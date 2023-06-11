table 50119 "Item Creation Line"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(3; Description; Text[30])
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
        field(5; "Description 2"; Text[30])
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
        field(21; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            OptionCaption = 'LIFO,FIFO,Specific,Average,Standard';
            OptionMembers = LIFO,FIFO,Specific,"Average",Standard;

            trigger OnValidate()
            begin

                /*  IF "Costing Method" = xRec."Costing Method" THEN
                     EXIT;
  */

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
        field(5419; "Replenishment System"; Option)
        {
            AccessByPermission = TableData "Req. Wksh. Template" = R;
            Caption = 'Replenishment System';
            OptionCaption = ' ,Purchase,Prod. Order,,Assembly';
            OptionMembers = " ",Purchase,"Prod. Order",,Assembly;

            trigger OnValidate()
            begin
                /*
                IF "Replenishment System" <> "Replenishment System"::Assembly THEN
                  TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");
                IF "Replenishment System" <> "Replenishment System"::Purchase THEN
                  TESTFIELD(Type,Type::Inventory);
                  */

            end;
        }
        field(5425; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
        }
        field(5426; "Purch. Unit of Measure"; Code[10])
        {
            Caption = 'Purch. Unit of Measure';
        }
        field(5702; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";

            trigger OnValidate()
            var
                ItemCategory: Record "Item Category";
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            //ProductGrp: Record "Product Group"; //16225 TABLE PRODUCT REMOVED
            begin
                /*
                IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
                  IF ItemCategory.GET("Item Category Code") THEN BEGIN
                    IF "Gen. Prod. Posting Group" = '' THEN
                      VALIDATE("Gen. Prod. Posting Group",ItemCategory."Def. Gen. Prod. Posting Group");
                        IF (("Gen. Prod. Posting Group" = ItemCategory."Def. Gen. Prod. Posting Group") AND
                        ("VAT Prod. Posting Group" = GenProdPostingGrp."Def. VAT Prod. Posting Group"))
                    THEN
                      VALIDATE("VAT Prod. Posting Group",ItemCategory."Def. VAT Prod. Posting Group");
                    IF "Inventory Posting Group" = '' THEN
                      VALIDATE("Inventory Posting Group",ItemCategory."Def. Inventory Posting Group");
                    IF "Tax Group Code" = '' THEN
                      VALIDATE("Tax Group Code",ItemCategory."Def. Tax Group Code");
                    VALIDATE("Costing Method",ItemCategory."Def. Costing Method");
                  END;
                
                  IF NOT ProductGrp.GET("Item Category Code","Product Group Code") THEN
                    VALIDATE("Product Group Code",'')
                  ELSE
                    VALIDATE("Product Group Code");
                END;
                */

            end;
        }
        field(5704; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group"."Code" WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(13712; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            //TableRelation = "Excise Prod. Posting Group"; //16225 TABLE N/F

            trigger OnValidate()
            var
                ItemUOM: Record "Item Unit of Measure";
                // ExciseProdPostingGrp: Record 13710; //16225 TABLE N/F
                ErrText01: Label 'Item Unit of Measure must be defined for %1 before Excise Product Posting Group %2 can be assigned.';
            begin
                //16225 TABLE N/F START
                /*IF "Excise Prod. Posting Group" <> '' THEN BEGIN
                  ExciseProdPostingGrp.GET("Excise Prod. Posting Group");
                  IF ExciseProdPostingGrp."Unit of Measure Code" <> '' THEN BEGIN
                    IF NOT ItemUOM.GET("No.",ExciseProdPostingGrp."Unit of Measure Code") THEN
                      ERROR(ErrText01,ExciseProdPostingGrp."Unit of Measure Code","Excise Prod. Posting Group")
                    ELSE
                      ItemUOM.TESTFIELD("Qty. per Unit of Measure");
                  END;
                END;*/
                //16225 TABLE N/F END
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
                //"HSN/SAC Code" := '';
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
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Type Code", DimensionValue.Code);
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      ((ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3")) THEN BEGIN
                        UserSetup.RESET;
                        IF UserSetup.GET(USERID) THEN
                            IF UserSetup."Allow TO Release" <> TRUE THEN
                                ERROR('You are not athorized to create item');
                        //MSAK
                        VALIDATE("Base Unit of Measure", 'SQ.MT');
                        VALIDATE("Sales Unit of Measure", 'CRT');
                        VALIDATE("Purch. Unit of Measure", 'CRT');
                        VALIDATE("Costing Method", "Costing Method"::Average);
                        VALIDATE("GST Credit", "GST Credit"::Availment);
                        VALIDATE("GST Group Code", 'GST28');
                        VALIDATE("Tax Group Code", 'TILES');
                        VALIDATE("Excise Accounting Type", "Excise Accounting Type"::"Without CENVAT");
                        VALIDATE("Default Transaction UOM", 'CRT');
                        //MSAK
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
                        VALIDATE("Plant Code"); //MSAK
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Type Code", "Type Code") THEN
                            "Type Name" := DimensionValue.Name;
                    END;
                END;

            end;
        }
        field(50001; "Type Catogery Code"; Code[2])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Type Catogery Code", DimensionValue.Code);
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
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
                        VALIDATE("Plant Code"); //MSAK
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Type Catogery Code", "Type Catogery Code") THEN
                            "Type Category Name" := DimensionValue.Name;
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;

            end;
        }
        field(50002; "Size Code"; Code[5])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Size Code", DimensionValue.Code);
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
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
                        //VALIDATE("Design Code"); //MSAK
                        VALIDATE("Plant Code"); //MSAK
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                            Description := "Size Name" + ' ' + DimensionValue.Name;
                        "Size Name" := DimensionValue.Name;
                    END;
                END;

            end;
        }
        field(50003; "Design Code"; Code[4])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Design Code", DimensionValue.Code);
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;
            end;

            trigger OnValidate()
            var
                Desc: Code[20];
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
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
                        IF DimensionValue.GET(InventorySetup."Design Code", "Design Code") THEN BEGIN
                            Description := "Size Name" + ' ' + DimensionValue.Name;
                            "Desgn Name" := DimensionValue.Name;

                        END;
                        //MSAK
                        VALIDATE("Plant Code"); //MSAK
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;

            end;
        }
        field(50004; "Color Code"; Code[4])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Color Code", DimensionValue.Code);
                    END;
                END;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
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
                        VALIDATE("Quality Code");//MSAK
                        VALIDATE("Plant Code"); //MSAK
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Color Code", "Color Code") THEN
                            "Color Name" := DimensionValue.Name;
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;

            end;
        }
        field(50005; "Packing Code"; Code[2])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN BEGIN
                            VALIDATE("Packing Code", DimensionValue.Code);
                            //VALIDATE("Packing Code Desc.",DimensionValue.Name);
                        END;
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
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
                        VALIDATE("Quality Code");//MSAK
                        VALIDATE("Plant Code"); //MSAK
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                            "Packing Name" := DimensionValue.Name;
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;

            end;
        }
        field(50006; "Quality Code"; Code[2])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Quality Code", DimensionValue.Code);
                    END;
                END;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
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
                        //TESTFIELD("Color Code");
                        //TESTFIELD("Packing Code");
                        //
                        InventorySetup.GET;
                        /*DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Type Code", "Type Code") THEN
                          "Description 2" := DimensionValue.Name;
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Type Catogery Code", "Type Catogery Code") THEN
                          "Description 2" := "Description 2"+ ' '+DimensionValue.Name;*/
                        InventorySetup.GET;

                        //MSAK as recommended by Laxman
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
                        IF DimensionValue.GET(InventorySetup."Quality Code", "Quality Code") THEN BEGIN
                            "Description 2" := "Description 2" + ' ' + DimensionValue.Name;
                            "Quality Name" := DimensionValue.Name;
                        END;
                        //MSAK
                        VALIDATE("Plant Code"); //MSAK
                    END;
                END;

                "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    "Plant Name" := DimensionValue.Name;

            end;
        }
        field(50007; "Plant Code"; Code[10])
        {

            trigger OnLookup()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        DimensionValue.FILTERGROUP(2);
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                        IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::DRA THEN
                            DimensionValue.SETRANGE(Code, 'D')
                        ELSE
                            IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::HSK THEN
                                DimensionValue.SETRANGE(Code, 'H')
                            ELSE
                                IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::SKD THEN
                                    DimensionValue.SETRANGE(Code, 'M')
                                ELSE
                                    IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::WZ THEN
                                        DimensionValue.SETRANGE(Code, 'W');
                        IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                            VALIDATE("Plant Code", DimensionValue.Code);
                    END;
                END;
            end;

            trigger OnValidate()
            begin
                ItemCreation.RESET;
                IF ItemCreation.GET(Rec."No.") THEN BEGIN
                    RecUserSetup.GET(ItemCreation."User ID");
                    IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (RecUserSetup."User ID" = USERID)) OR
                      (ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN

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

                        IF "Plant Code" = 'M' THEN BEGIN
                            VALIDATE("Item Category Code", 'M001');
                            VALIDATE("Inventory Posting Group", 'MANUF');
                            VALIDATE("Gen. Prod. Posting Group", 'MANUF');
                            VALIDATE("Group Code", '01');
                            VALIDATE("Replenishment System", "Replenishment System"::"Prod. Order");
                            VALIDATE("Excise Prod. Posting Group", 'GEN');
                            VALIDATE("Tax Group Code", 'TILES');
                            VALIDATE("Discount Group", Rec."Discount Group"::A);
                        END ELSE
                            IF "Plant Code" = 'D' THEN BEGIN
                                VALIDATE("Item Category Code", 'D001');
                                VALIDATE("Inventory Posting Group", 'MANUF');
                                VALIDATE("Gen. Prod. Posting Group", 'MANUF');
                                VALIDATE("Group Code", '01');
                                VALIDATE("Replenishment System", "Replenishment System"::"Prod. Order");
                                VALIDATE("Excise Prod. Posting Group", 'GEN');
                                VALIDATE("Tax Group Code", 'TILES');
                                VALIDATE("Discount Group", Rec."Discount Group"::A);
                            END ELSE
                                IF "Plant Code" = 'H' THEN BEGIN
                                    VALIDATE("Item Category Code", 'H001');
                                    VALIDATE("Inventory Posting Group", 'MANUF');
                                    VALIDATE("Gen. Prod. Posting Group", 'MANUF');
                                    VALIDATE("Group Code", '01');
                                    VALIDATE("Replenishment System", "Replenishment System"::"Prod. Order");
                                    VALIDATE("Excise Prod. Posting Group", 'GEN');
                                    VALIDATE("Tax Group Code", 'TILES');
                                    VALIDATE("Discount Group", Rec."Discount Group"::A);
                                END ELSE
                                    IF "Plant Code" = 'W' THEN BEGIN
                                        VALIDATE("Item Category Code", 'T001');
                                        VALIDATE("Inventory Posting Group", 'TRAD');
                                        VALIDATE("Gen. Prod. Posting Group", 'TRADING');
                                        VALIDATE("Group Code", '02');
                                        VALIDATE("Replenishment System", "Replenishment System"::Purchase);
                                        VALIDATE("Excise Prod. Posting Group", 'TRADE EXCI');
                                        VALIDATE("Tax Group Code", 'TILES');
                                    END;
                        //

                        "Item Code" := "Type Code" + "Type Catogery Code" + "Size Code" + "Design Code" + "Color Code" + "Packing Code" + "Quality Code" + "Plant Code";
                        InventorySetup.GET;
                        DimensionValue.RESET;
                        IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                            "Plant Name" := DimensionValue.Name;

                    END;
                END;
            end;
        }
        field(50008; "Item Classification"; Code[10])
        {
            TableRelation = "Item Classification";

            trigger OnValidate()
            begin
                /*
                IF "Item Classification" <> '' THEN BEGIN
                  ItemClassification.GET("Item Classification");
                  IF "Type Code" = '' THEN "Type Code":= ItemClassification."Type Code"   ;
                  IF "Type Catogery Code" = '' THEN  "Type Catogery Code" :=ItemClassification."Type Catogery Code" ;
                  IF "Size Code" = '' THEN "Size Code":=ItemClassification."Size Code" ;
                  IF "Design Code" = '' THEN "Design Code" :=ItemClassification."Design Code" ;
                  IF "Color Code" = '' THEN "Color Code" :=ItemClassification."Color Code" ;
                  IF "Packing Code" = '' THEN "Packing Code"  :=ItemClassification."Packing Code" ;
                  IF "Quality Code" = '' THEN "Quality Code" :=ItemClassification."Quality Code" ;
                  IF "Plant Code" = '' THEN "Plant Code" :=ItemClassification."Plant Code" ;
                  IF "Type Code" <> '' THEN VALIDATE("Type Code");
                  IF "Type Catogery Code" <> '' THEN VALIDATE("Type Catogery Code");
                  IF "Size Code" <> '' THEN VALIDATE("Size Code");
                  IF "Design Code" <> '' THEN VALIDATE("Design Code");
                  IF "Color Code" <> '' THEN VALIDATE("Color Code");
                  IF "Packing Code" <> '' THEN VALIDATE("Packing Code");
                  IF "Quality Code" <> '' THEN VALIDATE("Quality Code");
                  IF "Plant Code" <> '' THEN VALIDATE("Plant Code");
                END;
                */
                IF "Item Classification" = '' THEN
                    VALIDATE("List Price", 0)
                ELSE
                    VALIDATE("List Price", GetListPrice());

            end;
        }
        field(50034; "Group Code"; Code[3])
        {
            TableRelation = "Item Group";

            trigger OnValidate()
            begin

                IF ITemGRp.GET("Group Code") THEN
                    "Group code Desc" := ITemGRp.Description
                ELSE
                    "Group code Desc" := '';
            end;
        }
        field(50036; COGS; Decimal)
        {

            trigger OnValidate()
            begin
                VALIDATE("Variable & Semi Variable Cost", COGS + SV)
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
        field(50150; "Net Margin"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE("Net Margin %", "Net Margin" / ASP);
            end;
        }
        field(50151; "Net Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50152; FC; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE("Net Margin", "Gross Margin" - FC);
                "Gross Margin" := ASP - "Variable & Semi Variable Cost"
            end;
        }
        field(50153; SV; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE("Variable & Semi Variable Cost", COGS + SV);
                "Gross Margin" := ASP - ("Variable & Semi Variable Cost");
            end;
        }
        field(50160; "List Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50170; AD; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE(ASP, "List Price" - AD);
                "Gross Margin" := ASP - "Variable & Semi Variable Cost"
            end;
        }
        field(50180; ASP; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE("Gross Margin", ASP - "Variable & Semi Variable Cost");
            end;
        }
        field(50190; "Gross Margin"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE("Gross Margin %", "Gross Margin" / ASP);
                //VALIDATE("Net Margin","Gross Margin" - FC);
                VALIDATE("Net Margin", "Gross Margin");
                "Gross Margin" := ASP - "Variable & Semi Variable Cost"
            end;
        }
        field(50191; "Gross Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50195; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50196; "Variable & Semi Variable Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Default Transaction UOM"; Code[10])
        {
        }
        field(60005; "Default Prod. Plant Code"; Code[10])
        {
            TableRelation = Location."Code" WHERE("Use As In-Transit" = FILTER(false));
        }
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value"."Code" WHERE("Dimension Code" = FILTER('SCHEMECODE'));
        }
        field(60054; "Scheme Group"; Code[20])
        {
            TableRelation = "Dimension Value"."Code" WHERE("Dimension Code" = CONST('SCHEMEGROUP'));
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
            begin
                UserSetup.RESET;
                UserSetup.SETFILTER(UserSetup."User ID", "User ID");
                IF UserSetup.FIND('-') THEN BEGIN
                    UserSetup.TESTFIELD("Item Authorization HSK 1");
                    UserSetup.TESTFIELD("Item Authorization 2");
                    UserSetup.TESTFIELD("Item Authorization 3");
                END;
            end;
        }
        field(99005; "Created Date"; Date)
        {
        }
        field(99006; "Authorization  Date"; Date)
        {
            Editable = false;
        }
        field(99007; "Authorization Time"; Time)
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
        field(99014; "Line No."; Integer)
        {
        }
        field(99015; "Type Name"; Text[30])
        {
        }
        field(99016; "Type Category Name"; Text[30])
        {
        }
        field(99017; "Size Name"; Text[30])
        {
        }
        field(99018; "Desgn Name"; Text[30])
        {
        }
        field(99019; "Color Name"; Text[30])
        {
        }
        field(99020; "Packing Name"; Text[30])
        {
        }
        field(99021; "Quality Name"; Text[30])
        {
        }
        field(99022; "Plant Name"; Text[30])
        {
        }
        field(99023; "Authorization 3"; Code[50])
        {
        }
        field(99024; CEO; Code[10])
        {
        }
        field(99025; IT; Code[10])
        {
        }
        field(99026; "Authorization 3 Approval Date"; Date)
        {
        }
        field(99027; "Authorization 3 Approval Time"; Time)
        {
        }
        field(99028; "CEO Approval Date"; Date)
        {
        }
        field(99029; "CEO Approval Time"; Time)
        {
        }
        field(99030; "IT Approval Date"; Date)
        {
        }
        field(99031; "IT Approval Time"; Time)
        {
        }
        field(99032; "Group code Desc"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    trigger OnInsert()
    begin
        "Created Date" := TODAY;
        CheckAuthorisedUser();
        GetItemCreation();
        IF Status = Status::" " THEN
            VALIDATE("User ID", USERID) //MSAK
        ELSE
            TESTFIELD(Status, Status::" ");
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
        UserSetup: Record "User Setup";
        ItemCreation: Record "Item Creation";
        RecUserSetup: Record "User Setup";
        UnthorisedUserErr: Label 'You are not Authorised to create Item !!!';

    local procedure GetItemCreation()
    begin
        ItemCreation.GET(Rec."No.");
    end;

    local procedure GetListPrice(): Decimal
    var
        SalesPrice: Record "Item Sales Price1";
    begin
        TESTFIELD("Plant Code");
        TESTFIELD("Item Category Code");

        SalesPrice.RESET();
        SalesPrice.SETCURRENTKEY("Starting Date");
        SalesPrice.SETFILTER("Item Classification No.", Rec."Item Classification");
        SalesPrice.SETRANGE("Unit of Measure Code", 'SQ.MT');
        IF "Item Category Code" = 'T001' THEN
            SalesPrice.SETRANGE("Sales Code", 'WZ_D')
        ELSE
            IF "Item Category Code" = 'M001' THEN
                SalesPrice.SETRANGE("Sales Code", 'SKD_D')
            ELSE
                IF "Item Category Code" = 'D001' THEN
                    SalesPrice.SETRANGE("Sales Code", 'DRA_D')
                ELSE
                    IF "Item Category Code" = 'H001' THEN
                        SalesPrice.SETRANGE("Sales Code", 'HSK_D');

        SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, "Created Date");
        SalesPrice.SETRANGE("Starting Date", 0D, "Created Date");
        SalesPrice.SETASCENDING("Starting Date", TRUE);
        IF SalesPrice.FINDLAST THEN
            EXIT(SalesPrice."Unit Price");
    end;

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

    local procedure CheckAuthorisedUser()
    begin
        ItemCreation.GET(Rec."No.");
        IF USERID <> ItemCreation."User ID" THEN
            ERROR(UnthorisedUserErr);
    end;

    local procedure CheckOperationUnit()
    begin
        GetItemCreation();
        ItemCreation.TESTFIELD("Operation unit");
    end;
}

