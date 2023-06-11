pageextension 50157 pageextension50157 extends "Post Codes"
{
    Editable = true;
    layout
    {
        modify(TimeZone)
        {
            Visible = false;
        }
        addafter(County)
        {
            field(Zone; rec.Zone)
            {
                ApplicationArea = All;
            }
            field(Longitude; rec.Longitude)
            {
                ApplicationArea = All;
            }
            field(Latitude; rec.Latitude)
            {
                ApplicationArea = All;
            }
        }
    }
}

