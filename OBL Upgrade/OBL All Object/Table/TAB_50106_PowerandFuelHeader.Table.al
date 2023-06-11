table 50106 "Power and Fuel Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    MfgSetup.GET;
                    NoSeriesMgt.TestManual(MfgSetup."Power & Fuel No. Cons. Series");
                    "No. Series" := '';
                END;
            end;
        }
        field(10; "Date of Reporting"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateProdDates;
                CheckLinesExists;
            end;
        }
        field(15; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item WHERE("Inventory Posting Group" = FILTER('POWER' | 'FUEL' | 'GAS'));

            trigger OnValidate()
            begin
                "Item Description" := UpdateItemDesc("Item No.");
                CheckLinesExists;
                "Inventory At Location" := CalculateInventory("Item No.", Location, "Prod. End Date");
            end;
        }
        field(16; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Consumed Qty."; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckLinesExists;
                "Inventory At Location" := CalculateInventory("Item No.", Location, "Prod. End Date");
                IF "Inventory At Location" < "Consumed Qty." THEN
                    ERROR('Insufficient Inventory');
            end;
        }
        field(19; "Inventory At Location"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(20; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE("Prod. Units" = FIELD("Prod. Units"));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                CheckLinesExists
            end;
        }
        field(30; "Prod. Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Prod. End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                CheckLinesExists
            end;
        }
        field(45; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                CheckLinesExists
            end;
        }
        field(50; "Prod. Units"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                CheckLinesExists
            end;
        }
        field(80; "Creation Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Created By"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(90; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(100; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(500; "Size Filter"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SIZE'));
        }
        field(510; "Tableau Group Code Filter"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('TYPEGROUP'));
        }
        field(511; "Size Code Desc"; Text[30])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FILTER('SIZE'),
                                                               "Code" = FIELD("Size Filter")));
            FieldClass = FlowField;
        }
        field(512; "Total Production"; Decimal)
        {
            CalcFormula = Sum("Power & Fuel Cons. Lines"."Total Sq. Meter Produced" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DeleteRelatedLines;
    end;

    trigger OnInsert()
    begin
        MfgSetup.GET;
        IF "No." = '' THEN BEGIN
            //MfgSetup.TESTFIELD("Forcast No. Series");
            MfgSetup.TESTFIELD("Power & Fuel No. Cons. Series");
            NoSeriesMgt.InitSeries(MfgSetup."Power & Fuel No. Cons. Series", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        "Created By" := USERID;
        "Creation Date & Time" := CURRENTDATETIME;
    end;

    var
        MfgSetup: Record "Manufacturing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(OldPowerandFuelHeader: Record "Power and Fuel Header"): Boolean
    var
        SalesHeader2: Record "Sales Header";
    begin
        MfgSetup.GET;
        MfgSetup.TESTFIELD("Power & Fuel No. Cons. Series");
        IF NoSeriesMgt.SelectSeries(MfgSetup."Power & Fuel No. Cons. Series", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestStatusOpen()
    begin
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        DimMgt: Codeunit DimensionManagement;
    begin
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID, No, '',
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    local procedure UpdateProdDates()
    begin
        "Prod. Start Date" := "Date of Reporting";
        "Prod. End Date" := "Date of Reporting";
        //"Date Filter" := '..'+FORMAT("Date of Reporting");
    end;

    procedure GenerateOutputLines()
    var
        PowerFuelConsLines: Record "Power & Fuel Cons. Lines";
        ProductionItemLedgerEntries: Query "Production Item Ledger Entries";
        LineNo: Integer;
        TotQtyProd: Decimal;
    begin
        TESTFIELD("Consumed Qty.");
        TESTFIELD("Prod. Start Date");
        TESTFIELD("Prod. End Date");
        TESTFIELD("Prod. Units");
        PowerFuelConsLines.RESET;
        PowerFuelConsLines.SETFILTER("Document No.", '%1', "No.");
        IF PowerFuelConsLines.FINDFIRST THEN
            ERROR('Lines Already Exist First Delete the Lines and Regenerate it');

        CLEAR(ProductionItemLedgerEntries);
        ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Prod_Units, '%1', "Prod. Units");
        ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Posting_Date, '%1..%2', "Prod. Start Date", "Prod. End Date");
        ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Location_Code, '%1', Location);
        IF "Size Filter" <> '' THEN
            ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Size_Code, '%1', "Size Filter");
        IF "Tableau Group Code Filter" <> '' THEN
            ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Production_Group, '%1', "Tableau Group Code Filter");
        ProductionItemLedgerEntries.OPEN;
        WHILE ProductionItemLedgerEntries.READ DO BEGIN
            TotQtyProd += ProductionItemLedgerEntries.Sum_Qty_in_Sq_Mt;
        END;

        IF TotQtyProd = 0 THEN
            ERROR('There is no Production for the Given Dates /Prod. Units Please Re-check');

        CLEAR(ProductionItemLedgerEntries);
        ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Prod_Units, '%1', "Prod. Units");
        ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Posting_Date, '%1..%2', "Prod. Start Date", "Prod. End Date");
        ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Location_Code, '%1', Location);
        IF "Size Filter" <> '' THEN
            ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Size_Code, '%1', "Size Filter");
        IF "Tableau Group Code Filter" <> '' THEN
            ProductionItemLedgerEntries.SETFILTER(ProductionItemLedgerEntries.Production_Group, '%1', "Tableau Group Code Filter");

        ProductionItemLedgerEntries.OPEN;
        WHILE ProductionItemLedgerEntries.READ DO BEGIN
            LineNo += 1000;
            PowerFuelConsLines.INIT;
            PowerFuelConsLines."Document No." := "No.";
            PowerFuelConsLines."Line No." := LineNo;
            PowerFuelConsLines."Consumed Item No." := "Item No.";
            PowerFuelConsLines."FG Item No." := ProductionItemLedgerEntries.Item_No;
            PowerFuelConsLines."FG Item Description" := UpdateItemDesc(ProductionItemLedgerEntries.Item_No);
            PowerFuelConsLines."Total Sq. Meter Produced" := ProductionItemLedgerEntries.Sum_Qty_in_Sq_Mt;
            PowerFuelConsLines.Location := ProductionItemLedgerEntries.Location_Code;
            PowerFuelConsLines."Prod. Units" := ProductionItemLedgerEntries.Prod_Units;
            PowerFuelConsLines."Consumption Qty." := ROUND((ProductionItemLedgerEntries.Sum_Qty_in_Sq_Mt / TotQtyProd) * "Consumed Qty.", 0.01, '=');
            PowerFuelConsLines."Shortcut Dimension 1 Code" := ProductionItemLedgerEntries.Global_Dimension_1_Code;
            PowerFuelConsLines."Shortcut Dimension 2 Code" := ProductionItemLedgerEntries.Global_Dimension_2_Code;
            PowerFuelConsLines."Dimension Set ID" := ProductionItemLedgerEntries.Dimension_Set_ID;
            PowerFuelConsLines."Prod. Order No." := ProductionItemLedgerEntries.Order_No;
            PowerFuelConsLines."Prod. Order Line No." := ProductionItemLedgerEntries.Order_Line_No;
            PowerFuelConsLines.INSERT;
        END;
    end;

    local procedure UpdateItemDesc(ItemNo: Code[20]): Text
    var
        Item: Record Item;
    begin
        Item.GET(ItemNo);
        EXIT(Item.Description);
    end;

    local procedure CheckLinesExists()
    var
        PowerFuelConsLines: Record "Power & Fuel Cons. Lines";
    begin
        PowerFuelConsLines.RESET;
        PowerFuelConsLines.SETFILTER("Document No.", '%1', "No.");
        IF PowerFuelConsLines.FINDFIRST THEN
            ERROR('Lines Already Exist First Delete the Lines and Regenerate it');
    end;

    local procedure DeleteRelatedLines()
    var
        PowerFuelConsLines: Record "Power & Fuel Cons. Lines";
    begin
        PowerFuelConsLines.RESET;
        PowerFuelConsLines.SETFILTER("Document No.", '%1', "No.");
        IF PowerFuelConsLines.FINDFIRST THEN
            PowerFuelConsLines.DELETEALL;
    end;

    procedure Post(No: Code[20])
    var
        PowerFuelConsLines: Record "Power & Fuel Cons. Lines";
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        COPYItemJournalLine: Record "Item Journal Line";
        PowerandFuelHeaderArch: Record "Posted Power & Fuel Cons. Hdr.";
        PowerFuelConsLinesArc: Record "Posted Power & Fuel Cons.Lines";
    begin
        PowerFuelConsLines.SETRANGE("Document No.", "No.");
        IF PowerFuelConsLines.FINDFIRST THEN BEGIN
            ItemJournalLine.SETRANGE("Journal Batch Name", 'CONSUM');
            ItemJournalLine.SETRANGE("Journal Template Name", 'CONSUMP');
            IF ItemJournalLine.FINDFIRST THEN
                ItemJournalLine.DELETEALL;
        END;
        IF PowerFuelConsLines.FINDFIRST THEN BEGIN
            REPEAT
                ItemJournalLine."Journal Template Name" := 'CONSUMP';
                ItemJournalLine."Journal Batch Name" := 'CONSUM';
                ItemJournalLine."Order Type" := ItemJournalLine."Order Type"::Production;
                ItemJournalLine."Order No." := PowerFuelConsLines."Prod. Order No.";
                ItemJournalLine."Line No." := PowerFuelConsLines."Line No.";
                ItemJournalLine."Posting Date" := Rec."Date of Reporting";
                ItemJournalLine."Document No." := PowerFuelConsLines."Prod. Order No.";
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Consumption;
                //    ItemJournalLine."Prod. Order Comp. Line No." := PowerFuelConsLines."Prod. Order Line No.";
                ItemJournalLine."Location Code" := PowerFuelConsLines.Location;
                ItemJournalLine."External Document No." := PowerFuelConsLines."Document No.";
                ItemJournalLine.VALIDATE("Item No.", PowerFuelConsLines."Consumed Item No.");
                ItemJournalLine.VALIDATE(Quantity, PowerFuelConsLines."Consumption Qty.");
                ItemJournalLine."Source Type" := ItemJournalLine."Source Type"::Item;
                ItemJournalLine."Source No." := PowerFuelConsLines."FG Item No.";
                ItemJournalLine."Order Line No." := PowerFuelConsLines."Prod. Order Line No.";
                //ItemJournalLine.SetUpNewLine;
                ItemJournalLine.INSERT;
            UNTIL PowerFuelConsLines.NEXT = 0;

            ItemJournalLine.SETFILTER("Journal Template Name", '%1', 'CONSUMP');
            ItemJournalLine.SETFILTER("Journal Batch Name", '%1', 'CONSUM');
            IF ItemJournalLine.FINDFIRST THEN BEGIN
                REPEAT
                    ItemJnlPostLine.RUN(ItemJournalLine);
                UNTIL ItemJournalLine.NEXT = 0;
            END;



            PowerFuelConsLines.RESET;
            PowerFuelConsLines.SETFILTER("Document No.", '%1', "No.");
            IF PowerFuelConsLines.FINDFIRST THEN
                REPEAT
                    PowerFuelConsLinesArc.INIT;
                    PowerFuelConsLinesArc.TRANSFERFIELDS(PowerFuelConsLines);
                    PowerFuelConsLinesArc.INSERT;
                    PowerFuelConsLines.DELETE;
                UNTIL PowerFuelConsLines.NEXT = 0;

            PowerandFuelHeaderArch.INIT;
            PowerandFuelHeaderArch.TRANSFERFIELDS(Rec);
            PowerandFuelHeaderArch.INSERT;
            DELETE;
        END;
    end;

    procedure CalculateInventory(ItemNO: Code[20]; LocCode: Code[20]; AsonDate: Date) Inv: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        IF ItemNO = '' THEN
            EXIT(0);
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETFILTER("Item No.", '%1', ItemNO);
        ItemLedgerEntry.SETFILTER("Location Code", '%1', LocCode);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                Inv += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        EXIT(Inv);
    end;
}

