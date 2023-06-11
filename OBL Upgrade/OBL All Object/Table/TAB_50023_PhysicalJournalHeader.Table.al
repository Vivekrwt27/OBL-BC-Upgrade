table 50023 "Physical Journal Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "No. Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; Plant; Option)
        {
            Editable = false;
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;

            trigger OnValidate()
            begin
                TESTFIELD(Posted, FALSE);
                TESTFIELD("Physical Journal Key", '');
                DeleteLines;
            end;
        }
        field(4; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Posted, FALSE);
                TESTFIELD(Plant);
                GenerateKey;
                ValidatePhysicalJournal;
            end;
        }
        field(6; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(7; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8; "Voucher Type"; Option)
        {
            OptionCaption = ' ,Store Voucher,Production Voucher';
            OptionMembers = " ","Store Voucher","Production Voucher";
        }
        field(9; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Send to Approval,Release';
            OptionMembers = Open,"Send to Approval",Release;

            trigger OnValidate()
            begin
                TESTFIELD(Posted, FALSE);
                UpdateLines;
            end;
        }
        field(20; Posted; Boolean)
        {
        }
        field(25; "Physical Journal Key"; Text[30])
        {
        }
        field(30; "PICC Key"; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('PICC'),
                                                          "Blocked" = CONST(false),
                                                          Plant = FIELD(Plant));

            trigger OnValidate()
            var
                PhysicalJournalHeader: Record "Physical Journal Header";
            begin
                UpdateLines;
                IF "Voucher Type" <> "Voucher Type"::"Production Voucher" THEN
                    EXIT;
                PhysicalJournalHeader.RESET;
                PhysicalJournalHeader.SETRANGE("PICC Key", "PICC Key");
                IF PhysicalJournalHeader.FINDFIRST THEN BEGIN
                    Plant := PhysicalJournalHeader.Plant;
                    "Posting Date" := PhysicalJournalHeader."Posting Date";
                END;

                //MSVRN
                /*
                PhysicalJournalHeader.RESET;
                PhysicalJournalHeader.SETRANGE(Posted,TRUE);
                PhysicalJournalHeader.SETRANGE("Voucher Type", PhysicalJournalHeader."Voucher Type"::"Store Voucher");
                PhysicalJournalHeader.SETRANGE(Plant, Plant);
                IF NOT PhysicalJournalHeader.FINDFIRST THEN
                  ERROR('Not available for Plant %1', PhysicalJournalHeader.Plant);
                  */

            end;
        }
        field(40; "Transfer Percentage"; Decimal)
        {
        }
        field(60; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group".Code WHERE("PICC Allowed" = CONST(true));
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
        TESTFIELD(Posted, FALSE);
        DeleteLines;
    end;

    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(UPPERCASE(USERID));
        UserSetup.TESTFIELD(Plant);
        Plant := UserSetup.Plant;
        CLEAR(recDimension);
        IF NOT recDimension.GET('PICC') THEN BEGIN
            recDimension.INIT;
            recDimension.VALIDATE(Code, 'PICC');
            recDimension.Name := 'Picc';
            recDimension.VALIDATE("Code Caption", 'Picc Code');
            recDimension.VALIDATE("Filter Caption", 'Picc Filter');
            recDimension.INSERT(TRUE);
        END;
        /*
        DimensionValue.RESET;
        DimensionValue.SETRANGE("Dimension Code", 'PICC');
        DimensionValue.SETRANGE(Blocked, FALSE);
        IF DimensionValue.FINDFIRST THEN BEGIN
          IF DimensionValue.COUNT > 1 THEN
            ERROR(Text0001);
        END;
        */

        IF ("No." = '') THEN BEGIN
            InvSetup.GET;
            InvSetup.TESTFIELD("Physical Journal No. Series");
            NoSeriesMgt.InitSeries(InvSetup."Physical Journal No. Series", xRec."No.", 0D, "No.", "No. Series");

        END;
        /*
        IF ("No." <> xRec."No.") AND ("No."='') THEN BEGIN
          InvSetup.GET;
          NoSeriesMgt.TestManual(InvSetup."Physical Journal No. Series");
          "No. Series" := '';
        END;
        */
        "User ID" := USERID;
        "Creation Date" := TODAY;
        //"Posting Date":=TODAY;
        "Transfer Percentage" := 90;
        //GenerateKey;
        //ValidatePhysicalJournal;

    end;

    trigger OnModify()
    begin
        GenerateKey;
        //ValidatePhysicalJournal;
        //TESTFIELD(Status,Status::Open);
    end;

    var
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LocationFilter: Text;
        ProdOrderComponent: Record "Prod. Order Component";
        NextConsumpJnlLineNo: Integer;
        LastItemJnlLine: Record "Item Journal Line";
        NextTrfJnlLineNo: Integer;
        ToTemplateName: Code[20];
        ToBatchName: Code[20];
        DimensionValue: Record "Dimension Value";
        recDimension: Record Dimension;
        Text0001: Label 'PICC should not be Opened more than 1!';
        PhysicalJournalLine: Record "Physical Journal Line";
        TrfTemplateName: Code[20];
        TrfBatchName: Code[20];
        LineNo: Integer;


    procedure GetInventory(FromDate: Date; ToDate: Date; OptPlant: Option " ",SKD,DRA,HSK): Decimal
    var
        CalculateInventory: Query "Calculate Inventory";
        PhysicalJournalLine: Record "Physical Journal Line";
        Lineno: Integer;
        Item: Record Item;
        ItemCategory: Record "Inventory Posting Group";
        CalculateSummaryInventory: Query "Calc. Summary Inventory PICC";
    begin
        //IF NOT CONFIRM('Do you want to do Physical Journal ?',FALSE) THEN
        //  EXIT;
        ValidatePhysicalJournal;
        IF "Voucher Type" = "Voucher Type"::"Store Voucher" THEN
            GenerateDimension(Rec);
        Lineno := 10000;
        LocationFilter := GetLocation("Voucher Type", OptPlant);
        ItemCategory.RESET;
        ItemCategory.SETFILTER("PICC Allowed", '%1', TRUE);
        IF "Voucher Type" = "Voucher Type"::"Store Voucher" THEN
            ItemCategory.SETRANGE(Code, "Inventory Posting Group");
        IF ItemCategory.FINDFIRST THEN
            REPEAT
                CLEAR(CalculateInventory);
                CalculateInventory.SETFILTER(CalculateInventory.Inventory_Posting_Group, ItemCategory.Code);
                CalculateInventory.SETFILTER(CalculateInventory.Posting_Date, '%1..%2', FromDate, ToDate);
                CalculateInventory.SETFILTER(CalculateInventory.Location_Code, LocationFilter);
                CalculateInventory.SETFILTER(CalculateInventory.Sum_Quantity, '<>%1', 0);
                CalculateInventory.OPEN;
                WHILE CalculateInventory.READ DO BEGIN
                    PhysicalJournalLine.RESET;
                    PhysicalJournalLine.SETRANGE(PhysicalJournalLine."Document No.", "No.");
                    PhysicalJournalLine.SETRANGE(PhysicalJournalLine."Item No.", CalculateInventory.No);
                    PhysicalJournalLine.SETRANGE(PhysicalJournalLine."Location Code", CalculateInventory.Location_Code);
                    IF NOT PhysicalJournalLine.FINDFIRST THEN BEGIN
                        Item.GET(CalculateInventory.No);
                        PhysicalJournalLine.INIT;
                        PhysicalJournalLine."Document No." := "No.";
                        PhysicalJournalLine."Line No." := Lineno;
                        PhysicalJournalLine.VALIDATE("Item No.", CalculateInventory.No);
                        PhysicalJournalLine.Description := Item.Description + ' ' + Item."Description 2";
                        PhysicalJournalLine.UOM := Item."Base Unit of Measure";
                        PhysicalJournalLine."Location Code" := CalculateInventory.Location_Code;
                        PhysicalJournalLine."System Inventory" := ROUND(CalculateInventory.Sum_Quantity, 0.01, '<');
                        IF "Voucher Type" = "Voucher Type"::"Store Voucher" THEN
                            PhysicalJournalLine.VALIDATE("Physical Inventory", ROUND(CalculateInventory.Sum_Quantity, 0.01, '<'));
                        PhysicalJournalLine."Item Category Code" := Item."Item Category Code";
                        PhysicalJournalLine."Inventory Posting Group" := Item."Inventory Posting Group";
                        PhysicalJournalLine."Voucher Type" := "Voucher Type";
                        PhysicalJournalLine."PICC Key" := "PICC Key";
                        IF PhysicalJournalLine."Voucher Type" = PhysicalJournalLine."Voucher Type"::"Production Voucher" THEN
                            PhysicalJournalLine.VALIDATE("Transfer Inventory", CalculateStoreInventory("PICC Key", CalculateInventory.No, PhysicalJournalLine."Location Code"));
                        //IF PhysicalJournalLine."System Inventory"<>0 THEN BEGIN
                        PhysicalJournalLine.INSERT;
                        //      SummarisedInventory(PhysicalJournalLine."Document No.",CalculateInventory.Location_Code,Item."No.",CalculateInventory.Sum_Quantity);
                        PhysicalJournalLine.WhereUsedExplode(PhysicalJournalLine);
                        Lineno += 10000;
                        //END;
                    END ELSE BEGIN
                        PhysicalJournalLine."System Inventory" += CalculateInventory.Sum_Quantity;
                        PhysicalJournalLine.MODIFY;
                    END;
                END;
                CLEAR(CalculateSummaryInventory);
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Inventory_Posting_Group, ItemCategory.Code);
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Posting_Date, '%1..%2', FromDate, ToDate);
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Sum_Quantity, '<>%1', 0);
                CalculateSummaryInventory.OPEN;
                WHILE CalculateSummaryInventory.READ DO BEGIN
                    SummarisedInventory(PhysicalJournalLine."Document No.", CalculateSummaryInventory.Location_Code, CalculateSummaryInventory.No, CalculateSummaryInventory.Sum_Quantity);
                END;
            UNTIL ItemCategory.NEXT = 0;
    end;

    procedure GetLocation(VoucherType: Option " ",Store,Production; OptPlant: Option " ",SKD,DRA,HSK): Text
    var
        Location: Record Location;
    begin
        CASE OptPlant OF
            0:
                EXIT;
            1:
                BEGIN
                    IF VoucherType = 1 THEN
                        EXIT('SKD-STORE');

                    IF VoucherType = 2 THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE("Prod. Units", Location."Prod. Units"::SKD);
                        Location.SETFILTER(Code, '<>%1', 'SKD-STORE');
                        IF Location.FINDFIRST THEN
                            REPEAT
                                IF (STRLEN(LocationFilter) + STRLEN(Location.Code)) < MAXSTRLEN(LocationFilter) THEN
                                    LocationFilter := LocationFilter + '|' + Location.Code;
                            UNTIL Location.NEXT = 0;
                        LocationFilter := COPYSTR(LocationFilter, 2, 1024);
                        EXIT(LocationFilter);
                    END;
                END;
            2:
                BEGIN
                    IF VoucherType = 1 THEN
                        EXIT('DRA-STORE');
                    IF VoucherType = 2 THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE("Prod. Units", Location."Prod. Units"::DORA);
                        Location.SETFILTER(Code, '<>%1', 'DRA-STORE');

                        IF Location.FINDFIRST THEN
                            REPEAT
                                IF (STRLEN(LocationFilter) + STRLEN(Location.Code)) < MAXSTRLEN(LocationFilter) THEN
                                    LocationFilter := LocationFilter + '|' + Location.Code;
                            UNTIL Location.NEXT = 0;
                        LocationFilter := COPYSTR(LocationFilter, 2, 1024);
                        EXIT(LocationFilter);
                    END;
                END;
            3:
                BEGIN
                    IF VoucherType = 1 THEN
                        EXIT('HSK-STORE');
                    IF VoucherType = 2 THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE("Prod. Units", Location."Prod. Units"::Hoskotte);
                        Location.SETFILTER(Code, '<>%1', 'HSK-STORE');

                        IF Location.FINDFIRST THEN
                            REPEAT
                                IF (STRLEN(LocationFilter) + STRLEN(Location.Code)) < MAXSTRLEN(LocationFilter) THEN
                                    LocationFilter := LocationFilter + '|' + Location.Code;
                            UNTIL Location.NEXT = 0;
                        LocationFilter := COPYSTR(LocationFilter, 2, 1024);
                        EXIT(LocationFilter);
                    END;
                END;
        END;
    end;

    procedure DeleteLines()
    var
        PhysicalJournalLine: Record "Physical Journal Line";
    begin
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Document No.", "No.");
        IF PhysicalJournalLine.FINDFIRST THEN
            PhysicalJournalLine.DELETEALL;
    end;

    local procedure GenerateKey()
    begin
        IF (Plant > 0) AND ("Posting Date" <> 0D) THEN
            "Physical Journal Key" := FORMAT("Voucher Type") + '-' + FORMAT(Plant) + '-' + FORMAT(DATE2DMY("Posting Date", 2)) + '-' + FORMAT(DATE2DMY("Posting Date", 3));
    end;

    local procedure UpdateLines()
    var
        PhysicalJournalLine: Record "Physical Journal Line";
    begin
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Voucher Type", "Voucher Type");
        PhysicalJournalLine.SETRANGE("Document No.", "No.");
        IF PhysicalJournalLine.FINDFIRST THEN BEGIN
            PhysicalJournalLine.MODIFYALL("PICC Key", "PICC Key");
            PhysicalJournalLine.MODIFYALL("Voucher Type", "Voucher Type");
        END;
    end;

    local procedure ValidatePhysicalJournal()
    var
        PhysicalJournalHeader: Record "Physical Journal Header";
    begin
        IF "Physical Journal Key" = '' THEN
            EXIT;
        PhysicalJournalHeader.RESET;
        PhysicalJournalHeader.SETRANGE("Physical Journal Key", "Physical Journal Key");
        PhysicalJournalHeader.SETFILTER("Voucher Type", '%1', "Voucher Type");
        PhysicalJournalHeader.SETFILTER("No.", '<>%1', "No.");
        IF "Voucher Type" = "Voucher Type"::"Store Voucher" THEN
            PhysicalJournalHeader.SETRANGE("Inventory Posting Group", "Inventory Posting Group");
        IF PhysicalJournalHeader.FINDFIRST THEN
            ERROR('Already Open Physical Journal Exist for the Sames Period');
        /*
        IF "Voucher Type"= "Voucher Type"::"Production Voucher" THEN BEGIN
          PhysicalJournalHeader.RESET;
          PhysicalJournalHeader.SETRANGE("PICC Key","PICC Key");
          PhysicalJournalHeader.SETFILTER("Voucher Type",'%1',PhysicalJournalHeader."Voucher Type"::"Store Voucher");
          PhysicalJournalHeader.SETFILTER("No.",'<>%1',"No.");
          IF NOT PhysicalJournalHeader.FINDFIRST THEN
            ERROR('First Do Store Physical Journal for the Period - %1',"Physical Journal Key");
        END;
        */

    end;

    local procedure CheckManuallyConfirmed(PhysicalJournalHeader: Record "Physical Journal Header")
    var
        PhysicalJournalLine: Record "Physical Journal Line";
    begin
        IF PhysicalJournalHeader."Voucher Type" <> PhysicalJournalHeader."Voucher Type"::"Store Voucher" THEN BEGIN
            PhysicalJournalLine.RESET;
            PhysicalJournalLine.SETRANGE("Document No.", PhysicalJournalHeader."No.");
            PhysicalJournalLine.SETRANGE("Manually Confirmed", FALSE);
            IF PhysicalJournalLine.FINDFIRST THEN
                ERROR('Please confirm Line No. %1 First', PhysicalJournalLine."Line No.");
        END;
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Document No.", PhysicalJournalHeader."No.");
        PhysicalJournalLine.SETFILTER("Short/Excess", '<%1', 0);
        IF PhysicalJournalLine.FINDFIRST THEN
            ERROR('Shortage/Excess cannot be negative on Line No. %1 ', PhysicalJournalLine."Line No.");
    end;

    local procedure GenerateDimension(var PhysicalJournalHeader: Record "Physical Journal Header")
    var
        DimensionValue: Record "Dimension Value";
        Month: Text;
        "Key": Text;
    begin
        PhysicalJournalHeader.TESTFIELD("Posting Date");
        PhysicalJournalHeader.TESTFIELD(Plant);
        Key := FORMAT(PhysicalJournalHeader.Plant) + FORMAT(DATE2DMY(PhysicalJournalHeader."Posting Date", 2)) + '-' + FORMAT(DATE2DMY(PhysicalJournalHeader."Posting Date", 3));
        DimensionValue.RESET;
        DimensionValue.SETRANGE("Dimension Code", 'PICC');
        DimensionValue.SETRANGE(Code, Key);
        IF NOT DimensionValue.FINDFIRST THEN BEGIN
            DimensionValue."Dimension Code" := 'PICC';
            DimensionValue.Code := Key;
            DimensionValue.Name := 'Physical Journal Period [' + Key + ']';
            DimensionValue.Plant := PhysicalJournalHeader.Plant;
            DimensionValue.INSERT;
        END;
        PhysicalJournalHeader."PICC Key" := Key;
    end;


    procedure PostStoreVoucher(var PhysicalJournalHeader: Record "Physical Journal Header")
    var
        PhysicalJournalLine: Record "Physical Journal Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        PhysicalJournInventoryLines: Record "Physical Journ Inventory Lines";
    begin
        PhysicalJournalHeader.TESTFIELD(Status, Status::Release);
        PhysicalJournalHeader.TESTFIELD(Posted, FALSE);
        IF CONFIRM('Do you want to Post the Store Voucher', FALSE) THEN BEGIN
            LocationFilter := GetLocation(PhysicalJournalHeader."Voucher Type"::"Store Voucher", PhysicalJournalHeader.Plant);
            TrfTemplateName := 'RECLASS';
            TrfBatchName := 'DEFAULT';
            NextTrfJnlLineNo := 10000;
            ItemJournalLine.RESET;
            ItemJournalLine.SETRANGE("Journal Template Name", TrfTemplateName);
            ItemJournalLine.SETRANGE("Journal Batch Name", TrfBatchName);
            IF ItemJournalLine.FINDFIRST THEN
                ItemJournalLine.DELETEALL;


            PhysicalJournalLine.RESET;
            PhysicalJournalLine.SETRANGE("Document No.", PhysicalJournalHeader."No.");
            PhysicalJournalLine.SETFILTER("Transfer Inventory", '>%1', 0);
            IF PhysicalJournalLine.FINDFIRST THEN BEGIN
                REPEAT
                    PhysicalJournInventoryLines.RESET;
                    PhysicalJournInventoryLines.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
                    PhysicalJournInventoryLines.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
                    PhysicalJournInventoryLines.SETFILTER("Physical Inventory", '>%1', 0);
                    IF PhysicalJournInventoryLines.FINDFIRST THEN BEGIN
                        REPEAT
                            PostTransferVoucher(PhysicalJournInventoryLines, LocationFilter, PhysicalJournInventoryLines."Location Code");
                        UNTIL PhysicalJournInventoryLines.NEXT = 0;
                    END;
                UNTIL PhysicalJournalLine.NEXT = 0;
            END;
            PhysicalJournalHeader.Posted := TRUE;
            PhysicalJournalHeader.MODIFY;
        END;

        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TrfTemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", TrfBatchName);
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                CLEAR(ItemJnlPostLine);
                IF ItemJournalLine.Quantity <> 0 THEN
                    ItemJnlPostLine.RUN(ItemJournalLine);
            UNTIL ItemJournalLine.NEXT = 0;
    end;

    procedure PostProductionVoucher(var PhysicalJournalHeader: Record "Physical Journal Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        PhysicalJournalHeader.TESTFIELD(Status, Status::Release);
        PhysicalJournalHeader.TESTFIELD(Posted, FALSE);
        IF CONFIRM('Do you want to Post the Production Voucher', FALSE) THEN BEGIN
            CreateConsumptionVoucher(PhysicalJournalHeader);
            ItemJournalLine.RESET;
            ItemJournalLine.SETFILTER("Journal Template Name", '%1', TrfTemplateName);
            ItemJournalLine.SETFILTER("Journal Batch Name", '%1', TrfBatchName);
            IF ItemJournalLine.FINDFIRST THEN
                REPEAT
                    CLEAR(ItemJnlPostLine);
                    IF ItemJournalLine.Quantity <> 0 THEN
                        ItemJnlPostLine.RUN(ItemJournalLine);
                UNTIL ItemJournalLine.NEXT = 0;

            ItemJournalLine.RESET;
            ItemJournalLine.SETFILTER("Journal Template Name", '%1', ToTemplateName);
            ItemJournalLine.SETFILTER("Journal Batch Name", '%1', ToBatchName);
            IF ItemJournalLine.FINDFIRST THEN
                REPEAT
                    CLEAR(ItemJnlPostLine);
                    IF ItemJournalLine.Quantity <> 0 THEN
                        ItemJnlPostLine.RUN(ItemJournalLine);
                UNTIL ItemJournalLine.NEXT = 0;

            PhysicalJournalHeader.Posted := TRUE;
            PhysicalJournalHeader.MODIFY;
        END;
    end;

    procedure CalculateStoreInventory(PICCKey: Text; ItemNo: Code[20]; LocCode: Code[10]): Decimal
    var
        PhysicalJournalLine: Record "Physical Journal Line";
    begin
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("PICC Key", PICCKey);
        PhysicalJournalLine.SETRANGE("Item No.", ItemNo);
        PhysicalJournalLine.SETRANGE("Location Code", LocCode);
        IF PhysicalJournalLine.FINDFIRST THEN
            EXIT(PhysicalJournalLine."Transfer Inventory");
    end;


    procedure ChangeStatusRelease(var PhysicalJournalHeader: Record "Physical Journal Header")
    begin
        PhysicalJournalHeader.TESTFIELD(Status, PhysicalJournalHeader.Status::Open);
        IF CONFIRM('Do you want to release the Status', FALSE) THEN BEGIN

            CheckManuallyConfirmed(PhysicalJournalHeader);
            PhysicalJournalHeader.VALIDATE(Status, PhysicalJournalHeader.Status::Release);
            PhysicalJournalHeader.MODIFY;
        END;
    end;


    procedure ChangeStatusOpen(var PhysicalJournalHeader: Record "Physical Journal Header")
    begin
        PhysicalJournalHeader.TESTFIELD(Posted, FALSE);
        PhysicalJournalHeader.TESTFIELD(Status, PhysicalJournalHeader.Status::Release);
        IF CONFIRM('Do you want to Re-Open the Status', FALSE) THEN BEGIN
            PhysicalJournalHeader.VALIDATE(Status, PhysicalJournalHeader.Status::Open);
            PhysicalJournalHeader.MODIFY;
        END;
    end;


    procedure CreateConsumptionVoucher(PhysicalJournalHeader: Record "Physical Journal Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        PhysicalJournalLine: Record "Physical Journal Line";
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
    begin
        IF PhysicalJournalHeader."Voucher Type" <> PhysicalJournalHeader."Voucher Type"::"Production Voucher" THEN
            EXIT;

        ToTemplateName := 'CONSUMP';
        ToBatchName := 'CONSUM';
        NextConsumpJnlLineNo := 10000;

        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", ToTemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", ToBatchName);
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETEALL;
        //Transfer inventory
        TrfTemplateName := 'RECLASS';
        TrfBatchName := 'DEFAULT';
        NextTrfJnlLineNo := 10000;

        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TrfTemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", TrfBatchName);
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETEALL;


        LocationFilter := GetPICCLocation(PhysicalJournalHeader.Plant);
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Document No.", PhysicalJournalHeader."No.");
        PhysicalJournalLine.SETFILTER("Short/Excess", '>%1', 0);
        IF PhysicalJournalLine.FINDFIRST THEN BEGIN
            REPEAT
                PhysicalJournalOutputEntrie.RESET;
                PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
                PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
                PhysicalJournalOutputEntrie.SETFILTER("Transfer Allocated Qty.", '>%1', 0);
                IF PhysicalJournalOutputEntrie.FINDFIRST THEN BEGIN
                    REPEAT
                        TransferConsumpJnlLine(PhysicalJournalOutputEntrie, LocationFilter);
                    UNTIL PhysicalJournalOutputEntrie.NEXT = 0;
                END;
            UNTIL PhysicalJournalLine.NEXT = 0;
        END;
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Document No.", PhysicalJournalHeader."No.");
        PhysicalJournalLine.SETFILTER("Short/Excess", '>%1', 0);
        IF PhysicalJournalLine.FINDFIRST THEN BEGIN
            REPEAT
                PhysicalJournalOutputEntrie.RESET;
                PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
                PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
                PhysicalJournalOutputEntrie.SETFILTER("Allocate Quantity", '>%1', 0);
                IF PhysicalJournalOutputEntrie.FINDFIRST THEN BEGIN
                    REPEAT
                        AllocateQtyonProdOrder(PhysicalJournalOutputEntrie);
                    UNTIL PhysicalJournalOutputEntrie.NEXT = 0;
                END;
            UNTIL PhysicalJournalLine.NEXT = 0;
        END;
    end;


    procedure AllocateQtyonProdOrder(PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie") TotQty: Decimal
    begin
        ProdOrderComponent.RESET;
        ProdOrderComponent.SETFILTER(Status, '%1', ProdOrderComponent.Status::Released);
        ProdOrderComponent.SETRANGE("Item No.", PhysicalJournalOutputEntrie."RM Code");
        ProdOrderComponent.SETRANGE("Source No.", PhysicalJournalOutputEntrie."Source No.");
        ProdOrderComponent.SETRANGE("Location Code", PhysicalJournalOutputEntrie."Location Code");
        ProdOrderComponent.SETRANGE(Blocked, FALSE);
        IF ProdOrderComponent.FINDFIRST THEN BEGIN
            REPEAT
                TotQty += ProdOrderComponent."Expected Qty. (Base)";
            UNTIL ProdOrderComponent.NEXT = 0;
        END;

        IF TotQty <> 0 THEN BEGIN
            ProdOrderComponent.RESET;
            ProdOrderComponent.SETFILTER(Status, '%1', ProdOrderComponent.Status::Released);
            ProdOrderComponent.SETRANGE("Item No.", PhysicalJournalOutputEntrie."RM Code");
            ProdOrderComponent.SETRANGE("Source No.", PhysicalJournalOutputEntrie."Source No.");
            ProdOrderComponent.SETRANGE("Location Code", PhysicalJournalOutputEntrie."Location Code");
            ProdOrderComponent.SETRANGE(Blocked, FALSE);
            IF ProdOrderComponent.FINDFIRST THEN
                REPEAT
                    CreateConsumpJnlLine(ProdOrderComponent, ProdOrderComponent."Location Code", '', (PhysicalJournalOutputEntrie."Allocate Quantity") * (ProdOrderComponent."Expected Qty. (Base)" /
                                                                                TotQty));
                UNTIL ProdOrderComponent.NEXT = 0;
        END;
    end;

    local procedure CreateConsumpJnlLine(ProdOrderComponent: Record "Prod. Order Component"; LocationCode: Code[10]; BinCode: Code[20]; QtyToPost: Decimal)
    var
        Location: Record Location;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
    begin

        Item.GET(ProdOrderComponent."Item No.");
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := ToTemplateName;
        ItemJnlLine."Journal Batch Name" := ToBatchName;
        ItemJnlLine.SetUpNewLine(LastItemJnlLine);
        ItemJnlLine."Line No." := NextConsumpJnlLineNo;

        ItemJnlLine."Document No." := "No."; //TEAM 14763


        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Consumption);
        ItemJnlLine.VALIDATE("Order Type", ItemJnlLine."Order Type"::Production);
        ItemJnlLine.VALIDATE("Order No.", ProdOrderComponent."Prod. Order No.");
        ItemJnlLine.VALIDATE("Source No.", ProdOrderComponent."Source No.");
        ItemJnlLine.VALIDATE("Posting Date", "Posting Date");
        ItemJnlLine.VALIDATE("Item No.", ProdOrderComponent."Item No.");
        ItemJnlLine."Physical Journal Entry" := TRUE;
        ItemJnlLine."Physical Journal Key" := "PICC Key";
        ItemJnlLine.VALIDATE("Unit of Measure Code", ProdOrderComponent."Unit of Measure Code");
        ItemJnlLine.Description := ProdOrderComponent.Description;
        //IF Item."Rounding Precision" > 0 THEN
        //  ItemJnlLine.VALIDATE(Quantity,ROUND(QtyToPost,Item."Rounding Precision",'>'))
        //ELSE
        ItemJnlLine.VALIDATE(Quantity, ROUND(QtyToPost, 0.01, '<'));
        ItemJnlLine."Variant Code" := ProdOrderComponent."Variant Code";
        ItemJnlLine.VALIDATE("Location Code", LocationCode);
        IF BinCode <> '' THEN
            ItemJnlLine."Bin Code" := BinCode;
        ItemJnlLine.VALIDATE("Order Line No.", ProdOrderComponent."Prod. Order Line No.");
        ItemJnlLine.VALIDATE("Prod. Order Comp. Line No.", ProdOrderComponent."Line No.");

        IF ItemJnlLine.Quantity <> 0 THEN BEGIN
            ItemJnlLine.INSERT;
            IF Item."Item Tracking Code" <> '' THEN
                ItemTrackingMgt.CopyItemTracking(ProdOrderComponent.RowID1, ItemJnlLine.RowID1, FALSE);
            NextConsumpJnlLineNo := NextConsumpJnlLineNo + 10000;
        END;
    end;

    procedure BlockDimVal(Picc: Code[10]; PiccKey: Code[10])
    begin
        IF DimensionValue.GET(Picc, PiccKey) THEN BEGIN
            DimensionValue.Blocked := TRUE;
            DimensionValue.MODIFY;
        END;
    end;

    procedure CheckOpenDoc(PhysicalJournalHeader: Record "Physical Journal Header")
    var
        Text0001: Label 'Thre are total %1 documents are Open, it must not be more than 1!';
    begin

        PhysicalJournalHeader.RESET;
        //PhysicalJournalHeader.SETRANGE("No.", "No.");
        PhysicalJournalHeader.SETRANGE(Plant, Plant);
        //PhysicalJournalHeader.SETRANGE(Status, PhysicalJournalHeader.Status::Open);
        PhysicalJournalHeader.SETRANGE(Posted, FALSE);
        IF PhysicalJournalHeader.FINDFIRST THEN
            IF PhysicalJournalHeader.COUNT > 1 THEN
                MESSAGE('There are Pending Vocuher %1, Please Post the Pending Document First !', PhysicalJournalHeader."No.");
    end;

    local procedure TransferConsumpJnlLine(PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie"; LocationCode: Code[10])
    var
        Location: Record Location;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
    begin
        Item.GET(PhysicalJournalOutputEntrie."RM Code");
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := TrfTemplateName;
        ItemJnlLine."Journal Batch Name" := TrfBatchName;

        ItemJnlLine.SetUpNewLine(LastItemJnlLine);
        ItemJnlLine."Document No." := "No.";
        ItemJnlLine."Line No." := NextTrfJnlLineNo;

        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        ItemJnlLine.VALIDATE("Posting Date", "Posting Date");
        ItemJnlLine.VALIDATE("Item No.", PhysicalJournalOutputEntrie."RM Code");
        ItemJnlLine."Physical Journal Entry" := TRUE;
        ItemJnlLine."Physical Journal Key" := "PICC Key";
        ItemJnlLine.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
        ItemJnlLine.Description := Item.Description + ' ' + Item."Description 2";
        //IF Item."Rounding Precision" > 0 THEN
        //  ItemJnlLine.VALIDATE(Quantity,ROUND(PhysicalJournalOutputEntrie."Transfer Allocated Qty.",Item."Rounding Precision",'>'))
        //ELSE
        ItemJnlLine.VALIDATE(Quantity, ROUND(PhysicalJournalOutputEntrie."Transfer Allocated Qty.", 0.01, '>'));
        ItemJnlLine.VALIDATE("Location Code", LocationCode);
        ItemJnlLine.VALIDATE("New Location Code", PhysicalJournalOutputEntrie."Location Code");
        IF ItemJnlLine.Quantity <> 0 THEN BEGIN
            ItemJnlLine.INSERT;
            IF Item."Item Tracking Code" <> '' THEN
                ItemTrackingMgt.CopyItemTracking(ProdOrderComponent.RowID1, ItemJnlLine.RowID1, FALSE);
            NextTrfJnlLineNo := NextTrfJnlLineNo + 10000;
        END;
    end;

    local procedure SummarisedInventory(PhysicalJournalNo: Code[20]; LocationCode: Code[20]; ItemCode: Code[20]; Inventory: Decimal)
    var
        LocationWiseInventory: Record "Location Wise Inventory";
        Location: Record Location;
        PhysicalJournInventoryLines: Record "Physical Journ Inventory Lines";
    begin
        LocationWiseInventory.INIT;
        LocationWiseInventory.SETRANGE("Physical Journal Filter", PhysicalJournalNo);
        LocationWiseInventory.SETRANGE(Location, LocationCode);
        LocationWiseInventory.SETRANGE("No.", ItemCode);
        IF LocationWiseInventory.FINDFIRST THEN
            LocationWiseInventory.DELETE;

        /*
        PhysicalJournInventoryLines.RESET;
        PhysicalJournInventoryLines.SETRANGE("Document No.",PhysicalJournalNo);
        PhysicalJournInventoryLines.SETRANGE("Location Code",LocationCode);
        PhysicalJournInventoryLines.SETRANGE("Item No.",ItemCode);
        IF PhysicalJournInventoryLines.FINDFIRST THEN
          PhysicalJournInventoryLines.DELETE;
          */

        Location.GET(LocationCode);
        LocationWiseInventory.INIT;
        LocationWiseInventory."Physical Journal Filter" := PhysicalJournalNo;
        LocationWiseInventory.Location := LocationCode;
        LocationWiseInventory."No." := ItemCode;
        LocationWiseInventory."Inventory at Location" := Inventory;
        IF Location."Prod. Units" = Plant THEN
            LocationWiseInventory.INSERT(TRUE);
        /*
        PhysicalJournInventoryLines.INIT;
        PhysicalJournInventoryLines."Document No." := PhysicalJournalNo;
        PhysicalJournInventoryLines."Document Line No." := 10000;
        PhysicalJournInventoryLines."Item No." := ItemCode;
        PhysicalJournInventoryLines."Line No." := LineNo;
        PhysicalJournInventoryLines."System Inventory" := Inventory;
        PhysicalJournInventoryLines."Location Code" := LocationCode;
        LineNo +=100;
        IF Location."Prod. Units" = Plant THEN
        PhysicalJournInventoryLines.INSERT;
        */

    end;

    local procedure PostTransferVoucher(PhysicalJournalLine: Record "Physical Journ Inventory Lines"; FromLocationCode: Code[10]; ToLocationCode: Code[10])
    var
        Location: Record Location;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        Item.GET(PhysicalJournalLine."Item No.");
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := TrfTemplateName;
        ItemJnlLine."Journal Batch Name" := TrfBatchName;

        ItemJnlLine.SetUpNewLine(LastItemJnlLine);
        ItemJnlLine."Document No." := "No.";
        ItemJnlLine."Line No." := NextTrfJnlLineNo;

        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        ItemJnlLine.VALIDATE("Posting Date", "Posting Date");
        ItemJnlLine.VALIDATE("Item No.", PhysicalJournalLine."Item No.");
        ItemJnlLine."Physical Journal Entry" := TRUE;
        ItemJnlLine."Physical Journal Key" := "PICC Key";
        ItemJnlLine.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
        ItemJnlLine.Description := Item.Description + ' ' + Item."Description 2";
        ItemJnlLine.VALIDATE(Quantity, ROUND(PhysicalJournalLine."Physical Inventory", 0.01, '>'));

        ItemJnlLine.VALIDATE("Invoiced Quantity", ROUND(PhysicalJournalLine."Physical Inventory", 0.01, '>'));

        ItemJnlLine.VALIDATE("Location Code", FromLocationCode);
        ItemJnlLine.VALIDATE("New Location Code", ToLocationCode);
        IF ItemJnlLine.Quantity <> 0 THEN BEGIN
            //TEAM 14763
            ItemJnlLine.VALIDATE("Invoiced Quantity", ROUND(PhysicalJournalLine."Physical Inventory", 0.01, '>'));
            //TEAM 14763

            ItemJnlLine.INSERT;
            IF Item."Item Tracking Code" <> '' THEN
                ItemTrackingMgt.CopyItemTracking(ProdOrderComponent.RowID1, ItemJnlLine.RowID1, FALSE);
            NextTrfJnlLineNo := NextTrfJnlLineNo + 10000;
        END;
    end;

    local procedure GetPICCLocation(OptPlant: Option " ",SKD,DRA,HSK): Code[20]
    begin
        CASE OptPlant OF
            0:
                EXIT;
            1:
                EXIT('SKD-PLANT');
            2:
                EXIT('DRA-PLANT');
            3:
                EXIT('HSK-PLANT');
        END;
    end;
}

