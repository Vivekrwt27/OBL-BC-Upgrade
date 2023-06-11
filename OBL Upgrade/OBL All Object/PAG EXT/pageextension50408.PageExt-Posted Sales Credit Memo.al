pageextension 50408 pageextension50408 extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Structure Freight Amount"; Rec."Structure Freight Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Trade Discount"; Rec."Trade Discount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Insurance Amount"; Rec."Insurance Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Discount Amount"; Rec."Discount Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {

        addafter(ActivityLog)
        {
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                action("&Send BizTalk Sales Credit Memo")
                {
                    Caption = '&Send BizTalk Sales Credit Memo';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //BizTalkManagement.SendSalesCreditMemo(Rec);
                    end;
                }
            }
            group(Print1)
            {
                Caption = 'Print';
                action("Credit Memo (Sales)")
                {
                    Caption = 'Credit Memo (Sales)';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrForm.SETSELECTIONFILTER(SalesCrMemoHeader);
                        //SalesCrMemoHeader.PrintRecords(TRUE);
                        SalesCrMemoHeader.RESET;
                        SalesCrMemoHeader.SETFILTER(SalesCrMemoHeader."No.", Rec."No.");
                        CreditMemo.SETTABLEVIEW(SalesCrMemoHeader);
                        CreditMemo.RUN;
                    end;
                }
                action("PPD Credit Note")
                {
                    Caption = 'PPD Credit Note';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SalesCrMemoHeader.RESET;
                        SalesCrMemoHeader.SETFILTER(SalesCrMemoHeader."No.", Rec."No.");
                        //   CreditNote.SETTABLEVIEW(SalesCrMemoHeader);
                        //   CreditNote.RUN;
                    end;
                }
            }
        }
        addafter(IncomingDocument)
        {
            group("E-Invoice")
            {
                Caption = 'E-Invoice';
                action(GenerateIRN)
                {
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        APIManagementEY: Codeunit "API Management -EY 2.6";
                        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    begin
                        IF Rec."Posting Date" <= 20200930D THEN
                            ERROR('You cannot create IRN Before than 1st Oct 2020');
                        Rec.TESTFIELD("Acknowledgement No.", '');
                        Rec.TESTFIELD("Acknowledgement Date", 0DT);
                        CLEAR(APIManagementEY);
                        SalesCreditMemoHeader.RESET;
                        SalesCreditMemoHeader.SETFILTER("No.", '%1', Rec."No.");
                        IF SalesCreditMemoHeader.FINDFIRST THEN BEGIN
                            APIManagementEY.SetCrMemoHeader(SalesCreditMemoHeader);
                            APIManagementEY.GenerateSalesCreditJSONSchema(SalesCreditMemoHeader);
                        END;
                    end;
                }
                action("Cancel IRN")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        APIManagementEY: Codeunit "API Management -EY 2.6";
                        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    begin
                        IF Rec."Posting Date" <= 20200930D THEN
                            ERROR('You cannot create IRN Before than 1st Oct 2020');
                        Rec.TESTFIELD("Acknowledgement No.");
                        Rec.TESTFIELD("Acknowledgement Date");
                        Rec.TESTFIELD("IRN Hash");
                        IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                            CLEAR(APIManagementEY);
                            SalesCreditMemoHeader.RESET;
                            SalesCreditMemoHeader.SETFILTER("No.", '%1', Rec."No.");
                            IF SalesCreditMemoHeader.FINDFIRST THEN BEGIN
                                APIManagementEY.SetCrMemoHeader(SalesCreditMemoHeader);
                                APIManagementEY.CancelSalesCreditIRNNo(SalesCreditMemoHeader);
                            END;
                        END;
                    end;
                }
            }
        }
    }

    var
        // CreditNote: Report 50146;
        CreditMemo: Report "Credit Memo";
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";



    trigger OnOpenPage()
    begin
        //Upgrade(+)
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Credit memo", '%1', TRUE);
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

        //Upgrade(-)
    end;
}

