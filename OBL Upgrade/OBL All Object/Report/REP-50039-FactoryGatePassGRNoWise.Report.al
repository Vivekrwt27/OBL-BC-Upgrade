report 50039 "Factory Gate Pass GR No. Wise"
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
    RDLCLayout = '.\ReportLayouts\FactoryGatePassGRNoWise.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Shipment Header"; 110)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "GR No.", "Posting Date", "Location Code";
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
            column(GRNo; "Sales Shipment Header"."GR No.")
            {
            }
            column(GRDate; "Sales Shipment Header"."GR Date")
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
            column(SellToCity; "Sales Shipment Header"."Ship-to City")
            {
            }
            column(SellToPostCode; "Sales Shipment Header"."Sell-to Post Code")
            {
            }
            column(OrderNo; "Sales Shipment Header"."Order No.")
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
            column(Amt; GetAmttoCustomerPostedLine(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No."))
            {
            }
            column(No; No)//SalesInvoiceHeader."No."
            {
            }
            column(InvoiceDate; PostingDate)//SalesInvoiceHeader."Posting Date"
            {
            }
            column(State; RecState.Description)
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
                column(item_desc; Item.Description + ' ' + Item."Description 2")
                {
                }
                column(GrossWeight_SalesShipmentLine; "Sales Shipment Line"."Gross Weight")
                {
                }
                column(Quantity_SalesShipmentLine; "Sales Shipment Line".Quantity)
                {
                }
                column(Description_SalesShipmentLine; "Sales Shipment Line".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Sno += 1;
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

                //Rb SalesInvoiceHeader.get("Sales Shipment Header"."No.");
                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("No.", "No.");
                if SalesInvoiceHeader.FindSet() then begin
                    No := SalesInvoiceHeader."No.";
                    PostingDate := SalesInvoiceHeader."Posting Date";
                end;
                /* 
                                SalesInvoiceHeader.RESET;
                                SalesInvoiceHeader.SETFILTER("No.", '%1', Invno);
                                IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                                    InvoiceNoandDate := SalesInvoiceHeader."No." + '  ' + FORMAT(SalesInvoiceHeader."Posting Date");
                                    GatePassNo := SalesInvoiceHeader."No.";
                                    SalesInvoiceLine.RESET;
                                    SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                                    IF SalesInvoiceLine.FIND('-') THEN
                                        REPEAT
                                            IGSTAmt := 0;
                                            IGSTper := 0;
                                            SGSTAmt := 0;
                                            SGSTper := 0;
                                            CGSTAmt := 0;
                                            CGSTper := 0;
                                            GSTBaseAmt := 0;
                                            TotalAmount := 0;
                                            LineAmount := 0;




                                            RecDGLE.RESET();
                                            RecDGLE.SETRANGE("Document No.", SalesInvoiceLine."No.");
                                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                            RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                            IF RecDGLE.FINDFIRST THEN BEGIN
                                                REPEAT
                                                    IGSTAmt += abs(RecDGLE."GST Amount");
                                                UNTIL RecDGLE.NEXT = 0;
                                            END;


                                            RecDGLE.RESET();
                                            RecDGLE.SETRANGE("Document No.", SalesInvoiceLine."No.");
                                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                            RecDGLE.SETRANGE("GST Component Code", 'SGST');
                                            IF RecDGLE.FINDFIRST THEN BEGIN
                                                REPEAT
                                                    SGSTAmt += abs(RecDGLE."GST Amount");
                                                UNTIL RecDGLE.NEXT = 0;
                                            END;
                                            RecDGLE.RESET();
                                            RecDGLE.SETRANGE("Document No.", SalesInvoiceLine."No.");
                                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                            RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                            IF RecDGLE.FINDFIRST THEN BEGIN
                                                REPEAT
                                                    CGSTAmt += abs(RecDGLE."GST Amount");
                                                UNTIL RecDGLE.NEXT = 0;
                                            END;


                                            RecDGLE.RESET();
                                            RecDGLE.SETRANGE("Document No.", SalesInvoiceLine."No.");
                                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                            RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                            IF RecDGLE.FINDFIRST THEN BEGIN
                                                repeat
                                                    GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                                until RecDGLE.next = 0;
                                            END;
                                            RecDGLE.RESET();
                                            RecDGLE.SETRANGE("Document No.", SalesInvoiceLine."No.");
                                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                            RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                            IF RecDGLE.FINDFIRST THEN BEGIN
                                                repeat
                                                    GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                                until RecDGLE.Next() = 0;


                                            END;
                                            TotalAmount += LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;
                                            Amt := Amt + TotalAmount;  // 16630    Amt := Amt + SalesInvoiceLine."Amount To Customer";


                                        // 16630     SalesInvoiceLine."Amount Including Excise";
                                        UNTIL SalesInvoiceLine.NEXT = 0;
                                END; 16630 */
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
                IF RecState.GET("Sales Shipment Header"."GST Ship-to State Code") THEN;
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
        PostingDate: Date;
        No: Code[20];
        Item: Record Item;
        QtyInCartons: Decimal;
        QtyInsqm: Decimal;
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
        RecState: Record State;
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
        PstdSalesCrMemoLine: Record 115;
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
    begin
        Clear(IGSTAmt);
        Clear(LineAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
            //GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            SGSTAmt := abs(DetGstLedEntry."GST Amount");

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
            // GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;

        if PstdSalesCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdSalesCrMemoLine.Type <> PstdSalesCrMemoLine.Type::" " then
                LineAmt := PstdSalesCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdSalesCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdSalesInv.Get(DocumentNo, DocLineNo) then begin
            if PstdSalesInv.Type <> PstdSalesInv.Type::" " then
                LineAmt := PstdSalesInv."Line Amount";
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
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt) - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;

}

