page 50062 "Sales Scheme"
{
    // //mo customization no. 47 start

    Description = 'Customization No. 47';
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            field(Scheme; Scheme)
            {
                Caption = 'Scheme';
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF PAGE.RUNMODAL(PAGE::"Item Charges", ItemCharge) = ACTION::LookupOK THEN
                        Scheme := ItemCharge."No.";
                end;
            }
            field(CustomerNo; CustomerNo)
            {
                Caption = 'Customer No';
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF PAGE.RUNMODAL(PAGE::"Customer List", Cust) = ACTION::LookupOK THEN
                        CustomerNo := Cust."No.";
                end;
            }
            field(FromDate; FromDate)
            {
                Caption = 'From Date';
                ApplicationArea = All;
            }
            field(ToDate; ToDate)
            {
                Caption = 'To Date';
                ApplicationArea = All;
            }
            field(Amt; Amt)
            {
                Caption = 'Amount';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&OK")
            {
                Caption = '&OK';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //mo customization no. 47 start
                    TotQtyAssigned := 0;
                    IF Scheme = '' THEN
                        ERROR('Scheme must be filled in');
                    IF CustomerNo = '' THEN
                        ERROR('Customer must be filled in');
                    IF FromDate = 0D THEN
                        ERROR('From Date must be filled in');
                    IF ToDate = 0D THEN
                        ERROR('To Date must be filled in');
                    IF Amt = 0.0 THEN
                        ERROR('Amount must be filled in');

                    IF CONFIRM(STRSUBSTNO(Text003, Scheme)) THEN BEGIN

                        SalesShpHeader.RESET;
                        SalesShpHeader.SETRANGE("Sell-to Customer No.", CustomerNo);
                        SalesShpHeader.SETRANGE("Posting Date", FromDate, ToDate);
                        IF SalesShpHeader.FIND('-') THEN
                            REPEAT
                                SalesShpLine.RESET;
                                SalesShpLine.SETFILTER("Document No.", SalesShpHeader."No.");
                                IF SalesShpLine.FIND('-') THEN
                                    REPEAT
                                        ItemLedgerEntry.RESET;
                                        ItemLedgerEntry.SETFILTER("Document No.", SalesShpLine."Document No.");
                                        ItemLedgerEntry.SETFILTER("Item No.", SalesShpLine."No.");
                                        IF ItemLedgerEntry.FIND('-') THEN BEGIN
                                            ValueEntry.RESET;
                                            ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                            ValueEntry.SETFILTER("Item Charge No.", Scheme);
                                            IF NOT ValueEntry.FIND('-') THEN
                                                Bool := TRUE;
                                        END;
                                    UNTIL SalesShpLine.NEXT = 0;
                            UNTIL SalesShpHeader.NEXT = 0
                        ELSE
                            ERROR('No Shipment has been done for %1 during period %2 to %3', CustomerNo, FromDate, ToDate);

                        IF Bool = FALSE THEN
                            ERROR(Text001, Scheme);

                        IF Bool = TRUE THEN BEGIN
                            SalesHeader.INIT;
                            SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
                            SalesSetUp.GET;
                            TestNoSeries;
                            SalesHeaderNo := NoSeriesMgt.GetNextNo(GetNoSeriesCode, WORKDATE, TRUE);
                            SalesHeader.VALIDATE("No.", SalesHeaderNo);
                            SalesHeader."Posting Date" := WORKDATE;
                            SalesHeader.VALIDATE("Sell-to Customer No.", CustomerNo);
                            SalesHeader.INSERT(TRUE);

                            SalesLine.INIT;
                            SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                            SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                            SalesLine.VALIDATE("Line No.", 10000);
                            SalesLine.VALIDATE(Type, SalesLine.Type::"Charge (Item)");
                            SalesLine.VALIDATE("No.", Scheme);
                            SalesLine.VALIDATE(Quantity, 100);
                            SalesLine.VALIDATE("Unit Price", Amt / 100);
                            SalesLine.INSERT(TRUE);

                            //monika try
                            SalesShpHeader.RESET;
                            SalesShpHeader.SETRANGE("Sell-to Customer No.", CustomerNo);
                            SalesShpHeader.SETRANGE("Posting Date", FromDate, ToDate);
                            IF SalesShpHeader.FIND('-') THEN
                                REPEAT
                                    SalesShpLine.RESET;
                                    SalesShpLine.SETFILTER("Document No.", SalesShpHeader."No.");
                                    IF SalesShpLine.FIND('-') THEN
                                        REPEAT
                                            TotAmt += SalesShpLine."Unit Price" * SalesShpLine.Quantity;
                                        UNTIL SalesShpLine.NEXT = 0;
                                UNTIL SalesShpHeader.NEXT = 0;

                            SalesShpHeader.RESET;
                            SalesShpHeader.SETRANGE("Sell-to Customer No.", CustomerNo);
                            SalesShpHeader.SETRANGE("Posting Date", FromDate, ToDate);
                            IF SalesShpHeader.FIND('-') THEN
                                REPEAT
                                    SalesShpLine.RESET;
                                    SalesShpLine.SETFILTER("Document No.", SalesShpHeader."No.");
                                    IF SalesShpLine.FIND('-') THEN
                                        REPEAT
                                            ItemLedgerEntry.RESET;
                                            ItemLedgerEntry.SETFILTER("Document No.", SalesShpLine."Document No.");
                                            ItemLedgerEntry.SETFILTER("Item No.", SalesShpLine."No.");
                                            IF ItemLedgerEntry.FIND('-') THEN BEGIN
                                                ValueEntry.RESET;
                                                ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                                ValueEntry.SETFILTER("Item Charge No.", Scheme);
                                                IF NOT ValueEntry.FIND('-') THEN BEGIN
                                                    ItemChargeAssignSales.INIT;
                                                    ItemChargeAssignSales.VALIDATE("Document Type", ItemChargeAssignSales."Document Type"::"Credit Memo");
                                                    ItemChargeAssignSales.VALIDATE("Document No.", SalesHeaderNo);
                                                    ItemChargeAssignSales.VALIDATE("Document Line No.", 10000);
                                                    LNo := LNo + 10000;
                                                    ItemChargeAssignSales.VALIDATE("Line No.", LNo);
                                                    ItemChargeAssignSales.VALIDATE("Item Charge No.", Scheme);
                                                    ItemChargeAssignSales.VALIDATE("Item No.", SalesShpLine."No.");
                                                    ItemChargeAssignSales.VALIDATE("Applies-to Doc. No.", SalesShpLine."Document No.");
                                                    ItemChargeAssignSales.VALIDATE("Applies-to Doc. Line No.", SalesShpLine."Line No.");
                                                    Amnt := SalesShpLine."Unit Price" * SalesShpLine.Quantity;
                                                    //QtyAssign := (Amnt/Amt)*100;

                                                    QtyAssign := 100 / TotAmt * Amnt;
                                                    ItemChargeAssignSales.VALIDATE("Qty. to Assign", QtyAssign);
                                                    ItemChargeAssignSales.VALIDATE("Unit Cost", Amt / 100);
                                                    ItemChargeAssignSales.VALIDATE("Applies-to Doc. Type",
                                                    ItemChargeAssignSales."Applies-to Doc. Type"::Shipment);
                                                    ItemChargeAssignSales.INSERT(TRUE);
                                                END;
                                            END;
                                        UNTIL SalesShpLine.NEXT = 0;
                                UNTIL SalesShpHeader.NEXT = 0;
                            SalesLine.VALIDATE("Unit Price", Amt / 100);
                            SalesLine.MODIFY;
                            MESSAGE(Text002, SalesHeaderNo);
                            //new added
                            ItemChargeAssignSales.RESET;
                            ItemChargeAssignSales.SETRANGE("Document Type", ItemChargeAssignSales."Document Type"::"Credit Memo");
                            ItemChargeAssignSales.SETFILTER("Document No.", SalesHeaderNo);
                            ItemChargeAssignSales.SETFILTER("Document Line No.", '%1', 10000);
                            IF ItemChargeAssignSales.FIND('-') THEN
                                REPEAT
                                    QtyAssign := ROUND(ItemChargeAssignSales."Qty. to Assign", 0.01, '=');
                                    TotQtyAssigned += QtyAssign;
                                    ItemChargeAssignSales.VALIDATE("Qty. to Assign", QtyAssign);
                                    ItemChargeAssignSales.VALIDATE("Unit Cost", Amt / 100);

                                    ItemChargeAssignSales.MODIFY;
                                UNTIL ItemChargeAssignSales.NEXT = 0;
                            MESSAGE('%1', TotQtyAssigned);
                            IF TotQtyAssigned <> 100 THEN BEGIN
                                QtyAssign := ItemChargeAssignSales."Qty. to Assign";
                                ItemChargeAssignSales.VALIDATE("Qty. to Assign", QtyAssign + (100 - TotQtyAssigned));
                                ItemChargeAssignSales.VALIDATE("Unit Cost", Amt / 100);
                                ItemChargeAssignSales.MODIFY;
                            END;

                        END;


                    END;


                    FromDate := 0D;
                    ToDate := 0D;
                    CustomerNo := '';
                    Scheme := '';
                    Amt := 0;
                    //mo customization no. 47 end
                end;
            }
            action("&Cancel")
            {
                Caption = '&Cancel';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        Scheme: Code[20];
        FromDate: Date;
        ToDate: Date;
        Amt: Decimal;
        ItemCharge: Record "Item Charge";
        SalesSetUp: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[250];
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNo: Code[20];
        SalesShpLine: Record "Sales Shipment Line";
        SalesShpHeader: Record "Sales Shipment Header";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        SalesLine: Record "Sales Line";
        ItemChargeAssignSales: Record "Item Charge Assignment (Sales)";
        LNo: Integer;
        SalesHeaderNo: Code[20];
        Amnt: Decimal;
        QtyAssign: Decimal;
        Bool: Boolean;
        Text001: Label 'Scheme %1 has already been applied to the Shipment Lines.';
        Text002: Label 'Credit Memo %1 has been generated.';
        Text003: Label 'Are you sure you want to generate the credit memo.';
        TotQtyAssigned: Decimal;
        TotAmt: Decimal;

    local procedure TestNoSeries(): Boolean
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
            SalesSetUp.TESTFIELD("Credit Memo Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
            EXIT(SalesSetUp."Credit Memo Nos.");
        END;
    end;
}

