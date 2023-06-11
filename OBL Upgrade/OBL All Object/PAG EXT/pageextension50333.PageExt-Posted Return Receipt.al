pageextension 50333 pageextension50333 extends "Posted Return Receipt"
{
    layout
    {

        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; Rec."Ship-to Address 3")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            field("Transporter's Name"; Rec."Transporter's Name")
            {
                Caption = 'Transporter Code';
                Editable = false;
                ApplicationArea = All;
            }
            field("GR No."; Rec."GR No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("GR Date"; Rec."GR Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Truck No."; Rec."Truck No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    var
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];

    trigger OnOpenPage()//16225 Add Modify Code
    begin
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Return order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //ND Tri End Cust 38 
    end;

}

