pageextension 50363 pageextension50363 extends "Job Card"
{
    layout
    {
        addafter("Total WIP Cost G/L Amount")
        {
            field("<Ttotal WIP Sales G/L Amount>"; Rec."Total WIP Sales G/L Amount")
            {
                ApplicationArea = All;
            }
        }
    }
}

