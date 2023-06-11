
report 50156 "Sales Debit Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesDebitNote.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(INV_NO; CustLedEntry."Document No.")
            {
            }
            column(INV_Date; CustLedEntry."Posting Date")
            {
            }
            column(LOC_GST_No; Location."GST Registration No.")
            {
            }
            column(Cust_GST_No; Customer."GST Registration No.")
            {
            }
            column(Location_Name; Location.Name)
            {
            }
            column(Location_add1; Location.Address)
            {
            }
            column(Location_add2; Location."Address 2")
            {
            }
            column(Location_city; Location.City)
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(Comp_Name; "Company Information".Name)
            {
            }
            column(TextAddress1; TextAddress1)
            {
            }
            column(TextAddress2; TextAddress2)
            {
            }
            column(TextCity; TextCity)
            {
            }
            column(TextPhone; TextPhone)
            {
            }
            column(TextCIN; TextCIN)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(SalesInvoiceHeader_No; "Sales Invoice Header"."No.")
            {
            }
            column(SalesInvoiceHeader_ExternalDocumentNo; "Sales Invoice Header"."External Document No.")
            {
            }
            column(SalesInvoiceHeader_SelltoCustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(SalesInvoiceHeader_SelltoCustomerName1; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(SalesInvoiceHeader_SelltoCustomerName2; "Sales Invoice Header"."Sell-to Customer Name 2")
            {
            }
            column(SalesInvoiceHeader_SelltoAddress1; "Sales Invoice Header"."Sell-to Address")
            {
            }
            column(SalesInvoiceHeader_SelltoAddress2; "Sales Invoice Header"."Sell-to Address 2")
            {
            }
            column(SalesInvoiceHeader_SelltoCity; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(SalesInvoiceHeader_StateName; "Sales Invoice Header"."State name")
            {
            }
            column(Posting_Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(NetAmt; NetAmt)
            {
            }
            /*  column(RndOff; RndOff)
             {
             }//RB */

            column(orderdate; FORMAT("Sales Invoice Header"."Order Date"))
            {
            }
            column(orderno; "Sales Invoice Header"."Order No.")
            {
            }

            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(SalesInvoiceLine_Description; "Sales Invoice Line".Description)
                {
                }
                column(SalesInvoiceLine_Description2; "Sales Invoice Line"."Description 2")
                {
                }
                column(SalesInvoiceLine_Amount; "Sales Invoice Line".Amount)
                {
                }
                column(SalesInvoiceLine_TaxAmount; 0) // 16630 replace "Tax Amount"
                {
                }
                column(InvDisc; "Sales Invoice Header"."Discount Amount")
                {
                }
                column(InsuranceAmt; InsuranceAmt)
                {
                }
                column(Amt; Amt)
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
                column(TotalGSTAmt; 0)
                {
                }
                column(GSTTotal; GSTTotal)
                {
                }
                column(TotalGSTAmount; TotalGSTAmount)
                {
                }
                column(TaxChargeType; 0)// 16630 "Posted Str Order Line Details"."Tax/Charge Type"
                {
                }
                column(TaxChargeGroup; 0)// 16630 "Posted Str Order Line Details"."Tax/Charge Group"
                {
                }
                column(NoText1; NoText[1])
                {
                }
                column(NoText2; NoText[2])
                {
                }
                column(RoundOff; RoundOff)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    SIL.Reset();
                    SIL.SetRange("Document No.", "Document No.");
                    if SIL.FindSet() then
                        repeat
                            TotalLineAmt += SIL."Line Amount";
                            if SIL."No." = '51157000' then
                                RoundOff := SIL."Line Amount";
                        until SIL.Next() = 0;

                    TotalGSTAmt := TotalGSTAmtLine("Document No.");
                    NetAmtInWord := TotalLineAmt + TotalGSTAmt - "Sales Invoice Header"."Discount Amount";

                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(NoText, Round(NetAmtInWord, 1.0), "Sales Invoice Header"."Currency Code");//RB

                    DiscAmt := Amount;
                    //tds:=tds+"Sales Invoice Header"."Total TDS Including eCESS";
                    CRate := 0;
                    SRate := 0;
                    IRate := 0;
                    CAmount := 0;
                    SAmount := 0;
                    IAmount := 0;


                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CRate := DetailedGSTLedgerEntry."GST %";
                                CAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                //CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SRate := DetailedGSTLedgerEntry."GST %";
                                SAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                //SAmount1 += SAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IRate := DetailedGSTLedgerEntry."GST %";
                                IAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                //IAmount1 += IAmount;
                            END;

                        /*  IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                             URate := DetailedGSTLedgerEntry."GST %";
                             UAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                             IAmount1 += IAmount;
                         END; */

                        UNTIL
DetailedGSTLedgerEntry.NEXT = 0;
                end;
            }
            /*dataitem(DataItem1000000003; 13798)
            {
                DataItemLink = "Invoice No." = FIELD("No.");
                DataItemTableView = SORTING("Tax/Charge Type", "Tax/Charge Code")
                                    ORDER(Ascending)
                                    WHERE(Type = CONST(Sale),
                                          "Document Type" = CONST("Credit Memo"));
                column(TaxChargeType; "Posted Str Order Line Details"."Tax/Charge Type")
                {
                }
                column(TaxChargeGroup; "Posted Str Order Line Details"."Tax/Charge Group")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Tax/Charge Group") THEN BEGIN
                        GenLegSetup.GET;
                        IF ("Tax/Charge Type" = "Tax/Charge Type"::Charges) AND ("Charge Type" = "Charge Type"::" ") THEN
                            IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN BEGIN
                                InvDisc := Amount;
                            END;
                    END;


                    IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Charge Type") THEN BEGIN
                        IF ("Tax/Charge Type" = "Tax/Charge Type"::Charges) AND ("Charge Type" = "Charge Type"::Insurance) THEN BEGIN
                            InsuranceAmt := Amount;
                        END;
                    END;


                    IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Tax/Charge Type") THEN BEGIN
                        IF "Tax/Charge Type" = "Tax/Charge Type"::Charges THEN
                            Amt := Amount - InvDisc - InsuranceAmt
                        ELSE
                            Amt := Amount;
                        TotalAmt := TotalAmt + Amt;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    TotalAmt := 0;
                end;
            }*/

            trigger OnAfterGetRecord()
            begin
                IGSTAmt := 0;
                IGSTper := 0;
                SGSTAmt := 0;
                SGSTper := 0;
                CGSTAmt := 0;
                CGSTper := 0;
                GSTBaseAmt := 0;
                TotalAmount := 0;
                LineAmt := 0;




                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    REPEAT
                        IGSTAmt += abs(RecDGLE."GST Amount");
                    UNTIL RecDGLE.NEXT = 0;
                END;


                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'SGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    REPEAT
                        SGSTAmt += abs(RecDGLE."GST Amount");
                    UNTIL RecDGLE.NEXT = 0;
                END;


                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    repeat
                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                    until RecDGLE.next = 0;
                END;
                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    repeat
                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                    until RecDGLE.Next() = 0;

                END;
                TotalAmount += LineAmt + IGSTAmt + CGSTAmt + SGSTAmt;
                /* RndOff := NetAmt - TotalAmount;
                RoundAmt := ROUND(NetAmt);
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoText, TotalAmount, ''); //RB */

                IF Location.GET("Location Code") THEN;
                IF Customer.GET("Sell-to Customer No.") THEN;
                CustLedEntry.SETRANGE(CustLedEntry."Document No.", "Sales Invoice Header"."Applies-to Doc. No.");
                IF CustLedEntry.FINDFIRST THEN;


                CALCFIELDS("State name");
                //"Sales Invoice Header".CALCFIELDS();
                //16630 NetAmt := DiscAmt + InvDisc + InsuranceAmt + TotalAmt + "Sales Invoice Line"."Tax Amount";

            end;

            trigger OnPreDataItem()
            begin
                IF COMPANYNAME = 'Orient Bell Limited' THEN
                    CompanyName1 := 'Orient Bell Limited';

                "Company Information".GET;
            end;
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
        //RepAuditMgt.CreateAudit(50156)
    end;

    var
        AmtToCust: Decimal;
        RoundOff: Decimal;
        TotalLineAmt: Decimal;
        SIL: Record "Sales Invoice Line";
        CustLedEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        Location: Record Location;
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
        RndOff: Decimal;
        CheckReport: Report "Check Report";
        NoText: array[2] of Text[80];
        GenLegSetup: Record "General Ledger Setup";
        // 16630  PostedStrOrderLineDetails: Record 13798;
        ChargeAmt: Decimal;
        SalesTaxAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        InsuranceAmt: Decimal;
        ExciseAmt: Decimal;
        InvDisc: Decimal;
        DiscAmt: Decimal;
        NetAmt: Decimal;
        Amt: Decimal;
        tds: Decimal;
        CompanyName1: Text[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        TextAddress1: Label 'Regd. office:  8 Ind Area Sikandrabad';
        TextAddress2: Label ' Distt. Bulandshahr (UP)';
        TextCity: Label '  SIKANDRABAD.';
        TextPhone: Label '  Phone: 47119100  Fax: 28521273';
        TextCIN: Label 'PAN No. AAACO0305P CIN No. L14101UP1977PLC021546';
        RoundAmt: Decimal;
        "Company Information": Record "Company Information";
        RecDGLE: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        LineAmt: Decimal;
        TCSAmount: Decimal;
        NetAmtInWord: Decimal;



    procedure TotalGSTAmtLine(DocNo: Code[20]): Decimal
    var
        PstdSalesInv: Record 113;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(GSTBaseAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        // DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            IGSTAmt += abs(DetGstLedEntry."GST Amount");
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            SGSTAmt += abs(DetGstLedEntry."GST Amount");
        end;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocNo);
        //DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            DetGstLedEntry.CalcSums("GST Amount");
            CGSTAmt += abs(DetGstLedEntry."GST Amount");
        end;


        Clear(TotalAmt);
        TotalAmt := IGSTAmt + SGSTAmt + CGSTAmt;
        EXIT(ABS(TotalAmt));
    end;

}

