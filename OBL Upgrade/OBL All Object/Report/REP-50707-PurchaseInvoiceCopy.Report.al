report 50707 "Purchase - Invoice Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseInvoiceCopy.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Inv. Header"; 122)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Invoice';
            column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(LOC_GST_No; locationRec."GST Registration No.")
                    {
                    }
                    column(Vend_GST_No; VendorRec."GST Registration No.")
                    {
                    }
                    column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
                    {
                    }
                    column(VendInvDate; "Purch. Inv. Header"."Vendor Invoice Date")
                    {
                    }
                    column(VendInvNo; "Purch. Inv. Header"."Vendor Invoice No.")
                    {
                    }
                    column(PostDesc; "Purch. Inv. Header"."Posting Description")
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(DocCaptionCopyText; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(VendAddr6; VendAddr[6])
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
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(PayVendNo_PurchInvHeader; "Purch. Inv. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(BuyfrVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(OrderDate; "Purch. Inv. Header"."Order Date")
                    {
                    }
                    column(BuyfrVendNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(DocDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchInvHeader; "Purch. Inv. Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Due Date"))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchInvHeader; "Purch. Inv. Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PostDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
                    {
                    }
                    column(PricIncVAT_PurchInvHeader; "Purch. Inv. Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(VATBasDisc_PurchInvHeader; "Purch. Inv. Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoEMailCaption; CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegistrationNoCaption; CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(PurchInvHeaderDueDateCaption; PurchInvHeaderDueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PurchInvHeaderPostingDateCaption; PurchInvHeaderPostingDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(PaymentTermsDescriptionCaption; PaymentTermsDescriptionCaptionLbl)
                    {
                    }
                    column(ShipmentMethodDescriptionCaption; ShipmentMethodDescriptionCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(PayVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(PricIncVAT_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; 2000000026)
                    {
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDFIRST THEN
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
                    dataitem("Purch. Inv. Line"; 123)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(HSNSACCode_PurchInvLine; "Purch. Inv. Line"."HSN/SAC Code")
                        {
                        }
                        /* column(ExciseAmt_PurchInvLineFormat; '')
                        {

                        } */
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
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                        }
                        column(ServiceTaxSBCAmount; ServiceTaxSBCAmount)
                        {
                        }
                        column(ApplServiceTaxSBCAmount; AppliedServiceTaxSBCAmount)
                        {
                        }
                        column(KKCessAmount; KKCessAmount)
                        {
                        }
                        column(AppliedKKCessAmount; AppliedKKCessAmount)
                        {
                        }
                        column(AppliedServTaxAmt; AppliedServiceTaxAmt)
                        {
                        }
                        column(ApplServTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                        }
                        column(ApplServTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                        }
                        column(LineAmt_PurchInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_PurchInvLine; Description)
                        {
                        }
                        column(No_PurchInvLine; "No.")
                        {
                        }
                        column(No_PurchInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_PurchInvLine; Quantity)
                        {
                        }
                        column(UOM_PurchInvLine; "Unit of Measure")
                        {
                        }
                        column(DirectUnitCost_PurchInvLine; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchInvLine; "Line Discount %")
                        {
                        }
                        column(AllowInvDisc_PurchInvLine; "Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(LineDiscAmt_PurchInvLine; "Line Discount Amount")
                        {
                        }
                        column(LineNo_PurchInvLine; "Purch. Inv. Line"."Line No.")
                        {
                        }
                        column(AllowVATDisctxt; AllowVATDisctxt)
                        {
                        }
                        column(PurchInLineTypeNo; PurchInLineTypeNo)
                        {
                        }
                        column(VATAmtText; VATAmountText)
                        {
                        }
                        column(SourceDocNo_PurchInvLine; "Source Document No.")
                        {
                        }
                        column(InvDiscAmt_PurchInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_PurchInvLine; Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(AmtToVend_PurchInvLine; TotalAmt) // 16630 AmtToVend_PurchInvLine; "Amount To Vendor"
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        /* column(ExciseAmt_PurchInvLine; 0) // 16630 blank "Excise Amount"
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        } */
                        column(TaxAmt_PurchInvLine; 0) // 16630 blank "Tax Amount"
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TtlTDSIncSHECESS_PurchInvLine; -TotalTDSIncAmt) // 16630 blank -"Total TDS Including SHE CESS"
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(WorkTaxAmt_PurchInvLine; 0) // 16630 blank -"Work Tax Amount"
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmt; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ChargesAmt; ChargesAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtIncVATAmt_PurchInvLine; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmt; TotalAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(PurchInvLineLineDiscountCaption; PurchInvLineLineDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PurchInvLineExciseAmountCaption; PurchInvLineExciseAmountCaptionLbl)
                        {
                        }
                        column(PurchInvLineTaxAmountCaption; PurchInvLineTaxAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxAmountCaption; ServiceTaxAmountCaptionLbl)
                        {
                        }
                        column(TotalTDSIncludingSHECESSCaption; TotalTDSIncludingSHECESSCaptionLbl)
                        {
                        }
                        column(WorkTaxAmountCaption; WorkTaxAmountCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
                        {
                        }
                        column(ChargesAmountCaption; ChargesAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxeCessAmountCaption; ServiceTaxeCessAmountCaptionLbl)
                        {
                        }
                        column(SvcTaxAmtAppliedCaption; SvcTaxAmtAppliedCaptionLbl)
                        {
                        }
                        column(SvcTaxeCessAmtAppliedCaption; SvcTaxeCessAmtAppliedCaptionLbl)
                        {
                        }
                        column(ServiceTaxSHECessAmountCaption; ServiceTaxSHECessAmountCaptionLbl)
                        {
                        }
                        column(LineAmtInvDiscountAmtAmtInclVATCaption; LineAmtInvDiscountAmtAmtInclVATCaptionLbl)
                        {
                        }
                        column(AllowInvDiscountCaption; AllowInvDiscountCaptionLbl)
                        {
                        }
                        column(Desc_PurchInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_PurchInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(LineDiscAmt_PurchInvLineCaption; FIELDCAPTION("Line Discount Amount"))
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSBCAmtAppliedCaption; SvcTaxSBCAmtAppliedCaptionLbl)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(KKCessAmtAppliedCaption; KKCessAmtAppliedCaptionLbl)
                        {
                        }
                        column(ExciseAmt_PurchInvLineFormat; '')
                        {

                        }
                        dataitem(DimensionLoop2; 2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
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
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purch. Inv. Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                        // 16630     StructureLineDetails: Record 13798;
                        begin
                            TDSEntry.Reset();
                            TDSEntry.SetRange("Document No.", "Document No.");
                            if TDSEntry.FindSet() then
                                repeat
                                    TotalTDSIncAmt += TDSEntry."Total TDS Including SHE CESS";
                                until TDSEntry.Next() = 0;

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';
                            //GST
                            CRate := 0;
                            SRate := 0;
                            IRate := 0;
                            CAmount := 0;
                            SAmount := 0;
                            IAmount := 0;
                            IGSTAmt := 0;
                            IGSTper := 0;
                            SGSTAmt := 0;
                            SGSTper := 0;
                            CGSTAmt := 0;
                            CGSTper := 0;
                            GSTBaseAmt := 0;
                            TotalAmt := 0;




                            RecDGLE.RESET();
                            RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                            RecDGLE.SETRANGE("GST Component Code", 'IGST');
                            IF RecDGLE.FINDFIRST THEN BEGIN
                                REPEAT
                                    IGSTAmt += abs(RecDGLE."GST Amount");
                                UNTIL RecDGLE.NEXT = 0;
                            END;


                            RecDGLE.RESET();
                            RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                            RecDGLE.SETRANGE("GST Component Code", 'SGST');
                            IF RecDGLE.FINDFIRST THEN BEGIN
                                REPEAT
                                    SGSTAmt += abs(RecDGLE."GST Amount");
                                UNTIL RecDGLE.NEXT = 0;
                            END;
                            RecDGLE.RESET();
                            RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                            RecDGLE.SETRANGE("GST Component Code", 'CGST');
                            IF RecDGLE.FINDFIRST THEN BEGIN
                                REPEAT
                                    CGSTAmt += abs(RecDGLE."GST Amount");
                                UNTIL RecDGLE.NEXT = 0;
                            END;


                            RecDGLE.RESET();
                            RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                            RecDGLE.SETRANGE("GST Component Code", 'CGST');
                            IF RecDGLE.FINDFIRST THEN BEGIN
                                repeat
                                    GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                until RecDGLE.next = 0;
                            END;
                            RecDGLE.RESET();
                            RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                            RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                            RecDGLE.SETRANGE("GST Component Code", 'IGST');
                            IF RecDGLE.FINDFIRST THEN BEGIN
                                repeat
                                    GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                until RecDGLE.Next() = 0;

                            END;
                            TotalAmt += "Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;



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



                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "Purch. Inv. Line"."VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."Use Tax" := "Use Tax";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            /* 16630   StructureLineDetails.RESET;
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
                                   UNTIL StructureLineDetails.NEXT = 0;*/ // 16630

                            /*  SumServiceTaxAmt := SumServiceTaxAmt + "Service Tax Amount";
                              SumServiceTaxECessAmt := SumServiceTaxECessAmt + "Service Tax eCess Amount";
                              SumServiceTaxSHECessAmt := SumServiceTaxSHECessAmt + "Service Tax SHE Cess Amount";
                              SumServiceTaxSBCAmount := SumServiceTaxSBCAmount + "Service Tax SBC Amount";
                              SumKKCessAmount := SumKKCessAmount + "KK Cess Amount";*/ // 16630
                            AllowVATDisctxt := FORMAT("Purch. Inv. Line"."Allow Invoice Disc.");
                            PurchInLineTypeNo := "Purch. Inv. Line".Type.AsInteger();
                            /* 16630   IF "Purch. Inv. Header"."Transaction No. Serv. Tax" <> 0 THEN BEGIN
                                   ServiceTaxEntry.RESET;
                                   ServiceTaxEntry.SETRANGE(Type, ServiceTaxEntry.Type::Purchase);
                                   ServiceTaxEntry.SETRANGE("Document Type", ServiceTaxEntry."Document Type"::Invoice);
                                   ServiceTaxEntry.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                                   IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                                       ServiceTaxAmt := ABS(ServiceTaxEntry."Service Tax Amount");
                                       ServiceTaxECessAmt := ABS(ServiceTaxEntry."eCess Amount");
                                       ServiceTaxSHECessAmt := ABS(ServiceTaxEntry."SHE Cess Amount");
                                       ServiceTaxSBCAmount := ABS(ServiceTaxEntry."Service Tax SBC Amount");
                                       KKCessAmount := ABS(ServiceTaxEntry."KK Cess Amount");
                                       AppliedServiceTaxAmt := SumServiceTaxAmt - ABS(ServiceTaxEntry."Service Tax Amount");
                                       AppliedServiceTaxECessAmt := SumServiceTaxECessAmt - ABS(ServiceTaxEntry."eCess Amount");
                                       AppliedServiceTaxSHECessAmt := SumServiceTaxSHECessAmt - ABS(ServiceTaxEntry."SHE Cess Amount");
                                       AppliedServiceTaxSBCAmount := SumServiceTaxSBCAmount - ABS(ServiceTaxEntry."Service Tax SBC Amount");
                                       AppliedKKCessAmount := SumKKCessAmount - ABS(ServiceTaxEntry."KK Cess Amount");
                                   END ELSE BEGIN
                                       AppliedServiceTaxAmt := "Service Tax Amount";
                                       AppliedServiceTaxECessAmt := "Service Tax eCess Amount";
                                       AppliedServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                                       AppliedServiceTaxSBCAmount := "Service Tax SBC Amount";
                                       AppliedKKCessAmount := "KK Cess Amount";
                                   END;
                               END ELSE BEGIN
                                   ServiceTaxAmt := "Service Tax Amount";
                                   ServiceTaxECessAmt := "Service Tax eCess Amount";
                                   ServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                                   ServiceTaxSBCAmount := "Service Tax SBC Amount";
                                   KKCessAmount := "KK Cess Amount";
                               END;*/ // 16630

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += TotalAmt;  // 16630 "Amount To Vendor"
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                        end;

                        trigger OnPreDataItem()
                        var
                            PurchInvLine: Record "Purch. Inv. Line";
                            VATIdentifier: Code[10];
                        begin
                            VATAmountLine.DELETEALL;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            /* 16630    CurrReport.CREATETOTALS("Line Amount", "Inv. Discount Amount", Amount, "Amount Including VAT", "Excise Amount", "Tax Amount",
                                  "Service Tax Amount", "Service Tax eCess Amount");
                                CurrReport.CREATETOTALS("Total TDS Including SHE CESS", "Work Tax Amount", "Amount To Vendor", "Service Tax SHE Cess Amount");*/ // 16630

                            PurchInvLine.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                            PurchInvLine.SETFILTER(Type, '<>%1', 0);
                            VATAmountText := '';
                            IF PurchInvLine.FIND('-') THEN BEGIN
                                VATAmountText := STRSUBSTNO(Text011, PurchInvLine."VAT %");
                                VATIdentifier := PurchInvLine."VAT Identifier";
                                REPEAT
                                    IF (PurchInvLine."VAT Identifier" <> VATIdentifier) AND (PurchInvLine.Quantity <> 0) THEN
                                        VATAmountText := Text012;
                                UNTIL PurchInvLine.NEXT = 0;
                            END;
                            i := COUNT;
                            SumServiceTaxAmt := 0;
                            SumServiceTaxECessAmt := 0;
                            SumServiceTaxSHECessAmt := 0;
                            SumServiceTaxSBCAmount := 0;
                            SumKKCessAmount := 0;
                        end;
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineVATCaption; VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATBaseVTCCaption; VATAmountLineVATBaseVTCCaptionLbl)
                        {
                        }
                        column(VATAmtLineVATAmtVTCCaption; VATAmtLineVATAmtVTCCaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtVTCCaption; VATAmtLineInvDiscBaseAmtVTCCaptionLbl)
                        {
                        }
                        column(VATAmtLineLineAmtVTCCaption; VATAmtLineLineAmtVTCCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATIdentifierCaption; VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATBaseVTC1Caption; VATAmountLineVATBaseVTC1CaptionLbl)
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
                    dataitem(VATCounterLCY; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
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
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purch. Inv. Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Purch. Inv. Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Inv. Header"."Buy-from Vendor No." = "Purch. Inv. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total3; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
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
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ShipToAddr[1] = '' THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("G/L Entry"; 17)
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
                            "Recg/LAccount".GET("G/L Account No.");
                            var3 := "G/L Entry"."G/L Account No.";
                            VAR1 := "Recg/LAccount".Name;
                            VAR2 := "G/L Entry"."Debit Amount";
                            var4 := "G/L Entry"."Credit Amount";


                            /*  IF ("Recg/LAccount"."No."='11311100')OR("Recg/LAccount"."No."='11311200')OR("Recg/LAccount"."No."='11311300')
                                OR("Recg/LAccount"."No."='11311400')THEN
                                BEGIN
                                recvendor.GET("G/L Entry"."Source No.");
                                VAR1:= recvendor.Name;
                                END;
                             CurrReport.SHOWOUTPUT:=TRUE;
                           END;*/


                            IF ("Recg/LAccount"."No." = '11312100') OR ("Recg/LAccount"."No." = '11312200') OR ("Recg/LAccount"."No." = '11312300')
                              OR ("Recg/LAccount"."No." = '11311400') THEN BEGIN
                                IF recvendor.GET("G/L Entry"."Source No.") THEN
                                    VAR1 := recvendor.Name;
                            END;

                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo := OutputNo + 1;
                        CopyText := Text003;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;

                    ServiceTaxSHECessAmt := 0;
                    ServiceTaxECessAmt := 0;
                    ServiceTaxAmt := 0;
                    ServiceTaxSBCAmount := 0;
                    KKCessAmount := 0;
                    AppliedServiceTaxSHECessAmt := 0;
                    AppliedServiceTaxECessAmt := 0;
                    AppliedServiceTaxAmt := 0;
                    AppliedServiceTaxSBCAmount := 0;
                    AppliedKKCessAmount := 0;
                    ChargesAmount := 0;
                    OtherTaxesAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchInvCountPrinted.RUN("Purch. Inv. Header");
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;
                    IF NoOfCopies = 0 THEN
                        NoOfLoops := 1
                    ELSE
                        NoOfLoops := ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchInvLine: Record "Purch. Inv. Line";
            begin
                // 16630    CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                CompanyInfo.GET;
                IF locationRec.GET("Location Code") THEN;
                IF VendorRec.GET("Pay-to Vendor No.") THEN;


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;


                IF Location.GET("Location Code") THEN
                    // 16630    FormatAddr.Location(CompanyAddr, Location);


                    DimSetEntry1.SETRANGE("Dimension Set ID", "Purch. Inv. Header"."Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Purchaser Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
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
                FormatAddr.PurchInvPayTo(VendAddr, "Purch. Inv. Header");
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

                FormatAddr.PurchInvShipTo(ShipToAddr, "Purch. Inv. Header");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          14, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                SupplementaryText := '';
                PurchInvLine.SETRANGE("Document No.", "No.");
                PurchInvLine.SETRANGE(Supplementary, TRUE);
                IF PurchInvLine.FIND('-') THEN
                    SupplementaryText := Text16500;

                PricesInclVATtxt := FORMAT("Purch. Inv. Header"."Prices Including VAT");
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
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
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
            LogInteraction := SegManagement.FindInteractTmplCode(14) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
    end;

    var
        TotalTDSIncAmt: Decimal;
        TDSEntry: Record "TDS Entry";
        ExciseAmt_PurchInvLineFormat: Label ' ';
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Purchase - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
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
        IAmount1: Decimal;
        TotalGSTAmount: Decimal;
        VendorRec: Record Vendor;
        locationRec: Record Location;
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchInvCountPrinted: Codeunit "Purch. Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        OrderNoText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[10];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Purchase - Prepayment Invoice %1';
        OutputNo: Integer;
        PricesInclVATtxt: Text[30];
        AllowVATDisctxt: Text[30];
        VATAmountText: Text[30];
        Text011: Label '%1% VAT';
        Text012: Label 'VAT Amount';
        PurchInLineTypeNo: Integer;
        OtherTaxesAmount: Decimal;
        ChargesAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        SupplementaryText: Text[30];
        Text16500: Label 'Supplementary Invoice';
        // 16630    ServiceTaxEntry: Record 16473;
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        AppliedServiceTaxAmt: Decimal;
        AppliedServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
        AppliedServiceTaxSHECessAmt: Decimal;
        i: Integer;
        NewServiceTaxAmt: Decimal;
        NewServiceTaxECessAmt: Decimal;
        NewServiceTaxSHECessAmt: Decimal;
        NewAppliedServiceTaxAmt: Decimal;
        NewAppliedServiceTaxECessAmt: Decimal;
        NewAppliedServiceTaxSHECessAmt: Decimal;
        SumServiceTaxAmt: Decimal;
        SumServiceTaxECessAmt: Decimal;
        SumServiceTaxSHECessAmt: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoEMailCaptionLbl: Label 'E-Mail';
        CompanyInfoHomePageCaptionLbl: Label 'Home Page';
        CompanyInfoVATRegistrationNoCaptionLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
        PurchInvHeaderDueDateCaptionLbl: Label 'Due Date';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PurchInvHeaderPostingDateCaptionLbl: Label 'Posting Date';
        PageCaptionLbl: Label 'Page';
        PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method';
        DocumentDateCaptionLbl: Label 'Document Date';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        PurchInvLineLineDiscountCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PurchInvLineExciseAmountCaptionLbl: Label 'Excise Amount';
        PurchInvLineTaxAmountCaptionLbl: Label 'Tax Amount';
        ServiceTaxAmountCaptionLbl: Label 'Service Tax Amount';
        TotalTDSIncludingSHECESSCaptionLbl: Label 'Total TDS Inclluding eCess';
        WorkTaxAmountCaptionLbl: Label 'Work Tax Amount';
        OtherTaxesAmountCaptionLbl: Label 'Other Taxes Amount';
        ChargesAmountCaptionLbl: Label 'Charges Amount';
        ServiceTaxeCessAmountCaptionLbl: Label 'Service Tax eCess Amount';
        SvcTaxAmtAppliedCaptionLbl: Label 'Svc Tax Amt (Applied)';
        SvcTaxeCessAmtAppliedCaptionLbl: Label 'Svc Tax eCess Amt (Applied)';
        ServiceTaxSHECessAmountCaptionLbl: Label 'Service Tax SHECess Amount';
        LineAmtInvDiscountAmtAmtInclVATCaptionLbl: Label 'Payment Discount on VAT';
        AllowInvDiscountCaptionLbl: Label 'Allow Invoice Discount';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLineVATCaptionLbl: Label 'VAT %';
        VATAmountLineVATBaseVTCCaptionLbl: Label 'VAT Base';
        VATAmtLineVATAmtVTCCaptionLbl: Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmtLineInvDiscBaseAmtVTCCaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmtLineLineAmtVTCCaptionLbl: Label 'Line Amount';
        VATAmountLineVATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmountLineVATBaseVTC1CaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        ServiceTaxSBCAmount: Decimal;
        AppliedServiceTaxSBCAmount: Decimal;
        SumServiceTaxSBCAmount: Decimal;
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        SvcTaxSBCAmtAppliedCaptionLbl: Label 'SBC Amt (Applied)';
        KKCessAmount: Decimal;
        AppliedKKCessAmount: Decimal;
        SumKKCessAmount: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        KKCessAmtAppliedCaptionLbl: Label 'KK Cess Amt (Applied)';
        VAR1: Text[1000];
        VAR2: Decimal;
        "Recg/LAccount": Record "G/L Account";
        var3: Text[30];
        recvendor: Record Vendor;
        SErvicetax: Decimal;
        var4: Decimal;
        Location: Record Location;
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmt: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";



    local procedure DocumentCaption(): Text[250]
    begin
        IF "Purch. Inv. Header"."Prepayment Invoice" THEN
            EXIT(Text010);
        EXIT(Text004);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;
}

