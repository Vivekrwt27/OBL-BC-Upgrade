pageextension 50135 pageextension50135 extends "Sales Journal"
{
    layout
    {

        addfirst(Control1)
        {
            field("Location Code1"; rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Apply Entries")
        {
            Visible = false;
        }
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("Generate Dr. Note for TCS")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(ProcessDebitNoteofTCS);
                    ProcessDebitNoteofTCS.SetTCSJournalBatch(rec."Journal Template Name", rec."Journal Batch Name");
                    ProcessDebitNoteofTCS.RUN;
                end;
            }
        }
    }

    var
        ProcessDebitNoteofTCS: Report "Process Debit Note of TCS";

}

