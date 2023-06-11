pageextension 50131 pageextension50131 extends "Apply Vendor Entries"
{
    layout
    {

        //Unsupported feature: Property Deletion (CaptionML) on "AppliesToID(Control 22)".

        addafter("External Document No.")
        {
            field("User ID"; rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

}

