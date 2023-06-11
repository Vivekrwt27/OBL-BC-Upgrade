table 50118 "Item Creation"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin

                IF "No." <> xRec."No." THEN BEGIN
                    InvtSetup.GET;
                    //  NoSeriesMgt.InitSeries(InvtSetup."Item No. Series",xRec."No.",0D,"No.","No. Series");
                    NoSeriesMgt.TestManual(InvtSetup."Item No. Series");
                    "No. Series" := '';
                END;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;

            trigger OnValidate()
            begin
                IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
                    "Search Description" := Description;

                IF STRLEN(Description) > 30 THEN
                    ERROR('Length of Description Should not be more than 30');
            end;
        }
        field(4; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
        }
        field(5; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Editable = false;

            trigger OnValidate()
            begin
                IF STRLEN("Description 2") > 30 THEN
                    ERROR('Length of Description Should not be more than 30');
            end;
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(11; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(13; Status; Option)
        {
            OptionCaption = ' ,Authorization1,Authorization2,Authorization3,Authorization4,CEO,Created,Rejected';
            OptionMembers = " ",Authorization1,Authorization2,Authorization3,Authorization4,CEO,Created,Rejected;
        }
        field(18; "Operation unit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,HSK,DRA,SKD,WZ';
            OptionMembers = "  ",HSK,DRA,SKD,WZ;
        }
        field(21; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;

            trigger OnValidate()
            begin
                IF "Costing Method" = xRec."Costing Method" THEN
                    EXIT;
            end;
        }
        field(23; "No. Series"; Code[10])
        {
        }
        field(41; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(42; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(91; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Editable = false;
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") THEN
                    VALIDATE("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(92; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(98; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(99; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(5425; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5426; "Purch. Unit of Measure"; Code[10])
        {
            Caption = 'Purch. Unit of Measure';
            TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5702; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";

            trigger OnValidate()
            var
                ItemCategory: Record "Item Category";
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            /// ProductGrp: Record "Product Group";
            begin
                //MSAK
                IF "Item Category Code" = 'T001' THEN BEGIN
                    VALIDATE("Gen. Prod. Posting Group", 'TRADING');
                    VALIDATE("Inventory Posting Group", 'TRAD');
                    VALIDATE("Group Code", '02');
                END ELSE BEGIN
                    VALIDATE("Gen. Prod. Posting Group", 'MANUF');
                    VALIDATE("Inventory Posting Group", 'MANUF');
                    VALIDATE("Group Code", '01');
                END;
                //MSAK

                IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
                    IF ItemCategory.GET("Item Category Code") THEN BEGIN
                        //16225 Field N/F Start
                        /*  IF "Gen. Prod. Posting Group" = '' THEN
                              VALIDATE("Gen. Prod. Posting Group", ItemCategory."Def. Gen. Prod. Posting Group");
                          IF (("Gen. Prod. Posting Group" = ItemCategory."Def. Gen. Prod. Posting Group") AND
                          ("VAT Prod. Posting Group" = GenProdPostingGrp."Def. VAT Prod. Posting Group"))
                      THEN
                              VALIDATE("VAT Prod. Posting Group", ItemCategory."Def. VAT Prod. Posting Group");
                          IF "Inventory Posting Group" = '' THEN
                              VALIDATE("Inventory Posting Group", ItemCategory."Def. Inventory Posting Group");
                          IF "Tax Group Code" = '' THEN
                              VALIDATE("Tax Group Code", ItemCategory."Def. Tax Group Code");
                          VALIDATE("Costing Method", ItemCategory."Def. Costing Method");*///16225 Field N/F End
                    END;
                    //16225
                    /* IF NOT ProductGrp.GET("Item Category Code", "Product Group Code") THEN
                         VALIDATE("Product Group Code", '')
                     ELSE
                         VALIDATE("Product Group Code");*/
                END;
            end;
        }
        field(5704; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(13712; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            //TableRelation = "Excise Prod. Posting Group";//16225 TABLE N/F

            trigger OnValidate()
            var
                ItemUOM: Record "Item Unit of Measure";
                //ExciseProdPostingGrp: Record "13710"; //16225 TABLE N/F
                ErrText01: Label 'Item Unit of Measure must be defined for %1 before Excise Product Posting Group %2 can be assigned.';
            begin
                IF "Excise Prod. Posting Group" <> '' THEN BEGIN
                    //16225 Table  N/F Start
                    /* ExciseProdPostingGrp.GET("Excise Prod. Posting Group");
                     IF ExciseProdPostingGrp."Unit of Measure Code" <> '' THEN BEGIN
                         IF NOT ItemUOM.GET("No.", ExciseProdPostingGrp."Unit of Measure Code") THEN
                             ERROR(ErrText01, ExciseProdPostingGrp."Unit of Measure Code", "Excise Prod. Posting Group")
                         ELSE
                             ItemUOM.TESTFIELD("Qty. per Unit of Measure");
                     END;*///16225 Table  N/F End
                END;
            end;
        }
        field(13714; "Excise Accounting Type"; Option)
        {
            Caption = 'Excise Accounting Type';
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(16602; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            TableRelation = "GST Group";

            trigger OnValidate()
            begin
                "HSN/SAC Code" := '';
            end;
        }
        field(16604; "HSN/SAC Code"; Code[8])
        {
            Caption = 'HSN/SAC Code';
            TableRelation = "HSN/SAC"."Code" WHERE("GST Group Code" = FIELD("GST Group Code"));
        }
        field(16607; "GST Credit"; Option)
        {
            Caption = 'GST Credit';
            OptionCaption = 'Availment,Non-Availment';
            OptionMembers = Availment,"Non-Availment";

            trigger OnValidate()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(16608; Exempted; Boolean)
        {
            Caption = 'Exempted';
        }
        field(50000; "Type Code"; Code[5])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                /*
                IF Dimension.GET(27,"No.",InventorySetup."Type Code") THEN BEGIN
                  IF "Type Code"='' THEN
                    Dimension.DELETE ELSE BEGIN
                    Dimension.VALIDATE(Dimension."Dimension Value Code","Type Code");
                    ModifyDimension;
                  END;
                END ELSE BEGIN
                  Dimension.INIT;
                  Dimension.VALIDATE(Dimension."Dimension Code",InventorySetup."Type Code");
                  Dimension.VALIDATE(Dimension."Dimension Value Code","Type Code");
                  InsertDimension;
                END;
                InventorySetup.GET;
                
                IF DimensionValue.GET(InventorySetup."Type Code","Type Code") THEN
                 VALIDATE("Type Code Desc.",DimensionValue.Name)
                ELSE
                  VALIDATE("Type Code Desc.",'');
                  */

            end;
        }
        field(50001; "Type Catogery Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Catogery Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Type Catogery Code") THEN BEGIN
                    IF "Type Catogery Code" = '' THEN
                        Dimension.DELETE
                    ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Type Catogery Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Type Catogery Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Type Catogery Code");
                    InsertDimension;
                END;
                /*
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Type Catogery Code","Type Catogery Code") THEN
                  VALIDATE("Type Category Code Desc.",DimensionValue.Name)
                ELSE
                  VALIDATE("Type Category Code Desc.",'')
                  */

            end;
        }
        field(50002; "Size Code"; Code[5])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Size Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Size Code") THEN BEGIN
                    IF "Size Code" = '' THEN
                        Dimension.DELETE
                    ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Size Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Size Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Size Code");
                    InsertDimension;
                END;
                /*
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Size Code","Size Code") THEN
                  VALIDATE("Size Code Desc.",DimensionValue.Name)
                ELSE
                  VALIDATE("Size Code Desc.",'')
                  */

            end;
        }
        field(50003; "Design Code"; Code[4])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Design Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            var
                Desc: Code[20];
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Design Code") THEN BEGIN
                    IF "Design Code" = '' THEN
                        Dimension.DELETE ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Design Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Design Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Design Code");
                    InsertDimension;
                END;
                /*
              InventorySetup.GET;
              IF DimensionValue.GET(InventorySetup."Design Code","Design Code") THEN
                VALIDATE("Design Code Desc.",DimensionValue.Name)
              ELSE
                VALIDATE("Design Code Desc.",'');
                */

                //MSAK
                TESTFIELD("Size Code");
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                    Description := DimensionValue.Name;

                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Design Code", "Design Code") THEN
                    Description := Description + ' ' + DimensionValue.Name;
                //MSAK

            end;
        }
        field(50004; "Color Code"; Code[4])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Color Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Color Code") THEN BEGIN
                    IF "Color Code" = '' THEN
                        Dimension.DELETE ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Color Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Color Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Color Code");
                    InsertDimension;
                END;
                /*
              InventorySetup.GET;
              IF DimensionValue.GET(InventorySetup."Color Code","Color Code") THEN
                VALIDATE("Color Code Desc.",DimensionValue.Name)
              ELSE
                VALIDATE("Color Code Desc.",'');
                */

            end;
        }
        field(50005; "Packing Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN BEGIN
                    VALIDATE("Packing Code", DimensionValue.Code);
                    //VALIDATE("Packing Code Desc.",DimensionValue.Name);
                END;
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Packing Code") THEN BEGIN
                    IF "Packing Code" = '' THEN
                        Dimension.DELETE ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Packing Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Packing Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Packing Code");
                    InsertDimension;
                END;
                /*
              InventorySetup.GET;
              IF DimensionValue.GET(InventorySetup."Packing Code","Packing Code") THEN
                VALIDATE("Packing Code Desc.",DimensionValue.Name)
              ELSE
                VALIDATE("Packing Code Desc.",'');
                */

            end;
        }
        field(50006; "Quality Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Quality Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Quality Code") THEN BEGIN
                    IF "Quality Code" = '' THEN
                        Dimension.DELETE
                    ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Quality Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Quality Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Quality Code");
                    InsertDimension;
                END;
                /*
              InventorySetup.GET;
              IF DimensionValue.GET(InventorySetup."Quality Code","Quality Code") THEN
                VALIDATE("Quality Code Desc.",DimensionValue.Name)
              ELSE
                VALIDATE("Quality Code Desc.",'');
                */
                //MSAK
                TESTFIELD("Color Code");
                TESTFIELD("Packing Code");

                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Color Code", "Color Code") THEN
                    "Description 2" := DimensionValue.Name;

                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                    "Description 2" := "Description 2" + ' ' + DimensionValue.Name;

                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Quality Code", "Quality Code") THEN
                    "Description 2" := "Description 2" + ' ' + DimensionValue.Name;

                //MSAK

            end;
        }
        field(50007; "Plant Code"; Code[10])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Plant Code", DimensionValue.Code);
            end;

            trigger OnValidate()
            begin
                InventorySetup.GET;
                IF Dimension.GET(27, "No.", InventorySetup."Plant Code") THEN BEGIN
                    IF "Plant Code" = '' THEN
                        Dimension.DELETE ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Plant Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Plant Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Plant Code");
                    InsertDimension;
                END;
                /*
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Plant Code","Plant Code") THEN
                  VALIDATE("Plant Code Desc.",DimensionValue.Name)
                ELSE
                  VALIDATE("Plant Code Desc.",'');
                  */

            end;
        }
        field(50008; "Item Classification"; Code[10])
        {
            TableRelation = "Item Classification";

            trigger OnValidate()
            begin
                IF "Item Classification" <> '' THEN BEGIN
                    ItemClassification.GET("Item Classification");
                    IF "Type Code" = '' THEN "Type Code" := ItemClassification."Type Code";
                    IF "Type Catogery Code" = '' THEN "Type Catogery Code" := ItemClassification."Type Catogery Code";
                    IF "Size Code" = '' THEN "Size Code" := ItemClassification."Size Code";
                    IF "Design Code" = '' THEN "Design Code" := ItemClassification."Design Code";
                    IF "Color Code" = '' THEN "Color Code" := ItemClassification."Color Code";
                    IF "Packing Code" = '' THEN "Packing Code" := ItemClassification."Packing Code";
                    IF "Quality Code" = '' THEN "Quality Code" := ItemClassification."Quality Code";
                    IF "Plant Code" = '' THEN "Plant Code" := ItemClassification."Plant Code";
                    IF "Type Code" <> '' THEN VALIDATE("Type Code");
                    IF "Type Catogery Code" <> '' THEN VALIDATE("Type Catogery Code");
                    IF "Size Code" <> '' THEN VALIDATE("Size Code");
                    IF "Design Code" <> '' THEN VALIDATE("Design Code");
                    IF "Color Code" <> '' THEN VALIDATE("Color Code");
                    IF "Packing Code" <> '' THEN VALIDATE("Packing Code");
                    IF "Quality Code" <> '' THEN VALIDATE("Quality Code");
                    IF "Plant Code" <> '' THEN VALIDATE("Plant Code");
                END;
            end;
        }
        field(50034; "Group Code"; Code[3])
        {
            TableRelation = "Item Group";

            trigger OnValidate()
            begin
                /*
                IF ItemGrp.GET("Group Code") THEN
                 "Group code Desc" := ItemGrp.Description
                ELSE
                 "Group code Desc" := '';
                 */

            end;
        }
        field(50041; Commercial; Code[20])
        {

            trigger OnLookup()
            begin
                /*
                //TRI S.R 240310 - New code Add Start
                IF Premium AND ("Plant Code" = 'D') OR ("Plant Code" = 'M') OR ("Plant Code" = 'H')THEN
                BEGIN
                FilterSet := '';
                //FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'2H';
                //MSBS.Rao Begin dt. 06-07-12
                IF ("Plant Code" = 'D') THEN
                FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'2D';
                IF ("Plant Code" = 'M') THEN
                FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'2M';
                IF ("Plant Code" = 'H') THEN
                FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'2H';
                //MSBS.Rao End dt. 06-07-12
                RecfilterItem.RESET;
                RecfilterItem.SETFILTER("No.",'%1',FilterSet);
                RecfilterItem.SETRANGE(Premium,FALSE);
                 IF RecfilterItem.FIND('-') THEN
                  BEGIN
                   IF PAGE.RUNMODAL(0,RecfilterItem) = ACTION::LookupOK THEN
                    Commercial := RecfilterItem."No.";
                  END;
                END;
                //TRI S.R 240310 - New code Add Start
                */

            end;
        }
        field(50042; Economic; Code[20])
        {

            trigger OnLookup()
            begin
                /*
                //TRI S.R 240310 - New code Add Start
                IF Premium AND ("Plant Code" = 'D') OR ("Plant Code" = 'M') OR ("Plant Code" = 'H')THEN//MSBS.Rao dt. 06-07-12
                BEGIN
                FilterSet := '';
                //FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'3D';
                //MSBS.Rao Begin dt. 06-07-12
                IF ("Plant Code" = 'D') THEN
                FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'3D';
                IF ("Plant Code" = 'M') THEN
                FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'3M';
                IF ("Plant Code" = 'H') THEN
                FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'3H';
                //MSBS.Rao End dt. 06-07-12
                
                RecfilterItem.RESET;
                RecfilterItem.SETFILTER("No.",'%1',FilterSet);
                RecfilterItem.SETRANGE(Premium,FALSE);
                 IF RecfilterItem.FIND('-') THEN
                  BEGIN
                   IF PAGE.RUNMODAL(0,RecfilterItem) = ACTION::LookupOK THEN
                    Economic := RecfilterItem."No.";
                  END;
                END;
                //TRI S.R 240310 - New code Add Start
                */

            end;
        }
        field(50043; "Broken Tiles"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50126; "Discount Group"; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(50127; "Manuf. Strategy"; Option)
        {
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO,Non Retain - Ex';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO,"Non Retain - Ex";
        }
        field(50130; NPD; Text[15])
        {
        }
        field(50131; Originator; Text[100])
        {
        }
        field(50132; "Tableau Product Group"; Text[10])
        {
        }
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHEMECODE'));
        }
        field(60054; "Scheme Group"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SCHEMEGROUP'));
        }
        field(99000; "Item Code"; Code[20])
        {
        }
        field(99001; Authorization; Code[50])
        {
        }
        field(99002; "Authorization 1"; Code[50])
        {
        }
        field(99003; "Authorization 2"; Code[50])
        {
        }
        field(99004; "User ID"; Code[30])
        {

            trigger OnValidate()
            var
                RecUserSetup: Record "User Setup";
            begin
                //MSAK
                UserSetup.RESET;
                UserSetup.SETFILTER(UserSetup."User ID", "User ID");
                IF UserSetup.FIND('-') THEN BEGIN
                    CheckItemAuth1User();
                    UserSetup.TESTFIELD("Item Authorization 2");
                    UserSetup.TESTFIELD("Item Authorization 3");
                END;

                //MSAK
            end;
        }
        field(99005; "Created Date"; Date)
        {
        }
        field(99006; "Authorization  Date"; Date)
        {
            Editable = false;
        }
        field(99007; "Authorization  Time"; Time)
        {
            Editable = false;
        }
        field(99008; "Authorization 1 Date"; Date)
        {
            Editable = false;
        }
        field(99009; "Authorization 1 Time"; Time)
        {
            Editable = false;
        }
        field(99010; "Authorization 2 Date"; Date)
        {
            Editable = false;
        }
        field(99011; "Authorization 2 Time"; Time)
        {
            Editable = false;
        }
        field(99012; "Closed Date"; Date)
        {
            Editable = false;
        }
        field(99013; "Closed Time"; Time)
        {
            Editable = false;
        }
        field(99014; "Authorization 3"; Code[50])
        {
        }
        field(99015; CEO; Code[50])
        {
        }
        field(99016; IT; Code[50])
        {
        }
        field(99017; "Authorization 3 Approval Date"; Date)
        {
        }
        field(99018; "Authorization 3 Approval Time"; Time)
        {
        }
        field(99019; "CEO Approval Date"; Date)
        {
        }
        field(99020; "CEO Approval TIme"; Time)
        {
        }
        field(99021; "IT Approval Date"; Date)
        {
        }
        field(99022; "IT Approval Time"; Time)
        {
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
        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDFIRST THEN
            REPEAT
                ItemCreationLine.DELETE(TRUE);
            UNTIL ItemCreationLine.NEXT = 0;
    end;


    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            InvtSetup.GET;
            InvtSetup.TESTFIELD("Item No. Series");
            NoSeriesMgt.InitSeries(InvtSetup."Item No. Series", xRec."No. Series", WORKDATE, "No.", InvtSetup."Item No. Series");
        END;
        "Created Date" := TODAY;

        //MSRG 15.09.21 START
        UserSetup.GET(USERID);
        IF NOT UserSetup."Allow TO Release" THEN
            ERROR('You are not Authorised to create Item !!!');
        //MSRG 15.09.21 END

        IF Status = Status::" " THEN
            VALIDATE("User ID", USERID); //MSAK
    end;

    trigger OnModify()
    begin
        IF Status = Status::" " THEN
            VALIDATE("User ID", USERID); //MSAK
    end;

    var
        InventorySetup: Record "Inventory Setup";
        Dimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        ItemClassification: Record "Item Classification";
        ITemGRp: Record "Item Group";
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemCreationLine: Record "Item Creation Line";
        //SMTPSetp: Record "SMTP Mail Setup";
        //SMTPMail: Codeunit 400;//16225
        Item: Record Item;
        ItemCreation: Record "Item Creation";
        UserSetup: Record "User Setup";
        EmailTo: Text[100];
        ItemCode: Code[30];
        ApprovalEntry: Record "Approval Entry";
        EntryNo: Integer;
        NewSequenceNo: Integer;
        ApprovalEntry2: Record "Approval Entry";
        recUserSetup: Record "User Setup";
        SrNo: Integer;
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: Codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        FileMgmt: Codeunit "File Management";
        EmailBccList: list of [Text];
        TempBlobCU: Codeunit "Temp Blob";
        InstreamVar: InStream;
        OutstreamVar: OutStream;



    procedure ModifyDimension()
    begin
        /*
        Dimension.VALIDATE(Dimension."Value Posting",Dimension."Value Posting"::"Same Code");
        Dimension.MODIFY;
        *///MSAK

    end;

    procedure InsertDimension()
    begin
        /*
        Dimension.VALIDATE(Dimension."Table ID",27);
        Dimension.VALIDATE(Dimension."No.","No.");
        Dimension.VALIDATE(Dimension."Value Posting",Dimension."Value Posting":: " ");
        Dimension.INSERT(TRUE);
        *///MSAK

    end;

    procedure AssistEdit(ItemCreationNo: Record "Item Creation"): Boolean
    var
        SalesHeader2: Record "Sales Header";
    begin
        InvtSetup.GET;
        InvtSetup.TESTFIELD("Item No. Series");
        IF NoSeriesMgt.SelectSeries(InvtSetup."Item No. Series", xRec."No. Series", "No. Series") THEN BEGIN
            //NoSeriesMgt.SetDefaultSeries(InvtSetup."Item No. Series", "No. Series");
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    procedure SendItemApproval(ItemCreation: Record "Item Creation")
    begin
        UserSetup.RESET;
        IF UserSetup.GET("User ID") THEN
            IF UserSetup."Allow TO Release" <> TRUE THEN
                ERROR('You are not athorized to create item');

        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF NOT ItemCreationLine.FINDFIRST THEN
            ERROR('There is no item to approve');

        IF Status = Status::Created THEN
            MESSAGE('Item creations is already done')
        ELSE
            IF Status = Status::" " THEN BEGIN
                Authorization1;
            END ELSE
                IF Status = Status::Authorization1 THEN BEGIN
                    Authorization2;
                END ELSE
                    IF Status = Status::Authorization2 THEN BEGIN
                        Authorization3;
                    END ELSE
                        IF Status = Status::Authorization3 THEN BEGIN
                            CEOAuthorize;
                        END;
    end;

    procedure SendEmail(RecItemCreation: Record "Item Creation")
    var
        EmailMsg: codeunit "Email Message";
    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        IF RecItemCreation.Status = RecItemCreation.Status::" " THEN BEGIN
            EmailTo := RecItemCreation."Authorization 1";
        END;
        IF RecItemCreation.Status = RecItemCreation.Status::Authorization1 THEN BEGIN
            EmailTo := RecItemCreation."Authorization 2";
        END;
        IF RecItemCreation.Status = RecItemCreation.Status::Authorization2 THEN BEGIN
            EmailTo := RecItemCreation."Authorization 3";
        END;

        /*
        IF RecItemCreation.Status = RecItemCreation.Status::Authorization4 THEN BEGIN
          EmailTo := RecItemCreation."Authorization 3";
        END;*/


        //Sending Mail
        IF EmailTo <> '' THEN BEGIN
            //  SMTPSetp.GET;
            //  SMTPSetp.TESTFIELD("User ID")
            //  CLEAR(SMTPMail);
            ///  SMTPMail.CreateMessage('OrientBell Ltd', 'donotreply@orientbell.com', EmailTo, 'Item Created by ' + FORMAT(Status), '', TRUE);
            EmailAddressList.Add('donotreply@orientbell.com');
            EmailAddressList.Add(EmailTo);


            //SMTPMail.CreateMessage('OrientBell Pvt ltd', 'donotreply@orientbell.com','laxman.singh@orientbell.com', 'Item Created by '+FORMAT(Status), '', TRUE);
            //SMTPMail.AddCC('');
            BodyText := 'Dear Sir/Madam,';
            BodyText += '<br><br>';
            BodyText += 'Item Creation Document No is: ' + ItemCreationLine."No.";
            BodyText += '<br><br>';
            BodyText += '<b>' + 'ITEM NO.' + '                       -------------    ' + 'ITEM DESCRIPTION</b>';
            BodyText += '<br>';
            BodyText += '================================================================================<br>';
            ItemCreationLine.RESET;
            ItemCreationLine.SETRANGE("No.", "No.");
            IF ItemCreationLine.FINDFIRST THEN
                REPEAT
                    BodyText += ItemCreationLine."Item Code" + '       -------------    ' + ItemCreationLine.Description + ' ' +
                    ItemCreationLine."Description 2";
                    BodyText += '<br>';
                UNTIL ItemCreationLine.NEXT = 0;
            BodyText += '================================================================================<br><br>';
            BodyText += 'Item has been created by ' + FORMAT(Status) + '. Please approve this item created.';
            BodyText += '<br><br>';
            BodyText += 'Thank You';
            BodyText += '<br>';
            BodyText += 'OrientBell Ltd.';
            EmailMsg.Create(EmailAddressList, 'Item Created by ' + FORMAT(Status), BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            MESSAGE('Mail sent successfully');

        END;
        //

    end;

    procedure Authorization1()
    var
        ItemAuth1: Code[50];
    begin
        TESTFIELD("User ID");
        IF UserSetup.GET("User ID") THEN BEGIN
            IF USERID <> UserSetup."User ID" THEN
                ERROR('You are not authorize to send the Approval !!');
        END
        ELSE
            ERROR('User Not Found ');

        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDSET THEN
            REPEAT
                ItemCreationLine.TESTFIELD("Type Code");
                ItemCreationLine.TESTFIELD("Type Catogery Code");
                ItemCreationLine.TESTFIELD("Size Code");
                ItemCreationLine.TESTFIELD("Design Code");
                ItemCreationLine.TESTFIELD("Color Code");
                ItemCreationLine.TESTFIELD("Packing Code");
                ItemCreationLine.TESTFIELD("Quality Code");
                ItemCreationLine.TESTFIELD("Plant Code");
                ItemCreationLine.TESTFIELD(NPD);

                recUserSetup.GET("User ID");
                CheckItemAuth1User();
                ItemAuth1 := GetItemAuth1User();

                IF UserSetup.GET(ItemAuth1) THEN BEGIN
                    UserSetup.TESTFIELD("E-Mail");
                    ItemCreationLine.VALIDATE("Authorization 1", UserSetup."E-Mail");
                END;

                ItemCreationLine.VALIDATE("Authorization  Date", TODAY);
                ItemCreationLine.VALIDATE("Authorization Time", TIME);
                ItemCreationLine.Status := ItemCreationLine.Status::Authorization1;
                ItemCreationLine.MODIFY(TRUE);
            UNTIL ItemCreationLine.NEXT = 0;

        VALIDATE("Authorization 1", UserSetup."E-Mail");
        SendEmail(Rec);
        Status := Status::Authorization1;
        VALIDATE("Authorization  Date", TODAY);
        VALIDATE("Authorization  Time", TIME);
        Rec.MODIFY(TRUE);
    end;

    procedure Authorization2()
    var
        ItemAuth1: Code[50];
    begin

        TESTFIELD("User ID");
        IF UserSetup.GET("User ID") THEN BEGIN
            CheckItemAuth1User();
            ItemAuth1 := GetItemAuth1User();
            IF USERID <> ItemAuth1 THEN
                ERROR('You are not authorize to send the Approval !!');
        END
        ELSE
            ERROR('User Not Found ');

        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDSET THEN
            REPEAT
                ItemCreationLine.TESTFIELD("Type Code");
                ItemCreationLine.TESTFIELD("Type Catogery Code");
                ItemCreationLine.TESTFIELD("Size Code");
                ItemCreationLine.TESTFIELD("Packing Code");
                ItemCreationLine.TESTFIELD("Quality Code");
                ItemCreationLine.TESTFIELD("Plant Code");
                ItemCreationLine.TESTFIELD("Design Code");
                ItemCreationLine.TESTFIELD("Color Code");
                ItemCreationLine.TESTFIELD("Gross Weight");
                ItemCreationLine.TESTFIELD("Net Weight");
                ItemCreationLine.TESTFIELD("Default Prod. Plant Code");
                ItemCreationLine.TESTFIELD("Base Unit of Measure");
                ItemCreationLine.TESTFIELD(NPD);

                recUserSetup.GET("User ID");
                IF UserSetup.GET(recUserSetup."Item Authorization 2") THEN BEGIN
                    UserSetup.TESTFIELD("E-Mail");
                    ItemCreationLine.VALIDATE("Authorization 2", UserSetup."E-Mail");
                END
                ELSE
                    recUserSetup.TESTFIELD("Item Authorization 2");

                ItemCreationLine.VALIDATE("Authorization 1 Date", TODAY);
                ItemCreationLine.VALIDATE("Authorization 1 Time", TIME);
                ItemCreationLine.Status := ItemCreationLine.Status::Authorization2;
                ItemCreationLine.MODIFY(TRUE);

                Item.RESET;
                Item.SETRANGE("No.", ItemCreationLine."Item Code");
                IF Item.FINDFIRST THEN
                    ERROR('Item code is alreay created.');
            UNTIL ItemCreationLine.NEXT = 0;

        VALIDATE("Authorization 2", UserSetup."E-Mail");
        SendEmail(Rec);
        Status := Status::Authorization2;
        VALIDATE("Authorization 1 Date", TODAY);
        VALIDATE("Authorization 1 Time", TIME);
        Rec.MODIFY(TRUE);
    end;

    procedure Authorization3()
    begin
        TESTFIELD("User ID");
        IF UserSetup.GET("User ID") THEN BEGIN
            IF USERID <> UserSetup."Item Authorization 2" THEN
                ERROR('You are not authorize to send the Approval !!');
        END
        ELSE
            ERROR('User Not Found ');

        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDSET THEN
            REPEAT
                ItemCreationLine.TESTFIELD("Item Classification");
                ItemCreationLine.TESTFIELD("Tableau Product Group");
                ItemCreationLine.TESTFIELD("HSN/SAC Code");
                ItemCreationLine.TESTFIELD(COGS);
                recUserSetup.GET("User ID");
                IF UserSetup.GET(recUserSetup."Item Authorization 3") THEN BEGIN
                    UserSetup.TESTFIELD("E-Mail");
                    ItemCreationLine.VALIDATE("Authorization 3", UserSetup."E-Mail");
                END
                ELSE
                    recUserSetup.TESTFIELD("Item Authorization 3");
                ItemCreationLine.VALIDATE("Authorization 2 Date", TODAY);
                ItemCreationLine.VALIDATE("Authorization 2 Time", TIME);
                ItemCreationLine.Status := ItemCreationLine.Status::Authorization3;
                ItemCreationLine.MODIFY(TRUE);
            UNTIL ItemCreationLine.NEXT = 0;
        VALIDATE("Authorization 3", UserSetup."E-Mail");
        SendEmail2(Rec);
        Status := Status::Authorization3;
        VALIDATE("Authorization 2 Date", TODAY);
        VALIDATE("Authorization 2 Time", TIME);
        Rec.MODIFY(TRUE);

        //CreateApprovalEntry(ItemCreationLine.Status);
    end;

    procedure CMOAuthorize()
    begin
        /*
        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDSET THEN REPEAT
          ItemCreationLine.Status := ItemCreationLine.Status::CMO;
          ItemCreationLine.MODIFY(TRUE);
        UNTIL ItemCreationLine.NEXT=0;
        VALIDATE("Authorization 2 Date", TODAY);
        VALIDATE("Authorization 2 Time", TIME);
        CreateApprovalEntry(ItemCreationLine.Status);
        */ //Removed

    end;

    procedure CEOAuthorize()
    begin
        TESTFIELD("User ID");
        IF UserSetup.GET("User ID") THEN BEGIN
            IF USERID <> UserSetup."Item Authorization 3" THEN
                ERROR('You are not authorize to send the Approval !!');
        END
        ELSE
            ERROR('User Not Found ');

        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDSET THEN
            REPEAT
                ItemCreationLine.TESTFIELD("Type Code");
                ItemCreationLine.TESTFIELD("Type Catogery Code");
                ItemCreationLine.TESTFIELD("Size Code");
                ItemCreationLine.TESTFIELD("Design Code");
                ItemCreationLine.TESTFIELD("Color Code");
                ItemCreationLine.TESTFIELD("Packing Code");
                ItemCreationLine.TESTFIELD("Quality Code");
                ItemCreationLine.TESTFIELD("Plant Code");
                ItemCreationLine.TESTFIELD("Item Classification");
                ItemCreationLine.TESTFIELD("Tableau Product Group");
                ItemCreationLine.TESTFIELD(COGS);
                ItemCreationLine.TESTFIELD("Type Code");
                ItemCreationLine.TESTFIELD("Type Catogery Code");
                ItemCreationLine.TESTFIELD("Size Code");
                ItemCreationLine.TESTFIELD("Packing Code");
                ItemCreationLine.TESTFIELD("Quality Code");
                ItemCreationLine.TESTFIELD("Plant Code");
                ItemCreationLine.TESTFIELD("Design Code");
                ItemCreationLine.TESTFIELD("Color Code");
                ItemCreationLine.TESTFIELD("Gross Weight");
                ItemCreationLine.TESTFIELD("Net Weight");
                ItemCreationLine.TESTFIELD("Default Prod. Plant Code");
                ItemCreationLine.TESTFIELD("Base Unit of Measure");
                ItemCreationLine.TESTFIELD("HSN/SAC Code");
                /*recUserSetup.GET("User ID");
                IF UserSetup.GET(recUserSetup."Item Authorization 4") THEN BEGIN
                  UserSetup.TESTFIELD("E-Mail");
                  ItemCreationLine.VALIDATE("Authorization 4", UserSetup."E-Mail");
                END
                ELSE
                  recUserSetup.TESTFIELD("Item Authorization 4");*/
                ItemCreationLine.VALIDATE("Authorization 3 Approval Date", TODAY);
                ItemCreationLine.VALIDATE("Authorization 3 Approval Time", TIME);
                ItemCreationLine.Status := ItemCreationLine.Status::Created;
                ItemCreationLine.MODIFY(TRUE);
                Item.RESET;
                Item.SETRANGE("No.", ItemCreationLine."Item Code");
                IF NOT Item.FINDFIRST THEN BEGIN
                    CreateItem(ItemCreationLine);
                END;
            UNTIL ItemCreationLine.NEXT = 0;
        Status := Status::Created;
        VALIDATE("Authorization 3 Approval Date", TODAY);
        VALIDATE("Authorization 3 Approval Time", TIME);
        Rec.MODIFY(TRUE);

    end;

    procedure ITAuthorize()
    begin
        Rec.Status := Rec.Status::Created;
        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDSET THEN
            REPEAT
                Item.RESET;
                Item.SETRANGE("No.", ItemCreationLine."Item Code");
                IF NOT Item.FINDFIRST THEN BEGIN
                    Item.INIT;
                    Item.TRANSFERFIELDS(ItemCreationLine);
                    Item.VALIDATE(Description, ItemCreationLine.Description);
                    Item."Type Code Desc." := ItemCreationLine."Type Name";
                    Item."Type Category Code Desc." := ItemCreationLine."Type Category Name";
                    Item."Size Code Desc." := ItemCreationLine."Size Name";
                    Item."Design Code Desc." := ItemCreationLine."Desgn Name";
                    Item."Color Code Desc." := ItemCreationLine."Color Name";
                    Item."Packing Code Desc." := ItemCreationLine."Packing Name";
                    Item."Quality Code Desc." := ItemCreationLine."Quality Name";
                    Item."Plant Code Desc." := ItemCreationLine."Plant Name";
                    Item."Group code Desc" := ItemCreationLine."Group code Desc";
                    Item.VALIDATE("No.", ItemCreationLine."Item Code");
                    Item.INSERT(TRUE);
                    //MESSAGE('Item created successfully.');
                END;
                ItemCreationLine.Status := ItemCreationLine.Status::Created;
                ItemCreationLine.MODIFY(TRUE);
            UNTIL ItemCreationLine.NEXT = 0;
    end;

    procedure ApprovalEmail(ApprovalEntry_ItemCreation: Record "Approval Entry")
    var
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
    begin
        //Sending Mail
        //  SMTPSetp.GET;
        //  SMTPSetp.TESTFIELD("User ID");
        //  CLEAR(SMTPMail);
        //SMTPMail.CreateMessage('OrientBell Ltd', 'donotreply@orientbell.com',ApprovalEntry_ItemCreation.EmailID, 'Item Created, Please Approve', '', TRUE);
        ///   SMTPMail.CreateMessage('OrientBell Ltd', 'donotreply@orientbell.com', 'laxman.singh@orientbell.com', 'Item Created, Please Approve', '', TRUE);

        EmailAddressList.Add('donotreply@orientbell.com');   //SMTPMail.AddCC('alok.agarwal@orientbell.com');
        EmailCCList.add('laxman.singh@orientbell.com');
        BodyText := 'Dear Sir/Madam,';
        BodyText += '<br><br>';
        BodyText += 'Item Creation Document No is: ' + ItemCreationLine."No.";
        BodyText += '<br><br>';
        BodyText += '<b>' + 'ITEM NO.' + '                       -------------    ' + 'ITEM DESCRIPTION</b>';
        BodyText += '<br>';
        BodyText += '================================================================================<br>';
        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDFIRST THEN
            REPEAT
                BodyText += ItemCreationLine."Item Code" + '       -------------    ' + ItemCreationLine.Description + ' ' +
                ItemCreationLine."Description 2";
                BodyText += '<br>';
            UNTIL ItemCreationLine.NEXT = 0;
        BodyText += '===========================================================<br><br>';
        BodyText += 'Please approve above items created.  ';
        BodyText += Text50045 + getApprovalLink(50089, "No.", 1) + Text50046 + Text50047;
        BodyText += '<br><br>';
        BodyText += 'Thank You';
        BodyText += '<br>';
        BodyText += 'OrientBell Ltd.';
        EmailMsg.Create(EmailAddressList, 'Item Created, Please Approve', BodyText, true, EmailBccList, EmailCCList);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        MESSAGE('Mail sent successfully');
    end;

    procedure getApprovalLink(TblID: Integer; DocNo: Code[20]; TypeInt: Integer): Text
    var
        AppEntry: Record "Approval Entry";
        GUIDTXT: Text[100];
        TxtLink: Text[250];
    begin
        AppEntry.RESET;
        AppEntry.SETRANGE("Table ID", TblID);
        AppEntry.SETRANGE("Document No.", DocNo);
        AppEntry.SETRANGE(Status, AppEntry.Status::Created);
        AppEntry.SETFILTER("GUID Key", '<>%1', '{00000000-0000-0000-0000-000000000000}');
        IF AppEntry.FINDFIRST THEN BEGIN
            GUIDTXT := AppEntry."GUID Key";
        END;

        //TxtLink := '<button onclick="window.open('+'http://14.140.109.180/mailapproval/?ref='+GUIDTXT+')">Click me</button>';
        //TxtLink := TextButtonStart+GUIDTXT+TextButtonEnd;
        TxtLink := 'http://14.140.109.180/mailapproval/?ref=' + GUIDTXT; //test server
        //TxtLink := 'http://182.73.118.183/mailapproval/?ref='+GUIDTXT; //live server
        //TxtLink := 'http://14.140.109.190/mailapproval/?ref='+GUIDTXT; //live server
        //TxtLink := 'http://erp.orientapps.com/mailapproval/?ref='+GUIDTXT; //live server
        EXIT(TxtLink);
    end;

    procedure CreateApprovalEntry(CurrentStatus: Option " ",Authorization1,Authorization2,Authorization3,CMO,CEO,IT)
    var
        CreateApprovalEntry: Record "Approval Entry";
    begin
        WITH CreateApprovalEntry DO BEGIN
            ApprovalEntry.RESET;
            IF ApprovalEntry.FINDLAST THEN
                EntryNo := ApprovalEntry."Entry No.";
            SETRANGE("Table ID", 50089);
            SETRANGE("Document Type", "Document Type"::"Credit Limit");
            SETRANGE("Document No.", "No.");
            IF FINDLAST THEN
                NewSequenceNo := "Sequence No." + 1
            ELSE
                NewSequenceNo := 1;
            "Entry No." := EntryNo + 1;
            "Table ID" := 50089;
            "Document Type" := "Document Type"::"Credit Limit";
            "Document No." := "No.";
            "Sequence No." := NewSequenceNo;
            "Sender ID" := USERID;
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID1" := USERID;
            IF CurrentStatus = CurrentStatus::Authorization3 THEN
                EmailID := 'laxman.singh@orientbell.com'
            ELSE
                IF CurrentStatus = CurrentStatus::CEO THEN
                    EmailID := 'laxman.singh@orientbell.com';
            Status := Status::Created;
            INSERT(TRUE);

            ApprovalEmail(CreateApprovalEntry);
        END;
    end;

    local procedure CreateItem(ItemCreationLine: Record "Item Creation Line")
    begin
        Item.INIT;
        Item.TRANSFERFIELDS(ItemCreationLine);
        Item.VALIDATE("No.", ItemCreationLine."Item Code");
        Item.VALIDATE(Description, ItemCreationLine.Description);
        Item.VALIDATE("Description 2", ItemCreationLine."Description 2");
        //16225  Item.VALIDATE("Excise Prod. Posting Group", ItemCreationLine."Excise Prod. Posting Group");
        Item.VALIDATE("Gen. Prod. Posting Group", ItemCreationLine."Gen. Prod. Posting Group");
        Item.VALIDATE("Item Category Code", ItemCreationLine."Item Category Code");
        Item.VALIDATE("VAT Prod. Posting Group", ItemCreationLine."VAT Prod. Posting Group");
        Item.VALIDATE("Tax Group Code", ItemCreationLine."Tax Group Code");
        Item.VALIDATE(COGS, ItemCreationLine.COGS);
        Item.VALIDATE("Gross Weight", ItemCreationLine."Gross Weight");
        Item.VALIDATE("Net Weight", ItemCreationLine."Net Weight");
        Item.VALIDATE(NPD, ItemCreationLine.NPD);
        Item."Item Classification" := ItemCreationLine."Item Classification";
        Item."Type Code" := ItemCreationLine."Type Code";
        Item."Type Code Desc." := ItemCreationLine."Type Name";
        Item."Type Catogery Code" := ItemCreationLine."Type Catogery Code";
        Item."Type Category Code Desc." := ItemCreationLine."Type Category Name";
        Item."Size Code" := ItemCreationLine."Size Code";
        Item."Size Code Desc." := ItemCreationLine."Size Name";
        Item."Design Code" := ItemCreationLine."Design Code";
        Item."Design Code Desc." := ItemCreationLine."Desgn Name";
        Item."Color Code" := ItemCreationLine."Color Code";
        Item."Color Code Desc." := ItemCreationLine."Color Name";
        Item."Packing Code" := ItemCreationLine."Packing Code";
        Item."Packing Code Desc." := ItemCreationLine."Packing Name";
        Item."Quality Code" := ItemCreationLine."Quality Code";
        Item."Quality Code Desc." := ItemCreationLine."Quality Name";
        Item."Plant Code" := ItemCreationLine."Plant Code";
        Item."Plant Code Desc." := ItemCreationLine."Plant Name";
        Item."Group Code" := ItemCreationLine."Group Code";
        Item."Group code Desc" := ItemCreationLine."Group code Desc";
        Item."GST Credit" := item."GST Credit"::Availment;
        item."GST Group Code" := ItemCreationLine."GST Group Code";
        item."HSN/SAC Code" := ItemCreationLine."HSN/SAC Code";
        item."Created Date" := ItemCreationLine."Created Date";
        Item."Base Unit Of Measure New" := ItemCreationLine."Base Unit of Measure";
        IF ItemCreationLine."Replenishment System"::Assembly = ItemCreationLine."Replenishment System" THEN
            Item.VALIDATE("Replenishment System", Item."Replenishment System"::Assembly)
        ELSE
            IF ItemCreationLine."Replenishment System"::"Prod. Order" = ItemCreationLine."Replenishment System" THEN
                Item.VALIDATE("Replenishment System", Item."Replenishment System"::"Prod. Order")
            ELSE
                IF ItemCreationLine."Replenishment System"::Purchase = ItemCreationLine."Replenishment System" THEN
                    Item.VALIDATE("Replenishment System", Item."Replenishment System"::Purchase);
        Item."Tableau Product Group" := ItemCreationLine."Tableau Product Group";
        Item.Retained := TRUE;
        Item.INSERT(TRUE);
        MESSAGE('Item created successfully.');
    end;

    local procedure CheckCancelItemCreationStatus(ItemCreation: Record "Item Creation")
    var
        ItemAuth1: Code[50];
    begin

        IF (ItemCreation.Status = ItemCreation.Status::" ") OR (ItemCreation.Status = ItemCreation.Status::Created) THEN
            ERROR('You cannot Perform this action !!!');

        UserSetup.GET("User ID");
        CheckItemAuth1User();
        UserSetup.TESTFIELD("Item Authorization 2");
        UserSetup.TESTFIELD("Item Authorization 3");

        IF ItemCreation.Status = ItemCreation.Status::Authorization3 THEN BEGIN
            IF USERID <> UserSetup."Item Authorization 3" THEN
                ERROR('You are not authorize to cancel the Document !!')
        END
        ELSE
            IF ItemCreation.Status = ItemCreation.Status::Authorization2 THEN BEGIN
                IF USERID <> UserSetup."Item Authorization 2" THEN
                    ERROR('You are not authorize to cancel the Document !!');
            END
            ELSE
                IF ItemCreation.Status = ItemCreation.Status::Authorization1 THEN BEGIN
                    CheckItemAuth1User();
                    ItemAuth1 := GetItemAuth1User();
                    IF USERID <> ItemAuth1 THEN
                        ERROR('You are not authorize to cancel the Document !!');
                END;
    end;

    procedure CancelItemCreation(ItemCreation: Record "Item Creation")
    begin

        CheckCancelItemCreationStatus(ItemCreation);

        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", ItemCreation."No.");
        IF ItemCreationLine.FINDSET THEN
            REPEAT
                //ItemCreationLine.VALIDATE("Authorization 3 Date", TODAY);
                //ItemCreationLine.VALIDATE("Authorization 3 Time", TIME);
                ItemCreationLine.Status := ItemCreationLine.Status - 1;
                ItemCreationLine.MODIFY(TRUE);
            UNTIL ItemCreationLine.NEXT = 0;
        CancelItemCreationEmail(ItemCreation);
        Status := Status - 1;
        Rec.MODIFY(TRUE);
    end;

    procedure CancelItemCreationEmail(RecItemCreation: Record "Item Creation")
    var
        ItemAuth1: Code[50];
    begin

        //Sending Mail

        // SMTPSetp.GET;
        // SMTPSetp.TESTFIELD("User ID");
        // CLEAR(SMTPMail);
        // SMTPMail.CreateMessage('OrientBell Pvt ltd', 'donotreply@orientbell.com', EmailTo, 'Item Cancelled by ' + FORMAT(Status), '', TRUE);
        EmailAddressList.Add('donotreply@orientbell.com');
        // Add Email for User 4
        recUserSetup.GET("User ID");
        IF UserSetup.GET(recUserSetup."Item Authorization 3") THEN BEGIN
            UserSetup.TESTFIELD("E-Mail");
            ///  SMTPMail.AddRecipients(UserSetup."E-Mail");
        END
        ELSE
            ERROR('There is no Item Auth User 3 ');

        // Add Email for User 3
        recUserSetup.GET("User ID");
        IF UserSetup.GET(recUserSetup."Item Authorization 2") THEN BEGIN
            UserSetup.TESTFIELD("E-Mail");
            ///  SMTPMail.AddRecipients(UserSetup."E-Mail");
        END
        ELSE
            ERROR('There is no Item Auth User 2');

        // Add Email for User 2
        recUserSetup.GET("User ID");
        CheckItemAuth1User();
        ItemAuth1 := GetItemAuth1User();
        IF UserSetup.GET(ItemAuth1) THEN BEGIN
            UserSetup.TESTFIELD("E-Mail");
            ///  SMTPMail.AddRecipients(UserSetup."E-Mail");
        END;

        // Add Email for User 1
        recUserSetup.GET("User ID");
        IF UserSetup.GET(recUserSetup."User ID") THEN BEGIN
            UserSetup.TESTFIELD("E-Mail");
            ///  SMTPMail.AddRecipients(UserSetup."E-Mail");
        END;


        //SMTPMail.CreateMessage('OrientBell Pvt ltd', 'donotreply@orientbell.com','laxman.singh@orientbell.com', 'Item Created by '+FORMAT(Status), '', TRUE);
        //SMTPMail.AddCC('');
        EmailAddressList.Add('donotreply@orientbell.com');
        BodyText := 'Dear Sir/Madam,';
        BodyText += '<br><br>';
        BodyText += 'Item Creation Document No is: ' + ItemCreationLine."No.";
        BodyText += '<br><br>';
        BodyText += '<b>' + 'ITEM NO.' + '                       -------------    ' + 'ITEM DESCRIPTION</b>';
        BodyText += '<br>';
        BodyText += '================================================================================<br>';
        ItemCreationLine.RESET;
        ItemCreationLine.SETRANGE("No.", "No.");
        IF ItemCreationLine.FINDFIRST THEN
            REPEAT
                BodyText += ItemCreationLine."Item Code" + '       -------------    ' + ItemCreationLine.Description + ' ' +
                ItemCreationLine."Description 2";
                BodyText += '<br>';
            UNTIL ItemCreationLine.NEXT = 0;
        BodyText += '================================================================================<br><br>';
        BodyText += 'Item has been Cancelled by ' + FORMAT(Status) + '. Please approve this item created.';
        BodyText += '<br><br>';
        BodyText += 'Thank You';
        BodyText += '<br>';
        BodyText += 'OrientBell Ltd.';
        EmailMsg.Create(EmailAddressList, 'Item Created by ' + FORMAT(Status), BodyText, true, EmailBccList, EmailCCList);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        MESSAGE('Mail sent successfully');
        //
    end;

    local procedure CheckItemAuth1User()
    begin
        TESTFIELD("Operation unit");
        recUserSetup.GET("User ID");
        IF "Operation unit" = "Operation unit"::DRA THEN
            recUserSetup.TESTFIELD("Item Authorization DRA 1")
        ELSE
            IF "Operation unit" = "Operation unit"::HSK THEN
                recUserSetup.TESTFIELD("Item Authorization HSK 1")
            ELSE
                IF "Operation unit" = "Operation unit"::SKD THEN
                    recUserSetup.TESTFIELD("Item Authorization SKD 1")
                ELSE
                    IF "Operation unit" = "Operation unit"::WZ THEN
                        recUserSetup.TESTFIELD("Item Authorization WZ 1");
    end;

    local procedure GetItemAuth1User(): Code[50]
    begin
        TESTFIELD("Operation unit");
        recUserSetup.GET("User ID");
        IF "Operation unit" = "Operation unit"::DRA THEN
            EXIT(recUserSetup."Item Authorization DRA 1")
        ELSE
            IF "Operation unit" = "Operation unit"::HSK THEN
                EXIT(recUserSetup."Item Authorization HSK 1")
            ELSE
                IF "Operation unit" = "Operation unit"::SKD THEN
                    EXIT(recUserSetup."Item Authorization SKD 1")
                ELSE
                    IF "Operation unit" = "Operation unit"::WZ THEN
                        EXIT(recUserSetup."Item Authorization WZ 1")
    end;


    procedure SendEmail2(RecItemCreation: Record "Item Creation")
    begin

        IF RecItemCreation.Status = RecItemCreation.Status::" " THEN BEGIN
            EmailTo := RecItemCreation."Authorization 1";
        END;
        IF RecItemCreation.Status = RecItemCreation.Status::Authorization1 THEN BEGIN
            EmailTo := RecItemCreation."Authorization 2";
        END;
        IF RecItemCreation.Status = RecItemCreation.Status::Authorization2 THEN BEGIN
            EmailTo := RecItemCreation."Authorization 3";
        END;


        IF RecItemCreation.Status = RecItemCreation.Status::Authorization3 THEN BEGIN
            EmailTo := RecItemCreation."Authorization 3";
        END;


        //Sending Mail
        IF EmailTo <> '' THEN BEGIN
            //  SMTPSetp.GET;
            //  SMTPSetp.TESTFIELD("User ID");
            //  CLEAR(SMTPMail);
            ///  SMTPMail.CreateMessage('OrientBell Ltd', 'donotreply@orientbell.com', EmailTo, 'Item Created by ' + FORMAT(Status), '', TRUE);
            EmailAddressList.Add('donotreply@orientbell.com');
            //  SMTPMail.AddRecipients('kulbhushan.sharma@orientbell.com');
            EmailCCList.add('laxman.singh@orientbell.com');
            BodyText := 'Dear Sir/Madam,';
            BodyText += '<br><br>';
            BodyText += 'Item Creation Document No is: ' + ItemCreationLine."No.";
            BodyText += '<br><Br>';

            BodyText += '<br>';
            BodyText += '<Table border="1">';
            BodyText += '<tr>';

            BodyText += '<th>SL No.</th>';
            BodyText += '<th>Type</th>';
            BodyText += '<th>Plant</th>';
            BodyText += '<th>Project Name</th>';
            BodyText += '<th>Category</th>';
            BodyText += '<th>Size</th>';
            BodyText += '<th>Design</th>';
            BodyText += '<th>Color</th>';
            BodyText += '<th>Variable & Semi Variable Cost</th>';
            BodyText += '<th>Price Group</th>';
            BodyText += '<th>List Price</th>';
            BodyText += '<th>AD (Actual)</th>';
            BodyText += '<th>Net ASP</th>';
            BodyText += '<th>Gross Margin</th>';
            BodyText += '<th>Gross Margin</th>';
            BodyText += '<th>Net Margin (After CD)</th>';
            BodyText += '<th>Net Margin </th>';
            BodyText += '</tr>';

            SrNo := 0;
            ItemCreationLine.RESET;
            ItemCreationLine.SETCURRENTKEY("No.");
            ItemCreationLine.SETRANGE("No.", "No.");
            IF ItemCreationLine.FINDFIRST THEN
                REPEAT
                    SrNo += 1;

                    BodyText += '<tr>';
                    BodyText += '<td align="center">' + FORMAT(SrNo) + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Type Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Plant Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Project Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Type Category Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Size Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Desgn Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Color Name") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ROUND(ItemCreationLine."Variable & Semi Variable Cost", 0.01, '=')) + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Item Classification") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."List Price") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine.AD) + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine.ASP) + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Gross Margin") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ROUND(ItemCreationLine."Gross Margin %", 0.01, '=') * 100) + ' %' + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ItemCreationLine."Net Margin") + '</td>';
                    BodyText += '<td align="center">' + FORMAT(ROUND(ItemCreationLine."Net Margin %", 0.01, '=') * 100) + ' %' + '</td>';
                    BodyText += '</tr>';
                UNTIL ItemCreationLine.NEXT = 0;
            //BodyText +='================================================================================<br><br>');
            //BodyText +='Item has been created by '+FORMAT(Status)+'. Please approve this item created.');
            BodyText += '</table>';
            BodyText += '<br><br>';
            BodyText += 'Thank You';
            BodyText += '<br>';
            BodyText += 'Orientbell Ltd.';
            EmailMsg.Create(EmailAddressList, 'Item Created by ' + FORMAT(Status), BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            MESSAGE('Mail sent successfully');
        END;
    end;
}

