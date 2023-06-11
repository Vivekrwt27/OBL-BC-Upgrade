pageextension 50149 pageextension50149 extends "Transport Methods"
{
    layout
    {
        addafter(Code)
        {
            field(City; rec.City)
            {
                ApplicationArea = All;
            }
            field(State; rec.State)
            {
                ApplicationArea = All;
            }
            field("City Name"; rec."City Name")
            {
                ApplicationArea = All;
            }
            field("State Name"; rec."State Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("E-Way transport method"; rec."E-Way transport method")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        postcode: Record "Post Code";
}

