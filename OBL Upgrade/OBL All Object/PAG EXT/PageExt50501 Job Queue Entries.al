pageextension 50501 PageExt50501 extends "Job Queue Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Job &Queue")
        {
            action(TransferSOcreation)
            {
                ApplicationArea = All;
                RunObject = report 50181;
                Caption = 'Transfer SO Creation Report';
            }
            action("Item Data Import")
            {
                ApplicationArea = all;
                RunObject = codeunit 50027;
            }
            action(conversion)
            {
                ApplicationArea = all;
                RunObject = codeunit 50026;
            }
        }
    }

    var
        myInt: Integer;
}