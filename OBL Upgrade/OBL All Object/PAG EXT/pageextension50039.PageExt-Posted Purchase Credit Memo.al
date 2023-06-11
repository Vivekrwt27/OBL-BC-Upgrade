pageextension 50039 pageextension50039 extends "Posted Purchase Credit Memo"
{
    layout
    {

        addafter("Buy-from Contact")
        {
            field("Posting Description"; rec."Posting Description")
            {
                Caption = 'Posting Description';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
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
        }
        addafter("Vendor Cr. Memo No.")
        {
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
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        PCH: Record "Purch. Cr. Memo Hdr.";

    trigger OnOpenPage()
    begin
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Credit memo", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        REC.FILTERGROUP(2);
        REC.SETFILTER("Location Code", LocationFilterString);
        REC.FILTERGROUP(0);


        //ND Tri End Cust 38
        //TRI SC

    end;
}

