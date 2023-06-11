pageextension 50460 "Allowedsections" extends "Allowed Sections"
{
    layout
    {
        addafter("TDS Section Description")
        {
            field("Total Credit Amount"; Rec."Total Credit Amount")
            {
                ApplicationArea = all;
            }
            field("Total Credit %"; Rec."Total Credit %")
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
    }



}