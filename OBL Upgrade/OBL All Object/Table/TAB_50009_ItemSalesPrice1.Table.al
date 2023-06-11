table 50009 "Item Sales Price1"
{
    Caption = 'Item Sales Price';
    LookupPageID = "Sales Prices";

    fields
    {
        field(1; "Item Classification No."; Code[20])
        {
            Caption = 'Item Classification No.';
            NotBlank = true;
            TableRelation = "Item Classification";
        }
        field(2; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            TableRelation = IF ("Sales Type" = CONST("Customer Price Group")) "Customer Price Group"
            ELSE
            IF ("Sales Type" = CONST(Customer)) Customer
            ELSE
            IF ("Sales Type" = CONST(Campaign)) Campaign;

            trigger OnValidate()
            begin
                IF "Sales Code" <> '' THEN BEGIN
                    CASE "Sales Type" OF
                        "Sales Type"::"All Customers":
                            ERROR(Text001, FIELDCAPTION("Sales Code"));
                        "Sales Type"::"Customer Price Group":
                            BEGIN
                                CustPriceGr.GET("Sales Code");
                                "Price Includes VAT" := CustPriceGr."Price Includes VAT";
                                "VAT Bus. Posting Gr. (Price)" := CustPriceGr."VAT Bus. Posting Gr. (Price)";
                                "Allow Line Disc." := CustPriceGr."Allow Line Disc.";
                                "Allow Invoice Disc." := CustPriceGr."Allow Invoice Disc.";
                            END;
                        "Sales Type"::Customer:
                            BEGIN
                                Cust.GET("Sales Code");
                                "Currency Code" := Cust."Currency Code";
                                "Price Includes VAT" := Cust."Prices Including VAT";
                                "Allow Line Disc." := Cust."Allow Line Disc.";
                            END;
                        "Sales Type"::Campaign:
                            BEGIN
                                Campaign.GET("Sales Code");
                                "Starting Date" := Campaign."Starting Date";
                                "Ending Date" := Campaign."Ending Date";
                            END;
                    END;
                END;
            end;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));

                IF CurrFieldNo = 0 THEN
                    EXIT ELSE
                    IF "Sales Type" = "Sales Type"::Campaign THEN
                        ERROR(Text002, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"), FIELDCAPTION("Sales Type"), ("Sales Type"));
            end;
        }
        field(5; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Unit Price" > MRP THEN
                    ERROR(Text0003, "Item Classification No.");
            end;
        }
        field(7; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes VAT';
        }
        field(10; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(11; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
            TableRelation = "VAT Business Posting Group";
        }
        field(13; "Sales Type"; Option)
        {
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Price Group","All Customers",Campaign;

            trigger OnValidate()
            begin
                IF "Sales Type" <> xRec."Sales Type" THEN
                    VALIDATE("Sales Code", '');
            end;
        }
        field(14; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                IF CurrFieldNo = 0 THEN
                    EXIT;

                VALIDATE("Starting Date");

                IF "Sales Type" = "Sales Type"::Campaign THEN
                    ERROR(Text002, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"), FIELDCAPTION("Sales Type"), ("Sales Type"));
            end;
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure".Code;
        }
        field(5700; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(50000; MRP; Decimal)
        {
        }
        field(50001; UOM; Code[10])
        {
        }
        field(50002; "Quality 4 Classification Code"; Code[10])
        {
        }
        field(50003; sp1; Code[20])
        {
        }
        field(50004; "count"; Integer)
        {
            CalcFormula = Count("Item Sales Price1");
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50005; "Nepal Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item Classification No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
            Clustered = true;
        }
        key(Key2; "Sales Type", "Sales Code", "Item Classification No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
        key(Key3; "Sales Code", "Quality 4 Classification Code", "Item Classification No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Sales Type" = "Sales Type"::"All Customers" THEN
            "Sales Code" := ''
        ELSE
            TESTFIELD("Sales Code");

        TESTFIELD("Unit of Measure Code");
    end;

    trigger OnRename()
    begin
        IF "Sales Type" <> "Sales Type"::"All Customers" THEN
            TESTFIELD("Sales Code");
        //TESTFIELD("Item No.");
    end;

    var
        CustPriceGr: Record "Customer Price Group";
        Text000: Label '%1 cannot be after %2';
        Cust: Record Customer;
        Text001: Label '%1 must be blank.';
        Campaign: Record Campaign;
        Item: Record Item;
        Text002: Label 'You can only change the %1 and %2 from the Campaign Card when %3 = %4';
        Text0003: Label 'Unit Price of Item Classification No. %1 cannot be greater than its MRP.';
}

