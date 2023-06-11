pageextension 50081 pageextension50081 extends "HSN/SAC"
{
    layout
    {
        addafter(Type)
        {
            field(Blocked; rec.Blocked)
            {
                ApplicationArea = All;
            }
        }
    }
}

