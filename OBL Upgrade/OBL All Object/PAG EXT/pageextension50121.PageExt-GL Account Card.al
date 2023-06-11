pageextension 50121 pageextension50121 extends "G/L Account Card"
{
    layout
    {
        addafter("Omit Default Descr. in Jnl.")
        {
            field("Create for Orient"; rec."Create for Orient")
            {
                ApplicationArea = All;
            }
            field("Create for Bell"; rec."Create for Bell")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Apply Template")//"Action 62"
        {
            action("Create For Bell1")
            {
                Caption = 'Create For Bell';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    rec.CreateForBell(Rec, rec."No.");
                end;
            }
            action("Create For Orient1")
            {
                Caption = 'Create For Orient';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    rec.CreateForOrient(Rec, rec."No.");
                end;
            }
            action("Create For Both")
            {
                Caption = 'Create For Both';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    rec.CreateForAll(Rec, rec."No.");
                end;
            }
        }
    }
}

