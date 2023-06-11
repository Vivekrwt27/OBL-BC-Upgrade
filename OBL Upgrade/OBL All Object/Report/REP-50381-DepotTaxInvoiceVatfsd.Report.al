report 50381 "Depot Tax Invoice Vat fsd"
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
    RDLCLayout = '.\ReportLayouts\DepotTaxInvoiceVatfsd.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(vendor_Name; vendor.Name)
            {
            }
            column(vendor_Address; vendor.Address)
            {
            }
            column(vendor_Address2; vendor."Address 2")
            {
            }
            //16225 column(vendor_TINNo; vendor."T.I.N. No.")
            column(vendor_TINNo; vendor."Tax Code")
            {
            }
            column(vendor_PANNo; vendor."P.A.N. No.")
            {
            }
            column(vendor_City; vendor.City)
            {
            }
            //16225  column(vendor_ECCNo; vendor."E.C.C. No.")
            column(vendor_ECCNo; '')
            {
            }
            //16225 column(vendor_Range; vendor.Range)
            column(vendor_Range; '')
            {
            }
            //16225 column(vendor_Collec; vendor.Collectorate)
            column(vendor_Collec; '')
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
            column(CustTIN; Customer."TIN Date")
            {
            }
            column(TINNoSIH; "Sales Invoice Header"."Tin No.")
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(Address; Address)
            {
            }
            column(SIH_PostingDate; "Sales Invoice Header"."Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
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
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name 2")
            {
            }
            column(SelltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Address")
            {
            }
            column(SelltoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Address 2")
            {
            }
            column(SelltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(BilltoPostCode_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Post Code")
            {
            }
            column(SelltoPostCode_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Post Code")
            {
            }
            column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
            {
            }
            column(OrderDate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
            {
            }
            column(PONo_SalesInvoiceHeader; "Sales Invoice Header"."PO No.")
            {
            }
            column(TransportersName_SalesInvoiceHeader; "Sales Invoice Header"."Transporter Name")
            {
            }
            column(GRNo_SalesInvoiceHeader; "Sales Invoice Header"."GR No.")
            {
            }
            column(TruckNo_SalesInvoiceHeader; "Sales Invoice Header"."Truck No.")
            {
            }
            column(GRDate_SalesInvoiceHeader; "Sales Invoice Header"."GR Date")
            {
            }
            column(ShiptoName; "Sales Invoice Header"."Ship-to Name 2")
            {
            }
            column(ShipAdd; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShipAdd2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShipContact; "Sales Invoice Header"."Ship-to Contact")
            {
            }
            column(ShiptoCity; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShipPhone; 'Phone No.' + "Sales Invoice Header"."Ship to Phone No.")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(PoNo; "Sales Invoice Header"."PO No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(TINNo; "TINNo.")
            {
            }
            column(LocCST; Location."C.S.T. No.")
            {
            }
            column(TinNo_SalesInvoiceHeader; "Sales Invoice Header"."Tin No.")
            {
            }
            //16225 column(CSTNo; Customer."C.S.T. No.")
            column(CSTNo; Customer."CTS 1")
            {
            }
            column(GrNo; "Sales Invoice Header"."GR No.")
            {
            }
            column(GRDate; "Sales Invoice Header"."GR Date")
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
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(ExciseInWord; ExciseInWord[1])
                {
                }
                //16225   column(SalesInvoiceLine_ExciseAmount; ROUND("Excise Amount"))
                column(SalesInvoiceLine_ExciseAmount; ROUND("Amount"))
                {
                }
                column(Text13706; FORMAT(Text13706))
                {
                }
                column(Item_Tariff; Item.Tariff)
                {
                }
                column(Cart; Cart)
                {
                }
                column(sno; sno)
                {
                }
                column(Description_SalesInvoiceLine; "Sales Invoice Line".Description + ' ' + "Sales Invoice Line"."Description 2")
                {
                }
                column(Description2_SalesInvoiceLine; "Sales Invoice Line"."Description 2")
                {
                }
                column(TypeDesc; TypeDesc)
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure Code")
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
                //16225   column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line"."Amount To Customer")
                column(AmountToCustomer_SalesInvoiceLine; GetAmttoCustomerPostedLine("Document No.", "Line No."))
                {
                }
                //   column(BEDAmt; "Sales Invoice Line"."BED Amount")
                column(BEDAmt; "Sales Invoice Line"."VAT Base Amount")
                {
                }
                //16225   column(AssessValue; "Sales Invoice Line"."Assessable Value")
                column(AssessValue; "Sales Invoice Line"."VAT Base Amount")
                {
                }
                //   column(Assekbs; "Sales Invoice Line"."Assessable Value" * "Sales Invoice Line".Quantity)
                column(Assekbs; '')
                {
                }
                column(Remarks; "Sales Invoice Line".Remarks)
                {
                }
                //   column(ExcisUnitrate; "Sales Invoice Line"."Assessable Value" * 12.5 / 100)
                column(ExcisUnitrate; "Sales Invoice Line".Amount * 12.5 / 100)
                {
                }
                column(rgno; "Sales Invoice Line"."RG No.")
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
                    Sno1 += 1;

                    //RKS 020617
                    Item.RESET;
                    IF Item.GET("Sales Invoice Line"."No.") THEN;
                    //RKS 020617

                    Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                    Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                    //16225   Pcs := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<') - ROUND("Sales Invoice Line"."Amount To Customer", 1, '=');
                    Pcs := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<') - ROUND("Sales Invoice Line"."Amount", 1, '=');
                    //Rounoff:=("Sales Invoice Line"."Amount To Customer");
                    Wt := "Sales Invoice Line"."Gross Weight";
                    //MSBS.Rao Begin Dt. 07-06-12
                    QD += "Quantity Discount Amount" - "Accrued Discount";
                    IF QD <> 0 THEN
                        QdText := 'BR DISCOUNT';
                    AQD += "Accrued Discount";
                    IF AQD <> 0 THEN
                        AqdText := 'ABR DISCOUNT';
                    //MSBS.Rao End Dt. 07-06-12


                    //IF Cart <> 0 THEN
                    //  RateperCart := "Unit Price"*Quantity/Cart;

                    //IF Cart <> 0 THEN
                    //  DiscPerCart := "Line Discount Amount"/Cart;
                    //Value := Cart * (RateperCart - DiscPerCart);

                    IF Quantity <> 0 THEN;
                    //16225 BuyersPrice := (Amount + "Excise Amount") / Quantity;

                    IF "Quantity in Sq. Mt." <> 0 THEN BEGIN
                        DecRate := ("Quantity Discount Amount" / "Quantity in Sq. Mt.");
                        LineDis := ("Line Discount Amount" / "Quantity in Sq. Mt.");
                    END;


                    IF Sqmt <> 0 THEN BEGIN
                        BuyersRatePerSqMtr := (BuyersPrice * Quantity / Sqmt) + DecRate;
                        DiscPerSqmt := "Line Discount Amount" / Sqmt;
                    END;

                    //Value := Amount + "Excise Amount";
                    Value := (BuyersRatePerSqMtr * "Quantity in Sq. Mt.");


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
                    ItemType.SETRANGE(ItemType."No.", "Sales Invoice Line"."No.");
                    IF ItemType.FIND('-') THEN
                        //TRI 22.02.08 N.K Add Stop

                        //TRI NM 170308 Add Start
                        DimensionValue.RESET;
                    DimensionValue.SETFILTER("Dimension Code", '=%1', 'CATG');
                    DimensionValue.SETRANGE(Code, "Type Catogery Code");
                    IF DimensionValue.FINDFIRST THEN
                        TypeDesc := DimensionValue.Name;
                    //TRI NM 170308 Add Stop
                    //MESSAGE('%1',("Sales Invoice Line"."Amount To Customer"));


                    /* ExciseAmt := "Sales Invoice Line"."Excise Amount";
                     BEDAmt := "Sales Invoice Line"."BED Amount";
                     ECessAmt := "Sales Invoice Line"."eCess Amount";
                     SubTotal += Value; //tri*/

                    check.InitTextVariable();
                    check.FormatNoText(ExciseInWord, ROUND(ExciseAmt, 1), '');
                end;

                trigger OnPreDataItem()
                begin

                    CurrReport.CREATETOTALS(Value, Cart, Sqmt, Wt);
                    CurrReport.CREATETOTALS(Pcs); //-- 2. Tri30.0 PG 14112006
                    CurrReport.CREATETOTALS("Sales Invoice Line"."Amount");
                    CLEAR(Sno1);
                end;
            }
            //16225 DataItem Table N/F Start
            /* dataitem(DataItem1000000002; Table13798)
             {
                 DataItemLink = Invoice No.=FIELD(No.);
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
                                     "Charge Type"::" ", "Charge Type"::Freight, "Charge Type"::Commission:*///16225 End
                                                                                                             /*IF ("Tax/Charge Group" <> GenLegSetup."Discount Charge") THEN
                                                                                                               ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;*/
                                                                                                             //16225 start
                                                                                                             /*IF ("Tax/Charge Group" <> GenLegSetup."Discount Charge") AND
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
                                                                                         END;*/ //16225 End

            //sash
            /*  IF InsDisc = 0 THEN
                  QcText := ''
              ELSE
                  QcText := 'Qc Discount';*/


            // IF Sno2 = "Posted Str Order Line Details".COUNT THEN BEGIN
            /*
            DetailedTaxEntry.RESET;
            DetailedTaxEntry.SETRANGE("Document No.","Sales Invoice Header"."No.");
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
            // END;

            // end;

            /*   trigger OnPreDataItem()
             begin

                  IF "Sales Invoice Header"."Free Supply" = FALSE THEN BEGIN
                      ExciseText[1] := ExciseAmt;
                      ExciseLabel[1] := 'Excise';
                      Taxtotal := Amount;
                      ExciseText[2] := 0;
                      ExciseLabel[2] := '';
                  END ELSE BEGIN
                      ExciseText[2] := ExciseAmt;
                      ExciseLabel[2] := 'Excise';
                      Taxtotal := Amount - ExciseAmt;
                      ExciseText[1] := 0;
                      ExciseLabel[1] := '';
                  END;

                  FOR i := 1 TO 3 DO BEGIN
                      JudText[i] := '';
                      PerJud[i] := 0;
                  END;
                  i := 0;
                  SalesInvLine1.RESET;
                  SalesInvLine1.SETFILTER(SalesInvLine1."Document No.", '%1', "Sales Invoice Header"."No.");
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
                              TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                              TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                              IF TaxDetails.FIND('+') THEN
                                  IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                      JudText[i] := TaxDetails."Tax Jurisdiction Code";
                                      PerJud[i] := TaxDetails."Tax Below Maximum";
                                  END;
                          UNTIL TaxAreaLine.NEXT = 0;
                  END;

                  SalesInvLine1.RESET;
                  SalesInvLine1.SETFILTER(SalesInvLine1."Document No.", '%1', "Sales Invoice Header"."No.");
                  IF SalesInvLine1.FIND('-') THEN
                      tgVat := SalesInvLine1."VAT %";

                  IF InsuranceAmt <> 0 THEN
                      Policy := NewPolicy
                  ELSE
                      Policy := '';
                  CLEAR(Sno2);
              end;
          }*/

            trigger OnAfterGetRecord()
            begin
                /*  IF "Sales Invoice Header"."Currency Code" <> '' THEN
                      CurrCode := "Sales Invoice Header"."Currency Code" + ' Only'
                  ELSE
                      CurrCode := 'Rupees and Zero Paisa Only';

                  CALCFIELDS("Amount to Customer");
                  Rounoff := (ROUND("Amount to Customer", 1) - "Amount to Customer");
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
                  InsuranceAmt := 0;
                  IF FormCodes.GET("Form Code") THEN BEGIN
                      FormCode := 'Against ' + FormCodes.Description;
                      FormNo := 'Form No. ' + "Form No.";*/
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
            END; //ELSE
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


            /* IF "Sales Invoice Header".State = '14' THEN
                 KText := 'The Kerala Value Added Tax Rules - 2005, TAX INVOICE FORM NO 8'
             ELSE
                 KText := '';


             IF Location.GET("Location Code") THEN BEGIN
                 Address := Location.Address + Location."Address 2" + ' ' + Location.City;
                 Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                 Fax := Location."Fax No.";
             END;

             //CurrReport.SHOWOUTPUT(FALSE);

             //TRI N.K 22.02.08 Add Start
             GroupCode.SETRANGE(GroupCode."Group Code", "Sales Invoice Header"."Group Code");
             IF GroupCode.FIND('-') THEN;
                 //TRI N.K 22.02.08 Add Stop


                 //MS-PB BEGIN
                 Location.RESET;
             Location.SETRANGE(Code, "Location Code");
             IF Location.FINDFIRST THEN
                 HeaderTextLatest := DocumentPrint.PrintInvoiceType("Sales Invoice Header", Location);
             IF HeaderTextLatest = 'VAT/TAX Invoice' THEN
                 Taxstat := 'Input Tax Credit Available On this Invoice Only';

             //MS-PB END;

             IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                 LST := Customer."L.S.T. No.";
                 CST := Customer."C.S.T. No.";
                 CustomerTINNo := Customer."T.I.N. No.";
             END;
             sno := 0;

             //IF CompanyInfo.GET THEN                           //Anurag
             //  "TINNo." := CompanyInfo."T.I.N. No.";           //Anurag
             IF tin_no1.GET(Location."T.I.N. No.") THEN          //Anurag
                 "TINNo." := tin_no1.Description;                  //Anurag

             //TRI RK 21.04.10 Add Start
             DetailedTaxEntry.RESET;
             DetailedTaxEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
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

                 UNTIL DetailedTaxEntry.NEXT = 0;
             //TRI RK 21.04.10 Add End

             IF Location.GET("Location Code") THEN BEGIN
                 Address := Location.Address + Location."Address 2" + ' ' + Location.City;
                 Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                 Fax := Location."Fax No.";
             END;

             IF CustRec.GET("Sales Invoice Header"."Sell-to Customer No.") THEN;
             CustRec.CALCFIELDS(Balance);
             OutBal := CustRec.Balance;
             IF StateRec.GET(CustRec."State Code") THEN;
             CustomerStateDes := StateRec.Description;
             IF Shipto.GET("Sales Invoice Header"."Ship-to Code") THEN;
             IF StateRec.GET(Shipto.State) THEN;
             ShippiStateDes := StateRec.Description;

             //MSVRN 290517 >>
             TotalAssessVal := 0;
             recSIL.RESET;
             recSIL.SETRANGE("Document No.", "No.");
             IF recSIL.FINDFIRST THEN
                 REPEAT
                     TotalAssessVal += recSIL."Assessable Value" * recSIL.Quantity;
                 UNTIL recSIL.NEXT = 0;
             //
             // Sum(Fields!Assekbs.Value*12.5/100)
             //


             Check1.InitTextVariable();
             Check1.FormatNoText(AssessValText, ROUND(TotalAssessVal * 12.5 / 100, 0.01), '');
             //MSVRN 290517 <<

             vendor.RESET;
             IF vendor.GET("vendor code") THEN;

         end;

         trigger OnPreDataItem()
         begin

             CurrReport.CREATETOTALS(AQD, QD);
             // Numb:="Sales Invoice Header".GETFILTER("No.");

             CompanyInfo.GET;
             CompanyName1 := CompanyInfo.Name;
             CompanyName2 := CompanyInfo."Name 2";
         end;*///16225 DataItem Table N/F End
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

    trigger OnPostReport()
    begin

        /*n:=0;
        
        IF NOT ("Sales Invoice Header"."Invoice Mailed") THEN
        BEGIN
        IF SaveAsPDF THEN BEGIN
         IF ISCLEAR(PDFCreator) THEN
         CREATE(PDFCreator);
         IF ISCLEAR(PDFCreatorError) THEN
         CREATE(PDFCreatorError);
        
         ReportID := REPORT::"Depot Tax Invoice";
        
         FileDir := 'C:\mail\';
         FilNam:=DELCHR("Sales Invoice Header"."No.",'=','/');
         FileName := FilNam+'.pdf';
        
         //FileName:="Sales Invoice Header"."Sell-to Customer No."+'.pdf';
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
         mycust.SETRANGE(mycust."No.","Sales Invoice Header"."Sell-to Customer No.");
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
        //16225  FormCodes: Record "13756";
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
        //16225  tin_no1: Record "13701";
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
        // "Object": Record Object;
        DefaultPrinter: Text[200];
        Window: Dialog;
        WindowisOpen: Boolean;
        mycust: Record Customer;
        mymail: Codeunit Mail;
        testFile: Boolean;
        SIH: Record "Sales Invoice Header";
        Numb: Code[20];
        SaveAsPDF: Boolean;
        //16225  SMTPMail: Codeunit 400;
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
        CustomerStateDes: Text[20];
        ShippiStateDes: Text[20];
        Shipto: Record "Ship-to Address";
        OutBal: Decimal;
        recSIL: Record "Sales Invoice Line";
        TotalAssessVal: Decimal;
        Check1: Report Check;
        AssessValText: array[2] of Text[1024];
        Text13706: Label 'Assesable Value is calculated @ 55% of MRP';
        vendor: Record Vendor;

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

