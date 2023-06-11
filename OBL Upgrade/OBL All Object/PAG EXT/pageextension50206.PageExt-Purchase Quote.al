pageextension 50206 pageextension50206 extends "Purchase Quote"
{
    layout
    {

        modify("Currency Code")
        {
            trigger OnAssistEdit()
            begin
                CurrPage.Update();
            end;
        }
        addafter(Status)
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
            }
        }

    }

    var
        "-- NAVIN": Integer;
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        UserSetup: Record "User Setup";
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];




    trigger OnOpenPage()
    begin

        //Upgrade(+)
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Quote", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);
        //ND Tri End Cust 38
        //TRI SC
        //Upgrade(-)
    end;
}

