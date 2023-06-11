table 70018 "Purchase Price New"
{
    Caption = 'Purchase Price';
    LookupPageID = "Purchase Prices";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            MinValue = 0;
        }
        field(14; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5700; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(50000; "Order Date"; Date)
        {
        }
        field(50001; "Order No."; Code[20])
        {
        }
        field(50002; Quantity; Decimal)
        {
        }
        field(50003; "Excise %"; Decimal)
        {
        }
        field(50004; PaymentTerms; Code[20])
        {
            TableRelation = "Payment Terms".Code;
        }
        field(50005; "VAT %"; Decimal)
        {
        }
        field(50006; "Sales Tax %"; Decimal)
        {
        }
        field(50007; "Charges %"; Decimal)
        {
        }
        field(50008; "Other Taxes %"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.", "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
        key(Key3; "Order No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '%1 cannot be after %2';
        Text001: Label '%1 already exists.';
}

