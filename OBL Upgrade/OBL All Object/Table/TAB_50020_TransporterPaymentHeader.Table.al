table 50020 "Transporter Payment Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Customization No. 9';
        }
        field(2; "Vendor No."; Code[20])
        {
            Description = 'Customization No. 9';
            TableRelation = Vendor."No." WHERE(Transporter1 = CONST(true));
        }
        field(3; City; Text[30])
        {
            Description = 'Customization No. 9';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", FALSE);
            end;
        }
        field(4; "From Date"; Date)
        {
            Description = 'Customization No. 9';

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN TransporterPaymentLine.DELETEALL;
            end;
        }
        field(5; "To Date"; Date)
        {
            Description = 'Customization No. 9';

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN TransporterPaymentLine.DELETEALL;
            end;
        }
        field(6; "Charge Item"; Code[20])
        {
            Description = 'Customization No. 9';
            TableRelation = "Item Charge";

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN TransporterPaymentLine.DELETEALL;
            end;
        }
        field(7; "Rate/Kg"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Description = 'Customization No. 9';

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN
                    REPEAT
                        TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Rate/Kg", "Rate/Kg");
                        TransporterPaymentLine.MODIFY;
                    UNTIL TransporterPaymentLine.NEXT = 0;
            end;
        }
        field(8; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Transporter Payment Line".Amount WHERE("Trans. Payment No." = FIELD("No.")));
            Description = 'Customization No. 9';
            FieldClass = FlowField;
        }
        field(9; "Sales Person Code"; Code[10])
        {
            Description = 'Customization No. 26';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN TransporterPaymentLine.DELETEALL;
            end;
        }
        field(10; "Commission Type"; Option)
        {
            Description = 'Customization No. 26';
            OptionCaption = 'Per Carton,Per Sq. Mt.,% Before Excise,% After Excise ';
            OptionMembers = "Per Carton","Per Sq. Mt.","% Before Excise","% After Excise ";

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN
                    REPEAT
                        TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Commission Type", "Commission Type");
                        TransporterPaymentLine.MODIFY;
                    UNTIL TransporterPaymentLine.NEXT = 0;
            end;
        }
        field(11; "Calculation Value"; Decimal)
        {
            Description = 'Customization No. 26';

            trigger OnValidate()
            begin
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN
                    REPEAT
                        TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Calculation Value", "Calculation Value");
                        TransporterPaymentLine.MODIFY;
                    UNTIL TransporterPaymentLine.NEXT = 0;
            end;
        }
        field(12; "Total Commission"; Decimal)
        {
            CalcFormula = Sum("Transporter Payment Line"."Calculated Commission" WHERE("Trans. Payment No." = FIELD("No.")));
            Description = 'Customization No. 26';
            FieldClass = FlowField;
        }
        field(13; "Post Code"; Code[20])
        {
            Description = 'Customization No. 9';
            TableRelation = "Post Code"."Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
                TransporterPaymentLine.RESET;
                TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", "No.");
                IF TransporterPaymentLine.FIND('-') THEN TransporterPaymentLine.DELETEALL;
            end;
        }
        field(14; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transporter Payment Line"."K.G." WHERE("Trans. Payment No." = FIELD("No.")));
            Editable = false;

        }
        field(15; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(16; County; Text[30])
        {
            Caption = 'County';
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

    trigger OnInsert()
    begin


        IF "No." = '' THEN BEGIN
            PurchPaySetup.GET;
            IF PurchPaySetup."Transportor Nos." = '' THEN
                ERROR('Please Define Transportor No. Series');
            "No." := NoSeriesMgt.GetNextNo(PurchPaySetup."Transportor Nos.", WORKDATE, TRUE);
        END;
    end;

    var
        TransporterPaymentLine: Record "Transporter Payment Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchPaySetup: Record "Purchases & Payables Setup";
        InventorySetup: Record "Inventory Setup";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        PostCode: Record "Post Code";
}

