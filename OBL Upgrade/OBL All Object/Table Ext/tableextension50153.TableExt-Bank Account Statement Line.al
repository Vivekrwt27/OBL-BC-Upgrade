tableextension 50153 tableextension50153 extends "Bank Account Statement Line"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 6)".

        field(50000; Name; Text[100])
        {
            Description = 'mo tri1.0';
        }
        field(50001; "Cheque Date"; Date)
        {
            Description = 'mo tri1.0';
        }
        field(50002; "Issuing Bank"; Text[30])
        {
            Description = 'mo tri1.0';
        }
        field(50003; "Cheque No."; Code[10])
        {
            Description = 'mo tri1.0';
        }
    }
}

