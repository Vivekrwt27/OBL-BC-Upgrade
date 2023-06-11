tableextension 50274 tableextension50274 extends "Routing Header"
{
    fields
    {
        field(50001; "Production Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
    }
}

