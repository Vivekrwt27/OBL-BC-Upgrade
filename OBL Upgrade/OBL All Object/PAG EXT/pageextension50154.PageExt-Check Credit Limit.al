pageextension 50154 pageextension50154 extends "Check Credit Limit"
{
    layout
    {
        addafter(Control2)
        {
            field("Balance (LCY)"; rec."Balance (LCY)")
            {
                Caption = 'Out Standing Balance';
                ApplicationArea = All;
            }
            field("Purchase Order Pending"; rec."Purchase Order Pending")
            {
                Caption = 'No. of Orders.';
                ApplicationArea = All;
            }
            field(Orderoustingamount; Orderoustingamount)
            {
                AutoFormatType = 1;
                Caption = 'Release Order Value';
                ApplicationArea = All;
            }
            field(OutBlankamt; OutBlankamt)
            {
                AutoFormatType = 1;
                Caption = 'Open Sales Order';
                Visible = true;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //TRI
                    TgSalesLine.RESET;
                    TgSalesLine.SETRANGE("Document Type", TgSalesLine."Document Type"::Order);
                    TgSalesLine.SETRANGE(Status, TgSalesLine.Status::Open);
                    TgSalesLine.SETRANGE("Sell-to Customer No.", rec."No.");
                    PAGE.RUN(Page::"Sales Lines", TgSalesLine);
                    //TRI
                end;
            }

        }

    }

    var
        "--TRI": Integer;
        recPaymentTerms: Record "Payment Terms";
        DueDate: Date;
        recSalesHeader: Record "Sales Header";
        recSalesLine: Record "Sales Line";
        CreditLimitDue: Decimal;
        BalText: Text[100];
        Bal: Decimal;
        CreditLimitDueDate: Decimal;
        DetCustLed: Record "Detailed Cust. Ledg. Entry";
        Orderoustingamount: Decimal;
        OutBlankamt: Decimal;
        TgSalesLine: Record "Sales Line";
        TgSalesHeader: Record "Sales Header";
        Text50000: Label 'Overdue Amounts (LCY) as of Due Date %1';
        Text50001: Label 'Total Overdue Amounts (LCY) as of Due Date %1';
        Text19015059: Label 'A';
        Text19015060: Label 'B';
        Text19015061: Label 'C';
        Text19034164: Label 'A + B';

    trigger OnAfterGetRecord()
    begin
        //Upgrade (+)

        IF Cust2.GET(rec."No.") THEN
            IF recSalesHeader.GET(Cust2."Sales Header Type", Cust2."Sales Header No.") THEN
                DueDate := recSalesHeader."Due Date";
        CalcOverdueBalanceLCYTRI;
        //Upgrade(-)
    end;

    procedure CalcOverdueBalanceLCYTRI()
    var
        Cust: Record Customer;
        CustNo: Code[20];
    begin
        IF rec."No." = CustNo THEN BEGIN //MSKS2103
            Cust.GET(rec."No.");
            IF Cust.GETFILTER("Date Filter") = '' THEN
                Cust.SETFILTER("Date Filter", '..%1', DueDate);
            Cust.CALCFIELDS("Balance Due (LCY)");
            CreditLimitDueDate := Cust."Balance Due (LCY)";
        END; //MSKS2103
    end;

    procedure CalcReleasedOutstandingAmount(var Orderoustingamount: Decimal): Decimal
    begin
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status);
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Bill-to Customer No.", rec."No.");
        SalesLine.SETRANGE(Status, SalesLine.Status::Released);
        //SalesLine.CALCSUMS("Outstanding Amount (LCY)");
        //  SalesLine.CALCSUMS("Amount To Customer");
        //  Orderoustingamount := SalesLine."Amount To Customer";
        //Orderoustingamount := SalesLine."Outstanding Amount";
    end;

    var
        SalesLine: Record "Sales Line";
        Cust2: Record Customer;
}

