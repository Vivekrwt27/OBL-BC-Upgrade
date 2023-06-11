pageextension 50046 pageextension50046 extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("Location Code")
        {
            field("Vendor Invoice No."; rec."Vendor Invoice No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; rec."Vendor Invoice Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
            {
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("Vendor CN Date"; rec."Vendor CN Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Is Vendor GST C_Note  available"; rec."Vendor GST CN  available")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    var
        LocationFilterString: Text[250];
        UserLocation: Record "User Location";
}

