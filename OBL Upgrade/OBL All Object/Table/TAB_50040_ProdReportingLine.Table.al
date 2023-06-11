table 50040 "Prod. Reporting Line"
{
    Caption = 'Production Line';

    fields
    {
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(7; "Finished Goods"; Code[20])
        {

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(9; "FG No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                TestStatusOpen;
                Item.RESET;
                IF Item.GET(Rec."FG No.") THEN BEGIN
                    VALIDATE(Description, Item.Description);
                    VALIDATE("Description 2", Item."Description 2");
                    "Mfg. Batch No." := 'M';
                END;

                ProductionHeader.RESET;
                IF ProductionHeader.GET("Document No.") THEN BEGIN
                    "Prod. Units" := ProductionHeader."Prod. Units";
                END;
            end;
        }
        field(10; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("FG No."));

            trigger OnValidate()
            begin
                TestStatusOpen;
                "Mfg. Batch No." := "Variant Code";
                IF "Variant Code" <> '' THEN BEGIN
                    ItemVariant.GET("FG No.", "Variant Code");
                    ItemVariant.TESTFIELD(Blocked, FALSE);
                END
            end;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(15; "Quantity Produced"; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestStatusOpen;
                CheckItemCard;

                GetProductionHeader;
                "Prod. Units" := ProductionHeader."Prod. Units";
            end;
        }
        field(18; "Prod. Units"; Option)
        {
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(20; Location; Code[20])
        {
            TableRelation = Location WHERE("Prod. Units" = FIELD("Prod. Units"));

            trigger OnValidate()
            begin
                TestStatusOpen;
                /*
                IF "FG No." <> '' THEN BEGIN
                    ile.SETCURRENTKEY("Item No.","Location Code");
                    ile.SETRANGE("Item No.","FG No.");
                    ile.SETRANGE("Location Code",Location);
                
                      IF ile.FIND('-') THEN
                          ile.CALCSUMS(ile.Quantity);
                            ttqty := ile.Quantity;
                           IF ttqty > 0 THEN
                            MESSAGE('You have %1 Quantity at your Location. Do You Want to Produce More.',ttqty);
                    END;
                
                 */

            end;
        }
        field(30; "Prod. Order No."; Code[20])
        {
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                TestStatusOpen;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(35; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                TestStatusOpen;
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(40; "Prod. Order Line No."; Integer)
        {
        }
        field(60; "Finished Quantity"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Finished Quantity" WHERE("Status" = CONST(Released),
                                                                            "Prod. Order No." = FIELD("Prod. Order No."),
                                                                            "Line No." = FIELD("Prod. Order Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Qty. in CRT."; Decimal)
        {

            trigger OnValidate()
            begin

                IF "FG No." <> '' THEN BEGIN
                    ile.SETCURRENTKEY("Item No.", "Location Code");
                    ile.SETRANGE("Item No.", "FG No.");
                    ile.SETRANGE("Location Code", Location);

                    IF ile.FIND('-') THEN
                        ile.CALCSUMS(ile.Quantity);
                    ttqty := ile.Quantity;
                    IF ttqty > 0 THEN
                        MESSAGE('You have %1 Quantity at your Location. Do You Want to Produce More.', ttqty);
                END;
            end;
        }
        field(100; "Broken Tiles"; Decimal)
        {

            trigger OnValidate()
            begin
                CheckItemCard;
                TestStatusOpen;
            end;
        }
        field(110; "Commercial Quantity"; Decimal)
        {

            trigger OnValidate()
            begin
                CheckItemCard;
                TestStatusOpen;
            end;
        }
        field(120; "Economic Quantity"; Decimal)
        {

            trigger OnValidate()
            begin
                CheckItemCard;
                TestStatusOpen;
            end;
        }
        field(130; "Consumption Remaining"; Boolean)
        {
            CalcFormula = Exist("Prod. Order Component" WHERE("Status" = CONST(Released),
                                                               "Prod. Order No." = FIELD("Prod. Order No."),
                                                               "Prod. Order Line No." = FIELD("Prod. Order Line No."),
                                                               "Remaining Quantity" = FILTER(<> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(150; Shift; Code[20])
        {
            TableRelation = "Work Shift";

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(500; "Morbi Batch No."; Code[20])
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("FG No."));
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Line No.", "Variant Code")//,Field2,Field5,Field6//16225 N/F
        {
        }
    }

    trigger OnDelete()
    var
        ServItem: Record "Service Item";
        SalesDocLineComments: Record "Sales Comment Line";
    begin
        TestStatusOpen;
    end;

    trigger OnInsert()
    begin

        IF COMPANYNAME = 'Orient Bell Limited' THEN
            IF "Line No." > 50000 THEN
                ERROR('Sorry!!!!! You can select only 5 Items'); //Kulbhushan

        TestStatusOpen;
        GetProductionHeader;
        ProductionHeader.TESTFIELD("Prod. Units");

        "Prod. Units" := ProductionHeader."Prod. Units";
    end;

    trigger OnModify()
    begin
        TestStatusOpen;
    end;

    trigger OnRename()
    begin
        TestStatusOpen;
    end;

    var
        Item: Record Item;
        ProductionHeader: Record "Prod. Reporting Header";
        DimMgt: Codeunit DimensionManagement;
        ile: Record "Item Ledger Entry";
        ttqty: Decimal;
        ItemVariant: Record "Item Variant";

    local procedure TestStatusOpen()
    begin
        GetProductionHeader;
        IF "FG No." <> '' THEN
            ProductionHeader.TESTFIELD(Status, ProductionHeader.Status::Open);
        TESTFIELD("Prod. Order No.", '');
    end;

    local procedure GetProductionHeader()
    begin
        ProductionHeader.GET("Document No.");
    end;

    local procedure CheckItemCard()
    var
        Item: Record Item;
    begin
        Item.GET("FG No.");

        IF "Broken Tiles" <> xRec."Broken Tiles" THEN
            Item.TESTFIELD("Broken Tiles");

        IF "Commercial Quantity" <> xRec."Commercial Quantity" THEN
            Item.TESTFIELD(Commercial);

        IF "Economic Quantity" <> xRec."Economic Quantity" THEN
            Item.TESTFIELD(Economic);

        //IF ("Broken Tiles"+"Commercial Quantity"+"Economic Quantity") < "Quantity Produced" THEN
        //ERROR('Broken+Economic+Commercial Quantity cannot be greater than Produced Quantity');
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
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
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

