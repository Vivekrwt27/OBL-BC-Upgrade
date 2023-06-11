pageextension 50017 pageextension50017 extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("PO No."; rec."PO No.")
            {
                ApplicationArea = All;
            }
            field("Group Code"; rec."Group Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("<Pposting Date>"; rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("<Ddocument Date>"; rec."Document Date")
            {
                ApplicationArea = All;
            }
            field("<Rrequested Delivery Date>"; rec."Requested Delivery Date")
            {
                Editable = false;
                ApplicationArea = All;

            }
            field("<Ppromised Delivery Date>"; rec."Promised Delivery Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("<Oorder No.>"; rec."Order No.")
            {
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("<Eexternal Document No.>"; rec."External Document No.")
            {
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("<Ssalesperson Code>"; rec."Salesperson Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter("&Track Package")
        {
            action("Sales - Shipment")
            {
                Caption = 'Sales - Shipment';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    SalesShptHeader.PrintRecords(TRUE);
                end;
            }
            action("Factory Gate Pass GR No. Wise")
            {
                Caption = 'Factory Gate Pass GR No. Wise';
                ApplicationArea = All;

                trigger OnAction()
                begin

                    //CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    RecSalesshptHeader.RESET();
                    RecSalesshptHeader.SETCURRENTKEY("GR No.");
                    RecSalesshptHeader.SETRANGE("GR No.", Rec."GR No.");
                    RecSalesshptHeader.SETRANGE("Location Code", Rec."Location Code");
                    IF RecSalesshptHeader.FINDSET() THEN;
                    ReportFactoryGatePassGRN.SETTABLEVIEW(RecSalesshptHeader);
                    ReportFactoryGatePassGRN.RUN();
                end;
            }
            action("Factory Gate Pass")
            {
                Caption = 'Factory Gate Pass';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    ReportFactoryGatePass.SETTABLEVIEW(SalesShptHeader);
                    ReportFactoryGatePass.RUN;
                end;
            }
            action("Factory Gate Pass-Trading")
            {
                Caption = 'Factory Gate Pass-Trading';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    "ReportFactoryGatePass-Trading".SETTABLEVIEW(SalesShptHeader);
                    "ReportFactoryGatePass-Trading".RUN;
                end;
            }
        }
    }

    var
        SalesShptHeader: Record "Sales Shipment Header";
        ReportFactoryGatePass: Report "Factory Gate Pass";
        "ReportFactoryGatePass-Trading": Report "Sales Data (Sales Journal New)";
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        RecSalesshptHeader: Record "Sales Shipment Header";
        ReportFactoryGatePassGRN: Report "Factory Gate Pass GR No. Wise";

    trigger OnOpenPage()
    begin
        //Upgrade(+)
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
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

        //upgrade(-)

    end;
}

