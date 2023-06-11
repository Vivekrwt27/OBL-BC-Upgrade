pageextension 50246 pageextension50246 extends "Dimension Values"
{
    layout
    {
        addfirst(Control1)
        {
            field("Dimension Code"; Rec."Dimension Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Dimension Value Type")
        {
            field("Cover Under Daily MIS"; Rec."Cover Under Daily MIS")
            {
                ApplicationArea = All;
            }
        }
        addafter(Totaling)
        {
            field("Dimension Value ID"; Rec."Dimension Value ID")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()//16225 Add Block Code//
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;


}

