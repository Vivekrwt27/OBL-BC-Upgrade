tableextension 50268 tableextension50268 extends "Vendor Posting Group"
{
    fields
    {
        field(50000; Desc; Text[30])
        {
        }
        field(50001; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Owner Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}

