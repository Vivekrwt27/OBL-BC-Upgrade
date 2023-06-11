report 50388 "Sales Invoice Oreint VAT"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesInvoiceOreintVAT.rdl';
    Caption = 'Sales - Invoice';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = Normal;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(HeaderTextLatest; HeaderTextLatest)
            {
            }
            column(DiscountAmt; Discount)
            {
            }
            column(VATAmountNew; ABS(VATAmount))
            {
            }
            column(Policy; policy)
            {
            }
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(Form_Text; FormText)
            {
            }
            column(Outstanding_Amount; FORMAT(Outstand))
            {
            }
            column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(Vendor_Name; Recvendor.Name)
            {
            }
            column(CustLSTNo; "Cust LST")
            {
            }
            column(CustCSTNo; "Cust CST")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(ShiptoName_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name")
                    {
                    }
                    column(ShiptoName2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name 2")
                    {
                    }
                    column(ShiptoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address")
                    {
                    }
                    column(ShiptoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address 2")
                    {
                    }
                    column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
                    {
                    }
                    column(TruckNo_SalesInvoiceHeader; "Sales Invoice Header"."Truck No.")
                    {
                    }
                    column(GRNo_SalesInvoiceHeader; "Sales Invoice Header"."GR No.")
                    {
                    }
                    column(GRDate_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."GR Date", 0, 4))
                    {
                    }
                    column(PONo_SalesInvoiceHeader; "Sales Invoice Header"."PO No.")
                    {
                    }
                    column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
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
                    column(Statename_SalesInvoiceHeader; "Sales Invoice Header"."State name")
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
                    column(DocumentCaptionCopyText; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
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
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
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
                    column(BillToCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvoiceHdr; FORMAT("Sales Invoice Header"."Due Date", 0, 4))
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
                    column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvoiceHdr; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(OrderDate_SalesInvoiceHdr; FORMAT("Sales Invoice Header"."Order Date", 0, 4))
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
                    column(DocDate_SalesInvHeader; FORMAT("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo; FORMAT("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    //16225 column(PLAEntryNo_SalesInvHdr; "Sales Invoice Header"."PLA Entry No.")
                    column(PLAEntryNo_SalesInvHdr; '')
                    {
                    }
                    column(SupplementaryText; SupplementaryText)
                    {
                    }
                    //16225  column(RG23AEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 A Entry No.")
                    column(RG23AEntryNo_SalesInvHdr; '')
                    {
                    }
                    //16225  column(RG23CEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 C Entry No.")
                    column(RG23CEntryNo_SalesInvHdr; '')
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
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
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(PLAEntryNoCaption; PLAEntryNoCaptionLbl)
                    {
                    }
                    column(RG23AEntryNoCaption; RG23AEntryNoCaptionLbl)
                    {
                    }
                    column(RG23CEntryNoCaption; RG23CEntryNoCaptionLbl)
                    {
                    }
                    column(ServiceTaxRegistrationNoCaption; ServiceTaxRegistrationNoLbl)
                    {
                    }
                    column(ServiceTaxRegistrationNo; ServiceTaxRegistrationNo)
                    {
                    }
                    column(BillToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(SaleInvHeader_TinNo; SaleInvHeader."Tin No.")
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText_DimensionLoop1; DimText)
                        {
                        }
                        column(Number_Integer; DimensionLoop1.Number)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
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
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            ORDER(Ascending)
                                            WHERE(Type = FILTER(Item),
                                                  Quantity = FILTER(<> 0));
                        column(PageBreak1; FORMAT(PageBreak1))
                        {
                        }
                        column(PageCont; FORMAT(PageCont))
                        {
                        }
                        //16225 column(NetAmount; ROUND("Sales Invoice Line"."Amount To Customer", 1, '='))
                        column(NetAmount; ROUND(NETAmtToCust, 1, '='))
                        {
                        }
                        column(Vat_Amount; ABS(VATAmount))
                        {
                        }
                        column(Additional_VAT_Amount; ABS(AddVATAmount))
                        {
                        }
                        column(LineDiscountAmount; "Line Discount Amount")
                        {
                        }
                        column(Discount_Amount; ABS(Discount))
                        {
                        }
                        column(Amount_In_Words1_1; AmountinWord1[1])
                        {
                        }
                        column(Amount_In_Words_1; AmountinWord[1])
                        {
                        }
                        column(Jud_Text_1; JudText[1])
                        {
                        }
                        column(Jud_Text_2; JudText[2])
                        {
                        }
                        column(Per_Jud_1; PerJud[1])
                        {
                        }
                        column(Per_Jud_2; PerJud[2])
                        {
                        }
                        column(Text_13705; Text13705)
                        {
                        }
                        column(Text_13706; Text13706)
                        {
                        }
                        column(SNO; "S.No.")
                        {
                        }
                        column(SalesInv_TINNo; SaleInvHeader."Tin No.")
                        {
                        }
                        //16225  column(Bed_Amount; "Sales Invoice Line"."BED Amount")
                        column(Bed_Amount; 0)
                        {
                        }
                        //16225  column(Ecess_Amount; ROUND("Sales Invoice Line"."eCess Amount", 1, '='))
                        column(Ecess_Amount; 0)
                        {
                        }
                        //16225  column(SheCess_Amount; ROUND("Sales Invoice Line"."SHE Cess Amount", 1, '='))
                        column(SheCess_Amount; 0)
                        {
                        }
                        //16225  column(Excise_Amount; "Sales Invoice Line"."Excise Amount")
                        column(Excise_Amount; 0)
                        {
                        }
                        column(GrossWeight_SalesInvoiceLine; "Gross Weight")
                        {
                        }
                        column(State_Name; Stname)
                        {
                        }
                        column(Body; body)
                        {
                        }
                        column(Header_Text_Latest; HeaderTextLatest)
                        {
                        }
                        column(LineAmount_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Description_SalesInvLine; Description)
                        {
                        }
                        column(Description2_SalesInvoiceLine; "Description 2")
                        {
                        }
                        column(No_SalesInvoiceLine; "No.")
                        {
                        }
                        column(Quantity_SalesInvoiceLine; Quantity)
                        {
                        }
                        column(UOM_SalesInvoiceLine; "Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(QuantityinSqMt_SalesInvoiceLine; "Quantity in Sq. Mt.")
                        {
                        }
                        //16225  column(MRPPrice_SalesInvoiceLine; "MRP Price")
                        column(MRPPrice_SalesInvoiceLine; "MRP Price")
                        {
                        }
                        column(Assessable_Value; AssesableVal)
                        {
                        }
                        column(Disc_Per_Cart; DiscPerCart)
                        {
                        }
                        column(Buyers_Rate_Per_SqMtr; BuyersRatePerSqMtr)
                        {
                        }
                        column(Value; Value)
                        {
                        }
                        column(LineDiscount_SalesInvLine; "Line Discount %")
                        {
                        }
                        column(LineDiscount_SalesInvLineAmount; "Line Discount Amount")
                        {
                        }
                        column(PostedShipmentDate; FORMAT(PostedShipmentDate))
                        {
                        }
                        column(SalesLineType; FORMAT("Sales Invoice Line".Type))
                        {
                        }
                        //16225 column(DirectDebitPLARG_SalesInvLine; "Direct Debit To PLA / RG")
                        column(DirectDebitPLARG_SalesInvLine; "Sales Invoice Line"."Unit Cost")
                        {
                        }
                        //16225 column(SourceDocNo_SalesInvLine; "Source Document No.")
                        column(SourceDocNo_SalesInvLine; "Sales Invoice Line"."Units per Parcel")
                        {
                        }
                        //16225   column(Supplementary; Supplementary)
                        column(Supplementary; "Sales Invoice Line"."GST Place of Supply")
                        {
                        }
                        column(InvDiscountAmount; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesInvoiceLineAmount; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225  column(AmtInclVAT_SalesInvLine; "Amount To Customer")
                        column(AmtInclVAT_SalesInvLine; NETAmtToCust)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225 column(TaxAmount_SalesInvLine; "Tax Amount")
                        column(TaxAmount_SalesInvLine; "Sales Invoice Line"."VAT Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SalesInvLineTotalTDSTCSInclSHECESS; TotalTCSAmount)
                        {
                        }
                        column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AppliedServTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalTaxAmt; TotalTaxAmt)
                        {
                        }
                        column(TotalExciseAmt; TotalExciseAmt)
                        {
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                        }
                        column(SalesInvoiceLineLineNo; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountCaption; DiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(LineDiscountCaption; LineDiscountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(ExciseAmountCaption; ExciseAmountCaptionLbl)
                        {
                        }
                        column(TaxAmountCaption; TaxAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxAmountCaption; ServiceTaxAmountCaptionLbl)
                        {
                        }
                        column(ChargesAmountCaption; ChargesAmountCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
                        {
                        }
                        column(ServTaxeCessAmtCaption; ServTaxeCessAmtCaptionLbl)
                        {
                        }
                        column(TCSAmountCaption; TCSAmountCaptionLbl)
                        {
                        }
                        column(SvcTaxAmtAppliedCaption; SvcTaxAmtAppliedCaptionLbl)
                        {
                        }
                        column(SvcTaxeCessAmtAppliedCaption; SvcTaxeCessAmtAppliedCaptionLbl)
                        {
                        }
                        column(ServTaxSHECessAmtCaption; ServTaxSHECessAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSHECessAmtAppliedCaption; SvcTaxSHECessAmtAppliedCaptionLbl)
                        {
                        }
                        column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
                        {
                        }
                        column(Description_SalesInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvoiceLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_SalesInvoiceLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesInvoiceLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        //16225   column(DirectDebitPLARG_SalesInvLineCaption; FIELDCAPTION("Direct Debit To PLA / RG"))
                        column(DirectDebitPLARG_SalesInvLineCaption; FIELDCAPTION("Sales Invoice Line"."VAT Difference"))
                        {
                        }
                        column(ServiceTaxSBCAmt; ServiceTaxSBCAmt)
                        {
                        }
                        column(AppliedServiceTaxSBCAmt; AppliedServiceTaxSBCAmt)
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSBCAmtAppliedCaption; SvcTaxSBCAmtAppliedCaptionLbl)
                        {
                        }
                        column(Insurance_Charge; InsurnaceCharge)
                        {
                        }
                        column(FreightChargeAmount; FrightChargeAmt)
                        {
                        }

                        dataitem("Sales Shipment Buffer"; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShpBufferPostingDate;
                            FORMAT(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShipmentBufferQty; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                //16225 AmtToCust End//
                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
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
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            column(TempPostedAsmLineDescription; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineVariantCode; BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {
                                //16225   DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                                //16225   DecimalPlaces = 0 : 5;
                            }

                            trigger OnAfterGetRecord()
                            begin

                                IF Number = 1 THEN
                                    TempPostedAsmLine.FINDSET
                                ELSE
                                    TempPostedAsmLine.NEXT;
                            end;



                            trigger OnPreDataItem()
                            begin
                                CLEAR(TempPostedAsmLine);
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                CollectAsmInformation;
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                        //16225   StructureLineDetails: Record "13798";
                        begin
                            "S.No." := "S.No." + 1;

                            Sno += 1;
                            IF (Sno - 1) MOD 14 = 0 THEN
                                PageBreak1 := (Sno - 1) / 14;

                            PageCont := ROUND(COUNT / 14, 1, '<');
                            NETAmtToCust := GetAmttoCustomerPostedLine("Document No.", "Sales Invoice Line"."Line No.");

                            //MESSAGE('%1',"Line Discount Amount");
                            TotalLineAmount += "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                            //16225 field N/F Start
                            /* State1.RESET;
                             State1.SETRANGE(State1.Code, "Sales Invoice Line".State);
                             IF State1.FIND('-') THEN
                                 Stname := State1.Description;*///16225 field N/F End

                            //-----MS-PB BEGIN---------
                            Location2.RESET;
                            Location2.SETRANGE(Code, "Location Code");
                            IF Location2.FINDFIRST THEN BEGIN
                                SaleInvHeader.RESET;
                                SaleInvHeader.SETRANGE("No.", "Document No.");
                                /*  IF SaleInvHeader.FINDFIRST THEN
                                      HeaderTextLatest := DocumentPrint.PrintInvoiceType(SaleInvHeader, Location2);*/
                            END;
                            //-----MS-PB END-----------


                            Text13705 := FORMAT("Sales Invoice Header".Pay) + ' ' + 'Rs............../MT';


                            IF ("Type Catogery Code" = '54') OR ("Type Catogery Code" = '60') OR ("Type Catogery Code" = '61')
                               OR ("Type Catogery Code" = '62') OR ("Type Catogery Code" = '70') OR ("Type Catogery Code" = '71')
                               OR ("Type Catogery Code" = '46') THEN
                                body := 'Vitreous';


                            j := 0;
                            FOR j := 1 TO 3 DO BEGIN
                                JudText[j] := '';
                                PerJud[j] := 0;
                            END;

                            j := 0;
                            SalesInvLine5.RESET;
                            SalesInvLine5.SETFILTER(SalesInvLine5."Document No.", '%1', "Sales Invoice Header"."No.");
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
                                        //16225   TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                                        TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                                        IF TaxDetails.FIND('+') THEN
                                            IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                                JudText[j] := TaxDetails."Tax Jurisdiction Code";
                                                PerJud[j] := TaxDetails."Tax Below Maximum";
                                            END;
                                    UNTIL TaxAreaLine.NEXT = 0;
                            END;

                            PostedShipmentDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate;

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

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

                            //16225  TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS";

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            // TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            TotalAmountInclVAT += GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.");
                            //16225 TotalAmountInclVAT += "Amount To Customer";
                            //16225   TotalExciseAmt += "Excise Amount";
                            //16225  TotalTaxAmt += "Tax Amount";
                            //16225   ServiceTaxAmount += "Service Tax Amount";
                            //16225   ServiceTaxeCessAmount += "Service Tax eCess Amount";
                            //16225   ServiceTaxSHECessAmount += "Service Tax SHE Cess Amount";
                            //16225   ServiceTaxSBCAmount += "Service Tax SBC Amount";
                            //16225 table N/F Start
                            /*   StructureLineDetails.RESET;
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
                                   UNTIL StructureLineDetails.NEXT = 0;*///16225 table N/F End

                            //16225 Table N/F Start
                            /*   PostedStrOrderLineDetails.RESET;
                               PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                               PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                               PostedStrOrderLineDetails.SETRANGE("Item No.", "Sales Invoice Line"."No.");
                               PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
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
                               END;

                               IF "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 THEN BEGIN
                                   ServiceTaxEntry.RESET;
                                   ServiceTaxEntry.SETRANGE(Type, ServiceTaxEntry.Type::Sale);
                                   ServiceTaxEntry.SETRANGE("Document Type", ServiceTaxEntry."Document Type"::Invoice);
                                   ServiceTaxEntry.SETRANGE("Document No.", "Document No.");
                                   IF ServiceTaxEntry.FINDFIRST THEN BEGIN

                                       IF "Sales Invoice Header"."Currency Code" <> '' THEN BEGIN
                                           ServiceTaxEntry."Service Tax Amount" :=
                                             ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                             "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                             ServiceTaxEntry."Service Tax Amount", "Sales Invoice Header"."Currency Factor"));
                                           ServiceTaxEntry."eCess Amount" :=
                                             ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                             "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                             ServiceTaxEntry."eCess Amount", "Sales Invoice Header"."Currency Factor"));
                                           ServiceTaxEntry."SHE Cess Amount" :=
                                             ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                             "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                             ServiceTaxEntry."SHE Cess Amount", "Sales Invoice Header"."Currency Factor"));
                                           ServiceTaxEntry."Service Tax SBC Amount" :=
                                             ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                             "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                             ServiceTaxEntry."Service Tax SBC Amount", "Sales Invoice Header"."Currency Factor"));
                                       END;

                                       ServiceTaxAmt := ABS(ServiceTaxEntry."Service Tax Amount");
                                       ServiceTaxECessAmt := ABS(ServiceTaxEntry."eCess Amount");
                                       ServiceTaxSHECessAmt := ABS(ServiceTaxEntry."SHE Cess Amount");
                                       ServiceTaxSBCAmt := ABS(ServiceTaxEntry."Service Tax SBC Amount");
                                       AppliedServiceTaxAmt := ServiceTaxAmount - ABS(ServiceTaxEntry."Service Tax Amount");
                                       AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - ABS(ServiceTaxEntry."eCess Amount");
                                       AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - ABS(ServiceTaxEntry."SHE Cess Amount");
                                       AppliedServiceTaxSBCAmt := ServiceTaxSBCAmount - ABS(ServiceTaxEntry."Service Tax SBC Amount");
                                   END ELSE BEGIN
                                       AppliedServiceTaxAmt := ServiceTaxAmount;
                                       AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
                                       AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                                       AppliedServiceTaxSBCAmt := ServiceTaxSBCAmount;
                                   END;
                               END ELSE BEGIN
                                   ServiceTaxAmt := ServiceTaxAmount;
                                   ServiceTaxECessAmt := ServiceTaxeCessAmount;
                                   ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                                   ServiceTaxSBCAmt := ServiceTaxSBCAmount
                               END;*/ //16225 Table N/F End

                            Value := 0;
                            Cart := 0;
                            SqMt := 0;
                            Wt := 0;
                            LineDiscount := 0;
                            DiscPerCart := 0;
                            RateperCart := 0;

                            Cart := ROUND(Item.UomToCart("No.", "Unit of Measure Code", Quantity), 1, '<');
                            SqMt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);

                            Wt := "Sales Invoice Line"."Gross Weight";

                            Pcs := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<'); //-- 3. Tri30.0 PG 14112006

                            IF Cart <> 0 THEN
                                RateperCart := "Unit Price" * Quantity / Cart;

                            IF SqMt <> 0 THEN
                                DiscPerCart := "Line Discount Amount" / SqMt;

                            LineDiscount := "Line Discount Amount";

                            IF Quantity <> 0 THEN
                                // BuyersPrice := (Amount + "Excise Amount") / Quantity; 16630
                                BuyersPrice := "Sales Invoice Line".Amount;

                            IF "Quantity in Sq. Mt." <> 0 THEN BEGIN
                                DecRate := ("Quantity Discount Amount" / "Quantity in Sq. Mt.");
                                LineDis := ("Line Discount Amount" / "Quantity in Sq. Mt.");
                            END;

                            IF SqMt <> 0 THEN BEGIN
                                BuyersRatePerSqMtr := (BuyersPrice / SqMt) + DecRate + LineDis;
                                DiscPerSqmt := "Line Discount Amount" / SqMt;
                            END;
                            //16225 Field N/F Start
                            /* IF Quantity <> 0 THEN BEGIN
                                 BEDAmt := BEDAmt + "BED Amount";
                                 Hecess := Hecess + "SHE Cess Amount";
                                 ECess := ECess + "eCess Amount"
                             END;*///16225 Field N/F End

                            Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                            SqMt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                            Pcsqty := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<');
                            Wt := "Sales Invoice Line"."Gross Weight";

                            //16630   AssesableVal := "Sales Invoice Line"."Assessable Value" * "Sales Invoice Line".Quantity;
                            AssesableVal := "Sales Invoice Line".Quantity;
                            Value := (BuyersRatePerSqMtr * "Quantity in Sq. Mt.");//-"Excise Amount";
                                                                                  //16225   IF ExciseProdPostingGroup.GET("Sales Invoice Line"."Excise Prod. Posting Group") THEN;
                            IF "Sales Invoice Line"."Line Discount Amount" <> 0 THEN
                                IF "Sales Invoice Line"."Quantity in Cartons" <> 0 THEN
                                    Disamt := "Sales Invoice Line"."Line Discount Amount" / "Sales Invoice Line"."Quantity in Cartons";

                            //16225   Excisetotal := "BED Amount" + "eCess Amount" + "SHE Cess Amount";
                            TotalAmount := (TotalLineAmount + Excisetotal);
                            OtherCharges := BaleCharges + LabourCharges;
                            //16225 GTotal := (TotalLineAmount + Excisetotal + CSTchargeAmount + InsurenceChargeAmount + FrightChargeAmt + OtherCharges +
                            //16225 "Sales Invoice Line"."Tax Amount");
                            GTotal := (TotalLineAmount + Excisetotal + CSTchargeAmount + InsurenceChargeAmount + FrightChargeAmt + OtherCharges);
                            //16225 "Sales Invoice Line"."Tax Amount");

                            //msvc discount
                            Discount := 0;
                            //16225 Table N/F Start
                            /*   PostedStrOrderLDetails.RESET;
                               PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                               PostedStrOrderLDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                               PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
                               IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                                   REPEAT
                                       Discount += PostedStrOrderLDetails.Amount;
                                   UNTIL PostedStrOrderLDetails.NEXT = 0;
                               END;


                               InsurnaceCharge := 0;
                               PostedStrOrderLDetails.RESET;
                               PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                               PostedStrOrderLDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                               PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'INSURANCE');
                               IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                                   REPEAT
                                       InsurnaceCharge += PostedStrOrderLDetails.Amount;
                                   UNTIL PostedStrOrderLDetails.NEXT = 0;
                               END;*///16225 Table N/F End

                            /*
                            VATAmount:=0;
                            DetailedTaxEntry.RESET;
                            DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Document No.","Sales Invoice Line"."Document No.");
                            DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Additional Tax",FALSE);
                            IF DetailedTaxEntry.FIND('-')THEN BEGIN
                            REPEAT
                              VATAmount+=DetailedTaxEntry."Tax Amount";
                            UNTIL DetailedTaxEntry.NEXT=0;
                            END;

                            AddVATAmount:=0;
                            DetailedTaxEntry.RESET;
                            DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Document No.","Sales Invoice Line"."Document No.");
                            DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Additional Tax",TRUE);
                            IF DetailedTaxEntry.FIND('-')THEN BEGIN
                            REPEAT
                              AddVATAmount+=DetailedTaxEntry."Tax Amount";
                            UNTIL DetailedTaxEntry.NEXT=0;
                            END;
                            */
                            //MSBS.Rao Begin Dt. 07-06-12
                            QD += "Quantity Discount Amount" - "Accrued Discount";
                            IF QD <> 0 THEN
                                QdText := 'QD DISCOUNT';
                            AQD += "Accrued Discount";
                            IF AQD <> 0 THEN
                                AqdText := 'AQD DISCOUNT';
                            //MSBS.Rao End Dt. 07-06-12

                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(NumberText, ROUND(GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No."), 1), "Sales Invoice Header"."Currency Code");
                            //16 25CheckReport.FormatNoText(NumberText, ROUND("Amount To Customer",, 1), "Sales Invoice Header"."Currency Code");
                            //16225Field N/F Start
                            /* IF "Sales Invoice Line"."Charges To Customer" > 0 THEN BEGIN
                                 Charge := "Sales Invoice Line"."Charges To Customer"
                             END ELSE
                                 Charge1 := "Sales Invoice Line"."Charges To Customer";*///16225Field N/F End


                            //GTotal:=ROUND(GTotal + OtherCharges,1);
                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(NumberText, GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No."), GenJnlLine."Currency Code");
                            //16225CheckReport.FormatNoText(NumberText, "Sales Invoice Line"."Amount To Customer", GenJnlLine."Currency Code");
                            CheckReport.InitTextVariable;
                            //16225 CheckReport.FormatNoText(NumberText1, ROUND("BED Amount", 1), GenJnlLine."Currency Code");

                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(NumberText2, (Excisetotal), GenJnlLine."Currency Code");
                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(NumberText3, GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No."), GenJnlLine."Currency Code");
                            //16225 CheckReport.FormatNoText(NumberText3, "Amount To Customer", GenJnlLine."Currency Code");

                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(NumberText4, CSTchargeAmount, GenJnlLine."Currency Code");

                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(NumberText5, TotalShcess, GenJnlLine."Currency Code");
                            //msdr.begin
                            CheckReport.InitTextVariable;
                            CheckReport.FormatNoText(AmountinWord, ROUND(GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No."), 1), "Sales Invoice Header"."Currency Code");
                            //16225 CheckReport.FormatNoText(AmountinWord, ROUND("Sales Invoice Line"."Amount To Customer", 1), "Sales Invoice Header"."Currency Code");
                            CheckReport.InitTextVariable;
                            //16225   CheckReport.FormatNoText(AmountinWord1, ROUND("Excise Amount", 1), "Sales Invoice Header"."Currency Code");

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            //16225 Table Field N/F Start
                            /* CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Excise Amount", "Tax Amount",
                               "Service Tax Amount", "Service Tax eCess Amount", "Amount To Customer", "Service Tax SBC Amount");
                             CurrReport.CREATETOTALS("Service Tax SHE Cess Amount");*///16225 Table Field N/F End

                            "S.No." := 0;
                            CLEAR(Sno);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT_VATCounter; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier_VATCounter; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmountCaption; LineAmountCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
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
                        column(VATAmtLineVAT_VatCounterLCY; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier_VatCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Invoice Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SellToCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddressCaption; ShipToAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(RowIns; Integer)
                    {
                        column(IncRowas; IncRowas)
                        {
                        }
                        column(QD_Value; QD)
                        {
                        }
                        column(Qd_Text; QdText)
                        {
                        }
                        column(AQD_Value; AQD)
                        {
                        }
                        column(AQD_Text; AqdText)
                        {
                        }


                        trigger OnAfterGetRecord()
                        begin
                            IncRowas += 1;
                            //MESSAGE('%1',QD);

                        end;

                        trigger OnPreDataItem()
                        begin
                            IF Sno < 14 THEN
                                rowstogen := 14 - Sno
                            ELSE BEGIN
                                rowstogen := Sno - 14 * PageBreak1;
                                rowstogen := 14 - rowstogen;
                            END;
                            //MESSAGE('%1',rowstogen);
                            IF rowstogen = 0 THEN
                                rowstogen := 1;
                            SETRANGE(Number, 1, rowstogen);//,rowstogen+3);
                            CLEAR(IncRowas)
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;
                    TotalExciseAmt := 0;
                    TotalTaxAmt := 0;
                    ServiceTaxAmount := 0;
                    ServiceTaxeCessAmount := 0;
                    ServiceTaxSHECessAmount := 0;
                    ServiceTaxSBCAmount := 0;

                    OtherTaxesAmount := 0;
                    ChargesAmount := 0;
                    AppliedServiceTaxSHECessAmt := 0;
                    AppliedServiceTaxECessAmt := 0;
                    AppliedServiceTaxAmt := 0;
                    AppliedServiceTaxSBCAmt := 0;
                    ServiceTaxSHECessAmt := 0;
                    ServiceTaxECessAmt := 0;
                    ServiceTaxAmt := 0;
                    ServiceTaxSBCAmt := 0;
                    TotalTCSAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesInvLine: Record "Sales Invoice Line";
                Location: Record Location;
                SIL: Record "Sales Invoice Line";
            begin
                //16225 funcation N/F CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                IF "Posting Date" >= 20140107D THEN BEGIN//070114D
                    policy := NewPolicy
                END ELSE
                    policy := Text13704;

                // InsurnaceCharge 16630
                Clear(InsurnaceCharge);
                if "Sales Invoice Line".type = "Sales Invoice Line".Type::"Charge (Item)" then
                    if "Sales Invoice Line"."No." = 'TRDDISC' then
                        InsurnaceCharge := "Sales Invoice Line"."Line Amount";


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

                //16225 Field N/F start
                /*  IF "Sales Invoice Header"."Form Code" <> '' THEN
                      FormText := 'Against' + ' ' + FORMAT("Sales Invoice Header"."Form Code")
                  ELSE
                      FormText := '';*///16225 Field N/F End

                Cust1.RESET;
                Cust1.SETRANGE(Cust1."No.", "Bill-to Customer No.");
                //16225 field N/F Start
                /*  IF Cust1.FIND('-') THEN BEGIN
                      "Cust LST" := Cust1."L.S.T. No.";
                      "Cust CST" := Cust1."C.S.T. No.";
                      "Cust TIN" := Cust1."T.I.N. No."
                  END;*///16225 field N/F End
                Cust1.CALCFIELDS(Balance);
                Outstand := ROUND((Cust1.Balance), 1, '=');

                IF Recvendor.GET("Sales Invoice Header"."Transporter's Name") THEN;// Msdr
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
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
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                IF NOT Cust.GET("Bill-to Customer No.") THEN
                    CLEAR(Cust);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;
                //16225 FormatAddr.SalesInvShipTo(ShipToAddr, "Sales Invoice Header");
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
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

                SupplementaryText := '';
                SalesInvLine.SETRANGE("Document No.", "No.");
                //16225   SalesInvLine.SETRANGE(Supplementary, TRUE);
                IF SalesInvLine.FIND('-') THEN
                    SupplementaryText := Text16500;

                //16225 field N/f Start
                /*  IF Location.GET("Location Code") THEN
                      ServiceTaxRegistrationNo := Location."Service Tax Registration No."
                  ELSE
                      ServiceTaxRegistrationNo := CompanyInfo."Service Tax Registration No.";*/
                //16225 field N/f End

                //Discount Calc
                Discount := 0;
                ///16225 table N/F Start
                /*  PostedStrOrderLDetails.RESET;
                  PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                  PostedStrOrderLDetails.SETRANGE("Invoice No.", "No.");
                  PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
                  IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                      REPEAT
                          Discount += PostedStrOrderLDetails.Amount;
                      UNTIL PostedStrOrderLDetails.NEXT = 0;
                  END;


                  VATAmount := 0;
                  DetailedTaxEntry.RESET;
                  DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Document No.", "Sales Invoice Header"."No.");
                  DetailedTaxEntry.SETRANGE(DetailedTaxEntry."Additional Tax", FALSE);
                  IF DetailedTaxEntry.FIND('-') THEN BEGIN
                      REPEAT
                          VATAmount += DetailedTaxEntry."Tax Amount";
                      UNTIL DetailedTaxEntry.NEXT = 0;
                  END;*////16225 table N/F End
                //MESSAGE('%1',VATAmount);

                //Discount Calc
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
                    Visible = false;
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
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        //CompanyInfo.VerifyAndSetPaymentInfo;
        CASE SalesSetup."Logo Position on Documents" OF
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

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label ' COPY';
        Text004: Label 'Sales - Invoice%1';
        PageCaptionCap: Label 'Page %1 of %2';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        NETAmtToCust: Decimal;
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
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
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        SupplementaryText: Text[30];
        Text16500: Label 'Supplementary Invoice';
        //16225  ServiceTaxEntry: Record "16473";
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        AppliedServiceTaxAmt: Decimal;
        AppliedServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
        AppliedServiceTaxSHECessAmt: Decimal;
        TotalTaxAmt: Decimal;
        TotalExciseAmt: Decimal;
        TotalTCSAmount: Decimal;
        ServiceTaxAmount: Decimal;
        ServiceTaxeCessAmount: Decimal;
        ServiceTaxSHECessAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        HomePageCaptionCap: Label 'Home Page';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        DueDateCaptionLbl: Label 'Due Date';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        PLAEntryNoCaptionLbl: Label 'PLA Entry No.';
        RG23AEntryNoCaptionLbl: Label 'RG23A Entry No.';
        RG23CEntryNoCaptionLbl: Label 'RG23C Entry No.';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscountCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        LineDiscountCaptionLbl: Label 'Line Discount Amount';
        PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
        SubtotalCaptionLbl: Label 'Subtotal';
        ExciseAmountCaptionLbl: Label 'Excise Amount';
        TaxAmountCaptionLbl: Label 'Tax Amount';
        ServiceTaxAmountCaptionLbl: Label 'Service Tax Amount';
        ChargesAmountCaptionLbl: Label 'Charges Amount';
        OtherTaxesAmountCaptionLbl: Label 'Other Taxes Amount';
        ServTaxeCessAmtCaptionLbl: Label 'Service Tax eCess Amount';
        TCSAmountCaptionLbl: Label 'TCS Amount';
        SvcTaxAmtAppliedCaptionLbl: Label 'Svc Tax Amt (Applied)';
        SvcTaxeCessAmtAppliedCaptionLbl: Label 'Svc Tax eCess Amt (Applied)';
        ServTaxSHECessAmtCaptionLbl: Label 'Service Tax SHE Cess Amount';
        SvcTaxSHECessAmtAppliedCaptionLbl: Label 'Svc Tax SHECess Amt(Applied)';
        PaymentDiscVATCaptionLbl: Label 'Payment Discount on VAT';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        ShipToAddressCaptionLbl: Label 'Ship-to Address';
        ServiceTaxRegistrationNo: Code[20];
        ServiceTaxRegistrationNoLbl: Label 'Service Tax Registration No.';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        VATPercentageCaptionLbl: Label 'VAT %';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        VATBaseCaptionLbl: Label 'VAT Base';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        EMailCaptionLbl: Label 'E-Mail';
        DocumentDateCaptionLbl: Label 'Document Date';
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        SvcTaxSBCAmtAppliedCaptionLbl: Label 'SBC Amt (Applied)';
        ServiceTaxSBCAmount: Decimal;
        ServiceTaxSBCAmt: Decimal;
        AppliedServiceTaxSBCAmt: Decimal;
        "---------------------------------------": Integer;
        Location2: Record Location;
        SaleInvHeader: Record "Sales Invoice Header";
        HeaderTextLatest: Text[100];
        DocumentPrint: Codeunit "Document-Print";
        State1: Record State;
        Stname: Text[50];
        Recvendor: Record Vendor;
        Cust1: Record Customer;
        "Cust LST": Code[20];
        "Cust CST": Code[20];
        "Cust TIN": Code[20];
        Outstand: Decimal;
        "S.No.": Integer;
        body: Text[10];
        AssesableVal: Decimal;
        Value: Decimal;
        Cart: Decimal;
        SqMt: Decimal;
        Wt: Decimal;
        LineDiscount: Decimal;
        DiscPerCart: Decimal;
        RateperCart: Decimal;
        Item: Record Item;
        Pcs: Decimal;
        BuyersPrice: Decimal;
        DecRate: Decimal;
        LineDis: Decimal;
        BuyersRatePerSqMtr: Decimal;
        DiscPerSqmt: Decimal;
        BEDAmt: Decimal;
        Hecess: Decimal;
        ECess: Decimal;
        Pcsqty: Decimal;
        //16225 ExciseProdPostingGroup: Record "13710";
        Disamt: Decimal;
        Text13705: Text[100];
        Text13706: Label 'Assesable Value is calculated @ 55% of MRP';
        j: Integer;
        JudText: array[4] of Code[50];
        PerJud: array[3] of Decimal;
        SalesInvLine5: Record "Sales Invoice Line";
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        FormText: Text[30];
        CheckReport: Report "Check Report";
        NumberText: array[2] of Text[80];
        NumberText1: array[2] of Text[80];
        NumberText2: array[2] of Text[80];
        NumberText3: array[2] of Text[80];
        NumberText5: array[2] of Text[80];
        NumberText4: array[2] of Text[80];
        Charge: Decimal;
        Charge1: Decimal;
        GenJnlLine: Record "Gen. Journal Line";
        Excisetotal: Decimal;
        TotalLineAmount: Decimal;
        OtherCharges: Decimal;
        BaleCharges: Decimal;
        LabourCharges: Decimal;
        GTotal: Decimal;
        CSTchargeAmount: Decimal;
        InsurenceChargeAmount: Decimal;
        FrightChargeAmt: Decimal;
        TotalShcess: Decimal;
        AmountinWord: array[2] of Text[100];
        AmountinWord1: array[2] of Text[100];
        QD: Decimal;
        QdText: Text[30];
        AQD: Decimal;
        AqdText: Text[30];
        Discount: Decimal;
        //16225  PostedStrOrderLDetails: Record "13798";
        //16225  PostedStrOrderLineDetails: Record "13798";
        TccChargeAmount: Decimal;
        ChargePercentTCC: Decimal;
        BEDChargeAmount: Decimal;
        ChargePercentBED: Decimal;
        EcessChargeAmount: Decimal;
        ChargePercentEcess: Decimal;
        ChargePercentIns: Decimal;
        ChargePercentCST: Decimal;
        Hecesspercent: Decimal;
        InsurnaceCharge: Decimal;
        VATAmount: Decimal;
        //16225  DetailedTaxEntry: Record "16522";
        AddVATAmount: Decimal;
        policy: Text[200];
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        Text13704: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        AddDIs: Decimal;
        Sno: Integer;
        rowstogen: Integer;
        PageBreak1: Integer;
        IncRowas: Integer;
        PageCont: Integer;


    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Invoice Line"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF "Sales Invoice Header"."Order No." = '' THEN
            EXIT("Sales Invoice Header"."Posting Date");

        CASE "Sales Invoice Line".Type OF
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Invoice Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
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
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        IF SalesInvoiceHeader.FIND('-') THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT = 0;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF "Sales Invoice Header"."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN BEGIN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                    END;
                END;
            UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
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
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Sales Invoice Header"."Prepayment Invoice" THEN
            EXIT(Text010);
        EXIT(Text004);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DELETEALL;
        IF "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item THEN
            EXIT;
        WITH ValueEntry DO BEGIN
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
            SETRANGE("Document Type", "Document Type"::"Sales Invoice");
            SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
            IF NOT FINDSET THEN
                EXIT;
        END;
        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT = 0;
                    END;
                END;
            END;
        UNTIL ValueEntry.NEXT = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        END ELSE BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT;
        END;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
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

