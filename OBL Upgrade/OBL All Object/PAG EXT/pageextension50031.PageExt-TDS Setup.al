pageextension 50031 pageextension50031 extends "TDS Setup"
{
    layout
    {
        addafter("Tax Type")//"Control 1280008"
        {
            field("Tds Certificate"; rec."Tds Certificate")
            {
                ApplicationArea = All;
            }
            field("Calc. Over & Above Threshold"; rec."Calc. Over & Above Threshold")
            {
                ApplicationArea = All;
            }

        }
    }
}

