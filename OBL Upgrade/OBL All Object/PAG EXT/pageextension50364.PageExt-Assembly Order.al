pageextension 50364 pageextension50364 extends "Assembly Order"
{
    layout
    {
        addfirst(Posting)
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
}

