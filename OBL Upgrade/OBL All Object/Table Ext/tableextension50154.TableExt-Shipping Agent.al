tableextension 50154 tableextension50154 extends "Shipping Agent"
{
    fields
    {
        field(50000; "Insurance Applicable"; Boolean)
        {
        }
        field(50001; "Weight Less Then"; Decimal)
        {
        }
        field(50002; "Weight Greater Then"; Decimal)
        {
        }
        field(50003; Blocked; Boolean)
        {
        }
        field(50010; "Transporter GST No."; Code[20])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50011; Tonnage; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Tonnage for IBOT';
        }
        field(50012; "Block for IBOT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

