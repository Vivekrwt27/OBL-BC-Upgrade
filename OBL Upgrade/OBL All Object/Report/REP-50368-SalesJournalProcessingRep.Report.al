report 50368 "Sales Journal Processing Rep"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Posting Date" = FIELD("Posting Date"),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''),
                                          Type = FILTER(Item),
                                          Quantity = FILTER(<> 0),
                                          "Item Category Code" = FILTER('D001' | 'T001' | 'M001' | 'H001'));

                trigger OnAfterGetRecord()
                var
                    BaseUOM: Record "Item Unit of Measure";
                    ItemLedEntry: Record "Item Ledger Entry";
                begin

                    IF NOT IsSalesJournalAlreadyExist("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.") THEN
                        InsertSalesJournalData();
                end;
            }

            trigger OnPreDataItem()
            begin
                DeleteSalesJournalOldData(StartDate, EndDate);
                "Sales Invoice Header".SETRANGE("Posting Date", StartDate, EndDate);
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
        StartDate := TODAY - 1;
        EndDate := TODAY - 1;
    end;

    trigger OnPostReport()
    begin
        MESSAGE('Task has been completed!!!');
    end;

    var
        StartDate: Date;
        EndDate: Date;

    local procedure DeleteSalesJournalOldData(StartDate: Date; EndDate: Date)
    var
        SalesJournalData: Record "Sales Jpurnal Data";
    begin
        IF StartDate = 0D THEN
            ERROR('Start Date must have a value');

        IF EndDate = 0D THEN
            ERROR('End Date must have a value');

        SalesJournalData.RESET();
        SalesJournalData.SETRANGE("Posting Date", StartDate, EndDate);
        IF SalesJournalData.FINDFIRST THEN
            SalesJournalData.DELETEALL();
    end;

    local procedure IsSalesJournalAlreadyExist(DocNo: Code[20]; DocLineNo: Integer): Boolean
    var
        SalesJournalData: Record "Sales Jpurnal Data";
    begin
        SalesJournalData.RESET();
        SalesJournalData.SETRANGE("Invoice No.", DocNo);
        SalesJournalData.SETRANGE("Line No.", DocLineNo);
        IF SalesJournalData.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    local procedure GetTCSAmount(SalesLine: Record "Sales Invoice Line"): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: record "TCS Setup";
        TCSAmount: Decimal;
    begin
        Clear(TCSAmount);

        TCSSetup.Get();
        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TCSAmount += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;
        exit(Round(TCSAmount, 1));
    end;


    local procedure InsertSalesJournalData()
    var
        SalesJournalData: Record "Sales Jpurnal Data";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesJournalData1: Record "Sales Jpurnal Data";
        OrderNo: Code[20];
        OrderDate: Date;
        SupplierName: Text[50];
        VendorShipmentNo: Code[20];
        GRNNo: Code[20];
        GST: Decimal;
        QualityCode: Code[10];
        CartonsQty: Decimal;
        SqmtrQty: Decimal;
        Amt: Decimal;
        VendorInvoiceDate: Date;
        batch: Code[20];
        PurchLocation: Code[20];
        SalesLocation: Code[20];
        IGSTper: Decimal;
        SGSTper: Decimal;
        CGSTper: Decimal;
        TotalGST: Decimal;
        DetGstLedEntry: Record "Detailed GST Entry Buffer";
        TotalAmt: Decimal;
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
    begin

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
        Clear(TotalAmt);
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        PurchLocation := '';
        SalesLocation := '';
        begin
            Clear(IGSTper);
            Clear(SGSTper);
            Clear(CGSTper);
            Clear(GST);


            DetGstLedEntry.RESET();
            DetGstLedEntry.SETRANGE("Document No.", "Sales Invoice Line"."Order No.");
            // DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
            DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
            IF DetGstLedEntry.FINDFIRST THEN begin
                DetGstLedEntry.CalcSums("GST Amount");
                IGSTAmt := abs(DetGstLedEntry."GST Amount");
                IGSTper := DetGstLedEntry."GST %";
            end;



            DetGstLedEntry.RESET();
            DetGstLedEntry.SETRANGE("Document No.", "Sales Invoice Line"."Order No.");
            //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
            DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
            IF DetGstLedEntry.FINDFIRST THEN begin
                DetGstLedEntry.CalcSums("GST Amount");
                SGSTAmt := abs(DetGstLedEntry."GST Amount");
                SGSTper := DetGstLedEntry."GST %";
            end;


            DetGstLedEntry.RESET();
            DetGstLedEntry.SETRANGE("Document No.", "Sales Invoice Line"."Order No.");
            //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
            DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
            IF DetGstLedEntry.FINDFIRST THEN begin
                DetGstLedEntry.CalcSums("GST Amount");
                CGSTAmt := abs(DetGstLedEntry."GST Amount");
                CGSTper := DetGstLedEntry."GST %";
            end;

            Clear(TotalAmt);
            Clear(TotalGST);
            TotalGST := IGSTper + SGSTper + CGSTper;
            TotalAmt := IGSTAmt + SGSTAmt + CGSTAmt;

        end;

        SalesJournalData.INIT;
        SalesJournalData."Entry No." := SalesJournalData.GetLastEntryNo() + 1;
        SalesJournalData."Item Code" := "Sales Invoice Line"."No.";
        //16225 SalesJournalData."State Code" := "Sales Invoice Line".State;
        //16225  SalesJournalData."State Description" := GetStateName("Sales Invoice Line".State);
        SalesJournalData."Invoice No." := "Sales Invoice Line"."Document No.";
        SalesJournalData."Line No." := "Sales Invoice Line"."Line No.";
        SalesJournalData."Posting Date" := "Sales Invoice Header"."Posting Date";
        SalesJournalData."Customer Code" := "Sales Invoice Header"."Sell-to Customer No.";
        SalesJournalData."Customer Name" := "Sales Invoice Header"."Sell-to Customer Name";
        SalesJournalData."Customer City" := "Sales Invoice Header"."Sell-to City";
        SalesJournalData."Item Description" := "Sales Invoice Line".Description + "Sales Invoice Line"."Description 2";
        SalesJournalData.Quantity := "Sales Invoice Line".Quantity;
        SalesJournalData."ERP Size" := GetItemSizeCode(SalesJournalData."Item Code");
        SalesJournalData."Type Code Description" := GetItemTypeCodeDesc(SalesJournalData."Item Code");
        SalesJournalData."Type Category Code" := GetItemTypeCategoryCode(SalesJournalData."Item Code");
        SalesJournalData.CRT := "Sales Invoice Line".Quantity;
        SalesJournalData."Unit of Measure" := "Sales Invoice Line"."Unit of Measure";
        SalesJournalData."Unit of Measure Code" := "Sales Invoice Line"."Unit of Measure Code";
        SalesJournalData."Sq. Mt." := GetSqMtr(SalesJournalData."Item Code", SalesJournalData."Unit of Measure Code", SalesJournalData.Quantity);
        SalesJournalData."Basic Amount" := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity;
        //16225 SalesJournalData."Excise Duty" := "Sales Invoice Line"."Excise Amount";
        //16225  SalesJournalData."Excise Amount" := ROUND("Sales Invoice Line".Amount + "Sales Invoice Line"."Excise Amount", 0.01, '=');
        SalesJournalData.AD1 := "Sales Invoice Line"."Discount Amt 1";
        SalesJournalData.AD2 := "Sales Invoice Line"."Discount Amt 2";
        SalesJournalData.AD3 := "Sales Invoice Line"."Discount Amt 3";
        SalesJournalData.AD4 := "Sales Invoice Line"."Discount Amt 4";
        SalesJournalData.AD5 := "Sales Invoice Line"."System Discount Amount";
        SalesJournalData.AD6 := "Sales Invoice Line"."Discount Amt 6";
        SalesJournalData.AD7 := "Sales Invoice Line"."Discount Amt 7";
        SalesJournalData."Total AD" := "Sales Invoice Line"."Discount Amt 1" + "Sales Invoice Line"."Discount Amt 2" + "Sales Invoice Line"."Discount Amt 3"
                      + "Sales Invoice Line"."Discount Amt 4" + "Sales Invoice Line"."System Discount Amount" + "Sales Invoice Line"."Discount Amt 6" + "Sales Invoice Line"."Discount Amt 7";
        SalesJournalData.QD := "Sales Invoice Line"."Quantity Discount Amount" - "Sales Invoice Line"."Accrued Discount";
        SalesJournalData.AQD := "Sales Invoice Line"."Accrued Discount";
        SalesJournalData.Value := ROUND(SalesJournalData."Excise Amount", 0.01, '=');
        SalesJournalData."Cash Discount" := GetCashDiscount("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.");
        SalesJournalData."Sales Value" := GetSalesValue(SalesJournalData.Value, SalesJournalData."Cash Discount");
        SalesJournalData.Frieght := 0;
        GetInsuranceEntryChargeAmount("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.", SalesJournalData."Insurance Charge", SalesJournalData."Entry Tax");
        SalesJournalData.VAT := "Sales Invoice Line"."System Discount Amount";
        SalesJournalData."VAT Cess" := GetVATCESSAmount();
        SalesJournalData."GST%" := TotalGST;
        SalesJournalData."TCS Amount" := GetTCSAmount("Sales Invoice Line");
        SalesJournalData."Total GST" := TotalAmt;
        //16225   SalesJournalData."GST%" := "Sales Invoice Line"."GST %";
        //16225   SalesJournalData."Total GST" := "Sales Invoice Line"."Total GST Amount";
        //16225   SalesJournalData."TCS Amount" := "Sales Invoice Line"."TDS/TCS Amount";
        //16225   SalesJournalData."Total Tax" := "Sales Invoice Line"."Tax Amount";
        //16225    SalesJournalData."Net Value" := ROUND(SalesJournalData."Sales Value" + SalesJournalData.Frieght + "Sales Invoice Line"."CESS Amount" +
        //16225                                    SalesJournalData."Total Tax" + SalesJournalData."Insurance Charge" + SalesJournalData."Entry Tax", 0.01, '=');
        SalesJournalData."Item Classification" := GetItemClassification("Sales Invoice Line"."No.");
        SalesJournalData."Item Category Code" := "Sales Invoice Line"."Item Category Code";
        SalesJournalData."Group Code" := "Sales Invoice Line"."Group Code";
        SalesJournalData."Quality Code" := "Sales Invoice Line"."Quality Code";
        SalesJournalData."Location Code" := "Sales Invoice Header"."Location Code";
        SalesJournalData.Pay := "Sales Invoice Header".Pay;
        SalesJournalData."Customer Type" := "Sales Invoice Header"."Customer Type";
        SalesJournalData."Sales Type" := "Sales Invoice Header"."Sales Type";
        SalesJournalData."Dealer Code" := "Sales Invoice Header"."Dealer Code";
        SalesJournalData."S/O No." := "Sales Invoice Header"."Order No.";
        SalesJournalData."Make SO Date" := "Sales Invoice Header"."Make Order Date";
        SalesJournalData."Releasing Date" := "Sales Invoice Header"."Releasing Date";
        //16225    SalesJournalData."MRP /BOX" := "Sales Invoice Line"."MRP Price";
        SalesJournalData."MRP /Sqm" := GetMRPperSqMtr(SalesJournalData."Item Code", SalesJournalData."Unit of Measure Code", SalesJournalData.Quantity);
        SalesJournalData."AD1/Sqm" := "Sales Invoice Line".D1;
        SalesJournalData."AD2/Sqm" := "Sales Invoice Line".D2;
        SalesJournalData."AD3/Sqm" := "Sales Invoice Line".D3;
        SalesJournalData."AD4/Sqm" := "Sales Invoice Line".D4;
        SalesJournalData."AD5/Sqm" := "Sales Invoice Line".S1;
        SalesJournalData."AD6/Sqm" := "Sales Invoice Line".D6;
        SalesJournalData."AD7/Sqm" := "Sales Invoice Line".D7;
        IF SalesJournalData."Sq. Mt." <> 0 THEN
            SalesJournalData."Total AD/Sqm" := ROUND((("Sales Invoice Line"."Discount Amt 1" + "Sales Invoice Line"."Discount Amt 2" + "Sales Invoice Line"."Discount Amt 3"
                                                  + "Sales Invoice Line"."Discount Amt 4" + "Sales Invoice Line"."System Discount Amount") / SalesJournalData."Sq. Mt."), 0.01, '=');

        SalesJournalData."Billing Rate/Sqm" := GetBillingPricePerSqm(SalesJournalData."Sq. Mt.", SalesJournalData.Value);
        SalesJournalData."Offer Code" := "Sales Invoice Line"."Offer Code";
        SalesJournalData."External Doc. No." := "Sales Invoice Header"."External Document No.";
        //16225    SalesJournalData."Form Code" := "Sales Invoice Header"."Form Code";
        SalesJournalData."Transport Method" := "Sales Invoice Header"."Shipping Agent Code";
        SalesJournalData."Cust. Price Group" := "Sales Invoice Line"."Customer Price Group";
        SalesJournalData."GR No." := "Sales Invoice Header"."GR No.";
        SalesJournalData."GR Date" := "Sales Invoice Header"."GR Date";
        SalesJournalData."Sales Line Remark" := "Sales Invoice Line".Remarks;
        SalesJournalData."GR Value" := GetGrValue();
        SalesJournalData."Sales Person Code" := "Sales Invoice Header"."Salesperson Code";
        SalesJournalData."Variable Cost" := "Sales Invoice Line"."V. Cost";
        SalesJournalData."Truck No." := "Sales Invoice Header"."Truck No.";
        SalesJournalData."LR No." := "Sales Invoice Header"."GR No.";
        SalesJournalData."Transported Name" := "Sales Invoice Header"."Transporter Name";

        SalespersonPurchaser.GET("Sales Invoice Header"."Salesperson Code");
        SalesJournalData."Sales Person Name" := SalespersonPurchaser.Name;
        SalesJournalData."PCH Name" := GetPCHName(SalesJournalData."Customer Code");
        SalesJournalData."Govt. SP. Resp." := GetGovtSPName(SalesJournalData."Customer Code");
        SalesJournalData."Private SP .Resp." := GetPvtSPName(SalesJournalData."Customer Code");
        SalesJournalData."Branch Code" := "Sales Invoice Header"."Shortcut Dimension 1 Code";
        SalesJournalData."Sales Territory" := GetAreaCode(SalesJournalData."Customer Code");
        SalesJournalData."ORC Terms" := "Sales Invoice Header"."ORC Terms";
        SalesJournalData."Sales Line Sales Type" := "Sales Invoice Header"."Sales Type";
        SalesJournalData."Ship-to City" := "Sales Invoice Header"."Ship-to City";
        SalesJournalData."Trf/Pur Price" := GetTRFPurchasePrice();
        SalesJournalData."GST No" := GetCustGSTNo(SalesJournalData."Customer Code");
        SalesJournalData."Trade Discount" := GetTradeDiscountAmount();
        GetClaimAmounts("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.",
                        SalesJournalData.Frieght, SalesJournalData."Other Claim", SalesJournalData."Insurance Claim");
        SalesJournalData."AD Remarks" := "Sales Invoice Line"."AD Remarks";
        SalesJournalData."Order Processed Date" := "Sales Invoice Header"."Payment Date 3";
        SalesJournalData."Promise Delivery Date" := GetPromiseDeliveryDate("Sales Invoice Header"."Order No.");
        SalesJournalData."Business Development" := "Sales Invoice Header"."Business Development";
        SalesJournalData."Govt. Project Sales" := "Sales Invoice Header"."Govt. Project Sales";
        SalesJournalData."Orient Bell Boutique" := "Sales Invoice Header"."Orient Bell Tiles Boutique";
        SalesJournalData.CKA := "Sales Invoice Header"."CKA Code";
        SalesJournalData.Retail := "Sales Invoice Header"."Retail Code";
        SalesJournalData."Ref Code" := GetRefCode("Sales Invoice Line"."No.");
        SalesJournalData."Tableau Product Code" := GetTableauProdCode("Sales Invoice Line"."No.");
        SalesJournalData.Zone := GetZoneCode(SalesJournalData."Customer Code");
        SalesJournalData."PMT Code" := "Sales Invoice Header"."PMT Code";
        SalesJournalData."Order Received Date" := "Sales Invoice Header"."Order Booked Date";
        SalesJournalData."Gross Weight" := "Sales Invoice Line"."Gross Weight";
        SalesJournalData."Net Weight" := "Sales Invoice Line"."Net Weight";
        SalesJournalData.Week := GetWeekNo("Sales Invoice Header"."Posting Date");
        SalesJournalData.Month := GetMonthName("Sales Invoice Header"."Posting Date");
        SalesJournalData."Month No" := GetMonthNo("Sales Invoice Header"."Posting Date");
        SalesJournalData.Quarter := GetQuarterNo("Sales Invoice Header"."Posting Date");
        SalesJournalData."Financial Year" := GetFinancialYear("Sales Invoice Header"."Posting Date");
        SalesJournalData.Day := GetDay("Sales Invoice Header"."Posting Date");
        SalesJournalData."SKU Cat." := GetPremStd("Sales Invoice Line"."No.");
        SalesJournalData."Sale Type" := GetSaleType("Sales Invoice Header"."Sell-to Customer No.", "Sales Invoice Header"."PMT Code");
        SalesJournalData.Enterprises := GetEnterprise("Sales Invoice Header"."PMT Code");
        SalesJournalData."Get Type" := GetType("Sales Invoice Header"."PMT Code");
        SalesJournalData.Territory := GetTerritory("Sales Invoice Header"."Sell-to Customer No.");
        SalesJournalData."Customer Type2" := GetCustomerType2("Sales Invoice Header"."Sell-to Customer No.");
        SalesJournalData."NPD Type" := GetNPDTyp("Sales Invoice Line"."No.");
        SalesJournalData.Ashwamedha := GetAshwamedha("Sales Invoice Header"."Sell-to Customer No.");
        SalesJournalData.OBTB := GetOBTB("Sales Invoice Header"."Sell-to Customer No.");
        SalesJournalData."OBTB New/Existing" := GetOBTBNew("Sales Invoice Header"."Sell-to Customer No.");
        SalesJournalData.Liquidation := GetLiquidation("Sales Invoice Line"."No.");
        SalesJournalData."Manuf Strategy" := GetManufStrategy("Sales Invoice Line"."No.");
        SalesJournalData."Cust Parent Code" := GetParentCode("Sales Invoice Header"."Sell-to Customer No.");
        ;
        "Sales Invoice Header".CALCFIELDS("CD Availed from Utilisation");
        SalesJournalData1.RESET();
        SalesJournalData1.SETRANGE("Invoice No.", "Sales Invoice Header"."No.");
        SalesJournalData1.SETFILTER("CD Availed from Utilisation", '<>%1', 0);
        IF NOT SalesJournalData1.FINDFIRST THEN
            SalesJournalData."CD Availed from Utilisation" := "Sales Invoice Header"."CD Availed from Utilisation";

        SalesJournalData.INSERT(TRUE);
    end;

    local procedure GetStateName(StateCode: Code[10]): Text[50]
    var
        State: Record State;
    begin
        IF State.GET(StateCode) THEN
            EXIT(State.Description);
    end;

    local procedure GetSqMtr(ItemCode: Code[20]; UOMCode: Code[10]; Quantity: Decimal): Decimal
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(ROUND(Item.UomToSqm(ItemCode, UOMCode, Quantity), 0.01, '='));
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

    local procedure GetCashDiscount(DocNo: Code[20]; DocLineNo: Decimal) InvDisc1: Decimal
    var
        // PostedStrOrderLineDetails: Record "13798";
        GLSetup: Record "General Ledger Setup";
    begin
        CLEAR(InvDisc1);
        GLSetup.GET();
        //16225 Table N/F Start
        /*  PostedStrOrderLineDetails.RESET;
          PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
          PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
          PostedStrOrderLineDetails.SETRANGE("Invoice No.", DocNo);
          PostedStrOrderLineDetails.SETRANGE("Line No.", DocLineNo);
          IF PostedStrOrderLineDetails.FIND('-') THEN
              REPEAT
                  CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                      PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                          BEGIN
                              IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                  IF PostedStrOrderLineDetails.Amount < 0 THEN
                                      InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount)
                                  ELSE
                                      InvDisc1 := InvDisc1 + -PostedStrOrderLineDetails.Amount;
                          END;
                  END;
              UNTIL PostedStrOrderLineDetails.NEXT = 0;*///16225 Table N/F End
    end;

    local procedure GetSalesValue(Value: Decimal; CashDiscount: Decimal): Decimal
    var
    //16225 PostedStrOrderLineDetails: Record "13798";
    begin

        IF CashDiscount > 0 THEN
            EXIT(Value - ABS(CashDiscount))
        ELSE
            EXIT(Value - (CashDiscount));
    end;

    local procedure GetInsuranceEntryChargeAmount(DocNo: Code[20]; DocLineNo: Decimal; var InsuranceAmount: Decimal; var ET1: Decimal)
    var
    //16225 PostedStrOrderLineDetails: Record "13798";
    begin
        CLEAR(InsuranceAmount);
        CLEAR(ET1);
        //16225 Table N/F Start
        /*  PostedStrOrderLineDetails.RESET;
          PostedStrOrderLineDetails.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");
          PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
          PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
          PostedStrOrderLineDetails.SETRANGE("Invoice No.", DocNo);
          PostedStrOrderLineDetails.SETRANGE("Line No.", DocLineNo);
          IF PostedStrOrderLineDetails.FIND('-') THEN
              REPEAT
                  CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                      PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                          BEGIN
                              CASE PostedStrOrderLineDetails."Charge Type" OF
                                  PostedStrOrderLineDetails."Charge Type"::Insurance:
                                      InsuranceAmount := InsuranceAmount + PostedStrOrderLineDetails.Amount;
                              END;
                              IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                  ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                          END;
                  END;
              UNTIL PostedStrOrderLineDetails.NEXT = 0;*///16225 Table N/F End
    end;

    local procedure GetVATCESSAmount() tgVATCess: Decimal
    var
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        TaxDetails: Record "Tax Detail";
        Customer: Record Customer;
        Location: Record Location;
        VATAmount: Decimal;
    begin
        //16225 field N/f Start
        /* IF "Sales Invoice Line"."Tax %" <> 0 THEN BEGIN
             TaxAreaLine.RESET;
             TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', "Sales Invoice Header"."Tax Area Code");
             IF TaxAreaLine.FIND('-') THEN
                 REPEAT
                     IF TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code") THEN BEGIN
                         IF TaxJurisdiction."Additional Tax" THEN BEGIN
                             TaxDetails.RESET;
                             TaxDetails.SETCURRENTKEY("Tax Jurisdiction Code", "Tax Group Code", "Form Code", "Effective Date");
                             TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                             TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', "Sales Invoice Line"."Tax Group Code");
                             TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                             TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                             IF TaxDetails.FIND('+') THEN;
                             tgVATCess := ("Sales Invoice Line"."Tax Base Amount" * TaxDetails."Tax Below Maximum") / 100;
                         END;
                     END;
                 UNTIL TaxAreaLine.NEXT = 0;
         END;*///16225 field N/f end

        Customer.GET("Sales Invoice Line"."Sell-to Customer No.");
        IF Location.GET("Sales Invoice Header"."Location Code") THEN
            IF Location."State Code" = Customer."State Code" THEN;
        //16225    VATAmount := "Sales Invoice Line"."Tax Amount";

        IF VATAmount = 0 THEN
            tgVATCess := 0;
    end;

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

    local procedure GetMRPperSqMtr(ItemCode: Code[20]; UOMCode: Code[10]; Quantity: Decimal): Decimal
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        Sqmt := Item.UomToSqm(ItemCode, UOMCode, Quantity);
        /*  IF Sqmt <> 0 THEN
        //16225      EXIT(ROUND(("Sales Invoice Line"."MRP Price" * Quantity / Sqmt), 0.01, '='));*/
    end;

    local procedure GetBillingPricePerSqm(SqrMtr: Decimal; Value: Decimal): Decimal
    var
        Item: Record Item;
        Sqmt: Decimal;
    begin
        IF SqrMtr <> 0 THEN
            EXIT(ROUND(Value / SqrMtr, 0.01, '='));
    end;

    local procedure GetGrValue(): Decimal
    begin
        "Sales Invoice Header".CALCFIELDS("Gross Weight");
        IF "Sales Invoice Header"."GR Value" <> 0 THEN
            IF ("Sales Invoice Header"."Gross Weight" <> 0) THEN
                EXIT(("Sales Invoice Header"."GR Value" / "Sales Invoice Header"."Gross Weight") * "Sales Invoice Line"."Gross Weight");
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


    procedure GetItemLedgerEntry(DocNo: Code[20]; DocLineNo: Integer) EntryNo: Integer
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", DocNo);
        ValueEntry.SETRANGE("Document Line No.", DocLineNo);
        IF ValueEntry.FINDFIRST THEN BEGIN
            EntryNo := ValueEntry."Item Ledger Entry No.";
        END;
    end;

    local procedure GetTRFPurchasePrice(): Decimal
    var
        itemprice: Decimal;
        itemprice1: Decimal;
        ItemApplicationEntry: Record "Item Application Entry";
        TransferReceiptLine: Record "Transfer Receipt Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        itemprice := 0;
        itemprice1 := 0;
        ItemApplicationEntry.RESET;
        ItemApplicationEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
        ItemApplicationEntry.SETRANGE("Outbound Item Entry No.", GetItemLedgerEntry("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No."));
        IF ItemApplicationEntry.FINDFIRST THEN BEGIN
            IF ItemLedgerEntry.GET(ItemApplicationEntry."Inbound Item Entry No.") THEN BEGIN
                IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer THEN BEGIN
                    //16225 Field N/F Start
                    /* TransferReceiptLine.RESET;
                     TransferReceiptLine.SETRANGE("Document No.", ItemLedgerEntry."Document No.");
                     TransferReceiptLine.SETRANGE("Item No.", ItemLedgerEntry."Item No.");
                     IF TransferReceiptLine.FINDFIRST THEN
                         itemprice := TransferReceiptLine."MRP Price";*///16225 Field N/F End
                END ELSE BEGIN
                    IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase THEN BEGIN
                        //16225 Field N/F Start
                        /* PurchInvLine.RESET;
                         PurchInvLine.SETRANGE(PurchInvLine."Receipt No.", ItemLedgerEntry."Document No.");
                         PurchInvLine.SETRANGE("No.", ItemLedgerEntry."Item No.");
                         IF PurchInvLine.FINDFIRST THEN
                            itemprice1 := PurchInvLine."Assessable Value";*///16225 Field N/F End
                    END ELSE BEGIN
                        itemprice1 := (ItemLedgerEntry."Cost Amount (Actual)" / ItemLedgerEntry.Quantity);
                    END;
                END;
            END;
        END;

        EXIT(itemprice + itemprice1);
    end;

    local procedure GetCustGSTNo(CustomerNo: Code[20]): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."GST Registration No.");
    end;

    local procedure GetTradeDiscountAmount(): Decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        SalesInvoiceLine.SETRANGE(Type, "Sales Invoice Line".Type);
        SalesInvoiceLine.CALCSUMS(Quantity);
        "Sales Invoice Header".CALCFIELDS("CD Availed from Utilisation");
        EXIT(ABS("Sales Invoice Header"."CD Availed from Utilisation" / SalesInvoiceLine.Quantity * "Sales Invoice Line".Quantity));
    end;

    local procedure GetClaimAmounts(DocNo: Code[20]; DocLineNo: Decimal; var FrightChargeAmt: Decimal; var OthClaim: Decimal; var InsuranceClaim: Decimal)
    var
    //16225   PostedStrOrderLineDetails1: Record "13798";
    begin
        FrightChargeAmt := 0;
        OthClaim := 0;
        InsuranceClaim := 0;
        //16225 table N/F Start
        /*  PostedStrOrderLineDetails1.RESET;
          PostedStrOrderLineDetails1.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");
          PostedStrOrderLineDetails1.SETRANGE(Type, PostedStrOrderLineDetails1.Type::Sale);
          PostedStrOrderLineDetails1.SETRANGE("Document Type", PostedStrOrderLineDetails1."Document Type"::Invoice);
          PostedStrOrderLineDetails1.SETRANGE("Invoice No.", DocNo);
          PostedStrOrderLineDetails1.SETRANGE("Line No.", DocLineNo);
          IF PostedStrOrderLineDetails1.FIND('-') THEN
              REPEAT
                  IF NOT PostedStrOrderLineDetails1."Payable to Third Party" THEN BEGIN
                      IF PostedStrOrderLineDetails1."Tax/Charge Type" = PostedStrOrderLineDetails1."Tax/Charge Type"::Charges THEN BEGIN
                          CASE PostedStrOrderLineDetails1."Tax/Charge Group" OF
                              'FREIGHT':
                                  BEGIN
                                      FrightChargeAmt := FrightChargeAmt + PostedStrOrderLineDetails1.Amount;
                                  END;
                              'OTH_CLAIM':
                                  BEGIN
                                      OthClaim := OthClaim + PostedStrOrderLineDetails1.Amount;
                                  END;
                              'INS_CLAIM':
                                  BEGIN
                                      InsuranceClaim := InsuranceClaim + PostedStrOrderLineDetails1.Amount;
                                  END;
                          END;
                      END;
                  END;
              UNTIL PostedStrOrderLineDetails1.NEXT = 0;*///16225 table N/F End
    end;

    local procedure GetPromiseDeliveryDate(OrderNo: Code[20]): Date
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        SalesHeaderArchive.RESET;
        SalesHeaderArchive.SETRANGE("No.", OrderNo);
        IF SalesHeaderArchive.FINDFIRST THEN
            EXIT(SalesHeaderArchive."Promised Delivery Date");
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

    local procedure GetWeekNo(PostingDate: Date): Integer
    var
        recDate: Record Date;
        StartDate: Date;
    begin

        IF (DATE2DMY(PostingDate, 1) >= 1) AND (DATE2DMY(PostingDate, 1) <= 7) THEN
            EXIT(1)
        ELSE
            IF (DATE2DMY(PostingDate, 1) >= 8) AND (DATE2DMY(PostingDate, 1) <= 14) THEN
                EXIT(2)
            ELSE
                IF (DATE2DMY(PostingDate, 1) >= 15) AND (DATE2DMY(PostingDate, 1) <= 21) THEN
                    EXIT(3)
                ELSE
                    IF (DATE2DMY(PostingDate, 1) >= 22) AND (DATE2DMY(PostingDate, 1) <= 28) THEN
                        EXIT(4)
                    ELSE
                        EXIT(5)
        /*StartDate := CALCDATE('-CM',PostingDate);
        IF DATE2DMY(PostingDate,2) = 1 THEN BEGIN
          IF (DATE2DWY(PostingDate,2) = 52) OR  (DATE2DWY(PostingDate,2) = 53) THEN
            EXIT(1)
          ELSE
            EXIT(DATE2DWY(PostingDate,2)+1)
        END
        ELSE
          EXIT(DATE2DWY(PostingDate,2)-DATE2DWY(StartDate,2)+1);*/

    end;

    local procedure GetMonthName(PostingDate: Date): Text
    begin
        EXIT(FORMAT(PostingDate, 0, '<Month Text>'));
    end;

    local procedure GetMonthNo(PostingDate: Date): Integer
    begin

        CASE DATE2DMY(PostingDate, 2) OF
            1:
                EXIT(10);
            2:
                EXIT(11);
            3:
                EXIT(12);
            4:
                EXIT(1);
            5:
                EXIT(2);
            6:
                EXIT(3);
            7:
                EXIT(4);
            8:
                EXIT(5);
            9:
                EXIT(6);
            10:
                EXIT(7);
            11:
                EXIT(8);
            12:
                EXIT(9);
        END;
    end;

    local procedure GetQuarterNo(PostingDate: Date): Integer
    begin
        EXIT(((((DATE2DMY(PostingDate, 2) - 1) DIV 3) + 3) MOD 4) + 1);
    end;

    local procedure GetFinancialYear(PostingDate: Date): Text
    begin
        IF (DATE2DMY(PostingDate, 2) < 4) THEN
            EXIT((FORMAT(DATE2DMY(PostingDate, 3) - 1) + '-' + COPYSTR(FORMAT(DATE2DMY(PostingDate, 3)), 3)))
        ELSE
            EXIT((FORMAT(DATE2DMY(PostingDate, 3)) + '-' + COPYSTR(FORMAT(DATE2DMY(PostingDate, 3) + 1), 3)))
    end;

    local procedure GetDay(PostingDate: Date): Integer
    begin
        EXIT(DATE2DMY(PostingDate, 1));
    end;

    local procedure GetPremStd(ItemCode: Code[20]): Text
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN
            EXIT(Item."Quality Code Desc.");
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
                   OR (STRPOS(Customer."Tableau Zone", 'North') > 0) OR (STRPOS(Customer."Tableau Zone", 'South') > 0) OR (STRPOS(Customer."Tableau Zone", 'Central') > 0)) AND (PMTCode <> '') THEN
                    EXIT('InDirect')
                ELSE
                    IF ((STRPOS(Customer."Tableau Zone", 'East') > 0) OR (STRPOS(Customer."Tableau Zone", 'West') > 0)
                       OR (STRPOS(Customer."Tableau Zone", 'North') > 0) OR (STRPOS(Customer."Tableau Zone", 'South') > 0) OR (STRPOS(Customer."Tableau Zone", 'Central') > 0)) AND (PMTCode = '') THEN
                        EXIT('Retail')
                    ELSE
                        EXIT(Customer."Tableau Zone");
        END;
    end;

    local procedure GetEnterprise(PMTCode: Text): Text
    var
        Customer: Record Customer;
        PMTchr: Text;
    begin
        IF PMTCode = '' THEN
            EXIT('');
        IF (STRLEN(PMTCode) = 15) THEN BEGIN
            PMTchr := COPYSTR(PMTCode, 1, 1);
            IF (PMTchr = 'G') THEN
                EXIT('GET')
            ELSE
                IF (PMTchr = 'P') THEN
                    EXIT('PET')
                ELSE
                    IF (PMTchr = 'S') THEN
                        EXIT('SET')
                    ELSE
                        EXIT('');
        END
        ELSE
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
            EXIT(Customer.Outbreaks);
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

    local procedure GetType(PMTCode: Text): Text
    var
        Customer: Record Customer;
        PMTDiscountMaster: Record "PMT Discount Master";
    begin
        IF PMTCode <> '' THEN BEGIN
            IF (COPYSTR(PMTCode, 1, 1) = 'G') THEN BEGIN
                PMTDiscountMaster.RESET();
                PMTDiscountMaster.SETRANGE("Lead ID", PMTCode);
                IF PMTDiscountMaster.FINDFIRST THEN BEGIN
                    IF (PMTDiscountMaster."Contractor Name" = '') OR (STRPOS(UPPERCASE(PMTDiscountMaster."Contractor Name"), 'NON KEY ACCOUNT') > 0) THEN
                        EXIT('Non Key Account')
                    ELSE
                        EXIT('Key Account');
                END;
            END
            ELSE
                EXIT('');
        END;
    end;

    local procedure GetParentCode(CustomerNo: Code[20]): Text
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustomerNo);
        EXIT(Customer."Parent Customer No.")
    end;
}

