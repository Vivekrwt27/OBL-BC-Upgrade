pageextension 50248 pageextension50248 extends "Dimension Value Combinations"
{

    layout
    {
        addfirst(content)
        {
            group(Control1000000002)
            {
                field("Show Column NAME"; Rec.Blocked)
                {
                    Caption = 'Show Column NAME';
                    ApplicationArea = All;
                }
            }
            part("Dimension Combinations Matrix"; "Dimension Combinations Matrix")
            {
                ApplicationArea = All;
            }
        }
    }
}

