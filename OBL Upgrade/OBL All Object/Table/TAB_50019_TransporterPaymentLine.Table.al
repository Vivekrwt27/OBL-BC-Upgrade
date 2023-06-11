table 50019 "Transporter Payment Line"
{
    Caption = 'Payment Line';

    fields
    {
        field(1; "MRN No."; Code[20])
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(3; "MRN Date"; Date)
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(4; "Vendor No."; Code[20])
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(5; City; Text[30])
        {
            Description = 'Customization No. 9';
            TableRelation = "Post Code".City;
        }
        field(6; "Posting Date"; Date)
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(7; Item; Code[20])
        {
            Description = 'Customization No. 9';
            Editable = false;
            TableRelation = Item;
        }
        field(8; Quantity; Decimal)
        {
            Description = 'Customization No. 9';
            Editable = false;

            trigger OnValidate()
            begin
                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Item);
                ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, UOM);
                IF ItemUnitofMeasure.FIND('-') THEN
                    VALIDATE("K.G.", ItemUnitofMeasure.Weight * Quantity);

                VALIDATE("Quantity in Carton", CalcQtyPerCarton);
                VALIDATE("Quantity in Sq. Mt.", CalcQtyPerSqMt);
                VALIDATE("Calculated Commission", CalcCommission);
            end;
        }
        field(9; UOM; Text[30])
        {
            Description = 'Customization No. 9';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item"));

            trigger OnValidate()
            begin
                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Item);
                ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, UOM);
                IF ItemUnitofMeasure.FIND('-') THEN
                    VALIDATE("K.G.", ItemUnitofMeasure.Weight * Quantity);

                VALIDATE("Quantity in Carton", CalcQtyPerCarton);
                VALIDATE("Quantity in Sq. Mt.", CalcQtyPerSqMt);
                VALIDATE("Calculated Commission", CalcCommission);
            end;
        }
        field(10; "K.G."; Decimal)
        {
            Description = 'Customization No. 9';

            trigger OnValidate()
            begin
                VALIDATE(Amount, "K.G." * "Rate/Kg");
            end;
        }
        field(11; Amount; Decimal)
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(12; "Trans. Payment No."; Code[20])
        {
            Description = 'Customization No. 9';
            Editable = false;
        }
        field(13; "Rate/Kg"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Description = 'Customization No. 9';

            trigger OnValidate()
            begin
                VALIDATE(Amount, "K.G." * "Rate/Kg");
            end;
        }
        field(14; "Amount Before Excise"; Decimal)
        {
            Description = 'Customization No. 26';
        }
        field(15; "Amount After Excise"; Decimal)
        {
            Description = 'Customization No. 26';
        }
        field(16; "Calculated Commission"; Decimal)
        {
            Description = 'Customization No. 26';
            Editable = false;
        }
        field(17; "Commission Type"; Option)
        {
            Description = 'Customization No. 26';
            OptionCaption = 'Per Carton,Per Sq. Mt.,% Before Excise,% After Excise ';
            OptionMembers = "Per Carton","Per Sq. Mt.","% Before Excise","% After Excise ";

            trigger OnValidate()
            begin
                VALIDATE("Quantity in Carton", CalcQtyPerCarton);
                VALIDATE("Quantity in Sq. Mt.", CalcQtyPerSqMt);
                VALIDATE("Calculated Commission", CalcCommission);
            end;
        }
        field(18; "Calculation Value"; Decimal)
        {
            Description = 'Customization No. 26';

            trigger OnValidate()
            begin
                VALIDATE("Calculated Commission", CalcCommission);
            end;
        }
        field(19; "Quantity in Carton"; Decimal)
        {
            Description = 'Customization No. 26';
        }
        field(20; "Quantity in Sq. Mt."; Decimal)
        {
            Description = 'Customization No. 26';
        }
        field(21; "Customer No."; Code[20])
        {
            TableRelation = IF (Transfer = CONST(false)) Customer."No."
            ELSE
            IF (Transfer = CONST(true)) Location;
        }
        field(22; Transfer; Boolean)
        {
        }
        field(23; "GR No."; Code[20])
        {
            Editable = false;
        }
        field(24; "GR Date"; Date)
        {
            Editable = false;
        }
        field(25; "Invoice No."; Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Trans. Payment No.", "MRN No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        //     IF "MRN No." = '' THEN
        //         ERROR('MRN No. is not found in Line');
        IF TransporterPaymentHeader.GET("Trans. Payment No.") THEN BEGIN
            VALIDATE("Rate/Kg", TransporterPaymentHeader."Rate/Kg");
            VALIDATE("Commission Type", TransporterPaymentHeader."Commission Type");
            VALIDATE("Calculation Value", TransporterPaymentHeader."Calculation Value");
        END;
    end;

    var
        TransporterPaymentHeader: Record "Transporter Payment Header";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
        ItemUnitofMeasure2: Record "Item Unit of Measure";

    procedure CalcQtyPerCarton(): Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
    begin
        InventorySetup.GET;
        ItemUnitofMeasure.RESET;
        ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure."Item No.", Item);
        ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, InventorySetup."Unit of Measure for Carton");
        IF ItemUnitofMeasure.FIND('-') THEN BEGIN
            QtyPerC := ItemUnitofMeasure."Qty. per Unit of Measure";
            ItemUnitofMeasure2.RESET;
            ItemUnitofMeasure2.SETFILTER(ItemUnitofMeasure2."Item No.", Item);
            ItemUnitofMeasure2.SETFILTER(ItemUnitofMeasure2.Code, UOM);
            QtyPerU := ItemUnitofMeasure2."Qty. per Unit of Measure";
            EXIT((Quantity * QtyPerU) / QtyPerC);
        END;
    end;

    procedure CalcQtyPerSqMt(): Decimal
    var
        QtyPerC: Decimal;
        QtyPerU: Decimal;
    begin
        InventorySetup.GET;
        ItemUnitofMeasure.RESET;
        ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure."Item No.", Item);
        ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, InventorySetup."Unit of Measure for Sq. Mt.");
        IF ItemUnitofMeasure.FIND('-') THEN BEGIN
            QtyPerC := ItemUnitofMeasure."Qty. per Unit of Measure";
            ItemUnitofMeasure2.RESET;
            ItemUnitofMeasure2.SETFILTER(ItemUnitofMeasure2."Item No.", Item);
            ItemUnitofMeasure2.SETFILTER(ItemUnitofMeasure2.Code, UOM);
            QtyPerU := ItemUnitofMeasure2."Qty. per Unit of Measure";
            EXIT((Quantity * QtyPerU) / QtyPerC);
        END;
    end;

    procedure CalcCommission(): Decimal
    begin
        IF "Commission Type" = "Commission Type"::"Per Carton" THEN
            EXIT("Calculation Value" * "Quantity in Carton");

        IF "Commission Type" = "Commission Type"::"Per Sq. Mt." THEN
            EXIT("Calculation Value" * "Quantity in Sq. Mt.");

        IF "Commission Type" = "Commission Type"::"% After Excise " THEN
            EXIT(("Calculation Value" * "Amount After Excise") / 100);

        IF "Commission Type" = "Commission Type"::"% Before Excise" THEN
            EXIT(("Calculation Value" * "Amount Before Excise") / 100);
    end;
}

