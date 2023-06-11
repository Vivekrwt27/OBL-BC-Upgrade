page 50050 "Prompt Payment Discount"
{
    InsertAllowed = false;
    PageType = Card;
    Permissions = TableData "Cust. Ledger Entry" = rimd;
    SourceTable = "Prompt Payment Discount";
    SourceTableView = SORTING("Invoice No.")
                      ORDER(Ascending)
                      WHERE("Credit Memo No." = FILTER(''));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StateFilter; StateFilter)
                {
                    Caption = 'State Filter';
                    TableRelation = State;
                    ApplicationArea = All;
                }
                field(CustomerNo; CustomerNo)
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Customer.RESET;
                        Customer.SETFILTER(Customer."State Code", '%1', StateFilter);
                        IF PAGE.RUNMODAL(Page::"Customer List", Customer) = ACTION::LookupOK THEN BEGIN
                            CustomerNo := Customer."No.";
                            DiscountDays := Customer."PPD No. of Days";
                            DiscountPercentage := Customer."PPD %";
                            PaymentTermsDays := Customer."Payment Terms Days";
                            CustomerName := Customer.Name;
                            Rec.SETFILTER("Customer Code", CustomerNo);
                            CurrPage.UPDATE;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        IF Customer.GET(CustomerNo) THEN
                            CustomerName := Customer.Name;
                        CustomerNoOnAfterValidate;
                    end;
                }
                field(CustomerName; CustomerName)
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field(DateFilter; DateFilter)
                {
                    Caption = 'Date Filter';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ApplicationManagement.MakeDateFilter(DateFilter); //16225 Codunit N/F
                        Customer.SETFILTER(Customer."Date Filter", DateFilter);
                        IF Customer.GETFILTER(Customer."Date Filter") <> '' THEN
                            DateFilter := Customer.GETFILTER(Customer."Date Filter");
                        DateFilterOnAfterValidate;
                    end;
                }
                field(DiscountDays; DiscountDays)
                {
                    Caption = 'Discount No. Days';
                    ApplicationArea = All;
                }
                field(DiscountPercentage; DiscountPercentage)
                {
                    Caption = 'Discount %';
                    ApplicationArea = All;
                }
                field(PaymentTermsDays; PaymentTermsDays)
                {
                    Caption = 'Payment Terms Days';
                    ApplicationArea = All;
                }
                field(AdjustmentPercentage; AdjustmentPercentage)
                {
                    Caption = 'Adjustment %';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            repeater(Control1000000000)
            {
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Due Date"; Rec."Payment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Total Payment Received"; Rec."Total Payment Received")
                {
                    ApplicationArea = All;
                }
                field("Payment Rcpt. Date"; Rec."Payment Rcpt. Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                }
                field("Discount Applicable For Days"; Rec."Discount Applicable For Days")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //DiscountApplicableForDaysOnAfterValidate;  code blocked for upgradation
                    end;
                }
                field("Tax Adjustment"; Rec."Tax Adjustment")
                {
                    ApplicationArea = All;
                }
                field("Discount No. of Days"; Rec."Discount No. of Days")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //DiscountNoofDaysOnAfterValidate;  //Code blocked for upgradation
                    end;
                }
                field("Discount Date"; Rec."Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Discount %"; Rec."Discount %")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Discount37OnAfterValidate;
                    end;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DiscountAmountOnAfterValidate;
                    end;
                }
            }
            field(TotalDiscount; TotalDiscount)
            {
                Caption = 'Total Discount';
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Get Lines")
                {
                    Caption = '&Get New Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        GLSetup.GET;

                        IF CustomerNo = '' THEN
                            ERROR('Please select a Customer.');
                        IF CONFIRM('Do you want to get new lines for %1', TRUE, CustomerName) THEN BEGIN
                            Window.OPEN(Text001);
                            a := PromptPaymentDiscount.COUNT;
                            SalesSetup.GET;
                            PromptPaymentDiscount.RESET;
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.", "Posting Date", "Prompt Pmt. Discount");
                            SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Sell-to Customer No.", CustomerNo);
                            SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Posting Date", DateFilter);
                            //SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader.Discount,'%1',0);
                            SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Prompt Pmt. Discount", '%1', 0);
                            IF SalesInvoiceHeader.FIND('-') THEN
                                REPEAT
                                    //16225 Table N/F Start
                                    /*PostedStructureOrderDetails.RESET;
                                    PostedStructureOrderDetails.SETCURRENTKEY(Type,"Document Type","No.","Tax/Charge Type","Tax/Charge Group");
                                    PostedStructureOrderDetails.SETFILTER(Type,'%1',PostedStructureOrderDetails.Type::Sale);
                                    PostedStructureOrderDetails.SETFILTER("Document Type",'%1',PostedStructureOrderDetails."Document Type"::Invoice);
                                    PostedStructureOrderDetails.SETFILTER(PostedStructureOrderDetails."No.",'%1',SalesInvoiceHeader."No.");
                                    PostedStructureOrderDetails.SETFILTER("Tax/Charge Type",'%1',PostedStructureOrderDetails."Tax/Charge Type"::Charges);
                                    PostedStructureOrderDetails.SETFILTER(PostedStructureOrderDetails."Tax/Charge Group",'%1',GLSetup."Discount Charge");
                                    IF NOT PostedStructureOrderDetails.FIND('-') THEN*/
                                    //16225 Table N/F END
                                    IF NOT PromptPaymentDisc1.GET(SalesInvoiceHeader."No.") THEN BEGIN
                                        Window.UPDATE(1, SalesInvoiceHeader."No.");
                                        SalesInvoiceHeader.CALCFIELDS("Amount Including Excise");
                                        InvoiceAmt := 0;
                                        InvAmtWithSalesTax := 0;
                                        /*
                                        CustLedgerEntry.RESET;
                                        custledgerentry.setcurrentkey("Document No.","Document Type","Customer No.");
                                        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document No.",SalesInvoiceHeader."No.");
                                        CustLedgerEntry.SETFILTER("Document Type",'%1',CustLedgerEntry."Document Type"::Invoice);

                                        IF CustLedgerEntry.FIND('-') THEN REPEAT
                                          CustLedgerEntry.CALCFIELDS(Amount);
                                          InvoiceAmt := InvoiceAmt + CustLedgerEntry.Amount;
                                        UNTIL CustLedgerEntry.NEXT = 0;
                                        */
                                        //16225 Field N/F Start
                                        /* SalesInvoiceLine.RESET;
                                         SalesInvoiceLine.SETFILTER("Document No.", '%1', SalesInvoiceHeader."No.");
                                         IF SalesInvoiceLine.FIND('-') THEN
                                             REPEAT
                                                 InvoiceAmt := InvoiceAmt + SalesInvoiceLine.Amount + SalesInvoiceLine."Excise Amount";///16225 Block

                                                 InvAmtWithSalesTax := InvAmtWithSalesTax + SalesInvoiceLine.Amount + SalesInvoiceLine."Excise Amount" +
                                                 SalesInvoiceLine."Tax Amount";
                                             UNTIL SalesInvoiceLine.NEXT = 0;*///16225 Field N/F End
                                        PromptPaymentDiscount."Invoice No." := SalesInvoiceHeader."No.";
                                        PromptPaymentDiscount.Date := SalesInvoiceHeader."Posting Date";
                                        PromptPaymentDiscount."Invoice Amount" := InvoiceAmt;//SalesInvoiceHeader."Amount Including Excise";
                                        PromptPaymentDiscount."Payment Due Date" := SalesInvoiceHeader."Posting Date" + PaymentTermsDays;
                                        PromptPaymentDiscount.VALIDATE("Payment Rcpt. Date", GetLastPaymentDate(SalesInvoiceHeader."No."));
                                        PromptPaymentDiscount."Total Payment Received" := GetTotalPaymentAmount(SalesInvoiceHeader."No.");
                                        IF InvAmtWithSalesTax <> 0 THEN
                                            PromptPaymentDiscount.VALIDATE(PromptPaymentDiscount."Tax Adjustment", (100 - (100 * InvoiceAmt / InvAmtWithSalesTax)));
                                        date1 := SalesInvoiceHeader."Posting Date" + PaymentTermsDays;
                                        date2 := GetLastPaymentDate(SalesInvoiceHeader."No.");
                                        Days := 0;
                                        IF date1 > date2 THEN
                                            IF (date1 <> 0D) AND (date2 <> 0D) THEN
                                                REPEAT
                                                    date1 := date1 - 1;
                                                    Days := Days + 1;
                                                UNTIL date1 = date2;
                                        PromptPaymentDiscount.VALIDATE("No. of Days", Days);
                                        PromptPaymentDiscount.VALIDATE("Discount No. of Days", DiscountDays);
                                        PromptPaymentDiscount.VALIDATE("Discount %", DiscountPercentage);
                                        PromptPaymentDiscount."Customer Code" := SalesInvoiceHeader."Sell-to Customer No.";
                                        PromptPaymentDiscount."Discount Date" := WORKDATE;
                                        IF FORMAT(GetLastPaymentDate(SalesInvoiceHeader."No.")) <> '' THEN
                                            IF Days > 0 THEN
                                                PromptPaymentDiscount.INSERT(TRUE);
                                        COMMIT;
                                    END;
                                UNTIL SalesInvoiceHeader.NEXT = 0;
                            Window.CLOSE;
                            MESSAGE('%1 New line(s) added.', PromptPaymentDiscount.COUNT - a);
                        END;

                    end;
                }
                action("Generate &Credit Memo")
                {
                    Caption = '&Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.NEXT;
                        IF CONFIRM('Do you want to generate credit Memo?', TRUE) THEN BEGIN
                            IF TotalDiscount = 0 THEN
                                ERROR('There is nothing to generate Credit memo.');
                            SalesHeader.INIT;
                            SalesSetup.GET;
                            SalesHeader.VALIDATE(SalesHeader."Document Type", SalesHeader."Document Type"::"Credit Memo");
                            SalesHeader."No." := noseriesmgt.GetNextNo(SalesSetup."Credit Memo Nos.", WORKDATE, TRUE);
                            SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.", CustomerNo);
                            SalesHeader.VALIDATE(SalesHeader."Document Date", WORKDATE);
                            SalesHeader.INSERT(TRUE);
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", SalesLine."Document Type"::"Credit Memo");
                            SalesLine.VALIDATE(SalesLine."Document No.", SalesHeader."No.");
                            SalesLine.VALIDATE(SalesLine."Line No.", 10000);
                            SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::"G/L Account");
                            SalesLine.VALIDATE(SalesLine."No.", SalesSetup."Prompt Pmt. Account No.");
                            SalesLine.VALIDATE(SalesLine.Quantity, 1);
                            SalesLine.VALIDATE(SalesLine."Unit Price", TotalDiscount);
                            SalesLine.INSERT(TRUE);

                            MESSAGE('Credit Memo %1 has been generated.', SalesHeader."No.");

                            PromptPaymentDiscount.RESET;
                            PromptPaymentDiscount.SETFILTER(PromptPaymentDiscount."Customer Code", CustomerNo);
                            PromptPaymentDiscount.SETFILTER(PromptPaymentDiscount."Credit Memo No.", '%1', '');
                            IF PromptPaymentDiscount.FIND('-') THEN
                                REPEAT
                                    CustLedgerEntry.RESET;
                                    CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
                                    CustLedgerEntry.SETFILTER(CustLedgerEntry."Document No.", PromptPaymentDiscount."Invoice No.");
                                    IF CustLedgerEntry.FIND('-') THEN
                                        REPEAT
                                            CustLedgerEntry."Applies-to ID" := SalesHeader."No.";
                                            CustLedgerEntry.MODIFY(TRUE);
                                        UNTIL CustLedgerEntry.NEXT = 0;
                                UNTIL PromptPaymentDiscount.NEXT = 0

                        END;
                    end;
                }
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
            action("^")
            {
                Caption = '^';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Customer.RESET;
                    Customer.SETFILTER(Customer."Prompt Pmt. Details", '%1', TRUE);
                    IF Customer.FIND('-') THEN
                        REPEAT
                            Customer."Prompt Pmt. Details" := FALSE;
                            Customer.MODIFY;
                        UNTIL Customer.NEXT = 0;

                    PromptPaymentDisc1.RESET;
                    PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Credit Memo No.", '%1', '');
                    IF PromptPaymentDisc1.FIND('-') THEN
                        REPEAT
                            IF Customer.GET(PromptPaymentDisc1."Customer Code") THEN BEGIN
                                Customer."Prompt Pmt. Details" := TRUE;
                                Customer.MODIFY;
                            END;
                        UNTIL PromptPaymentDisc1.NEXT = 0;
                    COMMIT;
                    Customer.RESET;
                    Customer.SETFILTER(Customer."Prompt Pmt. Details", '%1', TRUE);
                    Customer.SETFILTER(Customer."State Code", '%1', StateFilter);
                    IF PAGE.RUNMODAL(Page::"Customer List", Customer) = ACTION::LookupOK THEN
                        IF Customer."No." <> '' THEN BEGIN

                            CustomerNo := Customer."No.";

                            IF Customer.GET(CustomerNo) THEN
                                CustomerName := Customer.Name;

                            Rec.SETFILTER("Customer Code", CustomerNo);
                            CurrPage.UPDATE;
                        END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Customer Code", CustomerNo);
        PromptPaymentDisc1.SETFILTER(Date, DateFilter);
        PromptPaymentDisc1.SETFILTER("Credit Memo No.", '%1', '');
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount" /** (1 - AdjustmentPercentage/100)*/ ;
            UNTIL PromptPaymentDisc1.NEXT = 0;

        IF NOT Rec.HASFILTER THEN
            ERROR('Please Select a Customer.');

    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Customer Code", '%1', '');
    end;

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        PromptPaymentDisc1: Record "Prompt Payment Discount";
        PromptPaymentDiscount: Record "Prompt Payment Discount";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        CustomerNo: Code[20];
        CustomerName: Text[100];
        DateFilter: Text[50];
        DiscountDays: Integer;
        DiscountPercentage: Decimal;
        // ApplicationManagement: Codeunit 1; //16225 Codunit N/F
        Days: Integer;
        date1: Date;
        date2: Date;
        Window: Dialog;
        Text001: Label 'Sales Invoice No. #1##########';
        TotalDiscount: Decimal;
        SalesHeader: Record "Sales Header";
        noseriesmgt: Codeunit NoSeriesManagement;
        SalesLine: Record "Sales Line";
        a: Integer;
        InvoiceAmt: Decimal;
        PaymentTermsDays: Integer;
        AdjustmentPercentage: Decimal;
        GLSetup: Record "General Ledger Setup";
        // PostedStructureOrderDetails: Record "13760"; //16225 Table N/F
        StateFilter: Code[20];
        StateRec: Record State;
        SalesInvoiceLine: Record "Sales Invoice Line";
        InvAmtWithSalesTax: Decimal;

    procedure GetLastPaymentDate(var InvoiceNo: Code[20]) Lastdate: Date
    var
        PromptPayment: Record "Prompt Payment Discount";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry1: Record "Cust. Ledger Entry";
        I: Integer;
    begin
        //CLEAR(Lastdate);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        CustLedgerEntry.SETFILTER("Document No.", InvoiceNo);
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);

        IF CustLedgerEntry.FIND('-') THEN
            REPEAT
                IF CustLedgerEntry1.GET(CustLedgerEntry."Closed by Entry No.") THEN BEGIN
                    CustLedgerEntry1.MARK(TRUE);
                END;
                //  CustLedgerEntry1.RESET;
                CustLedgerEntry1.SETCURRENTKEY("Closed by Entry No.", "Document Type");
                CustLedgerEntry1.SETFILTER(CustLedgerEntry1."Closed by Entry No.", '%1', CustLedgerEntry."Entry No.");
                CustLedgerEntry1.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Payment);
                IF CustLedgerEntry1.FIND('-') THEN
                    REPEAT
                        CustLedgerEntry1.MARK(TRUE);
                    UNTIL CustLedgerEntry1.NEXT = 0;
            UNTIL CustLedgerEntry.NEXT = 0;
        //CustLedgerEntry1.RESET;
        CustLedgerEntry1.SETCURRENTKEY("Closed by Entry No.", "Posting Date");
        CustLedgerEntry1.SETFILTER(CustLedgerEntry1."Closed by Entry No.", '%1|<>%2', 0, 0);
        CustLedgerEntry1.MARKEDONLY(TRUE);
        IF CustLedgerEntry1.FIND('+') THEN
            Lastdate := CustLedgerEntry1."Posting Date";
    end;

    procedure GetTotalPaymentAmount(var InvoiceNo: Code[20]) Amt: Decimal
    var
        PromptPayment: Record "Prompt Payment Discount";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry1: Record "Cust. Ledger Entry";
        I: Integer;
    begin
        //Amt := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        CustLedgerEntry.SETFILTER("Document No.", InvoiceNo);
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);

        IF CustLedgerEntry.FIND('-') THEN
            REPEAT
                IF CustLedgerEntry1.GET(CustLedgerEntry."Closed by Entry No.") THEN BEGIN
                    CustLedgerEntry1.MARK(TRUE);
                END;
                //  CustLedgerEntry1.RESET;
                CustLedgerEntry1.SETCURRENTKEY("Closed by Entry No.", "Document Type");
                CustLedgerEntry1.SETFILTER(CustLedgerEntry1."Closed by Entry No.", '%1', CustLedgerEntry."Entry No.");
                CustLedgerEntry1.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Payment);
                IF CustLedgerEntry1.FIND('-') THEN
                    REPEAT
                        CustLedgerEntry1.MARK(TRUE);
                    UNTIL CustLedgerEntry1.NEXT = 0;
            UNTIL CustLedgerEntry.NEXT = 0;

        //CustLedgerEntry1.RESET;
        CustLedgerEntry1.SETCURRENTKEY("Closed by Entry No.", "Posting Date");
        CustLedgerEntry1.SETFILTER(CustLedgerEntry1."Closed by Entry No.", '%1|<>%2', 0, 0);
        CustLedgerEntry1.MARKEDONLY(TRUE);
        IF CustLedgerEntry1.FIND('-') THEN
            REPEAT
                CustLedgerEntry1.CALCFIELDS(Amount);
                Amt := Amt + CustLedgerEntry1.Amount;
            UNTIL CustLedgerEntry1.NEXT = 0;
        Amt := ABS(Amt);
    end;

    local procedure DiscountApplicableForDaysOnAft()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Customer Code", CustomerNo);
        PromptPaymentDisc1.SETFILTER(Date, DateFilter);
        PromptPaymentDisc1.SETFILTER("Credit Memo No.", '%1', '');
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount";
            UNTIL PromptPaymentDisc1.NEXT = 0;
        CurrPage.UPDATE;
    end;

    local procedure DiscountNoofDaysOnAfterValidat()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Customer Code", CustomerNo);
        PromptPaymentDisc1.SETFILTER(Date, DateFilter);
        PromptPaymentDisc1.SETFILTER("Credit Memo No.", '%1', '');
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount";
            UNTIL PromptPaymentDisc1.NEXT = 0;
        CurrPage.UPDATE;
    end;

    local procedure Discount37OnAfterValidate()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Customer Code", CustomerNo);
        PromptPaymentDisc1.SETFILTER(Date, DateFilter);
        PromptPaymentDisc1.SETFILTER("Credit Memo No.", '%1', '');
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount";
            UNTIL PromptPaymentDisc1.NEXT = 0;
        CurrPage.UPDATE;
    end;

    local procedure DiscountAmountOnAfterValidate()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Customer Code", CustomerNo);
        PromptPaymentDisc1.SETFILTER(Date, DateFilter);
        PromptPaymentDisc1.SETFILTER("Credit Memo No.", '%1', '');
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount";
            UNTIL PromptPaymentDisc1.NEXT = 0;
        CurrPage.UPDATE;
    end;

    local procedure DateFilterOnAfterValidate()
    begin
        rec.SETFILTER(Date, DateFilter);
        CurrPage.UPDATE;
    end;

    local procedure CustomerNoOnAfterValidate()
    begin
        Rec.SETFILTER("Customer Code", CustomerNo);
        CurrPage.UPDATE;
    end;

    local procedure Control1000000031OnDeactivate()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount";
            UNTIL PromptPaymentDisc1.NEXT = 0;
    end;

    local procedure OnBeforePutRecord()
    begin
        TotalDiscount := 0;
        PromptPaymentDisc1.RESET;
        PromptPaymentDisc1.SETFILTER(PromptPaymentDisc1."Customer Code", CustomerNo);
        PromptPaymentDisc1.SETFILTER(Date, DateFilter);
        PromptPaymentDisc1.SETFILTER("Credit Memo No.", '%1', '');
        IF PromptPaymentDisc1.FIND('-') THEN
            REPEAT
                TotalDiscount := TotalDiscount + PromptPaymentDisc1."Discount Amount"/** (1 - AdjustmentPercentage/100)*/;
            UNTIL PromptPaymentDisc1.NEXT = 0;

        IF NOT Rec.HASFILTER THEN
            ERROR('Please Select a Customer.');

    end;
}

