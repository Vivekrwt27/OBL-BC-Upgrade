pageextension 50268 pageextension50268 extends "Stockkeeping Unit Card"
{
    layout
    {

        addafter("Transfer-from Code")
        {
            /*field("Routing No."; Rec."Routing No.")//16225 Allready define In BasePage
            {
            }*/
            field("Default Production SKU"; Rec."Default Production SKU")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }

    }
}

