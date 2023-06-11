pageextension 50176 pageextension50176 extends "Sales Quote"
{
    var
        "--NAVIN": Integer;
        MLTransactionType: Option Purchase,Sale;
        UserSetup: Record "User Setup";
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
        Text16500: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the Quote for Authorization?';
        Text13002: Label 'The Quote Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Quote Has been Rejected. Please Create A New Quote.';


    trigger OnOpenPage()
    begin
        //Upgarde(+)
        //TRI SC
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Quote", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');
        Rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //TRI SC

        //Upgrade(-)


    end;
}

