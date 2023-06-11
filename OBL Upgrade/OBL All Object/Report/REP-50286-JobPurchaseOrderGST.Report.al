report 50286 "Job Purchase Order GST"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\JobPurchaseOrderGST.rdl';
    Caption = 'Order';

    PreviewMode = Normal;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Locatoin_Add1; LocatoinRec.Address)
            {
            }
            column(Locatoin_Add2; LocatoinRec."Address 2")
            {
            }
            column(Locatoin_City; LocatoinRec.City)
            {
            }
            column(Locatoin_fAX; LocatoinRec."Fax No.")
            {
            }
            column(Locatoin_Post_code; LocatoinRec."Post Code")
            {
            }
            column(Locatoin_country; LocatoinRec.County)
            {
            }
            column(Locatoin_tele; LocatoinRec."Telex No.")
            {
            }
            column(Location_State; StateRec.Description)
            {
            }
            column(Locatoin_ph1; LocatoinRec."Phone No.")
            {
            }
            column(Locatoin_ph2; LocatoinRec."Phone No. 2")
            {
            }
            column(capes_no; "Purchase Header"."Capex No.")
            {
            }
            column(vendor_GST_No; vendor."GST Registration No.")
            {
            }
            column(Company_GST_No; LocatoinRec."GST Registration No.")
            {
            }
            //16225 column(TaxperPur1; FORMAT(Purchline1."Tax %"))
            column(TaxperPur1; FORMAT(0))
            {
            }
            column(TaxPerNew; TaxPerNew)
            {
            }
            column(PrintComment; PrintComment)
            {
            }
            column(DocType; "Purchase Header"."PUrchase Type")
            {
            }
            column(DOcNo; "Purchase Header"."No.")
            {
            }
            column(OrderDate; FORMAT("Purchase Header"."Order Date", 0, 4))
            {
            }
            column(AMD; AMD)
            {
            }
            column(qtd; qtd)
            {
            }
            column(PhNo; 'Ph. No. ' + vendor."Phone No.")
            {
            }
            column(VenderNo; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(VEND_ADDRESS; 'M/s. ' + BuyFromAddr[1])
            {
            }
            column(Comment1s; PurchCommLine.Comment)
            {
            }
            column(PaymentMathDes; PaymentMethod.Description)
            {
            }
            column(DeliveryDate; "Purchase Header"."Delivary Date")
            {
            }
            column(DeliveryPeriod; "Purchase Header"."Delivery Period")
            {
            }
            column(PayTermsDes; PaymentTerms.Description)
            {
            }
            column(ShipMathDes; ShipmentMethod.Description)
            {
            }
            column(DocType_PurchaseHeader; "Document Type")
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(PaymentTermsDesc; PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDesc; ShipmentMethod.Description)
            {
            }
            column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(amd_no; "Purchase Header"."Amendment No.")
            {
            }
            column(amd_dt; FORMAT("Purchase Header"."Amendment Date"))
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
            column(VATIdentCaption; VATIdentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption; ShpMethodDescCaptionLbl)
            {
            }
            column(PrepmtTermsDescCaption; PrepmtTermsDescCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
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
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(OrderCopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
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
                    column(DocDate_PurchaseHeader; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchaseHeader; "Purchase Header"."VAT Registration No.")
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
                    column(YourRef_PurchaseHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyfromVendNo_PurchaseHdr; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesIncluVAT_PurchaseHdr; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDis_PurchaseHdr; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
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
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(BuyfromVendNo_PurchaseHdrCaption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(PricesIncluVAT_PurchaseHdrCaption; "Purchase Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
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
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnAfterGetRecord()
                        var
                            TDSEntries: Record "TDS Entry";
                        begin
                            Clear(TotalIncludingAmountCESS);//15578
                            TDSEntries.Reset();
                            TDSEntries.SetRange("Document No.", "Document No.");
                            if TDSEntries.FindSet() then begin
                                repeat
                                    TotalIncludingAmountCESS += TDSEntries."Total TDS Including SHE CESS";
                                until TDSEntries.Next() = 0;

                            end;
                            CLEAR(PurchItem);
                            PurchItem := "Purchase Line"."No.";
                            RowCount := "Purchase Line".COUNT;   //RKS
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(GrandlGstAmt; TotalGSTAmtLine("Purchase Line"))//GrandlGstAmt replace
                        {
                        }
                        column(SnoNew; SnoNew)
                        {
                        }
                        //16225  column(TotalGSTAmount_PurchaseLine; "Purchase Line"."Total GST Amount")
                        column(TotalGSTAmount_PurchaseLine; TotalGSTAmtLine("Purchase Line"))
                        {
                        }
                        column(TotalGstAmt; TotalGstAmt)
                        {
                        }
                        //16225    column(Amount; "Purchase Line"."Line Amount" + "Purchase Line"."Total GST Amount")
                        column(Amount; "Purchase Line"."Direct Unit Cost")//"Purchase Line"."Line Amount" + TotalGSTAmtLine("Purchase Line")
                        {
                        }
                        column(HSNSACCode_PurchaseLine; "Purchase Line"."HSN/SAC Code")
                        {
                        }
                        //16225  column(GSTBaseAmount_PurchaseLine; "Purchase Line"."GST Base Amount")
                        column(GSTBaseAmount_PurchaseLine; LineGSTBaseAmt("Purchase Line"))
                        {
                        }
                        //16225 column(GST_PurchaseLine; "Purchase Line"."GST %")
                        column(GST_PurchaseLine; PurchaseLineGSTPer("Purchase Line"))
                        {
                        }
                        column(itemdes2; "Purchase Line"."Description 2")
                        {
                        }
                        column(PageBreak1; FORMAT(PageBreak1))
                        {
                        }
                        //16225 column(KKCessAmt; "Purchase Line"."KK Cess Amount")
                        column(KKCessAmt; 0)
                        {
                        }
                        column(PossCenvat; "Purchase Line"."Possible Cenvat")
                        {
                        }
                        //16225 column(TDSAmt; PurchLine."Bal. TDS Including SHE CESS")
                        column(TDSAmt; TotalIncludingAmountCESS)
                        {
                        }
                        column(IndentNo; "Purchase Line"."Indent No.")
                        {
                        }
                        column(LineDisAmt; "Purchase Line"."Line Discount Amount")
                        {
                        }
                        column(InvDisAmt; PurchLine."Inv. Discount Amount")
                        {
                        }
                        column(Sno; Sno)
                        {
                        }
                        column(LineAmt; LineAmt)
                        {
                        }
                        column(PurchLineLineAmount; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchaseLineDescription; "Purchase Line".Description)
                        {
                        }
                        column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(PurchaseLineType; FORMAT("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(No_PurchaseLine; "Purchase Line"."No.")
                        {
                        }
                        column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineDiscAmt_PurchaseLine; "Purchase Line"."Line Discount Amount")
                        {
                        }
                        column(NegativePurchLineInvDiscAmt; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLineInvDiscountAmt; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(PurchLineAmountToVendor; PurchLine."Line Amount" + CAmount + SAmount + IAmount)//16225 Amount Vendor Replace this Code
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225 column(PurchLineExciseAmount; PurchLine."Excise Amount")
                        column(PurchLineExciseAmount; 0)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225 column(PurchLineTaxAmount; PurchLine."Tax Amount")
                        column(PurchLineTaxAmount; 0)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225   column(PurchLineServiceTaxAmount; PurchLine."Service Tax Amount")
                        column(PurchLineServiceTaxAmount; 0)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225   column(PurchLineTotalTDSIncludingSheCess; -PurchLine."Total TDS Including SHE CESS")
                        column(PurchLineTotalTDSIncludingSheCess; -TotalIncludingAmountCESS)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225  column(PurchLineWorkTaxAmount; -PurchLine."Work Tax Amount")
                        column(PurchLineWorkTaxAmount; 0)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225  column(PurchLineSerTaxeCessAmt; PurchLine."Service Tax eCess Amount")
                        column(PurchLineSerTaxeCessAmt; 0)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        //16225  column(PurchLineSerTaxSHECessAmt; PurchLine."Service Tax SHE Cess Amount")
                        column(PurchLineSerTaxSHECessAmt; 0)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                        }
                        column(VATAmountLineVATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalServiceTaxeCessAmount; TotalServiceTaxeCessAmount)
                        {
                        }
                        column(TotalServiceTaxSHE2CessAmt; TotalServiceTaxSHE2CessAmount)
                        {
                        }
                        column(TotalSerTaxTDSSHEeCessAmt; TotalServiceTaxTDSSHEeCessAmount)
                        {
                        }
                        column(TotalServiceWorkTaxAmount; TotalServiceWorkTaxAmount)
                        {
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(DiscPercentCaption; DiscPercentCaptionLbl)
                        {
                        }
                        column(AmtCaption; AmtCaptionLbl)
                        {
                        }
                        column(LineDiscAmtCaption; LineDiscAmtCaptionLbl)
                        {
                        }
                        column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(ExciseAmtCaption; ExciseAmtCaptionLbl)
                        {
                        }
                        column(TotalTDSIncleSHECessCaption; TotalTDSIncleSHECessCaptionLbl)
                        {
                        }
                        column(WorkTaxAmtCaption; WorkTaxAmtCaptionLbl)
                        {
                        }
                        column(ServTaxeCessAmtCaption; ServTaxeCessAmtCaptionLbl)
                        {
                        }
                        column(ServTaxeSHECessAmtCaption; ServTaxeSHECessAmtCaptionLbl)
                        {
                        }
                        column(VATDiscAmtCaption; VATDiscAmtCaptionLbl)
                        {
                        }
                        column(PurchaseLineDescriptionCaption; "Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(No_PurchaseLineCaption; "Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_PurchaseLineCaption; "Purchase Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_PurchaseLineCaption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        //  column(ServTaxeSBCAmt; PurchLine."Service Tax SBC Amount")
                        column(ServTaxeSBCAmt; PurchLine."VAT Base Amount")
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(TotalGSTAmount; TotalGSTAmount)
                        {
                        }
                        column(Rate_CGST; CRate)
                        {
                        }
                        column(Rate_SGST; SRate)
                        {
                        }
                        column(Rate_UGST; URate)
                        {
                        }
                        column(Rate_IGST; IRate)
                        {
                        }
                        column(Amount_CGST; CAmount)
                        {
                        }
                        column(Amount_SGST; SAmount)
                        {
                        }
                        column(Amount_IGST; IAmount)
                        {
                        }
                        column(Amount_UGST; UAmount)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimensionLoop2_DimText; DimText)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
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

                                //Raushan GST
                                CRate := 0;
                                SRate := 0;
                                URate := 0;
                                IRate := 0;
                                CAmount := 0;
                                SAmount := 0;
                                UAmount := 0;
                                IAmount := 0;

                                DetailedGSTEntryBuffer.RESET;
                                DetailedGSTEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                                DetailedGSTEntryBuffer.SETRANGE("Transaction Type", DetailedGSTEntryBuffer."Transaction Type"::Purchase);
                                if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Blanket Order" then
                                    DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::"Blanket Order")
                                else
                                    if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Credit Memo" then
                                        DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::"Credit Memo")
                                    else
                                        if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Invoice then
                                            DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::Invoice)
                                        else
                                            if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Order then
                                                DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::Order)
                                            else
                                                if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Quote then
                                                    DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::Quote)
                                                else
                                                    if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Return Order" then
                                                        DetailedGSTEntryBuffer.SETRANGE("Document Type", DocumentType::"Return Order");
                                DetailedGSTEntryBuffer.SETRANGE("Document No.", PurchLine."Document No.");
                                DetailedGSTEntryBuffer.SETRANGE("Line No.", PurchLine."Line No.");
                                IF DetailedGSTEntryBuffer.FINDFIRST THEN
                                    REPEAT

                                        IF DetailedGSTEntryBuffer."GST Component Code" = 'CGST' THEN BEGIN
                                            CRate := DetailedGSTEntryBuffer."GST %";
                                            CAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                            //CGSTTotal+=ABS(DetailedGSTEntryBuffer."GST Amount");
                                        END;

                                        IF DetailedGSTEntryBuffer."GST Component Code" = 'SGST' THEN BEGIN
                                            SRate := DetailedGSTEntryBuffer."GST %";
                                            SAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                            //SGSTTotal+=ABS(DetailedGSTEntryBuffer."GST Amount");
                                        END;

                                        IF DetailedGSTEntryBuffer."GST Component Code" = 'IGST' THEN BEGIN
                                            IRate := DetailedGSTEntryBuffer."GST %";
                                            IAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                            //IGSTTotal+=ABS(DetailedGSTEntryBuffer."GST Amount");
                                        END;
                                        IF DetailedGSTEntryBuffer."GST Component Code" = 'UGST' THEN BEGIN
                                            URate := DetailedGSTEntryBuffer."GST %";
                                            UAmount := ABS(DetailedGSTEntryBuffer."GST Amount");

                                        END;
                                    UNTIL
DetailedGSTEntryBuffer.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }
                        dataitem("Comment Line"; "Comment Line")
                        {
                            DataItemLink = "No." = FIELD("No.");
                            DataItemLinkReference = "Purchase Line";
                            DataItemTableView = SORTING("Table Name", "No.", "Line No.")
                                                ORDER(Ascending)
                                                WHERE("Table Name" = CONST(Item));
                            column(Comments_Line_Item; COMMENTSLINE)
                            {
                            }
                            column(CommentItem; "Comment Line".Comment)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF PrintComment THEN BEGIN
                                    CommentLineCount += 1;
                                    IF "Comment Line".Comment <> '' THEN
                                        Sno += 1;
                                    IF (Sno - 1) MOD 10 = 0 THEN
                                        PageBreak1 := (Sno - 1) / 10;
                                    IF PageBreak1 = 0 THEN //MSKS18042018
                                        PageBreak1 := 1;
                                END;

                                //COMMENTSLINE +="Comment Line".Comment;
                            end;

                            trigger OnPreDataItem()
                            begin
                                //IF NOT PrintComment THEN
                                //EXIT;
                                //COMMENTSLINE:='';
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            //16225StructureLineDetails: Record "13795";
                            Currency: Record Currency;
                            ExPercal: Decimal;
                        begin

                            IF TaxPer = '' THEN
                                /*  IF "Purchase Line"."Tax %" <> 0 THEN//16225 field N/F
                                      TaxPer := FORMAT("Purchase Line"."Tax %") + ' %';*/

                            IF UOM.GET("Purchase Line"."Unit of Measure") THEN;
                            IF "Purchase Line".Description <> '' THEN
                                Sno += 1;

                            IF (Sno) MOD 10 = 0 THEN
                                PageBreak1 := (Sno) / 10;

                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT;
                            "Purchase Line" := PurchLine;
                            CLEAR(LineAmt);
                            CLEAR(TotalGstAmt);
                            CLEAR(COMMENTSLINE);
                            IF "Purchase Line"."No." <> '' THEN
                                SnoNew += 1;


                            IF Currency.GET(PurchLine."Currency Code") THEN;
                            LineAmt := ROUND(PurchLine.Quantity * PurchLine."Direct Unit Cost", Currency."Amount Rounding Precision");
                            TotLM += LineAmt;

                            TotalDisAmt += PurchLine."Line Discount Amount";


                            //16225  TotalGstAmt := PurchLine."Total GST Amount";    //RKS 060717
                            TotalGstAmt += CAmount + IAmount + SAmount;
                            GrandlGstAmt += TotalGstAmt;
                            ComentRec.RESET;
                            ComentRec.SETRANGE("No.", PurchLine."No.");
                            IF ComentRec.FINDFIRST THEN
                                REPEAT
                                    COMMENTSLINE += ',' + ComentRec.Comment;
                                UNTIL ComentRec.NEXT = 0;






                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';
                            //16225 Table N/F Start
                            /*   StructureLineDetails.RESET;
                               StructureLineDetails.SETRANGE(StructureLineDetails.Type, StructureLineDetails.Type::Purchase);
                               StructureLineDetails.SETRANGE(StructureLineDetails."Document Type", PurchLine."Document Type");
                               StructureLineDetails.SETRANGE(StructureLineDetails."Document No.", PurchLine."Document No.");
                               StructureLineDetails.SETRANGE(StructureLineDetails."Item No.", PurchLine."No.");
                               StructureLineDetails.SETRANGE("Line No.", PurchLine."Line No.");
                               IF StructureLineDetails.FIND('-') THEN
                                   REPEAT
                                       IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN
                                           IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                               IF StructureLineDetails."Tax/Charge Group" <> 'FREIGHT' THEN
                                                   ChargesAmount := ChargesAmount + ROUND(StructureLineDetails.Amount);
                                           IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                               OtherTaxesAmount := OtherTaxesAmount + ROUND(StructureLineDetails.Amount);

                                           IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Excise THEN
                                               ExciseAmount1 := ExciseAmount1 + StructureLineDetails.Amount;
                                           ExPercal := StructureLineDetails.Amount;
                                           IF (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges) AND
                                            (StructureLineDetails."Tax/Charge Group" = 'FREIGHT') THEN
                                               FreightCharges := FreightCharges + StructureLineDetails.Amount;

                                       END;
                                   UNTIL StructureLineDetails.NEXT = 0;*/
                            //16225 Table N/F End

                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");

                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;
                            //16225 Field N/f Start
                            /* TotalServiceTaxAmount += PurchLine."Service Tax Amount";
                             TotalServiceTaxeCessAmount += PurchLine."Service Tax eCess Amount";
                             TotalServiceTaxSHE2CessAmount += PurchLine."Service Tax SHE Cess Amount";
                             TotalServiceTaxTDSSHEeCessAmount += -PurchLine."Total TDS Including SHE CESS";
                             TotalServiceWorkTaxAmount += -PurchLine."Work Tax Amount";
                             TotalTaxAmount += PurchLine."Tax Amount";
                             TotalServiceTaxSBCAmount += PurchLine."Service Tax SBC Amount";
                             TotalKKCessAmount += PurchLine."KK Cess Amount";*/
                            //16225 Field N/f End

                            IF "Excise%" = '' THEN
                                IF ExPercal <> 0 THEN
                                    "Excise%" := FORMAT(ROUND(ExciseAmount1 / (TotLM - PurchLine."Line Discount Amount") * 100, 0.01, '=')) + ' %'
                                ELSE
                                    "Excise%" := '';

                            //16225   TotalGSTAmount += PurchLine."Total GST Amount"; //GST

                            /*
                            //RKS
                             IF FixedLenth>24 THEN BEGIN
                              OutputNo+=1;
                              FixedLenth:=0;
                             END;
                              FixedLenth+=1;
                             //RKS
                            */

                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            GrandlGstAmt := 0;
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            //16225 Field N/F Start
                            /* CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount",
                              PurchLine."Excise Amount", PurchLine."Tax Amount", PurchLine."Service Tax Amount",
                               PurchLine."Service Tax eCess Amount", PurchLine."Total TDS Including SHE CESS", PurchLine."Work Tax Amount",
                               PurchLine."Amount To Vendor", PurchLine."Service Tax SBC Amount");
                             CurrReport.CREATETOTALS(PurchLine."KK Cess Amount");
                             CurrReport.CREATETOTALS(PurchLine."Service Tax SHE Cess Amount");*/
                            //16225 Field N/F End
                            CLEAR(TotLM);
                            CLEAR(TotalDisAmt);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineInvDisAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
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
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATLCY; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLineVATIdentLCY; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PaytoVendorNo_PurchHdr; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PmtDetailsCaption; PmtDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SelltoCustomerNo_PurchHdr; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustomerNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccountNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDescription; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrePmtTotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmountLineVATAmountText; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrePmtTotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvBufAmountPrepmtVATAmount; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoopNumber; Number)
                        {
                        }
                        column(DescCaption; DescCaptionLbl)
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
                            column(PrepmtDimLoop_DimText; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT PrepmtDimSetEntry.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
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
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");

                            IF "Purchase Header"."Prices Including VAT" THEN
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
                        column(PrepmtVATAmountLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLineVAT; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLineVATIdent; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATAmtSpecCaption; PrepmtVATAmtSpecCaptionLbl)
                        {
                        }
                        column(PrepmtVATIdentCaption; PrepmtVATIdentCaptionLbl)
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
                    dataitem(RowsIns; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Yescap; 'Yes')
                        {
                        }
                        column(IncRowas; IncRowas)
                        {
                        }
                        column(TotalTaxAmount; TotalTaxAmount)
                        {
                        }
                        column(TaxAmtCaption; TaxAmtCaptionLbl)
                        {
                        }
                        column(ServTaxAmtCaption; ServTaxAmtCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmtCaption; OtherTaxesAmtCaptionLbl)
                        {
                        }
                        column(ChrgsAmtCaption; ChrgsAmtCaptionLbl)
                        {
                        }
                        column(ExciseAmount1; ExciseAmount1)
                        {
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalServiceTaxAmount; TotalServiceTaxAmount)
                        {
                        }
                        column(TotalServiceTaxSBCAmount; TotalServiceTaxSBCAmount)
                        {
                        }
                        column(ExcisePer; "Excise%")
                        {
                        }
                        column(TaxPer; TaxPer)
                        {
                        }
                        column(FreightCharges; FreightCharges)
                        {
                        }
                        column(TotLM; TotLM)
                        {
                        }
                        column(TotalDisAmt; TotalDisAmt)
                        {
                        }
                        column(TotalKKCessAmount; TotalKKCessAmount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IncRowas += 1;

                            //MESSAGE('%1',TotalTaxAmount);
                        end;

                        trigger OnPreDataItem()
                        var
                            rowstogen: Integer;
                        begin
                            //RKS
                            IF Sno < 10 THEN
                                rowstogen := 10 - Sno
                            ELSE BEGIN
                                rowstogen := Sno - 10 * PageBreak1;
                                rowstogen := 10 - rowstogen;
                            END;

                            //IF rowstogen < 4 THEN
                            //rowstogen := rowstogen + 2;
                            //IF PrintComment THEN
                            //rowstogen := ABS(rowstogen - CommentLineCount);

                            IF rowstogen <> 0 THEN
                                SETRANGE(Number, 1, rowstogen)//,rowstogen+3);
                            ELSE
                                SETRANGE(Number, 1, 1);
                            CLEAR(IncRowas)

                            //SETRANGE(Number,1,10-RowCount);
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    IF (NOT PrepmtPurchLine.ISEMPTY) THEN BEGIN
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        IF NOT TempPurchLine.ISEMPTY THEN
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    END;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    IF PrepmtVATAmountLine.FINDSET THEN
                        REPEAT
                            PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            IF PrePmtVATAmountLineDeduct.FIND THEN BEGIN
                                PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrePmtVATAmountLineDeduct."VAT Base";
                                PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrePmtVATAmountLineDeduct."VAT Amount";
                                PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                                  PrePmtVATAmountLineDeduct."Amount Including VAT";
                                PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrePmtVATAmountLineDeduct."Line Amount";
                                PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  PrePmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                                  PrePmtVATAmountLineDeduct."Invoice Discount Amount";
                                PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                                  PrePmtVATAmountLineDeduct."Calculated VAT Amount";
                                PrepmtVATAmountLine.MODIFY;
                            END;
                        UNTIL PrepmtVATAmountLine.NEXT = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    ///    PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                    ChargesAmount := 0;
                    OtherTaxesAmount := 0;

                    TotalInvoiceDiscountAmount := 0;

                    TotalServiceTaxAmount := 0;
                    TotalServiceTaxeCessAmount := 0;
                    TotalServiceTaxSHE2CessAmount := 0;
                    TotalServiceTaxTDSSHEeCessAmount := 0;
                    TotalServiceWorkTaxAmount := 0;
                    TotalTaxAmount := 0;
                    TotalServiceTaxSBCAmount := 0;
                    TotalKKCessAmount := 0;
                    TotalGSTAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurLine: Record "Purchase Line";
                //16225StrDetLine: Record "13795";
                Taxpertotal: Decimal;
                CountTemp: Integer;
                TaxperTemp: Decimal;
                TempCount: Integer;
            begin
                IF (Status <> Status::Released) AND (Status <> Status::"Short Close") THEN
                    IF NOT CurrReport.PREVIEW THEN
                        ERROR('Status Should Be Released');

                //Rks location ADDRESS
                LocatoinRec.RESET;
                IF LocatoinRec.GET("Location Code") THEN;
                IF StateRec.GET(LocatoinRec."State Code") THEN;

                //RKA END;

                PurLine.RESET;
                PurLine.SETRANGE("Document No.", "No.");
                PurLine.SETRANGE(Type, PurLine.Type::Item);
                IF PurLine.FINDFIRST THEN
                    REPEAT
                        TempCount += 1;
                        IF TaxperTemp = 0 THEN;
                    //16225    TaxperTemp := PurLine."Tax %";
                    //16225 table N/F start
                    /* StrDetLine.RESET;
                     StrDetLine.SETRANGE("Document Type", PurLine."Document Type");
                     StrDetLine.SETRANGE("Document No.", PurLine."Document No.");
                     StrDetLine.SETRANGE("Line No.", PurLine."Line No.");
                     StrDetLine.SETRANGE("Tax/Charge Type", StrDetLine."Tax/Charge Type"::"Sales Tax");
                     IF StrDetLine.FINDFIRST THEN BEGIN
                         Taxpertotal += StrDetLine."Calculation Value";
                         CountTemp += 1;
                     END;*///16225 table N/F End

                    UNTIL
                    PurLine.NEXT = 0;
                IF CountTemp <> 0 THEN
                    IF TempCount > 1 THEN
                        TaxPerNew := (Taxpertotal / CountTemp)
                    ELSE
                        TaxPerNew := TaxperTemp;


                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    Purchline1.RESET;
                    Purchline1.SETRANGE("Document No.", "No.");
                    Purchline1.SETFILTER(Type, '%1|%2|%3', 1, 2, 4);
                    IF Purchline1.FIND('-') THEN BEGIN
                        REPEAT
                            IF (STRLEN(Purchline1."No.") > 0) AND (Purchline1."Buy-from Vendor No." = '') THEN BEGIN
                                Purchline1."Buy-from Vendor No." := "Buy-from Vendor No.";
                                Purchline1.MODIFY;
                            END;
                        UNTIL Purchline1.NEXT = 0;
                    END;
                END;


                //16225 Funcation N/F CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CLEAR(CommentLineCount);
                PurchCommLine.RESET;
                PurchCommLine.SETRANGE("Document Type", "Document Type");
                PurchCommLine.SETRANGE("No.", "No.");
                IF PurchCommLine.FINDFIRST THEN;
                CompanyInfo.GET;
                IF vendor.GET("Purchase Header"."Buy-from Vendor No.") THEN;
                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);


                IF "Amendment No." <> '' THEN
                    AMD := 'Amendment No. ' + "Amendment No." + '  Date ' + FORMAT("Amendment Date")
                ELSE
                    AMD := '';

                IF "Quotation No." <> '' THEN
                    qtd := 'Quotation No. ' + "Quotation No." + '  Date ' + FORMAT("Quotation Date")
                ELSE
                    qtd := '';


                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF "Buy-from Vendor No." <> "Pay-to Vendor No." THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;


                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                //FixedLenth:=0; //RKS
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
                    field(NoofCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
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
                    field("Print Comment"; PrintComment)
                    {
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
            //16225 ArchiveDocument := PurchSetup."Archive Quotes and Orders";
            ArchiveDocument := PurchSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        PurchSetup.GET;
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        FixedLenth: Integer;
        ComentRec: Record "Comment Line";
        COMMENTSLINE: Text[1024];
        GrandlGstAmt: Decimal;
        TotalGstAmt: Decimal;
        LocatoinRec: Record Location;
        StateRec: Record State;
        RowCount: Decimal;
        TotalGSTAmount: Decimal;
        IGSTinWords: array[5] of Text[1024];
        CGSTinWords: array[5] of Text[1024];
        SGSTinWords: array[5] of Text[1024];
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        URate: Decimal;
        UAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        DetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        FormatAddr: Codeunit "Format Address";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
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
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtAmountInclVAT: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        OtherTaxesAmount: Decimal;
        ChargesAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalTaxAmount: Decimal;
        TotalServiceTaxAmount: Decimal;
        TotalServiceTaxeCessAmount: Decimal;
        TotalServiceTaxSHE2CessAmount: Decimal;
        TotalServiceTaxTDSSHEeCessAmount: Decimal;
        TotalServiceWorkTaxAmount: Decimal;
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        HdrDimsCaptionLbl: Label 'Header Dimensions';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        DiscPercentCaptionLbl: Label 'Discount %';
        AmtCaptionLbl: Label 'Amount';
        LineDiscAmtCaptionLbl: Label 'Line Discount Amount';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
        SubtotalCaptionLbl: Label 'Subtotal';
        ExciseAmtCaptionLbl: Label 'Excise Amount';
        TaxAmtCaptionLbl: Label 'Tax Amount';
        ServTaxAmtCaptionLbl: Label 'Service Tax Amount';
        OtherTaxesAmtCaptionLbl: Label 'Other Taxes Amount';
        ChrgsAmtCaptionLbl: Label 'Charges Amount';
        TotalTDSIncleSHECessCaptionLbl: Label 'Total TDS Incl. eCess Amount';
        WorkTaxAmtCaptionLbl: Label 'Work Tax Amount';
        ServTaxeCessAmtCaptionLbl: Label 'Service Tax eCess Amount';
        ServTaxeSHECessAmtCaptionLbl: Label 'Service Tax SHECess Amount';
        VATDiscAmtCaptionLbl: Label 'Payment Discount on VAT';
        LineDimsCaptionLbl: Label 'Line Dimensions';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        PmtDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        DescCaptionLbl: Label 'Description';
        GLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepmtSpecCaptionLbl: Label 'Prepayment Specification';
        PrepmtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        PrepmtVATIdentCaptionLbl: Label 'VAT Identifier';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATIdentCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        TotalIncludingAmountCESS: Decimal;
        PmtTermsDescCaptionLbl: Label 'Payment Terms';
        ShpMethodDescCaptionLbl: Label 'Shipment Method';
        PrepmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        DocDateCaptionLbl: Label 'Document Date';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        TotalServiceTaxSBCAmount: Decimal;
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        TotalKKCessAmount: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        PaymentMethod: Record "Payment Method";
        PurchCommLine: Record "Purch. Comment Line";
        vendor: Record Vendor;
        AMD: Text[50];
        DocumentType: Enum "Document Type Enum";
        qtd: Text[50];
        LineAmt: Decimal;
        Sno: Integer;
        FreightCharges: Decimal;
        ExciseAmount1: Decimal;
        IncRowas: Integer;
        PageBreak1: Integer;
        UOM: Record "Unit of Measure";
        SnoNew: Integer;
        PurchItem: Code[20];
        PrintComment: Boolean;
        CommentLineCount: Integer;
        "Excise%": Text[20];
        TotLM: Decimal;
        TaxPer: Text[20];
        TotalDisAmt: Decimal;
        TaxPerNew: Decimal;
        Purchline1: Record "Purchase Line";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    procedure TotalGSTAmtLine(T39: Record 39): Decimal
    var
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccPurchaseLine: Record "Purchase Line";
        TotalAmt: Decimal;
        GSTSetup: Record "GST Setup";
        ComponentName: Text;
        TaxTransactionValue: Record "Tax Transaction Value";
        sgstTOTAL: Decimal;
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        Clear(igst);
        Clear(sgst);
        Clear(cgst);
        Clear(TotalAmt);
        Clear(TDSAmt);

        GSTSetup.Get();

        if T39.Type <> T39.Type::" " then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T39.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                ComponentName := 'SGST';
                                sgst := abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper3 := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                ComponentName := 'CGST';
                                cgst := abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper2 := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                ComponentName := 'IGST';
                                igst := abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper1 := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;


        exit(igst + sgst + cgst);
    end;

    procedure PurchaseLineGSTPer(T39: Record 39): Decimal
    var
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccPurchaseLine: Record "Purchase Line";
        TotalAmt: Decimal;
        GSTSetup: Record "GST Setup";
        ComponentName: Text;
        TaxTransactionValue: Record "Tax Transaction Value";
        sgstTOTAL: Decimal;
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        Clear(igst);
        Clear(sgst);
        Clear(cgst);
        Clear(TotalAmt);
        Clear(TDSAmt);

        GSTSetup.Get();

        if T39.Type <> T39.Type::" " then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T39.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                ComponentName := 'SGST';
                                sgst := abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper3 := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                ComponentName := 'CGST';
                                cgst := abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper2 := TaxTransactionValue.Percent * 2;
                            end;
                        3:
                            begin
                                ComponentName := 'IGST';
                                igst := abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper1 := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;


        exit(GSTper2 + GSTper1);
    end;


    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
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

    procedure LineGSTBaseAmt(T39: Record 39): Decimal
    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";

    begin
        GSTSetup.Get();

        if T39.Type <> T39.Type::" " then begin

            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T39.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 10);
            if TaxTransactionValue.FindFirst() then
                exit(TaxTransactionValue.Amount);
            Message('%1', TaxTransactionValue.Amount);
        end;
    end;



}

