report 50363 "New State Cust. Wise Sales Cr."
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\NewStateCustWiseSalesCr.rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING(State, "Sell-to Customer No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date", "No.", "Bill-to Customer No.", "Bill-to City";
            column(SCMH_State; "Sales Cr.Memo Header".State)
            {
            }
            column(SCMH_SellToCustomerNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(Statename; Statename)
            {
            }
            column(SCMH_BillToCity; "Sales Cr.Memo Header"."Bill-to City")
            {
            }
            column(SellToCustomerNo; "Sell-to Customer No." + '  ' + "Sell-to Customer Name")
            {
            }
            column(SCMH_ShiplToCity; "Sales Cr.Memo Header"."Ship-to City")
            {
            }
            column(gst_type; "Sales Cr.Memo Header"."GST Customer Type")
            {
            }
            column(gstnr; gstn)
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Posting Date" = FIELD("Posting Date"),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''),
                                          Quantity = FILTER(<> 0));
                RequestFilterFields = "Unit of Measure Code";
                column(Statecode; Statecode)
                {
                }
                column(ExportNo; Export + ' ' + "Sales Cr.Memo Header"."No.")
                {
                }
                column(PostingDate; FORMAT("Sales Cr.Memo Header"."Posting Date"))
                {
                }
                column(Adress; "Sales Cr.Memo Header"."Sell-to Customer Name" + ' , ' + "Sales Cr.Memo Header"."Sell-to City")
                {
                }
                column(Description; "Sales Cr.Memo Line".Description + ' ' + "Sales Cr.Memo Line"."Description 2")
                {
                }
                column(Quantity; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(UnitOfMeasureCode; "Sales Cr.Memo Line"."Unit of Measure")
                {
                }
                column(SqrMtr; SqrMtr)
                {
                }
                column(UPriceQuantity; "Sales Cr.Memo Line"."Unit Price" * Quantity)
                {
                }
                //16225   column(ExciseAmount; "Sales Cr.Memo Line"."Excise Amount")
                column(ExciseAmount; "Sales Cr.Memo Line"."Amount")
                {
                }
                column(ExAmount; ExAmount)
                {
                }
                column(Disc1; "Sales Cr.Memo Line"."Discount Amt 1")
                {
                }
                column(Disc2; "Sales Cr.Memo Line"."Discount Amt 2")
                {
                }
                column(Disc3; "Sales Cr.Memo Line"."Discount Amt 3")
                {
                }
                column(LineDiscountAmount; "Sales Cr.Memo Line"."Line Discount Amount")
                {
                }
                column(A1; "Sales Cr.Memo Line"."Quantity Discount Amount" - "Sales Cr.Memo Line"."Accrued Discount")
                {
                }
                column(AccruedDiscount; "Sales Cr.Memo Line"."Accrued Discount")
                {
                }
                column(Value; Value)
                {
                }
                column(InvDisc1; InvDisc1)
                {
                }
                column(SalesValue; SalesValue)
                {
                }
                column(A2; VATAmount - tgVATCess)
                {
                }
                column(tgVATCess; tgVATCess)
                {
                }
                //16225  column(TaxAmount; "Tax Amount")
                column(TaxAmount; "Amount")
                {
                }
                column(ET1; ET1)
                {
                }
                column(Insurance1; Insurance1)
                {
                }
                column(NetValue; NetValue)
                {
                }
                column(A3; ('C' + "Sales Cr.Memo Line"."No."))
                {
                }
                column(ItemClassification; Item."Item Classification")
                {
                }
                column(ItemCategoryCode; "Sales Cr.Memo Line"."Item Category Code")
                {
                }
                column(GroupCodeDesc; Item."Group code Desc")
                {
                }
                column(QualityCode; Item."Quality Code")
                {
                }
                column(LocationCode; "Sales Cr.Memo Line"."Location Code")
                {
                }
                column(Pay; FORMAT(SalesInvHeader.Pay))
                {
                }
                column(SellToCustNo; ("Sales Cr.Memo Header"."Sell-to Customer No."))
                {
                }
                column(SellToCustName; "Sales Cr.Memo Header"."Sell-to Customer Name")
                {
                }
                column(SellToCity; "Sales Cr.Memo Header"."Sell-to City")
                {
                }
                column(CustomerType; FORMAT(SalesInvHeader."Customer Type"))
                {
                }
                column(SalesType; FORMAT(SalesInvHeader."Sales Type"))
                {
                }
                column(DealerCode; DealerCode)
                {
                }
                column(OrderNo; SalesInvHeader."Order No.")
                {
                }
                column(OrderDate; FORMAT(SalesInvHeader."Order Date"))
                {
                }
                column(ReleasingDate; FORMAT("Sales Cr.Memo Header"."Releasing Date"))
                {
                }
                //16225   column(MRPPrice; "Sales Cr.Memo Line"."MRP Price")
                column(MRPPrice; "Sales Cr.Memo Line"."Unit Price")
                {
                }
                column(MRPPerSqmtr; MRPPerSqmtr)
                {
                }
                column(D1; "Sales Cr.Memo Line".D1)
                {
                }
                column(D2; "Sales Cr.Memo Line".D2)
                {
                }
                column(D3; "Sales Cr.Memo Line".D3)
                {
                }
                column(D4; D4New)
                {
                }
                column(BillingRate; BillingRate)
                {
                }
                column(BuyerRateSqm; BuyerRateSqmNew)
                {
                }
                column(AppliedToDocNo; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                {
                }
                column(ExternalDocumentNo; "Sales Cr.Memo Header"."External Document No.")
                {
                }
                column(SalespersonDescription; SalesInvHeader."Salesperson Description")
                {
                }
                column(Name; Salesperson.Name)
                {
                }
                column(ShortcutDimension1Code; "Sales Cr.Memo Header"."Shortcut Dimension 1 Code")
                {
                }
                column(AreaCode; AreaCode)
                {
                }
                column(SCMH_SellToCustName; "Sales Cr.Memo Header"."Sell-to Customer Name")
                {
                }
                column(cgst; CAmount1)
                {
                }
                column(sgst; sAmount1)
                {
                }
                column(igst; IAmount1)
                {
                }
                column(ugst; UAmount1)
                {
                }

                trigger OnAfterGetRecord()
                begin


                    CLEAR(BuyerRateSqmNew);
                    CLEAR(D4New);
                    IF SqrMtr <> 0 THEN BEGIN
                        BuyerRateSqmNew := ROUND((("Sales Cr.Memo Line"."Line Discount Amount" / SqrMtr) + (ExAmount - "Sales Cr.Memo Line"."Line Discount Amount") / SqrMtr), 0.01, '=');
                        D4New := ROUND(("Sales Cr.Memo Line"."Line Discount Amount" / SqrMtr), 0.01, '=');
                    END;
                    //Vipul Tri1.0
                    // TRI G.D 06.05.08
                    Cust.GET("Sales Cr.Memo Line"."Sell-to Customer No.");
                    IF Location.GET("Location Code") THEN
                        IF Location."State Code" = Cust."State Code" THEN;
                    //16225  VATAmount := "Sales Cr.Memo Line"."Tax Amount";
                    //16225 Table N/F start
                    /*   Taxamount := ROUND("Tax Amount", 0.01, '=');
                       PostedStrOrderLineDetails.RESET;
                       PostedStrOrderLineDetails.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");//Rahul 060706
                       PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                       PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::"Credit Memo");
                       PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Line"."Document No.");
                       PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");
                       //TRI SC Open
                       IF PostedStrOrderLineDetails.FIND('-') THEN
                           REPEAT
                               CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                   PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                       BEGIN
                                           CASE PostedStrOrderLineDetails."Charge Type" OF
                                               PostedStrOrderLineDetails."Charge Type"::Insurance:
                                                   Insurance1 := Insurance1 + PostedStrOrderLineDetails.Amount;
                                           END;
                                           // IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                           //    InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount);
                                           IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                               ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                                           // TRI SC
                                       END;
                               END;
                           UNTIL PostedStrOrderLineDetails.NEXT = 0;

                       IF "Sales Cr.Memo Line"."Tax %" <> 0 THEN BEGIN
                           TaxAreaLine.RESET;
                           TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', "Tax Area Code");
                           IF TaxAreaLine.FIND('-') THEN
                               REPEAT
                                   IF TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code") THEN BEGIN
                                       IF TaxJurisdiction."Additional Tax" THEN BEGIN
                                           TaxDetails.RESET;
                                           TaxDetails.SETCURRENTKEY("Tax Jurisdiction Code", "Tax Group Code", "Form Code", "Effective Date");//Rahul 060706
                                           TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                                           TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', "Tax Group Code");
                                           TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Cr.Memo Header"."Form Code");
                                           TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Cr.Memo Header"."Posting Date");
                                           IF TaxDetails.FIND('+') THEN;
                                           tgVATCess := ("Sales Cr.Memo Line"."Tax Base Amount" * TaxDetails."Tax Below Maximum") / 100;
                                       END;
                                   END;
                               UNTIL TaxAreaLine.NEXT = 0;
                       END;
                       IF VATAmount = 0 THEN
                           tgVATCess := 0;

                       PostedStrOrderLineDetails.RESET;
                       PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                       PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::"Credit Memo");
                       PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Line"."Document No.");
                       PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");

                       IF PostedStrOrderLineDetails.FIND('-') THEN
                           REPEAT
                               CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                   PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                       BEGIN
                                           IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                               InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount);
                                       END;
                               END;

                           UNTIL PostedStrOrderLineDetails.NEXT = 0;*///16225 Table N/F End
                                                                      // TRI SC use VATAmount


                    //TRI SC
                    //16225  ExAmount := ROUND(("Sales Cr.Memo Line"."Unit Price" * "Sales Cr.Memo Line".Quantity) +
                    //16225  "Sales Cr.Memo Line"."Excise Amount", 0.01, '=');
                    ExAmount := ROUND("Sales Cr.Memo Line"."Unit Price" * "Sales Cr.Memo Line".Quantity);
                    Value := ROUND(ExAmount - "Sales Cr.Memo Line"."Line Discount Amount"
                                        - "Sales Cr.Memo Line"."Quantity Discount Amount", 0.01, '=');
                    SalesValue := Value - InvDisc1;
                    /*
                    ExAmount := Amount;
                    Value := ExAmount - InvDisc1;
                    SalesValue := Value + "Excise Amount";
                    */
                    //16225   NetValue := ROUND(SalesValue + "Sales Cr.Memo Line"."CESS Amount" + Taxamount + Insurance1 + ET1, 0.01, '=');
                    // Temp Coment
                    SqrMtr := ROUND(Item.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                    Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                    IF Sqmt <> 0 THEN;
                    //16225   MRPPerSqmtr := ROUND(("MRP Price" * Quantity / Sqmt), 0.01, '=');
                    IF SqrMtr <> 0 THEN
                        BillingRate := ROUND(Value / SqrMtr, 0.01, '=');
                    //TRI SC 050510
                    /*TRI LM 060207
                    //TotalValue := SalesValue + Taxamount + Insurance1;
                    //NetValue := ROUND(TotalValue,1,'=');
                    Roundoff := NetValue - TotalValue;
                    TRI LM 051207*/
                    /*
                    IF "Sales Cr.Memo Header"."Export Document" = "Sales Cr.Memo Header"."Export Document"::"1" THEN
                       Export := '*'
                    ELSE
                       Export := '';
                     *///TRISC

                    /*
                    IF "Tax Amount"  = 0 THEN
                     Taxamount := "VAT Amount"
                    ELSE
                    */
                    //MSSS
                    DealerCode := '';
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", "Document No.");
                    IF SalesInvHeader.FIND('-') THEN BEGIN
                        SalespersonPurchaser.RESET;
                        IF SalespersonPurchaser.GET(SalesInvHeader."Dealer Code") THEN
                            DealerCode := SalespersonPurchaser."Customer No.";
                    END;



                    GrandTaxAmount := GrandTaxAmount + Taxamount;

                    //TRISC
                    TotalBasicAmt := "Sales Cr.Memo Line"."Unit Price" * "Sales Cr.Memo Line".Quantity;
                    //TRI SC Open
                    // TRI SC


                    IF Cust.GET("Sell-to Customer No.") THEN
                        gstn := Cust."GST Registration No.";


                    CAmount := 0;
                    sAmount := 0;
                    IAmount := 0;
                    UAmount := 0;
                    CAmount1 := 0;
                    sAmount1 := 0;
                    IAmount1 := 0;
                    UAmount1 := 0;


                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                //CRate := DetailedGSTLedgerEntry."GST %";
                                CAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                //SRate := DetailedGSTLedgerEntry."GST %";
                                sAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                sAmount1 += sAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                //IRate := DetailedGSTLedgerEntry."GST %";
                                IAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                IAmount1 += IAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                //URate := DetailedGSTLedgerEntry."GST %";
                                UAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                UAmount1 += UAmount;
                            END;

                        UNTIL
DetailedGSTLedgerEntry.NEXT = 0;

                end;

                trigger OnPreDataItem()
                begin

                    //Vipul
                    CurrReport.CREATETOTALS(SqrMtr, ExAmount, ET1, Value, SalesValue, Insurance1, TotalValue, NetValue, InvDisc1, VATAmount);
                    CurrReport.CREATETOTALS("Sales Cr.Memo Line".Quantity, "Sales Cr.Memo Line"."Line Discount Amount",
                                             Taxamount, tgVATCess, Quantity, "Unit Price");//16225 "Sales Cr.Memo Line"."Excise Amount",
                    GLSetup.GET;
                    //Vipul
                    Value := 0;
                    NetValue := 0;
                    Insurance1 := 0;
                    VATAmount := 0;
                    tgVATCess := 0;
                    //MS-AN
                    SqrMtr := 0;
                    //MS-AN
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //MSAK.BEGIN 050515
                PchCode := '';
                GPchCode := '';
                PriPchCode := '';
                IF Customer2.GET("Sales Cr.Memo Header"."Sell-to Customer No.") THEN BEGIN
                    PchCode := Customer2."PCH Code";
                    GPchCode := Customer2."Govt. SP Resp.";
                    PriPchCode := Customer2."Private SP Resp.";
                    AreaCode := Customer2."Area Code";
                END;
                //MSAK.END 050515

                //********************

                CurrReport.SHOWOUTPUT(NOT PrintToExcel);
                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";

                //*********************

                IF StateRec.GET(State) THEN
                    Statename := StateRec.Description;

                //***********

                IF StateRec.GET(State) THEN
                    Statename := StateRec.Description;
                Statecode := StateRec.Code;


                IF SqrMtr <> 0 THEN BEGIN
                    BuyerRateSqm := ROUND((("Sales Cr.Memo Line"."Line Discount Amount" / SqrMtr) +
                    (ExAmount - "Sales Cr.Memo Line"."Line Discount Amount") / SqrMtr), 0.01, '=');
                END;
                //****************
                TotalBasicAmt := 0;

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE(SalesInvLine."Document No.", "No.");
                IF SalesInvLine.FIND('-') THEN
                    REPEAT
                        //TotalBasicAmt:=TotalBasicAmt + (SalesInvLine."Unit Price"*SalesInvLine."Quantity in Cartons");
                        TotalBasicAmt += (SalesInvLine."Unit Price" * SalesInvLine."Quantity in Cartons");
                    UNTIL SalesInvLine.NEXT = 0;

                IF StateRec.GET(State) THEN BEGIN
                    Statename := StateRec.Description;
                    Statecode := StateRec.Code;
                END;
            end;

            trigger OnPreDataItem()
            begin

                //vipul
                CurrReport.CREATETOTALS(SqrMtr, ExAmount, Value, SalesValue, Insurance1, TotalValue, NetValue, ET1, VATAmount);
                CurrReport.CREATETOTALS("Sales Cr.Memo Line".Quantity, "Sales Cr.Memo Line"."Line Discount Amount",
                                         tgVATCess);//16225 "Sales Cr.Memo Line"."Excise Amount", "Sales Cr.Memo Line"."Tax Amount",

                //vipul
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
        //RepAuditMgt.CreateAudit(50363)
    end;

    trigger OnPreReport()
    begin

        IF STRPOS(FORMAT("Sales Cr.Memo Header".GETFILTER("Sales Cr.Memo Header"."Posting Date")), '.') <> 1 THEN
            DateFrom := FORMAT("Sales Cr.Memo Header".GETRANGEMIN("Sales Cr.Memo Header"."Posting Date"));

        IF STRPOS(FORMAT("Sales Cr.Memo Header".GETFILTER("Sales Cr.Memo Header"."Posting Date")), '.')
          <> STRLEN(FORMAT("Sales Cr.Memo Header".GETFILTER("Sales Cr.Memo Header"."Posting Date"))) - 1 THEN
            DateTo := FORMAT("Sales Cr.Memo Header".GETRANGEMAX("Sales Cr.Memo Header"."Posting Date"));
    end;

    var
        //16225   PostedStrOrderLineDetails: Record "13798";
        Insurance1: Decimal;
        ExAmount: Decimal;
        Value: Decimal;
        SalesValue: Decimal;
        TotalValue: Decimal;
        NetValue: Decimal;
        Roundoff: Decimal;
        SqrMtr: Decimal;
        DateFrom: Text[30];
        DateTo: Text[30];
        Item: Record Item;
        Export: Text[30];
        StateRec: Record State;
        Statename: Text[30];
        Detailed: Boolean;
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        GLSetup: Record "General Ledger Setup";
        InvDisc1: Decimal;
        "---": Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Taxamount: Decimal;
        GrandTaxAmount: Decimal;
        tgVATCess: Decimal;
        TgItemGrp: Record "Item Group";
        Salesperson: Record "Salesperson/Purchaser";
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        TaxDetails: Record "Tax Detail";
        Freight: Decimal;
        Sqmt: Decimal;
        MRPPerSqmtr: Decimal;
        BuyerRateSqm: Decimal;
        //16225 StructureLineDetails: Record "13798";
        TotalBasicAmt: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        BillingRate: Decimal;
        Statecode: Code[10];
        ET1: Decimal;
        CustWiseSalesValue: Decimal;
        StateWiseSalesvalue: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        Location: Record Location;
        VATAmount: Decimal;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesInvHeader: Record "Sales Invoice Header";
        DealerCode: Code[30];
        CompanyName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Customer2: Record Customer;
        PchCode: Code[20];
        GPchCode: Code[20];
        PriPchCode: Code[20];
        AreaCode: Code[20];
        Text001: Label 'State Cust. Wise Sales Journal';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        BuyerRateSqmNew: Decimal;
        D4New: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CAmount: Decimal;
        sAmount: Decimal;
        IAmount: Decimal;
        UAmount: Decimal;
        CAmount1: Decimal;
        sAmount1: Decimal;
        IAmount1: Decimal;
        UAmount1: Decimal;
        gstn: Code[15];
        gsttyp: Option;
}

