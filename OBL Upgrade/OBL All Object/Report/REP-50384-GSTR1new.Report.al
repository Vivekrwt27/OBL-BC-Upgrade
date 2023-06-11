report 50384 "GSTR1 new"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\GSTR1new.rdl';
    Caption = 'GSTR-1';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));
            column(GSTComponent_1; GSTComp[1])
            {
            }
            column(GSTComponent_2; GSTComp[2])
            {
            }
            column(GSTComponent_3; GSTComp[3])
            {
            }
            column(GSTComponent_4; GSTComp[4])
            {
            }
            column(GSTComponent_5; GSTComp[5])
            {
            }
            column(GSTINLocation; GSTINLocation)
            {
            }
            column(TaxablePerson; TaxablePerson)
            {
            }
            column(AggregateTurnOver; AggregateTurnOver)
            {
            }
            column(Period; Period)
            {
                OptionMembers = "<Jan",Feb,March,Apr,May,June,July,Aug,Sept,Oct,Nov,"Dec>";
            }
            column(PersonName; PersonName)
            {
            }
            column(Place; Place)
            {
            }
            column(Year; Year)
            {
            }
            column(MaxDate; MaxDate)
            {
            }
            column(MinDate; MinDate)
            {
            }
            column(TODAY; FORMAT(TODAY, 0, 4))
            {
            }
            column(Date; FORMAT(Date))
            {
            }

            trigger OnPreDataItem()
            begin
                i := 1;
                //16225 Codeunit N/F Start
                /* GSTComponent.SETCURRENTKEY("Report View");
                 GSTComponent.ASCENDING(TRUE);
                 IF GSTComponent.FINDSET THEN BEGIN
                     REPEAT
                         GSTComp[i] := GSTComponent.Code;
                         i += 1;
                     UNTIL GSTComponent.NEXT = 0;
                 END ELSE
                     ERROR(ReportViewErr);*///16225 Codeunit N/F End
            end;
        }
        dataitem("Detailed GST Ledger Entry"; "Detailed GST Ledger Entry")
        {
            column(TOTBASE; TOTBASE)
            {
            }
            column(TOTCESS; TOTCESS)
            {
            }
            column(TOTU; TOTU)
            {
            }
            column(TOTI; TOTI)
            {
            }
            column(TOTS; TOTS)
            {
            }
            column(TOTC; TOTC)
            {
            }
            column(TOTALADJ; TOTALADJ)
            {
            }
            column(TOTALINV; TOTALINV)
            {
            }
            column(TransactionType_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Transaction Type")
            {
            }
            column(amtadjusted; amtadjusted)
            {
            }
            column(invoicee; invoicee)
            {
            }
            column(invoicedate; FORMAT(invoicedate))
            {
            }
            column(recieptvoucherno; RecieptNumber)
            {
            }
            column(recieptvoucherdate; FORMAT(RecieptDate))
            {
            }
            //16225  column(BuyerSellerStateCode_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Buyer/Seller State Code")
            column(BuyerSellerStateCode_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Buyer/Seller Reg. No.")
            {
            }
            //16225   column(BillOfExportNo_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Bill Of Export No.")
            column(BillOfExportNo_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Buyer/Seller Reg. No.")
            {
            }
            //16225   column(BillOfExportDate_DetailedGSTLedgerEntry; FORMAT("Detailed GST Ledger Entry"."Bill Of Export Date"))
            column(BillOfExportDate_DetailedGSTLedgerEntry; '')
            {
            }
            column(GSTWithoutPaymentofDuty_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."GST Without Payment of Duty")
            {
            }
            //16225    column(NatureofSupply_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Nature of Supply")
            column(NatureofSupply_DetailedGSTLedgerEntry; '')
            {
            }
            column(Quantity_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry".Quantity)
            {
            }
            column(HSNSACCode_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."HSN/SAC Code")
            {
            }
            column(DocumentNo_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Document No.")
            {
            }
            column(PostingDate_DetailedGSTLedgerEntry; FORMAT("Detailed GST Ledger Entry"."Posting Date"))
            {
            }
            column(DocumentType_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Document Type")
            {
            }
            column(GSTCustomerType_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."GST Customer Type")
            {
            }
            column(GSTJurisdictionType_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."GST Jurisdiction Type")
            {
            }
            column(DeemedNo; DeemedNo)
            {
            }
            column(DeemedDate; FORMAT(DeemedDate))
            {
            }
            column(BuyerSellerRegNo_1; BuyerSellerRegNo[1])
            {
            }
            column(InvoiceNo_1; InvoiceNo[1])
            {
            }
            column(GoodsService_1; GoodsService[1])
            {
            }
            column(HSNSAC_1; HSNSAC[1])
            {
            }
            column(s; Pos[1])
            {
            }
            column(GSTGroupType_1; FORMAT(GSTGroupType[1]))
            {
            }
            column(PostingDate_1; FORMAT(PostingDate[1]))
            {
            }
            column(Crate; Crate)
            {
            }
            column(Camt; Camt)
            {
            }
            column(Srate; Srate)
            {
            }
            column(Samt; Samt)
            {
            }
            column(Irate; Irate)
            {
            }
            column(Iamt; Iamt)
            {
            }
            column(Urate; Urate)
            {
            }
            column(Uamt; Uamt)
            {
            }
            column(ITCAmt_1; ITCAmt[1])
            {
            }
            column(ITCAmt_2; ITCAmt[2])
            {
            }
            column(ITCAmt_3; ITCAmt[3])
            {
            }
            column(BuyerSellerRegNo_7; BuyerSellerRegNo[7])
            {
            }
            column(InvoiceNo_7; InvoiceNo[7])
            {
            }
            column(GoodsService_7; GoodsService[7])
            {
            }
            column(Pos_7; Pos[7])
            {
            }
            column(GSTGroupType_7; FORMAT(GSTGroupType[7]))
            {
            }
            column(PostingDate_7; FORMAT(PostingDate[7]))
            {
            }
            column(GSTBaseAmt_8; GSTBaseAmt[8])
            {
            }
            column(BillofEntryNo; BillofEntryNo)
            {
            }
            column(BillofEntryDate; BillofEntryDate)
            {
            }
            column(BillofEntryValue; BillofEntryValue)
            {
            }
            column(GSTBaseAmt_2; GSTBaseAmt[2])
            {
            }
            column(GSTGroupType_2; FORMAT(GSTGroupType[2]))
            {
            }
            column(ITCAmt_4; ITCAmt[4])
            {
            }
            column(ITCAmt_5; ITCAmt[5])
            {
            }
            column(ITCAmt_6; ITCAmt[6])
            {
            }
            column(InvoiceNo_8; InvoiceNo[8])
            {
            }
            column(GSTBaseAmt_3; GSTBaseAmt[3])
            {
            }
            column(PostingDate_8; PostingDate[8])
            {
            }
            column(ITCAmt_7; ITCAmt[7])
            {
            }
            column(ITCAmt_8; ITCAmt[8])
            {
            }
            column(ITCAmt_9; ITCAmt[9])
            {
            }
            column(BuyerSellerRegNo_2; BuyerSellerRegNo[2])
            {
            }
            column(DocumentType_1; DocumentType[1])
            {
            }
            column(DocumentNo_1; DocumentNo[1])
            {
            }
            column(PostingDate_2; FORMAT(PostingDate[2]))
            {
            }
            column(GSTBaseAmt_4; GSTBaseAmt[4])
            {
            }
            column(GSTGroupType_3; FORMAT(GSTGroupType[3]))
            {
            }
            column(OriginalInvNo_1; OriginalInvNo[1])
            {
            }
            column(OriginalInvDate_1; OriginalInvDate[1])
            {
            }
            column(ITCAmt_10; ITCAmt[10])
            {
            }
            column(ITCAmt_11; ITCAmt[11])
            {
            }
            column(ITCAmt_12; ITCAmt[12])
            {
            }
            column(BuyerSellerRegNo_3; BuyerSellerRegNo[3])
            {
            }
            column(DocumentType_2; DocumentType[2])
            {
            }
            column(DocumentNo_2; DocumentNo[2])
            {
            }
            column(PostingDate_3; FORMAT(PostingDate[3]))
            {
            }
            column(GSTBaseAmt_5; GSTBaseAmt[5])
            {
            }
            column(GSTGroupType_4; FORMAT(GSTGroupType[4]))
            {
            }
            column(OriginalInvNo_2; OriginalInvNo[2])
            {
            }
            column(OriginalInvDate_2; OriginalInvDate[2])
            {
            }
            column(BuyerSellerRegNo_4; BuyerSellerRegNo[4])
            {
            }
            column(DocumentNo_3; DocumentNo[3])
            {
            }
            column(PostingDate_4; FORMAT(PostingDate[4]))
            {
            }
            column(GoodsService_2; GoodsService[2])
            {
            }
            column(LocStateCode_1; LocStateCode[1])
            {
            }
            column(DocumentNo_4; DocumentNo[4])
            {
            }
            column(PostingDate_5; PostingDate[5])
            {
            }
            column(PaymentDocNo_1; PaymentDocNo[1])
            {
            }
            column(Description_1; Description[1])
            {
            }
            column(Description_2; Description[2])
            {
            }
            column(Sno; Sno)
            {
            }
            column(Custname; Custname)
            {
            }
            column(CustRegno; CustRegno)
            {
            }
            column(itemdesc; itemdesc)
            {
            }
            column(itemUom; itemUom)
            {
            }
            column(HSNGL; "G/L"."HSN/SAC Code")
            {
            }
            column(GLSAC; GLSAC)
            {
            }
            column(No; No)
            {
            }
            column(Datee; FORMAT(Datee))
            {
            }
            column(DCrate; DCrate)
            {
            }
            column(GSTBaseAmount_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."GST Base Amount")
            {
            }
            column(EntryNo_DetailedGSTLedgerEntry; "Detailed GST Ledger Entry"."Entry No.")
            {
            }
            column(PostingDate9; FORMAT(PostingDate[9]))
            {
            }
            column(CessA; CessA)
            {
            }
            column(TotInv; TotInv)
            {
            }
            column(docuno; docuno)
            {
            }
            column(docudate; FORMAT(docudate))
            {
            }
            column(Exportno; Exportno)
            {
            }
            column(ExportD; FORMAT(ExportD))
            {
            }
            column(TOTBASE1; TOTBASE1)
            {
            }
            column(TOTCESS1; TOTCESS1)
            {
            }
            column(TOTU1; TOTU1)
            {
            }
            column(TOTI1; TOTI1)
            {
            }
            column(TOTS1; TOTS1)
            {
            }
            column(TOTC1; TOTC1)
            {
            }
            column(TOTALADJ1; TOTALADJ1)
            {
            }
            column(TOTALINV1; TOTALINV1)
            {
            }
            column(TotInv1; TotInv1)
            {
            }
            column(TOTBASE2; TOTBASE2)
            {
            }
            column(TOTCESS2; TOTCESS2)
            {
            }
            column(TOTU2; TOTU2)
            {
            }
            column(TOTI2; TOTI2)
            {
            }
            column(TOTS2; TOTS2)
            {
            }
            column(TOTC2; TOTC2)
            {
            }
            column(TOTALADJ2; TOTALADJ2)
            {
            }
            column(TOTALINV2; TOTALINV2)
            {
            }
            column(TotInv2; TotInv2)
            {
            }
            column(HSNCode; HSNCode)
            {
            }
            column(SACCode; SACCode)
            {
            }
            column(TOTQ; TOTQ)
            {
            }
            //16225   column(amttocust; "Detailed GST Ledger Entry"."Amount to Customer/Vendor")
            column(amttocust; GetAmttoCustomerPostedLine(Salesinvline."Document No.", Salesinvline."Line No.") / GetAmttoVendorPostedLine(Purchinvline."Document No.", Purchinvline."Line No."))
            {
            }
            column(gstvendtype; "Detailed GST Ledger Entry"."GST Vendor Type")
            {
            }
            column(CustomerVendorName; CustomerVendorName)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //01-09-2017

                HSNCode := '';
                THSNSAC.RESET;
                THSNSAC.SETRANGE(Code, "HSN/SAC Code");
                IF THSNSAC.FINDFIRST THEN
                    IF THSNSAC.Type = THSNSAC.Type::HSN THEN BEGIN
                        HSNCode := THSNSAC.Code
                    END;

                GLSAC := '';
                "G/L".RESET;
                "G/L".SETRANGE("No.", "No.");
                IF "G/L".FIND('-') THEN BEGIN
                    GLSAC := "G/L"."HSN/SAC Code"
                END;


                //01092017
                /*
              IF DocNo <>"Detailed GST Ledger Entry"."Document No." THEN BEGIN
                DocNo := "Detailed GST Ledger Entry"."Document No.";

              END ELSE BEGIN
                CurrReport.SKIP;
              END;
               */
                Crate := 0;
                Urate := 0;
                Srate := 0;
                Irate := 0;
                Camt := 0;
                Samt := 0;
                Iamt := 0;
                Uamt := 0;
                //if "Detailed GST Ledger Entry"."Document Type"="Detailed GST Ledger Entry"."Document Type"::INVOICE then repeat

                "Detailed GST Ledger Entry".RESET;
                "Detailed GST Ledger Entry".SETRANGE("Document No.", "Document No.");
                "Detailed GST Ledger Entry".SETRANGE("No.", "No.");
                //"Detailed GST Ledger Entry".SETRANGE("Document Line No.","Line No.");
                IF "Detailed GST Ledger Entry".FINDFIRST THEN
                    REPEAT

                        IF "Detailed GST Ledger Entry"."GST Component Code" = 'CGST' THEN BEGIN
                            Crate := "Detailed GST Ledger Entry"."GST %";
                            Camt := -("Detailed GST Ledger Entry"."GST Amount");
                        END;

                        IF "Detailed GST Ledger Entry"."GST Component Code" = 'SGST' THEN BEGIN
                            Srate := "Detailed GST Ledger Entry"."GST %";
                            Samt := -("Detailed GST Ledger Entry"."GST Amount");
                        END;

                        IF "Detailed GST Ledger Entry"."GST Component Code" = 'IGST' THEN BEGIN
                            Irate := "Detailed GST Ledger Entry"."GST %";
                            Iamt := -("Detailed GST Ledger Entry"."GST Amount");

                        END;
                        IF "Detailed GST Ledger Entry"."GST Component Code" = 'UGST' THEN BEGIN
                            Urate := "Detailed GST Ledger Entry"."GST %";
                            Uamt := -("Detailed GST Ledger Entry"."GST Amount");
                        END;
                    UNTIL
"Detailed GST Ledger Entry".NEXT = 0;

                //DetailsOfCreditAndDebitWithRevCharge(
                //  "Detailed GST Ledger Entry",GSTCompRate[10],GSTCompRate[11],GSTCompRate[12],GSTCompAmt[10],
                //  GSTCompAmt[11],GSTCompAmt[12],GSTComp[1],GSTComp[2],GSTComp[3]);

                IF ("Entry Type" = "Entry Type"::"Initial Entry") AND
                   ("Document Type" = "Document Type"::Payment) AND "GST on Advance Payment"
                THEN BEGIN
                    BuyerSellerRegNo[4] := "Buyer/Seller Reg. No.";
                    AdvancePaymentAfterPosting(
                      "Detailed GST Ledger Entry", GSTCompRate[16], GSTCompRate[17], GSTCompRate[18],
                      GSTCompAmt[16], GSTCompAmt[17], GSTCompAmt[18], GSTComp[1], GSTComp[2], GSTComp[3]);
                END;
                IF ("Entry Type" = "Entry Type"::Application) AND
                   ("Document Type" = "Document Type"::Invoice) AND "Reverse Charge" AND Paid AND "GST on Advance Payment"
                THEN
                    AdvancePaymentBeforePosting(
                      "Detailed GST Ledger Entry", GSTCompRate[19], GSTCompRate[20], GSTCompRate[21],
                      GSTCompAmt[19], GSTCompAmt[20], GSTCompAmt[21], GSTComp[1], GSTComp[2], GSTComp[3]);


                //registerd or unreg
                "Detailed GST Ledger Entry".RESET;


                //custname and Custregno NK
                Cust.RESET;

                IF Cust.GET("Detailed GST Ledger Entry"."Source No.") THEN BEGIN
                    Custname := Cust.Name;
                    IF ("GST Customer Type" = "GST Customer Type"::Unregistered) THEN
                        CustRegno := ' '
                    ELSE
                        IF ("GST Customer Type" = "GST Customer Type"::Registered) THEN
                            CustRegno := Cust."GST Registration No."

                END;

                IF Vend.GET("Detailed GST Ledger Entry"."Source No.") THEN BEGIN
                    Custname := Vend.Name;
                    IF ("GST Vendor Type" = "GST Vendor Type"::Unregistered) THEN
                        CustRegno := ' '
                    ELSE
                        IF ("GST Vendor Type" = "GST Vendor Type"::Registered) THEN
                            CustRegno := Vend."GST Registration No."

                END;


                //TYPE:=' ';
                //05-09-2017
                IF "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales THEN BEGIN
                    IF "Detailed GST Ledger Entry"."GST Customer Type" = "Detailed GST Ledger Entry"."GST Customer Type"::"Deemed Export" THEN
                        CustomerVendorName := 'Deemed Export'
                    ELSE
                        IF "Detailed GST Ledger Entry"."GST Customer Type" = "Detailed GST Ledger Entry"."GST Customer Type"::Exempted THEN
                            CustomerVendorName := 'Exempted'
                        ELSE
                            IF "Detailed GST Ledger Entry"."GST Customer Type" = "Detailed GST Ledger Entry"."GST Customer Type"::Export THEN
                                CustomerVendorName := 'Export'
                            ELSE
                                IF "Detailed GST Ledger Entry"."GST Customer Type" = "Detailed GST Ledger Entry"."GST Customer Type"::Registered THEN
                                    CustomerVendorName := 'Registered'
                                ELSE
                                    IF "Detailed GST Ledger Entry"."GST Customer Type" = "Detailed GST Ledger Entry"."GST Customer Type"::Unregistered THEN
                                        CustomerVendorName := 'Unregistered'
                END ELSE
                    IF "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Purchase THEN BEGIN
                        IF "Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered THEN
                            CustomerVendorName := 'Unregistered'
                    END;



                DeemedNo := '';
                DeemedDate := 0D;
                ///deemed export no
                IF "GST Customer Type" = "GST Customer Type"::"Deemed Export" THEN
                    DeemedNo := "Detailed GST Ledger Entry"."Document No."
                ELSE
                    DeemedNo := '';

                ///deemed export
                IF "GST Customer Type" = "GST Customer Type"::"Deemed Export" THEN
                    DeemedDate := "Detailed GST Ledger Entry"."Posting Date"
                ELSE
                    DeemedDate := 0D;

                ///export
                Exportno := '';
                //16225 Field N/F start
                /*IF "GST Customer Type" = "GST Customer Type"::Export THEN
                    Exportno := "Bill Of Export No."
                ELSE
                    Exportno := '';*///16225 Field N/F End

                ///export
                ExportD := 0D;
                //16225 Field N/F start
                /*  IF "GST Customer Type" = "GST Customer Type"::Export THEN
                      ExportD := "Bill Of Export Date"
                  ELSE
                      ExportD := 0D;*///16225 Field N/F End


                //serial no of credit/refund voucher //
                No := '';
                IF ("Document Type" = "Document Type"::"Credit Memo") OR ("Document Type" = "Document Type"::Refund) THEN
                    No := "Detailed GST Ledger Entry"."Document No."
                ELSE
                    No := '';
                IF ("Document Type" = "Document Type"::"Credit Memo") OR ("Document Type" = "Document Type"::Refund) THEN
                    Datee := "Detailed GST Ledger Entry"."Posting Date"
                ELSE
                    Datee := 0D;

                Item.RESET;
                IF Item.GET("Detailed GST Ledger Entry"."No.") THEN BEGIN
                    itemdesc := Item.Description;
                    itemUom := Item."Base Unit of Measure";
                END;

                invoicee := '';
                invoicedate := 0D;
                //NK no and date on posted invoice of credit memo//
                IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo") THEN BEGIN

                    IF "Detailed GST Ledger Entry"."Document No." <> '' THEN BEGIN

                        Saless.RESET;
                        Saless.SETRANGE("No.", "Detailed GST Ledger Entry"."Document No.");
                        Saless.SETRANGE("Posting Date", "Detailed GST Ledger Entry"."Posting Date");

                        IF Saless.FINDFIRST THEN BEGIN
                            IF (Saless."Applies-to Doc. Type" = Saless."Applies-to Doc. Type"::Invoice) THEN BEGIN
                                invoicee := Saless."Applies-to Doc. No.";
                                invoicedate := Saless."Posting Date"
                            END
                        END
                    END
                END;

                //reciept
                RecieptNumber := '';
                IF ("Document Type" = "Document Type"::Payment) THEN
                    RecieptNumber := "Detailed GST Ledger Entry"."Document No."
                ELSE
                    RecieptNumber := '';
                IF ("Document Type" = "Document Type"::Payment) THEN
                    RecieptDate := "Detailed GST Ledger Entry"."Posting Date"
                ELSE
                    RecieptDate := 0D;

                DetailGST.RESET;
                DetailGST.SETRANGE(DetailGST."No.", "Detailed GST Ledger Entry"."No.");

                IF DetailGST.FINDFIRST THEN
                    REPEAT

                        IF ("Document Type" = "Document Type"::Invoice) THEN
                            docuno := "Document No."
                        ELSE
                            docuno := '';

                        IF ("Document Type" = "Document Type"::Invoice) THEN
                            //05-09-2017
                            //SETRANGE("Source Type","Source Type"::Customer);
                            CASE Period OF
                                Period::Jan:
                                    SETRANGE("Posting Date", DMY2DATE(1, 1, Year), DMY2DATE(31, 1, Year));
                                Period::Feb:
                                    SETRANGE("Posting Date", DMY2DATE(1, 2, Year), DMY2DATE(28, 2, Year));
                                Period::March:
                                    SETRANGE("Posting Date", DMY2DATE(1, 3, Year), DMY2DATE(31, 3, Year));
                                Period::Apr:
                                    SETRANGE("Posting Date", DMY2DATE(1, 4, Year), DMY2DATE(30, 4, Year));
                                Period::May:
                                    SETRANGE("Posting Date", DMY2DATE(1, 5, Year), DMY2DATE(31, 5, Year));
                                Period::June:
                                    SETRANGE("Posting Date", DMY2DATE(1, 6, Year), DMY2DATE(30, 6, Year));
                                Period::July:
                                    SETRANGE("Posting Date", DMY2DATE(1, 7, Year), DMY2DATE(31, 7, Year));
                                Period::Aug:
                                    SETRANGE("Posting Date", DMY2DATE(1, 8, Year), DMY2DATE(31, 8, Year));
                                Period::Sept:
                                    SETRANGE("Posting Date", DMY2DATE(1, 9, Year), DMY2DATE(30, 9, Year));
                                Period::Oct:
                                    SETRANGE("Posting Date", DMY2DATE(1, 10, Year), DMY2DATE(31, 10, Year));
                                Period::Nov:
                                    SETRANGE("Posting Date", DMY2DATE(1, 11, Year), DMY2DATE(30, 3, Year));
                                Period::Dec:
                                    SETRANGE("Posting Date", DMY2DATE(1, 12, Year), DMY2DATE(31, 12, Year));
                            END;

                        docudate := "Posting Date"
// ELSE
// docudate := 0D;
UNTIL
DetailGST.NEXT = 0;

                //advance adjusted invoice
                IF ("Application Doc. Type" = "Application Doc. Type"::Invoice) AND ("Document Type" = "Document Type"::Payment) THEN
                    amtadjusted := "Application Doc. No"
                ELSE
                    amtadjusted := '';


                //cess
                scess.RESET;
                scess.SETRANGE(scess."Document No.", "Detailed GST Ledger Entry"."Document No.");
                IF scess.FINDFIRST THEN BEGIN
                    //16225   CessA := scess."CESS Amount";
                END;

                IF (("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Purchase) AND
                    ("Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered)) OR
                  ("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales) THEN BEGIN
                    //for excel total
                    TOTQ += "Detailed GST Ledger Entry".Quantity;
                    TOTBASE += "Detailed GST Ledger Entry"."GST Base Amount";
                    TOTALINV += GetAmttoCustomerPostedLine(Salesinvline."Document No.", Salesinvline."Line No.") / GetAmttoVendorPostedLine(Purchinvline."Document No.", Purchinvline."Line No.");
                    //16225   TOTALINV += "Detailed GST Ledger Entry"."Amount to Customer/Vendor";
                    IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice) THEN BEGIN

                        //TotInv := Camt+Samt+Iamt+Uamt+ABS("Detailed GST Ledger Entry"."GST Base Amount");

                        //TOTALINV +=TotInv;
                        //TOTALADJ +=amtadjusted;
                        TOTCESS += CessA;
                        TOTC += Camt;
                        TOTS += Samt;
                        TOTI += Iamt;
                        TOTU += Uamt;

                    END;
                END;

                IF (("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Purchase) AND
                    ("Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered)) OR
                  ("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales) THEN BEGIN

                    IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Payment) THEN BEGIN

                        //TotInv1 := Camt+Samt+Iamt+Uamt+ABS("Detailed GST Ledger Entry"."GST Base Amount");

                        //TOTALINV1 +=TotInv1;
                        //TOTALADJ +=amtadjusted;
                        TOTCESS1 += CessA;
                        TOTC1 += Camt;
                        TOTS1 += Samt;
                        TOTI1 += Iamt;
                        TOTU1 += Uamt;
                        //TOTBASE1 +=ABS("Detailed GST Ledger Entry"."GST Base Amount");
                    END;
                END;
                IF (("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Purchase) AND
                    ("Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered)) OR
                  ("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales) THEN BEGIN

                    IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo") OR
                       ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Refund) THEN BEGIN

                        //TotInv2 := Camt+Samt+Iamt+Uamt+ABS("Detailed GST Ledger Entry"."GST Base Amount");

                        //TOTALINV2 +=TotInv2;
                        //TOTALADJ +=amtadjusted;
                        TOTCESS2 += CessA;
                        TOTC2 += Camt;
                        TOTS2 += Samt;
                        TOTI2 += Iamt;
                        TOTU2 += Uamt;
                        //TOTBASE2 +=ABS("Detailed GST Ledger Entry"."GST Base Amount");
                    END;
                END;


                IF ExportToExcel THEN BEGIN

                    IF (("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Purchase) AND
                        ("Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered)) OR
                      ("Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales) THEN BEGIN
                        Sno += 1;


                        EnterCell(K, 1, FORMAT(Sno), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                        EnterCell(K, 2, FORMAT(CustomerVendorName), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 3, FORMAT("Detailed GST Ledger Entry"."Document Type"), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 4, FORMAT(CustRegno), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 5, FORMAT(Custname), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 6, FORMAT(docuno), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 7, FORMAT(docudate), FALSE, FALSE, ExcelBuf."Cell Type"::Date);
                        EnterCell(K, 8, FORMAT(itemdesc), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 9, FORMAT(HSNCode), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 10, FORMAT(GLSAC), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 11, FORMAT(-("Detailed GST Ledger Entry".Quantity)), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                        EnterCell(K, 12, FORMAT(itemUom), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 13, FORMAT("Detailed GST Ledger Entry"."GST Jurisdiction Type"), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        //16225   EnterCell(K, 14, FORMAT("Detailed GST Ledger Entry"."Nature of Supply"), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 15, FORMAT("Detailed GST Ledger Entry"."GST Without Payment of Duty"), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        //16225    EnterCell(K, 16, FORMAT("Detailed GST Ledger Entry"."Buyer/Seller State Code"), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        //16225    EnterCell(K, 17, FORMAT("Detailed GST Ledger Entry"."Bill Of Export No."), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        //16225    EnterCell(K, 18, FORMAT("Detailed GST Ledger Entry"."Bill Of Export Date"), FALSE, FALSE, ExcelBuf."Cell Type"::Date);
                        EnterCell(K, 19, FORMAT(DeemedNo), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 20, FORMAT(DeemedDate), FALSE, FALSE, ExcelBuf."Cell Type"::Date);

                        IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo") THEN
                            EnterCell(K, 21, FORMAT(-GetAmttoCustomerPostedLine(Salesinvline."Document No.", Salesinvline."Line No.") / GetAmttoVendorPostedLine(Purchinvline."Document No.", Purchinvline."Line No.")), FALSE, FALSE, ExcelBuf."Cell Type"::Text)
                        ELSE
                            EnterCell(K, 21, FORMAT(GetAmttoCustomerPostedLine(Salesinvline."Document No.", Salesinvline."Line No.") / GetAmttoVendorPostedLine(Purchinvline."Document No.", Purchinvline."Line No.")), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        //16225        EnterCell(K, 21, FORMAT(-("Detailed GST Ledger Entry"."Amount to Customer/Vendor")), FALSE, FALSE, ExcelBuf."Cell Type"::Text)
                        //   
                        //16225        EnterCell(K, 21, FORMAT("Detailed GST Ledger Entry"."Amount to Customer/Vendor"), FALSE, FALSE, ExcelBuf."Cell Type"::Text);

                        EnterCell(K, 22, FORMAT(-("Detailed GST Ledger Entry"."GST Base Amount")), FALSE, FALSE, ExcelBuf."Cell Type"::Number);

                        IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice) THEN BEGIN
                            EnterCell(K, 23, FORMAT(Crate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 24, FORMAT(Camt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 25, FORMAT(Srate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 26, FORMAT(Samt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 27, FORMAT(Urate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 28, FORMAT(Uamt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 29, FORMAT(Irate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 30, FORMAT(Iamt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 31, FORMAT(''), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 32, FORMAT(ABS(CessA)), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                        END;
                        EnterCell(K, 33, FORMAT(No), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                        EnterCell(K, 34, FORMAT(Datee), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 35, FORMAT(''), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 36, FORMAT(''), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 37, FORMAT(invoicee), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 38, FORMAT(invoicedate), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 39, FORMAT(''), FALSE, FALSE, ExcelBuf."Cell Type"::Text);
                        IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo") OR
                            ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Refund) THEN BEGIN
                            EnterCell(K, 40, FORMAT(Crate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 41, FORMAT(Camt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 42, FORMAT(Srate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 43, FORMAT(Samt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 44, FORMAT(Urate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 45, FORMAT(Uamt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 46, FORMAT(Irate), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 47, FORMAT(Iamt), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 48, FORMAT(''), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 49, FORMAT(CessA), FALSE, FALSE, ExcelBuf."Cell Type"::Number);
                        END;
                        EnterCell(K, 50, FORMAT(RecieptNumber), TRUE, FALSE, ExcelBuf."Cell Type"::Text);
                        EnterCell(K, 51, FORMAT(RecieptDate), TRUE, FALSE, ExcelBuf."Cell Type"::Date);
                        EnterCell(K, 52, FORMAT(amtadjusted), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                        IF ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Payment) THEN BEGIN
                            EnterCell(K, 53, FORMAT(Crate), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 54, FORMAT(Camt), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 55, FORMAT(Srate), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 56, FORMAT(Samt), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 57, FORMAT(Urate), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 58, FORMAT(Uamt), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 59, FORMAT(Irate), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 60, FORMAT(Iamt), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 61, FORMAT(' '), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                            EnterCell(K, 62, FORMAT(CessA), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                        END;
                        K += 1;

                    END
                END
                //END;

            end;

            trigger OnPostDataItem()
            begin
                IF ExportToExcel THEN BEGIN

                    EnterCell(K, 11, FORMAT(ABS(TOTQ)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 20, 'Total INVOICE', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
                    EnterCell(K, 21, FORMAT(TOTALINV), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 22, FORMAT(ABS(TOTBASE)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 24, FORMAT(ABS(TOTC)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 26, FORMAT(ABS(TOTS)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 28, FORMAT(ABS(TOTU)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 30, FORMAT(ABS(TOTI)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 31, 'Total Cess', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
                    EnterCell(K, 32, FORMAT(ABS(TOTCESS)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 41, FORMAT(ABS(TOTC2)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 43, FORMAT(ABS(TOTS2)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 45, FORMAT(ABS(TOTU2)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 47, FORMAT(ABS(TOTI2)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 48, 'Total Cess', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
                    EnterCell(K, 49, FORMAT(ABS(TOTCESS2)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 54, FORMAT(ABS(TOTC1)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 56, FORMAT(ABS(TOTS1)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 58, FORMAT(ABS(TOTU1)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 60, FORMAT(ABS(TOTI1)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);
                    EnterCell(K, 61, 'Total Cess', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
                    EnterCell(K, 62, FORMAT(ABS(TOTCESS1)), TRUE, FALSE, ExcelBuf."Cell Type"::Number);


                    K += 1;
                END
            end;

            trigger OnPreDataItem()
            begin
                //16225   GSTReturnsManagement.PostingDateFilter("Detailed GST Ledger Entry", Year, GSTINLocation, "Source Type"::Customer, Period);
                Sno := 0;
                TOTQ := 0;
                TotInv := 0;
                TOTALINV := 0;
                TOTALADJ := 0;
                TOTC := 0;
                TOTS := 0;
                TOTI := 0;
                TOTU := 0;
                TOTCESS := 0;

                TotInv1 := 0;
                TOTALINV1 := 0;
                TOTALADJ1 := 0;
                TOTC1 := 0;
                TOTS1 := 0;
                TOTI1 := 0;
                TOTU1 := 0;
                TOTCESS1 := 0;

                TotInv2 := 0;
                TOTALINV2 := 0;
                TOTALADJ2 := 0;
                TOTC2 := 0;
                TOTS2 := 0;
                TOTI2 := 0;
                TOTU2 := 0;
                TOTCESS2 := 0;
                TOTQP := 0;
                TOTBASEP := 0;
                TOTINVP := 0;
                //04-09-2017 Rajiv
                IF ExportToExcel THEN BEGIN

                    SETCURRENTKEY("Location  Reg. No.", "Source Type");
                    //SETRANGE("Location  Reg. No.",GSTIN);
                    //SETRANGE("Source Type","Source Type"::Customer);
                    CASE Period OF
                        Period::Jan:
                            SETRANGE("Posting Date", DMY2DATE(1, 1, Year), DMY2DATE(31, 1, Year));
                        Period::Feb:
                            SETRANGE("Posting Date", DMY2DATE(1, 2, Year), DMY2DATE(28, 2, Year));
                        Period::March:
                            SETRANGE("Posting Date", DMY2DATE(1, 3, Year), DMY2DATE(31, 3, Year));
                        Period::Apr:
                            SETRANGE("Posting Date", DMY2DATE(1, 4, Year), DMY2DATE(30, 4, Year));
                        Period::May:
                            SETRANGE("Posting Date", DMY2DATE(1, 5, Year), DMY2DATE(31, 5, Year));
                        Period::June:
                            SETRANGE("Posting Date", DMY2DATE(1, 6, Year), DMY2DATE(30, 6, Year));
                        Period::July:
                            SETRANGE("Posting Date", DMY2DATE(1, 7, Year), DMY2DATE(31, 7, Year));
                        Period::Aug:
                            SETRANGE("Posting Date", DMY2DATE(1, 8, Year), DMY2DATE(31, 8, Year));
                        Period::Sept:
                            SETRANGE("Posting Date", DMY2DATE(1, 9, Year), DMY2DATE(30, 9, Year));
                        Period::Oct:
                            SETRANGE("Posting Date", DMY2DATE(1, 10, Year), DMY2DATE(31, 10, Year));
                        Period::Nov:
                            SETRANGE("Posting Date", DMY2DATE(1, 11, Year), DMY2DATE(30, 3, Year));
                        Period::Dec:
                            SETRANGE("Posting Date", DMY2DATE(1, 12, Year), DMY2DATE(31, 12, Year));
                    END;
                    //GetNoSeries;
                    //GetPurchNoSeries;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(GSTINLocation; GSTINLocation)
                    {
                        Caption = 'GSTIN of the location';
                        TableRelation = "GST Registration Nos.".Code;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            Location.SETRANGE("GST Registration No.", GSTINLocation);
                            IF Location.FINDFIRST THEN
                                TaxablePerson := Location.Name
                        end;
                    }
                    field(TaxablePerson; TaxablePerson)
                    {
                        Caption = 'Name of the Taxable Person';
                        TableRelation = Location.Name;
                        ApplicationArea = All;
                    }
                    field(AggregateTurnover; AggregateTurnOver)
                    {
                        Caption = 'Aggregate Turnover of the Taxable person in the previous financial year';
                        ApplicationArea = All;
                    }
                    field(PersonName; PersonName)
                    {
                        Caption = 'Name of the Authorized Person';
                        ApplicationArea = All;
                    }
                    field(Period; Period)
                    {
                        ApplicationArea = All;
                    }
                    field(Place; Place)
                    {
                        Caption = 'Place';
                        ApplicationArea = All;
                    }
                    field(Date; Date)
                    {
                        Caption = 'Date';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            Year := DATE2DMY(Date, 3);
                        end;
                    }
                    field(ExportToExcel; ExportToExcel)
                    {
                        ApplicationArea = All;
                    }
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
        IF ExportToExcel THEN BEGIN
            // ExcelBuf.CreateBookAndOpenExcel(' ', 'Orient Bell', COMPANYNAME, USERID, '');
            //16225 ExcelBuf.GiveUserControl;
        END;
    end;

    trigger OnPreReport()
    begin

        IF ExportToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            CLEAR(ExcelBuf);
            i := 3;
            EnterCell(i, 1, 'Sno', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 2, 'Whether recipient is registered or unregistered', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 3, 'Document Type', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 4, 'GSTIN / UIN of recipient', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 5, 'Name of recipient', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 6, 'Invoice Number', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 7, 'Invoice Date', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 8, 'Description of goods / services provided', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 9, 'HSN code for goods', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 10, 'SAC for services', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 11, 'Quantity of goods sold', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 12, 'Unit Quantity Code / UOM', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 13, 'Whether supply is an inter-state supply or an intra-state supply', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 14, 'Nature of supply', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 15, 'Whether export undertaken without payment of IGST under Bond / LUT or with payment of IGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 16, 'Place of Supply(Name of State / UT)', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 17, 'Serial number of Shipping Bill in case of exports', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 18, 'Date of Shipping Bill in case of exports', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 19, 'Serial number of Bill of Export in case of supplies to SEZs or deemed exports', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 20, 'Date of Bill of Export in case of supplies to SEZs or deemed exports', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 21, 'Total invoice value', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 22, 'Taxable value of goods / services', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 23, 'Rate of CGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 24, 'Amount of CGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 25, 'Rate of SGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 26, 'Amount of SGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 27, 'Rate of UGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 28, 'Amount of UGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 29, 'Rate of IGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 30, 'Amount of IGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 31, 'Rate of Cess', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 32, 'Amount of Cess', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 33, 'Serial number of Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 34, 'Date of Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 35, 'Serial number of revised Shipping Bill', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 36, 'Date of revised Shipping Bill', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 37, 'Corresponding invoice number against which Debit note / Credit note is issued', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 38, 'Corresponding invoice date against which Debit note / Credit note is issued', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 39, 'Differential value for which Debit note / Credit note is issued / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 40, 'Rate of CGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 41, 'Amount of CGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 42, 'Rate of SGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 43, 'Amount of SGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 44, 'Rate of UGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 45, 'Amount of UGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 46, 'Rate of IGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 47, 'Amount of IGST charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 48, 'Rate of Cess charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 49, 'Amount of Cess charged on Debit note / Credit note / Refund Voucher', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 50, 'Receipt Voucher number', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 51, 'Receipt Voucher date', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 52, 'Advance adjusted against Invoice', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 53, 'Rate of CGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 54, 'Amount of CGST adjusted', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 55, 'Rate of SGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 56, 'Amount of SGST adjusted', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 57, 'Rate of UGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 58, 'Amount of UGST adjusted', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 59, 'Rate of IGST', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 60, 'Amount of IGST adjusted', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 61, 'Rate of Cess', TRUE, FALSE, ExcelBuf."Cell Type"::Text);
            EnterCell(i, 62, 'Amount of Cess adjusted', TRUE, FALSE, ExcelBuf."Cell Type"::Text);

            // i+=1;
            K := 4;
            //MinDate := "Detailed GST Ledger Entry".GETRANGEMIN("Posting Date");
            //MaxDate := "Detailed GST Ledger Entry".GETRANGEMAX("Posting Date");

        END
    end;

    var
        Location: Record Location;
        //16225  GSTComponent: Record "16405";
        //16225   GSTReturnsManagement: Codeunit "16404";
        GSTINLocation: Code[15];
        GSTComp: array[5] of Code[10];
        InvoiceNo: array[50] of Code[35];
        HSNSAC: array[50] of Code[10];
        BuyerSellerRegNo: array[50] of Code[15];
        BillofEntryNo: Code[20];
        DocumentNo: array[50] of Code[20];
        PaymentDocNo: array[20] of Code[20];
        Pos: array[20] of Code[10];
        OriginalInvNo: array[20] of Code[20];
        LocStateCode: array[10] of Code[10];
        GSTCompRate: array[50] of Decimal;
        GSTCompAmt: array[50] of Decimal;
        ITCAmt: array[50] of Decimal;
        GSTBaseAmt: array[50] of Decimal;
        BillofEntryValue: Decimal;
        AggregateTurnOver: Integer;
        Year: Integer;
        i: Integer;
        TaxablePerson: Text;
        PersonName: Text;
        GoodsService: array[50] of Text;
        Place: Text;
        Description: array[2] of Text;
        Period: Option Jan,Feb,March,Apr,May,June,July,Aug,Sept,Oct,Nov,Dec;
        GSTGroupType: array[50] of Option Goods,Service;
        DocumentType: array[50] of Option;
        PostingDate: array[50] of Date;
        BillofEntryDate: Date;
        ReportViewErr: Label 'GST Component setup must have value in the Report View field.';
        InterTxt: Label 'Interstate Supplies';
        Date: Date;
        OriginalInvDate: array[20] of Date;
        IntraTxt: Label 'Intrastate Supplies';
        Sno: Integer;
        Cust: Record Customer;
        Custname: Text[50];
        CustRegno: Text[15];
        Vend: Record Vendor;
        Crate: Decimal;
        Camt: Decimal;
        Srate: Decimal;
        Samt: Decimal;
        Irate: Decimal;
        Iamt: Decimal;
        Urate: Decimal;
        Uamt: Decimal;
        Item: Record Item;
        itemdesc: Text[30];
        itemUom: Text[10];
        "G/L": Record "G/L Account";
        GLSAC: Text[50];
        DeemedNo: Text;
        DeemedDate: Date;
        SerialNo: Record "Detailed GST Ledger Entry";
        Purch: Record "Purch. Cr. Memo Hdr.";
        Saless: Record "Sales Cr.Memo Header";
        Acc: Record "Bank Account Ledger Entry";
        No: Text[20];
        Datee: Date;
        DCrate: Decimal;
        Salesheader: Record "Sales Header";
        Purchheader: Record "Purchase Header";
        invoicee: Text;
        invoicedate: Date;
        amtadjusted: Code[20];
        salesamt: Record "Sales Line";
        scess: Record "Sales Invoice Line";
        CessA: Decimal;
        ExcelBuf: Record "Excel Buffer";
        ExportToExcel: Boolean;
        TotInv: Decimal;
        K: Integer;
        TransType: Text[30];
        SrNo: Integer;
        RecieptNumber: Text[30];
        RecieptDate: Date;
        TOTALINV: Decimal;
        TOTALADJ: Decimal;
        TOTBASE: Decimal;
        TOTC: Decimal;
        TOTS: Decimal;
        TOTI: Decimal;
        TOTU: Decimal;
        TOTCESS: Decimal;
        MaxDate: Date;
        MinDate: Date;
        DocNo: Code[20];
        LineNo: Code[20];
        docuno: Text;
        detgst: Record "Detailed GST Ledger Entry";
        docudate: Date;
        Exportno: Code[20];
        ExportD: Date;
        TOTALINV1: Decimal;
        TOTALADJ1: Decimal;
        TOTBASE1: Decimal;
        TOTC1: Decimal;
        TOTS1: Decimal;
        TOTI1: Decimal;
        TOTU1: Decimal;
        TOTCESS1: Decimal;
        TotInv1: Decimal;
        TOTALINV2: Decimal;
        TOTALADJ2: Decimal;
        TOTBASE2: Decimal;
        TOTC2: Decimal;
        TOTS2: Decimal;
        TOTI2: Decimal;
        TOTU2: Decimal;
        TOTCESS2: Decimal;
        TotInv2: Decimal;
        THSNSAC: Record "HSN/SAC";
        HSNCode: Code[8];
        SACCode: Code[8];
        DetailGST: Record "Detailed GST Ledger Entry";
        TOTQ: Decimal;
        TOTQP: Decimal;
        TOTBASEP: Decimal;
        TOTINVP: Decimal;
        Vendname: Text[20];
        VendRegno: Code[20];
        TYPE: Text;
        CustomerVendorName: Text[30];
        Salesinvline: Record "Sales Invoice Line";
        Purchinvline: Record "Purch. Inv. Line";

    local procedure AssignGSTAmt(DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; var GSTBaseAmt: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        DetailedGSTLedgerEntry2: Record "Detailed GST Ledger Entry";
    begin
        /*WITH DetailedGSTLedgerEntry DO BEGIN
          IF "Detailed GST Ledger Entry"."Transaction Type"= "Detailed GST Ledger Entry"."Transaction Type":: Sales THEN BEGIN
        
        
         // SETCURRENTKEY("Document Type","Document No.","Document Line No.","Nature of Supply","GST Jurisdiction Type");
          SETRANGE("Document Type",DetailedGSTLedgerEntry1."Document Type");
          SETRANGE("Document No.",DetailedGSTLedgerEntry1."Document No.");
         // SETRANGE("Nature of Supply",DetailedGSTLedgerEntry1."Nature of Supply");
          SETRANGE("GST Jurisdiction Type",DetailedGSTLedgerEntry1."GST Jurisdiction Type");
          SETRANGE("HSN/SAC Code",DetailedGSTLedgerEntry1."HSN/SAC Code");
          IF FINDSET THEN
            REPEAT
              IF "GST Component Code" = GSTComp1 THEN BEGIN
               Crate := "GST %";
               Camt := -("GST Amount");
              // TOTC +=Camt;
              END;
              IF "GST Component Code" = GSTComp2 THEN BEGIN
               Srate := "GST %";
               Samt := -("GST Amount");
               // TOTS +=Samt;
              END;
              IF "GST Component Code" = GSTComp3 THEN BEGIN
                Irate := "GST %";
                Iamt := -("GST Amount");
              //  TOTI +=Iamt;
        
                    END;
            UNTIL NEXT = 0;
        END
        END;
        */
        DetailedGSTLedgerEntry2.SETRANGE(DetailedGSTLedgerEntry2."Document Type", DetailedGSTLedgerEntry1."Document Type");
        DetailedGSTLedgerEntry2.SETRANGE(DetailedGSTLedgerEntry2."Document No.", DetailedGSTLedgerEntry1."Document No.");
        DetailedGSTLedgerEntry2.SETRANGE(DetailedGSTLedgerEntry2."GST Component Code", DetailedGSTLedgerEntry1."GST Component Code");
        DetailedGSTLedgerEntry2.SETRANGE(DetailedGSTLedgerEntry2."No.", DetailedGSTLedgerEntry1."No.");
        IF DetailedGSTLedgerEntry2.FINDFIRST THEN
            IF DetailedGSTLedgerEntry2."GST Jurisdiction Type" = DetailedGSTLedgerEntry2."GST Jurisdiction Type"::Intrastate THEN
                GSTBaseAmt += DetailedGSTLedgerEntry2."GST Base Amount" / 2
            ELSE
                GSTBaseAmt += DetailedGSTLedgerEntry2."GST Base Amount";


    end;

    local procedure DetailsOfCreditAndDebitWithRevCharge(DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        IF (DetailedGSTLedgerEntry."GST Vendor Type" = DetailedGSTLedgerEntry."GST Vendor Type"::Registered) AND
               //16225  ("Sales Invoice Type" IN ["Sales Invoice Type"::Supplementary, "Sales Invoice Type"::"Debit Note"]) AND
               NOT DetailedGSTLedgerEntry."Reverse Charge"
            THEN BEGIN
            BuyerSellerRegNo[2] := DetailedGSTLedgerEntry."Buyer/Seller Reg. No.";
            DocumentType[1] := DetailedGSTLedgerEntry."Document Type".AsInteger();
            DocumentNo[1] := DetailedGSTLedgerEntry."Document No.";
            PostingDate[2] := DetailedGSTLedgerEntry."Posting Date";
            GSTGroupType[3] := DetailedGSTLedgerEntry."GST Group Type".AsInteger();
            OriginalInvNo[1] := DetailedGSTLedgerEntry."Original Invoice No.";
            //16225   OriginalInvDate[1] := "Original Invoice Date";
            HSNSAC[8] := DetailedGSTLedgerEntry."HSN/SAC Code";
            AssignGSTAmt(
              DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3,
              GSTCompAmt1, GSTCompAmt2, GSTCompAmt3, GSTBaseAmt[4], GSTComp1, GSTComp2, GSTComp3);
        END;
    end;

    local procedure DetailsOfCreditAndDebitWithoutRevCharge(DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        IF (DetailedGSTLedgerEntry."GST Vendor Type" = DetailedGSTLedgerEntry."GST Vendor Type"::Unregistered) AND
               //16225   ("Sales Invoice Type" IN ["Sales Invoice Type"::Supplementary, "Sales Invoice Type"::"Debit Note"]) AND
               DetailedGSTLedgerEntry."Reverse Charge"
            THEN BEGIN
            BuyerSellerRegNo[3] := DetailedGSTLedgerEntry."Buyer/Seller Reg. No.";
            DocumentType[2] := DetailedGSTLedgerEntry."Document Type".AsInteger();
            DocumentNo[2] := DetailedGSTLedgerEntry."Document No.";
            PostingDate[3] := DetailedGSTLedgerEntry."Posting Date";
            GSTGroupType[4] := DetailedGSTLedgerEntry."GST Group Type".AsInteger();
            OriginalInvNo[2] := DetailedGSTLedgerEntry."Original Invoice No.";
            //16225    OriginalInvDate[2] := "Original Invoice Date";
            HSNSAC[9] := DetailedGSTLedgerEntry."HSN/SAC Code";
            AssignGSTAmt(
              DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3,
              GSTCompAmt1, GSTCompAmt2, GSTCompAmt3, GSTBaseAmt[5], GSTComp1, GSTComp2, GSTComp3);
        END;
    end;

    local procedure AdvancePaymentAfterPosting(var DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        DocumentNo[3] := DetailedGSTLedgerEntry."Document No.";
        PostingDate[4] := DetailedGSTLedgerEntry."Posting Date";
        HSNSAC[4] := DetailedGSTLedgerEntry."HSN/SAC Code";
        //16225 LocStateCode[1] := DetailedGSTLedgerEntry."Location State Code";
        AssignGSTAmt(
          DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3,
          GSTCompAmt1, GSTCompAmt2, GSTCompAmt3, GSTBaseAmt[6], GSTComp1, GSTComp2, GSTComp3);

    end;

    local procedure AdvancePaymentBeforePosting(var DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        DocumentNo[4] := DetailedGSTLedgerEntry."Document No.";
        PostingDate[5] := DetailedGSTLedgerEntry."Posting Date";
        PaymentDocNo[1] := DetailedGSTLedgerEntry."Payment Document No.";
        AssignGSTAmt(
          DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3,
          GSTCompAmt1, GSTCompAmt2, GSTCompAmt3, GSTBaseAmt[7], GSTComp1, GSTComp2, GSTComp3);

    end;

    local procedure ClearData()
    begin
        FOR i := 1 TO 25 DO BEGIN
            GSTCompRate[i] := 0;
            GSTCompAmt[i] := 0;
            ITCAmt[i] := 0;
            GSTBaseAmt[i] := 0;
        END;
    end;

    local procedure GetUnRegisteredTaxablePerson(DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        IF (DetailedGSTLedgerEntry."GST Vendor Type" = DetailedGSTLedgerEntry."GST Vendor Type"::Unregistered) AND DetailedGSTLedgerEntry."Reverse Charge" THEN BEGIN
            BuyerSellerRegNo[7] := DetailedGSTLedgerEntry."Buyer/Seller Reg. No.";
            InvoiceNo[7] := DetailedGSTLedgerEntry."Document No.";
            GetGoodsAndService(DetailedGSTLedgerEntry, GoodsService[7]);
            HSNSAC[7] := DetailedGSTLedgerEntry."HSN/SAC Code";
            IF DetailedGSTLedgerEntry."GST Credit" = DetailedGSTLedgerEntry."GST Credit"::Availment THEN
                GSTGroupType[7] := DetailedGSTLedgerEntry."GST Group Type".AsInteger();
            PostingDate[7] := DetailedGSTLedgerEntry."Posting Date";
            // 16225 IF "Buyer/Seller State Code" <> "Shipping Address State Code" THEN
            //16225    Pos[7] := "Shipping Address State Code";
            AssignGSTAmt(
              DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3, GSTCompAmt1, GSTCompAmt2,
              GSTCompAmt3, GSTBaseAmt[8], GSTComp1, GSTComp2, GSTComp3);
        END;
    end;

    local procedure GetGoodsAndService(var DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GoodService: Text)
    var
        Item: Record Item;
        GLAccount: Record "G/L Account";
        FixedAsset: Record "Fixed Asset";
        Resource: Record Resource;
    begin
        IF DetailedGSTLedgerEntry.Type = DetailedGSTLedgerEntry.Type::Item THEN BEGIN
            Item.GET(DetailedGSTLedgerEntry."No.");
            GoodService := Item.Description;
        END;
        IF DetailedGSTLedgerEntry.Type = DetailedGSTLedgerEntry.Type::"G/L Account" THEN BEGIN
            GLAccount.GET(DetailedGSTLedgerEntry."No.");
            GoodService := GLAccount.Name;
        END;
        IF DetailedGSTLedgerEntry.Type = DetailedGSTLedgerEntry.Type::"Fixed Asset" THEN BEGIN
            FixedAsset.GET(DetailedGSTLedgerEntry."No.");
            GoodService := FixedAsset.Description;
        END;
        IF DetailedGSTLedgerEntry.Type = DetailedGSTLedgerEntry.Type::Resource THEN BEGIN
            Resource.GET(DetailedGSTLedgerEntry."No.");
            GoodService := Resource.Name;
        END;
    end;

    local procedure FilterPostingDate(var DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry")
    begin
        //04-09-2017 Rajiv
        //if ExportToExcel then begin
        CASE Period OF
            Period::Jan:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 1, Year), DMY2DATE(31, 1, Year));
            Period::Feb:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 2, Year), DMY2DATE(28, 2, Year));
            Period::March:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 3, Year), DMY2DATE(31, 3, Year));
            Period::Apr:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 4, Year), DMY2DATE(30, 4, Year));
            Period::May:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 5, Year), DMY2DATE(31, 5, Year));
            Period::June:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 6, Year), DMY2DATE(30, 6, Year));
            Period::July:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 7, Year), DMY2DATE(31, 7, Year));
            Period::Aug:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 8, Year), DMY2DATE(31, 8, Year));
            Period::Sept:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 9, Year), DMY2DATE(30, 9, Year));
            Period::Oct:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 10, Year), DMY2DATE(31, 10, Year));
            Period::Nov:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 11, Year), DMY2DATE(30, 3, Year));
            Period::Dec:
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Posting Date", DMY2DATE(1, 12, Year), DMY2DATE(31, 12, Year));
        END;
        // end;
    end;

    local procedure GetGoodsAndCapitalGoods(DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        IF (DetailedGSTLedgerEntry."GST Jurisdiction Type" = DetailedGSTLedgerEntry."GST Jurisdiction Type"::Interstate) AND
               (DetailedGSTLedgerEntry."GST Vendor Type" <> DetailedGSTLedgerEntry."GST Vendor Type"::Import) AND (DetailedGSTLedgerEntry."GST Group Type" = DetailedGSTLedgerEntry."GST Group Type"::Goods)
            THEN BEGIN
            IF PurchaseHeader.GET(DetailedGSTLedgerEntry."Document Type", DetailedGSTLedgerEntry."Document No.") THEN BEGIN
                BillofEntryNo := PurchaseHeader."Bill of Entry No.";
                BillofEntryDate := PurchaseHeader."Bill of Entry Date";
                BillofEntryValue := PurchaseHeader."Bill of Entry Value";
            END;
            HSNSAC[2] := DetailedGSTLedgerEntry."HSN/SAC Code";
            GSTGroupType[2] := DetailedGSTLedgerEntry."GST Group Type".AsInteger();
            AssignGSTAmt(
              DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3, GSTCompAmt1,
              GSTCompAmt2, GSTCompAmt3, GSTBaseAmt[2], GSTComp1, GSTComp2, GSTComp3);
        END;
    end;

    local procedure ServiceReceivedfromSupplier(DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        IF (DetailedGSTLedgerEntry."GST Vendor Type" = DetailedGSTLedgerEntry."GST Vendor Type"::Import) AND
               (DetailedGSTLedgerEntry."GST Group Type" = DetailedGSTLedgerEntry."GST Group Type"::Service)
            THEN BEGIN
            InvoiceNo[2] := DetailedGSTLedgerEntry."External Document No.";
            PostingDate[8] := DetailedGSTLedgerEntry."Posting Date";
            HSNSAC[3] := DetailedGSTLedgerEntry."HSN/SAC Code";
            AssignGSTAmt(
              DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3,
              GSTCompAmt1, GSTCompAmt2, GSTCompAmt3, GSTBaseAmt[3], GSTComp1, GSTComp2, GSTComp3);
        END;
    end;

    local procedure GetRegisteredTaxablePerson(DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry"; var GSTCompRate1: Decimal; var GSTCompRate2: Decimal; var GSTCompRate3: Decimal; var GSTCompAmt1: Decimal; var GSTCompAmt2: Decimal; var GSTCompAmt3: Decimal; GSTComp1: Code[10]; GSTComp2: Code[10]; GSTComp3: Code[10])
    begin
        IF DetailedGSTLedgerEntry."GST Vendor Type" = DetailedGSTLedgerEntry."GST Vendor Type"::Registered THEN BEGIN
            BuyerSellerRegNo[1] := DetailedGSTLedgerEntry."Buyer/Seller Reg. No.";
            InvoiceNo[1] := DetailedGSTLedgerEntry."External Document No.";
            IF Cust.GET("Detailed GST Ledger Entry"."Source No.") THEN BEGIN
                HSNSAC[1] := DetailedGSTLedgerEntry."HSN/SAC Code";
                IF DetailedGSTLedgerEntry."GST Credit" = DetailedGSTLedgerEntry."GST Credit"::Availment THEN
                    GSTGroupType[1] := DetailedGSTLedgerEntry."GST Group Type".AsInteger();
                PostingDate[1] := DetailedGSTLedgerEntry."Posting Date";
                //16225  IF "Buyer/Seller State Code" <> "Shipping Address State Code" THEN
                //16225     Pos[1] := "Shipping Address State Code";
                AssignGSTAmt(
                  DetailedGSTLedgerEntry, GSTCompRate1, GSTCompRate2, GSTCompRate3, GSTCompAmt1, GSTCompAmt2,
                  GSTCompAmt3, GSTBaseAmt[1], GSTComp1, GSTComp2, GSTComp3);
            END;
        END;
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Underline: Boolean; CellType: Option)
    begin

        IF ExportToExcel THEN BEGIN
            ExcelBuf.INIT;
            ExcelBuf.VALIDATE("Row No.", RowNo);
            ExcelBuf.VALIDATE("Column No.", ColumnNo);
            ExcelBuf."Cell Value as Text" := CellValue;
            ExcelBuf.Formula := '';
            ExcelBuf.Bold := Bold;
            ExcelBuf.Underline := Underline;
            ExcelBuf.INSERT;
        END;
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

    procedure GetAmttoVendorPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record 123;
        PstdPurchCrMemoLine: Record 125;
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

        if PstdPurchCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchCrMemoLine.Type <> PstdPurchCrMemoLine.Type::" " then
                LineAmt := PstdPurchCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdPurchInv.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchInv.Type <> PstdPurchInv.Type::" " then
                LineAmt := PstdPurchInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchInv.RecordId);
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
    end;//


}

