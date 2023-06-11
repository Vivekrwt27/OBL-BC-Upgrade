report 50043 "Factory Gate Pass"
{
    // 
    // //-- 1. Tri30.0 PG 14112006 -- Code Added In "Sales Shipment Line - OnPreDataItem()"
    // //-- 2. Tri30.0 PG 14112006 -- Code Added In "Sales Shipment Line - OnAfterGetRecord()"
    // //-- 3. Tri30.0 PG 14112006 -- New Labels Added In Section "Sales Shipment Line, Header (1)"
    // //-- 4. Tri30.0 PG 14112006 -- New Fields Added In Section "Sales Shipment Line, Body (2)"
    // //-- 5. Tri30.0 PG 14112006 -- New Fields Added In Section "Sales Shipment Line, Footer (3)"
    // //-- 6. Tri30.0 PG 14112006 -- Changes Done In Table No. 27   (Item)
    // //-- 7. Tri30.0 PG 14112006 -- Changes Done In Table No. 313  (Inventory Setup)
    // //-- 8. Tri30.0 PG 14112006 -- Changes Done In Form No.  461  (Inventory Setup)
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\FactoryGatePass.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Shipment Header"; 110)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Posting Date", "Location Code";
            column(CompName; "Company Information".Name)
            {
            }
            column(CompAddress1; RecLocation.Address)
            {
            }
            column(CompAddress2; RecLocation."Address 2")
            {
            }
            column(GatePassNo; GatePassNo)
            {
            }
            column(Desc; Desc)
            {
            }
            column(ShipNo; "Sales Shipment Header"."No.")
            {
            }
            column(SellToCtDateustNo; "Sales Shipment Header"."Sell-to Customer No.")
            {
            }
            column(CustName; "Sales Shipment Header"."Sell-to Customer Name")
            {
            }
            column(Name2; "Sales Shipment Header"."Sell-to Customer Name 2")
            {
            }
            column(SellToAdd; "Sales Shipment Header"."Sell-to Address")
            {
            }
            column(SellToAdd2; "Sales Shipment Header"."Sell-to Address 2")
            {
            }
            column(SellToCity; "Sales Shipment Header"."Sell-to City")
            {
            }
            column(SellToPostCode; "Sales Shipment Header"."Sell-to Post Code")
            {
            }
            column(InvoiceNoandDate; InvoiceNoandDate)
            {
            }
            column(ShipmentDate; FORMAT("Sales Shipment Header"."Shipment Date"))
            {
            }
            column(TruckNo; "Sales Shipment Header"."Truck No.")
            {
            }
            column(Amt; Amt)
            {
            }
            column(No; SalesInvoiceHeader."No.")
            {
            }
            dataitem("Sales Shipment Line"; 111)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(Item));
                column(Sno; Sno)
                {
                }
                column(qty_sqm; "Sales Shipment Line"."Quantity (Base)")
                {
                }
                column(QtyInCartons; QtyInCartons)
                {
                }
                column(QtyInWeight; QtyInWeight)
                {
                }
                column(UOMCode; "Sales Shipment Line"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Sno += 1;
                    QtyInCartons := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                    IF QtyInCartons = 0 THEN
                        QtyInCartons := "Sales Shipment Line".Quantity;
                    //QtyInPcs := ROUND(Item.UomToPcs("No.","Unit of Measure Code",Quantity),1,'<');          //-- 2. Tri30.0 PG 14112006
                    //QtyInWeight := Item.UomToGrossWeight("No.","Unit of Measure Code",Quantity);    //-- 2. Tri30.0 PG 14112006
                    QtyInWeight := "Sales Shipment Line"."Gross Weight";
                end;

                trigger OnPreDataItem()
                begin

                    // CurrReport.CREATETOTALS(QtyInCartons); //-- 1. Tri30.0 PG 14112006
                    CurrReport.CREATETOTALS(QtyInCartons, QtyInPcs, QtyInWeight); //-- 1. Tri30.0 PG 14112006
                    Sno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RecLocation.GET("Sales Shipment Header"."Location Code");
                Amt := 0;
                ILE.RESET;
                ILE.SETFILTER(ILE."Document No.", '%1', "No.");
                IF ILE.FIND('-') THEN BEGIN
                    VE.RESET;
                    VE.SETFILTER(VE."Item Ledger Entry No.", '%1', ILE."Entry No.");
                    IF VE.FIND('-') THEN
                        Invno := VE."Document No.";
                END;
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETFILTER("No.", '%1', Invno);
                IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                    InvoiceNoandDate := SalesInvoiceHeader."No." + '  ' + FORMAT(SalesInvoiceHeader."Posting Date");
                    GatePassNo := SalesInvoiceHeader."No.";
                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                    IF SalesInvoiceLine.FIND('-') THEN
                        REPEAT
                            Amt := Amt + GetAmttoCustomerPostedLine(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No."); // SalesInvoiceLine."Amount Including Excise";
                        UNTIL SalesInvoiceLine.NEXT = 0;
                END;
                Amt := ROUND(Amt, 1, '=');


                Amt := ROUND(Amt, 1, '=');
                IF "Location Code" = 'SKD-WH-MFG' THEN
                    IF ("Group Code" = '01') OR ("Group Code" = '05') THEN
                        Address := '8, A-75 to A-80, A-85 and A-22,Ind. Area, Sikandrabad - 203205. Distt. Bulandshahr (UP)';

                IF "Location Code" = 'SKD-WH-TRD' THEN
                    IF ("Group Code" = '02') THEN
                        Address := 'A-84 Industrial Area, Sikandrabad - 203205. Distt. Bulandshahr (UP)';
                Address1 := 'Trading Devision';

                IF "Location Code" = 'HSK-WH-MFG' THEN
                    Address := 'Village-Chokkahalli, Taluka-Hoskote, Bangalore (Rural), Pin-562114';

                IF "Location Code" = 'DRA-WH-MFG' THEN
                    Address := 'Village Dora, taluka Amod, Distt-Bharuch, Gujarat, Pin-392230';
            end;

            trigger OnPreDataItem()
            begin
                "Company Information".GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field(Description; Desc)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Desc := 'Ceramics Galze tiles';
    end;

    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        PstdSalesCrMemoLine: Record 115;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        PstdSalesInv: Record 113;
        TDSAmt: Decimal;
        Item: Record Item;
        QtyInCartons: Decimal;
        QtyInsqm: Decimal;
        LineAmt: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InvoiceNoandDate: Text[50];
        Amt: Decimal;
        Sno: Integer;
        Desc: Text[200];
        GatePassNo: Code[50];
        Invno: Code[50];
        ILE: Record "Item Ledger Entry";
        VE: Record "Value Entry";
        QtyInPcs: Decimal;
        QtyInWeight: Decimal;
        RecLocation: Record Location;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Address: Text[100];
        Address1: Text[30];
        "Company Information": Record "Company Information";
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        LineAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";

    local procedure GetAmttoCustomerPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdSalesInv: Record 113;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        LineAmt: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
        TradeDisAmt: Decimal;
        CashDisAmt: Decimal;
        TotalDiscount: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(LineAmt);
        Clear(TradeDisAmt);
        Clear(CashDisAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                IGSTAmt += abs(DetGstLedEntry."GST Amount");
            until DetGstLedEntry.Next() = 0;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                SGSTAmt += abs(DetGstLedEntry."GST Amount");
            until DetGstLedEntry.Next() = 0;

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                CGSTAmt += abs(DetGstLedEntry."GST Amount");
            until DetGstLedEntry.Next() = 0;

        if PstdSalesInv.Get(DocumentNo, DocLineNo) then //begin
            if PstdSalesInv.Type <> PstdSalesInv.Type::" " then begin
                LineAmt := PstdSalesInv."Line Amount";
                TradeDisAmt := PstdSalesInv."Trade Discount Amount";
                CashDisAmt := PstdSalesInv."Structure Discount Amount";

                TotalDiscount := Abs(TradeDisAmt + CashDisAmt);

                TaxTransactionValue.Reset();
                TaxTransactionValue.SetRange("Tax Record ID", PstdSalesInv.RecordId);
                TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
                TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                TaxTransactionValue.SetRange("Value ID", 7);
                //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                if TaxTransactionValue.FindFirst() then
                    TDSAmt := TaxTransactionValue.Amount;
            end;

        Clear(TotalAmt);
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt - TotalDiscount) - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;


}

