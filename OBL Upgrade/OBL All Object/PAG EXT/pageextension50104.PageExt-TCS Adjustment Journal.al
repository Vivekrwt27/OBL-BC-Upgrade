pageextension 50104 pageextension50104 extends "TCS Adjustment Journal"
{

    layout
    {
        addafter("Posting Date")
        {
            field("Posting No. Series"; REC."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
}

