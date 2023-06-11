pageextension 50426 pageextension50426 extends "Cash Receipt Journal"
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
        GenJnlManagement.SetCodes(PAGE::"Cash Receipt Journal",3,FALSE,TRUE);//6700
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        addafter("Gen. Prod. Posting Group")
        {
            field("Cheque Date"; Rec."Cheque Date")
            {
                ApplicationArea = All;
            }
            field("Cheque No."; Rec."Cheque No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Applies-to Doc. No."; "Location Code")

    }
}

