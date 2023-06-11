table 90012 "DCAA Difference due to excise"
{
    //  DrillDownPageID = 90012;//16225 PAGE N/F
    //  LookupPageID = 90012;//16225 PAGE N/F

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
        }
        field(2; "Item No"; Code[20])
        {
        }
        field(3; "Ilvoice Line No"; Integer)
        {
        }
        field(4; "Posting Date"; Date)
        {
        }
        field(5; "Excise Amount"; Decimal)
        {
        }
        field(6; "Invoice Amount"; Decimal)
        {
        }
        field(7; "Excise Amount Total"; Decimal)
        {
            CalcFormula = Sum("DCAA Difference due to excise"."Excise Amount" WHERE("Posting Date" = FILTER(< '12/01/06')));
            FieldClass = FlowField;
        }
        field(8; "Invoice Amoutn Total"; Decimal)
        {
            CalcFormula = Sum("DCAA Difference due to excise"."Invoice Amount");
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Invoice No.", "Item No", "Ilvoice Line No")
        {
            Clustered = true;
            SumIndexFields = "Excise Amount", "Invoice Amount";
        }
        key(Key2; "Posting Date")
        {
            SumIndexFields = "Excise Amount", "Invoice Amount";
        }
    }

    fieldgroups
    {
    }
}

