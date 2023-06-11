pageextension 50285 pageextension50285 extends "Warehouse Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("Inter Company")
            {
                Caption = 'Inter Company';
                field("IC Transfer-In Nos."; Rec."IC Transfer-In Nos.")
                {
                    Caption = 'IC Transfer Nos.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

