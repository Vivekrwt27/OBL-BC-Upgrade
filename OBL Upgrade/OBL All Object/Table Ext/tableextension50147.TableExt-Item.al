tableextension 50147 tableextension50147 extends Item
{

    fields
    {
        modify("Base Unit of Measure")
        {

            trigger OnAfterValidate()
            begin
                Validate("Base Unit Of Measure New", "Base Unit of Measure");
            end;
        }
        modify(Description)// 15578
        {
            trigger OnAfterValidate()
            begin
                IF STRLEN(Description) > 30 THEN
                    ERROR('Length of Description Should not be more than 30');

            end;
        }
        modify("Description 2")// 15578
        {
            trigger OnAfterValidate()
            begin
                IF STRLEN("Description 2") > 30 THEN
                    ERROR('Length of Description Should not be more than 30');

            end;
        }


        modify(type)// 15578 
        {
            trigger OnAfterValidate()
            begin
                IF Type = Type::Service THEN
                    VALIDATE("Costing Method", "Costing Method"::Average);
            end;
        }


        modify("Gross Weight")// 15578
        {
            trigger OnBeforeValidate()
            begin
                //Vipul Tri1.0 Start
                IUOM.SETFILTER(IUOM."Item No.", '%1', "No.");
                IF IUOM.FIND('-') THEN
                    REPEAT
                        IUOM.Weight := IUOM."Qty. per Unit of Measure" * "Gross Weight";
                        IUOM.MODIFY;
                    UNTIL IUOM.NEXT = 0;
                //Vipul Tri1.0 end

            end;
        }
        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            begin
            end;
        }



        field(50000; "Type Code"; Code[2])
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
                IF Dimension.GET(27, "No.", InventorySetup."Type Code") THEN BEGIN
                    IF "Type Code" = '' THEN
                        Dimension.DELETE ELSE BEGIN
                        Dimension.VALIDATE(Dimension."Dimension Value Code", "Type Code");
                        ModifyDimension;
                    END;
                END ELSE BEGIN
                    Dimension.INIT;
                    Dimension.VALIDATE(Dimension."Dimension Code", InventorySetup."Type Code");
                    Dimension.VALIDATE(Dimension."Dimension Value Code", "Type Code");
                    InsertDimension;
                END;
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Type Code", "Type Code") THEN
                    VALIDATE("Type Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Type Code Desc.", '');
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Type Catogery Code", "Type Catogery Code") THEN
                    VALIDATE("Type Category Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Type Category Code Desc.", '')
            end;
        }
        field(50002; "Size Code"; Code[3])
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                    VALIDATE("Size Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Size Code Desc.", '')
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Design Code", "Design Code") THEN
                    VALIDATE("Design Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Design Code Desc.", '');
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Color Code", "Color Code") THEN
                    VALIDATE("Color Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Color Code Desc.", '');
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
                    VALIDATE("Packing Code Desc.", DimensionValue.Name);
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                    VALIDATE("Packing Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Packing Code Desc.", '');
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Quality Code", "Quality Code") THEN
                    VALIDATE("Quality Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Quality Code Desc.", '');
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
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                    VALIDATE("Plant Code Desc.", DimensionValue.Name)
                ELSE
                    VALIDATE("Plant Code Desc.", '');
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
        field(50009; "Type Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50010; "Type Category Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50011; "Size Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50012; "Design Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50013; "Color Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50014; "Packing Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50015; "Quality Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50016; "Plant Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50017; "Manufacturer Name"; Text[25])
        {
            Editable = false;
        }
        field(50018; "Warehouse Entry"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                "Location Code" = FIELD("Location Filter")));
            FieldClass = FlowField;
        }
        field(50019; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            FieldClass = FlowFilter;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(50021; "SalesQty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = CONST(Sale),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FILTER(<> ''),
                                                                         "Item No." = FIELD("No."),
                                                                         "Location Code" = FIELD("Location Filter")));
            FieldClass = FlowField;
        }
        field(50022; "ProductionQty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = filter(Output | Consumption),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FILTER(<> ''),
                                                                         "Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50023; "TransferQty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = CONST(Transfer),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         InTransit = CONST(false),
                                                                         "Qty in Sq.Mt." = FILTER(< 0),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "External Transfer" = CONST(true),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FILTER(<> ''),
                                                                         "Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50024; BalaceQty; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Item No." = FIELD("No."),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Entry Type" = FIELD("Entry Type"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "Size Code" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(50025; "Inventory Change"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FIELD("Entry Type"),
                                                                  InTransit = CONST(false),
                                                                  Quantity = FIELD("ILE Quantity")));
            Caption = 'Inventory Change';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "ILE Quantity"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(50027; "balance at date"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FIELD("Entry Type")));
            FieldClass = FlowField;
        }
        field(50028; EntryTypeOT; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FILTER('Output|Transfer'),
                                                                  Quantity = FILTER(> 0)));
            Caption = 'EntryTypeOT';
            DecimalPlaces = 0 : 5;
            Description = 'TRI H.B 12.04.06 - Flow Filter For Entry Type Equal to Output or Transfer, rest of all same as Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; EntryTypeST; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FILTER('Sale|Transfer'),
                                                                  Quantity = FILTER(< 0)));
            Caption = 'EntryTypeST';
            DecimalPlaces = 0 : 5;
            Description = 'TRI H.B 12.04.06 - Flow Filter For Entry Type Equal to Sale or transfer, rest of all same as Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Item Category Desc."; Text[60])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Description = 'Tri56.1 PG 15112006 -- Desc. Req. In Item List';
            FieldClass = FlowField;
        }
        field(50031; "Product Group Desc."; Text[30])
        {
            // 15578 CalcFormula = Lookup("Product Group".Description WHERE (Code=FIELD("Product Group Code")));
            Description = 'Tri56.1 PG 15112006 -- Desc. Req. In Item List';
            // FieldClass = FlowField;
        }
        field(50032; "Ex-Factory Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE(Type = CONST(Item),
                                                                 "No." = FIELD("No."),
                                                                 "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                 "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                 "Location Code" = FIELD("Location Filter"),
                                                                 "Posting Date" = FIELD("Date Filter")));
            Description = 'Tri PG 03042007';
            FieldClass = FlowField;
        }
        field(50033; "Excise Amount"; Decimal)
        {
            /*  CalcFormula = Sum("Sales Invoice Line"."Excise Amount" WHERE (Type=CONST(Item),
                                                                            "No."=FIELD("No."),
                                                                            "Shortcut Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code"=FIELD("Location Filter"),
                                                                            "Posting Date"=FIELD("Date Filter")));*/ // 15578
            Description = 'Tri PG 03042007';
            // FieldClass = FlowField;
        }
        field(50034; "Group Code"; Code[3])
        {
            TableRelation = "Item Group";

            trigger OnValidate()
            begin
                IF ItemGrp.GET("Group Code") THEN
                    "Group code Desc" := ItemGrp.Description
                ELSE
                    "Group code Desc" := '';
            end;
        }
        field(50035; "Group code Desc"; Text[50])
        {
            Description = 'tri LM 100308';
            Editable = false;
        }
        field(50036; COGS; Decimal)
        {
            Description = 'S.B. for Inserting value of Good sold manually 200508';
        }
        field(50037; "COGS Effective Date"; Date)
        {
            Description = 'S.B. for inserting effective date of COGS manually 200508';
        }
        field(50038; "Indent Blocked"; Boolean)
        {
            Description = 'TRI A.S 28.05.08';
        }
        field(50039; "Purchase Blocked"; Boolean)
        {
            Description = 'TRI A.S 28.05.08';
        }
        field(50040; Premium; Boolean)
        {
            Description = 'TRI S.R 170210 - New field Add';

            trigger OnValidate()
            begin
                IF ("Plant Code" <> 'D') AND ("Plant Code" <> 'M') AND ("Plant Code" <> 'H') AND ("Plant Code" <> 'W') THEN//MSBS.Rao dt. 06-07-12
                    TESTFIELD("Plant Code", 'D,M,H');//MSBS.Rao dt. 06-07-12

                TESTFIELD("Quality Code", '1');
            end;
        }
        field(50041; Commercial; Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add';

            trigger OnLookup()
            begin
                //TRI S.R 240310 - New code Add Start
                IF Premium AND ("Plant Code" = 'D') OR ("Plant Code" = 'M') OR ("Plant Code" = 'H') THEN BEGIN
                    FilterSet := '';
                    //FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'2H';
                    //MSBS.Rao Begin dt. 06-07-12
                    IF ("Plant Code" = 'D') THEN
                        FilterSet := COPYSTR("No.", 1, STRLEN("No.") - 2) + '2D';
                    IF ("Plant Code" = 'M') THEN
                        FilterSet := COPYSTR("No.", 1, STRLEN("No.") - 2) + '2M';
                    IF ("Plant Code" = 'H') THEN
                        FilterSet := COPYSTR("No.", 1, STRLEN("No.") - 2) + '2H';
                    //MSBS.Rao End dt. 06-07-12
                    RecfilterItem.RESET;
                    RecfilterItem.SETFILTER("No.", '%1', FilterSet);
                    RecfilterItem.SETRANGE(Premium, FALSE);
                    IF RecfilterItem.FIND('-') THEN BEGIN
                        IF PAGE.RUNMODAL(0, RecfilterItem) = ACTION::LookupOK THEN
                            Commercial := RecfilterItem."No.";
                    END;
                END;
                //TRI S.R 240310 - New code Add Start
            end;
        }
        field(50042; Economic; Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add';

            trigger OnLookup()
            begin
                //TRI S.R 240310 - New code Add Start
                IF Premium AND ("Plant Code" = 'D') OR ("Plant Code" = 'M') OR ("Plant Code" = 'H') THEN//MSBS.Rao dt. 06-07-12
                BEGIN
                    FilterSet := '';
                    //FilterSet := COPYSTR("No.",1,STRLEN("No.") -2)+'3D';
                    //MSBS.Rao Begin dt. 06-07-12
                    IF ("Plant Code" = 'D') THEN
                        FilterSet := COPYSTR("No.", 1, STRLEN("No.") - 2) + '3D';
                    IF ("Plant Code" = 'M') THEN
                        FilterSet := COPYSTR("No.", 1, STRLEN("No.") - 2) + '3M';
                    IF ("Plant Code" = 'H') THEN
                        FilterSet := COPYSTR("No.", 1, STRLEN("No.") - 2) + '3H';
                    //MSBS.Rao End dt. 06-07-12

                    RecfilterItem.RESET;
                    RecfilterItem.SETFILTER("No.", '%1', FilterSet);
                    RecfilterItem.SETRANGE(Premium, FALSE);
                    IF RecfilterItem.FIND('-') THEN BEGIN
                        IF PAGE.RUNMODAL(0, RecfilterItem) = ACTION::LookupOK THEN
                            Economic := RecfilterItem."No.";
                    END;
                END;
                //TRI S.R 240310 - New code Add Start
            end;
        }
        field(50043; "Broken Tiles"; Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add';
            TableRelation = Item."No.";
        }
        field(50044; "Indent Quantity"; Decimal)
        {
            CalcFormula = Sum("Indent Line".Quantity WHERE(Type = FILTER(Item),
                                                            "No." = FIELD("No."),
                                                            "Location Code" = FIELD("Location Filter"),
                                                            "Due Date" = FIELD("Date Filter"),
                                                            Deleted = FILTER(false),
                                                            Status = FILTER(<> Closed),
                                                            "Order No." = FILTER('')));
            Description = 'TRI S.R 170210 - New field Add';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50050; "Indirect Consumption Item"; Boolean)
        {
            Description = 'TRI S.R 170210 - New field Add';
        }
        field(50052; "New Item No."; Code[20])
        {
            Editable = false;
        }
        field(50053; "ABC Analysis"; Code[20])
        {
            Description = 'Ori Ut 060810';
        }
        field(50054; "Created ID"; Code[20])
        {
            Description = 'Ori Ut 060810';
            Editable = false;
        }
        field(50055; "Created Date"; Date)
        {
            Description = 'Ori Ut 060810';
            Editable = false;
        }
        field(50056; "Last Modified ID"; Code[50])
        {
            Description = 'Ori Ut 060810';
            Editable = false;
        }
        field(50057; Retained; Boolean)
        {
            Description = 'Ori Ut 270611';
        }
        field(50058; "Create for Orient"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50059; "Create for Bell"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50100; "Complete Description"; Text[110])
        {
        }
        field(50126; "Discount Group"; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(50127; "Manuf. Strategy"; Option)
        {
            Description = 'Kulbhushan Field for to know the production purpose';
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO,Non Retain - Ex';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO,"Non Retain - Ex";
        }
        field(50128; "Sample Code"; Code[20])
        {
        }
        field(50129; Layer; Decimal)
        {
        }
        field(50130; NPD; Text[20])
        {
        }
        field(50131; "NPD Sub"; Text[25])
        {
            Description = 'For Marketting Dashboard';
            Enabled = false;
        }
        field(50132; "Tableau Product Group"; Text[10])
        {
        }
        field(50133; Liquidaton; Boolean)
        {
        }
        field(50134; "Discount Comments"; Text[20])
        {
        }
        field(50135; "Layer Per Pallate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50136; "Box Per Layer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Inventory In SQMT"; Decimal)
        {
            Editable = false;
            Enabled = false;
        }
        field(60002; "Inventory In CRT"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty In Carton" WHERE("Item No." = FIELD("No."),
                                                                         "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                         "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                         "Variant Code" = FIELD("Variant Filter"),
                                                                         "Lot No." = FIELD("Lot No. Filter"),
                                                                         "Serial No." = FIELD("Serial No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "Default Transaction UOM"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(60004; "Transfer Order Blocked"; Boolean)
        {
            Description = 'TRI A.S 28.05.08';
        }
        field(60005; "Default Prod. Plant Code"; Code[10])
        {
            Description = 'TRI S.R 040610';
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(60006; "Inventory At Plant location"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FILTER('PLANT'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60009; Blocked2; Boolean)
        {
            Caption = 'Blocked';
        }
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHEMECODE'));
        }
        field(60031; "V. Cost"; Decimal)
        {
            Description = 'Cost By Anuj';
        }
        field(60032; Body; Text[15])
        {
        }
        field(60040; "End Use Item"; Boolean)
        {
        }
        field(60041; "Minimum Inventory"; Decimal)
        {
        }
        field(60046; "N.R.V"; Decimal)
        {
        }
        field(60047; "Old Code"; Code[20])
        {
        }
        field(60048; "Shelf Location HSK"; Text[20])
        {
        }
        field(60049; "Shelf Location Dra"; Text[20])
        {
        }
        field(60050; "Hide Items"; Boolean)
        {
            Description = 'For OBL Executive Hide Items';
        }
        field(60052; Tariff; Text[10])
        {
        }
        field(60053; "Size Description"; Text[39])
        {
        }
        field(60054; "Scheme Group"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SCHEMEGROUP'));
        }
        field(60055; "Prod. Consumption Item"; Code[20])
        {
            TableRelation = Item."No." WHERE(Blocked = CONST(false),
                                            "Item Category Code" = FIELD("Item Category Code"),
                                            "Inventory Posting Group" = FIELD("Inventory Posting Group"));
        }
        field(60056; "Sample Group"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60058; "Type Group Code"; Code[12])
        {
            DataClassification = ToBeClassified;
            Description = 'Free';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('TYPEGROUP'));
        }
        field(60059; "Production Group"; Code[12])
        {
            DataClassification = ToBeClassified;
            Description = 'CEO Report';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('TYPEGROUP'));
        }
        field(60060; "OBTB Focused Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'OBTB Dashboard';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('OBTBFOCUS'));
        }
        field(60061; "Goal Sheet Focused Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Goal Sheet Focused Product';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('GOALSHEET'));
        }
        field(60062; "Sales Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60063; "Non Focused Product"; Code[12])
        {
            DataClassification = ToBeClassified;
            Description = 'Darpan';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('NON FOCUS'));
        }
        field(60065; WDM; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(85001; "Base Unit Of Measure New"; Code[20])
        {
            Caption = 'Base Unit Of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            trigger OnValidate()
            begin

            end;

        }
    }
    keys
    {
        key(Key20; "Item Category Code")
        {
        }
        key(Key21; "Size Code", "Packing Code")
        {
        }
        key(Key22; "Size Code", "Type Code", "Design Code")
        {
        }
        key(Key23; "Plant Code", "Size Code")
        {
        }
        key(Key24; "Plant Code", "Size Code", "Packing Code")
        {
        }
        key(Key25; "Design Code")
        {
        }
        key(Key26; "Quality Code", "Size Code")
        {
        }
        key(Key27; "Size Code", "Quality Code")
        {
        }
        key(Key28; "Type Code")
        {
        }
        key(Key29; "Default Prod. Plant Code", "Size Code", "Packing Code")
        {
        }
    }

    trigger OnAfterDelete()
    begin
        //mo tri1.0 Customization no.64 start
        GLSetup.GET;
        IF DimValue.GET(GLSetup."Item Dimension Code", "No.") THEN BEGIN
            DimValue.DELETE;
        END;

        IF DefDim.GET(27, "No.", GLSetup."Item Dimension Code") THEN BEGIN
            DefDim.DELETE;
        END;
        //mo tri1.0 Customization no.64 end

    end;

    trigger OnInsert()
    begin
        "Created ID" := USERID;
        "Created Date" := TODAY;
    end;

    trigger OnAfterInsert()
    begin
        //To add the generated customer no. as dimension value.
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Item Dimension Code");
        IF NOT DimValue.GET(GLSetup."Item Dimension Code", "No.") THEN BEGIN
            DimValue.INIT;
            DimValue.VALIDATE("Dimension Code", GLSetup."Item Dimension Code");
            DimValue.VALIDATE(Code, "No.");
            DimValue.VALIDATE(Name, "No.");
            DimValue.INSERT;
        END;

        //To add the dimension value as default dimension
        IF NOT DefDim.GET(27, "No.", GLSetup."Item Dimension Code") THEN BEGIN
            DefDim.INIT;
            DefDim."Table ID" := 27;
            DefDim."No." := "No.";
            DefDim."Dimension Code" := GLSetup."Item Dimension Code";
            DefDim."Dimension Value Code" := DimValue.Code;
            DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
            //DefDim."Table Name" := TABLENAME;    code blocked for upgradation
            DefDim.INSERT;
        END;
        //mo tri1.0 Customization no.64 end


        "Created ID" := USERID;
        "Created Date" := TODAY;
        "Costing Method" := "Costing Method"::Average; //MSKS


    end;

    trigger OnAfterModify()
    begin
        "Last Modified ID" := USERID;

        //mo tri1.0 customization no. 64 start
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Item Dimension Code");
        IF DimValue.GET(GLSetup."Item Dimension Code", "No.") THEN BEGIN
            DimValue.VALIDATE(Name, Description);
            DimValue.MODIFY;
        END;
        //mo tri1.0 customization no. 64 end

    end;

    trigger OnAfterRename()
    begin
        "Last Modified ID" := USERID;

        //mo tri1.0 Customization no.64 start
        //To add the generated customer no. as dimension value.
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Item Dimension Code");
        IF DimValue.GET(GLSetUp."Item Dimension Code", xRec."No.") THEN
            DimValue.DELETE;

        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetUp."Item Dimension Code");
        DimValue.VALIDATE(Code, "No.");
        DimValue.VALIDATE(Name, "No.");
        DimValue.INSERT;

        //To add the dimension value as default dimension
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Item Dimension Code");
        IF DefDim.GET(27, xRec."No.", GLSetUp."Item Dimension Code") THEN
            DefDim.DELETE;

        DefDim.INIT;
        DefDim."Table ID" := 27;
        DefDim."No." := "No.";
        DefDim."Dimension Code" := GLSetUp."Item Dimension Code";
        DefDim."Dimension Value Code" := DimValue.Code;
        DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
        //DefDim."Table Name" := TABLENAME;      code blocked for upgradation
        DefDim.INSERT;
        //mo tri1.0 Customization no.64 end

    end;

    procedure ModifyDimension()
    begin
        Dimension.VALIDATE(Dimension."Value Posting", Dimension."Value Posting"::"Same Code");
        Dimension.MODIFY;
    end;

    procedure InsertDimension()
    begin
        Dimension.VALIDATE(Dimension."Table ID", 27);
        Dimension.VALIDATE(Dimension."No.", "No.");
        Dimension.VALIDATE(Dimension."Value Posting", Dimension."Value Posting"::" ");
        Dimension.INSERT(TRUE);
    end;

    procedure UomToSqm("ItemNo.": Code[20]; CurrentUOM: Code[10]; Qty: Decimal): Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
    begin
        IF CurrentUOM <> '' THEN BEGIN

            QtyPerC := 0;
            QtyPerU := 0;

            InventorySetup.GET;
            ItemUnitOfMeasure.RESET;
            ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure."Item No.", "ItemNo.");
            ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure.Code, InventorySetup."Unit of Measure for Sq. Mt.");
            IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                QtyPerC := ItemUnitOfMeasure."Qty. per Unit of Measure";
                ItemUnitofMeasure1.RESET;
                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "ItemNo.");
                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, CurrentUOM);
                IF ItemUnitofMeasure1.FIND('-') THEN
                    QtyPerU := ItemUnitofMeasure1."Qty. per Unit of Measure";
                SqMt := (Qty * QtyPerU) / QtyPerC;
            END;
            EXIT(ROUND(SqMt, 0.00001, '='));
        END;
    end;

    procedure UomToCart("ItemNo.": Code[20]; CurrentUOM: Code[10]; Qty: Decimal) Cart: Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
    begin
        IF CurrentUOM <> '' THEN BEGIN
            InventorySetup.GET;
            ItemUnitOfMeasure.RESET;
            ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure."Item No.", "ItemNo.");
            ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure.Code, InventorySetup."Unit of Measure for Carton");
            IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                QtyPerC := ROUND(ItemUnitOfMeasure."Qty. per Unit of Measure", 0.00001, '=');
                ItemUnitofMeasure1.RESET;
                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "ItemNo.");
                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, CurrentUOM);
                IF ItemUnitofMeasure1.FIND('-') THEN
                    QtyPerU := ROUND(ItemUnitofMeasure1."Qty. per Unit of Measure", 0.00001, '=');
                Cart := (Qty * QtyPerU) / QtyPerC;
            END;
            EXIT(ROUND(Cart, 1, '='));
        END;
    end;

    procedure UomToWeight("ItemNo.": Code[20]; CurrentUOM: Code[10]; Qty: Decimal) Weight: Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
    begin
        IF CurrentUOM <> '' THEN BEGIN
            ItemUnitofMeasure1.RESET;
            ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "ItemNo.");
            ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, CurrentUOM);
            IF ItemUnitofMeasure1.FIND('-') THEN
                Weight := (Qty * ItemUnitofMeasure1.Weight);

            EXIT(Weight);
        END;
    end;

    procedure UomToNetWeight("ItemNo.": Code[20]; CurrentUOM: Code[10]; Qty: Decimal) Weight: Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
        Itemrec: Record Item;
    begin
        IF CurrentUOM <> '' THEN BEGIN
            Itemrec.GET("ItemNo.");
            ItemUnitofMeasure1.RESET;
            ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "ItemNo.");
            ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, CurrentUOM);
            IF ItemUnitofMeasure1.FIND('-') THEN
                IF Itemrec."Gross Weight" <> 0 THEN
                    Weight := (Qty * ItemUnitofMeasure1.Weight) * Itemrec."Net Weight" / Itemrec."Gross Weight";

            EXIT(Weight);
        END;
    end;

    procedure UomToPcs("ItemNo.": Code[20]; CurrentUOM: Code[10]; Qty: Decimal) Pcs: Decimal
    var
        QtyPerP: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
    begin
        //-- 1. Tri30.0 PG 14112006 -- New Function Added "UomToPcs" -- Start
        IF CurrentUOM <> '' THEN BEGIN
            InventorySetup.GET;
            ItemUnitOfMeasure.RESET;
            ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure."Item No.", "ItemNo.");
            ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure.Code, InventorySetup."Unit of Measure for Pieces");
            IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                QtyPerP := ItemUnitOfMeasure."Qty. per Unit of Measure";
                ItemUnitofMeasure1.RESET;
                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "ItemNo.");
                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, CurrentUOM);
                IF ItemUnitofMeasure1.FIND('-') THEN
                    QtyPerU := ItemUnitofMeasure1."Qty. per Unit of Measure";
                IF QtyPerP <> 0 THEN
                    Pcs := (Qty * QtyPerU) / QtyPerP;
            END;
            EXIT(Pcs);
        END;
        //-- 1. Tri30.0 PG 14112006 -- New Function Added "UomToPcs" -- Stop
    end;

    procedure UomToGrossWeight("ItemNo.": Code[20]; CurrentUOM: Code[10]; Qty: Decimal) Weight: Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
        Itemrec: Record Item;
    begin
        IF CurrentUOM <> '' THEN BEGIN
            Itemrec.GET("ItemNo.");
            ItemUnitofMeasure1.RESET;
            ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "ItemNo.");
            ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, CurrentUOM);
            IF ItemUnitofMeasure1.FIND('-') THEN
                IF Itemrec."Net Weight" <> 0 THEN
                    Weight := (Qty * ItemUnitofMeasure1.Weight) * Itemrec."Gross Weight" / Itemrec."Net Weight";
            EXIT(Weight);
        END;
    end;

    procedure "--MIPL,MSBS.Rao---"()
    begin
    end;

    procedure CreateForBell(RecItemMaster: Record Item; DocumentNO: Code[20])
    var
        RecItem: Record Item;
        ToCompany: Text[50];
        ItemCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecItem DO BEGIN
            // IF COMPANYNAME ='Orient Bell Ceramics (Master)'THEN  BEGIN   //MSNK BLOCK 230315
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN  //MSNK 230315
                                                               //ToCompany :='Bell Ceramics Ltd.';  //MSNK BLOCK 230315
                ToCompany := 'Orient Bell Limited'; //MSNK 230315
                ItemCode := RecItem."No.";
                RecItem.CHANGECOMPANY(ToCompany);
                IF NOT RecItem.GET(ItemCode) THEN BEGIN
                    RecItem.TRANSFERFIELDS(Rec);
                    RecItem.INSERT;
                END;
                RecItemMaster.RESET;
                RecItemMaster.SETRANGE("No.", DocumentNO);
                IF RecItemMaster.FINDFIRST THEN BEGIN
                    RecItemMaster."Create for Bell" := TRUE;
                    RecItemMaster.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForOrient(RecItemMaster: Record Item; DocumentNO: Code[20])
    var
        RecItem: Record Item;
        ToCompany: Text[50];
        ItemCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecItem DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                ItemCode := RecItem."No.";
                RecItem.CHANGECOMPANY(ToCompany);
                IF NOT RecItem.GET(ItemCode) THEN BEGIN
                    RecItem.TRANSFERFIELDS(Rec);
                    RecItem.INSERT;
                END;
                RecItemMaster.RESET;
                RecItemMaster.SETRANGE("No.", DocumentNO);
                IF RecItemMaster.FINDFIRST THEN BEGIN
                    RecItemMaster."Create for Orient" := TRUE;
                    RecItemMaster.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForAll(RecItemMaster: Record Item; DocumentNO: Code[20])
    var
        RecItem: Record Item;
        ToCompany: Text[50];
        RecCompany: Record Company;
        ItemCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecItem DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                IF RecCompany.FINDFIRST THEN BEGIN
                    REPEAT
                        ToCompany := RecCompany.Name;
                        ItemCode := RecItem."No.";
                        RecItem.CHANGECOMPANY(ToCompany);
                        IF NOT RecItem.GET(ItemCode) THEN BEGIN
                            RecItem.TRANSFERFIELDS(Rec);
                            RecItem.INSERT;
                        END;
                    UNTIL RecCompany.NEXT = 0;
                END;
                RecItemMaster.RESET;
                RecItemMaster.SETRANGE("No.", DocumentNO);
                IF RecItemMaster.FINDFIRST THEN BEGIN
                    RecItemMaster."Create for Orient" := TRUE;
                    RecItemMaster."Create for Bell" := TRUE;
                    RecItemMaster.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CopyItem(RecItem: Record Item; NewCode: Code[20])
    var
        ToItemCompany: Record Item;
        FromItemUOM: Record "Item Unit of Measure";
        ToItemUOM: Record "Item Unit of Measure";
        TodefDim: Record "Default Dimension";
        FromdefDim: Record "Default Dimension";
    begin
        IF NOT ToItemCompany.GET(NewCode) THEN BEGIN
            ToItemCompany.TRANSFERFIELDS(RecItem);
            ToItemCompany."No." := NewCode;
            // 15578  ToItemCompany."Product Group Code" := '';
            ToItemCompany."Item Category Code" := '';
            ToItemCompany.INSERT;
            FromItemUOM.RESET;
            FromItemUOM.SETRANGE("Item No.", RecItem."No.");
            IF FromItemUOM.FINDFIRST THEN BEGIN
                REPEAT
                    ToItemUOM.RESET;
                    IF NOT ToItemUOM.GET(NewCode, FromItemUOM.Code) THEN BEGIN
                        ToItemUOM.TRANSFERFIELDS(FromItemUOM);
                        ToItemUOM."Item No." := NewCode;
                        ToItemUOM.INSERT;
                    END;
                UNTIL FromItemUOM.NEXT = 0;
            END;
        END;
        TodefDim.RESET;
        TodefDim.SETRANGE("Table ID", 27);
        TodefDim.SETRANGE("No.", NewCode);
        IF NOT TodefDim.FINDFIRST THEN BEGIN
            FromdefDim.RESET;
            FromdefDim.SETRANGE("Table ID", 27);
            FromdefDim.SETRANGE(FromdefDim."No.", RecItem."No.");
            IF FromdefDim.FINDFIRST THEN BEGIN
                REPEAT
                    TodefDim.INIT;
                    TodefDim.TRANSFERFIELDS(FromdefDim);
                    IF FromdefDim."Dimension Value Code" = RecItem."No." THEN
                        TodefDim."Dimension Value Code" := NewCode;
                    TodefDim."No." := NewCode;
                    TodefDim.INSERT;
                UNTIL FromdefDim.NEXT = 0;
            END;
        END;
    end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    var
        "...tri1.0": Integer;
        DefDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        ItemClassification: Record "Item Classification";
        Dimension: Record "Default Dimension";
        SqMt: Decimal;
        IUOM: Record "Item Unit of Measure";
        ItemGrp: Record "Item Group";
        FilterSet: Code[50];
        RecfilterItem: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemCategory: Record "Item Category";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
}

