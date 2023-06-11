report 50389 "GST RCM Self Invoice"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\GSTRCMSelfInvoice.rdl';
    PreviewMode = Normal;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(TransporterName; "Purch. Inv. Header"."Transporter Name")
            {
            }
            column(VendorOrderNo; "Purch. Inv. Header"."Vendor Order No.")
            {
            }
            column(VendorInvoiceNo; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(VendorInvoiceDate; "Purch. Inv. Header"."Vendor Invoice Date")
            {
            }
            column(GST_VEND_TYPE; VendRec."GST Vendor Type")
            {
            }
            column(DocumentReceivingDate_PurchInvHeader; "Purch. Inv. Header"."Document Receiving Date")
            {
            }
            column(loc_satecode; State_Rec."State Code (GST Reg. No.)")
            {
            }
            column(TranName_Sih; "Purch. Inv. Header"."Transporter Name")
            {
            }
            column(ship_name; ShipToAdd[1])
            {
            }
            column(ship_add1; ShipToAdd[2])
            {
            }
            column(ship_add2; ShipToAdd[3])
            {
            }
            column(ship_city_post; ShipToAdd[4] + '- ' + ShipToAdd[5])
            {
            }
            column(ship_state; ShipToAdd[9])
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
            column(cust_gstno_shipto; ShipToAdd[7])
            {
            }
            column(cust_statecode_shipto; ShipToAdd[10])
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
            column(PostingDate_SalesInvoiceHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(StateCode; StateCode)
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
            column(CusPan; VendRec."P.A.N. No.")
            {
            }
            column(CusT_GSTNo; Cust1."GST Registration No.")
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
            column(DocnO; CONVERTSTR("Purch. Inv. Line"."Document No.", '\', '/'))
            {
            }
            column(PostingDate; FORMAT("Purch. Inv. Header"."Posting Date"))
            {
            }
            column(CINNo; 'CETSH-6908 9090')
            {
            }
            column(Authorisigna; 'AUTHORIZED SIGNATORY')
            {
            }
            column(CustomerOrderN; "Purch. Inv. Header"."Order No.")
            {
            }
            column(SelltoCustNo; "Purch. Inv. Header"."Sell-to Customer No.")
            {
            }
            column(CustName; "Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(SelltoAdd; "Purch. Inv. Header"."Pay-to Address")
            {
            }
            column(SelltoAdd2; "Purch. Inv. Header"."Pay-to Address 2")
            {
            }
            column(SelltoCity; "Purch. Inv. Header"."Pay-to City")
            {
            }
            // 16225 column(StateName; "Purch. Inv. Header".State)
            column(StateName; '')
            {
            }
            column(Stnameloc; Stname)
            {
            }
            column(ShiptoName; "Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(ShiptoName2; "Purch. Inv. Header"."Pay-to Name 2")
            {
            }
            column(ShipttoAdd; "Purch. Inv. Header"."Pay-to Address")
            {
            }
            column(s; "Purch. Inv. Header"."Pay-to Address 2")
            {
            }
            column(ShiptoCity; "Purch. Inv. Header"."Pay-to City")
            {
            }
            column(CustLST; "Cust LST")
            {
            }
            column(CustCST; "Cust CST")
            {
            }
            column(TINNo; SaleInvHeader."Tin No.")
            {
            }
            column(OrderNo; CONVERTSTR("Purch. Inv. Header"."Order No.", '\', '/'))
            {
            }
            column(OrderDate; FORMAT("Purch. Inv. Header"."Order Date"))
            {
            }
            column(TruckNo; "Purch. Inv. Header"."Transporter's Code")
            {
            }
            column(VendorName; Recvendor.Name)
            {
            }
            column(GrNo; "Purch. Inv. Header"."GE No.")
            {
            }
            column(GrDate; FORMAT("Purch. Inv. Header"."Document Receiving Date"))
            {
            }
            column(PONo; "Purch. Inv. Header"."No.")
            {
            }
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(OutStand; 'Rs' + ' ' + FORMAT(Outstand) + ' ' + '(' + 'Including this Invoice' + ')')
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
                dataitem("<pageloop>"; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            ORDER(Ascending)
                                            WHERE(Quantity = FILTER(<> 0));
                        RequestFilterFields = "No.";
                        //16225 column(TDS_Percent; "Purch. Inv. Line"."TDS %")
                        column(TDS_Percent; TDSPer)
                        {
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                        }
                        //16225  column(TOTAL_TDS_In_she_cess; -"Total TDS Including SHE CESS")
                        column(TOTAL_TDS_In_she_cess; -TDSAmount)//15578
                        {
                        }
                        column(LineDiscount_PIL; "Purch. Inv. Line"."Line Discount %")
                        {
                        }
                        column(DirectUnitCost_PIL; "Purch. Inv. Line"."Direct Unit Cost")
                        {
                        }
                        column(OtherTaxes; OtherTaxes)
                        {
                        }
                        column(HSNSACCode_SalesInvoiceLine; "Purch. Inv. Line"."HSN/SAC Code")
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
                        column(QtySIL; "Purch. Inv. Line".Quantity)
                        {
                        }
                        column(UOM; "Unit of Measure")
                        {
                        }
                        column(QtySqMtr; "Purch. Inv. Line"."Qty. per Unit of Measure")
                        {
                        }
                        column(AssesableVal; AssesableVal)
                        {
                        }
                        column(Value; Quantity * "Direct Unit Cost")
                        {
                        }
                        column(GrossWeight; "Purch. Inv. Line"."Gross Weight")
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
                        column(Disamt; ABS(Discount))
                        {
                        }
                        column(LineDisAmt; ("Purch. Inv. Line"."Line Discount Amount"))
                        {
                        }
                        column(Charge; Charge)
                        {
                        }
                        column(InsurnaceCharge; InsurnaceCharge)
                        {
                        }
                        column(VATAmount; ABS(VATAmount))
                        {
                        }
                        column(AddVATAmount; ABS(AddVATAmount))
                        {
                        }
                        //16225 column(AmtToCust; ROUND("Purch. Inv. Line"."Amount To Vendor", 1, '='))
                        column(AmtToCust; ROUND(CustAmount + CAmount + SAmount + IAmount, 1, '='))
                        {
                        }
                        column(GLRoundingOFF; GLRoundingOFF)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            //16225  StructureLineDetails: Record "13798";
                            TDSEntry: Record "TDS Entry";
                        begin
                            TDSEntry.Reset();
                            TDSEntry.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
                            if TDSEntry.FindSet() then
                                repeat
                                    TDSAmount += TDSEntry."Total TDS Including SHE CESS";
                                    TDSPer += TDSEntry."TDS %"
                                Until TDSEntry.Next() = 0;
                            //dheeru
                            CRate := 0;
                            SRate := 0; // Purch. Inv. Line
                            IRate := 0;
                            CAmount := 0;
                            SAmount := 0;
                            IAmount := 0;
                            CustAmount := 0;


                            DetailedGSTLedgerEntry.RESET;
                            DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                            DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                            IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                        CRate := DetailedGSTLedgerEntry."GST %";
                                        CAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                        CAmount1 += CAmount;
                                    END;

                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                        SRate := DetailedGSTLedgerEntry."GST %";
                                        SAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                        SAmount1 += SAmount
                                    END;

                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                        IRate := DetailedGSTLedgerEntry."GST %";
                                        IAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                        IAmount1 += IAmount;
                                    END;

                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                        URate := DetailedGSTLedgerEntry."GST %";
                                        UAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                        IAmount1 += IAmount;
                                    END;

                                UNTIL
DetailedGSTLedgerEntry.NEXT = 0;
                            CustAmount := "Purch. Inv. Line"."Line Amount" + CAmount + SAmount + IAmount;
                            //rks

                            Sno += 1;
                            IF (Sno - 1) MOD 14 = 0 THEN
                                PageBreak1 := (Sno - 1) / 14;

                            PageCont := ROUND(COUNT / 14, 1, '<');

                            //16225 field N/F Start
                            /*  State1.RESET;
                              State1.SETRANGE(State1.Code, "Purch. Inv. Line"."State Code");
                              IF State1.FIND('-') THEN
                                  Stname := State1.Description;*/
                            //16225 field N/F End





                            IF "S.No." = 14 THEN
                                CurrReport.NEWPAGE;

                            "S.No." := "S.No." + 1;

                            // Msdr.begin
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
                            // Msdr.End

                            Item.RESET;
                            Item.SETRANGE(Item."No.", "Purch. Inv. Line"."No.");
                            IF Item.FIND('-') THEN
                                LotNo := Item."Lot Nos.";
                            PostedShipmentDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate;

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
                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            /*  StructureLineDetails.RESET;
                              StructureLineDetails.SETRANGE(StructureLineDetails.Type, StructureLineDetails.Type::Purchase);
                              StructureLineDetails.SETRANGE(StructureLineDetails."Document Type", StructureLineDetails."Document Type"::Invoice);
                              StructureLineDetails.SETRANGE(StructureLineDetails."Invoice No.", "Document No.");
                              StructureLineDetails.SETRANGE(StructureLineDetails."Item No.", "No.");
                              StructureLineDetails.SETRANGE("Line No.", "Line No.");
                              IF StructureLineDetails.FIND('-') THEN
                                  REPEAT
                                      IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN
                                          IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                              ChargesAmount := ChargesAmount + ROUND(StructureLineDetails.Amount);
                                          IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                              OtherTaxesAmount := OtherTaxesAmount + ROUND(StructureLineDetails.Amount);
                                      END;
                                  UNTIL StructureLineDetails.NEXT = 0;



                              PostedStrOrderLineDetails.RESET;
                              PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                              PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Purch. Inv. Line"."Document No.");
                              PostedStrOrderLineDetails.SETRANGE("Item No.", "Purch. Inv. Line"."No.");
                              PostedStrOrderLineDetails.SETRANGE("Line No.", "Purch. Inv. Line"."Line No.");
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
                                                          InsurenceChargeAmount := InsurenceChargeAmount + PostedStrOrderLineDetails.Amount;
                                                          ChargePercentIns := PostedStrOrderLineDetails."Calculation Value"
                                                      END;
                                                  'FREIGHT':
                                                      BEGIN
                                                          FrightChargeAmt := FrightChargeAmt + PostedStrOrderLineDetails.Amount;
                                                      END;
                                                  'ADDVAT':
                                                      BEGIN
                                                          FrightChargeAmt := FrightChargeAmt + PostedStrOrderLineDetails.Amount;
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
                                              END;
                                          END;
                                      END;
                                      IF PostedStrOrderLineDetails."Tax/Charge Type" = PostedStrOrderLineDetails."Tax/Charge Type"::"Sales Tax" THEN BEGIN
                                          CASE PostedStrOrderLineDetails."Tax/Charge Code" OF
                                              'SALES TAX':
                                                  BEGIN
                                                      CSTchargeAmount := CSTchargeAmount + PostedStrOrderLineDetails.Amount;
                                                      ChargePercentCST := PostedStrOrderLineDetails."Calculation Value"
                                                  END;
                                          END;
                                      END;
                                  UNTIL PostedStrOrderLineDetails.NEXT = 0;
                              END;*/
                            SalesInvoiceLine1.RESET;
                            SalesInvoiceLine1.SETRANGE(SalesInvoiceLine1."Document No.", "Purch. Inv. Line"."Document No.");
                            SalesInvoiceLine1.SETRANGE(SalesInvoiceLine1."Line No.", "Purch. Inv. Line"."Line No.");
                            IF SalesInvoiceLine1.FIND('-') THEN BEGIN
                                //16225 Field N/F Start
                                /*  TotalBed := TotalBed +
                                      ROUND(
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                      "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                        SalesInvoiceLine1."BED Amount", "Purch. Inv. Header"."Currency Factor"),
                                        Currency."Unit-Amount Rounding Precision");

                                  TotalEcess := TotalEcess +
                                        ROUND(
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                      "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                        SalesInvoiceLine1."eCess Amount", "Purch. Inv. Header"."Currency Factor"),
                                        Currency."Unit-Amount Rounding Precision");

                                  TotalShcess := TotalShcess +
                                           ROUND(
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                      "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                        SalesInvoiceLine1."SHE Cess Amount", "Purch. Inv. Header"."Currency Factor"),
                                        Currency."Unit-Amount Rounding Precision");*///16225 Field N/F End

                                TotalCashDic := TotalCashDic + SalesInvoiceLine1."Line Discount Amount";
                                TotalTradeDisc := TotalTradeDisc + SalesInvoiceLine1."Inv. Discount Amount";
                            END;
                            Amt := Amt + ROUND("Purch. Inv. Line"."Line Amount", 1);

                            Location2.RESET;
                            Location2.SETRANGE(Location2.Code, "Purch. Inv. Line"."Location Code");
                            IF Location2.FIND('-') THEN BEGIN
                                //Intdays:=FORMAT(Location2."Int. Days");
                                //IntRate:=Location2."Int. Rate";
                                //Complaindays:=FORMAT(Location2."Complain Days");
                                //Juridiction:=Location2.Juridiction;
                                //InvoiceNotification:=Location2."Invoice Notification";
                                //Insurance:=Location2."Insurance Policy No.";
                            END;

                            SalesInvoiceHeader2.RESET;
                            SalesInvoiceHeader2.SETRANGE(SalesInvoiceHeader2."No.", "Purch. Inv. Line"."Document No.");
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
                            //16225 Table N/F Start
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
                            Wt := "Purch. Inv. Line"."Gross Weight";
                            //END
                            //ELSE IF SalesInvLine1."Unit of Measure" = 'CRT' THEN
                            //BEGIN
                            Pcs := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<'); //-- 3. Tri30.0 PG 14111406
                                                                                                          //END;
                                                                                                          //MSAK.BEGIN


                            IF SqMt <> 0 THEN
                                DiscPerCart := "Line Discount Amount" / SqMt;

                            LineDiscount := "Line Discount Amount";
                            //Value :="Quantity in Cartons"*(RateperCart-DiscPerCart) - LineDiscount;
                            //Value :=Amount;
                            //MSAK.END
                            //MSAK.BEGIN
                            /*
                            IF Quantity <> 0 THEN
                              BuyersPrice := (Amount + "Excise Amount") / Quantity;
                            
                            IF "Quantity in Sq. Mt." <> 0 THEN BEGIN
                            DecRate:=("Quantity Discount Amount"/"Quantity in Sq. Mt.");
                            LineDis:=("Line Discount Amount"/"Quantity in Sq. Mt.");
                            END;
                            
                            IF SqMt <> 0 THEN BEGIN
                              BuyersRatePerSqMtr := (BuyersPrice * Quantity / SqMt)+DecRate+LineDis;
                              DiscPerSqmt := "Line Discount Amount"/SqMt;
                            END;
                            
                            Value :=(BuyersRatePerSqMtr*"Quantity in Sq. Mt."); // RKS AFTER JHA SIR RECOMMENDATION// BuyersRatePerSqMtr
                            
                            */
                            ///MSAK.END
                            //16225 Table N/F Start
                            /* IF Quantity <> 0 THEN BEGIN
                                 BEDAmt := BEDAmt + "BED Amount";
                                 Hecess := Hecess + "SHE Cess Amount";
                                 ECess := ECess + "eCess Amount"
                             END;*///16225 Table N/F End

                            Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                            SqMt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                            Pcsqty := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<');
                            Wt := "Purch. Inv. Line"."Gross Weight";

                            //IF Cart <> 0 THEN
                            //  RateperCart := "Unit Price"*Quantity/Cart;

                            //IF Cart <> 0 THEN
                            //  DiscPerCart := "Line Discount Amount"/Cart;
                            //Value := Cart * (RateperCart - DiscPerCart);
                            //MSAK.BEGIN
                            /*
                            IF Quantity <> 0 THEN
                              BuyersPrice := (Amount + "Excise Amount") / Quantity;
                            
                            IF SqMt <> 0 THEN BEGIN
                              BuyersRatePerSqMtr := BuyersPrice * Quantity / SqMt;
                              DiscPerSqmt := "Line Discount Amount"/SqMt;
                            END;
                            */
                            //Value := Amount + "Excise Amount";
                            //MSAK.END
                            /*
                            IF Quantity <> 0 THEN
                              BuyersPrice := (Amount + "Excise Amount") / Quantity;
                            
                            
                            IF SqMt <> 0 THEN BEGIN
                              BuyersRatePerSqMtr := (BuyersPrice * Quantity / SqMt)+DecRate+LineDis;
                              DiscPerSqmt := "Line Discount Amount"/SqMt;
                            END;
                            */

                            /*QD:=0;
                            QuantityDiscountEntry.RESET;
                            QuantityDiscountEntry.SETRANGE("Posted Document No.","Document No.");
                            QuantityDiscountEntry.SETRANGE("Accrued Entry",FALSE);
                            IF QuantityDiscountEntry.FIND('-')THEN BEGIN
                            REPEAT
                              QD+=QuantityDiscountEntry."QD Given Amount";
                            UNTIL QuantityDiscountEntry.NEXT=0;
                            END;
                            
                            AQD:=0;
                            QuantityDiscountEntry.RESET;
                            QuantityDiscountEntry.SETRANGE("Posted Document No.","Document No.");
                            QuantityDiscountEntry.SETRANGE("Accrued Entry",TRUE);
                            IF QuantityDiscountEntry.FIND('-')THEN BEGIN
                            REPEAT
                              AQD+=QuantityDiscountEntry."QD Given Amount";
                            UNTIL QuantityDiscountEntry.NEXT=0;
                            END;
                            
                             */
                            //msvc discount
                            Discount := 0;
                            //16225 Table N/F Start
                            /*  PostedStrOrderLDetails.RESET;
                              PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                              PostedStrOrderLDetails.SETRANGE("Invoice No.", "Purch. Inv. Line"."Document No.");
                              PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
                              IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                                  REPEAT
                                      Discount += PostedStrOrderLDetails.Amount;
                                  UNTIL PostedStrOrderLDetails.NEXT = 0;
                              END;*///16225 Table N/F End


                            InsurnaceCharge := 0;
                            //16225 Table N/F Start
                            /*    PostedStrOrderLDetails.RESET;
                                PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                                PostedStrOrderLDetails.SETRANGE("Invoice No.", "Purch. Inv. Line"."Document No.");
                                PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'INSURANCE');
                                IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                                    REPEAT
                                        InsurnaceCharge += PostedStrOrderLDetails.Amount;
                                    UNTIL PostedStrOrderLDetails.NEXT = 0;
                                END;*///16225 Table N/F End
                                      //msvc insurnace


                            VATAmount := 0;
                            //16225 Table N/F Start
                            /*   DetailedTaxEntry.RESET;
                               DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Document No.", "Purch. Inv. Line"."Document No.");
                               DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Additional Tax", FALSE);
                               IF DetailedTaxEntry.FIND('-') THEN BEGIN
                                   REPEAT
                                       VATAmount += DetailedTaxEntry."Tax Amount";
                                   UNTIL DetailedTaxEntry.NEXT = 0;
                               END;*///16225 Table N/F End

                            AddVATAmount := 0;
                            //16225 Table N/F Start
                            /*  DetailedTaxEntry.RESET;
                              DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Document No.", "Purch. Inv. Line"."Document No.");
                              DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Additional Tax", TRUE);
                              IF DetailedTaxEntry.FIND('-') THEN BEGIN
                                  REPEAT
                                      AddVATAmount += DetailedTaxEntry."Tax Amount";
                                  UNTIL DetailedTaxEntry.NEXT = 0;
                              END;*///16225 Table N/F End

                            //MSSS
                            LineStop := LineStop + 1;
                            /*
                            //MSBS.Rao Begin Dt. 07-06-12
                              //QD +="Quantity Discount Amount"-"Accrued Discount";
                              QD :="Quantity Discount Amount"-"Accrued Discount"; //6700
                              IF QD <> 0 THEN
                                QdText :='QD DISCOUNT';
                              //AQD+="Accrued Discount";
                              AQD :="Accrued Discount";//6700
                              IF AQD<>0 THEN
                                AqdText :='AQD DISCOUNT';
                            //MSBS.Rao End Dt. 07-06-12
                            
                            AssesableVal:="Purch. Inv. Line"."Assessable Value"*"Purch. Inv. Line".Quantity;
                            //Value:=(BuyersRatePerSqMtr*"Quantity in Sq. Mt.") - "Purch. Inv. Line"."Line Discount Amount" ;//-"Excise Amount"; //050717
                            IF ExciseProdPostingGroup.GET("Purch. Inv. Line"."Excise Prod. Posting Group") THEN;
                            IF "Purch. Inv. Line"."Line Discount Amount"<>0 THEN
                            IF "Purch. Inv. Line"."Quantity in Cartons" <> 0 THEN
                            Disamt :="Purch. Inv. Line"."Line Discount Amount"/"Purch. Inv. Line"."Quantity in Cartons";
                            IF ("Type Catogery Code" = '54') OR ("Type Catogery Code" = '60') OR ("Type Catogery Code" = '61')
                               OR ("Type Catogery Code" = '62') OR ("Type Catogery Code" = '70') OR ("Type Catogery Code" = '71')
                               OR ("Type Catogery Code" = '46')          THEN
                                  body := 'Vitreous';
                            */
                            //rowCount:="Purch. Inv. Line".COUNT;

                        end;

                        trigger OnPreDataItem()
                        begin
                            "S.No." := 0;
                            CLEAR(Sno);
                            Sno := 0;
                        end;
                    }
                    dataitem("G/L Entry"; "G/L Entry")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "G/L Account No.", "Posting Date", Amount)
                                            ORDER(Ascending);
                        column(VAR1; VAR1)
                        {
                        }
                        column(VAR2; VAR2)
                        {
                        }
                        column(var3; var3)
                        {
                        }
                        column(var4; var4)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin


                            // "Purch. Inv. Line".SETRANGE("Purch. Inv. Line"."Document No.","Document No.");

                            //   IF "Purch. Inv. Line".FIND('-')THEN

                            //   SETFILTER("G/L Entry"."Document Type",'%1',"G/L Entry"."Document Type"::Invoice);
                            IF "Recg/LAccount".GET("G/L Account No.") THEN;
                            var3 := "G/L Entry"."G/L Account No.";
                            VAR1 := "Recg/LAccount".Name;
                            VAR2 := "G/L Entry"."Debit Amount";
                            var4 := "G/L Entry"."Credit Amount";
                            //MESSAGE('%1',var4);

                            /*  IF ("Recg/LAccount"."No."='11311100')OR("Recg/LAccount"."No."='11311200')OR("Recg/LAccount"."No."='11311300')
                                OR("Recg/LAccount"."No."='11311400')THEN
                                BEGIN
                                recvendor2.GET("G/L Entry"."Source No.");
                                VAR1:= recvendor2.Name;
                                END;
                             CurrReport.SHOWOUTPUT:=TRUE;
                           END;*/


                            IF ("Recg/LAccount"."No." = '11312100') OR ("Recg/LAccount"."No." = '11312200') OR ("Recg/LAccount"."No." = '11312300')
                              OR ("Recg/LAccount"."No." = '11311400') THEN BEGIN
                                IF recvendor2.GET("G/L Entry"."Source No.") THEN
                                    VAR1 := recvendor2.Name;
                            END;

                        end;

                        trigger OnPreDataItem()
                        begin
                            var3 := '';
                            VAR1 := '';
                            VAR2 := 0;
                            var4 := 0;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    OuputNos += 1;
                    IF OuputNos = 1 THEN
                        copyText1 := 'Original For Supplier';
                    IF OuputNos = 2 THEN
                        copyText1 := 'Duplicate For Transporter';
                    IF OuputNos = 3 THEN
                        copyText1 := 'Triplicate For Assessee';
                end;

                trigger OnPreDataItem()
                begin

                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    copyText1 := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    LineStop := 0;
                    //CLEAR(OuputNos);
                    OuputNos := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Billing ADDR
                Location.RESET;
                IF Location.GET("Location Code") THEN;
                State_Rec.RESET;
                IF State_Rec.GET(Location."State Code") THEN;


                VendRec.RESET;
                VendRec.SETRANGE("No.", "Buy-from Vendor No.");
                IF VendRec.FINDFIRST THEN BEGIN
                    BillToAdd[1] := VendRec.Name;
                    BillToAdd[2] := VendRec.Address;
                    BillToAdd[3] := VendRec."Address 2";
                    BillToAdd[4] := VendRec.City;
                    BillToAdd[5] := VendRec."Post Code";
                    BillToAdd[6] := VendRec."State Code";
                    BillToAdd[7] := VendRec."GST Registration No.";
                    BillToAdd[8] := VendRec."P.A.N. No.";

                    RecState.RESET;
                    IF RecState.GET(VendRec."State Code") THEN
                        BillToAdd[10] := RecState."State Code (GST Reg. No.)";
                    BillToAdd[9] := RecState.Description;
                END;
                /*
                //Shipping ADDR
                IF "Ship-to Code" <> '' THEN BEGIN
                  RecShipToAdd.RESET;
                  RecShipToAdd.SETRANGE(Code, "Ship-to Code");
                  IF RecShipToAdd.FINDFIRST THEN BEGIN
                    ShipToAdd[1] :=RecShipToAdd.Name;
                    ShipToAdd[2] :=RecShipToAdd.Address;
                    ShipToAdd[3] :=RecShipToAdd."Address 2";
                    ShipToAdd[4] :=RecShipToAdd.City;
                    ShipToAdd[5] :=RecShipToAdd."Post Code";
                    ShipToAdd[6] :=RecShipToAdd.State;
                    ShipToAdd[7] :=RecShipToAdd."GST Registration No.";
                
                    RecState.RESET;
                    IF RecState.GET(RecShipToAdd.State) THEN
                     ShipToAdd[10] := RecState."State Code (GST Reg. No.)";
                     ShipToAdd[9]  :=RecState.Description;
                
                  END;
                
                END ELSE
                BEGIN
                */
                ShipToAdd[1] := Location.Name;
                ShipToAdd[2] := Location.Address;
                ShipToAdd[3] := Location."Address 2";
                ShipToAdd[4] := Location.City;
                ShipToAdd[5] := Location."Post Code";
                ShipToAdd[6] := Location."State Code";
                ShipToAdd[7] := Location."GST Registration No.";

                RecState.RESET;
                IF RecState.GET(Location."State Code") THEN
                    ShipToAdd[10] := RecState."State Code (GST Reg. No.)";
                ShipToAdd[9] := RecState.Description;
                //END;

                //RAUSHAN B2S2 END



                sate_ship_state.RESET;
                //sate_ship_state.get();


                //dheeru
                //16225 Field N/F Start
                /*   RecState.RESET;
                   RecState.SETRANGE(Code, State);
                   IF RecState.FINDFIRST THEN
                       REPEAT
                           StateCode := RecState."State Code (GST Reg. No.)";
                           StateName := RecState.Description;
                       //MESSAGE('%1=%2',StateCode,StateName);
                       UNTIL
   RecState.NEXT = 0;*///16225 Field N/F End
                       //dheeru Purch. Inv. Header


                IF "Purch. Inv. Header"."Currency Code" <> '' THEN
                    CurCaption := "Purch. Inv. Header"."Currency Code" + ' and Zero Paisa Only'
                ELSE
                    CurCaption := 'Rupees and Zero Paisa Only';
                //16225 Table filed N/F Start
                /*  State1.RESET;
                  State1.SETRANGE(State1.Code, "Purch. Inv. Header".State);
                  IF State1.FIND('-') THEN
                      Stname := State1.Description;*/
                //16225 Table filed N/F End



                j := 0;
                SalesInvLine5.RESET;
                SalesInvLine5.SETFILTER(SalesInvLine5."Document No.", '%1', "Purch. Inv. Header"."No.");
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
                            //16225 TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Purch. Inv. Header"."Form Code");
                            TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Purch. Inv. Header"."Posting Date");
                            IF TaxDetails.FIND('+') THEN
                                IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                    JudText[j] := TaxDetails."Tax Jurisdiction Code";
                                    PerJud[j] := TaxDetails."Tax Below Maximum";
                                END;
                        UNTIL TaxAreaLine.NEXT = 0;
                END;

                //-----MS-PB BEGIN---------
                Location2.RESET;
                Location2.SETRANGE(Code, "Location Code");
                IF Location2.FINDFIRST THEN BEGIN
                    SaleInvHeader.RESET;
                    SaleInvHeader.SETRANGE("No.", "No.");
                    /* IF SaleInvHeader.FINDFIRST THEN
                         HeaderTextLatest := DocumentPrint.PrintInvoiceType(SaleInvHeader, Location2);*///
                END;
                //-----MS-PB END-----------
                //IF Location.FINDFIRST THEN



                IF "Posting Date" >= 20140701D THEN BEGIN //010714D
                    policy := NewPolicy
                END ELSE
                    policy := Text13704;


                QD := 0;
                AQD := 0;
                QdText := '';
                AqdText := '';

                salesinvi7.RESET;
                salesinvi7.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                salesinvi7.SETRANGE(Type, salesinvi7.Type::Item);
                IF salesinvi7.FIND('-') THEN
                    co := salesinvi7.COUNT;
                //16225 Field N/F Start
                /*  IF "Purch. Inv. Header"."Form Code" <> '' THEN
                      FormText := 'Agianst' + ' ' + FORMAT("Purch. Inv. Header"."Form Code")
                  ELSE
                      FormText := '';*///16225 Field N/F End
                                       /*
                                       IF Recvendor.GET("Purch. Inv. Header"."Transporter's Name") THEN// RKS
                                       Respcent.RESET;
                                       IF Respcent.GET("Purch. Inv. Header"."Responsibility Center") THEN
                                          RespCntrAddr[1] := Respcent.Address;
                                          RespCntrAddr[2] := Respcent."Address 2";
                                       */

                COMPRESSARRAY(RespCntrAddr);


                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                //FormatAddr.SalesInvBillTo(BillToAddr,"Purch. Inv. Header");
                //FormatAddr.SalesInvShipTo(ShipToAddr,"Purch. Inv. Header");

                //16225 funcation N/F CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                // PostedDocDim1.SETRANGE("Table ID", DATABASE::"Purch. Inv. Header");
                // PostedDocDim1.SETRANGE("Document No.", "Purch. Inv. Header"."No.");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                /*
               IF "Salesperson Code" = '' THEN BEGIN
                 SalesPurchPerson.INIT;
                 SalesPersonText := '';
               END ELSE BEGIN
                 SalesPurchPerson.GET("Salesperson Code");
                 SalesPersonText := Text000;
               END;
               */
                IF "Your Reference" = '' THEN
                    ReferenceText := ''


                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
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
                //FormatAddr.SalesInvBillTo(CustAddr,"Purch. Inv. Header");
                //IF NOT Cust.GET("Bill-to Customer No.") THEN
                //CLEAR(Cust);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");


                GrandTotal := 0;
                SIL.RESET;
                SIL.SETRANGE(SIL."Document No.", "No.");
                IF SIL.FIND('-') THEN BEGIN
                    REPEAT
                        //16225 TraiffNo := SIL."Excise Prod. Posting Group";
                        // GrandTotal += SIL."Amount To Customer";
                        GrandTotal += CustAmount + SAmount + CAmount + IAmount;
                        IF SIL."No." = '51157000' THEN
                            GLRoundingOFF += CustAmount + SAmount + CAmount + IAmount;
                    UNTIL SIL.NEXT = 0;
                END;
                //RKS

                check.InitTextVariable;
                check.FormatNoText(NetInWord, ROUND(GrandTotal), "Purch. Inv. Header"."Currency Code");



                Exessiblegoods := 0;
                salesinvoiceline.SETRANGE("Document No.", "No.");
                IF salesinvoiceline.FIND('-') THEN BEGIN
                    REPEAT
                        Exessiblegoods := Exessiblegoods + salesinvoiceline.Amount;
                    UNTIL salesinvoiceline.NEXT = 0;
                END;
                //end;

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
        recvendor2: Record Vendor;
        VAR1: Text[1000];
        VAR2: Decimal;
        "Recg/LAccount": Record "G/L Account";
        var3: Text[30];
        SErvicetax: Decimal;
        var4: Decimal;
        sate_ship_state: Record State;
        State_Rec: Record State;
        rowCount: Integer;
        copyText1: Text[50];
        NetInWord: array[3] of Text[200];
        check: Report "Check Report";
        GLRoundingOFF: Decimal;
        RecShipToAdd: Record "Ship-to Address";
        ShipToAdd: array[20] of Text;
        BillToAdd: array[20] of Text;
        VendRec: Record Vendor;
        custState: Record State;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        // PostedDocDim1: Record 359;
        // PostedDocDim2: Record 359;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        OrderNoText: Text[100];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
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
        //16225  PostedStrOrderLineDetails: Record "13798";
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
        StateTable: Record State;
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
        salesinvoiceline: Record "Sales Invoice Line";
        Kgtotal: Decimal;
        Locpin: Code[10];
        ShippingAgent: Record "Shipping Agent";
        Shipingdes: Text[50];
        Cust1: Record Customer;
        challanno: Code[20];
        Salesshipment: Record "Sales Shipment Header";
        SalesInvoiceLine1: Record "Sales Invoice Line";
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
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        PaymentTerm: Text[50];
        ShipmentDes: Text[50];
        DueDate: Date;
        VatChargeAmount: Decimal;
        SalesInvoiceLine3: Record "Sales Invoice Line";
        A: Code[10];
        VatPercentAmount: Decimal;
        InvoiceDicount: Decimal;
        Customer: Record Customer;
        CustECCNo: Code[20];
        CustRange: Code[200];
        CustCommissionerate: Code[200];
        CustPANNo: Code[20];
        "CST%": Text[30];
        "VAT%": Text[30];
        "InvoiceDisc%": Text[30];
        "Insurance%": Text[30];
        "Cust.InvoiceDisc.": Record "Cust. Invoice Disc.";
        "TradeDic%": Text[30];
        TradePercente: Decimal;
        SalesInvoiceHeader4: Record "Sales Invoice Header";
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
        VAT: Code[20];
        //16225  ExcisePostingSetup: Record "13711";
        "BED%": Decimal;
        "eCess%": Decimal;
        "SHECess%": Decimal;
        SIL: Record "Sales Invoice Line";
        TraiffNo: Code[20];
        SalesOrderNo: Code[20];
        AmountinWord: array[2] of Text[100];
        GrandTotal: Decimal;
        Respcent: Record "Responsibility Center";
        RespCntrAddr: array[15] of Text[250];
        NoInText: array[10] of Text[250];
        ExInText: array[10] of Text[50];
        //16225 ExcisePGP: Record "13710";
        BarCodeRequired: Boolean;
        SIH: Record "Sales Invoice Header";
        txt: Text[100];
        Range: Text[100];
        Division: Text[100];
        LineStop: Integer;
        Exessiblegoods: Decimal;
        //16225 "Excise Prod.Posting Group": Record "13710";
        Desc: Text[60];
        NOOFPKG: Decimal;
        //16225  ExciseProdPostingGroup: Record "13710";
        QTYPERPKG: Decimal;
        CLE: Record "Cust. Ledger Entry";
        VendorCode: Code[20];
        SINC: Record "Sales Invoice Line";
        Type1: Code[20];
        ItemPartNo: array[600] of Code[20];
        MSFNo: Code[20];
        SIHeader: Record "Sales Invoice Header";
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
        SalesInvLine5: Record "Sales Invoice Line";
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        j: Integer;
        JudText: array[4] of Code[50];
        PerJud: array[3] of Decimal;
        salesinvi7: Record "Sales Invoice Line";
        co: Integer;
        State1: Record State;
        Stname: Text[50];
        //16225  PostedStrOrderLDetails: Record "13798";
        Discount: Decimal;
        InsurnaceCharge: Decimal;
        //16225    DetailedTaxEntry: Record "16522";
        VATAmount: Decimal;
        AddVATAmount: Decimal;
        FormText: Text[30];
        Text13705: Text[100];
        DecRate: Decimal;
        LineDis: Decimal;
        DocumentPrint: Codeunit "Document-Print";
        HeaderTextLatest: Text[100];
        SaleInvHeader: Record "Sales Invoice Header";
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
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
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
        CustAmount: Decimal;
        IAmount1: Decimal;
        TotalGSTAmount: Decimal;
        OtherTaxes: Decimal;
        TDSAmount: Decimal;
        TDSPer: Decimal;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        /*
        NextEntryNo := 1;
        IF "Purch. Inv. Line"."Shipment No." <> '' THEN
          IF SalesShipmentHeader.GET("Purch. Inv. Line"."Shipment No.") THEN
            EXIT(SalesShipmentHeader."Posting Date");
        
        IF "Purch. Inv. Header"."Order No."='' THEN
          EXIT("Purch. Inv. Header"."Posting Date");
        
        CASE "Purch. Inv. Line".Type OF
          "Purch. Inv. Line".Type::Item:
            GenerateBufferFromValueEntry("Purch. Inv. Line");
          "Purch. Inv. Line".Type::"G/L Account","Purch. Inv. Line".Type::Resource,
          "Purch. Inv. Line".Type::"Charge (Item)","Purch. Inv. Line".Type::"Fixed Asset":
             GenerateBufferFromShipment("Purch. Inv. Line");
          "Purch. Inv. Line".Type::" ":
              EXIT(0D);
        END;
        
        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.","Purch. Inv. Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No." ,"Purch. Inv. Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
          SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
              SalesShipmentBuffer.GET(
                SalesShipmentBuffer2."Document No.",SalesShipmentBuffer2."Line No.",SalesShipmentBuffer2."Entry No.");
              SalesShipmentBuffer.DELETE;
              EXIT(SalesShipmentBuffer2."Posting Date");;
            END ;
           SalesShipmentBuffer.CALCSUMS(Quantity);
           IF SalesShipmentBuffer.Quantity <> "Purch. Inv. Line".Quantity THEN BEGIN
             SalesShipmentBuffer.DELETEALL;
             EXIT("Purch. Inv. Header"."Posting Date");
           END;
        END ELSE
          EXIT("Purch. Inv. Header"."Posting Date");
        */

    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        /*
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.","Posting Date");
        ValueEntry.SETRANGE("Document No.",SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date","Purch. Inv. Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.",'');
        ValueEntry.SETFILTER("Entry No.",'%1..',FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
          REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
              IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
              ELSE
                Quantity := ValueEntry."Invoiced Quantity";
              AddBufferEntry(
                SalesInvoiceLine2,
                -Quantity,
                ItemLedgerEntry."Posting Date");
              TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
            END;
            FirstValueEntryNo := ValueEntry."Entry No." + 1;
          UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
        */

    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        /*
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.",'..%1',"Purch. Inv. Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.","Purch. Inv. Header"."Order No.");
        IF SalesInvoiceHeader.FIND('-') THEN
          REPEAT
            SalesInvoiceLine2.SETRANGE("Document No.",SalesInvoiceHeader."No.");
            SalesInvoiceLine2.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
            SalesInvoiceLine2.SETRANGE(Type,SalesInvoiceLine.Type);
            SalesInvoiceLine2.SETRANGE("No.",SalesInvoiceLine."No.");
            SalesInvoiceLine2.SETRANGE("Unit of Measure Code",SalesInvoiceLine."Unit of Measure Code");
            IF SalesInvoiceLine2.FIND('-') THEN
              REPEAT
                TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
              UNTIL SalesInvoiceLine2.NEXT = 0;
          UNTIL SalesInvoiceHeader.NEXT = 0;
        
        SalesShipmentLine.SETCURRENTKEY("Order No.","Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.","Purch. Inv. Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.",SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type,SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.",SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code",SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity,'<>%1',0);
        
        IF SalesShipmentLine.FIND('-') THEN
          REPEAT
            IF "Purch. Inv. Header"."Get Shipment Used" THEN
              CorrectShipment(SalesShipmentLine);
            IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
              TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
            ELSE BEGIN
              IF ABS(SalesShipmentLine.Quantity)  > ABS(TotalQuantity) THEN
                SalesShipmentLine.Quantity := TotalQuantity;
              Quantity :=
                SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
        
              TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
              SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;
        
              IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
                BEGIN
                  AddBufferEntry(
                    SalesInvoiceLine,
                    Quantity,
                    SalesShipmentHeader."Posting Date");
                END;
            END;
          UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
        */

    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        /*
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.","Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.",SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.",SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
           REPEAT
              SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
           UNTIL SalesInvoiceLine.NEXT = 0;
        */

    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        /*
        SalesShipmentBuffer.SETRANGE("Document No.",SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date",PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
          SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
          SalesShipmentBuffer.MODIFY;
          EXIT;
        END;
        
        WITH SalesShipmentBuffer DO BEGIN
          "Document No." := SalesInvoiceLine."Document No.";
          "Line No." := SalesInvoiceLine."Line No.";
          "Entry No." := NextEntryNo;
          Type := SalesInvoiceLine.Type;
          "No." := SalesInvoiceLine."No.";
          Quantity := QtyOnShipment;
         "Posting Date" := PostingDate;
          INSERT;
          NextEntryNo := NextEntryNo + 1
        END;
        */

    end;

    procedure GetDate()
    begin
    end;

    procedure GetPartNo(SalesInvLine: Record "Sales Invoice Line"): Code[20]
    var
        Item: Record Item;
       // ItemCrossRef: Record "Item Cross Reference";
    begin
        /*
        IF Item.GET("Purch. Inv. Line"."No.") THEN BEGIN
          ItemCrossRef.RESET();
          ItemCrossRef.SETRANGE("Item No.",Item."No.");
          ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::Customer);
          ItemCrossRef.SETRANGE("Cross-Reference Type No.",SalesInvLine."Buy-from Vendor No.");
          ItemCrossRef.SETFILTER("Cross-Reference No.",'<>%1','');
          IF ItemCrossRef.FINDFIRST THEN BEGIN
            EXIT(ItemCrossRef."Cross-Reference No.");
          END;
        END;
        */

    end;
}

