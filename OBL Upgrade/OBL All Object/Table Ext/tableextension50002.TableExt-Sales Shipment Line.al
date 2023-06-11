tableextension 50002 tableextension50002 extends "Sales Shipment Line"
{
    fields
    {


        field(50002; "Quantity in Cartons"; Decimal)
        {
        }
        field(50003; "Type Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Code", DimensionValue.Code);
            end;
        }
        field(50004; "Plant Code"; Code[1])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Plant Code", DimensionValue.Code);
            end;
        }
        field(50005; "Size Code"; Code[3])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Size Code", DimensionValue.Code);
            end;
        }
        field(50006; "Posting Date1"; Date)
        {
            Description = 'report  S15';
        }
        field(50007; Schemes; Code[20])
        {
            Description = 'Customization No. 47';
        }
        field(50008; "Color Code"; Code[4])
        {
            Description = 'report s-20';

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Color Code", DimensionValue.Code);
            end;
        }
        field(50009; "Design Code"; Code[4])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Design Code", DimensionValue.Code);
            end;
        }
        field(50010; "Packing Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Packing Code", DimensionValue.Code);
            end;
        }
        field(50011; "Quality Code"; Code[1])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Quality Code", DimensionValue.Code);
            end;
        }
        field(50012; "Salesperson Code"; Code[10])
        {
            Description = 'report n-4';
        }
        field(50013; "Quantity in Sq. Mt."; Decimal)
        {
            Editable = false;
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Buyer's Price"; Decimal)
        {
            Editable = false;
        }
        field(50016; "Discount Per Unit"; Decimal)
        {
        }
        field(50018; "Related Location code"; Code[20])
        {
        }
        field(50019; "Unit Price (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50020; "Amount (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50021; "Carton No. From"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50022; "Carton No. To"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50023; "Pallet No. From"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50024; "Pallet No. To"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50025; "Total Pallets"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50026; "Total Cartons"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50028; "Group Code"; Code[2])
        {
            Editable = false;
        }
        field(50030; "Type Catogery Code"; Code[2])
        {
            Description = 'Tri NM 160308';

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Catogery Code", DimensionValue.Code);
            end;
        }
        field(50060; "Sales Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(60004; Remarks; Text[40])
        {
            Description = 'TRI DG 290710';
            Editable = false;
        }
        field(60010; "Offer Code"; Code[10])
        {
        }
        field(60011; Slab; Code[10])
        {
        }
        field(60013; "Quantity Discount %"; Decimal)
        {
            Caption = 'Quantity Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(60014; "Quantity Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Quantity Discount Amount';
        }
        field(60015; "Accrued Quantity"; Decimal)
        {
        }
        field(60016; "Calculate Line Discount"; Boolean)
        {
        }
        field(60017; "Accrued Discount"; Decimal)
        {
        }
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHEMECODE'));
        }
        field(60050; D1; Decimal)
        {
        }
        field(60051; D2; Decimal)
        {
        }
        field(60052; D3; Decimal)
        {
        }
        field(60053; D4; Decimal)
        {
        }
        field(60054; S1; Decimal)
        {
        }
        field(60055; "Discount Amt 1"; Decimal)
        {
        }
        field(60056; "Discount Amt 2"; Decimal)
        {
        }
        field(60057; "Discount Amt 3"; Decimal)
        {
        }
        field(60058; "Discount Amt 4"; Decimal)
        {
        }
        field(60059; "System Discount Amount"; Decimal)
        {
        }
        field(90004; "Amount Inc CD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key8; "Location Code")
        {
        }
        key(Key9;/*State,*/"No.")
        {
        }
    }


    var
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";

}

