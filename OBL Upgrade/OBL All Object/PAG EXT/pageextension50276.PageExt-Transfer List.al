pageextension 50276 pageextension50276 extends 5742
{
    layout
    {
        addafter("Receipt Date")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field("Requested By"; Rec."Requested By")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = All;
            }
            field("Total Qty"; Rec."Total Qty")
            {
                ApplicationArea = All;
            }
            field("Last Shipment No."; Rec."Last Shipment No.")
            {
                ApplicationArea = All;
            }
            field("Qty. To Ship"; Rec."Qty. To Ship")
            {
                ApplicationArea = All;
            }
            field("Qty in Sq Mtr"; Rec."Qty in Sq Mtr")
            {
                ApplicationArea = All;
            }
            field("Releasing Date"; Rec."Releasing Date")
            {
                ApplicationArea = All;
            }
            field("Releasing Time"; Rec."Releasing Time")
            {
                ApplicationArea = All;
            }
            field("Completely Shipped"; Rec."Completely Shipped")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        tgTransferHeader: Record "Transfer Header";
        tgTransferList: Page "Transfer Orders";
        tgUserLocation: Record "User Location";

    trigger OnOpenPage()
    var
        LocationFilterString: Text[1000];
        UserLocation: Record "User Location";
    begin
        //Upgrade(+)
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Transfer Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF LocationFilterString <> '' THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code"
                ELSE
                    LocationFilterString := UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;


        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        //MESSAGE(LocationFilterString);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Transfer-from Code", LocationFilterString);
        //SETFILTER("Transfer-to Code",LocationFilterString);
        Rec.SETRANGE("External Transfer", FALSE);
        Rec.FILTERGROUP(0);
        //upgrade(-)

    end;


    procedure tgGetTransferOrderNo(): Code[20]
    begin
        EXIT(Rec."No.");
    end;
}

