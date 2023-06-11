report 50710 "Service Document - Test Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ServiceDocumentTestCopy.rdl';
    Caption = 'Service Document - Test';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Service Header"; 5900)
        {
            DataItemTableView = WHERE("Document Type" = FILTER(<> Quote));
            RequestFilterFields = "Document Type", "No.";
            RequestFilterHeading = 'Service Document';
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Service_Document___TestCaption; Service_Document___TestCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem(PageCounter; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                {
                }
                column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                {
                }
                column(CustomerRegistrationLbl; CustomerRegistrationLbl)
                {
                }
                column(Customer_GST_RegistrationNo; Customer."GST Registration No.")
                {
                }
                column(STRSUBSTNO_Text014_ServiceHeaderFilter_; STRSUBSTNO(Text014, ServiceHeaderFilter))
                {
                }
                column(ShowServiceHeaderFilter; ServiceHeaderFilter)
                {
                }
                column(ShipInvText; ShipInvText)
                {
                }
                column(ReceiveInvText; ReceiveInvText)
                {
                }
                column(Service_Header___Customer_No__; "Service Header"."Customer No.")
                {
                }
                column(ShipToAddr_8_; ShipToAddr[8])
                {
                }
                column(ShipToAddr_7_; ShipToAddr[7])
                {
                }
                column(ShipToAddr_6_; ShipToAddr[6])
                {
                }
                column(ShipToAddr_5_; ShipToAddr[5])
                {
                }
                column(ShipToAddr_4_; ShipToAddr[4])
                {
                }
                column(ShipToAddr_3_; ShipToAddr[3])
                {
                }
                column(ShipToAddr_2_; ShipToAddr[2])
                {
                }
                column(ShipToAddr_1_; ShipToAddr[1])
                {
                }
                column(Service_Header___Ship_to_Code_; "Service Header"."Ship-to Code")
                {
                }
                column(FORMAT__Service_Header___Document_Type____________Service_Header___No__; FORMAT("Service Header"."Document Type") + ' ' + "Service Header"."No.")
                {
                }
                column(FORMAT__Service_Header___Prices_Including_VAT__; FORMAT("Service Header"."Prices Including VAT"))
                {
                }
                column(BillToAddr_8_; BillToAddr[8])
                {
                }
                column(BillToAddr_7_; BillToAddr[7])
                {
                }
                column(BillToAddr_6_; BillToAddr[6])
                {
                }
                column(BillToAddr_5_; BillToAddr[5])
                {
                }
                column(BillToAddr_4_; BillToAddr[4])
                {
                }
                column(BillToAddr_3_; BillToAddr[3])
                {
                }
                column(BillToAddr_2_; BillToAddr[2])
                {
                }
                column(BillToAddr_1_; BillToAddr[1])
                {
                }
                column(Service_Header___Bill_to_Customer_No__; "Service Header"."Bill-to Customer No.")
                {
                }
                column(ShowBillAddrInfo; "Service Header"."Bill-to Customer No." <> "Service Header"."Customer No.")
                {
                }
                column(Service_Header___Salesperson_Code_; "Service Header"."Salesperson Code")
                {
                }
                column(Service_Header___Your_Reference_; "Service Header"."Your Reference")
                {
                }
                column(Service_Header___Customer_Posting_Group_; "Service Header"."Customer Posting Group")
                {
                }
                column(Service_Header___Posting_Date_; FORMAT("Service Header"."Posting Date"))
                {
                }
                column(Service_Header___Document_Date_; FORMAT("Service Header"."Document Date"))
                {
                }
                column(Service_Header___Prices_Including_VAT_; "Service Header"."Prices Including VAT")
                {
                }
                column(ShowQuote; "Service Header"."Document Type" = "Service Header"."Document Type"::Quote)
                {
                }
                column(Service_Header___Payment_Terms_Code_; "Service Header"."Payment Terms Code")
                {
                }
                column(Service_Header___Payment_Discount___; "Service Header"."Payment Discount %")
                {
                }
                column(Service_Header___Due_Date_; FORMAT("Service Header"."Due Date"))
                {
                }
                column(Service_Header___Customer_Disc__Group_; "Service Header"."Customer Disc. Group")
                {
                }
                column(Service_Header___Pmt__Discount_Date_; FORMAT("Service Header"."Pmt. Discount Date"))
                {
                }
                column(Service_Header___Invoice_Disc__Code_; "Service Header"."Invoice Disc. Code")
                {
                }
                column(Service_Header___Payment_Method_Code_; "Service Header"."Payment Method Code")
                {
                }
                column(Service_Header___Posting_Date__Control105; FORMAT("Service Header"."Posting Date"))
                {
                }
                column(Service_Header___Document_Date__Control106; FORMAT("Service Header"."Document Date"))
                {
                }
                column(Service_Header___Order_Date_; FORMAT("Service Header"."Order Date"))
                {
                }
                column(Service_Header___Prices_Including_VAT__Control194; "Service Header"."Prices Including VAT")
                {
                }
                column(ShowOrder; "Service Header"."Document Type" = "Service Header"."Document Type"::Order)
                {
                }
                column(Service_Header___Payment_Terms_Code__Control18; "Service Header"."Payment Terms Code")
                {
                }
                column(Service_Header___Due_Date__Control19; FORMAT("Service Header"."Due Date"))
                {
                }
                column(Service_Header___Pmt__Discount_Date__Control22; FORMAT("Service Header"."Pmt. Discount Date"))
                {
                }
                column(Service_Header___Payment_Discount____Control23; "Service Header"."Payment Discount %")
                {
                }
                column(Service_Header___Payment_Method_Code__Control26; "Service Header"."Payment Method Code")
                {
                }
                column(Service_Header___Customer_Disc__Group__Control100; "Service Header"."Customer Disc. Group")
                {
                }
                column(Service_Header___Invoice_Disc__Code__Control102; "Service Header"."Invoice Disc. Code")
                {
                }
                column(Service_Header___Customer_Posting_Group__Control130; "Service Header"."Customer Posting Group")
                {
                }
                column(Service_Header___Posting_Date__Control131; FORMAT("Service Header"."Posting Date"))
                {
                }
                column(Service_Header___Document_Date__Control132; FORMAT("Service Header"."Document Date"))
                {
                }
                column(Service_Header___Prices_Including_VAT__Control196; "Service Header"."Prices Including VAT")
                {
                }
                column(ShowInvoice; "Service Header"."Document Type" = "Service Header"."Document Type"::Invoice)
                {
                }
                column(Service_Header___Applies_to_Doc__Type_; "Service Header"."Applies-to Doc. Type")
                {
                }
                column(Service_Header___Applies_to_Doc__No__; "Service Header"."Applies-to Doc. No.")
                {
                }
                column(Service_Header___Customer_Posting_Group__Control136; "Service Header"."Customer Posting Group")
                {
                }
                column(Service_Header___Posting_Date__Control137; FORMAT("Service Header"."Posting Date"))
                {
                }
                column(Service_Header___Document_Date__Control138; FORMAT("Service Header"."Document Date"))
                {
                }
                column(Service_Header___Prices_Including_VAT__Control198; "Service Header"."Prices Including VAT")
                {
                }
                column(ShowCreditMemo; "Service Header"."Document Type" = "Service Header"."Document Type"::"Credit Memo")
                {
                }
                column(Service_Header___Customer_No__Caption; "Service Header".FIELDCAPTION("Customer No."))
                {
                }
                column(Ship_toCaption; Ship_toCaptionLbl)
                {
                }
                column(CustomerCaption; CustomerCaptionLbl)
                {
                }
                column(Service_Header___Ship_to_Code_Caption; "Service Header".FIELDCAPTION("Ship-to Code"))
                {
                }
                column(Bill_toCaption; Bill_toCaptionLbl)
                {
                }
                column(Service_Header___Bill_to_Customer_No__Caption; "Service Header".FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Service_Header___Salesperson_Code_Caption; "Service Header".FIELDCAPTION("Salesperson Code"))
                {
                }
                column(Service_Header___Your_Reference_Caption; "Service Header".FIELDCAPTION("Your Reference"))
                {
                }
                column(Service_Header___Customer_Posting_Group_Caption; "Service Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Service_Header___Posting_Date_Caption; Service_Header___Posting_Date_CaptionLbl)
                {
                }
                column(Service_Header___Document_Date_Caption; Service_Header___Document_Date_CaptionLbl)
                {
                }
                column(Service_Header___Prices_Including_VAT_Caption; "Service Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(Service_Header___Payment_Terms_Code_Caption; "Service Header".FIELDCAPTION("Payment Terms Code"))
                {
                }
                column(Service_Header___Payment_Discount___Caption; "Service Header".FIELDCAPTION("Payment Discount %"))
                {
                }
                column(Service_Header___Due_Date_Caption; Service_Header___Due_Date_CaptionLbl)
                {
                }
                column(Service_Header___Customer_Disc__Group_Caption; "Service Header".FIELDCAPTION("Customer Disc. Group"))
                {
                }
                column(Service_Header___Pmt__Discount_Date_Caption; Service_Header___Pmt__Discount_Date_CaptionLbl)
                {
                }
                column(Service_Header___Invoice_Disc__Code_Caption; "Service Header".FIELDCAPTION("Invoice Disc. Code"))
                {
                }
                column(Service_Header___Payment_Method_Code_Caption; "Service Header".FIELDCAPTION("Payment Method Code"))
                {
                }
                column(Service_Header___Posting_Date__Control105Caption; Service_Header___Posting_Date__Control105CaptionLbl)
                {
                }
                column(Service_Header___Document_Date__Control106Caption; Service_Header___Document_Date__Control106CaptionLbl)
                {
                }
                column(Service_Header___Order_Date_Caption; Service_Header___Order_Date_CaptionLbl)
                {
                }
                column(Service_Header___Prices_Including_VAT__Control194Caption; "Service Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(Service_Header___Payment_Terms_Code__Control18Caption; "Service Header".FIELDCAPTION("Payment Terms Code"))
                {
                }
                column(Service_Header___Payment_Discount____Control23Caption; "Service Header".FIELDCAPTION("Payment Discount %"))
                {
                }
                column(Service_Header___Due_Date__Control19Caption; Service_Header___Due_Date__Control19CaptionLbl)
                {
                }
                column(Service_Header___Pmt__Discount_Date__Control22Caption; Service_Header___Pmt__Discount_Date__Control22CaptionLbl)
                {
                }
                column(Service_Header___Payment_Method_Code__Control26Caption; "Service Header".FIELDCAPTION("Payment Method Code"))
                {
                }
                column(Service_Header___Customer_Disc__Group__Control100Caption; "Service Header".FIELDCAPTION("Customer Disc. Group"))
                {
                }
                column(Service_Header___Invoice_Disc__Code__Control102Caption; "Service Header".FIELDCAPTION("Invoice Disc. Code"))
                {
                }
                column(Service_Header___Customer_Posting_Group__Control130Caption; "Service Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Service_Header___Posting_Date__Control131Caption; Service_Header___Posting_Date__Control131CaptionLbl)
                {
                }
                column(Service_Header___Document_Date__Control132Caption; Service_Header___Document_Date__Control132CaptionLbl)
                {
                }
                column(Service_Header___Prices_Including_VAT__Control196Caption; "Service Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(Service_Header___Applies_to_Doc__Type_Caption; "Service Header".FIELDCAPTION("Applies-to Doc. Type"))
                {
                }
                column(Service_Header___Applies_to_Doc__No__Caption; "Service Header".FIELDCAPTION("Applies-to Doc. No."))
                {
                }
                column(Service_Header___Customer_Posting_Group__Control136Caption; "Service Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Service_Header___Posting_Date__Control137Caption; Service_Header___Posting_Date__Control137CaptionLbl)
                {
                }
                column(Service_Header___Document_Date__Control138Caption; Service_Header___Document_Date__Control138CaptionLbl)
                {
                }
                column(Service_Header___Prices_Including_VAT__Control198Caption; "Service Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(SellToAddr_1_; SellToAddr[1])
                {
                }
                column(SellToAddr_2_; SellToAddr[2])
                {
                }
                column(SellToAddr_3_; SellToAddr[3])
                {
                }
                column(SellToAddr_4_; SellToAddr[4])
                {
                }
                column(SellToAddr_5_; SellToAddr[5])
                {
                }
                column(SellToAddr_6_; SellToAddr[6])
                {
                }
                column(SellToAddr_7_; SellToAddr[7])
                {
                }
                column(SellToAddr_8_; SellToAddr[8])
                {
                }
                dataitem(DimensionLoop1; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    column(DimText; DimText)
                    {
                    }
                    column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        DimText := DimTxtArr[Number];
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT ShowDim THEN
                            CurrReport.BREAK;
                        FindDimTxt("Service Header"."Dimension Set ID");
                        SETRANGE(Number, 1, DimTxtArrLength);
                    end;
                }
                dataitem(HeaderErrorCounter; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                    {
                    }

                    trigger OnPostDataItem()
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, ErrorCounter);
                    end;
                }
                dataitem(CopyLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    dataitem("Service Line"; 5902)
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            IF FIND('+') THEN
                                OrigMaxLineNo := "Line No.";
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(GSTComponentCode1; GSTComponentCode[1] + ' Amount')
                        {
                        }
                        column(GSTComponentCode2; GSTComponentCode[2] + ' Amount')
                        {
                        }
                        column(GSTComponentCode3; GSTComponentCode[3] + ' Amount')
                        {
                        }
                        column(GSTComponentCode4; GSTComponentCode[4] + 'Amount')
                        {
                        }
                        column(GSTCompAmount1; ABS(GSTCompAmount[1]))
                        {
                        }
                        column(GSTCompAmount2; ABS(GSTCompAmount[2]))
                        {
                        }
                        column(GSTCompAmount3; ABS(GSTCompAmount[3]))
                        {
                        }
                        column(GSTCompAmount4; ABS(GSTCompAmount[4]))
                        {
                        }
                        column(Service_Line__Type; "Service Line".Type)
                        {
                        }
                        column(Service_Line___No__; "Service Line"."No.")
                        {
                        }
                        column(Service_Line__Description; "Service Line".Description)
                        {
                        }
                        column(Service_Line__Quantity; "Service Line".Quantity)
                        {
                        }
                        column(QtyToHandle; QtyToHandle)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Service_Line___Qty__to_Invoice_; "Service Line"."Qty. to Invoice")
                        {
                        }
                        column(Service_Line___Unit_Price_; "Service Line"."Unit Price")
                        {
                            AutoFormatExpression = "Service Line"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Service_Line___Line_Discount___; "Service Line"."Line Discount %")
                        {
                        }
                        column(Service_Line___Line_Amount_; "Service Line"."Line Amount")
                        {
                            AutoFormatExpression = "Service Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Service_Line___Allow_Invoice_Disc__; "Service Line"."Allow Invoice Disc.")
                        {
                        }
                        column(Service_Line___Line_Discount_Amount_; "Service Line"."Line Discount Amount")
                        {
                        }
                        column(FORMAT__Service_Line___Allow_Invoice_Disc___; FORMAT("Service Line"."Allow Invoice Disc."))
                        {
                        }
                        column(ServiceLineLineNo; ServiceLine."Line No.")
                        {
                        }
                        column(SumLineAmount; SumLineAmount)
                        {
                        }
                        column(SumInvDiscountAmount; SumInvDiscountAmount)
                        {
                        }
                        column(TempServiceLine__Inv__Discount_Amount_; -TempServiceLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TempServiceLine__Line_Amount_; TempServiceLine."Line Amount")
                        {
                            AutoFormatExpression = "Service Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(TempServiceLine__Line_Amount_____Service_Line___Inv__Discount_Amount_; TempServiceLine."Line Amount" - TempServiceLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowRoundLoop5; VATAmount = 0)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                        }
                        column(TempServiceLine__Excise_Amount_; 0) // 16630 blank TempServiceLine."Excise Amount"
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TempServiceLine__Tax_Amount_; 0) // 16630 blank TempServiceLine."Tax Amount"
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control1500007; TotalInclVATText)
                        {
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumServiceLineExciseAmount; SumServiceLineExciseAmount)
                        {
                        }
                        column(SumServiceLineTaxAmount; SumServiceLineTaxAmount)
                        {
                        }
                        column(SumLineServiceTaxAmount; SumLineServiceTaxAmount)
                        {
                        }
                        column(SumLineServiceTaxECessAmount; SumLineServiceTaxECessAmount)
                        {
                        }
                        column(SumLineServiceTaxSHECessAmount; SumLineServiceTaxSHECessAmount)
                        {
                        }
                        column(SumServiceLineAmountToCusTomer; SumServiceLineAmountToCusTomer)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowRoundLoop7; "Service Header"."Prices Including VAT" AND (VATAmount <> 0) AND ("Service Header"."VAT Base Discount %" <> 0))
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control189; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATBaseAmount___VATAmount; VATBaseAmount + VATAmount)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control186; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowRoundLoop8; "Service Header"."Prices Including VAT" AND (VATAmount <> 0))
                        {
                        }
                        column(Service_Line___No__Caption; "Service Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Service_Line__DescriptionCaption; "Service Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Service_Line___Qty__to_Invoice_Caption; "Service Line".FIELDCAPTION("Qty. to Invoice"))
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(Service_Line___Line_Discount___Caption; Service_Line___Line_Discount___CaptionLbl)
                        {
                        }
                        column(Service_Line___Allow_Invoice_Disc__Caption; "Service Line".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(Service_Line___Line_Discount_Amount_Caption; Service_Line___Line_Discount_Amount_CaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Service_Line__TypeCaption; "Service Line".FIELDCAPTION(Type))
                        {
                        }
                        column(Service_Line__QuantityCaption; Service_Line__QuantityCaptionLbl)
                        {
                        }
                        column(QtyToHandleCaption; QtyToHandleCaptionLbl)
                        {
                        }
                        column(TempServiceLine__Inv__Discount_Amount_Caption; TempServiceLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(TempServiceLine__Excise_Amount_Caption; TempServiceLine__Excise_Amount_CaptionLbl)
                        {
                        }
                        column(TempServiceLine__Tax_Amount_Caption; TempServiceLine__Tax_Amount_CaptionLbl)
                        {
                        }
                        column(ServiceTaxAmtCaption; ServiceTaxAmtCaptionLbl)
                        {
                        }
                        column(Charges_AmountCaption; Charges_AmountCaptionLbl)
                        {
                        }
                        column(Other_Taxes_AmountCaption; Other_Taxes_AmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxECessAmtCaption; ServiceTaxECessAmtCaptionLbl)
                        {
                        }
                        column(Svc_Tax_Amt__Applied_Caption; Svc_Tax_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(Svc_Tax_eCess_Amt__Applied_Caption; Svc_Tax_eCess_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(ServiceTaxSHECessAmtCaption; ServiceTaxSHECessAmtCaptionLbl)
                        {
                        }
                        column(Svc_Tax_SHECess_Amt_Applied_Caption; Svc_Tax_SHECess_Amt_Applied_CaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(AppliedServiceTaxSBCAmt; AppliedServiceTaxSBCAmt)
                        {
                        }
                        column(ServiceTaxSBCAmt; ServiceTaxSBCAmt)
                        {
                        }
                        column(SumLineSvcTaxSBCAmount; SumLineSvcTaxSBCAmount)
                        {
                        }
                        column(ServiceTaxSBCAmtCaption; ServiceTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(Svc_Tax_SBC_Amt__Applied_Caption; Svc_Tax_SBC_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(AppliedKKCessAmt; AppliedKKCessAmt)
                        {
                        }
                        column(KKCessAmt; KKCessAmt)
                        {
                        }
                        column(SumLineKKCessAmount; SumLineKKCessAmount)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(KKCess_Amt__Applied_Caption; KKCess_Amt__Applied_CaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; 2000000026)
                        {
                            DataItemTableView = SORTING(Number);
                            column(DimText_Control159; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                DimText := DimTxtArr[Number];
                            end;

                            trigger OnPostDataItem()
                            begin
                                sgstTOTAL := 0;
                                igst := 0;
                                igstTotal := 0;
                                sgst := 0;
                                GSTper3 := 0;
                                cgst := 0;
                                GSTper1 := 0;
                                GSTper2 := 0;
                                cgstTOTAL := 0;
                                TotalAmt := 0;
                                LineAmt := 0;




                                Clear(sgst);
                                Clear(igst);
                                Clear(cgst);
                                Clear(TotalAmt);
                                TempServiceLine.Reset();
                                TempServiceLine.SetRange("Document Type", "Service Header"."Document Type");
                                TempServiceLine.SetRange("Document No.", "Service Header"."No.");
                                if TempServiceLine.FindSet() then
                                    repeat
                                        TotalAmt += TempServiceLine."Line Amount";
                                        GSTSetup.Get();
                                        if GSTSetup."GST Tax Type" = GSTLbl then
                                            if TempServiceLine."GST Jurisdiction Type" = TempServiceLine."GST Jurisdiction Type"::Interstate then
                                                ComponentName := IGSTLbl
                                            else
                                                ComponentName := CGSTLbl
                                        else
                                            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                                                ComponentName := CESSLbl;

                                        if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                                            TaxTransactionValue.Reset();
                                            TaxTransactionValue.SetRange("Tax Record ID", TempServiceLine.RecordId);
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
                                            TotalAmt += LineAmt + igst + sgst + cgst;
                                        end;
                                    until TempServiceLine.Next() = 0;

                                SumLineAmount := SumLineAmount + TempServiceLine."Line Amount";
                                SumInvDiscountAmount := SumInvDiscountAmount + TempServiceLine."Inv. Discount Amount";
                                /*  SumServiceLineExciseAmount := SumServiceLineExciseAmount + TempServiceLine."Excise Amount";
                                  SumServiceLineTaxAmount := SumServiceLineTaxAmount + TempServiceLine."Tax Amount";
                                  SumLineServiceTaxAmount := SumLineServiceTaxAmount + TempServiceLine."Service Tax Amount";
                                  SumLineServiceTaxECessAmount := SumLineServiceTaxECessAmount + TempServiceLine."Service Tax eCess Amount";
                                  SumLineServiceTaxSHECessAmount := SumLineServiceTaxSHECessAmount + TempServiceLine."Service Tax SHE Cess Amount";
                                  SumLineSvcTaxSBCAmount := SumLineSvcTaxSBCAmount + TempServiceLine."Service Tax SBC Amount";
                                  SumLineKKCessAmount := SumLineKKCessAmount + TempServiceLine."KK Cess Amount";*/ // 16630
                                SumServiceLineAmountToCusTomer := SumServiceLineAmountToCusTomer + TotalAmt;
                                // 16630 SumServiceLineAmountToCusTomer := SumServiceLineAmountToCusTomer + TempServiceLine."Amount To Customer";
                                TotalAmount :=
                                  SumLineAmount - SumInvDiscountAmount + SumServiceLineExciseAmount +
                                  SumServiceLineTaxAmount + ServiceTaxAmt + ServiceTaxECessAmt + ServiceTaxSHECessAmt + OtherTaxesAmount +
                                  ChargesAmount + AppliedServiceTaxAmt + AppliedServiceTaxECessAmt +
                                  AppliedServiceTaxSHECessAmt + ServiceTaxSBCAmt + AppliedServiceTaxSBCAmt +
                                  KKCessAmt + AppliedKKCessAmt + TotalGSTAmount;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowDim THEN
                                    CurrReport.BREAK;
                                FindDimTxt("Service Line"."Dimension Set ID");
                                SETRANGE(Number, 1, DimTxtArrLength);
                            end;
                        }
                        dataitem(LineErrorCounter; 2000000026)
                        {
                            DataItemTableView = SORTING(Number);
                            column(ErrorText_Number__Control97; ErrorText[Number])
                            {
                            }
                            column(ErrorText_Number__Control97Caption; ErrorText_Number__Control97CaptionLbl)
                            {
                            }

                            trigger OnPostDataItem()
                            begin
                                ErrorCounter := 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, ErrorCounter);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            ServCost: Record "Service Cost";
                            TableID: array[10] of Integer;
                            No: array[10] of Code[20];
                            ServiceHeader2: Record "Service Header";
                            // 16630       StrOrdLineDetails: Record 13795;
                            ServiceLine3: Record "Service Line";
                        // 16630        StructureLineDetails: Record 13795;
                        begin
                            IF Number = 1 THEN
                                TempServiceLine.FIND('-')
                            ELSE
                                TempServiceLine.NEXT;
                            "Service Line" := TempServiceLine;

                            WITH "Service Line" DO BEGIN
                                ServiceHeader2.GET("Document Type", "Document No.");
                                /*  IF ServiceHeader2.Trading THEN BEGIN
                                      StrOrdLineDetails.RESET;
                                      StrOrdLineDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
                                      StrOrdLineDetails.SETRANGE("Document Type", "Document Type");
                                      StrOrdLineDetails.SETRANGE("Document No.", "Document No.");
                                      StrOrdLineDetails.SETRANGE(Type, StrOrdLineDetails.Type::Service);
                                      StrOrdLineDetails.SETRANGE("Tax/Charge Type", StrOrdLineDetails."Tax/Charge Type"::Excise);

                                      ServiceLine3.RESET;
                                      ServiceLine3.SETRANGE("Document Type", "Document Type");
                                      ServiceLine3.SETRANGE("Document No.", "Document No.");
                                      ServiceLine3.SETRANGE(Type, ServiceLine3.Type::Item);
                                      ServiceLine3.SETRANGE("Excise Accounting Type", ServiceLine3."Excise Accounting Type"::"With CENVAT");
                                      IF ServiceLine3.FINDSET THEN
                                          REPEAT
                                              StrOrdLineDetails.SETRANGE("Line No.", ServiceLine3."Line No.");
                                              IF StrOrdLineDetails.FINDFIRST THEN BEGIN
                                                  Item.GET(ServiceLine3."No.");
                                                  IF Item."Capital Item" OR Item."Fixed Asset" THEN
                                                      AddError(STRSUBSTNO(Text16508, ServiceLine3."Document Type", ServiceLine3."Document No.", ServiceLine3."Line No."));
                                              END;
                                          UNTIL ServiceLine3.NEXT = 0;
                                  END;*/ // 16630
                                         // 16630     IF "Free Supply" AND ("Line Amount" < 0) THEN
                                AddError(STRSUBSTNO(Text16505, "Line Amount", "Document Type", "Document No.", "Line No."));

                                IF NOT "Service Header"."Prices Including VAT" AND
                                   ("VAT Calculation Type" = "VAT Calculation Type"::"Full VAT")
                                THEN
                                    TempServiceLine."Line Amount" := 0;
                                FilterAppliedEntries;
                                // 16630      IF (NOT "Service Header".Trading) AND ("CIF Amount" + "BCD Amount" = 0) AND CVD THEN
                                AddError(Text16504);

                                TempDimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                                IF "Document Type" = "Document Type"::"Credit Memo"
                                THEN BEGIN
                                    IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                                        IF "Qty. to Invoice" <> Quantity THEN
                                            AddError(STRSUBSTNO(Text015, FIELDCAPTION("Qty. to Invoice"), Quantity));
                                    END;
                                    IF "Qty. to Ship" <> 0 THEN
                                        AddError(STRSUBSTNO(Text043, FIELDCAPTION("Qty. to Ship")));
                                END ELSE
                                    IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                                        IF ("Qty. to Ship" <> Quantity) AND ("Shipment No." = '') THEN
                                            AddError(STRSUBSTNO(Text015, FIELDCAPTION("Qty. to Ship"), Quantity));
                                        IF "Qty. to Invoice" <> Quantity THEN
                                            AddError(STRSUBSTNO(Text015, FIELDCAPTION("Qty. to Invoice"), Quantity));
                                    END;

                                IF NOT Ship THEN
                                    "Qty. to Ship" := 0;

                                IF ("Document Type" = "Document Type"::Invoice) AND ("Shipment No." <> '') THEN BEGIN
                                    "Quantity Shipped" := Quantity;
                                    "Qty. to Ship" := 0;
                                END;

                                IF Invoice THEN BEGIN
                                    IF "Document Type" = "Document Type"::"Credit Memo" THEN
                                        MaxQtyToBeInvoiced := Quantity
                                    ELSE
                                        MaxQtyToBeInvoiced := "Qty. to Ship" + "Quantity Shipped" - "Quantity Invoiced";
                                    IF ABS("Qty. to Invoice") > ABS(MaxQtyToBeInvoiced) THEN
                                        "Qty. to Invoice" := MaxQtyToBeInvoiced;
                                END ELSE
                                    "Qty. to Invoice" := 0;

                                IF "Gen. Prod. Posting Group" <> '' THEN BEGIN
                                    IF ("Service Header"."Document Type" = "Service Header"."Document Type"::"Credit Memo") AND
                                       ("Service Header"."Applies-to Doc. Type" = "Service Header"."Applies-to Doc. Type"::Invoice) AND
                                       ("Service Header"."Applies-to Doc. No." <> '')
                                    THEN BEGIN
                                        CustLedgEntry.SETCURRENTKEY("Document No.");
                                        CustLedgEntry.SETRANGE("Customer No.", "Service Header"."Bill-to Customer No.");
                                        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
                                        CustLedgEntry.SETRANGE("Document No.", "Service Header"."Applies-to Doc. No.");
                                        IF NOT CustLedgEntry.FINDLAST AND NOT ApplNoError THEN BEGIN
                                            ApplNoError := TRUE;
                                            AddError(
                                              STRSUBSTNO(
                                                Text016,
                                                "Service Header".FIELDCAPTION("Applies-to Doc. No."), "Service Header"."Applies-to Doc. No."));
                                        END;
                                        VATDate := CustLedgEntry."Posting Date";
                                    END ELSE
                                        VATDate := "Service Header"."Posting Date";

                                    IF NOT VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group") THEN
                                        AddError(
                                          STRSUBSTNO(
                                            Text017,
                                            VATPostingSetup.TABLECAPTION, "VAT Bus. Posting Group", "VAT Prod. Posting Group"));
                                    IF VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" THEN
                                        IF ("Service Header"."VAT Registration No." = '') AND NOT VATNoError THEN BEGIN
                                            VATNoError := TRUE;
                                            AddError(
                                              STRSUBSTNO(
                                                Text035, "Service Header".FIELDCAPTION("VAT Registration No.")));
                                        END;
                                END;

                                CheckQuantity("Service Line");

                                ServiceLine := "Service Line";
                                IF NOT ("Document Type" = "Document Type"::"Credit Memo") THEN BEGIN
                                    ServiceLine."Qty. to Ship" := -ServiceLine."Qty. to Ship";
                                    ServiceLine."Qty. to Invoice" := -ServiceLine."Qty. to Invoice";
                                END;

                                RemQtyToBeInvoiced := ServiceLine."Qty. to Invoice";

                                CASE "Document Type" OF
                                    "Document Type"::Order, "Document Type"::Invoice:
                                        CheckShptLines("Service Line");
                                END;
                                CheckType("Service Line");
                                IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                                    AddError(DimMgt.GetDimCombErr);

                                IF Type = Type::Cost THEN BEGIN
                                    TableID[1] := DATABASE::"G/L Account";
                                    IF ServCost.GET("No.") THEN
                                        No[1] := ServCost."Account No.";
                                END ELSE BEGIN
                                    TableID[1] := DimMgt.TypeToTableID5(Type);
                                    No[1] := "No.";
                                END;
                                TableID[2] := DATABASE::Job;
                                No[2] := "Job No.";
                                IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") THEN
                                    AddError(DimMgt.GetDimValuePostingErr);
                                IF "Line No." > OrigMaxLineNo THEN BEGIN
                                    "No." := '';
                                    Type := Type::" ";
                                END;
                            END;
                            /*     CalculateTaxAmount(StructureLineDetails);
                                  CalculateGSTComponent;*/ // 16630
                        end;

                        trigger OnPostDataItem()
                        begin
                            /*   TotalAmount :=
                                 TempServiceLine."Line Amount" - TempServiceLine."Inv. Discount Amount" + TempServiceLine."Excise Amount" +
                                 TempServiceLine."Tax Amount" + ServiceTaxAmt + ServiceTaxECessAmt + ServiceTaxSHECessAmt + OtherTaxesAmount +
                                 ChargesAmount + AppliedServiceTaxAmt + AppliedServiceTaxECessAmt + AppliedServiceTaxSHECessAmt +
                                 ServiceTaxSBCAmt + AppliedServiceTaxSBCAmt + KKCessAmt + AppliedKKCessAmt + TotalGSTAmount;*/ // 16630
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATNoError := FALSE;
                            ApplNoError := FALSE;
                            /* CurrReport.CREATETOTALS(
                               TempServiceLine."Line Amount", TempServiceLine."Inv. Discount Amount", TempServiceLine."Excise Amount",
                               TempServiceLine."Tax Amount", TempServiceLine."Service Tax Amount",
                               TempServiceLine."Service Tax eCess Amount", TempServiceLine."Amount To Customer", TempServiceLine."Service Tax SBC Amount");
                             CurrReport.CREATETOTALS(TempServiceLine."KK Cess Amount");
                             CurrReport.CREATETOTALS(TempServiceLine."Service Tax SHE Cess Amount");*/ // 16630

                            MoreLines := TempServiceLine.FIND('+');
                            WHILE MoreLines AND (TempServiceLine.Description = '') AND (TempServiceLine."Description 2" = '') AND
                                  (TempServiceLine."No." = '') AND (TempServiceLine.Quantity = 0) AND
                                  (TempServiceLine.Amount = 0)
                            DO
                                MoreLines := TempServiceLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            TempServiceLine.SETRANGE("Line No.", 0, TempServiceLine."Line No.");
                            SETRANGE(Number, 1, TempServiceLine.COUNT);

                            SumLineAmount := 0;
                            SumInvDiscountAmount := 0;
                            SumServiceLineExciseAmount := 0;
                            SumServiceLineTaxAmount := 0;
                            SumLineServiceTaxAmount := 0;
                            SumLineServiceTaxECessAmount := 0;
                            SumLineServiceTaxSHECessAmount := 0;
                            SumServiceLineAmountToCusTomer := 0;
                            SumLineSvcTaxSBCAmount := 0;
                            SumLineKKCessAmount := 0;
                        end;
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Service Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control150; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control151; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Service Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control173; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control171; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control169; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control181; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control182; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Service Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control183; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control184; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control150Caption; VATAmountLine__VAT_Amount__Control150CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control151Caption; VATAmountLine__VAT_Base__Control151CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control173Caption; VATAmountLine__Invoice_Discount_Amount__Control173CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control171Caption; VATAmountLine__Inv__Disc__Base_Amount__Control171CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control169Caption; VATAmountLine__Line_Amount__Control169CaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
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
                              VATAmountLine."VAT Base", VATAmountLine."VAT Amount", VATAmountLine."Amount Including VAT",
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        ChargesToCustomer: Decimal;
                    begin
                        CLEAR(TempServiceLine);
                        CLEAR(ServAmountsMgt);
                        VATAmountLine.DELETEALL;
                        TempServiceLine.DELETEALL;
                        // 16630     ServAmountsMgt.GetServiceLines("Service Header", TempServiceLine, 1, ChargesToCustomer);
                        ServAmountsMgt.GetServiceLines("Service Header", TempServiceLine, 1);

                        // Ship prm added
                        TempServiceLine.CalcVATAmountLines(0, "Service Header", TempServiceLine, VATAmountLine, Ship);
                        TempServiceLine.UpdateVATOnLines(0, "Service Header", TempServiceLine, VATAmountLine);
                        VATAmount := VATAmountLine.GetTotalVATAmount;
                        VATBaseAmount := VATAmountLine.GetTotalVATBase;
                        VATDiscountAmount :=
                          VATAmountLine.GetTotalVATDiscount("Service Header"."Currency Code", "Service Header"."Prices Including VAT");
                        TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                        ChargesAmount := 0;
                        OtherTaxesAmount := 0;
                        AppliedServiceTaxSHECessAmt := 0;
                        AppliedServiceTaxAmt := 0;
                        AppliedServiceTaxECessAmt := 0;
                        TotalAmount := 0;
                        AppliedServiceTaxSBCAmt := 0;
                        AppliedKKCessAmt := 0;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                TableID: array[10] of Integer;
                No: array[10] of Code[20];
                ShipQtyExist: Boolean;
                STBaseAmt: Decimal;
            begin
                FormatAddr.ServiceHeaderSellTo(SellToAddr, "Service Header");
                FormatAddr.ServiceHeaderBillTo(BillToAddr, "Service Header");
                FormatAddr.ServiceHeaderShipTo(ShipToAddr, "Service Header");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text004, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text004, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, "Currency Code");
                END;
                // 16630   IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);
                Customer.GET("Bill-to Customer No.");

                Invoice := InvOnNextPostReq;
                Ship := ShipReceiveOnNextPostReq;
                CheckCustomerNo("Service Header", ShipQtyExist);
                IF "Bill-to Customer No." = '' THEN
                    AddError(STRSUBSTNO(Text006, FIELDCAPTION("Bill-to Customer No.")))
                ELSE BEGIN
                    IF "Bill-to Customer No." <> "Customer No." THEN
                        IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                            IF (Cust.Blocked = Cust.Blocked::All) OR
                               ((Cust.Blocked = Cust.Blocked::Invoice) AND
                                ("Document Type" = "Document Type"::"Credit Memo"))
                            THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text045,
                                    Cust.FIELDCAPTION(Blocked), FALSE, Cust.TABLECAPTION, "Bill-to Customer No."));
                        END ELSE
                            AddError(
                              STRSUBSTNO(
                                Text008,
                                Cust.TABLECAPTION, "Bill-to Customer No."));
                END;

                ServiceSetup.GET;

                IF "Posting Date" = 0D THEN
                    AddError(STRSUBSTNO(Text006, FIELDCAPTION("Posting Date")))
                ELSE
                    IF "Posting Date" <> NORMALDATE("Posting Date") THEN
                        AddError(STRSUBSTNO(Text009, FIELDCAPTION("Posting Date")))
                    ELSE BEGIN
                        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                            IF USERID <> '' THEN
                                IF UserSetup.GET(USERID) THEN BEGIN
                                    AllowPostingFrom := UserSetup."Allow Posting From";
                                    AllowPostingTo := UserSetup."Allow Posting To";
                                END;
                            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                                AllowPostingFrom := GLSetup."Allow Posting From";
                                AllowPostingTo := GLSetup."Allow Posting To";
                            END;
                            IF AllowPostingTo = 0D THEN
                                AllowPostingTo := 99991231D;
                        END;
                        IF ("Posting Date" < AllowPostingFrom) OR ("Posting Date" > AllowPostingTo) THEN
                            AddError(
                              STRSUBSTNO(
                                Text010, FIELDCAPTION("Posting Date")));
                    END;

                IF "Document Date" <> 0D THEN
                    IF "Document Date" <> NORMALDATE("Document Date") THEN
                        AddError(STRSUBSTNO(Text009, FIELDCAPTION("Document Date")));

                CASE "Document Type" OF
                    "Document Type"::Invoice:
                        BEGIN
                            Ship := TRUE;
                            Invoice := TRUE;
                        END;
                    "Document Type"::"Credit Memo":
                        BEGIN
                            Ship := FALSE;
                            Invoice := TRUE;
                        END;
                END;

                IF NOT (Ship OR Invoice) THEN
                    AddError(
                      STRSUBSTNO(
                        Text034,
                        Text001, Text002));
                CheckShipAndInvoice("Service Header");
                IF Invoice AND ("Posting No." = '') THEN
                    IF "Document Type" = "Document Type"::Order THEN
                        IF "Posting No. Series" = '' THEN
                            AddError(
                              STRSUBSTNO(
                                Text006,
                                FIELDCAPTION("Posting No. Series")));

                ServiceLine.RESET;
                ServiceLine.SETRANGE("Document Type", "Document Type");
                ServiceLine.SETRANGE("Document No.", "No.");
                IF ServiceLine.FINDFIRST THEN
                    DropShipOrder := TRUE;

                IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                    AddError(DimMgt.GetDimCombErr);

                TableID[1] := DATABASE::Customer;
                No[1] := "Bill-to Customer No.";
                TableID[3] := DATABASE::"Salesperson/Purchaser";
                No[3] := "Salesperson Code";
                TableID[4] := DATABASE::"Responsibility Center";
                No[4] := "Responsibility Center";

                IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") THEN
                    AddError(DimMgt.GetDimValuePostingErr);
                // 16630     CalculateTax("Service Header", STBaseAmt);
            end;

            trigger OnPreDataItem()
            begin
                ServiceHeader.COPY("Service Header");
                ServiceHeader.FILTERGROUP := 2;
                ServiceHeader.SETRANGE("Document Type", ServiceHeader."Document Type"::Order);
                IF ServiceHeader.FINDFIRST THEN BEGIN
                    CASE TRUE OF
                        ShipReceiveOnNextPostReq AND InvOnNextPostReq:
                            ShipInvText := Text000;
                        ShipReceiveOnNextPostReq:
                            ShipInvText := Text001;
                        InvOnNextPostReq:
                            ShipInvText := Text002;
                    END;
                    ShipInvText := STRSUBSTNO(Text003, ShipInvText);
                END;
                // 16630   TempSvcTaxAppllBuffer.DELETEALL;
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
                    group("Order Posting")
                    {
                        Caption = 'Order Posting';
                        field(ShipReceiveOnNextPostReq; ShipReceiveOnNextPostReq)
                        {
                            Caption = 'Ship';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT ShipReceiveOnNextPostReq THEN
                                    InvOnNextPostReq := TRUE;
                            end;
                        }
                        field(InvOnNextPostReq; InvOnNextPostReq)
                        {
                            Caption = 'Invoice';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT InvOnNextPostReq THEN
                                    ShipReceiveOnNextPostReq := TRUE;
                            end;
                        }
                    }
                    field(ShowDim; ShowDim)
                    {
                        Caption = 'Show Dimensions';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF NOT ShipReceiveOnNextPostReq AND NOT InvOnNextPostReq THEN BEGIN
                ShipReceiveOnNextPostReq := TRUE;
                InvOnNextPostReq := TRUE;
            END;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
    end;

    trigger OnPreReport()
    begin
        ServiceHeaderFilter := "Service Header".GETFILTERS;
    end;

    var
        Text000: Label 'Ship and Invoice';
        Text001: Label 'Ship';
        Text002: Label 'Invoice';
        Text003: Label 'Order Posting: %1';
        Text004: Label 'Total %1';
        Text006: Label '%1 must be specified.';
        Text007: Label '%1 must be %2 for %3 %4.';
        Text008: Label '%1 %2 does not exist.';
        Text009: Label '%1 must not be a closing date.';
        Text010: Label '%1 is not within your allowed range of posting dates.';
        Text012: Label 'There is nothing to post.';
        Text014: Label 'Service Document: %1';
        Text015: Label '%1 must be %2.';
        Text016: Label '%1 %2 does not exist on customer entries.';
        Text017: Label '%1 %2 %3 does not exist.';
        Text019: Label '%1 %2 must be specified.';
        Text020: Label '%1 must be 0 when %2 is 0.';
        Text024: Label 'The %1 on the shipment is not the same as the %1 on the Service Header.';
        Text026: Label 'Line %1 of the shipment %2, which you are attempting to invoice, has already been invoiced.';
        Text027: Label '%1 must have the same sign as the shipments.';
        Text034: Label 'Enter "Yes" in %1 and/or %2.';
        Text035: Label 'You must enter the customer''s %1.';
        Text036: Label 'The quantity you are attempting to invoice is greater than the quantity in shipment %1.';
        ServiceSetup: Record "Service Mgt. Setup";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        Cust: Record Customer;
        ServiceHeader: Record "Service Header";
        ServiceLine: Record "Service Line";
        ServiceLine2: Record "Service Line";
        TempServiceLine: Record "Service Line" temporary;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        Res: Record Resource;
        ServiceShptLine: Record "Service Shipment Line";
        GenPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        GenJnlLine: Record "Gen. Journal Line";
        SalesSetup: Record "Sales & Receivables Setup";
        // 16630    ServiceTaxEntry: Record 16473;
        // 16630    TempSvcTaxAppllBuffer: Record 16529 temporary;
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        CurrExchRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        CompanyInfo: Record "Company Information";
        // 16630   GSTComponent: Record 16405;
        DetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        // 16630    GSTManagement: Codeunit 16401;
        FormatAddr: Codeunit "Format Address";
        DimMgt: Codeunit DimensionManagement;
        ServAmountsMgt: Codeunit "Serv-Amounts Mgt.";
        ServiceHeaderFilter: Text;
        SellToAddr: array[8] of Text[50];
        BillToAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        ShipInvText: Text[50];
        ReceiveInvText: Text[50];
        DimText: Text;
        ErrorText: array[99] of Text[250];
        TaxType: Text[30];
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        VATDate: Date;
        MaxQtyToBeInvoiced: Decimal;
        RemQtyToBeInvoiced: Decimal;
        QtyToBeInvoiced: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        QtyToHandle: Decimal;
        SumLineAmount: Decimal;
        SumInvDiscountAmount: Decimal;
        AppliedServiceTaxAmt: Decimal;
        AppliedServiceTaxECessAmt: Decimal;
        AppliedServiceTaxSHECessAmt: Decimal;
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        TotalAmount: Decimal;
        SumServiceLineExciseAmount: Integer;
        SumServiceLineTaxAmount: Decimal;
        SumLineServiceTaxAmount: Decimal;
        SumLineServiceTaxECessAmount: Decimal;
        SumLineServiceTaxSHECessAmount: Decimal;
        SumServiceLineAmountToCusTomer: Decimal;
        ThirdPartyAmount: Decimal;
        ErrorCounter: Integer;
        OrigMaxLineNo: Integer;
        DropShipOrder: Boolean;
        InvOnNextPostReq: Boolean;
        ShipReceiveOnNextPostReq: Boolean;
        VATNoError: Boolean;
        ApplNoError: Boolean;
        ShowDim: Boolean;
        Text043: Label '%1 must be zero.';
        Text045: Label '%1 must not be %2 for %3 %4.';
        MoreLines: Boolean;
        Ship: Boolean;
        Invoice: Boolean;
        ServiceTaxExists: Boolean;
        DimTxtArrLength: Integer;
        DimTxtArr: array[500] of Text;
        Text16501: Label 'Please Check The Total of PLA , RG 23 A and RG 23 C with Excise Amount.';
        Text16504: Label 'Sum of CIF Amount and BCD Amount should not be 0 for CVD Calculation.';
        Text16505: Label 'Line Amount should not be %1 in Document Type = %2 Document No. = %3 Line No. = %4.';
        Text16508: Label 'Fixed asset or capital item must not be used in trading transaction in Document Type=%1,Document No.=%2,Line No.=%3.';
        Text16509: Label 'Tax Type must be %1 for Tax Jurisdiction in Tax Area Line %2';
        Text16523: Label 'The Applied Payment Document %1 should not have amount to apply greater than %2.';
        Text16524: Label 'Service Tax Advance Payment Document/s cannot be applied with non Service Tax Invoice/s.';
        Text16526: Label 'Document Type %1 should not be applied against a Refund document %2 having service tax on advance payment.';
        Text16527: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Rounding Precision/Type.';
        Text16528: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Group Codes.';
        Text16529: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Registration Nos.';
        Text16530: Label 'Payment Document with ST Pure Agent and Service Tax on Advance Payment should be applied with invoice having check mark on ST Pure Agent.';
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        Service_Document___TestCaptionLbl: Label 'Service Document - Test';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Ship_toCaptionLbl: Label 'Ship-to';
        CustomerCaptionLbl: Label 'Customer';
        Bill_toCaptionLbl: Label 'Bill-to';
        Service_Header___Posting_Date_CaptionLbl: Label 'Posting Date';
        Service_Header___Document_Date_CaptionLbl: Label 'Document Date';
        Service_Header___Due_Date_CaptionLbl: Label 'Due Date';
        Service_Header___Pmt__Discount_Date_CaptionLbl: Label 'Pmt. Discount Date';
        Service_Header___Posting_Date__Control105CaptionLbl: Label 'Posting Date';
        Service_Header___Document_Date__Control106CaptionLbl: Label 'Document Date';
        Service_Header___Order_Date_CaptionLbl: Label 'Order Date';
        Service_Header___Due_Date__Control19CaptionLbl: Label 'Due Date';
        Service_Header___Pmt__Discount_Date__Control22CaptionLbl: Label 'Pmt. Discount Date';
        Service_Header___Posting_Date__Control131CaptionLbl: Label 'Posting Date';
        Service_Header___Document_Date__Control132CaptionLbl: Label 'Document Date';
        Service_Header___Posting_Date__Control137CaptionLbl: Label 'Posting Date';
        Service_Header___Document_Date__Control138CaptionLbl: Label 'Document Date';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        ErrorText_Number_CaptionLbl: Label 'Warning!';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Service_Line___Line_Discount___CaptionLbl: Label 'Line Disc. %';
        Service_Line___Line_Discount_Amount_CaptionLbl: Label 'Line Discount Amount';
        AmountCaptionLbl: Label 'Amount';
        Service_Line__QuantityCaptionLbl: Label 'Quantity';
        QtyToHandleCaptionLbl: Label 'Qty. to Handle';
        TempServiceLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        TempServiceLine__Excise_Amount_CaptionLbl: Label 'Excise Amount';
        TempServiceLine__Tax_Amount_CaptionLbl: Label 'Tax Amount';
        ServiceTaxAmtCaptionLbl: Label 'Service Tax Amount';
        Charges_AmountCaptionLbl: Label 'Charges Amount';
        Other_Taxes_AmountCaptionLbl: Label 'Other Taxes Amount';
        ServiceTaxECessAmtCaptionLbl: Label 'Service TaxeCess Amount';
        Svc_Tax_Amt__Applied_CaptionLbl: Label 'Svc Tax Amt (Applied)';
        Svc_Tax_eCess_Amt__Applied_CaptionLbl: Label 'Svc Tax eCess Amt (Applied)';
        ServiceTaxSHECessAmtCaptionLbl: Label 'Service Tax SHECess Amt';
        Svc_Tax_SHECess_Amt_Applied_CaptionLbl: Label 'Svc Tax SHECess Amt(Applied)';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        ErrorText_Number__Control97CaptionLbl: Label 'Warning!';
        VATAmountLine__VAT_Amount__Control150CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control151CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__Invoice_Discount_Amount__Control173CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control171CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Line_Amount__Control169CaptionLbl: Label 'Line Amount';
        TotalCaptionLbl: Label 'Total';
        AppliedServiceTaxSBCAmt: Decimal;
        ServiceTaxSBCAmt: Decimal;
        SumLineSvcTaxSBCAmount: Decimal;
        ServiceTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        Svc_Tax_SBC_Amt__Applied_CaptionLbl: Label 'Svc Tax SBC Amt (Applied)';
        AppliedKKCessAmt: Decimal;
        KKCessAmt: Decimal;
        SumLineKKCessAmount: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        KKCess_Amt__Applied_CaptionLbl: Label 'KK Cess Amt (Applied)';
        CompanyRegistrationLbl: Label 'Company Registration No.';
        CustomerRegistrationLbl: Label 'Customer GST Reg No.';
        GSTCompAmount: array[20] of Decimal;
        TotalGSTAmount: Decimal;
        GSTComponentCode: array[20] of Code[10];
        IsGSTApplicable: Boolean;
        J: Integer;
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
        LineAmt: Decimal;


    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    local procedure CheckShptLines(ServiceLine2: Record "Service Line")
    var
        TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        WITH ServiceLine2 DO BEGIN
            IF ABS(RemQtyToBeInvoiced) > ABS("Qty. to Ship") THEN BEGIN
                ServiceShptLine.RESET;
                CASE "Document Type" OF
                    "Document Type"::Order:
                        BEGIN
                            ServiceShptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                            ServiceShptLine.SETRANGE("Order No.", "Document No.");
                            ServiceShptLine.SETRANGE("Order Line No.", "Line No.");
                        END;
                    "Document Type"::Invoice:
                        BEGIN
                            ServiceShptLine.SETRANGE("Document No.", "Shipment No.");
                            ServiceShptLine.SETRANGE("Line No.", "Shipment Line No.");
                        END;
                END;

                ServiceShptLine.SETFILTER("Qty. Shipped Not Invoiced", '<>0');

                IF ServiceShptLine.FIND('-') THEN
                    REPEAT
                        DimMgt.GetDimensionSet(TempPostedDimSetEntry, ServiceShptLine."Dimension Set ID");
                        IF NOT DimMgt.CheckDimIDConsistency(
                             TempDimSetEntry, TempPostedDimSetEntry, DATABASE::"Service Line", DATABASE::"Service Shipment Line")
                        THEN
                            AddError(DimMgt.GetDocDimConsistencyErr);

                        IF ServiceShptLine."Customer No." <> "Customer No." THEN
                            AddError(
                              STRSUBSTNO(
                                Text024,
                                FIELDCAPTION("Customer No.")));
                        IF ServiceShptLine.Type <> Type THEN
                            AddError(
                              STRSUBSTNO(
                                Text024,
                                FIELDCAPTION(Type)));
                        IF ServiceShptLine."No." <> "No." THEN
                            AddError(
                              STRSUBSTNO(
                                Text024,
                                FIELDCAPTION("No.")));
                        IF ServiceShptLine."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                            AddError(
                              STRSUBSTNO(
                                Text024,
                                FIELDCAPTION("Gen. Bus. Posting Group")));
                        IF ServiceShptLine."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
                            AddError(
                              STRSUBSTNO(
                                Text024,
                                FIELDCAPTION("Gen. Prod. Posting Group")));
                        IF ServiceShptLine."Location Code" <> "Location Code" THEN
                            AddError(
                              STRSUBSTNO(
                                Text024,
                                FIELDCAPTION("Location Code")));

                        IF -ServiceLine."Qty. to Invoice" * ServiceShptLine.Quantity < 0 THEN
                            AddError(
                              STRSUBSTNO(
                                Text027, FIELDCAPTION("Qty. to Invoice")));

                        QtyToBeInvoiced := RemQtyToBeInvoiced - ServiceLine."Qty. to Ship";
                        IF ABS(QtyToBeInvoiced) > ABS(ServiceShptLine.Quantity - ServiceShptLine."Quantity Invoiced") THEN
                            QtyToBeInvoiced := -(ServiceShptLine.Quantity - ServiceShptLine."Quantity Invoiced");
                        RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
                        ServiceShptLine."Quantity Invoiced" := ServiceShptLine."Quantity Invoiced" - QtyToBeInvoiced;
                        ServiceShptLine."Qty. Shipped Not Invoiced" :=
                          ServiceShptLine.Quantity - ServiceShptLine."Quantity Invoiced"
                    UNTIL (ServiceShptLine.NEXT = 0) OR (ABS(RemQtyToBeInvoiced) <= ABS("Qty. to Ship"))
                ELSE
                    AddError(
                      STRSUBSTNO(
                        Text026,
                        "Shipment Line No.",
                        "Shipment No."));
            END;

            IF ABS(RemQtyToBeInvoiced) > ABS("Qty. to Ship") THEN
                IF "Document Type" = "Document Type"::Invoice THEN
                    AddError(
                      STRSUBSTNO(
                        Text036,
                        "Shipment No."));
        END;
    end;

    procedure FindDimTxt(DimSetID: Integer)
    var
        i: Integer;
        TxtToAdd: Text[120];
        Separation: Text[5];
        StartNewLine: Boolean;
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimTxtArrLength := 0;
        FOR i := 1 TO ARRAYLEN(DimTxtArr) DO
            DimTxtArr[i] := '';
        IF NOT DimSetEntry.FINDSET THEN
            EXIT;
        Separation := '; ';
        REPEAT
            TxtToAdd := DimSetEntry."Dimension Code" + ' - ' + DimSetEntry."Dimension Value Code";
            IF DimTxtArrLength = 0 THEN
                StartNewLine := TRUE
            ELSE
                StartNewLine := STRLEN(DimTxtArr[DimTxtArrLength]) + STRLEN(Separation) + STRLEN(TxtToAdd) > MAXSTRLEN(DimTxtArr[1]);
            IF StartNewLine THEN BEGIN
                DimTxtArrLength += 1;
                DimTxtArr[DimTxtArrLength] := TxtToAdd
            END ELSE
                DimTxtArr[DimTxtArrLength] := DimTxtArr[DimTxtArrLength] + Separation + TxtToAdd;
        UNTIL DimSetEntry.NEXT = 0;
    end;

    /*  procedure CheckTotalExciseAmount()
      var
        ExciseCenvatClaim: Record 16584;
      begin
          ExciseCenvatClaim.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
          ExciseCenvatClaim.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
          ExciseCenvatClaim.SETRANGE("Line No.", GenJnlLine."Line No.");
          ExciseCenvatClaim.SETRANGE("Document No.", GenJnlLine."Document No.");
          IF ExciseCenvatClaim.FINDFIRST THEN
              IF (ExciseCenvatClaim."BED Amount" <> ExciseCenvatClaim."PLA BED Amount") OR
                 (ExciseCenvatClaim."AED(GSI) Amount" <> ExciseCenvatClaim."PLA AED(GSI) Amount") OR
                 (ExciseCenvatClaim."AED(TTA) Amount" <> ExciseCenvatClaim."PLA AED(TTA) Amount") OR
                 (ExciseCenvatClaim."SED Amount" <> ExciseCenvatClaim."PLA SED Amount") OR
                 (ExciseCenvatClaim."SAED Amount" <> ExciseCenvatClaim."PLA SAED Amount") OR
                 (ExciseCenvatClaim."CESS Amount" <> ExciseCenvatClaim."PLA CESS Amount") OR
                 (ExciseCenvatClaim."NCCD Amount" <> ExciseCenvatClaim."PLA NCCD Amount") OR
                 (ExciseCenvatClaim."eCess Amount" <> ExciseCenvatClaim."PLA eCess Amount") OR
                 (ExciseCenvatClaim."SHE Cess Amount" <> ExciseCenvatClaim."PLA SHE Cess Amount") OR
                 (ExciseCenvatClaim."ADET Amount" <> ExciseCenvatClaim."PLA ADET Amount") OR
                 (ExciseCenvatClaim."ADE Amount" <> ExciseCenvatClaim."PLA ADE Amount") OR
                 (ExciseCenvatClaim."Excise Charge Amount" <> ExciseCenvatClaim."PLA Excise Charge Amount")
               THEN
                  AddError(Text16501);
      end;*/ // 16630

    procedure FilterAppliedEntries()
    var
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        // 16630    ServiceTaxEntry: Record 16473;
        Cust: Record Customer;
        Currency: Record Currency;
        GenLedgSetup: Record "General Ledger Setup";
        ServiceLine3: Record "Service Line";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        ApplyingDate: Date;
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AmountforAppl: Decimal;
        AppliedAmount: Decimal;
        AppliedAmountLCY: Decimal;
        RemainingAmount: Decimal;
        AmountToBeApplied: Decimal;
        AppliedServiceTaxAmount: Decimal;
        AppliedServiceTaxEcessAmount: Decimal;
        AppliedServiceTaxSHEcessAmount: Decimal;
        AppliedServiceTaxSBCAmount: Decimal;
        AppliedKKCessAmount: Decimal;
    begin
        WITH "Service Header" DO BEGIN
            AmountforAppl := TotalAmt;
            // 16630 AmountforAppl := TempServiceLine."Amount To Customer";
            ApplyingDate := "Posting Date";
            IF "Service Header"."Bill-to Customer No." <> '' THEN
                Cust.GET("Bill-to Customer No.")
            ELSE
                Cust.GET("Customer No.");
            IF "Applies-to Doc. No." <> '' THEN BEGIN
                OldCustLedgEntry.SETCURRENTKEY("Document No.");
                OldCustLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                OldCustLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                OldCustLedgEntry.SETRANGE("Customer No.", "Bill-to Customer No.");
                OldCustLedgEntry.SETRANGE(Open, TRUE);
                OldCustLedgEntry.FINDFIRST;
                // 16630      IF NOT OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
                EXIT;
                IF OldCustLedgEntry."Posting Date" > ApplyingDate THEN
                    ApplyingDate := OldCustLedgEntry."Posting Date";
                GenJnlApply.CheckAgainstApplnCurrency("Currency Code", OldCustLedgEntry."Currency Code", AccType::Vendor, TRUE);
                OldCustLedgEntry.CALCFIELDS("Remaining Amount");
                IF "Currency Code" <> '' THEN BEGIN
                    Currency.GET("Currency Code");
                    FindAmtForAppln(
                      OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                      OldCustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision", AmountforAppl);
                END ELSE BEGIN
                    GenLedgSetup.GET;
                    FindAmtForAppln(
                      OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                      OldCustLedgEntry."Remaining Amount", GenLedgSetup."Amount Rounding Precision", AmountforAppl);
                END;

                AppliedAmountLCY := ABS(AppliedAmountLCY);
                // 16630  CheckAppliedInvHasServTax(OldCustLedgEntry);
                /* 16630  CheckRoundingParameters(OldCustLedgEntry);
                  CheckRefundApplicationOnline(OldCustLedgEntry);
                  CheckApplofSTpureAgntOnline(OldCustLedgEntry);

                 IF TempServiceLine."Service Tax Amount" <> 0 THEN BEGIN
                      ServiceTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                      ServiceTaxEntry.SETRANGE("Service Tax Group Code", "Service Line"."Service Tax Group");
                      ServiceTaxEntry.SETRANGE("Service Tax Registration No.", "Service Line"."Service Tax Registration No.");
                      ServiceTaxEntry.SETRANGE("ST Pure Agent", FALSE);
                      IF ServiceTaxEntry.FINDSET THEN
                          REPEAT
                              RemainingAmount := 0;
                              AmountToBeApplied := 0;
                              RemainingAmount := ABS(ServiceTaxEntry."Amount Including Service Tax" - ServiceTaxEntry."Amount Received/Paid");
                              IF RemainingAmount > 0 THEN BEGIN
                                  IF RemainingAmount >= ABS(AppliedAmountLCY) THEN
                                      AmountToBeApplied := ABS(AppliedAmountLCY)
                                  ELSE
                                      AmountToBeApplied := RemainingAmount;
                              END;
                              AppliedAmountLCY -= AmountToBeApplied;
                              CheckAppliedCustPayment(OldCustLedgEntry, AmountToBeApplied, AmountforAppl);
                              AmountforAppl -= AmountToBeApplied;
                              AppliedServiceTaxAmount :=
                                (AmountToBeApplied / ServiceTaxEntry."Amount Including Service Tax") *
                                (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                 ServiceTaxEntry."SHE Cess Amount" +
                                  ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                              AppliedServiceTaxEcessAmount :=
                                (AppliedServiceTaxAmount * ServiceTaxEntry."eCess Amount") /
                                (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                 ServiceTaxEntry."SHE Cess Amount" +
                                  ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                              AppliedServiceTaxSHEcessAmount :=
                                (AppliedServiceTaxAmount * ServiceTaxEntry."SHE Cess Amount") /
                                (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                 ServiceTaxEntry."SHE Cess Amount" +
                                  ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                              AppliedServiceTaxSBCAmount :=
                                (AppliedServiceTaxAmount * ServiceTaxEntry."Service Tax SBC Amount") /
                                (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                 ServiceTaxEntry."SHE Cess Amount" +
                                  ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                              AppliedKKCessAmount :=
                                (AppliedServiceTaxAmount * ServiceTaxEntry."KK Cess Amount") /
                                (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                 ServiceTaxEntry."SHE Cess Amount" +
                                  ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");

                              AppliedServiceTaxSHEcessAmount := ROUND(AppliedServiceTaxSHEcessAmount);
                              AppliedServiceTaxEcessAmount := ROUND(AppliedServiceTaxEcessAmount);
                              AppliedServiceTaxSBCAmount := ROUND(AppliedServiceTaxSBCAmount);
                              AppliedKKCessAmount := ROUND(AppliedKKCessAmount);
                              AppliedServiceTaxAmount :=
                                ROUND(AppliedServiceTaxAmount - AppliedServiceTaxEcessAmount - AppliedServiceTaxSHEcessAmount -
                                  AppliedServiceTaxSBCAmount - AppliedKKCessAmount);
                              AppliedServiceTaxSHECessAmt += AppliedServiceTaxSHEcessAmount;
                              AppliedServiceTaxECessAmt += AppliedServiceTaxEcessAmount;
                              AppliedServiceTaxAmt += AppliedServiceTaxAmount;
                              AppliedServiceTaxSBCAmt += AppliedServiceTaxSBCAmount;
                              AppliedKKCessAmt += AppliedKKCessAmount;
                          UNTIL (ServiceTaxEntry.NEXT = 0) OR (AppliedAmountLCY = 0);
                  END;*/ // 16630
            END ELSE
                IF "Applies-to ID" <> '' THEN BEGIN
                    // Find the first old entry (Invoice) which the new entry (Payment) should apply to
                    OldCustLedgEntry.RESET;
                    OldCustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                    OldCustLedgEntry.SETRANGE("Customer No.", "Bill-to Customer No.");
                    OldCustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                    OldCustLedgEntry.SETRANGE(Open, TRUE);
                    IF NOT (Cust."Application Method" = Cust."Application Method"::"Apply to Oldest") THEN
                        OldCustLedgEntry.SETFILTER("Amount to Apply", '<>0');
                    IF Cust."Application Method" = Cust."Application Method"::"Apply to Oldest" THEN
                        OldCustLedgEntry.SETFILTER("Posting Date", '..%1', GenJnlLine."Posting Date");

                    // Check Cust Ledger Entry and add to Temp.
                    IF SalesSetup."Appln. between Currencies" = SalesSetup."Appln. between Currencies"::None THEN
                        OldCustLedgEntry.SETRANGE("Currency Code", "Currency Code");

                    IF OldCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            // 16630      IF OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
                            IF GenJnlApply.CheckAgainstApplnCurrency(
                              "Currency Code", OldCustLedgEntry."Currency Code", AccType::Vendor, FALSE)
                            THEN BEGIN
                                IF (OldCustLedgEntry."Posting Date" > ApplyingDate) AND (OldCustLedgEntry."Applies-to ID" <> '') THEN
                                    ApplyingDate := OldCustLedgEntry."Posting Date";
                                OldCustLedgEntry.CALCFIELDS("Remaining Amount");
                                IF "Currency Code" <> '' THEN BEGIN
                                    Currency.GET("Currency Code");
                                    FindAmtForAppln(
                                      OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                                      OldCustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision", AmountforAppl);
                                END ELSE BEGIN
                                    GenLedgSetup.GET;
                                    FindAmtForAppln(OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                                    OldCustLedgEntry."Remaining Amount", GenLedgSetup."Amount Rounding Precision", AmountforAppl);
                                END;

                                AppliedAmountLCY := ABS(AppliedAmountLCY);
                                // 16630    CheckAppliedInvHasServTax(OldCustLedgEntry);
                                /*   CheckRoundingParameters(OldCustLedgEntry);
                                   CheckRefundApplicationOnline(OldCustLedgEntry);
                                   CheckApplofSTpureAgntOnline(OldCustLedgEntry);*/ // 16630

                                /* 16630    IF TempServiceLine."Service Tax Amount" <> 0 THEN BEGIN
                                        ServiceTaxEntry.RESET;
                                        ServiceTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                                        ServiceTaxEntry.SETRANGE("Service Tax Group Code", "Service Line"."Service Tax Group");
                                        ServiceTaxEntry.SETRANGE("Service Tax Registration No.", "Service Line"."Service Tax Registration No.");
                                        ServiceTaxEntry.SETRANGE("ST Pure Agent", FALSE);
                                        IF ServiceTaxEntry.FINDSET THEN
                                            REPEAT
                                                RemainingAmount := 0;
                                                AmountToBeApplied := 0;
                                                RemainingAmount := ABS(ServiceTaxEntry."Amount Including Service Tax" - ServiceTaxEntry."Amount Received/Paid");
                                                IF RemainingAmount > 0 THEN BEGIN
                                                    IF RemainingAmount >= ABS(AppliedAmountLCY) THEN
                                                        AmountToBeApplied := ABS(AppliedAmountLCY)
                                                    ELSE
                                                        AmountToBeApplied := RemainingAmount;
                                                END;
                                                AppliedAmountLCY -= AmountToBeApplied;
                                                CheckAppliedCustPayment(OldCustLedgEntry, AmountToBeApplied, AmountforAppl);
                                                AmountforAppl -= AmountToBeApplied;
                                                AppliedServiceTaxAmount :=
                                                  (AmountToBeApplied / ServiceTaxEntry."Amount Including Service Tax") *
                                                  (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                                   ServiceTaxEntry."SHE Cess Amount" +
                                                    ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                                                AppliedServiceTaxEcessAmount :=
                                                  (AppliedServiceTaxAmount * ServiceTaxEntry."eCess Amount") /
                                                  (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                                   ServiceTaxEntry."SHE Cess Amount" +
                                                    ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                                                AppliedServiceTaxSHEcessAmount :=
                                                  (AppliedServiceTaxAmount * ServiceTaxEntry."SHE Cess Amount") /
                                                  (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                                   ServiceTaxEntry."SHE Cess Amount" +
                                                    ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                                                AppliedServiceTaxSBCAmount :=
                                                  (AppliedServiceTaxAmount * ServiceTaxEntry."Service Tax SBC Amount") /
                                                  (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                                   ServiceTaxEntry."SHE Cess Amount" +
                                                    ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                                                AppliedKKCessAmount :=
                                                  (AppliedServiceTaxAmount * ServiceTaxEntry."Service Tax SBC Amount") /
                                                  (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                                   ServiceTaxEntry."SHE Cess Amount" +
                                                    ServiceTaxEntry."Service Tax SBC Amount" + ServiceTaxEntry."KK Cess Amount");
                                                AppliedServiceTaxSHEcessAmount := ROUND(AppliedServiceTaxSHEcessAmount);
                                                AppliedServiceTaxEcessAmount := ROUND(AppliedServiceTaxEcessAmount);
                                                AppliedServiceTaxSBCAmount := ROUND(AppliedServiceTaxSBCAmount);
                                                AppliedKKCessAmount := ROUND(AppliedKKCessAmount);
                                                AppliedServiceTaxAmount :=
                                                  ROUND(AppliedServiceTaxAmount - AppliedServiceTaxEcessAmount - AppliedServiceTaxSHEcessAmount -
                                                  AppliedServiceTaxSBCAmount - AppliedKKCessAmount);

                                                AppliedServiceTaxSHECessAmt += AppliedServiceTaxSHEcessAmount;
                                                AppliedServiceTaxECessAmt += AppliedServiceTaxEcessAmount;
                                                AppliedServiceTaxAmt += AppliedServiceTaxAmount;
                                                AppliedServiceTaxSBCAmt += AppliedServiceTaxSBCAmount;
                                                AppliedKKCessAmt += AppliedKKCessAmount;
                                            UNTIL (ServiceTaxEntry.NEXT = 0) OR (AppliedAmountLCY = 0);
                                    END;*/ // 16630
                            END;
                        UNTIL OldCustLedgEntry.NEXT = 0;
                END;
        END;
        ServiceLine3.COPYFILTERS("Service Line");
        ServiceLine3 := "Service Line";
        IF ServiceLine3.NEXT = 0 THEN BEGIN
            /*   AppliedServiceTaxSHECessAmt := RoundServiceTaxPrecision(AppliedServiceTaxSHECessAmt);
               AppliedServiceTaxECessAmt := RoundServiceTaxPrecision(AppliedServiceTaxECessAmt);
               AppliedServiceTaxAmt := RoundServiceTaxPrecision(AppliedServiceTaxAmt);
               AppliedServiceTaxSBCAmt := RoundServiceTaxPrecision(AppliedServiceTaxSBCAmt);
               AppliedKKCessAmt := RoundServiceTaxPrecision(AppliedKKCessAmt);*/ // 16630
            ServiceTaxAmt -= ROUND(AppliedServiceTaxAmt);
            ServiceTaxECessAmt -= ROUND(AppliedServiceTaxECessAmt);
            ServiceTaxSHECessAmt -= ROUND(AppliedServiceTaxSHECessAmt);
            ServiceTaxSBCAmt -= ROUND(AppliedServiceTaxSBCAmt);
            KKCessAmt -= ROUND(AppliedKKCessAmt);

            /*    ServiceTaxAmt := RoundServiceTaxPrecision(ServiceTaxAmt);
                ServiceTaxECessAmt := RoundServiceTaxPrecision(ServiceTaxECessAmt);
                ServiceTaxSHECessAmt := RoundServiceTaxPrecision(ServiceTaxSHECessAmt);
                ServiceTaxSBCAmt := RoundServiceTaxPrecision(ServiceTaxSBCAmt);
                KKCessAmt := RoundServiceTaxPrecision(KKCessAmt);*/ // 16630
        END;
        IF ServiceTaxSHECessAmt < 0 THEN
            ServiceTaxSHECessAmt := 0;
        IF ServiceTaxECessAmt < 0 THEN
            ServiceTaxECessAmt := 0;
        IF ServiceTaxAmt < 0 THEN
            ServiceTaxAmt := 0;
        IF ServiceTaxSBCAmt < 0 THEN
            ServiceTaxSBCAmt := 0;
        IF KKCessAmt < 0 THEN
            KKCessAmt := 0;
    end;

    local procedure FindAmtForAppln(OldCustLedgEntry: Record "Cust. Ledger Entry"; var AppliedAmount: Decimal; var AppliedAmountLCY: Decimal; OldRemainingAmtBeforeAppln: Decimal; ApplnRoundingPrecision: Decimal; AmountforAppl: Decimal)
    var
        OldAppliedAmount: Decimal;
    begin
        IF OldCustLedgEntry.GETFILTER(Positive) <> '' THEN BEGIN
            IF OldCustLedgEntry."Amount to Apply" <> 0 THEN
                AppliedAmount := -OldCustLedgEntry."Amount to Apply"
            ELSE
                AppliedAmount := -OldCustLedgEntry."Remaining Amount";
        END ELSE BEGIN
            IF OldCustLedgEntry."Amount to Apply" <> 0 THEN BEGIN
                IF (CheckCalcPmtDisc(OldCustLedgEntry, ApplnRoundingPrecision, FALSE, FALSE, AmountforAppl) AND
                   (ABS(OldCustLedgEntry."Amount to Apply") >=
                    ABS(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible")) AND
                   (ABS(AmountforAppl) >=
                     ABS(OldCustLedgEntry."Amount to Apply" - OldCustLedgEntry."Remaining Pmt. Disc. Possible"))) OR
                   OldCustLedgEntry."Accepted Pmt. Disc. Tolerance"
                THEN BEGIN
                    AppliedAmount := -OldCustLedgEntry."Remaining Amount";
                    OldCustLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
                END ELSE BEGIN
                    IF ABS(AmountforAppl) <= ABS(OldCustLedgEntry."Amount to Apply") THEN
                        AppliedAmount := AmountforAppl
                    ELSE
                        AppliedAmount := -OldCustLedgEntry."Amount to Apply";
                END;
            END ELSE
                IF ABS(AmountforAppl) < ABS(OldCustLedgEntry."Remaining Amount") THEN
                    AppliedAmount := AmountforAppl
                ELSE
                    AppliedAmount := -OldCustLedgEntry."Remaining Amount";
        END;

        IF ServiceHeader."Currency Code" = OldCustLedgEntry."Currency Code" THEN BEGIN
            AppliedAmountLCY := ROUND(AppliedAmount / OldCustLedgEntry."Original Currency Factor");
            OldAppliedAmount := AppliedAmount;
        END ELSE BEGIN
            IF AppliedAmount = -OldCustLedgEntry."Remaining Amount" THEN
                OldAppliedAmount := -OldCustLedgEntry."Remaining Amount"
            ELSE
                OldAppliedAmount :=
                  CurrExchRate.ExchangeAmount(
                    AppliedAmount, ServiceHeader."Currency Code",
                    OldCustLedgEntry."Currency Code", ServiceHeader."Posting Date");

            IF ServiceHeader."Currency Code" <> '' THEN
                AppliedAmountLCY := ROUND(OldAppliedAmount / OldCustLedgEntry."Original Currency Factor")
            ELSE
                AppliedAmountLCY := ROUND(AppliedAmount / ServiceHeader."Currency Factor");
        END;
    end;

    local procedure CheckCalcPmtDisc(var OldCustLedgEntry: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckFilter: Boolean; CheckAmount: Boolean; AmountforAppl: Decimal): Boolean
    begin
        IF (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) AND
          (ServiceHeader."Posting Date" <= OldCustLedgEntry."Pmt. Discount Date")
        THEN BEGIN
            IF CheckFilter THEN BEGIN
                IF CheckAmount THEN
                    EXIT(
                      (OldCustLedgEntry.GETFILTER(Positive) <> '') OR
                      (ABS(AmountforAppl) + ApplnRoundingPrecision >=
                       ABS(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible")));
                EXIT(OldCustLedgEntry.GETFILTER(Positive) <> '');
            END;
            IF CheckAmount THEN
                EXIT(
                  ABS(AmountforAppl) + ApplnRoundingPrecision >=
                  ABS(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible"));
            EXIT(TRUE);
        END;
    end;

    /*  procedure RoundServiceTaxPrecision(ServiceTaxAmount: Decimal): Decimal
      var
          ServiceTaxRoundingDirection: Text[1];
          ServiceTaxRoundingPrecision: Decimal;
      begin
          CASE "Service Header"."Service Tax Rounding Type" OF
              "Service Header"."Service Tax Rounding Type"::Nearest:
                  ServiceTaxRoundingDirection := '=';
              "Service Header"."Service Tax Rounding Type"::Up:
                  ServiceTaxRoundingDirection := '>';
              "Service Header"."Service Tax Rounding Type"::Down:
                  ServiceTaxRoundingDirection := '<';
          END;
          IF "Service Header"."Service Tax Rounding Precision" <> 0 THEN
              ServiceTaxRoundingPrecision := "Service Header"."Service Tax Rounding Precision"
          ELSE
              ServiceTaxRoundingPrecision := 0.01;
          EXIT(ROUND(ServiceTaxAmount, ServiceTaxRoundingPrecision, ServiceTaxRoundingDirection));
      end;*/ // 16630

    /*  procedure CheckAppliedInvHasServTax(OldCustLedgEntry: Record 21)
      var
           SvcTaxEntry: Record 16473;
          ServiceLine3: Record 5902;
      begin
          IF OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Payment THEN BEGIN
              IF NOT OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
                  EXIT;
              IF NOT ServiceTaxExists THEN BEGIN
                  ServiceTaxEntry.RESET;
                  ServiceTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                  IF ServiceTaxEntry.FINDFIRST THEN
                      AddError(Text16524);
              END;

             IF ServiceTaxExists THEN BEGIN
               SvcTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                  IF SvcTaxEntry.FINDFIRST THEN BEGIN
                      ServiceLine3.RESET;
                      ServiceLine3.SETRANGE("Document Type", "Service Line"."Document Type");
                      ServiceLine3.SETRANGE("Document No.", "Service Line"."Document No.");
                    ServiceLine3.SETRANGE("Service Tax Group", SvcTaxEntry."Service Tax Group Code");
                      IF NOT ServiceLine3.FINDFIRST THEN
                          AddError(Text16528);
                    ServiceLine3.SETRANGE("Service Tax Group");
                      ServiceLine3.SETRANGE("Service Tax Registration No.", SvcTaxEntry."Service Tax Registration No.");
                      IF NOT ServiceLine3.FINDFIRST THEN
                          AddError(Text16529);
                  END;
              END;
          END;
      end;*/ // 16630

    /*  procedure CheckRefundApplicationOnline(OldCustLedgEntry: Record 21)
     begin
          IF OldCustLedgEntry."Serv. Tax on Advance Payment" AND
            (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Refund)
          THEN
              AddError(STRSUBSTNO(Text16526, "Service Header"."Document Type", OldCustLedgEntry."Document No."));
      end;*/ // 16630

    /*  procedure CheckRoundingParameters(OldCustLedgEntry: Record 21)
      var
          SvcTaxEntry: Record 16473;
      begin
          IF TempServiceLine."Service Tax Amount" = 0 THEN
              EXIT;
          SvcTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
          IF NOT SvcTaxEntry.FINDFIRST THEN
              EXIT;
          IF (SvcTaxEntry."Service Tax Amount" + SvcTaxEntry."eCess Amount" + SvcTaxEntry."SHE Cess Amount" +
            SvcTaxEntry."Service Tax SBC Amount" + SvcTaxEntry."KK Cess Amount") = 0 THEN
              EXIT;
          IF ("Service Header"."Service Tax Rounding Precision" <> SvcTaxEntry."Service Tax Rounding Precision") OR
            ("Service Header"."Service Tax Rounding Type" <> SvcTaxEntry."Service Tax Rounding Type")
          THEN
              AddError(Text16527);
      end;*/ // 16630

    /*   procedure CheckAppliedCustPayment(OldCustLedgEntry: Record 21; AmountToBeApplied: Decimal; AmountToBeComparedWith: Decimal)
       var
           SvcTaxEntry: Record 16473;
           EntryInserted: Boolean;
       begin
           IF NOT OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
               EXIT;
           SvcTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
           SvcTaxEntry.SETRANGE("Service Tax Group Code", "Service Line"."Service Tax Group");
           SvcTaxEntry.SETRANGE("Service Tax Registration No.", "Service Line"."Service Tax Registration No.");
           IF SvcTaxEntry.FINDFIRST THEN BEGIN
               TempSvcTaxAppllBuffer.Type := TempSvcTaxAppllBuffer.Type::Sale;
               TempSvcTaxAppllBuffer."Document No." := OldCustLedgEntry."Document No.";
               TempSvcTaxAppllBuffer."Service Tax Group Code" := SvcTaxEntry."Service Tax Group Code";
               TempSvcTaxAppllBuffer."Service Tax Registration No." := SvcTaxEntry."Service Tax Registration No.";
               TempSvcTaxAppllBuffer."Transaction No." := OldCustLedgEntry."Transaction No.";
               TempSvcTaxAppllBuffer."Amount to Apply (LCY)" := AmountToBeComparedWith;
               EntryInserted := TempSvcTaxAppllBuffer.INSERT;

               IF TempSvcTaxAppllBuffer."Amount to Apply (LCY)" < ABS(OldCustLedgEntry."Amount to Apply") THEN
                   AddError(STRSUBSTNO(Text16523, OldCustLedgEntry."Document No.", -TempSvcTaxAppllBuffer."Amount to Apply (LCY)"));
               TempSvcTaxAppllBuffer."Amount to Apply (LCY)" -= AmountToBeApplied;
               TempSvcTaxAppllBuffer.MODIFY;
           END;
       end;*/ // 16630

    /*   procedure CheckApplofSTpureAgntOnline(OldCustLedgEntry: Record 21)
        var
            ServTaxEntry: Record 16473;
        begin
            IF OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Payment THEN
                IF OldCustLedgEntry."Serv. Tax on Advance Payment" THEN BEGIN
                    ServTaxEntry.RESET;
                    ServTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                    IF ServTaxEntry.FINDFIRST THEN
                        IF ServTaxEntry."ST Pure Agent" <> "Service Header"."ST Pure Agent" THEN
                            AddError(Text16530);
                END;
        end;*/ // 16630

    procedure CheckQuantity(var ServiceLine: Record "Service Line")
    begin
        WITH ServiceLine DO BEGIN
            IF Quantity <> 0 THEN BEGIN
                IF "No." = '' THEN
                    AddError(STRSUBSTNO(Text019, Type, FIELDCAPTION("No.")));
                IF Type = 0 THEN
                    AddError(STRSUBSTNO(Text006, FIELDCAPTION(Type)));
            END ELSE
                IF Amount <> 0 THEN
                    AddError(
                      STRSUBSTNO(Text020, FIELDCAPTION(Amount), FIELDCAPTION(Quantity)));
        END;
    end;

    procedure InitializeRequest(ShipReceiveOnNextPostReqFrom: Boolean; InvOnNextPostReqFrom: Boolean; ShowDimFrom: Boolean)
    begin
        ShipReceiveOnNextPostReq := ShipReceiveOnNextPostReqFrom;
        IF NOT ShipReceiveOnNextPostReq THEN
            InvOnNextPostReq := TRUE;
        InvOnNextPostReq := InvOnNextPostReqFrom;
        IF NOT InvOnNextPostReq THEN
            ShipReceiveOnNextPostReq := TRUE;
        ShowDim := ShowDimFrom;
    end;

    /* 16630  local procedure CalculateTax(var ServiceHeader: Record 5900; var STBaseAmt: Decimal)
      begin
          WITH ServiceHeader DO BEGIN
              ServiceTaxAmt := 0;
              ServiceTaxECessAmt := 0;
              ServiceTaxSHECessAmt := 0;
              ServiceTaxSBCAmt := 0;
              KKCessAmt := 0;
              TotalGSTAmount := 0;
              ServiceLine.RESET;
              ServiceLine.SETRANGE("Document Type", "Document Type");
              ServiceLine.SETRANGE("Document No.", "No.");
              IF ServiceLine.FINDSET THEN
                  REPEAT
                      IF ServiceLine.Quantity <> 0 THEN BEGIN
                          ServiceTaxAmt += ROUND(ServiceLine."Service Tax Amount" * ServiceLine."Qty. to Invoice" / ServiceLine.Quantity);
                          ServiceTaxECessAmt +=
                            ROUND(ServiceLine."Service Tax eCess Amount" * ServiceLine."Qty. to Invoice" / ServiceLine.Quantity);
                          ServiceTaxSHECessAmt +=
                            ROUND(ServiceLine."Service Tax SHE Cess Amount" * ServiceLine."Qty. to Invoice" / ServiceLine.Quantity);
                          ServiceTaxSBCAmt += ROUND(ServiceLine."Service Tax SBC Amount" * ServiceLine."Qty. to Invoice" / ServiceLine.Quantity);
                          KKCessAmt +=
                            ROUND(ServiceLine."KK Cess Amount" * ServiceLine."Qty. to Invoice" / ServiceLine.Quantity);
                          STBaseAmt += ServiceLine."Service Tax Base";
                          ServiceTaxExists :=
                            ((ServiceTaxAmt + ServiceTaxECessAmt + ServiceTaxSHECessAmt + STBaseAmt + ServiceTaxSBCAmt + KKCessAmt) <> 0) OR
                            "Service Header"."ST Pure Agent";
                          TotalGSTAmount +=
                            ROUND(ServiceLine."Total GST Amount" * ServiceLine."Qty. to Invoice" / ServiceLine.Quantity);
                      END;
                  UNTIL ServiceLine.NEXT = 0;
          END;
      end;*/ // 16630

    local procedure CheckShipAndInvoice(var ServiceHeader: Record "Service Header")
    begin
        WITH ServiceHeader DO BEGIN
            IF Invoice THEN BEGIN
                ServiceLine.RESET;
                ServiceLine.SETRANGE("Document Type", "Document Type");
                ServiceLine.SETRANGE("Document No.", "No.");
                ServiceLine.SETFILTER(Quantity, '<>0');
                IF "Document Type" = "Document Type"::Order THEN
                    ServiceLine.SETFILTER("Qty. to Invoice", '<>0');
                Invoice := ServiceLine.FIND('-');
                IF Invoice AND NOT Ship AND ("Document Type" = "Document Type"::Order) THEN BEGIN
                    Invoice := FALSE;
                    REPEAT
                        Invoice := (ServiceLine."Quantity Shipped" - ServiceLine."Quantity Invoiced") <> 0;
                    UNTIL Invoice OR (ServiceLine.NEXT = 0);
                END;
            END;

            IF Ship THEN BEGIN
                ServiceLine.RESET;
                ServiceLine.SETRANGE("Document Type", "Document Type");
                ServiceLine.SETRANGE("Document No.", "No.");
                ServiceLine.SETFILTER(Quantity, '<>0');
                IF "Document Type" = "Document Type"::Order THEN
                    ServiceLine.SETFILTER("Qty. to Ship", '<>0');
                ServiceLine.SETRANGE("Shipment No.", '');
                Ship := ServiceLine.FIND('-');
            END;

            IF NOT (Ship OR Invoice) THEN
                AddError(Text012);

            IF Invoice THEN
                IF NOT ("Document Type" = "Document Type"::"Credit Memo") THEN
                    IF "Due Date" = 0D THEN
                        AddError(STRSUBSTNO(Text006, FIELDCAPTION("Due Date")));

            IF Ship AND ("Shipping No." = '') THEN // Order,Invoice
                IF ("Document Type" = "Document Type"::Order) OR
                   (("Document Type" = "Document Type"::Invoice) AND ServiceSetup."Shipment on Invoice")
                THEN
                    IF "Shipping No. Series" = '' THEN
                        AddError(
                          STRSUBSTNO(
                            Text006,
                            FIELDCAPTION("Shipping No. Series")));
        END;
    end;

    local procedure CheckCustomerNo(var ServiceHeader: Record "Service Header"; var ShipQtyExist: Boolean)
    begin
        WITH ServiceHeader DO
            IF "Customer No." = '' THEN
                AddError(STRSUBSTNO(Text006, FIELDCAPTION("Customer No.")))
            ELSE BEGIN
                IF Cust.GET("Customer No.") THEN BEGIN
                    IF (Cust.Blocked = Cust.Blocked::Ship) AND Ship THEN BEGIN
                        ServiceLine2.SETRANGE("Document Type", "Document Type");
                        ServiceLine2.SETRANGE("Document No.", "No.");
                        ServiceLine2.SETFILTER("Qty. to Ship", '>0');
                        IF ServiceLine2.FINDFIRST THEN
                            ShipQtyExist := TRUE;
                    END;
                    IF (Cust.Blocked = Cust.Blocked::All) OR
                       ((Cust.Blocked = Cust.Blocked::Invoice) AND
                        (NOT ("Document Type" = "Document Type"::"Credit Memo"))) OR
                       ShipQtyExist
                    THEN
                        AddError(
                          STRSUBSTNO(
                            Text045,
                            Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, "Customer No."));
                END ELSE
                    AddError(
                      STRSUBSTNO(
                        Text008,
                        Cust.TABLECAPTION, "Customer No."));
            END;
    end;

    /* local procedure CalculateGSTComponent()
     begin
         IF IsGSTApplicable AND ("Service Line".Type <> "Service Line".Type::" ") THEN BEGIN
             J := 1;
             GSTComponent.RESET;
             GSTComponent.SETRANGE("GST Jurisdiction Type", "Service Line"."GST Jurisdiction Type");
             IF GSTComponent.FINDSET THEN
                 REPEAT
                     GSTComponentCode[J] := GSTComponent.Code;
                     DetailedGSTEntryBuffer.RESET;
                     DetailedGSTEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                     DetailedGSTEntryBuffer.SETRANGE("Transaction Type", DetailedGSTEntryBuffer."Transaction Type"::Service);
                     DetailedGSTEntryBuffer.SETRANGE("Document Type", "Service Line"."Document Type");
                     DetailedGSTEntryBuffer.SETRANGE("Document No.", "Service Line"."Document No.");
                     DetailedGSTEntryBuffer.SETRANGE("GST Component Code", GSTComponentCode[J]);
                     IF DetailedGSTEntryBuffer.FINDSET THEN BEGIN
                         REPEAT
                             GSTCompAmount[J] += DetailedGSTEntryBuffer."GST Amount";
                         UNTIL DetailedGSTEntryBuffer.NEXT = 0;
                         J += 1;
                     END;
                 UNTIL GSTComponent.NEXT = 0;
         END;
     end;*/ // 16630

    /* local procedure CalculateTaxAmount(var StructureOrderLineDetails: Record 13795)
     begin
         StructureOrderLineDetails.RESET;
         StructureOrderLineDetails.SETRANGE(Type, StructureOrderLineDetails.Type::Service);
         StructureOrderLineDetails.SETRANGE("Document Type", "Service Line"."Document Type");
         StructureOrderLineDetails.SETRANGE("Document No.", "Service Line"."Document No.");
         StructureOrderLineDetails.SETRANGE("Item No.", "Service Line"."No.");
         StructureOrderLineDetails.SETRANGE("Line No.", "Service Line"."Line No.");
         IF StructureOrderLineDetails.FINDSET THEN
             REPEAT
                 IF NOT StructureOrderLineDetails."Payable to Third Party" THEN BEGIN
                     IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::Charges THEN
                         ChargesAmount += ROUND(StructureOrderLineDetails.Amount);
                     IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                         OtherTaxesAmount += ROUND(StructureOrderLineDetails.Amount);
                 END ELSE
                     IF StructureOrderLineDetails."Tax/Charge Type" IN
                        [StructureOrderLineDetails."Tax/Charge Type"::Charges, StructureOrderLineDetails."Tax/Charge Type"::"Other Taxes"]
                     THEN
                         ThirdPartyAmount += StructureOrderLineDetails.Amount;
             UNTIL StructureOrderLineDetails.NEXT = 0;
         TaxAreaLine.RESET;
         TaxAreaLine.SETCURRENTKEY("Tax Area", "Calculation Order");
         TaxAreaLine.SETRANGE("Tax Area", "Service Line"."Tax Area Code");
         IF TaxAreaLine.FINDFIRST THEN
             REPEAT
                 TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code");
                 IF TaxType = '' THEN
                     TaxType := FORMAT(TaxJurisdiction."Tax Type")
                 ELSE
                     IF TaxType <> FORMAT(TaxJurisdiction."Tax Type") THEN
                         AddError(STRSUBSTNO(Text16509, TaxType, TaxAreaLine."Tax Jurisdiction Code"));
             UNTIL TaxAreaLine.NEXT = 0;
     end;*/ // 16630

    local procedure CheckType(var ServiceLine: Record "Service Line")
    begin
        WITH ServiceLine DO BEGIN
            IF (Type >= Type::"G/L Account") AND ("Qty. to Invoice" <> 0) THEN BEGIN
                IF NOT GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group") THEN
                    AddError(
                      STRSUBSTNO(
                        Text017,
                        GenPostingSetup.TABLECAPTION, "Gen. Bus. Posting Group", "Gen. Prod. Posting Group"));
                IF NOT VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group") THEN
                    AddError(
                      STRSUBSTNO(
                        Text017,
                        VATPostingSetup.TABLECAPTION, "VAT Bus. Posting Group", "VAT Prod. Posting Group"));
            END;

            CASE Type OF
                Type::"G/L Account":
                    BEGIN
                        IF ("No." = '') AND (Amount = 0) THEN
                            EXIT;

                        IF "No." <> '' THEN
                            IF GLAcc.GET("No.") THEN BEGIN
                                IF GLAcc.Blocked THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text007,
                                        GLAcc.FIELDCAPTION(Blocked), FALSE, GLAcc.TABLECAPTION, "No."));
                                IF NOT GLAcc."Direct Posting" AND ("Line No." <= OrigMaxLineNo) THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text007,
                                        GLAcc.FIELDCAPTION("Direct Posting"), TRUE, GLAcc.TABLECAPTION, "No."));
                            END ELSE
                                AddError(
                                  STRSUBSTNO(
                                    Text008,
                                    GLAcc.TABLECAPTION, "No."));
                    END;
                Type::Item:
                    BEGIN
                        IF ("No." = '') AND (Quantity = 0) THEN
                            EXIT;

                        IF "No." <> '' THEN
                            IF Item.GET("No.") THEN BEGIN
                                IF Item.Blocked THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text007,
                                        Item.FIELDCAPTION(Blocked), FALSE, Item.TABLECAPTION, "No."));
                                IF Item.Reserve = Item.Reserve::Always THEN BEGIN
                                    CALCFIELDS("Reserved Quantity");
                                    IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                                        IF (SignedXX(Quantity) < 0) AND (ABS("Reserved Quantity") < ABS(Quantity)) THEN
                                            AddError(
                                              STRSUBSTNO(
                                                Text015,
                                                FIELDCAPTION("Reserved Quantity"), SignedXX(Quantity)));
                                    END ELSE
                                        IF (SignedXX(Quantity) < 0) AND (ABS("Reserved Quantity") < ABS("Qty. to Ship")) THEN
                                            AddError(
                                              STRSUBSTNO(
                                                Text015,
                                                FIELDCAPTION("Reserved Quantity"), SignedXX("Qty. to Ship")));
                                END
                            END ELSE
                                AddError(
                                  STRSUBSTNO(
                                    Text008,
                                    Item.TABLECAPTION, "No."));
                    END;
                Type::Resource:
                    BEGIN
                        IF ("No." = '') AND (Quantity = 0) THEN
                            EXIT;

                        IF "No." <> '' THEN
                            IF Res.GET("No.") THEN BEGIN
                                IF Res.Blocked THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text007,
                                        Res.FIELDCAPTION(Blocked), FALSE, Res.TABLECAPTION, "No."));
                            END ELSE
                                AddError(
                                  STRSUBSTNO(
                                    Text008,
                                    Res.TABLECAPTION, "No."));
                    END;
            END;
        END;
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
}

