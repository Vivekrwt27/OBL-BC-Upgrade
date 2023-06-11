pageextension 50379 pageextension50379 extends "Purchase Order List"
{
    layout
    {
        addafter("Pay-to Country/Region Code")
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
            }



        }

        addafter("Requested Receipt Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }

            field("Prices Including VAT"; Rec."Prices Including VAT")
            {
                ApplicationArea = All;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }



        }
        addafter("Job Queue Status")
        {
            field(Receive; Rec.Receive)
            {
                ApplicationArea = All;
            }
            field(Invoice; Rec.Invoice)
            {
                ApplicationArea = All;
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;
            }
            field("Nature of Expense"; Rec.NOE)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("NOE Name"; NOEName)
            {
                TableRelation = "NOE Permission".Name WHERE(NOE = FIELD(NOE),
                                                             Location = FIELD("Location Code"));
                Visible = false;
                ApplicationArea = All;
            }
            field("Capex No."; Rec."Capex No.")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Currency Factor"; Amount)
    }
    actions
    {
        modify(Release)
        {
            Visible = false;
            Enabled = false;
        }
        modify(Reopen)
        {
            Visible = false;
            Enabled = false;
        }
    }

    var
        LocationFilterString: Text;
        UserLocation: Record "User Location";
        PayTermDesc: Text;
        recPayTerms: Record "Payment Terms";
        recPurchHdr: Record "Purchase Header";
        NOEName: Text;

    trigger OnAfterGetRecord()
    begin
        //MSVRN //270318 >>
        recPurchHdr.RESET;
        recPurchHdr.SETRANGE("Document Type", recPurchHdr."Document Type"::Order);
        recPurchHdr.SETRANGE("No.", rec."No.");
        IF recPurchHdr.FINDFIRST THEN
            REPEAT
                recPayTerms.RESET;
                recPayTerms.SETRANGE(Code, rec."Payment Terms Code");
                IF recPayTerms.FINDFIRST THEN
                    PayTermDesc := recPayTerms.Description
                ELSE
                    PayTermDesc := '';
            UNTIL recPurchHdr.NEXT = 0;
        //MSVRN //270318 <<

    end;

    trigger OnOpenPage()
    begin
        //TCPL::6904 21 JULY 2016
        //upgrade(+)
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Order", '%1', TRUE);
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

        //Upgrade(-)

    end;
}

