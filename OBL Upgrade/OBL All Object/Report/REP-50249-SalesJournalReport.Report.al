report 50249 "Sales Journal Report"
{
    // --MSVRN 091117--
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesJournalReport.rdl';


    dataset
    {
        dataitem("Sales Jpurnal Data"; "Sales Jpurnal Data")
        {
            DataItemTableView = SORTING("State Code", "Customer Code")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "Invoice No.", "Customer Code", "Customer City", "Customer Type", "State Code", "Sales Territory", "Unit of Measure Code", "Item Code";
            column(ShowChainName; ShowChainName)
            {
            }
            column(StateCode_SalesJpurnalData; "Sales Jpurnal Data"."State Code")
            {
            }
            column(CustomerCode_SalesJpurnalData; "Sales Jpurnal Data"."Customer Code")
            {
            }
            column(Quantity_SalesJpurnalData; "Sales Jpurnal Data".Quantity)
            {
            }
            column(SalesLineSalesType_SalesJpurnalData2; "Sales Jpurnal Data"."Sales Line Sales Type")
            {
            }
            column(Detailed; Detailed)
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(TotalCDAvail; TotalCDAvail)
            {
            }
            column(AmountinLakhs; AmountinLakhs)
            {
            }
            column(RefCode; GetRefCode("Sales Jpurnal Data"."Item Code"))
            {
            }
            column(Week_SalesJpurnalData; "Sales Jpurnal Data".Week)
            {
            }
            column(Quarter_SalesJpurnalData; "Sales Jpurnal Data".Quarter)
            {
            }
            column(FinancialYear_SalesJpurnalData; "Sales Jpurnal Data"."Financial Year")
            {
            }
            column(ReviewZone; GetZoneCode("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(ParentCode; GetParentCode("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(Month_SalesJpurnalData; "Sales Jpurnal Data".Month)
            {
            }
            column(MonthNo_SalesJpurnalData; "Sales Jpurnal Data"."Month No")
            {
            }
            column(SalesPersonCodeNew; SalesPersonCodeNew)
            {
            }
            column(SalesPersonNameNew; SalesPersonNameNew)
            {
            }
            column(ERPSize_SalesJpurnalData; GetItemSizeCode("Sales Jpurnal Data"."Item Code"))
            {
            }
            column(Day_SalesJpurnalData; "Sales Jpurnal Data".Day)
            {
            }
            column(TableauProdCode; GetTableauProdCode("Sales Jpurnal Data"."Item Code"))
            {
            }
            column(SKUCat_SalesJpurnalData; "Sales Jpurnal Data"."SKU Cat.")
            {
            }
            column(TypeCodeDescription_SalesJpurnalData; "Sales Jpurnal Data"."Type Code Description")
            {
            }
            column(SaleType_SalesJpurnalData; "Sales Jpurnal Data"."Sale Type")
            {
            }
            column(TypeCategoryCode_SalesJpurnalData; "Sales Jpurnal Data"."Type Category Code")
            {
            }
            column(Enterprises_SalesJpurnalData; "Sales Jpurnal Data".Enterprises)
            {
            }
            column(ZoneCode; GetZoneCode("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(GetType_SalesJpurnalData; "Sales Jpurnal Data"."Get Type")
            {
            }
            column(StateDescription_SalesJpurnalData; "Sales Jpurnal Data"."State Description")
            {
            }
            column(Territory_SalesJpurnalData; GetTerritory("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(PMTCode_SalesJpurnalData; "Sales Jpurnal Data"."PMT Code")
            {
            }
            column(CustomerType2_SalesJpurnalData; "Sales Jpurnal Data"."Customer Type2")
            {
            }
            column(SalesPersonCode_SalesJpurnalData; "Sales Jpurnal Data"."Sales Person Code")
            {
            }
            column(NPDType_SalesJpurnalData; "Sales Jpurnal Data"."NPD Type")
            {
            }
            column(OrderReceivedDate_SalesJpurnalData; "Sales Jpurnal Data"."Order Received Date")
            {
            }
            column(Ashwamedha_SalesJpurnalData; "Sales Jpurnal Data".Ashwamedha)
            {
            }
            column(GrossWeight_SalesJpurnalData; "Sales Jpurnal Data"."Gross Weight")
            {
            }
            column(OBTB_SalesJpurnalData; GetOBTB("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(NetWeight_SalesJpurnalData; "Sales Jpurnal Data"."Net Weight")
            {
            }
            column(OBTBNewExisting_SalesJpurnalData; "Sales Jpurnal Data"."OBTB New/Existing")
            {
            }
            column(SalesPersonName; "Sales Jpurnal Data"."Sales Person Name")
            {
            }
            column(Liquidation_SalesJpurnalData; "Sales Jpurnal Data".Liquidation)
            {
            }
            column(ManufStrategy_SalesJpurnalData; "Sales Jpurnal Data"."Manuf Strategy")
            {
            }
            column(SONo_SalesJpurnalData; "Sales Jpurnal Data"."S/O No.")
            {
            }
            column(TruckNo_SalesJpurnalData; "Sales Jpurnal Data"."Truck No.")
            {
            }
            column(LRNo_SalesJpurnalData; "Sales Jpurnal Data"."LR No.")
            {
            }
            column(TransportedName_SalesJpurnalData; "Sales Jpurnal Data"."Transported Name")
            {
            }
            column(OfferCode_SalesJpurnalData; "Sales Jpurnal Data"."Offer Code")
            {
            }
            column(ExternalDocNo_SalesJpurnalData; "Sales Jpurnal Data"."External Doc. No.")
            {
            }
            column(FormCode_SalesJpurnalData; "Sales Jpurnal Data"."Form Code")
            {
            }
            column(TransportMethod_SalesJpurnalData; "Sales Jpurnal Data"."Transport Method")
            {
            }
            column(GRNo_SalesJpurnalData; "Sales Jpurnal Data"."GR No.")
            {
            }
            column(GRDate_SalesJpurnalData; "Sales Jpurnal Data"."GR Date")
            {
            }
            column(PCHName; GetPCHName("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(GovtSPName; GetGovtSPName("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(ChainName; GetChainName("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(CustomerGSTNo; GetCustGSTNo("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(TradeDiscount_SalesJpurnalData; "Sales Jpurnal Data"."Trade Discount")
            {
            }
            column(OtherClaim_SalesJpurnalData; "Sales Jpurnal Data"."Other Claim")
            {
            }
            column(ORCTerms_SalesJpurnalData; "Sales Jpurnal Data"."ORC Terms")
            {
            }
            column(InsuranceClaim_SalesJpurnalData; "Sales Jpurnal Data"."Insurance Claim")
            {
            }
            column(ADRemarks_SalesJpurnalData; "Sales Jpurnal Data"."AD Remarks")
            {
            }
            column(OrderProcessedDate_SalesJpurnalData; "Sales Jpurnal Data"."Order Processed Date")
            {
            }
            column(PromiseDeliveryDate_SalesJpurnalData; "Sales Jpurnal Data"."Promise Delivery Date")
            {
            }
            column(BusinessDevName; GetBussinessDevName("Sales Jpurnal Data"."Business Development"))
            {
            }
            column(GovtProjectSalesName; GetGovtProjectSalesName("Sales Jpurnal Data"."Govt. Project Sales"))
            {
            }
            column(OrientBellBotiqueName; GetOrientBellBotiqueName("Sales Jpurnal Data"."Orient Bell Boutique"))
            {
            }
            column(SalesLineSalesType_SalesJpurnalData; "Sales Jpurnal Data"."Sales Line Sales Type")
            {
            }
            column(CKA_SalesJpurnalData; "Sales Jpurnal Data".CKA)
            {
            }
            column(ShiptoCity_SalesJpurnalData; "Sales Jpurnal Data"."Ship-to City")
            {
            }
            column(Retail_SalesJpurnalData; "Sales Jpurnal Data".Retail)
            {
            }
            column(TrfPurPrice_SalesJpurnalData; "Sales Jpurnal Data"."Trf/Pur Price")
            {
            }
            column(PrivateSPRespName; GetPvtSPName("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(BranchCode_SalesJpurnalData; "Sales Jpurnal Data"."Branch Code")
            {
            }
            column(AreaCodeName; GetAreaCode("Sales Jpurnal Data"."Customer Code"))
            {
            }
            column(SalesLineRemark_SalesJpurnalData; "Sales Jpurnal Data"."Sales Line Remark")
            {
            }
            column(GRValue_SalesJpurnalData; "Sales Jpurnal Data"."GR Value")
            {
            }
            column(MakeSODate_SalesJpurnalData; "Sales Jpurnal Data"."Make SO Date")
            {
            }
            column(ReleasingDate_SalesJpurnalData; "Sales Jpurnal Data"."Releasing Date")
            {
            }
            column(MRPBOX_SalesJpurnalData; "Sales Jpurnal Data"."MRP /BOX")
            {
            }
            column(CustPriceGroup_SalesJpurnalData; "Sales Jpurnal Data"."Cust. Price Group")
            {
            }
            column(MRPSqm_SalesJpurnalData; "Sales Jpurnal Data"."MRP /Sqm")
            {
            }
            column(AD1Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD1/Sqm")
            {
            }
            column(AD2Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD2/Sqm")
            {
            }
            column(AD3Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD3/Sqm")
            {
            }
            column(AD4Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD4/Sqm")
            {
            }
            column(AD5Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD5/Sqm")
            {
            }
            column(AD6Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD6/Sqm")
            {
            }
            column(AD7Sqm_SalesJpurnalData; "Sales Jpurnal Data"."AD7/Sqm")
            {
            }
            column(TotalADSqm_SalesJpurnalData; "Sales Jpurnal Data"."Total AD/Sqm")
            {
            }
            column(BillingRateSqm_SalesJpurnalData; "Sales Jpurnal Data"."Billing Rate/Sqm")
            {
            }
            column(BuyerRateSqm_SalesJpurnalData; "Sales Jpurnal Data"."Buyer Rate/Sqm")
            {
            }
            column(ItemDescription_SalesJpurnalData; "Sales Jpurnal Data"."Item Description")
            {
            }
            column(ItemCategoryCode_SalesJpurnalData; "Sales Jpurnal Data"."Item Category Code")
            {
            }
            column(QualityCode_SalesJpurnalData; "Sales Jpurnal Data"."Quality Code")
            {
            }
            column(CustomerType_SalesJpurnalData; "Sales Jpurnal Data"."Customer Type")
            {
            }
            column(SalesType_SalesJpurnalData; "Sales Jpurnal Data"."Sales Type")
            {
            }
            column(LocationCode_SalesJpurnalData; "Sales Jpurnal Data"."Location Code")
            {
            }
            column(Pay_SalesJpurnalData; "Sales Jpurnal Data".Pay)
            {
            }
            column(ItemCode_SalesJpurnalData; "Sales Jpurnal Data"."Item Code")
            {
            }
            column(CustomerName_SalesJpurnalData; "Sales Jpurnal Data"."Customer Name")
            {
            }
            column(CustomerCity_SalesJpurnalData; "Sales Jpurnal Data"."Customer City")
            {
            }
            column(InvoiceNo_SalesJpurnalData; "Sales Jpurnal Data"."Invoice No.")
            {
            }
            column(PostingDate_SalesJpurnalData; "Sales Jpurnal Data"."Posting Date")
            {
            }
            column(UnitofMeasure_SalesJpurnalData; "Sales Jpurnal Data"."Unit of Measure")
            {
            }
            column(SqMt_SalesJpurnalData; "Sales Jpurnal Data"."Sq. Mt.")
            {
            }
            column(BasicAmount_SalesJpurnalData; "Sales Jpurnal Data"."Basic Amount")
            {
            }
            column(ExciseDuty_SalesJpurnalData; "Sales Jpurnal Data"."Excise Duty")
            {
            }
            column(ExciseAmount_SalesJpurnalData; "Sales Jpurnal Data"."Excise Amount")
            {
            }
            column(QD_SalesJpurnalData; "Sales Jpurnal Data".QD)
            {
            }
            column(AQD_SalesJpurnalData; "Sales Jpurnal Data".AQD)
            {
            }
            column(Value_SalesJpurnalData; "Sales Jpurnal Data".Value)
            {
            }
            column(CashDiscount_SalesJpurnalData; "Sales Jpurnal Data"."Cash Discount")
            {
            }
            column(SalesValue_SalesJpurnalData; "Sales Jpurnal Data"."Sales Value")
            {
            }
            column(Frieght_SalesJpurnalData; "Sales Jpurnal Data".Frieght)
            {
            }
            column(AD1_SalesJpurnalData; "Sales Jpurnal Data".AD1)
            {
            }
            column(AD2_SalesJpurnalData; "Sales Jpurnal Data".AD2)
            {
            }
            column(AD3_SalesJpurnalData; "Sales Jpurnal Data".AD3)
            {
            }
            column(AD4_SalesJpurnalData; "Sales Jpurnal Data".AD4)
            {
            }
            column(AD5_SalesJpurnalData; "Sales Jpurnal Data".AD5)
            {
            }
            column(AD6_SalesJpurnalData; "Sales Jpurnal Data".AD6)
            {
            }
            column(AD7_SalesJpurnalData; "Sales Jpurnal Data".AD7)
            {
            }
            column(TotalAD_SalesJpurnalData; "Sales Jpurnal Data"."Total AD")
            {
            }
            column(InsuranceCharge_SalesJpurnalData; "Sales Jpurnal Data"."Insurance Charge")
            {
            }
            column(EntryTax_SalesJpurnalData; "Sales Jpurnal Data"."Entry Tax")
            {
            }
            column(VAT_SalesJpurnalData; "Sales Jpurnal Data".VAT)
            {
            }
            column(VATCess_SalesJpurnalData; "Sales Jpurnal Data"."VAT Cess")
            {
            }
            column(GST_SalesJpurnalData; "Sales Jpurnal Data"."GST%")
            {
            }
            column(TotalGST_SalesJpurnalData; "Sales Jpurnal Data"."Total GST")
            {
            }
            column(TCSAmount_SalesJpurnalData; "Sales Jpurnal Data"."TCS Amount")
            {
            }
            column(TotalTax_SalesJpurnalData; "Sales Jpurnal Data"."Total Tax")
            {
            }
            column(NetValue_SalesJpurnalData; "Sales Jpurnal Data"."Net Value")
            {
            }
            column(ItemClassification; GetItemClassification("Sales Jpurnal Data"."Item Code"))
            {
            }
            column(GroupCodeDescription; GetGroupCodeDescription("Sales Jpurnal Data"."Group Code"))
            {
            }
            column(DealerCode; GetDealerCode("Sales Jpurnal Data"."Dealer Code"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesPersonNameNew := '';
                SalesPersonCodeNew := '';
                IF Customer.GET("Sales Jpurnal Data"."Customer Code") THEN BEGIN
                    SalesPersonCodeNew := Customer."Salesperson Code";
                    SalesPersonNameNew := Customer."Salesperson Description";
                END;
                TotalCDAvail += "Sales Jpurnal Data"."CD Availed from Utilisation";
                AmountinLakhs := "Sales Jpurnal Data".Value / 100000;
            end;

            trigger OnPostDataItem()
            begin
                GetPCHName("Sales Jpurnal Data"."Customer Code")
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Detail; Detailed)
                {
                    Visible = false;
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

    trigger OnPreReport()
    begin

        IF STRPOS(FORMAT("Sales Jpurnal Data".GETFILTER("Sales Jpurnal Data"."Posting Date")), '.') <> 1 THEN
            DateFrom := FORMAT("Sales Jpurnal Data".GETRANGEMIN("Sales Jpurnal Data"."Posting Date"));

        IF STRPOS(FORMAT("Sales Jpurnal Data".GETFILTER("Sales Jpurnal Data"."Posting Date")), '.')
          <> STRLEN(FORMAT("Sales Jpurnal Data".GETFILTER("Sales Jpurnal Data"."Posting Date"))) - 1 THEN
            DateTo := FORMAT("Sales Jpurnal Data".GETRANGEMAX("Sales Jpurnal Data"."Posting Date"));

        IF UPPERCASE(USERID) = 'ADMIN' THEN
            ShowChainName := TRUE;
    end;

    var
        Text001: Label 'State Cust. Wise Sales Journal';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        DateFrom: Text;
        DateTo: Text;
        ShowChainName: Boolean;
        Detailed: Boolean;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesPersonCodeNew: Code[20];
        SalesPersonNameNew: Text;
        TotalCDAvail: Decimal;
        Customer: Record Customer;
        Check: Report "Check";
        AmountinLakhs: Decimal;

    local procedure GetItemClassification(ItemCode: Code[20]): Code[10]
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Item Classification");
    end;

    local procedure GetGroupCodeDescription(GroupCode: Code[10]): Text[100]
    var
        ItemGroup: Record "Item Group";
    begin
        IF ItemGroup.GET(GroupCode) THEN
            EXIT(ItemGroup.Description);
    end;

    local procedure GetDealerCode(DealerCode: Code[20]): Code[20]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        IF SalespersonPurchaser.GET(DealerCode) THEN
            EXIT(SalespersonPurchaser."Customer No.");
    end;

    local procedure GetPCHName(CustomerNo: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        IF SalespersonPurchaser.GET(Customer."PCH Code") THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    local procedure GetGovtSPName(CustomerNo: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        IF SalespersonPurchaser.GET(Customer."Govt. SP Resp.") THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    local procedure GetPvtSPName(CustomerNo: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        IF SalespersonPurchaser.GET(Customer."Private SP Resp.") THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    local procedure GetAreaCode(CustomerNo: Code[20]): Code[20]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."Area Code")
    end;

    local procedure GetChainName(CustomerNo: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."Chain Name");
    end;

    local procedure GetCustGSTNo(CustomerNo: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."GST Registration No.");
    end;

    local procedure GetBussinessDevName(BusinessDevCode: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        IF SalespersonPurchaser.GET(BusinessDevCode) THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    local procedure GetGovtProjectSalesName(GovtProjectSalesCode: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        IF SalespersonPurchaser.GET(GovtProjectSalesCode) THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    local procedure GetOrientBellBotiqueName(OrientBellBotiqueCode: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        IF SalespersonPurchaser.GET(OrientBellBotiqueCode) THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    local procedure GetRefCode(ItemCode: Code[20]): Code[20]
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Old Code");
    end;

    local procedure GetTableauProdCode(ItemCode: Code[20]): Text
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Tableau Product Group");
    end;

    local procedure GetZoneCode(CustomerNo: Code[20]): Text
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."Tableau Zone")
    end;

    local procedure GetParentCode(CustomerNo: Code[20]): Text
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."Parent Customer No.")
    end;

    local procedure GetPremStd(ItemCode: Code[20]): Code[10]
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT('');
    end;

    local procedure GetTerritory(CustomerCode: Code[20]): Code[10]
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerCode) THEN
            EXIT(Customer."Area Code");
    end;

    local procedure GetCustomerType2(CustomerCode: Code[20]): Code[20]
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerCode) THEN
            EXIT(Customer."Customer Type");
    end;

    local procedure GetAshwamedha(CustomerCode: Code[20]): Text
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerCode) THEN
            EXIT(Customer."Aadhaar No.");
    end;

    local procedure GetOBTB(CustomerCode: Code[20]): Text
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerCode) THEN BEGIN
            IF (STRPOS(UPPERCASE(Customer."Customer Type"), 'ENTERPRISE') > 0) OR
                (STRPOS(UPPERCASE(Customer."Customer Type"), 'CKA') > 0) OR (STRPOS(UPPERCASE(Customer."Customer Type"), 'PROJECT') > 0) THEN
                EXIT('In Active')
            ELSE
                IF (STRPOS(UPPERCASE(Customer."Customer Type"), 'DEALER') > 0) OR (STRPOS(UPPERCASE(Customer."Customer Type"), 'DISTRIBUTER') > 0) THEN
                    EXIT(FORMAT(Customer."OBTB Status"));
        END;
    end;

    local procedure GetNPDTyp(ItemCode: Code[20]): Text[20]
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item.NPD);
    end;

    local procedure GetLiquidation(ItemCode: Code[20]): Boolean
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item.Liquidaton);
    end;

    local procedure GetManufStrategy(ItemCode: Code[20]): Text
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(FORMAT(Item."Manuf. Strategy"));
    end;

    local procedure GetFinancialYear(PostingDate: Date): Text
    begin
        IF (DATE2DMY(PostingDate, 2) < 4) THEN
            EXIT((FORMAT(DATE2DMY(PostingDate, 3) - 1) + '-' + COPYSTR(FORMAT(DATE2DMY(PostingDate, 3)), 3)))
        ELSE
            EXIT((FORMAT(DATE2DMY(PostingDate, 3)) + '-' + COPYSTR(FORMAT(DATE2DMY(PostingDate, 3) + 1), 3)))
    end;

    local procedure GetOBTBNew(CustomerCode: Code[20]): Text
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerCode) THEN BEGIN
            IF Customer."OBTB Joining Date" <> 0D THEN
                IF GetFinancialYear(TODAY) = GetFinancialYear(Customer."OBTB Joining Date") THEN
                    EXIT('New')
                ELSE
                    EXIT('Old');
        END;
    end;

    local procedure GetItemSizeCode(ItemCode: Code[20]): Text[50]
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Size Code Desc.");
    end;

    local procedure GetItemTypeCodeDesc(ItemCode: Code[20]): Text[50]
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Type Code Desc.");
    end;

    local procedure GetItemTypeCategoryCode(ItemCode: Code[20]): Text[50]
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Type Category Code Desc.");
    end;

    local procedure GetMonthNo(PostingDate: Date): Integer
    begin
        EXIT(DATE2DMY(PostingDate, 2));
    end;

    local procedure GetSaleType(CustomerCode: Code[20]; PMTCode: Text): Text
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerCode) THEN BEGIN
            IF (STRPOS(Customer."Tableau Zone", 'Enterprise') > 0) OR (STRPOS(Customer."Tableau Zone", 'Exim') > 0) OR (STRPOS(Customer."Tableau Zone", 'CKA') > 0) THEN
                EXIT('Direct')
            ELSE
                IF ((STRPOS(Customer."Tableau Zone", 'East') > 0) OR (STRPOS(Customer."Tableau Zone", 'West') > 0)
                   OR (STRPOS(Customer."Tableau Zone", 'North') > 0) OR (STRPOS(Customer."Tableau Zone", 'South') > 0)) AND (PMTCode <> '') THEN
                    EXIT('InDirect')
                ELSE
                    IF ((STRPOS(Customer."Tableau Zone", 'East') > 0) OR (STRPOS(Customer."Tableau Zone", 'West') > 0)
                       OR (STRPOS(Customer."Tableau Zone", 'North') > 0) OR (STRPOS(Customer."Tableau Zone", 'South') > 0)) AND (PMTCode = '') THEN
                        EXIT('Retail')
                    ELSE
                        EXIT(Customer."Tableau Zone");
        END;
    end;
}

