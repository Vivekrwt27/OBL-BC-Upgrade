report 50080 "Sales Data (Sales Journal New)"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesDataSalesJournalNew.rdl';
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
            column(Ship_stname; Ship_stname)
            {

            }
            column(AmtToCust; '')//SalesJournalData.AmountToCustomer
            {
            }
            column(MRPPrice; '')// SalesJournalData.MRPPrice
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
            column(ZH; SalesJournalData.Zonal_Head)
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
            column(Externaldocu; SalesJournalData.External_Document_No)
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
            column(TCS_Amt; '')//SalesJournalData.TDS_TCS_Amount
            {
            }
            column(GST_per; '')//SalesJournalData.GST_per
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
            column(OBTBJoiningDate; FORMAT(SalesJournalData.OBTB_Joining_Date))
            {
            }
            column(AD1; SalesJournalData.Discount_Amt_1)
            {
            }
            column(AD2; SalesJournalData.Discount_Amt_2)
            {
            }
            column(AD3; SalesJournalData.Discount_Amt_3)
            {
            }
            column(AD4; SalesJournalData.Discount_Amt_4)
            {
            }
            column(Credit_Approval; SalesJournalData.Credit_App_Not_Req)
            {
            }
            column(Freight; SalesJournalData.Discount_Amt_6)
            {
            }
            column(ORC; SalesJournalData.Discount_Amt_7)
            {
            }
            column(S1; SalesJournalData.S1)
            {
            }
            column(d6; SalesJournalData.D6)
            {
            }
            column(ZM_name; SalesJournalData.ZM_Name)
            {
            }
            column(Truck_NO; SalesJournalData.TruckNo)
            {
            }
            column("MOD"; FORMAT(SalesJournalData.Make_Order_Date))
            {
            }
            column(RD; FORMAT(SalesJournalData.Releasing_Date))
            {
            }
            column(GST_base; '')//SalesJournalData.GSTBaseAmount
            {
            }
            column(Order_process; SalesJournalData.Payment_Date_3)
            {
            }
            column(PostCode; SalesJournalData.PostCode)
            {
            }
            column(qty_sq; SalesJournalData.Quantity_in_Sq_Mt)
            {
            }
            column(app_req; SalesJournalData.Approval_Required)
            {
            }
            column(OBTB_Customer; SalesJournalData.Coco_Customer)
            {
            }
            column(OBTB_Joining; FORMAT(SalesJournalData.OBTB_Joining_Date))
            {
            }
            column(PreApprovedDisAmt; PreApprovedDisAmt)
            {
            }
            column(Inventory_Not_found; SalesJournalData.Inventory_not_found)
            {
            }
            column(cd; SalesJournalData.CD)
            {
            }

            trigger OnAfterGetRecord()
            var
                SalesInvoiceLine: Record "Sales Invoice Line";
            begin
                InitialiseVariables;


                IF NOT SalesJournalData.READ THEN
                    CurrReport.BREAK;

                IF SalesJournalData.Quantity_Base <> 0 THEN
                    ASPValue := ROUND(SalesJournalData.LineAmount / SalesJournalData.Quantity_Base, 0.01, '=');

                LineDisAmt := SalesJournalData.Discount_Amt_1 + SalesJournalData.Discount_Amt_2 + SalesJournalData.Discount_Amt_3
                             + SalesJournalData.Discount_Amt_4 + SalesJournalData.System_Discount_Amount + SalesJournalData.Discount_Amt_6 + SalesJournalData.Discount_Amt_7;


                IF tptdesc.GET(SalesJournalData.TransportMethod) THEN
                    Transport := tptdesc.Name;

                BuyerPricePerSqm := ((SalesJournalData.LineAmount + SalesJournalData.line_discount) / SalesJournalData.Quantity_Base);
                IF State.GET(SalesJournalData.State) THEN //16767 Ship_state
                    Ship_stname := State.Description;

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

                ///   MRPPerSqmtr := ROUND((SalesJournalData.MRPPrice * SalesJournalData.Quantity / SalesJournalData.Quantity_Base), 0.01, '=');

                IF SalesJournalData.Quantity_Base <> 0 THEN
                    BillingRate := ROUND(SalesJournalData.LineAmount / SalesJournalData.Quantity_Base, 0.01, '=');

                PreApprovedDisAmt := 0;
                IF CalcPreAppDiscData THEN BEGIN
                    IF SalesInvoiceLine.GET(SalesJournalData.InvoiceNo, SalesJournalData.Line_No) THEN
                        PreApprovedDisAmt := SalesInvoiceLine.GetPreApprovedDiscount();
                END;

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

                IF GBLPCHCode <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.PCHFilter, '%1', GBLPCHCode);

                IF GBLSPCode <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.SalesPersonFilter, '%1', GBLSPCode);

                IF Custno <> '' THEN
                    SalesJournalData.SETFILTER(SalesJournalData.Cust_Code, '%1', Custno);

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
            column(AmtToCust1; '')// -1 * SalesReturn.AmountToCustomer
            {
            }
            column(MRPPrice1; '')// SalesReturn.MRPPrice
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
            column(AD_1; SalesReturn.Discount_Amt_1)
            {
            }
            column(AD_2; SalesReturn.Discount_Amt_2)
            {
            }
            column(AD_3; SalesReturn.Discount_Amt_3)
            {
            }
            column(AD_4; SalesReturn.Discount_Amt_4)
            {
            }
            column(ZM_nameret; SalesReturn.ZM_name)
            {
            }
            column(Rsq_mt; -1 * SalesReturn.Quantity_in_Sq_Mt)
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

                IF GBLPCHCode <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.PCHFilter, '%1', GBLPCHCode);

                IF GBLSPCode <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.SalesPersonFilter, '%1', GBLSPCode);

                IF Custno <> '' THEN
                    SalesReturn.SETFILTER(SalesReturn.Cust_code, '%1', Custno);

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
                field("Include Prev. Year Data"; GBLPrevYear)
                {
                    ApplicationArea = All;
                }
                field("Calculate PreApproved Discount"; CalcPreAppDiscData)
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
        SalesJournalData: Query "Sales Journal Data";
        TotalDiscount: Decimal;
        GblStartDate: Date;
        GBLEndDate: Date;
        GBLAreaCode: Code[20];
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
        PreApprovedDisAmt: Decimal;
        CalcPreAppDiscData: Boolean;
        State: Record State;
        Ship_stname: Text[50];

    local procedure InitialiseVariables()
    begin
        TotalDiscount := 0;
        ASPValue := 0;
    end;

    procedure SetParameters(StartDate: Date; EndDate: Date; AreaCode: Code[20]; PCHCode: Code[20]; SPCode: Code[20]; PreviousYear: Boolean)
    begin
        GblStartDate := StartDate;
        GBLEndDate := EndDate;
        GBLAreaCode := AreaCode;
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
}

