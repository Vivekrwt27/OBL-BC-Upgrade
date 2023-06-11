tableextension 50226 tableextension50226 extends "Warehouse Setup"
{
    fields
    {
        field(50000; "IC Transfer-In Nos."; Code[20])
        {
            Caption = 'IC Transfer-In Nos.';
            Description = 'MS-PB';
            TableRelation = "No. Series";
        }
        field(50001; "IC Transfer-Out Nos."; Code[20])
        {
            Caption = 'IC Transfer-Out Nos.';
            Description = 'MS-PB';
            TableRelation = "No. Series";
        }
        field(50002; "Auto Post Transfer - In"; Boolean)
        {
            Description = 'MS-PB';
        }
    }
}

