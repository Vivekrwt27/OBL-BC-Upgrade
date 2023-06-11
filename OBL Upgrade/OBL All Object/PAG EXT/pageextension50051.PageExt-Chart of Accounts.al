pageextension 50051 pageextension50051 extends "Chart of Accounts"
{
    Editable = false;
    layout
    {
        addafter("Direct Posting")
        {
            field("System Entries"; rec.wip)
            {
                ApplicationArea = All;
            }
        }
        addafter(Totaling)
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
        moveafter("Net Change"; "Debit Amount", "Credit Amount")
        addafter("Default Deferral Template Code")
        {
            field("Date Filter"; rec."Date Filter")
            {
                ApplicationArea = All;
            }
        }
    }
}

