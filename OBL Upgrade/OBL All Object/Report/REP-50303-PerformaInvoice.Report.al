report 50303 "Performa Invoice"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\PerformaInvoice.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "No.";
            column(SelltoCountryRegionCode_SalesInvoiceHeader; "Sell-to Country/Region Code")
            {
            }
            column(ExportInv; ExportInv)
            {
            }
            column(AddCharge; AddCharge)
            {
            }
            column(Vircode; Vircode)
            {
            }
            column(PriceExp; PriceExp)
            {
            }
            column(PriceExp2; PriceExp2)
            {
            }
            column(CarriedForCaption; CarriedForLbl)
            {
            }
            column(BroughtForCaption; BroughtForLbl)
            {
            }
            column(B2CQRCode; '')
            {
            }
            column(PMTCode; "PMT Code")
            {
            }
            column(loc_satecode; State_Rec."State Code (GST Reg. No.)")
            {
            }
            column(TranName_Sih; "Transporter's Name")
            {
            }
            column(ship_name; "Ship-to Name")
            {
            }
            column(cust_no; "Sell-to Customer No.")
            {
            }
            column(E_way; "E-Way Bill No.")
            {
            }
            column(Tolerance; Tolerance)
            {
            }
            column(PostofLoading; PostofLoading)
            {
            }
            column(PostofDischarge; PostofDischarge)
            {
            }
            column(Origin; Origin)
            {
            }
            column(ship_add1; ShipToAdd[2])
            {
            }
            column(ship_add2; ShipToAdd[3])
            {
            }
            column(ship_city_post; ShipToAdd[4])
            {
            }
            column(Ship_to_pin; ShipToAdd[5])
            {
            }
            column(ship_state; ShipToAdd[9])
            {
            }
            column(ship_add8; "Ship-to Name 2")
            {
            }
            column(BILL_name; BillToAdd[1])
            {
            }
            column(BILL_ADD1; BillToAdd[2])
            {
            }
            column(BILL_ADD2; BillToAdd[3])
            {
            }
            column(BILL_CITY_POST; BillToAdd[4] + '- ' + BillToAdd[5])
            {
            }
            column(BILL_STATE; BillToAdd[9])
            {
            }
            column(NetInWord; NetInWord[1])
            {
            }
            column(cust_gstno_billto; BillToAdd[7])
            {
            }
            column(cust_statecode_billto; BillToAdd[10])
            {
            }
            column(Virtual_ID; BillToAdd[11])
            {
            }
            column(cust_gstno_shipto; ShipToAdd[7])
            {
            }
            column(cust_statecode_shipto; ShipToAdd[10])
            {
            }
            column(BankName; BankDetail[1])
            {
            }
            column(BankCity; BankDetail[2])
            {
            }
            column(BankAccountNo; BankDetail[3])
            {
            }
            column(BankDetailRTGS; BankDetail[4])
            {
            }
            column(BankDetailSWIFT; BankDetail[5])
            {
            }
            column(BankAddress; BankDetail[6])
            {
            }
            column(BankAddress2; BankDetail[7])
            {
            }
            column(custState_code; custState."State Code (GST Reg. No.)")
            {
            }
            column(Company_GST_No; Location."GST Registration No.")
            {
            }
            column(Company_PAN_No; CompanyInfo."P.A.N. No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(StateCode; StateCode)
            {
            }
            column(TradeDiscount_SalesInvoiceHeader; "CD Availed from Utilisation")
            {
            }
            column(Location_Address; Location.Address + ',' + Location."Address 2" + ', ' + Location.City + ',' + State_Rec.Description + ', ' + 'Phone No.' + Location."Phone No.")
            {
            }
            column(Stname; Stname)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(JudText1; JudText[1])
            {
            }
            column(JudText2; JudText[2])
            {
            }
            column(PerJud1; FORMAT(PerJud[1]))
            {
            }
            column(PerJud2; FORMAT(PerJud[2]))
            {
            }
            column(FormText; FormText)
            {
            }
            column(CusPan; Cust1."P.A.N. No.")
            {
            }
            column(CusT_GSTNo; Cust1."GST Registration No.")
            {
            }
            column(Cust_VirtualID; Cust1."Virtual ID")
            {
            }
            column(NewPolicy; NewPolicy)
            {
            }
            column(CurCaption; CurCaption)
            {
            }
            column(Text13705; Text13705)
            {
            }
            column(Text13706; Text13706)
            {
            }
            column(HeaderTextLatest; HeaderTextLatest)
            {
            }
            column(DocnO; CONVERTSTR("Sales Line"."Document No.", '\', '/'))
            {
            }
            column(PostingDate; FORMAT("Posting Date"))
            {
            }
            column(CINNo; 'CETSH-6908 9090')
            {
            }
            column(Authorisigna; 'AUTHORIZED SIGNATORY')
            {
            }
            column(CustomerOrderN; "Sales Order No.")
            {
            }
            column(SelltoCustNo; "Sell-to Customer No.")
            {
            }
            column(CustName; "Sell-to Customer Name")
            {
            }
            column(SelltoAdd; "Sell-to Address")
            {
            }
            column(SelltoAdd2; "Sell-to Address 2")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(Stnameloc; Stname)
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoName2; "Ship-to Name 2")
            {
            }
            column(ShipttoAdd; "Ship-to Address")
            {
            }
            column(ShipttoAdd2; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(CustLST; "Cust LST")
            {
            }
            column(CustCST; "Cust CST")
            {
            }
            column(OrderNo; CONVERTSTR("Sales Order No.", '\', '/'))
            {
            }
            column(OrderDate; FORMAT("Order Date"))
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(VendorName; "Transporter Name")
            {
            }
            column(GrNo; "GR No.")
            {
            }
            column(GrDate; FORMAT("GR Date"))
            {
            }
            column(PONo; "PO No.")
            {
            }
            column(OutStand; 'Rs' + ' ' + FORMAT(Outstand) + ' ' + '(' + 'Including this Invoice' + ')')
            {
            }
            column(pay; Pay)
            {
            }
            column(PaymentTerms_SalesHeader; RecPaymentTerms.Description)
            {
            }
            column(inv_name; invoicename)
            {
            }
            column(pl_suppl; pos)
            {
            }
            column(rem_lubo; REM)
            {
            }
            column(OthClm; OthClm)
            {
            }
            column(InsuranceClm; InsuranceClm)
            {
            }
            column(Container; "Vehicle No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(OuputNos; OuputNos)
                {
                }
                column(copyText1; copyText1)
                {
                }
                column(NoOfLoops; NoOfLoops)
                {
                }
                column(TotalCopies; NoOfCopies)
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemLinkReference = "Sales Header";
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending)
                                        WHERE(Type = FILTER(Item),
                                              Quantity = FILTER(<> 0));
                    RequestFilterFields = "No.";
                    column(TotalNoOfInvoiceLines; TotalNoOfInvoiceLines)
                    {
                    }
                    column(HideCarriedForward; HideCarriedForward)
                    {
                    }
                    column(OtherTaxes; OtherTaxes)
                    {
                    }
                    column(HSNSACCode_SalesInvoiceLine; "HSN/SAC Code")
                    {
                    }
                    column(CRate; CRate)
                    {
                    }
                    column(CAmount; CAmount)
                    {
                    }
                    column(SRate; SRate)
                    {
                    }
                    column(SAmount; SAmount)
                    {
                    }
                    column(URate; URate)
                    {
                    }
                    column(UAmount; UAmount)
                    {
                    }
                    column(IRate; IRate)
                    {
                    }
                    column(IAmount; IAmount)
                    {
                    }
                    column(TotalGSTAmt; TotalGSTAmt)
                    {
                    }
                    column(GSTTotal; GSTTotal)
                    {
                    }
                    column(TotalGSTAmount; TotalGSTAmount)
                    {
                    }
                    //16225 column(TDSTCS_SalesInvoiceLine; "TDS/TCS %") blank
                    column(TDSTCS_SalesInvoiceLine; 0)
                    {
                    }
                    //16225 blank column(TotalTDSTCSInclSHECESS_SalesInvoiceLine; "Total TDS/TCS Incl. SHE CESS")
                    column(TotalTDSTCSInclSHECESS_SalesInvoiceLine; 0)
                    {
                    }
                    column(PageBreak1; PageBreak1)
                    {
                    }
                    column(PageCont; PageCont)
                    {
                    }
                    column(Sno; "S.No.")
                    {
                    }
                    column(body; body)
                    {
                    }
                    column(Description2; Description + ' ' + "Description 2")
                    {
                    }
                    column(QtySIL; Quantity)
                    {
                    }
                    column(UOM; "Unit of Measure Code")
                    {
                    }
                    column(QtySqMtr; "Quantity in Sq. Mt.")
                    {
                    }
                    // 16225 column(MRP; "MRP Price") blank 
                    column(MRP; 0)
                    {
                    }
                    column(AssesableVal; AssesableVal)
                    {
                    }
                    column(DiscPerCart; DiscPerCart)
                    {
                    }
                    column(BuyersRatePerSqMtr; BuyersRatePerSqMtr)
                    {
                    }
                    column(Value; Value)
                    {
                    }
                    column(ExportPrice; "Unit Price Excl. VAT/Sq.Mt")
                    {
                    }
                    column(GrossWeight; "Gross Weight")
                    {
                    }
                    column(QD; QD)
                    {
                    }
                    column(QdText; QdText)
                    {
                    }
                    column(AqdText; AqdText)
                    {
                    }
                    column(AQD; AQD)
                    {
                    }
                    column(Disamt; ChargeDisAmt)
                    {
                    }
                    column(LineDisAmt; ("Line Discount Amount"))
                    {
                    }
                    column(GrossTotal; Value + (Discount) - ("Line Discount Amount") - AQD - QD)
                    {
                    }
                    column(Charge; Charge)
                    {
                    }
                    column(InsurnaceCharge; InsurnaceCharge)
                    {
                    }
                    //16225 column(AmtToCust; ROUND("Amount To Customer", 1, '='))
                    column(AmtToCust; ROUND(AmttoCustomerSalesLine("Sales Line"), 1, '='))
                    {
                    }
                    column(GLRoundingOFF; GLRoundingOFF)
                    {
                    }
                    column(FrightChargeAmt; FrightChargeAmt)
                    {
                    }
                    column(InsurenceChargeAmount; InsurenceChargeAmount)
                    {
                    }
                    column(ChargeDisAmt; ChargeDisAmt)
                    {
                    }
                    column(HideCol; HideCol)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                    //16225 StructureLineDetails: Record "13798";
                    begin
                        //dheeru
                        CRate := 0;
                        SRate := 0;
                        IRate := 0;
                        CAmount := 0;
                        SAmount := 0;
                        IAmount := 0;

                        TotalNoOfInvoiceLines := "Sales Line".COUNT();
                        //16225 field N/F Start
                        /* IF "Sales Line"."GST %" = 0.5 THEN
                             GST05 := 'abc'
                         ELSE
                             GST05 := '';*///16225 field N/F End

                        DetailedGSTLedgerEntry.RESET;
                        DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.");
                        DetailedGSTLedgerEntry.SETFILTER("Transaction Type", '%1', DetailedGSTLedgerEntry."Transaction Type"::Sales);
                        if "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Blanket Order" then
                            DetailedGSTLedgerEntry.SETRANGE("Document Type", DocumentType::"Blanket Order")
                        else
                            if "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Credit Memo" then
                                DetailedGSTLedgerEntry.SETRANGE("Document Type", DocumentType::"Credit Memo")
                            else
                                if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Invoice then
                                    DetailedGSTLedgerEntry.SETRANGE("Document Type", DocumentType::Invoice)
                                else
                                    if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Order then
                                        DetailedGSTLedgerEntry.SETRANGE("Document Type", DocumentType::Order)
                                    else
                                        if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Quote then
                                            DetailedGSTLedgerEntry.SETRANGE("Document Type", DocumentType::Quote)
                                        else
                                            if "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Return Order" then
                                                DetailedGSTLedgerEntry.SETRANGE("Document Type", DocumentType::"Return Order");
                        DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                        DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                        DetailedGSTLedgerEntry.SETRANGE("Line No.", "Line No.");
                        IF DetailedGSTLedgerEntry.FINDFIRST THEN
                            REPEAT
                                IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                    CRate := DetailedGSTLedgerEntry."GST %";
                                    CAmount := DetailedGSTLedgerEntry."GST Amount" * -1;
                                    CAmount1 += CAmount;
                                END;

                                IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                    SRate := DetailedGSTLedgerEntry."GST %";
                                    SAmount := DetailedGSTLedgerEntry."GST Amount" * -1;
                                    SAmount1 += SAmount
                                END;

                                IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                    IRate := DetailedGSTLedgerEntry."GST %";
                                    IAmount := DetailedGSTLedgerEntry."GST Amount" * -1;
                                    IAmount1 += IAmount;
                                END;

                                IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                    URate := DetailedGSTLedgerEntry."GST %";
                                    UAmount := DetailedGSTLedgerEntry."GST Amount" * -1;
                                    IAmount1 += IAmount;
                                END;

                            UNTIL
DetailedGSTLedgerEntry.NEXT = 0;
                        //MIPLRK210422>>>
                        /*
                        Sno +=1 ;
                        IF (Sno -1) MOD 41 = 0 THEN
                          PageBreak1 := (Sno -1)/41;
                        
                        PageCont := ROUND(COUNT/41,1,'<');
                        */

                        Sno += 1;
                        IF (Sno - 1) MOD 41 = 0 THEN
                            PageBreak1 := (Sno - 1) / 41;

                        PageCont := ROUND(COUNT / 41, 1, '<');

                        //<<<<MIPLRK210422
                        //16225 field N/F Start
                        /* State1.RESET;
                         State1.SETRANGE(State1.Code, "Sales Line".State);
                         IF State1.FIND('-') THEN
                             Stname := State1.Description;*///16225 field N/F End
                                                            //MIPLRK210422>>>
                                                            /*
                                                            IF (TotalNoOfInvoiceLines > 41) AND  (Sno < TotalNoOfInvoiceLines) THEN
                                                              HideCarriedForward := FALSE
                                                            ELSE
                                                              HideCarriedForward := TRUE;

                                                            IF "S.No."=41 THEN
                                                            CurrReport.NEWPAGE;
                                                            */


                        IF (TotalNoOfInvoiceLines > 41) AND (Sno < TotalNoOfInvoiceLines) THEN
                            HideCarriedForward := FALSE
                        ELSE
                            HideCarriedForward := TRUE;

                        IF "S.No." = 41 THEN
                            CurrReport.NEWPAGE;
                        //<<<<<MIPLRk210422

                        ItemPartNo[1] := GetPartNo("Sales Line");
                        "S.No." := "S.No." + 1;
                        //TotalLineAmount+=  "Sales Line".Amount;
                        TotalLineAmount += "Sales Line".Quantity * "Sales Line"."Unit Price";

                        IF Item.GET("No.") THEN BEGIN
                            DimensionValue.RESET;
                            DimensionValue.SETRANGE(Code, Item."Size Code");
                            IF DimensionValue.FINDFIRST THEN;
                        END;
                        IF "Tax Area Code" <> '' THEN BEGIN
                            StrLength := STRLEN("Tax Area Code") - 2;
                            StrText := COPYSTR("Tax Area Code", StrLength, 3);
                            IF StrText = 'CST' THEN
                                HeaderText := Text13702
                            //ELSE
                            //HeaderText :=Text13703;
                        END ELSE
                            HeaderText := Text13702;

                        Item.RESET;
                        Item.SETRANGE(Item."No.", "Sales Line"."No.");
                        IF Item.FIND('-') THEN
                            LotNo := Item."Lot Nos.";

                        SalesInvoiceLine1.RESET;
                        SalesInvoiceLine1.SETRANGE(SalesInvoiceLine1."Document No.", "Document No.");
                        SalesInvoiceLine1.SETRANGE(SalesInvoiceLine1.Type, SalesInvoiceLine1.Type::"G/L Account");
                        IF SalesInvoiceLine1.FIND('-') THEN BEGIN
                            REPEAT
                                Roundoff := SalesInvoiceLine1."Line Amount";
                            UNTIL SalesInvoiceLine1.NEXT = 0;
                        END;
                        IF (Type = Type::"G/L Account") THEN BEGIN
                        END;
                        //16225 table N/F Start
                        /*  StructureLineDetails.RESET;
                          StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
                          StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
                          StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
                          StructureLineDetails.SETRANGE("Item No.", "No.");
                          StructureLineDetails.SETRANGE("Line No.", "Line No.");
                          IF StructureLineDetails.FIND('-') THEN
                              REPEAT
                                  IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN
                                      IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                          ChargesAmount := ChargesAmount + ABS(StructureLineDetails.Amount);
                                      IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                          OtherTaxesAmount := OtherTaxesAmount + ABS(StructureLineDetails.Amount);
                                  END;
                              UNTIL StructureLineDetails.NEXT = 0;
                          InsuranceClm := 0;
                          OthClm := 0;
                          FrightChargeAmt := 0;
                          ChargeDisAmt := 0;
                          CLEAR(InsurenceChargeAmount);
                          PostedStrOrderLineDetails.RESET;
                          PostedStrOrderLineDetails.SETFILTER(Type, '%1', PostedStrOrderLineDetails.Type::Sale);
                          PostedStrOrderLineDetails.SETFILTER("Document Type", '%1', PostedStrOrderLineDetails."Document Type"::Order);
                          PostedStrOrderLineDetails.SETRANGE("Document No.", "Document No.");
                          PostedStrOrderLineDetails.SETRANGE("Item No.", "No.");
                          PostedStrOrderLineDetails.SETRANGE("Line No.", "Line No.");
                          IF PostedStrOrderLineDetails.FIND('-') THEN BEGIN
                              REPEAT
                                  IF NOT PostedStrOrderLineDetails."Payable to Third Party" THEN BEGIN
                                      IF PostedStrOrderLineDetails."Tax/Charge Type" = PostedStrOrderLineDetails."Tax/Charge Type"::Charges THEN BEGIN
                                          CASE PostedStrOrderLineDetails."Tax/Charge Group" OF
                                              'TCC':
                                                  BEGIN
                                                      TccChargeAmount := TccChargeAmount + PostedStrOrderLineDetails.Amount;
                                                      ChargePercentTCC := PostedStrOrderLineDetails."Calculation Value";
                                                  END;
                                              'BED':
                                                  BEGIN
                                                      BEDChargeAmount := BEDChargeAmount + PostedStrOrderLineDetails.Amount;
                                                      ChargePercentBED := PostedStrOrderLineDetails."Calculation Value";
                                                  END;
                                              'ECESS':
                                                  BEGIN
                                                      EcessChargeAmount := EcessChargeAmount + PostedStrOrderLineDetails.Amount;
                                                      ChargePercentEcess := PostedStrOrderLineDetails."Calculation Value";
                                                  END;
                                              'INSURANCE':
                                                  BEGIN
                                                      InsurenceChargeAmount := PostedStrOrderLineDetails.Amount;
                                                      ChargePercentIns := PostedStrOrderLineDetails."Calculation Value"
                                                  END;
                                              'FREIGHT':
                                                  BEGIN
                                                      FrightChargeAmt := PostedStrOrderLineDetails.Amount;
                                                  END;
                                              'HECESS':
                                                  BEGIN
                                                      Hecess := Hecess + PostedStrOrderLineDetails.Amount;
                                                      Hecesspercent := PostedStrOrderLineDetails."Calculation Value";
                                                  END;
                                              'BCHARG':
                                                  BEGIN
                                                      BaleCharges := BaleCharges + PostedStrOrderLineDetails.Amount;
                                                      //Hecesspercent:=PostedStrOrderLineDetails."Calculation Value";
                                                  END;
                                              'LCHARGE':
                                                  BEGIN
                                                      LabourCharges := LabourCharges + PostedStrOrderLineDetails.Amount;
                                                      //Hecesspercent:=PostedStrOrderLineDetails."Calculation Value";
                                                  END;
                                              'OTH_CLAIM':
                                                  BEGIN
                                                      OthClm := OthClm + PostedStrOrderLineDetails.Amount;
                                                  END;
                                              'INS_CLAIM':
                                                  BEGIN
                                                      InsuranceClm := InsuranceClm + PostedStrOrderLineDetails.Amount;
                                                  END;
                                              'DISCOUNT':
                                                  BEGIN
                                                      ChargeDisAmt := PostedStrOrderLineDetails.Amount;
                                                  END;
                                          END;
                                      END;
                                  END;
                              UNTIL PostedStrOrderLineDetails.NEXT = 0;
                          END;*///16225 table N/F End
                        SalesInvoiceLine1.RESET;
                        SalesInvoiceLine1.SETRANGE(SalesInvoiceLine1."Document No.", "Sales Line"."Document No.");
                        SalesInvoiceLine1.SETRANGE(SalesInvoiceLine1."Line No.", "Sales Line"."Line No.");
                        IF SalesInvoiceLine1.FIND('-') THEN BEGIN
                            //16225 table N/F Start
                            /*TotalBed := TotalBed +
                                ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  SalesInvoiceLine1."BED Amount", "Sales Header"."Currency Factor"),
                                  Currency."Unit-Amount Rounding Precision");

                            TotalEcess := TotalEcess +
                                  ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  SalesInvoiceLine1."eCess Amount", "Sales Header"."Currency Factor"),
                                  Currency."Unit-Amount Rounding Precision");

                            TotalShcess := TotalShcess +
                                     ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  SalesInvoiceLine1."SHE Cess Amount", "Sales Header"."Currency Factor"),
                                  Currency."Unit-Amount Rounding Precision");*///16225 table N/F End

                            TotalCashDic := TotalCashDic + SalesInvoiceLine1."Line Discount Amount";
                            TotalTradeDisc := TotalTradeDisc + SalesInvoiceLine1."Inv. Discount Amount";
                        END;
                        Amt := Amt + ROUND("Sales Line"."Line Amount", 1);

                        Location2.RESET;
                        Location2.SETRANGE(Location2.Code, "Sales Line"."Location Code");
                        IF Location2.FIND('-') THEN BEGIN
                            //Intdays:=FORMAT(Location2."Int. Days");
                            //IntRate:=Location2."Int. Rate";
                            //Complaindays:=FORMAT(Location2."Complain Days");
                            //Juridiction:=Location2.Juridiction;
                            //InvoiceNotification:=Location2."Invoice Notification";
                            //Insurance:=Location2."Insurance Policy No.";
                        END;

                        SalesInvoiceHeader2.RESET;
                        SalesInvoiceHeader2.SETRANGE(SalesInvoiceHeader2."No.", "Sales Line"."Document No.");
                        IF SalesInvoiceHeader2.FIND('-') THEN BEGIN
                            BEGIN
                                DueDate := SalesInvoiceHeader2."Due Date";
                            END;
                            PaymentTerms.RESET;
                            PaymentTerms.SETRANGE(PaymentTerms.Code, SalesInvoiceHeader2."Payment Terms Code");
                            IF PaymentTerms.FIND('-') THEN BEGIN
                                PaymentTerm := PaymentTerms.Description;
                            END;
                            ShipmentMethod.RESET;
                            ShipmentMethod.SETRANGE(ShipmentMethod.Code, SalesInvoiceHeader2."Shipment Method Code");
                            IF ShipmentMethod.FIND('-') THEN BEGIN
                                ShipmentDes := ShipmentMethod.Description;
                            END;
                            SalesPurchPerson.RESET;
                            SalesPurchPerson.SETRANGE(SalesPurchPerson.Code, SalesInvoiceHeader2."Salesperson Code");
                            IF SalesPurchPerson.FIND('-') THEN BEGIN
                                AgentName := SalesPurchPerson.Name
                            END;

                        END;

                        //MSSS
                        //16225 Table N/F start
                        /*  ExcisePostingSetup.SETRANGE("Excise Bus. Posting Group", "Excise Bus. Posting Group");
                          ExcisePostingSetup.SETRANGE("Excise Prod. Posting Group", "Excise Prod. Posting Group");
                          IF ("Posting Date" <> 0D) THEN
                              ExcisePostingSetup.SETRANGE("From Date", 0D, "Posting Date")
                          ELSE
                              ExcisePostingSetup.SETRANGE("From Date", 0D, WORKDATE);
                          IF ExcisePostingSetup.FIND('+') THEN BEGIN
                              "BED%" := ExcisePostingSetup."BED %";
                              "eCess%" := ExcisePostingSetup."eCess %";
                              "SHECess%" := ExcisePostingSetup."SHE Cess %";
                          END;*///16225 Table N/F End


                        Value := 0;
                        Cart := 0;
                        SqMt := 0;
                        Wt := 0;
                        LineDiscount := 0;
                        DiscPerCart := 0;
                        RateperCart := 0;
                        //IF SalesInvLine1."Unit of Measure Code" = 'CRT' THEN
                        //BEGIN
                        Cart := ROUND(Item.UomToCart("No.", "Unit of Measure Code", Quantity), 1, '<');
                        SqMt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                        //Wt := Item.UomToWeight("No.","Unit of Measure Code",Quantity);
                        Wt := "Sales Line"."Gross Weight";
                        //END
                        //ELSE IF SalesInvLine1."Unit of Measure" = 'CRT' THEN
                        //BEGIN
                        Pcs := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<'); //-- 3. Tri30.0 PG 14111406
                                                                                                      //END;
                                                                                                      //MSAK.BEGIN

                        IF Cart <> 0 THEN
                            RateperCart := "Unit Price" * Quantity / Cart;

                        IF SqMt <> 0 THEN
                            DiscPerCart := "Line Discount Amount" / SqMt;

                        LineDiscount := "Line Discount Amount";
                        //Value :="Quantity in Cartons"*(RateperCart-DiscPerCart) - LineDiscount;
                        //Value :=Amount;
                        //MSAK.END
                        //MSAK.BEGIN
                        //16225 Field N/F Start
                        /*  IF Quantity <> 0 THEN
                              BuyersPrice := (Amount + "Excise Amount") / Quantity;*///16225 Field N/F End

                        IF "Quantity in Sq. Mt." <> 0 THEN BEGIN
                            DecRate := ("Quantity Discount Amount" / "Quantity in Sq. Mt.");
                            LineDis := ("Line Discount Amount" / "Quantity in Sq. Mt.");
                        END;

                        CLEAR(BuyersRatePerSqMtr);
                        IF SqMt <> 0 THEN BEGIN
                            //BuyersRatePerSqMtr := (BuyersPrice * Quantity / SqMt)+DecRate+LineDis;  //Rk170222
                            BuyersRatePerSqMtr := ROUND(((BuyersPrice * Quantity / SqMt) + DecRate + LineDis), 0.01, '>');  //Rk170222
                            DiscPerSqmt := "Line Discount Amount" / SqMt;
                        END;
                        //=Code.RupeesToWord(ReportItems!Textbox149.Value)

                        Value := ROUND(((BuyersRatePerSqMtr - DiscPerCart) * "Quantity in Sq. Mt."), 0.01, '>');
                        //16225 Field N/F Start
                        /* IF Quantity <> 0 THEN BEGIN
                             BEDAmt := BEDAmt + "BED Amount";
                             Hecess := Hecess + "SHE Cess Amount";
                             ECess := ECess + "eCess Amount"
                         END;*///16225 Field N/F End

                        Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                        SqMt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                        Pcsqty := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<');
                        Wt := "Sales Line"."Gross Weight";

                        Discount := 0;
                        //16225 Table N/F Start
                        /*   PostedStrOrderLDetails.RESET;
                           PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                           PostedStrOrderLDetails.SETRANGE("Invoice No.", "Sales Line"."Document No.");
                           PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
                           IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                               REPEAT
                                   Discount += PostedStrOrderLDetails.Amount;
                               UNTIL PostedStrOrderLDetails.NEXT = 0;
                           END;*///16225 Table N/F End

                        InsurnaceCharge := 0;
                        //16225 Table N/F Start
                        /*   PostedStrOrderLDetails.RESET;
                           PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                           PostedStrOrderLDetails.SETRANGE("Invoice No.", "Sales Line"."Document No.");
                           PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'INSURANCE');
                           IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                               REPEAT
                                   InsurnaceCharge += PostedStrOrderLDetails.Amount;
                               UNTIL PostedStrOrderLDetails.NEXT = 0;

                           END;*///16225 Table N/F End

                        LineStop := LineStop + 1;

                        QD := "Quantity Discount Amount" - "Accrued Discount";
                        IF QD <> 0 THEN
                            QdText := 'QD DISCOUNT';
                        AQD := "Accrued Discount";
                        IF AQD <> 0 THEN
                            AqdText := 'AQD DISCOUNT';

                        //16225   AssesableVal := "Sales Line"."Assessable Value" * "Sales Line".Quantity;
                        AssesableVal := "Sales Line"."GST Assessable Value (LCY)" * "Sales Line".Quantity;
                        //16225  IF ExciseProdPostingGroup.GET("Sales Line"."Excise Prod. Posting Group") THEN;
                        IF "Sales Line"."Line Discount Amount" <> 0 THEN
                            IF "Sales Line"."Quantity in Cartons" <> 0 THEN
                                Disamt := "Sales Line"."Line Discount Amount" / "Sales Line"."Quantity in Cartons";
                        IF ("Type Catogery Code" = '54') OR ("Type Catogery Code" = '60') OR ("Type Catogery Code" = '61')
                           OR ("Type Catogery Code" = '62') OR ("Type Catogery Code" = '70') OR ("Type Catogery Code" = '71')
                           OR ("Type Catogery Code" = '46') THEN
                            body := 'Vitreous';

                        rowCount := "Sales Line".COUNT;

                        IF CustRec."Customer Type" = 'DEALER' THEN
                            HideCol := FALSE
                        ELSE
                            HideCol := TRUE;

                    end;

                    trigger OnPreDataItem()
                    begin
                        "S.No." := 0;
                        CLEAR(Sno);
                        Sno := 0;
                        CLEAR(PageCont);
                    end;
                }
                dataitem(RowIns; Integer)
                {
                    column(IncRowas; IncRowas)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IncRowas += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, 25 - rowCount);//,rowstogen+3);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    OuputNos += 1;
                    IF OuputNos = 1 THEN
                        copyText1 := 'Original For Buyer';
                    IF OuputNos = 2 THEN
                        copyText1 := 'Duplicate For Transporter';
                    IF OuputNos = 3 THEN
                        copyText1 := 'Triplicate For Assessee';
                end;

                trigger OnPostDataItem()
                begin
                    //Rk160222
                    /*
                    IF NOT CurrReport.PREVIEW THEN
                      SalesInvCountPrinted.RUN(SalesInvoiceHeader);
                      */

                end;

                trigger OnPreDataItem()
                begin

                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    copyText1 := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    LineStop := 0;
                    OuputNos := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CompanyInformation: Record "Company Information";
                amttocustomer: Decimal;
                DynamicsPAYID: Text;
            begin
                OthClm := 0;
                InsuranceClm := 0;
                CLEAR(ExportInv);
                CLEAR(AddCharge);
                CLEAR(Vircode);
                CLEAR(PriceExp);
                CLEAR(PriceExp2);
                SalesInvoiceHeader.COPY("Sales Header");
                //Billing ADDR
                CustRec.RESET;
                CustRec.SETRANGE("No.", "Sell-to Customer No.");
                IF CustRec.FINDFIRST THEN
                    IF (CustRec."Country/Region Code" = '01') THEN
                        ExportInv := FALSE
                    ELSE
                        ExportInv := TRUE;
                IF CustRec."Country/Region Code" <> '01' THEN
                    AddCharge := TRUE
                ELSE
                    AddCharge := FALSE;
                IF CustRec."Country/Region Code" = '01' THEN
                    Vircode := FALSE
                ELSE
                    Vircode := TRUE;
                IF CustRec."Country/Region Code" <> '01' THEN
                    PriceExp := FALSE
                ELSE
                    PriceExp := TRUE;
                IF (CustRec."Country/Region Code" = '01') AND ("Sales Header"."Customer Type" <> 'GET') AND ("Sales Header"."Customer Type" <> 'PROJECT') AND ("Sales Header"."Customer Type" <> 'SET') AND ("Sales Header"."Customer Type" <> 'PET') THEN
                    PriceExp2 := FALSE
                ELSE
                    PriceExp2 := TRUE;
                BEGIN
                    //MESSAGE('Cust No. = %1 and Inv type = %2',"Sales Header"."Sell-to Customer No.",ExportInv);
                    BillToAdd[1] := CustRec.Name;
                    BillToAdd[2] := CustRec.Address;
                    BillToAdd[3] := CustRec."Address 2";
                    BillToAdd[4] := CustRec.City;
                    BillToAdd[5] := CustRec."Pin Code";
                    //  BillToAdd[5] := CustRec."Post Code";
                    BillToAdd[6] := CustRec."State Code";
                    BillToAdd[7] := CustRec."GST Registration No.";
                    BillToAdd[8] := CustRec."P.A.N. No.";
                    BillToAdd[11] := CustRec."Virtual ID";

                    RecState.RESET;
                    IF RecState.GET(CustRec."State Code") THEN
                        BillToAdd[10] := RecState."State Code (GST Reg. No.)";
                    BillToAdd[9] := RecState.Description;
                END;

                CLEAR(BankDetail);
                BankInfo.RESET;
                BankInfo.SETRANGE("No.", "Sales Header"."Approved By");
                IF BankInfo.FINDFIRST THEN BEGIN
                    BankDetail[1] := BankInfo.Name;
                    BankDetail[2] := BankInfo.City;
                    BankDetail[3] := BankInfo."Bank Account No.";
                    BankDetail[4] := BankInfo."RTGS/NEFT/IFSC Code";
                    BankDetail[5] := BankInfo."SWIFT Code";
                    BankDetail[6] := BankInfo.Address;
                    BankDetail[7] := BankInfo."Address 2";
                END;

                //Shipping ADDR
                IF "Ship-to Code" <> '' THEN BEGIN
                    RecShipToAdd.RESET;
                    RecShipToAdd.SETRANGE(RecShipToAdd.Code, "Ship-to Code");
                    IF RecShipToAdd.FINDFIRST THEN BEGIN
                        //ShipToAdd[1] :=RecShipToAdd.Name;
                        ShipToAdd[1] := SaleInvHeader."Ship-to Name";
                        ShipToAdd[2] := RecShipToAdd.Address;
                        ShipToAdd[3] := RecShipToAdd."Address 2";
                        ShipToAdd[4] := RecShipToAdd.City;
                        ShipToAdd[5] := "Sales Header"."Ship to Pin";

                        //ShipToAdd[5] :=RecShipToAdd."Post Code";
                        ShipToAdd[6] := RecShipToAdd.State;
                        ShipToAdd[7] := RecShipToAdd."GST Registration No.";
                        ShipToAdd[8] := SaleInvHeader."Ship-to Name 2";

                        /*RecState.RESET;
                        IF RecState.GET(RecShipToAdd.State) THEN
                         ShipToAdd[10] := RecState."State Code (GST Reg. No.)";
                         ShipToAdd[9]  :=RecState.Description;

                      END;*/

                        RecState.RESET;
                        IF State_Rec.GET("GST Ship-to State Code") THEN
                            ShipToAdd[9] := State_Rec.Description;
                    END;
                END ELSE BEGIN
                    ShipToAdd[1] := CustRec.Name;
                    ShipToAdd[2] := CustRec.Address;
                    ShipToAdd[3] := CustRec."Address 2";
                    ShipToAdd[4] := CustRec.City;
                    ShipToAdd[5] := "Sales Header"."Ship to Pin";
                    //ShipToAdd[5] :=Cust."Post Code";
                    ShipToAdd[6] := CustRec."State Code";
                    ShipToAdd[7] := Cust."GST Registration No.";
                    ShipToAdd[8] := SaleInvHeader."Ship-to Name 2";

                    /*  RecState.RESET;
                      IF RecState.GET(CustRec."State Code") THEN
                       ShipToAdd[10] := RecState."State Code (GST Reg. No.)";
                      ShipToAdd[9]  :=RecState.Description;
                  END;*/

                    RecState.RESET;
                    IF State_Rec.GET("GST Ship-to State Code") THEN
                        ShipToAdd[9] := State_Rec.Description;
                END;
                RecState.RESET;
                IF RecState.Code = '' THEN
                    RecState.Code := CustRec."Customer Price Group";

                RecState.SETRANGE(Code, State);
                IF RecState.FINDFIRST THEN
                    REPEAT
                        StateCode := RecState."State Code (GST Reg. No.)";
                        StateName := RecState.Description;
                    UNTIL
RecState.NEXT = 0;


                IF "Currency Code" <> '' THEN
                    CurCaption := "Currency Code" + ' and Zero Paisa Only'
                ELSE
                    CurCaption := 'Rupees and Zero Paisa Only';
                //16225 field N/F satrt
                /* State1.RESET;
                 State1.SETRANGE(State1.Code, "Sales Line".State);
                 IF State1.FIND('-') THEN
                     Stname := State1.Description;*///16225 field N/F End

                j := 0;
                SalesInvLine5.RESET;
                SalesInvLine5.SETFILTER(SalesInvLine5."Document No.", '%1', "Sales Header"."No.");
                SalesInvLine5.SETFILTER(SalesInvLine5."Tax Liable", '%1', TRUE);
                IF SalesInvLine5.FIND('-') THEN BEGIN
                    TaxAreaLine.RESET;
                    TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', SalesInvLine5."Tax Area Code");
                    IF TaxAreaLine.FIND('-') THEN
                        REPEAT
                            j := j + 1;
                            TaxDetails.RESET;
                            TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                            TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', SalesInvLine5."Tax Group Code");
                            //16225  TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Header"."Form Code");
                            TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Header"."Posting Date");
                            IF TaxDetails.FIND('+') THEN
                                IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                    JudText[j] := TaxDetails."Tax Jurisdiction Code";
                                    PerJud[j] := TaxDetails."Tax Below Maximum";
                                END;
                        UNTIL TaxAreaLine.NEXT = 0;
                END;
                /*Rk160222
                //-----MS-PB BEGIN---------
                Location2.RESET;
                Location2.SETRANGE(Code,"Location Code");
                IF Location2.FINDFIRST THEN BEGIN
                  SaleInvHeader.RESET;
                  SaleInvHeader.SETRANGE("No.","No.");
                  IF SaleInvHeader.FINDFIRST THEN
                    HeaderTextLatest:=DocumentPrint.PrintInvoiceType(SaleInvHeader,Location2);
                END;
                //-----MS-PB END-----------
                */
                Location.RESET;
                IF Location.GET("Location Code") THEN;
                State_Rec.RESET;
                IF State_Rec.GET(Location."State Code") THEN;

                QD := 0;
                AQD := 0;
                QdText := '';
                AqdText := '';

                salesinvi7.RESET;
                salesinvi7.SETRANGE("Document No.", "Sales Header"."No.");
                salesinvi7.SETRANGE(Type, salesinvi7.Type::Item);
                IF salesinvi7.FIND('-') THEN
                    co := salesinvi7.COUNT;
                //16225 Table Field N/F Start
                /*  IF "Sales Header"."Form Code" <> '' THEN
                      FormText := 'Against' + ' ' + FORMAT("Sales Header"."Form Code")
                  ELSE
                      FormText := '';*///16225 Table Field N/F End

                IF Recvendor.GET("Sales Header"."Transporter's Name") THEN
                    Respcent.RESET;
                IF Respcent.GET("Sales Header"."Responsibility Center") THEN
                    RespCntrAddr[1] := Respcent.Address;
                RespCntrAddr[2] := Respcent."Address 2";

                COMPRESSARRAY(RespCntrAddr);
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");  //Rk160222
                                                                           //16225   FormatAddr.SalesHeaderShipTo(ShipToAddr, "Sales Header");  //Rk160222
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");  //Rk160222
                                                                                     //Rk160222FormatAddr.SalesInvBillTo(BillToAddr,"Sales Header");
                                                                                     //Rk160222FormatAddr.SalesInvShipTo(ShipToAddr,"Sales Header");
                                                                                     //16225 funcation N/F   CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                //   PostedDocDim1.SETRANGE("Table ID", DATABASE::"Sales Header");
                //   PostedDocDim1.SETRANGE("Document No.", "Sales Header"."No.");

                IF "Sales Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Sales Order No.");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.GET();
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, "Currency Code");
                END;
                //Rk160222FormatAddr.SalesInvBillTo(CustAddr,"Sales Header");
                IF NOT Cust.GET("Bill-to Customer No.") THEN
                    CLEAR(Cust);
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF RecPaymentTerms.GET("Sales Header"."Payment Terms Code") THEN;

                //Rk160222FormatAddr.SalesInvShipTo(ShipToAddr,"Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;
                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;
                Cust1.RESET;
                Cust1.SETRANGE(Cust1."No.", "Bill-to Customer No.");
                IF Cust1.FINDFIRST THEN BEGIN
                    //16225   "Cust LST" := Cust1."L.S.T. No.";
                    //16225    "Cust CST" := Cust1."C.S.T. No.";
                    //16225   "Cust TIN" := Cust1."T.I.N. No.";
                    custState.RESET;
                    IF custState.GET(Cust1."State Code") THEN;
                END;
                Cust1.CALCFIELDS(Balance);
                Outstand := ROUND((Cust1.Balance), 1, '=');
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue.Code, "Sales Header"."Shortcut Dimension 2 Code");
                IF DimensionValue.FIND('-') THEN BEGIN
                    Unit := DimensionValue.Name
                END;
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", "Sales Header"."Bill-to Customer No.");
                IF Customer.FIND('-') THEN BEGIN
                    //16225    CustECCNo := Customer."E.C.C. No.";
                    //16225    CustRange := Customer.Range;
                    //16225    CustCommissionerate := Customer.Collectorate;
                    CustPANNo := Customer."P.A.N. No.";
                END;
                //GrandTotal:=0;
                SIL.RESET;
                SIL.SETCURRENTKEY("Document No.", "Line No.");
                SIL.SETRANGE(SIL."Document No.", "No.");
                IF SIL.FIND('-') THEN BEGIN
                    REPEAT
                        Clear(sgst);
                        Clear(igst);
                        Clear(cgst);
                        Clear(TotalAmt);
                        ReccSalesLine.Reset();
                        ReccSalesLine.SetRange("Document Type", SIL."Document Type");
                        ReccSalesLine.SetRange("Document No.", SIL."Document No.");
                        if ReccSalesLine.FindSet() then
                            repeat
                                TotalAmt += ReccSalesLine."Line Amount";
                                GSTSetup.Get();
                                if GSTSetup."GST Tax Type" = GSTLbl then
                                    if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                                        ComponentName := IGSTLbl
                                    else
                                        ComponentName := CGSTLbl
                                else
                                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                                        ComponentName := CESSLbl;

                                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                                    TaxTransactionValue.Reset();
                                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                                    if TaxTransactionValue.FindSet() then
                                        repeat
                                            case TaxTransactionValue."Value ID" of
                                                6:
                                                    begin
                                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                        GSTper3 := TaxTransactionValue.Percent;
                                                    end;
                                                2:
                                                    begin
                                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                        GSTper2 := TaxTransactionValue.Percent;
                                                    end;
                                                3:
                                                    begin
                                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                        GSTper1 := TaxTransactionValue.Percent;
                                                    end;
                                            end;
                                        until TaxTransactionValue.Next() = 0;
                                    cgstTOTAL += cgst;
                                    sgstTOTAL += sgst;
                                    igstTotal += igst;
                                end;
                            until ReccSalesLine.Next() = 0;
                        //15578 text

                        //16225   TraiffNo := SIL."Excise Prod. Posting Group";
                        GrandTotal += TotalAmt + sgst + cgst + igst;
                        IF SIL."No." = '51157000' THEN
                            GLRoundingOFF += TotalAmt + sgst + cgst + igst;
                    UNTIL SIL.NEXT = 0;
                END;
                check.InitTextVariable;
                check.FormatNoText(NetInWord, ROUND(GrandTotal), "Sales Header"."Currency Code");

                Exessiblegoods := 0;
                salesinvoiceline.SETRANGE("Document No.", "No.");
                IF salesinvoiceline.FIND('-') THEN BEGIN
                    REPEAT
                        Exessiblegoods := Exessiblegoods + salesinvoiceline.Amount;
                    UNTIL salesinvoiceline.NEXT = 0;
                END;
                CLE.RESET;
                CLE.SETRANGE(CLE."Document No.", "Sales Header"."No.");
                IF CLE.FINDFIRST THEN;
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", "Sales Header"."Bill-to Customer No.");
                IF Cust.FINDFIRST THEN
                    VendorCode := Cust."Customer Type";
                /*Rk180422>>
                IF "Sales Header".State = '19' THEN BEGIN
                    invoicename := 'Tax Invoice - Export'
                   END ELSE
                    invoicename := 'Tax Invoice';
                */
                invoicename := 'PROFORMA INVOICE';
                //Rk180422<<<
                IF "Sales Header".State = '19' THEN BEGIN
                    pos := 'Country of Desti.:'
                END ELSE
                    pos := 'Place of Supply:';

                IF ("Sales Header".State = '19') AND ("Sales Header"."Location Code" = 'SKD-SAMPLE') THEN
                    REM := Text3705;

                IF ("Sales Header".State = '19') AND ("Sales Header"."Location Code" = 'SKD-WH-MFG') THEN
                    REM := Text3705;


                IF ("Sales Header".State = '19') AND ("Sales Header"."Location Code" = 'DRA-WH-MFG') THEN
                    REM := Text3706;

                IF ("Sales Header".State = '19') AND ("Sales Header"."Location Code" = 'DP-MORBI') THEN
                    REM := Text3706;

            end;

            trigger OnPreDataItem()
            begin
                HideCol := FALSE;
                GrandTotal := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("No of Copies"; NoOfCopies)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Tolerance; Tolerance)
                {
                    ApplicationArea = All;
                }
                field("Port of Loading"; PostofLoading)
                {
                    ApplicationArea = All;
                }
                field("Port of Discharge"; PostofDischarge)
                {
                    ApplicationArea = All;
                }
                field(Origin; Origin)
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        State_Rec: Record State;
        DocumentType: Enum "Document Type Enum";
        rowCount: Integer;
        copyText1: Text[50];
        NetInWord: array[3] of Text[200];
        check: Report "Check Report";
        GLRoundingOFF: Decimal;
        RecShipToAdd: Record "Ship-to Address";
        ShipToAdd: array[20] of Text;
        BillToAdd: array[20] of Text;
        CustRec: Record Customer;
        custState: Record State;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        RecPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        //  PostedDocDim1: Record 359;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        SalesInvCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        OrderNoText: Text[100];
        SalesPersonText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[100];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        //16225 PostedStrOrderLineDetails: Record "13795";
        "Corp-Addition------------": Integer;
        TccChargeAmount: Decimal;
        ChargePercentTCC: Decimal;
        BEDChargeAmount: Decimal;
        ChargePercentBED: Decimal;
        EcessChargeAmount: Decimal;
        ChargePercentEcess: Decimal;
        InsurenceChargeAmount: Decimal;
        ChargePercentIns: Decimal;
        CSTchargeAmount: Decimal;
        ChargePercentCST: Decimal;
        FrightChargeAmt: Decimal;
        SalesHeader: Record "Sales Header";
        BillToAddr: array[8] of Text[80];
        TempSalesLine: Record "Sales Line" temporary;
        AgentName: Text[40];
        SalesPersonRec: Record "Salesperson/Purchaser";
        CheckReport: Report "Check Report";
        NumberText: array[2] of Text[80];
        NumberText1: array[2] of Text[80];
        NumberText2: array[2] of Text[80];
        NumberText3: array[2] of Text[80];
        NumberText5: array[2] of Text[80];
        NumberText4: array[2] of Text[80];
        GenJnlLine: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        Amt: Decimal;
        GTotal: Decimal;
        StateTable: Record state;
        StateDescription: Text[50];
        Location: Record Location;
        LocName: Text[50];
        LocAddress: Text[50];
        LocAddress2: Text[50];
        LocCity: Text[50];
        LocPhone: Text[30];
        "LocE-mail": Text[80];
        LocRst: Code[30];
        LocCst: Code[30];
        LocTin: Code[20];
        LocState: Text[30];
        "Cust TIN": Code[20];
        "Cust LST": Code[20];
        "Cust CST": Code[20];
        CompInfo: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        Unit: Text[30];
        Hecess: Decimal;
        Hecesspercent: Decimal;
        Excisetotal: Decimal;
        Disctotal: Decimal;
        Item: Record Item;
        LotNo: Code[20];
        Bagtotal: Integer;
        salesinvoiceline: Record "Sales Line";
        Kgtotal: Decimal;
        Locpin: Code[10];
        ShippingAgent: Record "Shipping Agent";
        Shipingdes: Text[50];
        Cust1: Record Customer;
        challanno: Code[20];
        Salesshipment: Record "Sales Shipment Header";
        SalesInvoiceLine1: Record "Sales Line";
        TotalBed: Decimal;
        TotalEcess: Decimal;
        TotalShcess: Decimal;
        TotalTradeDisc: Decimal;
        TotalCashDic: Decimal;
        "AddCst/Vat": Option " ",VAT,CST;
        TaxArea: Record "Tax Area";
        TaxLineArea: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        Location2: Record Location;
        IntRate: Decimal;
        Intdays: Text[50];
        Complaindays: Text[30];
        Juridiction: Text[30];
        InvoiceNotification: Text[200];
        Insurance: Text[100];
        SalesInvoiceHeader2: Record "Sales Header";
        PaymentTerm: Text[50];
        ShipmentDes: Text[50];
        DueDate: Date;
        VatChargeAmount: Decimal;
        SalesInvoiceLine3: Record "Sales Line";
        A: Code[10];
        VatPercentAmount: Decimal;
        InvoiceDicount: Decimal;
        Customer: Record Customer;
        CustECCNo: Code[20];
        CustRange: Code[200];
        CustCommissionerate: Code[200];
        CustPANNo: Code[20];
        "InvoiceDisc%": Text[30];
        "Insurance%": Text[30];
        "Cust.InvoiceDisc.": Record "Cust. Invoice Disc.";
        "TradeDic%": Text[30];
        TradePercente: Decimal;
        SalesInvoiceHeader4: Record "Sales Header";
        ShiptoAddress: Record "Ship-to Address";
        ShipEccNo: Code[20];
        ShipregNo: Code[20];
        ShipRange: Code[20];
        ShipCommissionerate: Code[20];
        ShipPanNo: Code[20];
        Customer1: Record Customer;
        BaleCharges: Decimal;
        LabourCharges: Decimal;
        OtherCharges: Decimal;
        "S.No.": Integer;
        TotalLineAmount: Decimal;
        CopyNo: Integer;
        PageTitle: Text[30];
        //16225 ExcisePostingSetup: Record 13711;
        "BED%": Decimal;
        "eCess%": Decimal;
        "SHECess%": Decimal;
        SIL: Record "Sales Line";
        TraiffNo: Code[20];
        SalesOrderNo: Code[20];
        AmountinWord: array[2] of Text[100];
        GrandTotal: Decimal;
        Respcent: Record "Responsibility Center";
        RespCntrAddr: array[15] of Text[250];
        NoInText: array[10] of Text[250];
        ExInText: array[10] of Text[50];
        //16225  ExcisePGP: Record 13710;
        BarCodeRequired: Boolean;
        SIH: Record "Sales Header";
        txt: Text[100];
        Range: Text[100];
        Division: Text[100];
        LineStop: Integer;
        Exessiblegoods: Decimal;
        //16225"Excise Prod.Posting Group": Record 13710;
        Desc: Text[60];
        NOOFPKG: Decimal;
        //16225 ExciseProdPostingGroup: Record "13710";
        QTYPERPKG: Decimal;
        CLE: Record "Cust. Ledger Entry";
        VendorCode: Code[20];
        SINC: Record "Sales Line";
        Type1: Code[20];
        ItemPartNo: array[600] of Code[20];
        MSFNo: Code[20];
        SIHeader: Record "Sales Header";
        Roundoff: Decimal;
        Value: Decimal;
        Cart: Decimal;
        SqMt: Decimal;
        Wt: Decimal;
        LineDiscount: Decimal;
        DiscPerCart: Decimal;
        RateperCart: Decimal;
        Pcs: Decimal;
        BEDAmt: Decimal;
        ECess: Decimal;
        Pcsqty: Decimal;
        BuyersPrice: Decimal;
        BuyersRatePerSqMtr: Decimal;
        DiscPerSqmt: Decimal;
        Outstand: Decimal;
        QD: Decimal;
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        AQD: Decimal;
        AmountinWord1: array[2] of Text[100];
        Recvendor: Record Vendor;
        DeleveryAdd: array[4] of Text[30];
        TextContinue: Text[30];
        AqdText: Text[30];
        QdText: Text[30];
        StrLength: Integer;
        StrText: Text[30];
        HeaderText: Text[30];
        Charge: Decimal;
        Charge1: Decimal;
        AssesableVal: Decimal;
        Disamt: Decimal;
        SalesInvLine5: Record "Sales Line";
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        j: Integer;
        JudText: array[4] of Code[50];
        PerJud: array[3] of Decimal;
        salesinvi7: Record "Sales Line";
        co: Integer;
        State1: Record State;
        Stname: Text[50];
        //16225 PostedStrOrderLDetails: Record "13798";
        Discount: Decimal;
        InsurnaceCharge: Decimal;
        //16225 DetailedTaxEntry: Record 16522;
        VATAmount: Decimal;
        AddVATAmount: Decimal;
        FormText: Text[30];
        Text13705: Text[100];
        DecRate: Decimal;
        LineDis: Decimal;
        DocumentPrint: Codeunit "Document-Print";
        HeaderTextLatest: Text[100];
        SaleInvHeader: Record "Sales Header";
        body: Text[10];
        policy: Text[200];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        Text13702: Label 'SALES INVOICE';
        Text13703: Label 'TAX INVOICE';
        Text13706: Label 'Assesable Value is calculated @ 55% of MRP';
        //16225 Text13707: ;
        Text13704: Label '"Goods insured under policy 111200/21/13/02/00000012 w.e.f. 01/07/13 with United India Ins.Co.Ltd. and upto 30/06/13 under policy 354900/21/ 12/4200000153 with National Insurance Co."';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        CurCaption: Text[30];
        OuputNos: Integer;
        Sno: Integer;
        rowstogen: Integer;
        PageBreak1: Integer;
        IncRowas: Integer;
        PageCont: Integer;
        StateCode: Code[50];
        StateName: Text[50];
        RecState: Record State;
        DetailedGSTLedgerEntry: Record "Detailed GST Entry Buffer";
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        URate: Decimal;
        UAmount: Decimal;
        TotalGSTAmt: Decimal;
        GSTTotal: Decimal;
        CAmount1: Decimal;
        SAmount1: Decimal;
        IAmount1: Decimal;
        TotalGSTAmount: Decimal;
        OtherTaxes: Decimal;
        shipstate: Text[30];
        invoicename: Text[50];
        pos: Text[18];
        Text3705: Label 'Supply Meant For Export Under Bond Or Letter Of Undertaking Without Payment Of Integrated Tax | Application No. ARN AA090418042693Y dt. 12/04/2018.';
        Text3706: Label 'Supply Meant For Export Under Bond Or Letter Of Undertaking Without Payment Of Integrated Tax | Application No. ARN no AA240418016494A Dt.07.04.2018'''' ';
        REM: Text[170];
        OthClm: Decimal;
        InsuranceClm: Decimal;
        "--MSVRN--": Integer;
        HideCol: Boolean;
        SalesInvoiceHeader: Record "Sales Header";
        //16225 kbs: ;
        GST05: Text;
        TotalCopies: Integer;
        APIManagement: Codeunit "API Management -EY 2.6";
        //TempBlob: Record "Upgrade Blob Storage" temporary;
        PaymentText: Text;
        CarriedForLbl: Label 'Carried Forward :';
        BroughtForLbl: Label 'Brought Forward :';
        TotalNoOfInvoiceLines: Integer;
        HideCarriedForward: Boolean;
        ExportInv: Boolean;
        BankInfo: Record "Bank Account";
        BankDetail: array[8] of Text;
        Tolerance: Text;
        PostofLoading: Text;
        PostofDischarge: Text;
        Origin: Text;
        ARNNo: Label 'AA090418042693Y';
        ChargeDisAmt: Decimal;
        Vircode: Boolean;
        AddCharge: Boolean;
        PriceExp: Boolean;
        PriceExp2: Boolean;
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;



    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;


    procedure GetPartNo(SalesLine: Record "Sales Line"): Code[20]
    var
        Item: Record Item;
    // ItemCrossRef: Record "Item Cross Reference";
    begin
        /*  IF Item.GET("Sales Line"."No.") THEN BEGIN
             ItemCrossRef.RESET();
             ItemCrossRef.SETRANGE("Item No.", Item."No.");
             ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Customer);
             ItemCrossRef.SETRANGE("Cross-Reference Type No.", SalesLine."Sell-to Customer No.");
             ItemCrossRef.SETFILTER("Cross-Reference No.", '<>%1', '');
             IF ItemCrossRef.FINDFIRST THEN BEGIN
                 EXIT(ItemCrossRef."Cross-Reference No.");
             END;
         END; */
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    procedure AmttoCustomerSalesLine(T37: Record 37): Decimal
    var
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        TotalAmt: Decimal;
        GSTSetup: Record "GST Setup";
        ComponentName: Text;
        TaxTransactionValue: Record "Tax Transaction Value";
        sgstTOTAL: Decimal;
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        GSTSetup.Get();
        TDSSetup.Get();
        Clear(igst);
        Clear(sgst);
        Clear(cgst);
        Clear(TotalAmt);
        Clear(TDSAmt);

        TotalAmt := T37."Line Amount";
        if T37.Type <> T37.Type::" " then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat

                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                ComponentName := 'SGST';
                                sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper3 := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                ComponentName := 'CGST';
                                cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper2 := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                ComponentName := 'IGST';
                                igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper1 := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
            cgstTOTAL += cgst;
            sgstTOTAL += sgst;
            igstTotal += igst;

            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TDSAmt += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;

        exit((TotalAmt + igst + sgst + cgst) - TDSAmt);
    end;

}

