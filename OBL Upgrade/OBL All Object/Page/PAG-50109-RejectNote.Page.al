page 50109 "Reject Note"
{
    // 1. TRI V.D 30.10.10 - New Form created.

    Caption = 'Reject Note';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Rejection Purchase Header";
    SourceTableView = WHERE("Document Type" = filter(Order));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Rejection No."; Rec."Rejection No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'PO No.';
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = All;
                }
                field("Vendor Classification"; Rec."Vendor Classification")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Security Amount"; Rec."Security Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Security Date"; Rec."Security Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    Caption = 'Truck No.';
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("GE No."; Rec."GE No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quotation No."; Rec."Quotation No.")
                {
                    Caption = 'Quote No.';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    ApplicationArea = All;
                }
                field("Total Recd. Quantity"; Rec."Total Recd. Quantity")
                {
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part(RejectionLines; "Rejection Note Subform")
            {
                SubPageLink = "Rejection No." = FIELD("Rejection No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                }
                field("C Form"; Rec."C Form")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Form Code"; Rec."Form Code")
                {
                    ApplicationArea = All;
                }
                field("Form No."; Rec."Form No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Form 31 Amount"; Rec."Form 31 Amount")
                {
                    ApplicationArea = All;
                }
                field("Capital PO"; Rec."Capital PO")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension1CodeOnAfterValidate;
                        ShortcutDimension1CodeOnAfterV
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension2CodeOnAfterValidate;
                        ShortcutDimension2CodeOnAfterV
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //PricesIncludingVATOnAfterValidate;
                        PricesIncludingVATOnAfterValid
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Receiving No. Series"; Rec."Receiving No. Series")
                {
                    ApplicationArea = All;
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment Date"; Rec."Vendor Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Transporter's Code"; Rec."Transporter's Code")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Delivery Period"; Rec."Delivery Period")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = All;
                }
            }
            group("E-Commerce")
            {
                Caption = 'E-Commerce';
                field("BizTalk Purchase Order"; Rec."BizTalk Purchase Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Sent"; Rec."Time Sent")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Quote No."; Rec."Vendor Quote No.")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purch. Order Cnfmn."; Rec."BizTalk Purch. Order Cnfmn.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Received"; Rec."Date Received")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Received"; Rec."Time Received")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Receipt"; Rec."BizTalk Purchase Receipt")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Invoice"; Rec."BizTalk Purchase Invoice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Application)
            {
                Caption = 'Application';
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                field("GTA Service Type"; Rec."GTA Service Type")
                {
                    ApplicationArea = All;
                }
                field("Consignment Note No."; Rec."Consignment Note No.")
                {
                    ApplicationArea = All;
                }
                field("Declaration Form (GTA)"; Rec."Declaration Form (GTA)")
                {
                    ApplicationArea = All;
                }
                field("Input Service Distribution"; Rec."Input Service Distribution")
                {
                    ApplicationArea = All;
                }
                field("Transit Document"; Rec."Transit Document")
                {
                    ApplicationArea = All;
                }
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
                field("LC No."; Rec."LC No.")
                {
                    ApplicationArea = All;
                }
                field("Service Tax Rounding Precision"; Rec."Service Tax Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Service Tax Rounding Type"; Rec."Service Tax Rounding Type")
                {
                    ApplicationArea = All;
                }
                group("Manufacturer Detail")
                {
                    Caption = 'Manufacturer Detail';
                    field("Manufacturer E.C.C. No."; Rec."Manufacturer E.C.C. No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Manufacturer Name"; Rec."Manufacturer Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Manufacturer Address"; Rec."Manufacturer Address")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Rejection Advice")
                {
                    Caption = 'Rejection Advice';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        RecRejpurchline.RESET;
                        RecRejpurchline.SETFILTER("Rejection No.", '%1', Rec."Rejection No.");
                        //RecRejpurchline.SETFILTER("No.","No.");
                        RejectionAdvice.SETTABLEVIEW(RecRejpurchline);
                        RejectionAdvice.RUN;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
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

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);//250

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        //Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //ND Tri End Cust 38
        //TRI SC
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2. Do you wish to continue?';
        //   PurchInfoPaneMgmt: Codeunit 7181;
        PurchLine: Record "Purchase Line";
        //  DefermentBuffer: Record 16532;
        Text0001: Label 'Challan Quantity must be filled in.';
        Text0002: Label 'Actual Quantity must be filled in.';
        Text0003: Label 'Accepted Quantity must be filled in.';
        Text0004: Label 'Rejection Reason Code must be entered.';
        Text0005: Label 'Shortage Reason Code must be entered.';
        Text0006: Label 'Status must be Released while posting.';
        Text0007: Label 'Status must be Open while changing the "Buy-from Post code".';
        Text000: Label 'Do you want to convert the Order to an Import order?';
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        ShortClose: Codeunit ShortClose;
        UserSetup: Record "User Setup";
        IndentLine: Record "Indent Line";
        PurchaseLine2: Record "Purchase Line";
        GetFilters: Code[80];
        LineNo1: Integer;
        IndentHeader: Record "Indent Header";
        IndentLine1: Record "Indent Line";
        IndentHeader1: Record "Indent Header";
        IndentLine2: Record "Indent Line";
        IndentHeader2: Record "Indent Header";
        LockPurchDoc: Codeunit "Lock Sales Document";
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
        RecRejpurchline: Record "Rejection Purchase Line";
        RejectionAdvice: Report 50209;
        Test: Code[10];

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.RejectionLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.RejectionLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.RejectionLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.RejectionLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

