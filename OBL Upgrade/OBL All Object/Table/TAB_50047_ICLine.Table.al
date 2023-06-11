table 50047 "IC Line"
{

    fields
    {
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Inter Company';
            OptionMembers = "Inter Company";
        }
        field(20; "Document No."; Code[20])
        {
        }
        field(30; "Line No."; Integer)
        {
        }
        field(40; "Item No."; Code[20])
        {
            TableRelation = Item;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Transfer Type" = 1 THEN BEGIN
                    ICLine.RESET;
                    ICLine.SETRANGE("Document No.", "Document No.");
                    ICLine.SETRANGE("Item No.", "Item No.");
                    IF ICLine.FINDFIRST THEN
                        ERROR(Text50001, "Item No.");

                    IF Item.GET("Item No.") THEN BEGIN
                        Description := Item.Description;
                        "Description 2" := Item."Description 2";
                        UOM := Item."Base Unit of Measure";
                        "Item Category Code" := Item."Item Category Code";
                    END;
                    Quantity := 0;
                    UpdateValuesFromHeader;

                    //MSBS.Rao Begin Dt. 05-09-12
                    IF RecICHeader.GET("Transfer Type", "Document No.") THEN
                        "IC Gen. Bus. Posting Group" := RecICHeader."IC Gen. Bus. Posting Group"
                    ELSE
                        "IC Gen. Bus. Posting Group" := '';
                    GetToItemCode;
                END;

                //MSBS.Rao End Dt. 05-09-12

                //MSKS
                IF "Transfer Type" = 0 THEN BEGIN
                    ValidateToItemCode();
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", UPPERCASE(USERID));
                    IF UserSetup.FINDFIRST THEN BEGIN
                        IF NOT UserSetup."IC Posting" THEN
                            ERROR('You Donot Have Permission to Modify The Item Code.');
                    END ELSE BEGIN
                        ERROR('You Donot Have Permission to Modify The Item Code.');
                    END;
                END;
            end;
        }
        field(50; Description; Text[50])
        {
        }
        field(51; "Description 2"; Text[50])
        {
        }
        field(60; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                CheckQuantity;
                //ValidateToItemCode;
            end;
        }
        field(70; "From Company"; Text[30])
        {
        }
        field(80; "To Company"; Text[30])
        {
        }
        field(90; "From Location"; Code[10])
        {
        }
        field(100; "To Location"; Code[10])
        {
        }
        field(110; "Posting Date"; Date)
        {
        }
        field(120; "Shortcut Dimension 1 Code"; Code[10])
        {
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(130; "Shortcut Dimension 2 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(140; "Transfer Type"; Option)
        {
            OptionCaption = 'Transfer In, Transfer Out';
            OptionMembers = "Transfer In"," Transfer Out";
        }
        field(150; UOM; Code[10])
        {
            TableRelation = "Item Unit of Measure"."Item No." WHERE("Item No." = FIELD("Item No."));
        }
        field(160; "DT UOM"; Code[10])
        {
        }
        field(170; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                Quantity := 0;
            end;
        }
        field(50001; "IC Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'IC Gen. Bus. Posting Group';
            Description = 'MSBS.Rao';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50002; "To Item No."; Code[20])
        {
            TableRelation = Item."No." WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidateToItemCode;
            end;
        }
        field(50003; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
    }

    keys
    {
        key(Key1; "Transfer Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Text50000: Label 'Available Quantity is %1 %2. Please Check. ';
        Text50001: Label 'Item %1 already exists';
        ICLine: Record "IC Line";
        RecICHeader: Record "IC Header";
        ToItemMaster: Record Item;
        UserSetup: Record "User Setup";
        Text50002: Label 'To Item No. Must be Equal to Item No. For Item No. %1.';

    procedure UpdateValuesFromHeader()
    var
        ICHeader: Record "IC Header";
    begin
        IF ICHeader.GET("Transfer Type", "Document No.") THEN BEGIN
            "From Company" := ICHeader."From Company";
            "To Company" := ICHeader."To Company";
            "From Location" := ICHeader."From Location";
            "To Location" := ICHeader."To Location";
            "Posting Date" := ICHeader."Posting Date";
            "Shortcut Dimension 1 Code" := ICHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ICHeader."Shortcut Dimension 2 Code";
        END;

        IF Item.GET("Item No.") THEN BEGIN
            Description := Item.Description;
            "Description 2" := Item."Description 2";
            UOM := Item."Base Unit of Measure";
            "Item Category Code" := Item."Item Category Code";
        END;
    end;

    procedure CheckQuantity()
    begin
        Item.RESET;
        Item.SETRANGE("No.", "Item No.");
        Item.SETRANGE("Variant Filter", "Variant Code");
        Item.SETRANGE("Location Filter", "From Location");
        IF Item.FINDFIRST THEN BEGIN
            // MESSAGE('%1..%2',"Item No.","From Location");
            //Item.CALCFIELDS("Inventory In CRT"); //MSBS.Rao Dt.22/06/12 Commeted thrugh. Kulbhushan
            //IF Quantity > Item."Inventory In CRT" THEN BEGIN  //MSBS.Rao Dt.22/06/12 Commeted thrugh. Kulbhushan
            Item.CALCFIELDS(Inventory);
            IF Quantity > Item.Inventory THEN BEGIN
                ERROR(Text50000, Item.Inventory, Item."Default Transaction UOM");
                //ERROR(Text50000,Item."Inventory In CRT",Item."Default Transaction UOM" ); //MSBS.Rao Dt.22/06/12 Commeted thrugh. Kulbhushan
            END;
        END;
    end;

    procedure GetToItemCode()
    begin
        IF "Item Category Code" IN ['H001', 'M001', 'T001', 'D001'] THEN BEGIN
            "To Item No." := "Item No.";
        END ELSE BEGIN
            ToItemMaster.RESET;
            ToItemMaster.CHANGECOMPANY("To Company");
            IF ToItemMaster.GET("Item No.") THEN
                "To Item No." := "Item No."
            ELSE
                "To Item No." := '';
        END;
    end;

    procedure ValidateToItemCode()
    begin
        TESTFIELD("To Item No.");
        IF "Item Category Code" IN ['H001', 'M001', 'T001', 'D001'] THEN BEGIN
            IF "To Item No." <> "Item No." THEN
                ERROR(Text50002, "Item No.");
        END;
    end;
}

