pageextension 50043 pageextension50043 extends "Posted Sales Credit Memos"
{
    layout
    {
        addfirst(Control1)
        {
            field("Acknowledgement No."; rec."Acknowledgement No.")
            {
                ApplicationArea = All;
            }
            field("IRN Hash"; rec."IRN Hash")
            {
                ApplicationArea = All;
            }
            field("QR Code"; rec."QR Code")
            {
                ApplicationArea = All;
            }
            field("Acknowledgement Date"; rec."Acknowledgement Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Exchange Status")
        {
            field("Posting Description"; rec."Posting Description")
            {
                ApplicationArea = All;
            }
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("GST Customer Type"; rec."GST Customer Type")
            {
                ApplicationArea = All;
            }
            field("User ID"; rec."User ID")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter("&Print")
        {
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


            action("Pending E-Invoice")
            {
                Caption = 'Pending E-Invoice';
                ApplicationArea = all;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Category7;

                trigger OnAction()
                var
                    Pendding: Report 50336;

                begin
                    Pendding.Run();
                end;
            }//16767


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

