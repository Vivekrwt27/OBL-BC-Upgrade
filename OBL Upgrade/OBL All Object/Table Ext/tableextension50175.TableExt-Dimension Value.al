tableextension 50175 tableextension50175 extends "Dimension Value"
{
    // TRI CA New field created 50021(Cover Under Daily MIS)
    fields
    {
        modify(Code)// 15578
        {
            trigger OnAfterValidate()
            begin
                VALIDATE("Last Modify Date", CURRENTDATETIME);
            end;
        }

        modify(Name)// 15578
        {
            trigger OnBeforeValidate()
            begin
                VALIDATE("Last Modify Date", CURRENTDATETIME);
            end;
        }
        field(50000; "Qty Recieved"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Output),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50001; "Opening Qty"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Posting Date" = FIELD("Date Filter"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50002; "Date Filter"; Date)
        {
            Enabled = false;
            FieldClass = FlowFilter;
        }
        field(50003; "Depot Transfer"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         InTransit = FILTER(true),
                                                                         "External Transfer" = FILTER(true),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50004; "Location Filter"; Code[20])
        {
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = Location WHERE("Main Location" = FILTER(''));
        }
        field(50005; "Plant Code"; Code[10])
        {
        }
        field(50007; "Qty Sales"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Sale),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50008; Transfers; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         InTransit = CONST(false),
                                                                         "External Transfer" = CONST(true),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50009; "Opening Qty(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Posting Date" = FIELD("Date Filter"),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50010; "Qty Output(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Output),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50011; "Qty Sales(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Sale),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50012; "Transfers(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Document Type" = FILTER("Transfer Shipment"),
                                                                         InTransit = CONST(false),
                                                                         "External Transfer" = CONST(true),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50013; "Type Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    //VALIDATE("Type Filter",DimensionValue.Code);
                    "Type Filter" := DimensionValue.Code;
            end;
        }
        field(50014; "Quality Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Quality Filter", DimensionValue.Code);
            end;
        }
        field(50015; "Category Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Category Filter", DimensionValue.Code);
            end;
        }
        field(50016; "Size Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Size Filter", DimensionValue.Code);
            end;
        }
        field(50017; "Color Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Color Filter", DimensionValue.Code);
            end;
        }
        field(50018; "Packing Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Packing Filter", DimensionValue.Code);
            end;
        }
        field(50019; "Design Filter"; Code[10])
        {
            Enabled = false;
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Design Filter", DimensionValue.Code);
            end;
        }
        field(50020; "Transfers Rcpt(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         InTransit = CONST(false),
                                                                         "External Transfer" = CONST(true),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50021; "Cover Under Daily MIS"; Boolean)
        {
            Description = 'TRI CA 100810';
        }
        field(50022; "Group Category"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('GROUP CAT'));
        }
        field(50023; "Last Modify Date"; DateTime)
        {
        }
        field(50024; Plant; Option)
        {
            Editable = false;
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;
        }
        field(50025; "Display Allow"; Boolean)
        {
        }
        field(50026; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        ItemSetup: Record "Inventory Setup";
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
}

