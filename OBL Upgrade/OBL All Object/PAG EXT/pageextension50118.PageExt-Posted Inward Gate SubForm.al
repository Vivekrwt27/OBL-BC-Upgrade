pageextension 50118 pageextension50118 extends "Posted Inward Gate SubForm"
{
    layout
    {
        addafter("Source Name")
        {
            field("Vendor No"; rec."Vendor No")
            {
                ApplicationArea = All;
            }
        }
    }
}

