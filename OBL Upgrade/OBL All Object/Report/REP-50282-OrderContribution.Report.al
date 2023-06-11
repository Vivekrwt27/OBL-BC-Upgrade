report 50282 "Order Contribution"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\OrderContribution.rdl';
    Caption = 'Order Contribution';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(c_name; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(City; "Sales Header"."Sell-to City")
            {
            }
            column(TruckNo_SalesHeader; "Sales Header"."Truck No.")
            {
            }
            column(pay; "Sales Header".Pay)
            {
            }
            column(Order_no; "Sales Header"."No.")
            {
            }
            column(TransportersName_SalesHeader; "Sales Header"."Transporter's Name")
            {
            }
            //16225   column(TINNoCust; CustRec."T.I.N. No.")
            column(TINNoCust; '')
            {
            }
            column(CustType; CustRec."Customer Type")
            {
            }
            column(CST; CST)
            {
            }
            column(OrderDate_SalesHeader; "Sales Header"."Order Date")
            {
            }
            column(GSTNO_LOC; Location."GST Registration No.")
            {
            }
            column(LocaTINNo; LocaTINNo)
            {
            }
            column(STATE_CODE; State1."State Code (GST Reg. No.)")
            {
            }
            column(CustomerStateDes; CustomerStateDes)
            {
            }
            column(Customer_GSTNO; CustRec."GST Registration No.")
            {
            }
            column(DocumentType_SalesHeader; "Document Type")
            {
            }
            column(DiscChargeRate; FORMAT("Sales Header"."Discount Charges %"))
            {
            }
            column(PayTermCode; "Sales Header"."Payment Terms Code")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(VATPercentCaption; VATPercentCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(LineAmtCaption; LineAmtCaptionLbl)
            {
            }
            column(VATIdentCaption; VATIdentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
            }
            column(TradeDiscount_SalesHeader; "Sales Header"."Trade Discount")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(SalesPersonCode; "Sales Header"."Salesperson Code")
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentCaptionCopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; Location.Name)
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; Location.Address)
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; Location."Address 2")
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; Location.City + State1.Description)
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; Location."Phone No.")
                    {
                    }
                    column(FaxNo; Location."Fax No.")
                    {
                    }
                    column(PostCode; Location."Post Code")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDescription; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    //16225 column(TinNo; CompanyInfo."T.I.N. No.")
                    column(TinNo; '')
                    {
                    }
                    column(BillToCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = false;
                    }
                    column(DocumentDate_SalesHeader; FORMAT("Sales Header"."Document Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesHeader; "Sales Header"."Your Reference")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PricesInclVAT_SalesHeader; "Sales Header"."Prices Including VAT")
                    {
                        IncludeCaption = false;
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo; FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(BillToCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(HomePageCaption; HomePageCaptionCap)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ShpDateCaption; ShpDateCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(EMailCaption; EMailCaptionLbl)
                    {
                    }
                    column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
                    {
                    }
                    column(ShipMethodDescCaption; ShipMethodDescCaptionLbl)
                    {
                    }
                    column(PrepmtTermsDescCaption; PrepmtTermsDescCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(AmtCaption; AmtCaptionLbl)
                    {
                    }
                    column(Pay_; "Sales Header".Pay)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_Integer; DimensionLoop1.Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DimSetEntry1.NEXT = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnAfterGetRecord()
                        var
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
                        begin
                            Clear(sgst);
                            Clear(igst);
                            Clear(cgst);
                            Clear(TotalAmt);
                            ReccSalesLine.Reset();
                            ReccSalesLine.SetRange("Document Type", "Sales Line"."Document Type");
                            ReccSalesLine.SetRange("Document No.", "Sales Line"."Document No.");
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

                            LineDiscountAmt += "Line Discount Amount";
                            AmttoCust += "Sales Line"."Line Amount" + sgst + cgst + igst;


                            IF item.GET("No.") THEN;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(BilPrice; GrndTotal)
                        {
                        }
                        column(TotalVCost; TotalVCost)
                        {
                        }
                        column(VCost1; recItem."V. Cost" * SqMt)
                        {
                        }
                        column(Manuf_sta; recItem."Manuf. Strategy")
                        {
                        }
                        column(Item_class; recItem."Item Classification")
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
                        column(URate; URate)
                        {
                        }
                        column(UAmount; UAmount)
                        {
                        }
                        column(TotalQd; TotalQd)
                        {
                        }
                        column(DisPerSqMt; SalesLine."Discount Per SQ.MT")
                        {
                        }
                        column(LineDiscountAmt; "Sales Line"."Line Discount Amount")
                        {
                        }
                        column(Disc; "Sales Line".D7)
                        {
                        }
                        column(Price_sqmt; "Sales Line"."Unit Price Excl. VAT/Sq.Mt" - "Sales Line".D7)
                        {
                        }
                        column(BuyersRatePerSqMtr; BuyersRatePerSqMtr)
                        {
                        }
                        column(Billingprice; ("Sales Line"."Unit Price Excl. VAT/Sq.Mt" - "Sales Line".D7) * SqMt)
                        {
                        }
                        //16225 column(MRP; SalesLine."MRP Price")
                        column(MRP; 0)
                        {
                        }
                        //16225  column(LineExciseAmt; SalesLine."Excise Amount")
                        column(LineExciseAmt; 0)
                        {
                        }
                        column(Location; "Sales Line"."Location Code")
                        {
                        }
                        column(ExciseAmount; ExciseAmount)
                        {
                        }
                        column(InvDisc; ABS(InvDisc))
                        {
                        }
                        column(AddInvDisSUMAddInsuDisc; ABS(AddInvDisc + AddInsuDisc))
                        {
                        }
                        column(Charges; Charges)
                        {
                        }
                        column(CstTots; CstTot)
                        {
                        }
                        column(ServiceTax; ServiceTax)
                        {
                        }
                        column(VatTot; VatTot)
                        {
                        }
                        column(AdditionalTot; AdditionalTot)
                        {
                        }
                        column(AmttoCust; AmttoCust)
                        {
                        }
                        column(Othertaxes; Othertaxes)
                        {
                        }
                        column(AQD; "Sales Line"."Accrued Discount")
                        {
                        }
                        column(SalesLineLineAmount; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Description_SalesLine; "Sales Line".Description + "Sales Line"."Description 2")
                        {
                        }
                        column(NNCSalesLineInvDiscAmt; NNC_SalesLineInvDiscAmt)
                        {
                        }
                        column(NNCSalesLineLineAmt; NNC_SalesLineLineAmt)
                        {
                        }
                        column(NNCTotalLCY; NNC_TotalLCY)
                        {
                        }
                        column(NNCVATAmt; NNC_VATAmt)
                        {
                        }
                        column(NNCPmtDiscOnVAT; NNC_PmtDiscOnVAT)
                        {
                        }
                        column(NNCTotalInclVAT2; NNC_TotalInclVAT2)
                        {
                        }
                        column(NNCVatAmt2; NNC_VatAmt2)
                        {
                        }
                        column(NNCTotalExclVAT2; NNC_TotalExclVAT2)
                        {
                        }
                        column(VATBaseDisc_SalesHeader; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(No_SalesLine; "Sales Line"."No.")
                        {
                            IncludeCaption = false;
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                            IncludeCaption = false;
                        }
                        column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                        {
                            IncludeCaption = false;
                        }
                        column(listprice_sqmt; "Sales Line"."Unit Price Excl. VAT/Sq.Mt")
                        {
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(SalesLineLineAmount1; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(LineDiscount_SalesLineAmount; "Sales Line"."Line Discount Amount")
                        {
                        }
                        column(Type_SalesLine; FORMAT("Sales Line".Type))
                        {
                        }
                        column(No_SalesLine1; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvoiceDisYesNo; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(SalesLineInvDiscAmount; SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesLineLineAmtInvDiscAmt; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // 16225   column(SalesLineTaxAmount; SalesLine."Tax Amount")
                        column(SalesLineTaxAmount; 0)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225   column(VATAmount; SalesLine."Service Tax SHE Cess Amount")
                        column(VATAmount; 0)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NNCSalesLineExciseAmt; NNC_SalesLineExciseAmt)
                        {
                        }
                        column(NNCSalesLineTaxAmt; NNC_SalesLineTaxAmt)
                        {
                        }
                        column(NNCSalesLineSvcTaxAmt; NNC_SalesLineSvcTaxAmt)
                        {
                        }
                        column(NNCSalesLineSvcTaxeCessAmt; NNC_SalesLineSvcTaxeCessAmt)
                        {
                        }
                        column(NNCSalesLineSvcSHECessAmt; NNC_SalesLineSvcSHECessAmt)
                        {
                        }
                        column(NNCSalesLineTDSTCSSHECESS; NNC_SalesLineTDSTCSSHECESS)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount1; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_SalesLineCaption; "Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Description_SalesLineCaption; "Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_SalesLineCaption; "Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption; "Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(AllowInvDisc_SalesLineCaption; "Sales Line".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscPercentCaption; DiscPercentCaptionLbl)
                        {
                        }
                        column(LineDiscCaption; LineDiscCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(ExciseAmtCaption; ExciseAmtCaptionLbl)
                        {
                        }
                        column(TaxAmtCaption; TaxAmtCaptionLbl)
                        {
                        }
                        column(ServTaxAmtCaption; ServTaxAmtCaptionLbl)
                        {
                        }
                        column(ChargesAmtCaption; ChargesAmtCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmtCaption; OtherTaxesAmtCaptionLbl)
                        {
                        }
                        column(ServTaxeCessAmtCaption; ServTaxeCessAmtCaptionLbl)
                        {
                        }
                        column(TCSAmtCaption; TCSAmtCaptionLbl)
                        {
                        }
                        column(ServTaxSHECessAmtCaption; ServTaxSHECessAmtCaptionLbl)
                        {
                        }
                        column(VATDisctAmtCaption; VATDisctAmtCaptionLbl)
                        {
                        }
                        column(NNCSalesLineSvcTaxSBCAmt; NNC_SalesLineSvcTaxSBCAmt)
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(NNCSalesLineKKCessAmt; NNC_SalesLineKKCessAmt)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(Cart; Cart)
                        {
                        }
                        column(SqMt; SqMt)
                        {
                        }
                        column(Wt; Wt)
                        {
                        }
                        column(LineAmt; LineAmt)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDFIRST THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntry2.NEXT = 0);
                                IF ShowInternalInfo THEN BEGIN
                                    //16225   NNC_SalesLineExciseAmt += SalesLine."Excise Amount";
                                    //16225   NNC_SalesLineTaxAmt += SalesLine."Tax Amount";
                                    //16225   NNC_SalesLineSvcTaxAmt += SalesLine."Service Tax Amount";
                                    //16225   NNC_SalesLineSvcTaxeCessAmt += SalesLine."Service Tax eCess Amount";
                                    //16225   NNC_SalesLineSvcSHECessAmt += SalesLine."Service Tax SHE Cess Amount";
                                    //16225NNC_SalesLineTDSTCSSHECESS += SalesLine."Total TDS/TCS Incl. SHE CESS";
                                    //16225NNC_SalesLineAmtToCustomer += SalesLine."Amount To Customer";
                                    //16225    NNC_SalesLineSvcTaxSBCAmt += SalesLine."Service Tax SBC Amount";
                                    //16225   NNC_SalesLineKKCessAmt += SalesLine."KK Cess Amount";


                                    TotalAmount := NNC_SalesLineLineAmt - NNC_SalesLineInvDiscAmt + NNC_SalesLineExciseAmt + NNC_SalesLineTaxAmt
                                     + NNC_SalesLineSvcTaxAmt + NNC_SalesLineSvcTaxeCessAmt + ChargesAmount + OtherTaxesAmount
                                     + NNC_SalesLineTDSTCSSHECESS + NNC_SalesLineSvcSHECessAmt
                                     + NNC_SalesLineSvcTaxSBCAmt + NNC_SalesLineKKCessAmt;
                                END;
                            end;

                            trigger OnPostDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN BEGIN
                                    //16225    NNC_SalesLineExciseAmt += SalesLine."Excise Amount";
                                    //16225   NNC_SalesLineTaxAmt += SalesLine."Tax Amount";
                                    //16225   NNC_SalesLineSvcTaxAmt += SalesLine."Service Tax Amount";
                                    //16225    NNC_SalesLineSvcTaxeCessAmt += SalesLine."Service Tax eCess Amount";
                                    //16225    NNC_SalesLineSvcSHECessAmt += SalesLine."Service Tax SHE Cess Amount";
                                    //16225NNC_SalesLineTDSTCSSHECESS += SalesLine."Total TDS/TCS Incl. SHE CESS";
                                    //16225NNC_SalesLineAmtToCustomer += SalesLine."Amount To Customer";
                                    //16225   NNC_SalesLineSvcTaxSBCAmt += SalesLine."Service Tax SBC Amount";
                                    //16225   NNC_SalesLineKKCessAmt += SalesLine."KK Cess Amount";

                                    TotalAmount := NNC_SalesLineLineAmt - NNC_SalesLineInvDiscAmt + NNC_SalesLineExciseAmt + NNC_SalesLineTaxAmt
                                     + NNC_SalesLineSvcTaxAmt + NNC_SalesLineSvcTaxeCessAmt + ChargesAmount + OtherTaxesAmount
                                     + NNC_SalesLineTDSTCSSHECESS + NNC_SalesLineSvcSHECessAmt
                                     + NNC_SalesLineSvcTaxSBCAmt + NNC_SalesLineKKCessAmt;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineUnitOfMeasureText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent + AsmLine.Description)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineType; AsmLine.Type)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    AsmLine.FINDSET
                                ELSE
                                    AsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmInfoExistsForLine THEN
                                    CurrReport.BREAK;
                                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                                SETRANGE(Number, 1, AsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                        //16225 StructureLineDetails: Record "13795";
                        begin
                            IF Number = 1 THEN
                                SalesLine.FIND('-')
                            ELSE
                                SalesLine.NEXT;
                            "Sales Line" := SalesLine;
                            IF DisplayAssemblyInformation THEN
                                AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Sales Line"."No." := '';

                            NNC_SalesLineLineAmt += SalesLine."Line Amount";
                            NNC_SalesLineInvDiscAmt += "Sales Line"."Inv. Discount Amount";

                            NNC_TotalLCY := NNC_SalesLineLineAmt - NNC_SalesLineInvDiscAmt;
                            TotalQd += (("Sales Line"."Quantity Discount Amount" / "Sales Line"."Quantity (Base)") * "Sales Line"."Quantity in Sq. Mt.(Ship)");
                            NNC_TotalExclVAT := NNC_TotalLCY;
                            NNC_VATAmt := VATAmount;
                            NNC_TotalInclVAT := NNC_TotalLCY - NNC_VATAmt;

                            NNC_PmtDiscOnVAT := -VATDiscountAmount;

                            NNC_TotalInclVAT2 := TotalAmountInclVAT;

                            NNC_VatAmt2 := VATAmount;
                            NNC_TotalExclVAT2 := VATBaseAmount;




                            //RKS GST START
                            CRate := 0;
                            SRate := 0;
                            IRate := 0;
                            CAmount := 0;
                            SAmount := 0;
                            IAmount := 0;
                            URate := 0;
                            UAmount := 0;


                            DetailedGSTEntryBuffer.RESET;
                            DetailedGSTEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                            DetailedGSTEntryBuffer.SETRANGE("Transaction Type", DetailedGSTEntryBuffer."Transaction Type"::Sales);

                            if "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Blanket Order" then
                                DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::"Blanket Order")
                            else
                                if "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Credit Memo" then
                                    DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::"Credit Memo")
                                else
                                    if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Invoice then
                                        DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::Invoice)
                                    else
                                        if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Order then
                                            DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::Order)
                                        else
                                            if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Quote then
                                                DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::Quote)
                                            else
                                                if "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Return Order" then
                                                    DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::"Return Order");

                            DetailedGSTEntryBuffer.SETRANGE("Document No.", "Sales Line"."Document No.");
                            DetailedGSTEntryBuffer.SETRANGE("Line No.", "Sales Line"."Line No.");

                            IF DetailedGSTEntryBuffer.FINDFIRST THEN
                                REPEAT
                                    IF DetailedGSTEntryBuffer."GST Component Code" = 'CGST' THEN BEGIN
                                        CRate := DetailedGSTEntryBuffer."GST %";
                                        CAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                        // CAmount1+=CAmount;
                                    END;

                                    IF DetailedGSTEntryBuffer."GST Component Code" = 'SGST' THEN BEGIN
                                        SRate := DetailedGSTEntryBuffer."GST %";
                                        SAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                        //SAmount1+=SAmount
                                    END;

                                    IF DetailedGSTEntryBuffer."GST Component Code" = 'IGST' THEN BEGIN
                                        IRate := DetailedGSTEntryBuffer."GST %";
                                        IAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                        //IAmount1+=IAmount;
                                    END;

                                    IF DetailedGSTEntryBuffer."GST Component Code" = 'UTGST' THEN BEGIN
                                        URate := DetailedGSTEntryBuffer."GST %";
                                        UAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                        //IAmount1+=IAmount;
                                    END;

                                UNTIL
DetailedGSTEntryBuffer.NEXT = 0;




                            IF Currency.GET(SalesLine."Currency Code") THEN;
                            LineAmt := ROUND("Sales Line".Quantity * "Sales Line"."Unit Price", Currency."Amount Rounding Precision");
                            //LineAmt := "Sales Line"."Line Amount"+"Sales Line"."Line Discount Amount";
                            LineTotalAmt := LineTotalAmt + LineAmt;
                            GenLegSetup.GET();
                            //16225 table N/F Start
                            /*  StructureLineDetails.RESET;
                              StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
                              StructureLineDetails.SETRANGE("Document Type", SalesLine."Document Type");
                              StructureLineDetails.SETRANGE("Document No.", SalesLine."Document No.");
                              StructureLineDetails.SETRANGE("Item No.", SalesLine."No.");
                              StructureLineDetails.SETRANGE("Line No.", SalesLine."Line No.");
                              IF StructureLineDetails.FIND('-') THEN
                                  REPEAT
                                      IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN
                                          IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                              ChargesAmount := ChargesAmount + ROUND(StructureLineDetails.Amount);
                                          IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                              OtherTaxesAmount := OtherTaxesAmount + ROUND(StructureLineDetails.Amount);
                                      END;
                                      IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Excise THEN
                                          ExciseAmount := ExciseAmount + StructureLineDetails.Amount;*/
                            //16225 table N/F End
                            //sash block
                            /* IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN BEGIN
                               IF StructureLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                  InvDisc := InvDisc + StructureLineDetails.Amount
                               ELSE
                                 Charges := Charges + StructureLineDetails.Amount;
                               END;
                               */     //sash block

                            //sash new alter
                            //16225 table N/F Start
                            /*   IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN BEGIN
                                   IF StructureLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                       InvDisc := InvDisc + StructureLineDetails.Amount
                                   // ELSE IF StructureLineDetails."Tax/Charge Group" = GenLegSetup.AddonDisc THEN
                                   //   AddInvDisc := AddInvDisc + StructureLineDetails.Amount
                                   ELSE
                                       IF StructureLineDetails."Tax/Charge Group" = GenLegSetup.AddInsuranceDisc THEN BEGIN
                                           IF SalesLine.Quantity > 0 THEN
                                               // AddInsuDisc := AddInsuDisc + (StructureLineDetails.Amount*SalesLine."Qty. to Ship"/SalesLine.Quantity)
                                               AddInsuDisc := AddInsuDisc + ((StructureLineDetails."Calculation Value" *
                                 StructureLineDetails."Base Amount" / 100) * SalesLine."Qty. to Ship" / SalesLine.Quantity)
                                       END
                                       ELSE
                                           Charges := Charges + StructureLineDetails.Amount;
                               END; */     //sash new alter
                                           //16225 table N/F End
                                           //16225 table N/F Start
                                           /*  IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                                 Othertaxes := Othertaxes + StructureLineDetails.Amount;
                                             IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Sales Tax" THEN
                                                 SalesTax := SalesTax + StructureLineDetails.Amount;
                                             IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::GST THEN
                                                 ServiceTax := ServiceTax + StructureLineDetails.Amount;
                                             IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                                 VATAmt := VATAmt + StructureLineDetails.Amount;
                                             LineTotalAmt := LineTotalAmt + StructureLineDetails.Amount;

                                         UNTIL StructureLineDetails.NEXT = 0;
                                     TotalAmount := SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount" + SalesLine."Excise Amount" + SalesLine."Tax Amount"
                                       + SalesLine."Service Tax Amount" + SalesLine."Service Tax eCess Amount" + ChargesAmount + OtherTaxesAmount
                                       + SalesLine."Total TDS/TCS Incl. SHE CESS" + SalesLine."Service Tax SHE Cess Amount" + SalesLine."Service Tax SBC Amount" +
                                       SalesLine."KK Cess Amount";*/
                                           //16225 table N/F End

                            // NAVIN



                            Cart := 0;
                            SqMt := 0;
                            Wt := 0;
                            Cart := item.UomToCart(SalesLine."No.", SalesLine."Unit of Measure Code", SalesLine.Quantity);
                            SqMt := item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", SalesLine.Quantity);
                            //Wt := item.UomToWeight(SalesLine."No.",SalesLine."Unit of Measure Code",SalesLine.Quantity);
                            Wt := SalesLine."Gross Weight";

                            CLEAR(recItem);
                            IF recItem.GET(SalesLine."No.") THEN;

                            IF SalesLine."Quantity in Sq. Mt." <> 0 THEN BEGIN
                                DecRate := (SalesLine."Quantity Discount Amount" / SalesLine."Quantity in Sq. Mt.");
                            END;

                            CLEAR(BuyersRatePerSqMtr);
                            IF SqMt <> 0 THEN BEGIN
                                BuyersRatePerSqMtr := (SalesLine."Buyer's Price" * SalesLine.Quantity / SqMt) + DecRate;
                            END;

                            CLEAR(VatTot);
                            CLEAR(CstTot);
                            //16225 Table N/F Start
                            /*   DetailTaxBuffer.RESET;
                               DetailTaxBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                               DetailTaxBuffer.SETRANGE("Document Type", "Sales Header"."Document Type");
                               DetailTaxBuffer.SETRANGE("Document No.", "Sales Header"."No.");
                               IF DetailTaxBuffer.FINDFIRST THEN
                                   REPEAT
                                       DetailTaxBuffer.CALCFIELDS("Additional Tax", "Tax Type");
                                       IF DetailTaxBuffer."Tax Type" = DetailTaxBuffer."Tax Type"::CST THEN BEGIN
                                           IF NOT DetailTaxBuffer."Additional Tax" THEN
                                               CstTot := CstTot + (-DetailTaxBuffer."Tax Amount")
                                           ELSE
                                               AdditionalTot := AdditionalTot + (-DetailTaxBuffer."Tax Amount");
                                       END;

                                       IF DetailTaxBuffer."Tax Type" = DetailTaxBuffer."Tax Type"::VAT THEN BEGIN
                                           IF NOT DetailTaxBuffer."Additional Tax" THEN
                                               VatTot := VatTot + (-DetailTaxBuffer."Tax Amount")
                                           ELSE
                                               AdditionalTot := AdditionalTot + (-DetailTaxBuffer."Tax Amount");
                                       END;

                                   UNTIL DetailTaxBuffer.NEXT = 0;*///16225 Table N/F End


                            //BilPrice := 0;
                            //TotalVCost := 0;
                            //BilPrice := ("Sales Line"."Unit Price Excl. VAT/Sq.Mt"-"Sales Line".D7)*SqMt;
                            BilPrice := (RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT")) - (RecSalesLine.D1 + RecSalesLine.D2 + RecSalesLine.D3 + RecSalesLine.D4);
                            TotalVCost := recItem."V. Cost" * SqMt;


                            IF TotalVCost <> 0 THEN
                                GrndTotal := (BilPrice - TotalVCost) / TotalVCost;

                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                                MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SETRANGE(Number, 1, SalesLine.COUNT);
                            //16225 Field N/F Start
                            /*CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine."Inv. Discount Amount", SalesLine."Excise Amount", SalesLine."Tax Amount",
                              SalesLine."Service Tax Amount", SalesLine."Service Tax eCess Amount",
                              SalesLine."Service Tax SHE Cess Amount",
                            SalesLine."Total TDS/TCS Incl. SHE CESS", SalesLine."Amount To Customer", SalesLine."Service Tax SBC Amount");
                            CurrReport.CREATETOTALS(SalesLine."KK Cess Amount");*/
                            //16225 Field N/F End
                            NNC_SalesLineExciseAmt := 0;
                            NNC_SalesLineTaxAmt := 0;
                            NNC_SalesLineSvcTaxAmt := 0;
                            NNC_SalesLineSvcTaxeCessAmt := 0;
                            NNC_SalesLineSvcSHECessAmt := 0;
                            NNC_SalesLineTDSTCSSHECESS := 0;
                            NNC_SalesLineAmtToCustomer := 0;
                            NNC_SalesLineSvcTaxSBCAmt := 0;
                            NNC_SalesLineKKCessAmt := 0;



                            LineTotalAmt := 0;
                            ExciseAmount := 0;
                            Charges := 0;
                            Othertaxes := 0;
                            SalesTax := 0;
                            InvDisc := 0;
                            CstTot := 0;
                            AdditionalTot := 0;
                            //sash
                            AddInvDisc := 0;
                            AddInsuDisc := 0;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT1; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SellToCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
                        {
                            IncludeCaption = false;
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddrCaption; ShipToAddrCaptionLbl)
                        {
                        }
                        column(SellToCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDescription; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccountNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText1; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtText; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText1; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvBufAmount; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufAmtPrepmtVATAmt; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText1; VATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PmtTermsCaption; PmtTermsCaptionLbl)
                        {
                        }
                        column(GLAccNoCaption; GLAccNoCaptionLbl)
                        {
                        }
                        column(PrepmtSpecCaption; PrepmtSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT PrepmtDimSetEntry.FIND('-') THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL PrepmtDimSetEntry.NEXT = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF PrepmtInvBuf.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF ShowInternalInfo THEN
                                DimMgt.GetDimensionSet(PrepmtDimSetEntry, PrepmtInvBuf."Dimension Set ID");

                            IF "Sales Header"."Prices Including VAT" THEN
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLineVAT; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdentifier; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATAmtSpecCaption; PrepmtVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, PrepmtVATAmountLine.COUNT);
                        end;
                    }
                    dataitem("Sales Comment Line"; "Sales Comment Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                            ORDER(Ascending);
                        column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line" temporary;
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    SalesPostPrepmt.GetSalesLines("Sales Header", 0, PrepmtSalesLine);

                    IF (NOT PrepmtSalesLine.ISEMPTY) THEN BEGIN
                        SalesPostPrepmt.GetSalesLinesToDeduct("Sales Header", TempSalesLine);
                        IF NOT TempSalesLine.ISEMPTY THEN
                            SalesPostPrepmt.CalcVATAmountLines("Sales Header", TempSalesLine, PrepmtVATAmountLineDeduct, 1);
                    END;
                    SalesPostPrepmt.CalcVATAmountLines("Sales Header", PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    IF PrepmtVATAmountLine.FINDSET THEN
                        REPEAT
                            PrepmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            IF PrepmtVATAmountLineDeduct.FIND THEN BEGIN
                                PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrepmtVATAmountLineDeduct."VAT Base";
                                PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrepmtVATAmountLineDeduct."VAT Amount";
                                PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                                  PrepmtVATAmountLineDeduct."Amount Including VAT";
                                PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrepmtVATAmountLineDeduct."Line Amount";
                                PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  PrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                                  PrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                                  PrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                PrepmtVATAmountLine.MODIFY;
                            END;
                        UNTIL PrepmtVATAmountLine.NEXT = 0;

                    SalesPostPrepmt.UpdateVATOnLines("Sales Header", PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    ///   SalesPostPrepmt.BuildInvLineBuffer2("Sales Header", PrepmtSalesLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    NNC_TotalLCY := 0;
                    NNC_TotalExclVAT := 0;
                    NNC_VATAmt := 0;
                    NNC_TotalInclVAT := 0;
                    NNC_PmtDiscOnVAT := 0;
                    NNC_TotalInclVAT2 := 0;
                    NNC_VatAmt2 := 0;
                    NNC_TotalExclVAT2 := 0;
                    NNC_SalesLineLineAmt := 0;
                    NNC_SalesLineInvDiscAmt := 0;

                    ChargesAmount := 0;
                    TotalAmount := 0;
                    OtherTaxesAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF Print THEN
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Loca: Record Location;
                Customer: Record Customer;
            begin
                IF CustRec.GET("Sell-to Customer No.") THEN;
                CustRec.CALCFIELDS(Balance);
                OutBal := CustRec.Balance;
                IF StateRec.GET(CustRec."State Code") THEN;
                CustomerStateDes := StateRec.Description;
                IF Shipto.GET("Ship-to Code") THEN;
                IF StateRec.GET(Shipto.State) THEN;
                ShippiStateDes := StateRec.Description;
                CLEAR(CST);
                IF Loca.GET("Sales Header"."Location Code") THEN;

                LocaTINNo := Loca."GST Registration No.";
                IF Customer.GET("Sales Header"."Sell-to Customer No.") THEN;
                IF Loca."State Code" <> Customer."State Code" THEN
                    CST := TRUE;


                //16225 funcation N/F  CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");


                IF Location.GET("Sales Header"."Location Code") THEN;
                IF State1.GET(Location."State Code") THEN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddr.RespCenter(CompanyAddr, RespCenter);
                        CompanyInfo."Phone No." := RespCenter."Phone No.";
                        CompanyInfo."Fax No." := RespCenter."Fax No.";
                    END ELSE
                        FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Sales Header"."Dimension Set ID");

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;

                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, "Currency Code");
                END;
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Header"."Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Sales Header"."Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Sales Header"."Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Header"."Language Code");
                END;

                // 16225 FormatAddr.SalesHeaderShipTo(ShipToAddr, "Sales Header");
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF Print THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Print := Print OR NOT CurrReport.PREVIEW;
                AsmInfoExistsForLine := FALSE;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            //16225  ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            ArchiveDocument := SalesSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF (UPPERCASE(USERID) <> 'MA028') AND (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'FA028') THEN
            ERROR('Report has an error');

        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    var
        Text000: Label 'Salesperson';
        DocumentType: Enum "Document Type Enum";
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label ' COPY';
        Text004: Label 'Order Confirmation%1';
        PageCaptionCap: Label 'Page %1 of %2';
        Text006: Label 'Total %1 Excl. VAT';
        DetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        URate: Decimal;
        UAmount: Decimal;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtAmountInclVAT: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        NNC_TotalLCY: Decimal;
        NNC_TotalExclVAT: Decimal;
        NNC_VATAmt: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_PmtDiscOnVAT: Decimal;
        NNC_TotalInclVAT2: Decimal;
        NNC_VatAmt2: Decimal;
        NNC_TotalExclVAT2: Decimal;
        NNC_SalesLineLineAmt: Decimal;
        NNC_SalesLineInvDiscAmt: Decimal;
        Print: Boolean;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        TotalAmount: Decimal;
        NNC_SalesLineSvcTaxeCessAmt: Decimal;
        NNC_SalesLineExciseAmt: Decimal;
        NNC_SalesLineTaxAmt: Decimal;
        NNC_SalesLineSvcTaxAmt: Decimal;
        NNC_SalesLineSvcSHECessAmt: Decimal;
        NNC_SalesLineTDSTCSSHECESS: Decimal;
        NNC_SalesLineAmtToCustomer: Decimal;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        HomePageCaptionCap: Label 'Home Page';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        ShpDateCaptionLbl: Label 'Shipment Date';
        OrderNoCaptionLbl: Label 'Order No.';
        EMailCaptionLbl: Label 'E-Mail';
        PmtTermsDescCaptionLbl: Label 'Payment Terms';
        ShipMethodDescCaptionLbl: Label 'Shipment Method';
        PrepmtTermsDescCaptionLbl: Label 'Prepayment Payment Terms';
        DocDateCaptionLbl: Label 'Document Date';
        AmtCaptionLbl: Label 'Amount';
        HdrDimsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscPercentCaptionLbl: Label 'Discount %';
        LineDiscCaptionLbl: Label 'Line Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        ExciseAmtCaptionLbl: Label 'Excise Amount';
        TaxAmtCaptionLbl: Label 'Tax Amount';
        ServTaxAmtCaptionLbl: Label 'Service Tax Amount';
        ChargesAmtCaptionLbl: Label 'Charges Amount';
        OtherTaxesAmtCaptionLbl: Label 'Other Taxes Amount';
        ServTaxeCessAmtCaptionLbl: Label 'Service Tax eCess Amount';
        TCSAmtCaptionLbl: Label 'TCS Amount';
        ServTaxSHECessAmtCaptionLbl: Label 'Service Tax SHECess Amount';
        VATDisctAmtCaptionLbl: Label 'Payment Discount on VAT';
        LineDimsCaptionLbl: Label 'Line Dimensions';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        ShipToAddrCaptionLbl: Label 'Ship-to Address';
        PmtTermsCaptionLbl: Label 'Description';
        GLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepmtSpecCaptionLbl: Label 'Prepayment Specification';
        PrepmtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        VATIdentCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        NNC_SalesLineSvcTaxSBCAmt: Decimal;
        NNC_SalesLineKKCessAmt: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        //16225  DetailTaxBuffer: Record "16480";
        VatTot: Decimal;
        CstTot: Decimal;
        AdditionalTot: Decimal;
        LineDiscountAmt: Decimal;
        NetTot: Decimal;
        Customer1: Record Customer;
        TinNo: Code[15];
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        AQD: Decimal;
        Location: Record Location;
        State1: Record State;
        AmttoCust: Decimal;
        TotalQd: Decimal;
        AddInvDisc: Decimal;
        AddInsuDisc: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Currency: Record Currency;
        LineAmt: Decimal;
        LineTotalAmt: Decimal;
        //16225  StructureLineDetails: Record "13795";
        ExciseAmount: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        InvDisc: Decimal;
        Charges: Decimal;
        Othertaxes: Decimal;
        SalesTax: Decimal;
        ServiceTax: Decimal;
        VATAmt: Decimal;
        Cart: Decimal;
        SqMt: Decimal;
        Wt: Decimal;
        item: Record Item;
        DecRate: Decimal;
        BuyersRatePerSqMtr: Decimal;
        CustRec: Record Customer;
        OutBal: Decimal;
        StateRec: Record State;
        CustomerStateDes: Text[100];
        Shipto: Record "Ship-to Address";
        ShippiStateDes: Text[100];
        CST: Boolean;
        LocaTINNo: Code[30];
        vcost: Decimal;
        recItem: Record Item;
        BilPrice: Decimal;
        TotalVCost: Decimal;
        GrndTotal: Decimal;
        RecSalesLine: Record "Sales Line";


    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 16225text
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
}

