pageextension 50280 pageextension50280 extends "Posted Transfer Shipments"
{

    layout
    {

        addafter("No.")
        {
            field("Acknowledgement No."; Rec."Acknowledgement No.")
            {
                ApplicationArea = All;
            }
            field("IRN Hash"; Rec."IRN Hash")
            {
                ApplicationArea = All;
            }
            field("QR Code"; Rec."QR Code")
            {
                ApplicationArea = All;
            }
            field("Acknowledgement Date"; Rec."Acknowledgement Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Transfer-From Code")
        {
            field("Created ID"; Rec."Created ID")
            {
                ApplicationArea = All;
            }
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Transfer-to Code"; "Posting Date")
        addafter("Transfer-to Code")
        {
            field("Releasing Date"; Rec."Releasing Date")
            {
                ApplicationArea = All;
            }
            field("Releasing Time"; Rec."Releasing Time")
            {
                ApplicationArea = All;
            }
            /*field("Posting Date"; Rec."Posting Date") //16225 move Field 
            {
            }*/
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = All;
            }
            field("Transporter's Name"; Rec."Transporter's Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("E-Way No."; Rec."E-Way No.")
            {
                Editable = false;
                Importance = Promoted;
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action("Factory Gate Pass1")
            {
                Caption = 'Factory Gate Pass1';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Factory Gate Pass1";
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(TransShptHeader);
                    TransShptHeader.PrintRecords(TRUE);
                end;
            }
        }
        addafter("&Navigate")
        {
            action(GenerateIRN)
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN //093020D //16225
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("Acknowledgement No.", '');
                    Rec.TESTFIELD("Acknowledgement Date", '');
                    CLEAR(APIManagementEY);
                    TransShptHeader.RESET;
                    TransShptHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF TransShptHeader.FINDFIRST THEN BEGIN
                        APIManagementEY.SetTransferShipHeader(TransShptHeader);
                        APIManagementEY.GenerateTransferInvoiceJSONSchema(TransShptHeader);
                    END;
                end;
            }
            action("Cancel IRN")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN //093020D //16225
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("Acknowledgement No.");
                    Rec.TESTFIELD("Acknowledgement Date");
                    Rec.TESTFIELD("IRN Hash");
                    IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                        CLEAR(APIManagementEY);
                        TransShptHeader.RESET;
                        TransShptHeader.SETFILTER("No.", '%1', Rec."No.");
                        IF TransShptHeader.FINDFIRST THEN BEGIN
                            APIManagementEY.SetTransferShipHeader(TransShptHeader);
                            APIManagementEY.CancelTrfShipIRNNo(TransShptHeader);
                        END;
                    END;
                end;
            }
        }
    }

    var
        UserLocation: Record "User Location";
        APIManagementEY: Codeunit "API Management -EY 2.6";
        TransShptHeader: Record "Transfer Shipment Header";


}

