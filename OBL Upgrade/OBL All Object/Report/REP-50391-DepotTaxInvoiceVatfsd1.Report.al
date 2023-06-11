report 50391 "Depot Tax Invoice Vat fsd1"
{
    // 
    // //TRI H.B 12.04.06 - new report Created.
    // 
    // //-- 1. Tri30.0 PG 14112006 - New Global Variable Added - "Pcs" - Decimal Type
    // //-- 2. Tri30.0 PG 14112006 - New Code Added In "Sales Invoice Line - OnPreDataItem()"
    // //-- 3. Tri30.0 PG 14112006 - New Code Added In "Sales Invoice Line - OnAfterGetRecord()"
    // //-- 4. Tri30.0 PG 14112006 - New Controls Added In "Sales Invoice Line, Footer (2)"
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DepotTaxInvoiceVatfsd1.rdl';


    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.";
            column(TransferfromCode_TSH; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TSH; "Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransferfromName2_TSH; "Transfer Shipment Header"."Transfer-from Name 2")
            {
            }
            column(TransferfromAddress_TSH; "Transfer Shipment Header"."Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TSH; "Transfer Shipment Header"."Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TSH; "Transfer Shipment Header"."Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TSH; "Transfer Shipment Header"."Transfer-from City")
            {
            }
            column(TransferfromCounty_TTSH; "Transfer Shipment Header"."Transfer-from County")
            {
            }
            column(TrsffromCountryRegionCode_TSH; "Transfer Shipment Header"."Trsf.-from Country/Region Code")
            {
            }
            column(TransfertoCode_TSH; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TSH; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoName2_TSH; "Transfer Shipment Header"."Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TSH; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TSH; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TSH; "Transfer Shipment Header"."Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TSH; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(TransfertoCounty_TSH; "Transfer Shipment Header"."Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TSHr; "Transfer Shipment Header"."Trsf.-to Country/Region Code")
            {
            }
            column(TransferOrderDate_TSH; "Transfer Shipment Header"."Transfer Order Date")
            {
            }
            column(TransferfromState_TSH; "Transfer Shipment Header"."Transfer-from State")
            {
            }
            column(TransfertoState_TSH; "Transfer Shipment Header"."Transfer-to State")
            {
            }
            column(DiscountValue; Discount)
            {
            }
            column(vendor_Name; vendor.Name)
            {
            }
            column(vendor_Address; vendor.Address)
            {
            }
            column(vendor_Address2; vendor."Address 2")
            {
            }
            //16225  column(vendor_TINNo; vendor."T.I.N. No.")
            column(vendor_TINNo; vendor."CST Tin")
            {
            }
            column(vendor_PANNo; vendor."P.A.N. No.")
            {
            }
            column(vendor_City; vendor.City)
            {
            }
            //16225  column(vendor_ECCNo; vendor."E.C.C. No.")
            column(vendor_ECCNo; vendor."CST Tin")
            {
            }
            //16225 column(vendor_Range; vendor.Range)
            column(vendor_Range; vendor.Region)
            {
            }
            //16225   column(vendor_Collec; vendor.Collectorate)
            column(vendor_Collec; vendor.City)
            {
            }
            column(OutBal; OutBal)
            {
            }
            column(CustomerStateDes; CustomerStateDes)
            {
            }
            column(ShippiStateDes; ShippiStateDes)
            {
            }
            column(ShiptoPhone; Shipto."Phone No.")
            {
            }
            column(CustPan; Customer."P.A.N. No.")
            {
            }
            column(Cust_GSTIN; Customer."GST Registration No.")
            {
            }
            column(Company_GST_No; CompanyInfo."GST Registration No.")
            {
            }
            column(Company_PAN_No; CompanyInfo."P.A.N. No.")
            {
            }
            //16225  column(Company_STATE_Code; CompanyInfo.State)
            column(Company_STATE_Code; CompanyInfo."State Code")
            {
            }
            column(CustTIN; Customer."TIN Date")
            {
            }
            column(Cust_State_Code; Customer."State Code")
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(Address; Address + ',' + Location."State Code" + ',' + 'Phone No.' + Location."Phone No.")
            {
            }
            column(Location_State_Code; Location."State Code")
            {
            }
            column(Location_Phone; 'Phone No.' + Location."Phone No.")
            {
            }
            column(SIH_PostingDate; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(HeaderTextLatest; HeaderTextLatest)
            {
            }
            column(Taxstat; Taxstat)
            {
            }
            column(CstTot; CstTot)
            {
            }
            column(VatTot; VatTot)
            {
            }
            column(KText; KText)
            {
            }
            column(GrpDesc1; GroupCode.Description)
            {
            }
            column(GrpDesc2; GroupCode.Description2)
            {
            }
            column(Location_GST; RecState."State Code (GST Reg. No.)")
            {
            }
            column(TruckNo_SalesInvoiceHeader; "Transfer Shipment Header"."Truck No.")
            {
            }
            column(GRDate_SalesInvoiceHeader; "Transfer Shipment Header"."GR Date")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(TINNo; "TINNo.")
            {
            }
            //16225  column(LocCST; Location."C.S.T No.")
            column(LocCST; Location."C.S.T. No.")
            {
            }
            //16225 column(CSTNo; Customer."C.S.T. No.")
            column(CSTNo; Customer."TAN No.")
            {
            }
            column(GrNo; "Transfer Shipment Header"."GR No.")
            {
            }
            column(GRDate; "Transfer Shipment Header"."GR Date")
            {
            }
            column(FormCode; FormCode)
            {
            }
            column(FormNo; FormNo)
            {
            }
            column(Ph; Ph)
            {
            }
            column(Fax; Fax)
            {
            }
            column(tgcstper; tgcstper)
            {
            }
            column(tgvatper; tgvatper)
            {
            }
            column(AssessValText; AssessValText[1] + AssessValText[2])
            {
            }
            column(StateCode; StateCode)
            {
            }
            column(CustomerStateDes1; CustomerStateDes1)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Transfer Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            ORDER(Ascending)
                                            WHERE(Quantity = FILTER(<> 0));
                        column(ExciseInWord; ExciseInWord[1])
                        {
                        }
                        //16225  column(SalesInvoiceLine_ExciseAmount; ROUND("Excise Amount"))
                        column(SalesInvoiceLine_ExciseAmount; ROUND("Amount"))
                        {
                        }
                        column(Text13706; FORMAT(Text13706))
                        {
                        }
                        column(Item_Tariff; Item."HSN/SAC Code")
                        {
                        }
                        column(Cart; Cart)
                        {
                        }
                        column(sno; sno)
                        {
                        }
                        column(Description_SalesInvoiceLine; "Transfer Shipment Line".Description + ' ' + "Transfer Shipment Line"."Description 2")
                        {
                        }
                        column(Description2_SalesInvoiceLine; "Transfer Shipment Line"."Description 2")
                        {
                        }
                        column(TypeDesc; TypeDesc)
                        {
                        }
                        column(Quantity_SalesInvoiceLine; "Transfer Shipment Line".Quantity)
                        {
                        }
                        column(UnitofMeasureCode_SalesInvoiceLine; "Transfer Shipment Line"."Unit of Measure Code")
                        {
                        }
                        column(Sqmt; ROUND(Sqmt, 0.01))
                        {
                        }
                        column(Wt; Wt)
                        {
                        }
                        column(DiscPerSqmt; DiscPerSqmt)
                        {
                        }
                        column(BuyersRatePerSqMtr; BuyersRatePerSqMtr)
                        {
                        }
                        column(Value; Value)
                        {
                        }
                        column(Rounoff; Rounoff)
                        {
                        }
                        column(AmountToCustomer_SalesInvoiceLine; "Transfer Shipment Line".Amount)
                        {
                        }
                        //16225  column(BEDAmt; "Transfer Shipment Line"."BED Amount")
                        column(BEDAmt; "Transfer Shipment Line"."Amount")
                        {
                        }
                        //16225    column(AssessValue; "Transfer Shipment Line"."Assessable Value")
                        column(AssessValue; "Transfer Shipment Line"."GST Assessable Value")
                        {
                        }
                        //16225 column(Assekbs; "Transfer Shipment Line"."Assessable Value" * "Transfer Shipment Line".Quantity)
                        column(Assekbs; "Transfer Shipment Line"."GST Assessable Value" * "Transfer Shipment Line".Quantity)
                        {
                        }
                        //16225 column(ExcisUnitrate; "Transfer Shipment Line"."Assessable Value" * 12.5 / 100)
                        column(ExcisUnitrate; "Transfer Shipment Line"."GST Assessable Value" * 12.5 / 100)
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
                        column(QD; QD)
                        {
                        }
                        column(AQD; AQD)
                        {
                        }
                        column(AqdText; AqdText)
                        {
                        }
                        column(QdText; QdText)
                        {
                        }
                        column(QcText; QcText)
                        {
                        }
                        column(InvDisc; ABS(InvDisc))
                        {
                        }
                        column(InsDisc; InsDisc)
                        {
                        }
                        column(AdditionalTot; AdditionalTot)
                        {
                        }
                        column(ChargeAmt; ChargeAmt)
                        {
                        }
                        column(InsuranceAmt; InsuranceAmt)
                        {
                        }
                        column(OtherTaxes; OtherTaxes)
                        {
                        }
                        column(PerJud1; FORMAT(PerJud[1]))
                        {
                        }
                        column(JudText1; JudText[1])
                        {
                        }
                        column(tgaddPer; tgaddPer)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //dheeru
                            CRate := 0;
                            SRate := 0;
                            IRate := 0;
                            CAmount := 0;
                            SAmount := 0;
                            IAmount := 0;


                            DetailedGSTLedgerEntry.RESET;
                            DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            //DetailedGSTLedgerEntry.SETRANGE("No.","No.");
                            DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                            IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                        CRate := DetailedGSTLedgerEntry."GST %";
                                        CAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                        CAmount1 += CAmount;
                                    END;

                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                        SRate := DetailedGSTLedgerEntry."GST %";
                                        SAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                        SAmount1 += SAmount
                                    END;

                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                        IRate := DetailedGSTLedgerEntry."GST %";
                                        IAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                        IAmount1 += IAmount;
                                    END;
                                UNTIL
DetailedGSTLedgerEntry.NEXT = 0;
                            TotalGSTAmount := 0;
                            TotalGSTAmount += CAmount1 + SAmount1 + IAmount1;
                            //GSTTotal := 0;
                            DetailedGSTLedgerEntry.RESET;
                            DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            IF DetailedGSTLedgerEntry.FIND('-') THEN BEGIN
                                REPEAT
                                    GSTTotal += ABS(DetailedGSTLedgerEntry."GST Amount");
                                //Message('%1',GSTTotal);
                                UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                            END;


                            //dheeru


                            Sno1 += 1;


                            //RKS 020617
                            Item.RESET;
                            IF Item.GET("Transfer Shipment Line"."Item No.") THEN;
                            //RKS 020617

                            Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                            Sqmt := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                            Pcs := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", Quantity), 1, '<') - ROUND("Transfer Shipment Line".Amount, 1, '=');
                            //Rounoff:=("Transfer Shipment Line"."Amount To Customer");
                            Wt := "Transfer Shipment Line"."Gross Weight";
                            //MSBS.Rao Begin Dt. 07-06-12
                            /*  QD+="Quantity Discount Amount"-"Accrued Discount";
                              IF QD <> 0 THEN
                                QdText :='BR DISCOUNT';
                              AQD+="Accrued Discount";//RKS
                              IF AQD<>0 THEN
                                AqdText :='ABR DISCOUNT';
                                */
                            //MSBS.Rao End Dt. 07-06-12


                            //IF Cart <> 0 THEN
                            //  RateperCart := "Unit Price"*Quantity/Cart;

                            //IF Cart <> 0 THEN
                            //  DiscPerCart := "Line Discount Amount"/Cart;
                            //Value := Cart * (RateperCart - DiscPerCart);

                            /* IF Quantity <> 0 THEN//16225 fIELD N/f
                                 BuyersPrice := (Amount + "Excise Amount") / Quantity;*/
                            /*
                            IF "Qty in Sq. Mt." <> 0 THEN BEGIN
                            DecRate:=("Qty Discount Amount"/"Qty in Sq. Mt."); //RKS rate
                            LineDis:=("Line Discount Amount"/"Qty in Sq. Mt.");
                            END;
                            
                            IF Sqmt <> 0 THEN BEGIN
                              BuyersRatePerSqMtr := (BuyersPrice * Quantity / Sqmt)+DecRate;
                              DiscPerSqmt := "Line Discount Amount"/Sqmt;
                            END;
                              Ball:=BuyersRatePerSqMtr+DiscPerSqmt;
                            //Value := Amount + "Excise Amount";
                            Value:=(Ball*"Qty in Sq. Mt.");
                            */

                            //CurrReport.SHOWOUTPUT(FALSE);

                            TypeName := '';
                            SizeName := '';
                            TypeDesc := '';

                            InventorySetup.GET;
                            IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                                SizeName := DimensionValue.Name;
                            IF DimensionValue.GET(InventorySetup."Type Code", "Type Code") THEN
                                TypeName := DimensionValue.Name;
                            IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                                PackingName := DimensionValue.Name;

                            sno := sno + 1;


                            //TRI 22.02.08 N.K Add Start
                            //ItemType.SETRANGE(ItemType."No.","Transfer Shipment Line"."ITEM No.");
                            //IF ItemType.FIND('-')THEN
                            //TRI 22.02.08 N.K Add Stop

                            //TRI NM 170308 Add Start
                            DimensionValue.RESET;
                            DimensionValue.SETFILTER("Dimension Code", '=%1', 'CATG');
                            DimensionValue.SETRANGE(Code, "Type Catogery Code");
                            IF DimensionValue.FINDFIRST THEN
                                TypeDesc := DimensionValue.Name;
                            //TRI NM 170308 Add Stop
                            //MESSAGE('%1',("Transfer Shipment Line"."Amount To Customer"));


                            //16225    ExciseAmt := "Transfer Shipment Line"."Excise Amount";
                            //16225    BEDAmt := "Transfer Shipment Line"."BED Amount";
                            //16225    ECessAmt := "Transfer Shipment Line"."eCess Amount";
                            SubTotal += Value; //tri

                            check.InitTextVariable();
                            check.FormatNoText(ExciseInWord, ROUND(ExciseAmt, 1), '');
                            Count1 := "Transfer Shipment Line".COUNT;
                            //message('%1',Count1)

                        end;

                        trigger OnPreDataItem()
                        begin

                            CurrReport.CREATETOTALS(Value, Cart, Sqmt, Wt);
                            CurrReport.CREATETOTALS(Pcs); //-- 2. Tri30.0 PG 14112006
                            //CurrReport.CREATETOTALS("Transfer Shipment Line"."Amount To Customer");
                            CLEAR(Sno1);
                            GSTTotal := 0;
                        end;
                    }
                    /*   dataitem(DataItem1000000002; 13798)
                       {
                           DataItemLink = Invoice No.=FIELD(No.);
                           DataItemLinkReference = "Transfer Shipment Header";
                           DataItemTableView = SORTING(Tax/Charge Type, Tax/Charge Code)
                                               ORDER(Ascending)
                                               WHERE(Type = FILTER(Sale));
                           column(QD; QD)
                           {
                           }
                           column(AQD; AQD)
                           {
                           }
                           column(AqdText; AqdText)
                           {
                           }
                           column(QdText; QdText)
                           {
                           }
                           column(QcText; QcText)
                           {
                           }
                           column(InvDisc; ABS(InvDisc))
                           {
                           }
                           column(InsDisc; InsDisc)
                           {
                           }
                           column(AdditionalTot; AdditionalTot)
                           {
                           }
                           column(ChargeAmt; ChargeAmt)
                           {
                           }
                           column(InsuranceAmt; InsuranceAmt)
                           {
                           }
                           column(OtherTaxes; OtherTaxes)
                           {
                           }
                           column(PerJud1; FORMAT(PerJud[1]))
                           {
                           }
                           column(JudText1; JudText[1])
                           {
                           }
                           column(tgaddPer; tgaddPer)
                           {
                           }

                           trigger OnAfterGetRecord()
                           begin
                               Sno2 += 1;

                               GenLegSetup.GET;
                               CASE "Tax/Charge Type" OF
                                   "Tax/Charge Type"::Charges:
                                       BEGIN
                                           CASE "Charge Type" OF
                                               "Charge Type"::" ", "Charge Type"::Freight, "Charge Type"::Commission:
                                                   /*IF ("Tax/Charge Group" <> GenLegSetup."Discount Charge") THEN
                                                     ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;*/
                    //16225 Start
                    /* IF ("Tax/Charge Group" <> GenLegSetup."Discount Charge") AND
                      ("Tax/Charge Group" <> GenLegSetup.AddInsuranceDisc) THEN
                         ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;

                 "Charge Type"::Insurance:
                     InsuranceAmt += "Posted Str Order Line Details".Amount;
             END;

             IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                 InvDisc += "Posted Str Order Line Details".Amount;
             IF "Tax/Charge Group" = GenLegSetup.AddInsuranceDisc THEN
                 InsDisc += "Posted Str Order Line Details".Amount;

         END;
     "Tax/Charge Type"::"Sales Tax":
         SalesTaxAmt += "Posted Str Order Line Details".Amount;
     "Tax/Charge Type"::"Other Taxes":
         OtherTaxes += "Posted Str Order Line Details".Amount;
     "Tax/Charge Type"::"Service Tax":
         VATAmt += "Posted Str Order Line Details".Amount;
 END;*///16225 End

                    //sash
                    /*16225 IF InsDisc = 0 THEN
                        QcText := ''
                    ELSE
                        QcText := 'Qc Discount';*///16225 End


                    //16225 IF Sno2 = "Posted Str Order Line Details".COUNT THEN BEGIN
                    /*
                    DetailedTaxEntry.RESET;
                    DetailedTaxEntry.SETRANGE("Document No.","Transfer Shipment Header"."No.");
                    IF DetailedTaxEntry.FINDFIRST THEN
                    REPEAT
                      DetailedTaxEntry.CALCFIELDS("Additional Tax");
                       IF DetailedTaxEntry."Tax Type" = DetailedTaxEntry."Tax Type"::CST THEN BEGIN
                        IF NOT DetailedTaxEntry."Additional Tax" THEN BEGIN
                          CstTot := CstTot+(-DetailedTaxEntry."Tax Amount");
                          CstPercent := DetailedTaxEntry."Tax %";
                          tgcstper := FORMAT(CstPercent) +'  %';
                        END ELSE BEGIN
                          AdditionalTot := AdditionalTot + (-DetailedTaxEntry."Tax Amount");
                          AdditionalPercent := DetailedTaxEntry."Tax %";
                          tgaddPer := FORMAT(AdditionalPercent) +'  %';
                        END;
                       END;

                       IF DetailedTaxEntry."Tax Type" = DetailedTaxEntry."Tax Type"::VAT THEN BEGIN
                        IF NOT DetailedTaxEntry."Additional Tax" THEN BEGIN
                          VatTot := VatTot+(-DetailedTaxEntry."Tax Amount");
                          VatPercent := DetailedTaxEntry."Tax %";
                          tgvatper := FORMAT(VatPercent) +'  %';
                        END ELSE BEGIN
                          AdditionalTot := AdditionalTot + (-DetailedTaxEntry."Tax Amount");
                          AdditionalPercent := DetailedTaxEntry."Tax %";
                          tgaddPer := FORMAT(AdditionalPercent) +'  %';
                        END;
                       END;

                    UNTIL  DetailedTaxEntry.NEXT=0;
                           */
                    //16225   END;

                    //16225 end;

                    //  trigger OnPreDataItem()
                    // begin
                    /*
                    IF "Transfer Shipment Header"."Free Supply" = FALSE THEN BEGIN
                       ExciseText[1] := ExciseAmt;
                       ExciseLabel[1] := 'Excise';
                       Taxtotal := Amount;
                       ExciseText[2] := 0;  //RKS
                       ExciseLabel[2] := '';
                    END ELSE BEGIN
                       ExciseText[2] := ExciseAmt;
                       ExciseLabel[2] := 'Excise';
                       Taxtotal := Amount - ExciseAmt;
                       ExciseText[1] := 0;
                       ExciseLabel[1] := '';
                    END;
                    */
                    /* 16225 startFOR i := 1 TO 3 DO BEGIN
                         JudText[i] := '';
                         PerJud[i] := 0;
                     END;
                     i := 0;
                     SalesInvLine1.RESET;
                     SalesInvLine1.SETFILTER(SalesInvLine1."Document No.", '%1', "Transfer Shipment Header"."No.");
                     SalesInvLine1.SETFILTER(SalesInvLine1."Tax Liable", '%1', TRUE);
                     IF SalesInvLine1.FIND('-') THEN BEGIN
                         TaxAreaLine.RESET;
                         TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', SalesInvLine1."Tax Area Code");
                         IF TaxAreaLine.FIND('-') THEN
                             REPEAT
                                 i := i + 1;
                                 TaxDetails.RESET;
                                 TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                                 TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', SalesInvLine1."Tax Group Code");
                                 TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Transfer Shipment Header"."Form Code");
                                 TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Transfer Shipment Header"."Posting Date");
                                 IF TaxDetails.FIND('+') THEN
                                     IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                         JudText[i] := TaxDetails."Tax Jurisdiction Code";
                                         PerJud[i] := TaxDetails."Tax Below Maximum";
                                     END;
                             UNTIL TaxAreaLine.NEXT = 0;
                     END;

                     SalesInvLine1.RESET;
                     SalesInvLine1.SETFILTER(SalesInvLine1."Document No.", '%1', "Transfer Shipment Header"."No.");
                     IF SalesInvLine1.FIND('-') THEN
                         tgVat := SalesInvLine1."VAT %";

                     IF InsuranceAmt <> 0 THEN
                         Policy := NewPolicy
                     ELSE
                         Policy := '';
                     CLEAR(Sno2);*///16225 End

                    //16225  end;
                    //16225 }
                    /*16225 Start dataitem(Integer; Integer)
                     {
                         DataItemLinkReference = PageLoop;
                         DataItemTableView = SORTING(Number);
                         column(Number_Integer; Integer.Number)
                         {
                         }
                         column(Count1; Count1)
                         {
                         }

                         trigger OnPreDataItem()
                         begin
                             SETRANGE(Number, 1, 15 - Count1);
                         end;
                     }*///16225 End
                }

                trigger OnAfterGetRecord()
                begin
                    IF NoOfLoops > 0 THEN BEGIN
                        OutputNo += 1;
                    END;

                    IF OutputNo = 1 THEN
                        CopyText := 'ORIGINAL FOR BUYER';
                    IF OutputNo = 2 THEN
                        CopyText := 'DUPLICATE FOR TRANSPORTER';
                    IF OutputNo = 3 THEN
                        CopyText := 'TRIPLICATE FOR ASSESSEE';
                    IF OutputNo >= 4 THEN
                        CopyText := 'EXTRA COPY';
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //dheeru
                /*   RecState.RESET;
                   RecState.SETRANGE(Code, "Transfer-from Code");
                   IF RecState.FINDFIRST THEN
                       REPEAT
                           StateCode := RecState."State Code (GST Reg. No.)";
                           StateName := RecState.Description;
                       //MESSAGE('%1=%2',StateCode,StateName);
                       UNTIL
   RecState.NEXT = 0;
                   //dheeru

                   //IF "Transfer Shipment Header"."Currency Code" <> '' THEN
                   //  CurrCode := "Transfer Shipment Header"."Currency Code" + ' Only'
                   //ELSE
                   // CurrCode := 'Rupees and Zero Paisa Only';

                   CALCFIELDS(Amount);
                   Rounoff := (ROUND(Amount, 1) - Amount);
                   QD := 0;
                   AQD := 0;
                   QdText := '';
                   AqdText := '';

                   SubTotal := 0;
                   CLEAR(ExciseText);
                   CLEAR(ExciseLabel);
                   ExciseAmt := 0;
                   BEDAmt := 0;
                   ECessAmt := 0;
                   FormCode := '';
                   FormNo := '';
                   ChargeAmt := 0;
                   SalesTaxAmt := 0;
                   OtherTaxes := 0;
                   VATAmt := 0;
                   InsuranceAmt := 0;*///16225 End
                                       //16225IF FormCodes.GET("Form Code") THEN BEGIN
                                       //16225 FormCode := 'Against ' + FormCodes.Description;
                                       //16225 FormNo := 'Form No. ' + "Form No.";
                                       //MS-PB BEGIN After discussion with Mr. Kulbhushan sharma. Conclusion:- (QD and AQD Calculation does not belongs to form attached).
                                       /*  QD:=0;
                                         QuantityDiscountEntry.RESET;
                                         QuantityDiscountEntry.SETRANGE("Posted Document No.","No.");
                                         QuantityDiscountEntry.SETRANGE("Accrued Entry",FALSE);
                                         QuantityDiscountEntry.SETFILTER("QD Given Amount",'<>%1',0);
                                         IF QuantityDiscountEntry.FIND('-')THEN BEGIN
                                           QdText :='QD DISCOUNT';
                                         //REPEAT
                                           QD+=QuantityDiscountEntry."QD Given Amount";
                                         //UNTIL QuantityDiscountEntry.NEXT=0;
                                       */  //MS-END;
                                           //16225 END; //ELSE
                                           //MS-PB BEGIN After discussion with Mr. Kulbhushan sharma. Conclusion:- (QD and AQD Calculation does not belongs to form attached).

                /*QdText :='';
                
                AQD:=0;
                  AqdText :='';
                QuantityDiscountEntry.RESET;
                QuantityDiscountEntry.SETRANGE("Posted Document No.","No.");
                QuantityDiscountEntry.SETFILTER("QD Given Amount",'<>%1',0);
                QuantityDiscountEntry.SETRANGE("Accrued Entry",TRUE);
                IF QuantityDiscountEntry.FIND('-')THEN BEGIN
                  AqdText :='AQD DISCOUNT';
                  AQD+=QuantityDiscountEntry."QD Given Amount";
                END ELSE BEGIN
                 AqdText :=''
                END;
                END; */
                //MS-PB END;

                /*
               //MS-PB BEGIN Before any chang please take a look on above commented code.

               QD:=0;
               QuantityDiscountEntry.RESET;
               QuantityDiscountEntry.SETRANGE("Posted Document No.","No.");
               QuantityDiscountEntry.SETRANGE("Accrued Entry",FALSE);
               QuantityDiscountEntry.SETFILTER("QD Given Amount",'<>%1',0);
               IF QuantityDiscountEntry.FIND('-')THEN BEGIN
                 QdText :='QD DISCOUNT';
                 QD+=QuantityDiscountEntry."QD Given Amount";
               END;


               AQD:=0;
                 AqdText :='';
               QuantityDiscountEntry.RESET;
               QuantityDiscountEntry.SETRANGE("Posted Document No.","No.");
               QuantityDiscountEntry.SETFILTER("QD Given Amount",'<>%1',0);
               QuantityDiscountEntry.SETRANGE("Accrued Entry",TRUE);
               IF QuantityDiscountEntry.FIND('-')THEN BEGIN
                 AqdText :='AQD DISCOUNT';
                 AQD+=QuantityDiscountEntry."QD Given Amount";
               END ELSE BEGIN
                AqdText :=''
               END;
               //MS-PB END;
               */


                IF "Transfer Shipment Header"."Transfer-from State" = '14' THEN
                    KText := 'The Kerala Value Added Tax Rules - 2005, TAX INVOICE FORM NO 8'
                ELSE
                    KText := '';


                IF Location.GET("Transfer-from State") THEN BEGIN
                    Address := Location.Address + Location."Address 2" + ' ' + Location.City;
                    Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                    Fax := Location."Fax No.";
                END;

                //CurrReport.SHOWOUTPUT(FALSE);

                //TRI N.K 22.02.08 Add Start
                GroupCode.SETRANGE(GroupCode."Group Code", "Transfer Shipment Header"."Group Code");
                IF GroupCode.FIND('-') THEN
                    //TRI N.K 22.02.08 Add Stop


                    //MS-PB BEGIN
                    Location.RESET;
                Location.SETRANGE(Code, "Transfer-to State");
                IF Location.FINDFIRST THEN
                    //HeaderTextLatest:=DocumentPrint.PrintInvoiceType("Transfer Shipment Header","Transfer-to State");  //rks
                    IF HeaderTextLatest = 'VAT/TAX Invoice' THEN
                        Taxstat := 'Input Tax Credit Available On this Invoice Only';

                //MS-PB END;
                /*
                IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                  LST := Customer."L.S.T. No.";
                  CST := Customer."C.S.T. No.";
                  CustomerTINNo := Customer."T.I.N. No.";
                END;
                */
                sno := 0;

                //IF CompanyInfo.GET THEN                           //Anurag
                //  "TINNo." := CompanyInfo."T.I.N. No.";           //Anurag
                //16225 Table N/F Start
                /*  IF tin_no1.GET(Location."T.I.N. No.") THEN          //Anurag
                      "TINNo." := tin_no1.Description;                  //Anurag

                  //TRI RK 21.04.10 Add Start
                  DetailedTaxEntry.RESET;
                  DetailedTaxEntry.SETRANGE("Document No.", "Transfer Shipment Header"."No.");
                  IF DetailedTaxEntry.FINDFIRST THEN
                      REPEAT
                          DetailedTaxEntry.CALCFIELDS("Additional Tax");
                          IF DetailedTaxEntry."Tax Type" = DetailedTaxEntry."Tax Type"::CST THEN BEGIN
                              IF NOT DetailedTaxEntry."Additional Tax" THEN BEGIN
                                  CstTot := CstTot + (-DetailedTaxEntry."Tax Amount");
                                  CstPercent := DetailedTaxEntry."Tax %";
                                  tgcstper := FORMAT(CstPercent) + '  %';
                              END ELSE BEGIN
                                  AdditionalTot := AdditionalTot + (-DetailedTaxEntry."Tax Amount");
                                  AdditionalPercent := DetailedTaxEntry."Tax %";
                                  tgaddPer := FORMAT(AdditionalPercent) + '  %';
                              END;
                          END;

                          IF DetailedTaxEntry."Tax Type" = DetailedTaxEntry."Tax Type"::VAT THEN BEGIN
                              IF NOT DetailedTaxEntry."Additional Tax" THEN BEGIN
                                  VatTot := VatTot + (-DetailedTaxEntry."Tax Amount");
                                  VatPercent := DetailedTaxEntry."Tax %";
                                  tgvatper := FORMAT(VatPercent) + '  %';
                              END ELSE BEGIN
                                  AdditionalTot := AdditionalTot + (-DetailedTaxEntry."Tax Amount");
                                  AdditionalPercent := DetailedTaxEntry."Tax %";
                                  tgaddPer := FORMAT(AdditionalPercent) + '  %';
                              END;
                          END;

                      UNTIL DetailedTaxEntry.NEXT = 0;*///16225 Table N/F End
                                                        //TRI RK 21.04.10 Add End

                IF Location.GET("Transfer-to State") THEN BEGIN
                    Address := Location.Address + Location."Address 2" + ' ' + Location.City;
                    Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                    Fax := Location."Fax No.";
                END;

                //IF CustRec.GET("Transfer Shipment Header"."Sell-to Customer No.") THEN;
                //CustRec.CALCFIELDS(Balance);                                                   //rks
                //OutBal := CustRec.Balance;
                /*
                IF StateRec.GET(CustRec."State Code") THEN;
                CustomerStateDes := StateRec.Description+','+CustRec.City;
                CustomerStateDes1:= StateRec.Description;
                IF Shipto.GET("Transfer Shipment Header"."Ship-to Code") THEN;
                IF StateRec.GET(Shipto.State) THEN;
                ShippiStateDes := StateRec.Description;
                */
                //MSVRN 290517 >>
                TotalAssessVal := 0;
                recSIL.RESET;
                recSIL.SETRANGE("Document No.", "No.");
                IF recSIL.FINDFIRST THEN
                    REPEAT
                        //16225  TotalAssessVal += recSIL."Assessable Value" * recSIL.Quantity;
                        TotalAssessVal += recSIL."GST Assessable Value (LCY)" * recSIL.Quantity;
                    UNTIL recSIL.NEXT = 0;
                //
                // Sum(Fields!Assekbs.Value*12.5/100)
                //
                //dheeru
                Discount := 0;
                //16225 Table N/F Start
                /*  PostedStrOrderLDetails.RESET;
                  PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                  PostedStrOrderLDetails.SETRANGE("Invoice No.", "No.");
                  PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
                  IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                      REPEAT
                          Discount += PostedStrOrderLDetails.Amount;
                      UNTIL PostedStrOrderLDetails.NEXT = 0;
                  END;*///16225 Table N/F END


                //dheeru


                Check1.InitTextVariable();
                Check1.FormatNoText(AssessValText, ROUND(TotalAssessVal * 12.5 / 100, 0.01), '');
                //MSVRN 290517 <<

                ////vendor.RESET;
                // vendor.GET("vendor code") THEN;

            end;

            trigger OnPreDataItem()
            begin

                CurrReport.CREATETOTALS(AQD, QD);
                // Numb:="Transfer Shipment Header".GETFILTER("No.");

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(NoOfCopies; NoOfCopies)
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

        /*n:=0;
        
        IF NOT ("Transfer Shipment Header"."Invoice Mailed") THEN
        BEGIN
        IF SaveAsPDF THEN BEGIN
         IF ISCLEAR(PDFCreator) THEN
         CREATE(PDFCreator);
         IF ISCLEAR(PDFCreatorError) THEN
         CREATE(PDFCreatorError);
        
         ReportID := REPORT::"Depot Tax Invoice";
        
         FileDir := 'C:\mail\';
         FilNam:=DELCHR("Transfer Shipment Header"."No.",'=','/');
         FileName := FilNam+'.pdf';
        
         //FileName:="Transfer Shipment Header"."Sell-to Customer No."+'.pdf';
         PDFCreatorError := PDFCreator.cError;
         IF PDFCreator.cStart('/NoProcessingAtStartup',TRUE) = FALSE THEN
          ERROR('Status: Error[' + FORMAT(PDFCreatorError.Number) + ']: ' + PDFCreatorError.Description);
        
         PDFCreatorOption := PDFCreator.cOptions;
        
        
         PDFCreatorOption.UseAutosave := 1;
         PDFCreatorOption.UseAutosaveDirectory := 1;
         PDFCreatorOption.AutosaveDirectory := FileDir;
         PDFCreatorOption.AutosaveFormat := 0;
         PDFCreatorOption.AutosaveFilename := FileName;
         PDFCreator.cOptions := PDFCreatorOption;
         PDFCreator.cClearCache();
         DefaultPrinter := PDFCreator.cDefaultPrinter;
         PDFCreator.cDefaultPrinter := 'PDFCreator';
         PDFCreator.cPrinterStop := FALSE;
        
         SIH.RESET;
         SIH.SETRANGE("No.",Numb);
         IF SIH.FINDFIRST THEN
         REPORT.RUNMODAL(REPORT::"Depot Tax Invoice",FALSE,FALSE,SIH);
        
         SLEEP(2000);
        
         mycust.RESET;
         mycust.SETRANGE(mycust."No.","Transfer Shipment Header"."Sell-to Customer No.");
         mycust.SETFILTER(mycust."E-Mail",'<>%1','');
        
         IF mycust.FIND('-') THEN BEGIN
          mycust.TESTFIELD(mycust."E-Mail");
        
          SMTPMail.CreateMessage('Orient Bell Limited.','admndelhi@orienttiles.com',mycust."E-Mail",'Depot Tax Invoice'
           ,'',TRUE);
        
        
         SMTPMail.AppendBody(Text50000);
         SMTPMail.AppendBody(Text50001);
         SMTPMail.AppendBody(Numb);
         SMTPMail.AppendBody(Text50002);
         SMTPMail.AppendBody(Text50003);
         SMTPMail.AppendBody(Text50010);
         SMTPMail.AppendBody(Text50004);
         SMTPMail.AppendBody(Text50005);
         SMTPMail.AppendBody(Text50006);
         SMTPMail.AppendBody(Text50007);
         SMTPMail.AppendBody(Text50008);
         SMTPMail.AppendBody(Text50009);
         SMTPMail.AddAttachment('C:\mail\'+FileName);
         SMTPMail.Send;
        
        
         SIH.RESET;
         SIH.SETRANGE("No.",Numb);
         IF SIH.FINDFIRST THEN BEGIN
          SIH."Invoice Mailed":=TRUE;
          SIH.MODIFY;
         END;
        
         END;
        END;
        END;
         */
        //RepAuditMgt.CreateAudit(50000)

    end;

    var
        check: Report Check;
        ExciseInWord: array[2] of Text[250];
        Customer: Record Customer;
        RateperCart: Decimal;
        DiscPerCart: Decimal;
        Item: Record Item;
        Value: Decimal;
        SubTotal: Decimal;
        Taxtotal: Decimal;
        Netamt: Decimal;
        Location: Record Location;
        Address: Text[250];
        Ph: Text[100];
        Fax: Text[100];
        OurTIN: Code[50];
        CheckReport: Report Check;
        NoText: array[2] of Text[80];
        ExciseAmt: Decimal;
        NoTextExcise: array[2] of Text[80];
        LST: Code[100];
        CST: Code[100];
        CustomerTINNo: Text[30];
        ChargeAmt: Decimal;
        SalesTaxAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        InsuranceAmt: Decimal;
        BEDAmt: Decimal;
        ECessAmt: Decimal;
        FormCode: Text[50];
        FormNo: Text[50];
        //16225 FormCodes: Record "13756";
        ExciseLabel: array[2] of Text[50];
        ExciseText: array[2] of Decimal;
        sno: Integer;
        GenLegSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        "TINNo.": Text[30];
        TypeName: Text[50];
        SizeName: Text[50];
        PackingName: Text[50];
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        WorkAddress: Text[250];
        PhoneNo: Integer;
        Cart: Decimal;
        Sqmt: Decimal;
        Wt: Decimal;
        DiscPerSqmt: Decimal;
        BuyersPrice: Decimal;
        BuyersRatePerSqMtr: Decimal;
        //16225 tin_no1: Record "13701";
        i: Integer;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        SalesInvLine1: Record "Sales Invoice Line";
        tgVat: Decimal;
        Pcs: Decimal;
        GroupCode: Record "Item Group";
        ItemType: Record Item;
        TypeCatogeryCode: Code[10];
        TypeDesc: Text[30];
        InvDisc: Decimal;
        InsDisc: Decimal;
        DecSubtotal: Decimal;
        "---------TRI------": Integer;
        //16225 DetailedTaxEntry: Record "16522";
        CstTot: Decimal;
        AdditionalTot: Decimal;
        VatTot: Decimal;
        VatPercent: Decimal;
        AdditionalPercent: Decimal;
        CstPercent: Decimal;
        tgvatper: Text[30];
        tgaddPer: Text[30];
        tgcstper: Text[30];
        Outstand: Decimal;
        CompanyName2: Text[100];
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        QD: Decimal;
        AQD: Decimal;
        LineDis: Decimal;
        DecRate: Decimal;
        AqdText: Text[30];
        QdText: Text[30];
        KText: Text[100];
        DocumentPrint: Codeunit "Document-Print";
        HeaderTextLatest: Text[100];
        Rounoff: Decimal;
        "---------": Integer;
        FileDir: Text[100];
        FileName: Text[100];
        ReportID: Integer;
        //16225   "Object": Record Object;
        DefaultPrinter: Text[200];
        Window: Dialog;
        WindowisOpen: Boolean;
        mycust: Record Customer;
        mymail: Codeunit Mail;
        testFile: Boolean;
        SIH: Record "Sales Invoice Header";
        Numb: Code[20];
        SaveAsPDF: Boolean;
        //16225 SMTPMail: Codeunit 400;
        n: Integer;
        chrLineBreak: Char;
        FilNam: Text[30];
        QcText: Text[30];
        Taxstat: Text[100];
        isvat: Boolean;
        Policy: Text[500];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text50000: Label 'Dear Customer, <br/> <br/> ';
        Text50001: Label 'Enclosed please find the computer generated invoice :';
        Text50002: Label ' against the order placed by you. <br/> <br/> ';
        Text50003: Label 'This is for your records. Kindly acknowledge the receipt.';
        Text50004: Label 'Regards, <br/> <br/> ';
        Text50005: Label 'Orient Bell Ltd. <br/> <br/> ';
        Text50006: Label 'Iris House, 16 Business Center, Nangal Raya <br/> <br/> ';
        Text50007: Label 'New Delhi 110046, India<br/> <br/> ';
        Text50008: Label 'Tel:   +91 11 4711 9100<br/> <br/> ';
        Text50009: Label 'Fax:  +91 11 2852 1273<br/> <br/> ';
        Text50010: Label ' <br/> <br/> ';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with United India Insurance Co. Ltd., Rohtak"';
        LastLineSIL: Boolean;
        LastLineStrOrDet: Boolean;
        Sno1: Integer;
        Sno2: Integer;
        CurrCode: Text[50];
        CustRec: Record Customer;
        StateRec: Record State;
        CustomerStateDes: Text[50];
        ShippiStateDes: Text[50];
        CustomerStateDes1: Text[30];
        Shipto: Record "Ship-to Address";
        OutBal: Decimal;
        recSIL: Record "Sales Invoice Line";
        TotalAssessVal: Decimal;
        Check1: Report Check;
        AssessValText: array[2] of Text[1024];
        Text13706: Label 'Assesable Value is calculated @ 55% of MRP';
        vendor: Record Vendor;
        RecState: Record State;
        Sate: Code[50];
        StateCode: Code[50];
        StateName: Text[50];
        Ball: Decimal;
        Discount: Decimal;
        //16225   PostedStrOrderLDetails: Record "13798";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        TotalGSTAmt: Decimal;
        GSTTotal: Decimal;
        CAmount1: Decimal;
        SAmount1: Decimal;
        IAmount1: Decimal;
        TotalGSTAmount: Decimal;
        OutputNo: Integer;
        CopyText: Text[30];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        Count1: Integer;
}

