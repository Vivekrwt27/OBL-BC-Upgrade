report 50241 "Nav Password Change Process 60"
{
    // <MIPL 13012020>

    ProcessingOnly = true;

    dataset
    {
        dataitem(User; User)
        {
            DataItemTableView = WHERE(State = CONST(Enabled));

            trigger OnAfterGetRecord()
            begin
                "Change Password" := TRUE;
                MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        userrec: Record User;
}

