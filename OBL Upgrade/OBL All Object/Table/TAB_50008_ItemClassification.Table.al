table 50008 "Item Classification"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Type Code"; Code[2])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Type Code" := DimensionValue.Code;
            end;
        }
        field(4; "Type Catogery Code"; Code[2])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Type Catogery Code" := DimensionValue.Code;
            end;
        }
        field(5; "Size Code"; Code[3])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Size Code" := DimensionValue.Code;
            end;
        }
        field(6; "Design Code"; Code[4])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Design Code" := DimensionValue.Code;
            end;
        }
        field(7; "Color Code"; Code[4])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Color Code" := DimensionValue.Code;
            end;
        }
        field(8; "Packing Code"; Code[2])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Packing Code" := DimensionValue.Code;
            end;
        }
        field(9; "Quality Code"; Code[1])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Quality Code" := DimensionValue.Code;
            end;
        }
        field(10; "Plant Code"; Code[1])
        {
            TableRelation = Dimension;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    "Plant Code" := DimensionValue.Code;
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
}

