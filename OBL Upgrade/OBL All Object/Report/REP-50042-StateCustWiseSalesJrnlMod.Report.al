report 50042 "State Cust.Wise SalesJrnl Mod"
{
    // --MSVRN 091117--
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\StateCustWiseSalesJrnlMod.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING(State, "Sell-to Customer No.")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "No.", "Sell-to Customer No.", "Bill-to City", "Customer Type", State, "Sales Territory";
            column(TotalCDAvail; TotalCDAvail)
            {
            }
            column(ShowChainName; ShowChainName)
            {
            }
            column(ChainName; ChainName)
            {
            }
            column(MakeOrderDate; "Sales Invoice Header"."Make Order Date")
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(Detailed; Detailed)
            {
            }
            column(StateGroup; StateNum)
            {
            }
            column(Statecode; Statecode)
            {
            }
            column(Statename; Statename)
            {
            }
            column(PostingDate; "Sales Invoice Header"."Posting Date")
            {
            }
            column(CustNo; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(CustName; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(City; "Sales Invoice Header"."Sell-to City")
            {
            }

            column(DealerCode; DealerCode)
            {
            }
            column(SIHpay; "Sales Invoice Header".Pay)
            {
            }
            column(CustType; "Sales Invoice Header"."Customer Type")
            {
            }
            column(SalesType; "Sales Invoice Header"."Sales Type")
            {
            }
            column(OrderNo; "Sales Invoice Header"."Order No.")
            {
            }
            column(ReleDate; "Sales Invoice Header"."Releasing Date")
            {
            }
            column(Set; "Sales Invoice Header".BD)
            {
            }
            column(get; "Sales Invoice Header".GPS)
            {
            }
            column(pet; "Sales Invoice Header".CKA)
            {
            }
            column(TotWeight; TotWeight)
            {
            }
            column(RatioFreightAmt; RatioFreightAmt)
            {
            }
            column(PchCode; PchCode)
            {
            }
            column(GPchCode; GPchCode)
            {
            }
            column(PriPchCode; PriPchCode)
            {
            }
            column(AreaCode; AreaCode)
            {
            }
            column(zone1; zone)
            {
            }
            column(ExDocNumber; "Sales Invoice Header"."External Document No.")
            {
            }
            column(FormCode; '') // 16630 blank "Sales Invoice Header"."Form Code"
            {
            }
            column(SagentCode; "Sales Invoice Header"."Shipping Agent Code")
            {
            }
            column(GrossWeight; "Sales Invoice Header"."Gross Weight")
            {
            }
            column(cdavail; "Sales Invoice Header"."CD Availed from Utilisation")
            {
            }
            column(GRNo; "Sales Invoice Header"."GR No.")
            {
            }
            column(GRDate; "Sales Invoice Header"."GR Date")
            {
            }
            column(SalesPerson; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(Order_booked; "Sales Invoice Header"."Order Booked Date")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(PMT_code; "Sales Invoice Header"."PMT Code")
            {
            }
            column(TransporterName; "Transporter Name")
            {
            }
            column(SalesPersonSIH; Salesperson.Name)
            {
            }
            column(SalesPersonName; Salesperson.Name)
            {
            }
            column(PCHName; Salesperson1.Name)
            {
            }
            column(GovtSPName; Salesperson2.Name)
            {
            }
            column(PrivSPName; Salesperson3.Name)
            {
            }
            column(ShDim1; "Sales Invoice Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ORCCOde; "Sales Invoice Header"."ORC Terms")
            {
            }
            column(ShiptoCity; SalesInvHeader."Ship-to City")
            {
            }
            column(Cust_gstno; GSTNO)
            {
            }
            column(Order_process; "Sales Invoice Header"."Payment Date 3")
            {
            }
            column(promis_dt; promis)
            {
            }
            column(BusnssDev; SalesPer[1].Name)
            {
            }
            column(GovtProjSles; SalesPer[2].Name)
            {
            }
            column(OrientBoutique; SalesPer[3].Name)
            {
            }
            column(CKA; "Sales Invoice Header"."CKA Code")
            {
            }
            column(RETAIL; "Sales Invoice Header"."Retail Code")
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Posting Date" = FIELD("Posting Date"),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''),
                                          Type = FILTER('Item|Fixed Asset|Resource'),
                                          Quantity = FILTER(<> 0));
                RequestFilterFields = "Unit of Measure Code", "No.";
                column(BuyerPricePerSqm; BuyerPricePerSqm)
                {
                }
                column(InvNo; "Sales Invoice Line"."Document No.")
                {
                }
                column(ref_code; refcode)
                {
                }
                column(Tableau_prod; tpc)
                {
                }
                column(Descrip; "Sales Invoice Line".Description + ' ' + "Sales Invoice Line"."Description 2")
                {
                }
                column(Quantity; "Sales Invoice Line".Quantity)
                {
                }
                column(Custo_price; "Sales Invoice Line"."Customer Price Group")
                {
                }
                column(TCS_amt; TCSAmt) // 16630  "Sales Invoice Line"."TDS/TCS Amount"
                {
                }
                column(TradeDisc; TradeDisc * "Sales Invoice Line".Quantity)
                {
                }
                column(UOM; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(SqrMtr; SqrMtr)
                {
                }
                column(FreightAmt; FreightAmt)
                {
                }
                column(UnitPriceMulQual; "Sales Invoice Line"."Unit Price" * Quantity)
                {
                }
                column(ExAmount; ExAmount)
                {
                }
                column(LineDisAmt; LineDisAmt)
                {
                }
                column(DisAmtMinsAqAmt; "Sales Invoice Line"."Quantity Discount Amount" - "Sales Invoice Line"."Accrued Discount")
                {
                }
                column(ItemDiscount; ItemDiscount)
                {
                }
                column(AccDis; "Sales Invoice Line"."Accrued Discount")
                {
                }
                column(Val; Value)
                {
                }
                column(ExciseAmt; 0)// 16630 blank "Sales Invoice Line"."Excise Amount"
                {
                }
                column(SalesValue; SalesValue)
                {
                }
                column(Taxamount; Taxamount)
                {
                }
                column(GrValue; (RATPERKG) * ("Sales Invoice Line"."Gross Weight"))
                {
                }
                column(Insurance1; Insurance1)
                {
                }
                column(tgVATCess; tgVATCess)
                {
                }
                column(TotalValue; TotalValue)
                {
                }
                column(Roundoff; Roundoff)
                {
                }
                column(NetValue; NetValue)
                {
                }
                column(EXAmt1; 0) // 16630 blank "Sales Invoice Line"."Excise Amount"
                {
                }
                column(Dis1; "Sales Invoice Line"."Discount Amt 1")
                {
                }
                column(Dis2; "Sales Invoice Line"."Discount Amt 2")
                {
                }
                column(Dis3; "Sales Invoice Line"."Discount Amt 3")
                {
                }
                column(Dis4; "Sales Invoice Line"."Discount Amt 4")
                {
                }
                column(Dis5; "Sales Invoice Line"."System Discount Amount")
                {
                }
                column(Dis6; "Sales Invoice Line"."Discount Amt 6")
                {
                }
                column(Dis7; "Sales Invoice Line"."Discount Amt 7")
                {
                }
                column(SILTaxAmt; 0) // 16630 blank  "Sales Invoice Line"."Tax Amount"
                {
                }
                column(ET1; ET1)
                {
                }
                column(SILNo; "Sales Invoice Line"."No.")
                {
                }
                column(ItemClass; Item."Item Classification")
                {
                }
                column(ItemCatCode; "Sales Invoice Line"."Item Category Code")
                {
                }
                column(ItemGrpDes; TgItemGrp.Description)
                {
                }
                column(QualityCode; "Sales Invoice Line"."Quality Code")
                {
                }
                column(LocationCode; "Sales Invoice Line"."Location Code")
                {
                }
                column(MRPPrice; 0) // 16630 blank "Sales Invoice Line"."MRP Price"
                {
                }
                column(MRPPerSqmtr; MRPPerSqmtr)
                {
                }
                column(D1; "Sales Invoice Line".D1)
                {
                }
                column(D2; "Sales Invoice Line".D2)
                {
                }
                column(D3; "Sales Invoice Line".D3)
                {
                }
                column(D4; "Sales Invoice Line".D4)
                {
                }
                column(D5; "Sales Invoice Line".S1)
                {
                }
                column(D6; "Sales Invoice Line".D6)
                {
                }
                column(D7; "Sales Invoice Line".D7)
                {
                }
                column(LineDisPerSqMeter; LineDisPerSqMeter)
                {
                }
                column(BillingRate; BillingRate)
                {
                }
                column(BuyerRateSqm; BuyerRateSqm)
                {
                }
                column(InvDisc1; InvDisc1)
                {
                }
                column(OfferCode; "Sales Invoice Line"."Offer Code")
                {
                }
                column(CustPriceGroup; "Sales Invoice Line"."Customer Price Group")
                {
                }
                column(AD_req; "Sales Invoice Line"."Approval Required") //16767
                {

                }
                column(Remarks; "Sales Invoice Line".Remarks)
                {
                }
                column(Vcost; "Sales Invoice Line"."V. Cost")
                {
                }
                column(var1; var1)
                {
                }
                column(var2; Var2)
                {
                }
                column(ItemNo; "Sales Invoice Line"."No.")
                {
                }
                column(itemprice1; itemprice + itemprice1)
                {
                }
                column(gstper; GSTPERCENT("Document No.")) // 16630  "Sales Invoice Line"."GST %"
                {
                }
                column(tgst; TotalGSTAmtLine("Document No."))// 16630  "Sales Invoice Line"."Total GST Amount"
                {
                }
                column(FrightChargeAmt; FrightChargeAmt)
                {
                }
                column(OthClm; OthClm)
                {
                }
                column(InsuranceClm; InsuranceClm)
                {
                }
                column(TotalQty; TotalQty)
                {
                }
                column(ad_remarks; "Sales Invoice Line"."AD Remarks")
                {
                }
                column(Gweight; "Sales Invoice Line"."Gross Weight")
                {
                }
                column(nweight; "Sales Invoice Line"."Net Weight")
                {
                }

                trigger OnAfterGetRecord()
                var
                    BaseUOM: Record "Item Unit of Measure";
                    ItemLedEntry: Record "Item Ledger Entry";
                    TCSentry: Record "TCS Entry";
                begin

                    Clear(TCSAmt);
                    TCSentry.Reset();
                    TCSentry.SetRange("Document No.", "Document No.");
                    if TCSentry.FindSet() then
                        TCSAmt += TCSentry."TCS Amount";

                    FreightAmt := 0;
                    TotalQty := 0;
                    recSalesInvLn.RESET;
                    recSalesInvLn.SETRANGE("Document No.", "Document No.");
                    recSalesInvLn.SETRANGE(Type, Type);
                    IF recSalesInvLn.FINDFIRST THEN
                        REPEAT
                            TotalQty += recSalesInvLn.Quantity;
                        UNTIL recSalesInvLn.NEXT = 0;

                    /*
                    PostedStrOrderLineDetails.RESET;
                    PostedStrOrderLineDetails.SETCURRENTKEY(Type,"Invoice No.","Item No.","Line No.");//Rahul 060706
                    PostedStrOrderLineDetails.SETRANGE(Type,PostedStrOrderLineDetails.Type::Sale);
                    PostedStrOrderLineDetails.SETRANGE("Document Type",PostedStrOrderLineDetails."Document Type"::Invoice);
                    PostedStrOrderLineDetails.SETRANGE("Invoice No.","Document No.");
                    PostedStrOrderLineDetails.SETRANGE("Charge Type",PostedStrOrderLineDetails."Charge Type"::Freight);
                    PostedStrOrderLineDetails.SETRANGE("Line No.","Line No.");
                    //TRI SC Open
                    IF PostedStrOrderLineDetails.FINDFIRST THEN
                    REPEAT
                      FreightAmt += ABS(PostedStrOrderLineDetails.Amount);
                    UNTIL PostedStrOrderLineDetails.NEXT = 0;
                    */

                    //msvrn 041017>>
                    /* 16630   FrightChargeAmt := 0;
                       OthClm := 0;
                       InsuranceClm := 0;
                       PostedStrOrderLineDetails1.RESET;
                       PostedStrOrderLineDetails1.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");//Rahul 060706
                       PostedStrOrderLineDetails1.SETRANGE(Type, PostedStrOrderLineDetails1.Type::Sale);
                       PostedStrOrderLineDetails1.SETRANGE("Document Type", PostedStrOrderLineDetails1."Document Type"::Invoice);
                       PostedStrOrderLineDetails1.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                       PostedStrOrderLineDetails1.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
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
                                                   OthClm := OthClm + PostedStrOrderLineDetails1.Amount;
                                               END;
                                           'INS_CLAIM':
                                               BEGIN
                                                   InsuranceClm := InsuranceClm + PostedStrOrderLineDetails1.Amount;
                                               END;
                                       END;
                                   END;
                               END;
                           UNTIL PostedStrOrderLineDetails1.NEXT = 0;*/ // 16630
                                                                        //msvrn<<


                    IF Quantity <> 0 THEN  //ND 6700
                        IF BaseUOM.GET("No.", "Unit of Measure Code") THEN
                            IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                                //16630   BuyerPricePerSqm := (("Line Amount" + "Excise Amount" + "Sales Invoice Line"."Line Discount Amount") / Quantity) / BaseUOM."Qty. per Unit of Measure";
                                BuyerPricePerSqm := (("Line Amount" + "Sales Invoice Line"."Line Discount Amount") / Quantity) / BaseUOM."Qty. per Unit of Measure";

                    //Vipul Tri1.0
                    // TRI G.D 06.05.08
                    Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                    IF Location.GET("Location Code") THEN
                        IF Location."State Code" = Cust."State Code" THEN
                            // 16630       VATAmount := "Sales Invoice Line"."Tax Amount";
                            CLEAR(var1);
                    CLEAR(Var2);
                    IF Item.GET("Sales Invoice Line"."No.") THEN
                        var1 := Item."Item Classification";
                    refcode := Item."Old Code";
                    tpc := Item."Tableau Product Group";

                    IF TgItemGrp.GET("Sales Invoice Line"."Group Code") THEN
                        Var2 := TgItemGrp.Description;

                    CLEAR(LineDisPerSqMeter);

                    // 16630   Taxamount := ROUND("Tax Amount", 0.01, '=');
                    CLEAR(Insurance1);
                    CLEAR(ET1);
                    /* 16630  PostedStrOrderLineDetails.RESET;
                      PostedStrOrderLineDetails.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");//Rahul 060706
                      PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                      PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
                      PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                      PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
                      //TRI SC Open
                      IF PostedStrOrderLineDetails.FIND('-') THEN
                          REPEAT
                              CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                  PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                      BEGIN
                                          CASE PostedStrOrderLineDetails."Charge Type" OF
                                              PostedStrOrderLineDetails."Charge Type"::Insurance:
                                                  Insurance1 := Insurance1 + PostedStrOrderLineDetails.Amount;
                                          END;
                                          // IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                          //    InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount);
                                          IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                              ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                                          // TRI SC
                                      END;
                              END;
                          UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ // 16630

                    /* 16630   IF "Sales Invoice Line"."Tax %" <> 0 THEN BEGIN
                           TaxAreaLine.RESET;
                           TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', "Tax Area Code");
                           IF TaxAreaLine.FIND('-') THEN
                               REPEAT
                                   IF TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code") THEN BEGIN
                                       IF TaxJurisdiction."Additional Tax" THEN BEGIN
                                           TaxDetails.RESET;
                                           TaxDetails.SETCURRENTKEY("Tax Jurisdiction Code", "Tax Group Code", "Form Code", "Effective Date");//Rahul 060706
                                           TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                                           TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', "Tax Group Code");
                                           TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                                           TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                                           IF TaxDetails.FIND('+') THEN;
                                           tgVATCess := ("Sales Invoice Line"."Tax Base Amount" * TaxDetails."Tax Below Maximum") / 100;
                                       END;
                                   END;
                               UNTIL TaxAreaLine.NEXT = 0;
                       END;
                       IF VATAmount = 0 THEN
                           tgVATCess := 0;
                       CLEAR(InvDisc1);
                       //IF GlobalDocNo <> "Sales Invoice Line"."Document No." THEN BEGIN
                         PostedStrOrderLineDetails.RESET;
                         PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                         PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
                         PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                         PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
                         IF PostedStrOrderLineDetails.FIND('-') THEN
                             REPEAT
                                 CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                     PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                         BEGIN
                                             IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                                 IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                     InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount)
                                                 ELSE //MSBS.Rao 0713
                                                     InvDisc1 := InvDisc1 + -PostedStrOrderLineDetails.Amount;//MSBS.Rao 0713

                                             //omi
                                             IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup.AddInsuranceDisc THEN
                                                 IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                     InsDisc := InsDisc + ABS(PostedStrOrderLineDetails.Amount)
                                                 ELSE
                                                     InsDisc := InsDisc + -PostedStrOrderLineDetails.Amount;
                                             //omi ends

                                         END;
                                 END;

                             UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ // 16630
                                                                         //MESSAGE('%1',InvDisc1);
                                                                         //END;
                                                                         //GlobalDocNo := "Sales Invoice Line"."Document No.";
                                                                         // TRI SC use VATAmount

                    //InvDisc1 := -1 *InvDisc1 ; //MSKS
                    //TRI SC
                    //ExAmount:= ROUND(("Sales Invoice Line"."Unit Price"*"Sales Invoice Line".Quantity) +  "Sales Invoice Line"."Excise Amount",0.01,'=');
                    // 16630 ExAmount := ROUND("Sales Invoice Line".Amount + "Sales Invoice Line"."Excise Amount", 0.01, '=');  //MSAK
                    ExAmount := ROUND("Sales Invoice Line".Amount, 0.01, '=');  //MSAK
                    IF S1 <> 0 THEN
                        val1 := "Quantity in Sq. Mt." * S1;


                    //IF (D7 <>0) AND ("Posting Date"< 250517D ) THEN
                    IF D7 <> 0 THEN
                        val2 := "Quantity in Sq. Mt." * D7;
                    //    ELSE
                    //     val2 := "Sales Invoice Line"."Discount Amt 7";

                    /*
                     Value:= ROUND(ExAmount - ("Sales Invoice Line"."Discount Amt 1" + "Sales Invoice Line"."Discount Amt 2" + "Sales Invoice Line"."Discount Amt 3"
                              +"Sales Invoice Line"."Discount Amt 4"+val1+"Sales Invoice Line"."Discount Amt 6"+"Sales Invoice Line"."Discount Amt 7") -"Sales Invoice Line"."Quantity Discount Amount",0.01,'=');
                    *///MSAK
                      // Value:= ROUND(ExAmount - (val1) -"Sales Invoice Line"."Quantity Discount Amount",0.01,'=');//MS
                    Value := ROUND(ExAmount, 0.01, '=');

                    LineDisAmt := "Sales Invoice Line"."Discount Amt 1" + "Sales Invoice Line"."Discount Amt 2" + "Sales Invoice Line"."Discount Amt 3"
                                 + "Sales Invoice Line"."Discount Amt 4" + "Sales Invoice Line"."System Discount Amount" + "Sales Invoice Line"."Discount Amt 6" + "Sales Invoice Line"."Discount Amt 7";

                    //LineDisAmt := "Sales Invoice Line"."Line Discount Amount"; //MS
                    IF InvDisc1 > 0 THEN
                        SalesValue := Value - ABS(InvDisc1)
                    ELSE
                        SalesValue := Value - (InvDisc1);
                    /*
                    ExAmount := Amount;
                    Value := ExAmount - InvDisc1;
                    SalesValue := Value + "Excise Amount";
                    */
                    // 16630   NetValue := ROUND(SalesValue + FreightAmt + "Sales Invoice Line"."CESS Amount" + Taxamount + Insurance1 + ET1, 0.01, '=');
                    NetValue := ROUND(SalesValue + FreightAmt + Taxamount + Insurance1 + ET1, 0.01, '=');
                    // Temp Coment
                    SqrMtr := ROUND(Item.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                    Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                    IF SqrMtr <> 0 THEN
                        LineDisPerSqMeter := ROUND((("Sales Invoice Line"."Discount Amt 1" + "Sales Invoice Line"."Discount Amt 2" + "Sales Invoice Line"."Discount Amt 3"
                        + "Sales Invoice Line"."Discount Amt 4" + "Sales Invoice Line"."System Discount Amount") / SqrMtr), 0.01, '=');

                    /* IF Sqmt <> 0 THEN
                         MRPPerSqmtr := ROUND(("MRP Price" * Quantity / Sqmt), 0.01, '=');*/ // 16630
                    IF SqrMtr <> 0 THEN
                        BillingRate := ROUND(Value / SqrMtr, 0.01, '=');
                    //TRI SC 050510
                    /*TRI LM 060207
                    //TotalValue := SalesValue + Taxamount + Insurance1;
                    //NetValue := ROUND(TotalValue,1,'=');
                    Roundoff := NetValue - TotalValue;
                    TRI LM 051207*/
                    /*
                    IF "Sales Invoice Header"."Export Document" = "Sales Invoice Header"."Export Document"::"1" THEN
                       Export := '*'
                    ELSE
                       Export := '';
                     *///TRISC

                    /*
                    IF "Tax Amount"  = 0 THEN
                     Taxamount := "VAT Amount"
                    ELSE
                    */
                    //MSSS
                    DealerCode := '';
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", "Document No.");
                    IF SalesInvHeader.FIND('-') THEN BEGIN
                        SalespersonPurchaser.RESET;
                        IF SalespersonPurchaser.GET(SalesInvHeader."Dealer Code") THEN
                            DealerCode := SalespersonPurchaser."Customer No.";
                    END;

                    GrandTaxAmount := GrandTaxAmount + Taxamount;

                    //TRISC
                    TotalBasicAmt := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity;
                    //TRI SC Open
                    // TRI S
                    /*
                      itemapp.RESET;
                      itemapp.SETCURRENTKEY("Out Bond Entries","Item Code1");
                      itemapp.SETRANGE("Out Bond Entries","Document No.");
                      itemapp.SETRANGE("Item Code1","No.");
                          IF itemapp.FIND('-')THEN
                          itemapp.CALCFIELDS(itemapp."Trf Price",itemapp."Pur Price");
                          itemprice := itemapp."Trf Price"+itemapp."Pur Price";
                    */
                    itemprice := 0;
                    itemprice1 := 0;
                    itemapp.RESET;
                    itemapp.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
                    itemapp.SETRANGE("Outbound Item Entry No.", GetItemLedgerEntry("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No."));
                    IF itemapp.FINDFIRST THEN BEGIN
                        IF ItemLedEntry.GET(itemapp."Inbound Item Entry No.") THEN BEGIN
                            //     ItemLedEntry.CALCFIELDS("Cost Amount (Actual)");
                            IF ItemLedEntry."Entry Type" = ItemLedEntry."Entry Type"::Transfer THEN BEGIN
                                //   itemprice := (ItemLedEntry."Cost Amount (Actual)" / ItemLedEntry.Quantity);
                                TranRecLine.RESET;
                                TranRecLine.SETRANGE("Document No.", ItemLedEntry."Document No.");
                                TranRecLine.SETRANGE("Item No.", ItemLedEntry."Item No.");
                                /* IF TranRecLine.FINDFIRST THEN
                                     itemprice := TranRecLine."MRP Price";*/ // 16630
                            END ELSE BEGIN
                                IF ItemLedEntry."Entry Type" = ItemLedEntry."Entry Type"::Purchase THEN BEGIN
                                    purinvline.RESET;
                                    purinvline.SETRANGE(purinvline."Receipt No.", ItemLedEntry."Document No.");
                                    purinvline.SETRANGE("No.", ItemLedEntry."Item No.");
                                    /*   IF purinvline.FINDFIRST THEN
                                           itemprice1 := purinvline."Assessable Value";*/ // 16630
                                END ELSE BEGIN
                                    itemprice1 := (ItemLedEntry."Cost Amount (Actual)" / ItemLedEntry.Quantity);
                                END;
                            END;
                        END;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    GLSetup.GET;
                    //Vipul
                    Value := 0;
                    val1 := 0;
                    val2 := 0;
                    NetValue := 0;
                    Insurance1 := 0;
                    VATAmount := 0;
                    tgVATCess := 0;
                    LineDisAmt := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //IF "Sales Invoice Header".State = '' THEN
                //   "Sales Invoice Header".State := "Sales Invoice Header"."Customer Price Group";

                TotalCDAvail += "Sales Invoice Header"."CD Availed from Utilisation";

                EVALUATE(StateNum, "Sales Invoice Header".State);
                //
                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
                //
                IF StateRec.GET(State) THEN
                    Statename := StateRec.Description;

                //MSAK.BEGIN 050515
                TotWeight := 0;
                RatioFreightAmt := 0;

                PchCode := '';
                GPchCode := '';
                PriPchCode := '';
                CLEAR(ChainName);
                IF Customer2.GET("Sales Invoice Header"."Sell-to Customer No.") THEN BEGIN
                    PchCode := Customer2."PCH Code";
                    GPchCode := Customer2."Govt. SP Resp.";
                    PriPchCode := Customer2."Private SP Resp.";
                    AreaCode := Customer2."Area Code";
                    ChainName := Customer2."Chain Name";
                    GSTNO := Customer2."GST Registration No.";
                    zone := Customer2."Tableau Zone";
                END;
                IF Salesperson.GET(Customer2."Salesperson Code") THEN;
                IF Salesperson1.GET(PchCode) THEN;
                IF Salesperson2.GET(GPchCode) THEN;
                IF Salesperson3.GET(PriPchCode) THEN;
                //MSAK.END 050515

                RecSalesInvLine.RESET;
                RecSalesInvLine.SETRANGE("Document No.", "No.");
                IF RecSalesInvLine.FINDFIRST THEN BEGIN
                    REPEAT
                        TotWeight += RecSalesInvLine."Gross Weight";
                    UNTIL RecSalesInvLine.NEXT = 0;
                END;
                //MESSAGE('%1=%2',FreightAmt,TotWeight);
                IF TotWeight <> 0 THEN
                    RatioFreightAmt := FreightAmt / TotWeight
                ELSE
                    RatioFreightAmt := 0;
                //MESSAGE('%1',RatioFreightAmt);

                arcsahead.RESET;
                arcsahead.SETRANGE("No.", "Order No.");
                IF arcsahead.FINDFIRST THEN
                    promis := arcsahead."Promised Delivery Date";

                CLEAR(SalesPer);
                IF SalesPer[1].GET("Business Development") THEN;
                IF SalesPer[2].GET("Govt. Project Sales") THEN;
                IF SalesPer[3].GET("Orient Bell Tiles Boutique") THEN;


                "Sales Invoice Header".CALCFIELDS("Gross Weight");
                IF "Sales Invoice Header"."GR Value" <> 0 THEN
                    IF ("Sales Invoice Header"."Gross Weight" <> 0) THEN  //MSAK 29112018
                        RATPERKG := "Sales Invoice Header"."GR Value" / "Sales Invoice Header"."Gross Weight";
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

    trigger OnPostReport()
    begin

        //RepAuditMgt.CreateAudit(50042);
    end;

    trigger OnPreReport()
    begin

        IF STRPOS(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date")), '.') <> 1 THEN
            DateFrom := FORMAT("Sales Invoice Header".GETRANGEMIN("Sales Invoice Header"."Posting Date"));

        IF STRPOS(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date")), '.')
          <> STRLEN(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date"))) - 1 THEN
            DateTo := FORMAT("Sales Invoice Header".GETRANGEMAX("Sales Invoice Header"."Posting Date"));

        IF UPPERCASE(USERID) = 'ADMIN' THEN
            ShowChainName := TRUE;
    end;

    var
        // 16630 PostedStrOrderLineDetails: Record 13798;
        Insurance1: Decimal;
        TCSAmt: Decimal;
        ExAmount: Decimal;
        Value: Decimal;
        SalesValue: Decimal;
        TotalValue: Decimal;
        NetValue: Decimal;
        Roundoff: Decimal;
        SqrMtr: Decimal;
        DateFrom: Text[30];
        DateTo: Text[30];
        Item: Record Item;
        Export: Text[30];
        StateRec: Record State;
        Statename: Text[30];
        Detailed: Boolean;
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        GLSetup: Record "General Ledger Setup";
        InvDisc1: Decimal;
        "---": Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Taxamount: Decimal;
        GrandTaxAmount: Decimal;
        tgVATCess: Decimal;
        TgItemGrp: Record "Item Group";
        Salesperson: Record "Salesperson/Purchaser";
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        TaxDetails: Record "Tax Detail";
        Freight: Decimal;
        Sqmt: Decimal;
        MRPPerSqmtr: Decimal;
        BuyerRateSqm: Decimal;
        // 16630 StructureLineDetails: Record 13798;
        TotalBasicAmt: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        BillingRate: Decimal;
        Statecode: Code[10];
        ET1: Decimal;
        CustWiseSalesValue: Decimal;
        StateWiseSalesvalue: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        Location: Record Location;
        VATAmount: Decimal;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesInvHeader: Record "Sales Invoice Header";
        DealerCode: Code[30];
        CompanyName2: Text[100];
        grvalue: Decimal;
        RATPERKG: Decimal;
        remarks: Boolean;
        InsDisc: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Customer2: Record Customer;
        PchCode: Code[20];
        GPchCode: Code[20];
        PriPchCode: Code[20];
        AreaCode: Code[20];
        FreightAmt: Decimal;
        RecSalesInvLine: Record "Sales Invoice Line";
        TotWeight: Decimal;
        RatioFreightAmt: Decimal;
        Text001: Label 'State Cust. Wise Sales Journal';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        Salesperson1: Record "Salesperson/Purchaser";
        Salesperson2: Record "Salesperson/Purchaser";
        Salesperson3: Record "Salesperson/Purchaser";
        GlobalDocNo: Code[20];
        var1: Code[50];
        Var2: Text[100];
        BuyerPricePerSqm: Decimal;
        LineDisPerSqMeter: Decimal;
        StateNum: Integer;
        ChainName: Text[50];
        ShowChainName: Boolean;
        itemapp: Record "Item Application Entry";
        itemprice: Decimal;
        TranRecLine: Record "Transfer Receipt Line";
        itemprice1: Decimal;
        purinvline: Record "Purch. Inv. Line";
        val1: Decimal;
        val2: Decimal;
        LineDisAmt: Decimal;
        GSTNO: Code[15];
        "//msvrn": Integer;
        InsurenceChargeAmount: Decimal;
        ChargePercentIns: Decimal;
        FrightChargeAmt: Decimal;
        LabourCharges: Decimal;
        OthClm: Decimal;
        InsuranceClm: Decimal;
        // 16630  PostedStrOrderLineDetails1: Record 13798;
        recSalesInvLn: Record "Sales Invoice Line";
        TotalQty: Decimal;
        ItemDiscount: Decimal;
        ToatlVal: Decimal;
        TradeDisc: Decimal;
        TotalCDAvail: Decimal;
        arcsahead: Record "Sales Header Archive";
        promis: Date;
        "--MSVRN--": Integer;
        SalesPer: array[3] of Record "Salesperson/Purchaser";
        refcode: Code[20];
        zone: Code[10];
        tpc: Text[10];


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
            //MESSAGE('%1',EntryNo);
        END;
    end;

    procedure TotalGSTAmtLine(DocNo: Code[20]): Decimal
    var
        PstdSalesInv: Record 113;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        IGSTper: Decimal;
        CGSTper: Decimal;
        SGSTper: Decimal;
        GSTper: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(GSTBaseAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(IGSTper);
        Clear(CGSTper);
        Clear(SGSTper);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        // DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
            IGSTper := DetGstLedEntry."GST %";
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            SGSTAmt := abs(DetGstLedEntry."GST Amount");
            SGSTper := DetGstLedEntry."GST %";
        end;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
            CGSTper := DetGstLedEntry."GST %";
        end;


        Clear(TotalAmt);
        Clear(GSTper);
        TotalAmt := IGSTAmt + SGSTAmt + CGSTAmt;
        GSTper := IGSTper + CGSTper + SGSTper;
        exit(GSTper);
        EXIT(ABS(TotalAmt));
    end;

    procedure GSTPERCENT(DocNo: Code[20]): Decimal
    var
        PstdSalesInv: Record 113;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        IGSTper: Decimal;
        CGSTper: Decimal;
        SGSTper: Decimal;
        GSTper: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(GSTBaseAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(IGSTper);
        Clear(CGSTper);
        Clear(SGSTper);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        // DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            IGSTper := DetGstLedEntry."GST %";
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            SGSTper := DetGstLedEntry."GST %";
        end;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            CGSTper := DetGstLedEntry."GST %";
        end;


        Clear(GSTper);
        GSTper := IGSTper + CGSTper + SGSTper;
        exit(GSTper);
    end;




}

