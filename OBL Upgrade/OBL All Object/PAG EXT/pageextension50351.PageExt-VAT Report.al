pageextension 50351 pageextension50351 extends "VAT Report"
{
    Caption = 'VAT Report';
    layout
    {

        modify("Return Period")
        {
            Visible = false;
        }

        modify(ReturnPeriodStatus)
        {
            Visible = false;
        }


        modify(ErrorMessagesPart)
        {
            Visible = false;
        }
        addafter(ReturnPeriodDueDate)
        {
            field("Original Report No."; Rec."Original Report No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("VAT Report Version"; ReturnPeriodDueDate)
        moveafter(ReturnPeriodDueDate; "Start Date")
    }
    actions
    {
        modify(SuggestLines)
        {
            Caption = '&Suggest Lines';
        }
        modify(Submit)
        {
            Caption = '&Export';

        }
        modify("Mark as Submitted")
        {
            Caption = 'Mark as Su&bmitted';
        }
        modify(Reopen)
        {
            Caption = 'Re&open';
        }
        modify(Print)
        {
            Caption = '&Print';
        }
        modify("Open VAT Return Period Card")
        {

            Caption = '&Release';
            ShortCutKey = 'Ctrl+F9';
            Promoted = true;
            PromotedCategory = Process;
        }


        modify(Release)
        {
            Visible = false;
        }


        modify("Cancel Submission")
        {
            Visible = false;
        }

        modify("Download Submission Message")
        {
            Visible = false;
        }
        modify("Download Response Message")
        {
            Visible = false;
        }
        modify("Calc. and Post VAT Settlement")
        {
            Visible = false;
        }

        modify("Report Setup")
        {
            Visible = false;
        }

        addafter(SuggestLines)
        {
        }
        addafter(Reopen)
        {
        }
        moveafter(SuggestLines; "Open VAT Return Period Card")
        moveafter("Open VAT Return Period Card"; "Mark as Submitted")
    }



}

