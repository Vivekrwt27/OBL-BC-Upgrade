report 50036 "Sales Data (Sales Journal)"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesDataSalesJournal.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; 2000000026)
        {
            column(CustNo; SalesJournalData.CustomerNo)
            {
            }
            column(CustName; SalesJournalData.CustomerName)
            {
            }
            column(SellToCity; SalesJournalData.SellToCity)
            {
            }
            column(State; GetStateName(SalesJournalData.State))
            {
            }
            column(CustType; SalesJournalData.CustomerType)
            {
            }
            column(InvoiceNo; SalesJournalData.InvoiceNo)
            {
            }
            column(PostingDate; SalesJournalData.PostingDate)
            {
            }
            column(LocationCode; SalesJournalData.LocationCode)
            {
            }
            column(TransportMethod; Transport)
            {
            }
            column(ItemNo; SalesJournalData.ItemNo)
            {
            }
            column(ItemDesc; SalesJournalData.ItemDescc + ' ' + SalesJournalData.ItemDescc2)
            {
            }
            column(Qty; SalesJournalData.Quantity)
            {
            }
            column(UOM; SalesJournalData.UOM)
            {
            }
            column(QtyBase; SalesJournalData.Quantity_Base)
            {
            }
            column(LineAmt; SalesJournalData.LineAmount)
            {
            }
            column(ASP; ASPValue)
            {
            }
            column(AmtToCust; GetAmttoCustomerPostedLine(SalesJournalData.Document_No_, SalesJournalData.Line_No))//SalesJournalData.AmountToCustomer
            {
            }
            column(MRPPrice; SalesJournalData.MRPPrice)
            {
            }
            column(LineDisAmt; LineDisAmt)
            {
            }
            column(Pay; SalesJournalData.Pay)
            {
            }
            column(SalesType; SalesJournalData.Sales_Type)
            {
            }
            column(SizeCodeDesc; SalesJournalData.SizeCodeDesc)
            {
            }
            column(TypeCodeDesc; SalesJournalData.TypeCodeDesc)
            {
            }
            column(TypeCatCodeDesc; SalesJournalData.TypeCatCodeDesc)
            {
            }
            column(TabProdGrp; SalesJournalData.TabProdGrp)
            {
            }
            column(TypeCatCode; SalesJournalData.TypeCatCode)
            {
            }
            column(QualityCode; SalesJournalData.QualityCode)
            {
            }
            column(ZH; SalesJournalData.ZH_Name)
            {
            }
            column(SPCode; SalesJournalData.SPCode)
            {
            }
            column(SPName; SalesJournalData.SPName)
            {
            }
            column(PCHCode; SalesJournalData.PCHCode)
            {
            }
            column(PCHName; SalesJournalData.PCHName)
            {
            }
            column(GovtSPResp; SalesJournalData.GovtSPResp)
            {
            }
            column(GovtName; SalesJournalData.GovtName)
            {
            }
            column(PrivateSPResp; SalesJournalData.PrivateSPResp)
            {
            }
            column(PrivateSP_Name; SalesJournalData.PrivateSP_Name)
            {
            }
            column(GET; SalesJournalData.Govt_proj)
            {
            }
            column(Tableau_Zone; SalesJournalData.TableauZone)
            {
            }
            column(Month; DATE2DMY(SalesJournalData.PostingDate, 2))
            {
            }
            column(Year; DATE2DMY(SalesJournalData.PostingDate, 3))
            {
            }
            column(Week; DATE2DWY(SalesJournalData.PostingDate, 2))
            {
            }
            column(Sales_Territory; SalesJournalData.Sales_Territory)
            {
            }
            column(Ship_city; SalesJournalData.Ship_to_City)
            {
            }
            column(MRP_sqmt; MRPPerSqmtr)
            {
            }
            column(billing_sqm; BillingRate)
            {
            }
            column(Buter_price_Sqm; BuyerPricePerSqm)
            {
            }
            column(PMT; SalesJournalData.PMTCode)
            {
            }
            column(Order_date; SalesJournalData.Order_Date)
            {
            }
            column(Order_no; SalesJournalData.Order_No)
            {
            }
            column(Item_npd; SalesJournalData.Item_npd)
            {
            }
            column(Sample_group; SalesJournalData.Sample_Group)
            {
            }
            column(cka_code; SalesJournalData.CKA_Code)
            {
            }
            column(Item_class; SalesJournalData.item_class)
            {
            }
            column(TCS_Amt; TCSAmt)//SalesJournalData.TDS_TCS_Amount
            {
            }
            column(GST_per; GSTPERCENT)//SalesJournalData.GST_per
            {
            }
            column(Manuf_stategy; SalesJournalData.Manuf_stategy)
            {
            }
            column(tcs; SalesJournalData.TCS_Nature_of_Collection)
            {
            }
            column(obtb; SalesJournalData.obtb)
            {
            }
            column(truckno; SalesJournalData.TruckNo)
            {
            }
            column(gr_no; SalesJournalData.GR_No)
            {
            }
            column(FocusProd; SalesJournalData.Goal_Sheet_Focused_Product)
            {
            }
            column(OBTBJoiningDate; SalesJournalData.OBTB_Joining_Date)
            {
            }
            column("MOD"; SalesJournalData.Make_Order_Date)
            {
            }
            column(AWS; SalesJournalData.AWS)
            {
            }
            column(Gross_Wt; SalesJournalData.Gross_Weight)
            {
            }
            column(Net_wt; SalesJournalData.Net_Weight)
            {
            }
            column(qty_sq; SalesJournalData.Quantity_in_Sq_Mt)
            {
            }

            trigger OnAfterGetRecord()
            var
                TCSentry: Record "TCS Entry";
            begin
                InitialiseVariables;

                /*  Clear(TCSAmt);
                 TCSentry.Reset();
                 TCSentry.SetRange("Document No.", SalesJournalData.Document_No_);
                 if TCSentry.FindSet() then
                     repeat
                         TCSAmt += TCSentry."TCS Amount";
                     until TCSentry.next() = 0;
  *///16767


                IF NOT SalesJournalData.READ THEN
                    CurrReport.BREAK;

                IF SalesJournalData.Quantity_Base <> 0 THEN
                    ASPValue := ROUND(SalesJournalData.LineAmount / SalesJournalData.Quantity_Base, 0.01, '=');

                LineDisAmt := SalesJournalData.Discount_Amt_1 + SalesJournalData.Discount_Amt_2 + SalesJournalData.Discount_Amt_3
                             + SalesJournalData.Discount_Amt_4 + SalesJournalData.System_Discount_Amount + SalesJournalData.Discount_Amt_6 + SalesJournalData.Discount_Amt_7;


                IF tptdesc.GET(SalesJournalData.TransportMethod) THEN
                    Transport := tptdesc.Name;

                BuyerPricePerSqm := ((SalesJournalData.LineAmount + SalesJournalData.line_discount) / SalesJournalData.Quantity_Base);


                /*
                
                Sqmt := Item.UomToSqm("No.","Unit of Measure Code",Quantity);
                IF SqrMtr <> 0 THEN
                  LineDisPerSqMeter := ROUND((("Sales Invoice Line"."Discount Amt 1" + "Sales Invoice Line"."Discount Amt 2" + "Sales Invoice Line"."Discount Amt 3"
                  +"Sales Invoice Line"."Discount Amt 4" + "Sales Invoice Line"."System Discount Amount")/SqrMtr),0.01,'=');
                
                IF Sqmt <> 0 THEN
                  MRPPerSqmtr := ROUND(("MRP Price"*Quantity/Sqmt),0.01,'=');
                IF SqrMtr<>0 THEN
                 BillingRate := ROUND(Value/SqrMtr,0.01,'=');
                
                */

                MRPPerSqmtr := ROUND((SalesJournalData.MRPPrice * SalesJournalData.Quantity / SalesJournalData.Quantity_Base), 0.01, '=');

                IF SalesJournalData.Quantity_Base <> 0 THEN
                    BillingRate := ROUND(SalesJournalData.LineAmount / SalesJournalData.Quantity_Base, 0.01, '=');


            end;

            trigger OnPostDataItem()
            begin
                SalesJournalData.CLOSE;
            end;

            trigger OnPreDataItem()
            begin

                IF GBLPrevYear THEN
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2|%3..%4', GblStartDate, GBLEndDate, GblStartDate - 365, GBLEndDate - 365)
                ELSE
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', GblStartDate, GBLEndDate);

                IF GBLAreaCode <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', GBLAreaCode);

                IF GBLZHCode <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', GBLZHCode);

                IF GBLPCHCode <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.PCHFilter, '%1', GBLPCHCode);

                IF GBLSPCode <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.SalesPersonFilter, '%1', GBLSPCode);

                IF Custno <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.Cust_Code, '%1', Custno);

                IF ItemNo <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.Item_no, '%1', ItemNo);


                SalesJournalData.OPEN;

            end;
        }
        dataitem(SalesReturn1; 2000000026)
        {
            column(LineNo1; SalesReturn.Line_No)
            {
            }
            column(CustNo1; SalesReturn.CustomerNo)
            {
            }
            column(CustName1; SalesReturn.CustomerName)
            {
            }
            column(SellToCity1; SalesReturn.SellToCity)
            {
            }
            column(State1; GetStateName(SalesReturn.State))
            {
            }
            column(CustType1; SalesReturn.CustomerType)
            {
            }
            column(Rsq_mt; -1 * SalesReturn.Quantity_in_Sq_Mt)
            {
            }
            column(InvoiceNo1; SalesReturn.InvoiceNo)
            {
            }
            column(PostingDate1; SalesReturn.PostingDate)
            {
            }
            column(LocationCode1; SalesReturn.LocationCode)
            {
            }
            column(TransportMethod1; Transport)
            {
            }
            column(ItemNo1; SalesReturn.ItemNo)
            {
            }
            column(ItemDesc1; SalesReturn.ItemDescc + ' ' + SalesReturn.ItemDescc2)
            {
            }
            column(Qty1; -1 * SalesReturn.Quantity)
            {
            }
            column(UOM1; SalesReturn.UOM)
            {
            }
            column(QtyBase1; -1 * SalesReturn.Quantity_Base)
            {
            }
            column(LineAmt1; -1 * SalesReturn.LineAmount)
            {
            }
            column(ASP1; ASPValue)
            {
            }
            column(AmtToCust1; -1 * GetAmttoCustomerPostedLine(SalesReturn.Document_No_, SalesReturn.Line_No))// -1 * SalesReturn.AmountToCustomer
            {
            }
            column(MRPPrice1; SalesReturn.MRPPrice)
            {
            }
            column(LineDisAmt1; -1 * LineDisAmt)
            {
            }
            column(Pay1; '')
            {
            }
            column(SalesType1; SalesReturn.Sales_Type)
            {
            }
            column(SizeCodeDesc1; SalesReturn.SizeCodeDesc)
            {
            }
            column(TypeCodeDesc1; SalesReturn.TypeCodeDesc)
            {
            }
            column(TypeCatCodeDesc1; SalesReturn.TypeCatCodeDesc)
            {
            }
            column(TabProdGrp1; SalesReturn.TabProdGrp)
            {
            }
            column(TypeCatCode1; SalesReturn.TypeCatCode)
            {
            }
            column(QualityCode1; SalesReturn.QualityCode)
            {
            }
            column(SPCode1; SalesReturn.SPCode)
            {
            }
            column(SPName1; SalesReturn.SPName)
            {
            }
            column(PCHCode1; SalesReturn.PCHCode)
            {
            }
            column(PCHName1; SalesReturn.PCHName)
            {
            }
            column(GovtSPResp1; SalesReturn.GovtSPResp)
            {
            }
            column(GovtName1; SalesReturn.GovtName)
            {
            }
            column(PrivateSPResp1; SalesReturn.PrivateSPResp)
            {
            }
            column(PrivateSP_Name1; SalesReturn.PrivateSP_Name)
            {
            }
            column(Tableau_Zone1; SalesReturn.TableauZone)
            {
            }
            column(Ritem_class; SalesReturn.Item_Classification)
            {
            }
            column(npd; SalesReturn.NPD)
            {
            }
            column(Month1; DATE2DMY(SalesReturn.PostingDate, 2))
            {
            }
            column(Year1; DATE2DMY(SalesReturn.PostingDate, 3))
            {
            }
            column(Week1; DATE2DWY(SalesReturn.PostingDate, 2))
            {
            }
            column(Sales_Territory1; SalesReturn.Sales_Territory)
            {
            }
            column(Ship_city1; SalesReturn.Ship_to_City)
            {
            }
            column(MRP_sqmt1; MRPPerSqmtr)
            {
            }
            column(billing_sqm1; BillingRate)
            {
            }
            column(Buter_price_Sqm1; BuyerPricePerSqm)
            {
            }
            column(PMT1; '')
            {
            }
            column(ZM_nameret; SalesReturn.ZH_name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InitialiseVariables;

                IF NOT SalesReturn.READ THEN
                    CurrReport.BREAK;

                IF SalesReturn.Quantity_Base <> 0 THEN
                    ASPValue := ROUND(SalesReturn.LineAmount / SalesReturn.Quantity_Base, 0.01, '=');

                LineDisAmt := SalesReturn.Discount_Amt_1 + SalesReturn.Discount_Amt_2 + SalesReturn.Discount_Amt_3
                             + SalesReturn.Discount_Amt_4 + SalesReturn.System_Discount_Amount;

                BuyerPricePerSqm := ((SalesReturn.LineAmount + SalesReturn.line_discount) / SalesReturn.Quantity_Base);

                // MRPPerSqmtr := ROUND((SalesReturn.MRPPrice * SalesReturn.Quantity / SalesReturn.Quantity_Base), 0.01, '=');

                IF SalesReturn.Quantity_Base <> 0 THEN
                    BillingRate := ROUND(SalesReturn.LineAmount / SalesReturn.Quantity_Base, 0.01, '=');
            end;

            trigger OnPostDataItem()
            begin
                SalesReturn.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                IF GBLPrevYear THEN
                    SalesReturn.SETFILTER(SalesReturn.PostingDateFilter, '%1..%2|%3..%4', GblStartDate, GBLEndDate, GblStartDate - 365, GBLEndDate - 365)
                ELSE
                    SalesReturn.SETFILTER(SalesReturn.PostingDateFilter, '%1..%2', GblStartDate, GBLEndDate);

                IF GBLAreaCode <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.AreaFilter, '%1', GBLAreaCode);

                IF GBLZHCode <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.Zonal_Head, '%1', GBLZHCode);

                IF GBLPCHCode <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.PCHFilter, '%1', GBLPCHCode);

                IF GBLSPCode <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.SalesPersonFilter, '%1', GBLSPCode);

                IF Custno <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.Cust_code, '%1', Custno);

                IF ItemNo <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.Item_no, '%1', ItemNo);


                SalesReturn.OPEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; GblStartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; GBLEndDate)
                {
                    ApplicationArea = All;
                }
                field("PCH Code"; GBLPCHCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field("SP COde"; GBLSPCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field("Customer No."; Custno)
                {
                    TableRelation = Customer;
                    ApplicationArea = All;
                }
                field("Item Code"; ItemNo)
                {
                    TableRelation = Item;
                    ApplicationArea = All;
                }
                field("Include Prev. Year Data"; GBLPrevYear)
                {
                    ApplicationArea = All;
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
        //SetParameters(011018D,311218D,'','','',TRUE);
    end;

    var
        GSTPERCENT: Decimal;
        TCSAmt: Decimal;
        SalesJournalData: Query "Sales Journal Data";
        TotalDiscount: Decimal;
        GblStartDate: Date;
        GBLEndDate: Date;
        GBLAreaCode: Code[20];
        GBLZHCode: Code[20];
        GBLPCHCode: Code[20];
        GBLSPCode: Code[20];
        Custno: Code[20];
        GBLPrevYear: Boolean;
        ASPValue: Decimal;
        LineDisAmt: Decimal;
        Sqmt: Decimal;
        MRPPerSqmtr: Decimal;
        BuyerRateSqm: Decimal;
        BillingRate: Decimal;
        BaseUOM: Record "Item Unit of Measure";
        BuyerPricePerSqm: Decimal;
        tptdesc: Record "Shipping Agent";
        Transport: Text[100];
        SqrMtr: Decimal;
        SalesReturn: Query "Sales Return Journal Data";
        ItemNo: Code[19];

    local procedure InitialiseVariables()
    begin
        TotalDiscount := 0;
        ASPValue := 0;
    end;

    procedure SetParameters(StartDate: Date; EndDate: Date; AreaCode: Code[20]; ZHCode: Code[20]; PCHCode: Code[20]; SPCode: Code[20]; PreviousYear: Boolean)
    begin
        GblStartDate := StartDate;
        GBLEndDate := EndDate;
        GBLAreaCode := AreaCode;
        GBLZHCode := ZHCode;
        GBLPCHCode := PCHCode;
        GBLSPCode := SPCode;
        GBLPrevYear := PreviousYear;
    end;

    local procedure GetStateName(StateCode: Code[10]): Text
    var
        State: Record State;
    begin
        IF State.GET(StateCode) THEN
            EXIT(State.Description);
    end;

    procedure GetAmttoCustomerPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
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
        IGSTper: Decimal;
        CGSTper: Decimal;
        SGSTper: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(LineAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        Clear(IGSTper);
        Clear(SGSTper);
        Clear(CGSTper);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
            IGSTper := DetGstLedEntry."GST %";
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            SGSTAmt := abs(DetGstLedEntry."GST Amount");
            SGSTper := DetGstLedEntry."GST %";
        end;

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
            CGSTper := DetGstLedEntry."GST %";
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

        GSTPERCENT := IGSTper + SGSTper + CGSTper;

        Clear(TotalAmt);
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt) - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;

}

