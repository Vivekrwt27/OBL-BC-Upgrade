tableextension 50162 tableextension50162 extends "No. Series Relationship"
{
    fields
    {
        field(50000; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(50001; type; Text[8])
        {
        }
    }
}

