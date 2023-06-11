report 50017 "Purchase V/S Dispatch Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseVSDispatchReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Application Entry"; 339)
        {
            DataItemTableView = SORTING("Item Ledger Entry No.", "Output Completely Invd. Date")
                                ORDER(Ascending)
                                WHERE("Item Code1" = FILTER('*W'),
                                      "Out Bond Entries" = FILTER(<> ''));
            RequestFilterFields = Location, "Posting Date", "Item Code1", "In Bond Entries";
            column(PostingDate_ItemApplicationEntry; FORMAT("Item Application Entry"."Posting Date"))
            {
            }
            column(InBondEntries_ItemApplicationEntry; "Item Application Entry"."In Bond Entries")
            {
            }
            column(OutBondEntries_ItemApplicationEntry; "Item Application Entry"."Out Bond Entries")
            {
            }
            column(ItemNo; "Item Application Entry"."Item Code1")
            {
            }
            column(OrderNo; OrderNo)
            {
            }
            column(OrderDate; FORMAT(OrderDate))
            {
            }
            column(CustName; CustName)
            {
            }
            column(CustCity; CustCity)
            {
            }
            column(CustStateCode; CustStateCode)
            {
            }
            column(InvDate; FORMAT(InvDate))
            {
            }
            column(InvNo; InvNo)
            {
            }
            column(SupplierNames; SupplierName)
            {
            }
            column(VendorShipmentNo; VendorShipmentNo)
            {
            }
            column(GRNNo; GRNNo)
            {
            }
            column(GST; GST)
            {
            }
            column(QualityCode; QualityCode)
            {
            }
            column(SqmtrQty; -1 * Qty)
            {
            }
            column(CartonsQty; CartonsQty)
            {
            }
            column(Amt; "Item Application Entry"."Pur Price")
            {
            }
            column(Zone; Zone)
            {
            }
            column(GrossWeight; GrossWeight)
            {
            }
            column(VendorInvoiceDate; FORMAT(VendorInvoiceDate))
            {
            }
            column(TransporterName; TransporterName)
            {
            }
            column(Topay; Topay)
            {
            }
            column(TruckNo; TruckNo)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(SaleLineAmount; SaleLineAmount)
            {
            }
            column(ItemName; ItemName)
            {
            }
            column(Batch1; batch)
            {
            }
            column(PurchLocation; PurchLocation)
            {
            }
            column(SalesLocation; SalesLocation)
            {
            }
            column(SalesInvNo; SalesInvNo)
            {
            }
            column(TransferDocNo; TransferDocNo)
            {
            }
            column(TransferOrderNo; TransferOrderNo)
            {
            }
            column(SaleLineqty; SaleLineqty)
            {
            }
            column(Sales_order; SOrder)
            {
            }
            column(Sales_Order_date; FORMAT(SOrderdt))
            {
            }
            column(Size_desc; ItemSize)
            {
            }
            column(LR_NO; lrno)
            {
            }
            column(InBonEnt; "Item Application Entry"."In Bond Entries")
            {
            }
            column(EntryNo; "Item Application Entry"."Entry No.")
            {
            }
            column(ItemLedgEntNo; "Item Application Entry"."Item Ledger Entry No.")
            {
            }
            column(ship_city; scity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF ItemLedgEnt <> "Item Application Entry"."Item Ledger Entry No." THEN
                    ItemLedgEnt := "Item Application Entry"."Item Ledger Entry No."
                ELSE
                    CurrReport.SKIP;

                Qty := 0;
                ItemApplicationEntry.RESET;
                ItemApplicationEntry.SETRANGE("Out Bond Entries", "Item Application Entry"."Out Bond Entries");
                ItemApplicationEntry.SETRANGE("Item Ledger Entry No.", "Item Application Entry"."Item Ledger Entry No.");
                IF ItemApplicationEntry.FINDSET THEN
                    REPEAT
                        Qty += ItemApplicationEntry.Quantity;
                    UNTIL ItemApplicationEntry.NEXT = 0;

                "Item Application Entry".CALCFIELDS("Item Application Entry"."Item Code1");
                CLEAR(OrderNo);
                CLEAR(OrderDate);
                CLEAR(SupplierName);
                CLEAR(VendorShipmentNo);
                CLEAR(GRNNo);
                CLEAR(GST);
                CLEAR(QualityCode);
                CLEAR(CartonsQty);
                CLEAR(SqmtrQty);
                CLEAR(Amt);
                CLEAR(VendorInvoiceDate);
                CLEAR(batch);
                PurchLocation := '';
                SalesLocation := '';
                begin
                    Clear(IGSTper);
                    Clear(SGSTper);
                    Clear(CGSTper);
                    Clear(GST);


                    DetGstLedEntry.RESET();
                    DetGstLedEntry.SETRANGE("Document No.", PRL."Order No.");
                    DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
                    IF DetGstLedEntry.FINDFIRST THEN
                        IGSTper := DetGstLedEntry."GST %";



                    DetGstLedEntry.RESET();
                    DetGstLedEntry.SETRANGE("Document No.", PRL."Order No.");
                    DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
                    IF DetGstLedEntry.FINDFIRST THEN
                        SGSTper := DetGstLedEntry."GST %";


                    DetGstLedEntry.RESET();
                    DetGstLedEntry.SETRANGE("Document No.", PRL."Order No.");
                    DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
                    IF DetGstLedEntry.FINDFIRST THEN
                        CGSTper := DetGstLedEntry."GST %";


                    Clear(TotalGST);
                    TotalGST := IGSTper + SGSTper + CGSTper;
                end;

                PRL.RESET;
                PRL.SETRANGE(PRL.Type, PRL.Type::Item);
                PRL.SETRANGE(PRL."No.", "Item Application Entry"."Item Code1");
                PRL.SETRANGE(PRL."Document No.", "Item Application Entry"."In Bond Entries");
                IF PRL.FINDSET THEN
                    REPEAT
                        OrderNo := PRL."Order No.";
                        OrderDate := PRL."Order Date";
                        PurchLocation := PRL."Location Code";
                        GRNNo := PRL."Document No.";
                        GST := TotalGST;
                        // GST := TotalGSTAmtLinePRL(PRL."Document No.");//16630
                        Amt := GetAmttoVendorPostedLine(PRL."Document No.", PRL."Line No.");//16630
                        batch := PRL."Batch No.";
                        SqmtrQty := PRL."Quantity (Base)";
                        IF PRL."Unit of Measure" = 'Carton' THEN
                            CartonsQty := PRL.Quantity;
                        IF Vendor.GET(PRL."Buy-from Vendor No.") THEN
                            SupplierName := Vendor.Name;
                        IF PRH.GET(PRL."Document No.") THEN BEGIN
                            VendorShipmentNo := PRH."Vendor Invoice No.";
                            VendorInvoiceDate := PRH."Vendor Invoice Date";
                        END;
                        IF Item.GET(PRL."No.") THEN
                            DimensionValue.RESET;
                        DimensionValue.SETFILTER(DimensionValue."Dimension Code", '%1', 'QUALITY');
                        DimensionValue.SETRANGE(DimensionValue.Code, Item."Quality Code");
                        IF DimensionValue.FINDFIRST THEN
                            QualityCode := DimensionValue.Name;

                    UNTIL PRL.NEXT = 0;

                CLEAR(CustName);
                CLEAR(CustCity);
                CLEAR(CustStateCode);
                CLEAR(InvDate);
                CLEAR(InvNo);
                CLEAR(Zone);
                CLEAR(GrossWeight);
                CLEAR(TransporterName);
                CLEAR(TruckNo);
                CLEAR(Topay);
                //CLEAR(SaleLineAmount);
                SaleLineAmount := 0;
                CLEAR(SaleLineqty);
                CLEAR(Remarks);
                SalesInvNo := '';
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."No.", "Item Application Entry"."Item Code1");
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", "Item Application Entry"."Out Bond Entries");
                IF SalesInvoiceLine.FINDSET THEN
                    REPEAT
                        IF Cust.GET(SalesInvoiceLine."Sell-to Customer No.") THEN BEGIN
                            CustName := Cust.Name;
                            CustCity := Cust.City;
                            CustStateCode := Cust."State Desc.";
                            Zone := Cust.Zone;
                            SalesLocation := SalesInvoiceLine."Location Code";
                            SalesInvNo := SalesInvoiceLine."Document No.";
                        END;
                        IF Item2.GET(SalesInvoiceLine."No.") THEN
                            GrossWeight := Item2."Gross Weight";
                        InvDate := SalesInvoiceLine."Posting Date";
                        InvNo := SalesInvoiceLine."Document No.";
                        SaleLineAmount := TotalGSTAmtLine(SalesInvoiceLine."Document No.");//16630
                        SaleLineqty := SalesInvoiceLine.Quantity;
                        Remarks := SalesInvoiceLine.Remarks;
                        IF SIH.GET(SalesInvoiceLine."Document No.") THEN BEGIN
                            TransporterName := SIH."Transporter Name";
                            TruckNo := SIH."Truck No.";
                            Topay := FORMAT(SIH.Pay);
                            SOrder := SIH."Order No.";
                            SOrderdt := SIH."Order Date";
                            lrno := SIH."GR No.";
                            scity := SIH."Ship-to City";
                        END;
                    UNTIL SalesInvoiceLine.NEXT = 0;

                CLEAR(ItemName);
                IF Item3.GET("Item Application Entry"."Item Code1") THEN
                    ItemName := Item3.Description + ' ' + Item3."Description 2";
                ItemSize := Item3."Size Code Desc.";

                CLEAR(TransferDocNo);
                CLEAR(TransferOrderNo);
                TransferShipmentHeader.RESET;
                TransferShipmentHeader.SETRANGE("No.", "Item Application Entry"."Out Bond Entries");
                IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                    TransferDocNo := TransferShipmentHeader."No.";
                    TransferOrderNo := TransferShipmentHeader."Transfer Order No.";
                END;
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

    var

        IGSTper: Decimal;
        SGSTper: Decimal;
        CGSTper: Decimal;
        TotalGST: Decimal;
        DetGstLedEntry: Record "Detailed GST Entry Buffer";
        PRL: Record "Purch. Rcpt. Line";
        OrderNo: Code[20];
        OrderDate: Date;
        SalesInvoiceLine: Record "Sales Invoice Line";
        InvoiceNo: Code[20];
        Cust: Record Customer;
        CustName: Text[50];
        CustCity: Text[40];
        CustStateCode: Code[40];
        InvNo: Code[20];
        InvDate: Date;
        Vendor: Record Vendor;
        SupplierName: Text[50];
        PRH: Record "Purch. Rcpt. Header";
        VendorShipmentNo: Code[20];
        GRNNo: Code[20];
        GST: Decimal;
        Item: Record Item;
        DimensionValue: Record "Dimension Value";
        QualityCode: Code[10];
        CartonsQty: Decimal;
        SqmtrQty: Decimal;
        Amt: Decimal;
        Zone: Code[10];
        Item2: Record Item;
        GrossWeight: Decimal;
        VendorInvoiceDate: Date;
        TransporterName: Text;
        SIH: Record "Sales Invoice Header";
        TruckNo: Text[50];
        Topay: Text[20];
        SaleLineAmount: Decimal;
        Remarks: Text[50];
        Item3: Record Item;
        ItemName: Text[200];
        batch: Code[20];
        PurchLocation: Code[20];
        SalesLocation: Code[20];
        SalesInvNo: Code[20];
        TransferDocNo: Code[20];
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferOrderNo: Code[20];
        SaleLineqty: Decimal;
        SOrder: Code[20];
        SOrderdt: Date;
        ItemSize: Code[15];
        lrno: Text[20];
        ItemLedgEnt: Integer;
        ItemApplicationEntry: Record "Item Application Entry";
        Qty: Decimal;
        scity: Text[20];

    procedure TotalGSTAmtLine(DocNo: Code[20]): Decimal
    var
        PstdSalesInv: Record 113;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(GSTBaseAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            SGSTAmt := abs(DetGstLedEntry."GST Amount");
        end;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
        end;


        Clear(TotalAmt);
        TotalAmt := IGSTAmt + SGSTAmt + CGSTAmt;
        EXIT(ABS(TotalAmt));
    end;

    procedure TotalGSTAmtLinePRL(DocNo: Code[20]): Decimal
    var
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt1: Decimal;
        SGSTAmt2: Decimal;
        CGSTAmt3: Decimal;
    begin
        Clear(IGSTAmt1);
        Clear(SGSTAmt2);
        Clear(CGSTAmt3);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            IGSTAmt1 := DetGstLedEntry."GST %";



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            SGSTAmt2 := DetGstLedEntry."GST %";


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            CGSTAmt3 := DetGstLedEntry."GST %";


        Clear(TotalAmt);
        TotalAmt := IGSTAmt1 + SGSTAmt2 + CGSTAmt3;
        EXIT(ABS(TotalAmt));
    end;

    procedure GetAmttoVendorPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record 123;
        PstdPurchCrMemoLine: Record 125;
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
        IF DetGstLedEntry.FINDFIRST THEN
            IGSTAmt := abs(DetGstLedEntry."GST Amount");



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
        IF DetGstLedEntry.FINDFIRST THEN
            CGSTAmt := abs(DetGstLedEntry."GST Amount");

        if PstdPurchCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchCrMemoLine.Type <> PstdPurchCrMemoLine.Type::" " then
                LineAmt := PstdPurchCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdPurchInv.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchInv.Type <> PstdPurchInv.Type::" " then
                LineAmt := PstdPurchInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchInv.RecordId);
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
    end;//
}

