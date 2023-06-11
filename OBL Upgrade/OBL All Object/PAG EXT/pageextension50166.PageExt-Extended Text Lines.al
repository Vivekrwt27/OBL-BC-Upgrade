pageextension 50166 pageextension50166 extends "Extended Text Lines"
{
    layout
    {
        addfirst(Control1)
        {
            field("Table Name"; rec."Table Name")
            {
                ApplicationArea = All;
            }
            field("No."; rec."No.")
            {
                ApplicationArea = All;
            }
            field("Language Code"; rec."Language Code")
            {
                ApplicationArea = All;
            }
            field("Text No."; rec."Text No.")
            {
                ApplicationArea = All;
            }
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

