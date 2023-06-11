pageextension 50416 pageextension50416 extends "Bank Payment Voucher"
{
    layout
    {

        //Unsupported feature: Code Modification on "Control 33.OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.SetCodes(PAGE::"Bank Payment Voucher",4,FALSE,FALSE);
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        addafter("Document Type")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Adv. Pmt. Adjustment"; Rec."Adv. Pmt. Adjustment")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Posting No. Series"; "Cheque No.")
        modify("Cheque No.")
        {
            Caption = 'cheque no.';

        }
        moveafter("Document No."; "Location Code", "On Hold")
        moveafter("Account No."; "Location Code")

        addafter("Location Code")
        {
            field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
            {
                ApplicationArea = All;
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = All;
            }
            field("Nature of Supply"; Rec."Nature of Supply")
            {
                ApplicationArea = All;
            }
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = All;
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
            }
            field("GST Bill-to/BuyFrom State Code"; Rec."GST Bill-to/BuyFrom State Code")
            {
                ApplicationArea = All;
            }
        }
        moveafter("GST Jurisdiction Type"; "GST on Advance Payment")
        moveafter("Nature of Supply"; "GST Group Code", "GST Group Type")
        moveafter("GST Customer Type"; "GST Vendor Type", "HSN/SAC Code")
    }
    actions
    {



        addafter("P&review Check")
        {
            action("Cheque IDBI")
            {
                Caption = 'Cheque IDBI';
                RunObject = Report "GST Sales Invoice Nepal";
                ApplicationArea = All;
            }
        }
    }
    var
        CurrentJnlBatchName: Code[10];


}

