pageextension 50045 pageextension50045 extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Order Address Code")
        {
            field("User ID"; rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Posting Description New"; Rec."Posting Description New")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Shipment Method Code"; "Vendor Invoice No.", "Order No.")
        addafter("Shipment Method Code")
        {
            field("Vendor Posting Group"; rec."Vendor Posting Group")
            {
                ApplicationArea = All;
            }
            field("Form C No."; rec."Form C No.")
            {
                ApplicationArea = All;
            }
            field("Form C Amt"; rec."Form C Amt")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            field("Total Recd. Quantity"; rec."Total Recd. Quantity")
            {
                ApplicationArea = All;
            }
            field("Pre-Assigned No. Series"; rec."Pre-Assigned No. Series")
            {
                ApplicationArea = All;
            }
            field("Pre-Assigned No."; rec."Pre-Assigned No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                Caption = 'Truck No.';
                ApplicationArea = All;
            }
            field("Vendor Shipment No."; rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
            }
            field("GE No."; rec."GE No.")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; rec."Transporter Name")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        LocationFilterString: Text[500];
        UserLocation: Record "User Location";


    trigger OnOpenPage()
    begin
        //TCPL::6904 21 JULY 2016
        //upgrade(+)
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Invoice", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);
        //ND Tri End Cust 38
        //TRI SC
        //SETRANGE("New Status","New Status"::Short);
        //Msvc

    end;
}

