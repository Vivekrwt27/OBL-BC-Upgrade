report 50015 "Sales Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesJournal.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "No.", "Sell-to Customer No.", "Bill-to City",/* "Form Code",*/ "Location Code";
            column(Name_CompInfo; CompInfo.Name)
            {
            }
            column(TINNo; TINNo)
            {
            }
            column(CompName2; CompInfo."Name 2")
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(FrieghtCharge; FrieghtCharge)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(Filters; GETFILTERS)
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(uom; uom)
            {
            }
            column(Code_State; StateCodeNum)
            {
            }
            column(DealerCode_SalesInvoiceHeader; "Sales Invoice Header"."Dealer Code")
            {
            }
            column(SqrMtr; SqrMtr)
            {
            }
            column(ExAmount; ExAmount)
            {
            }
            column(FormCode_SalesInvoiceHeader; '') // 16630 blank "Sales Invoice Header".form code
            {
            }
            column(DiscountCharges_SalesInvoiceHeader; "Sales Invoice Header"."Discount Charges %")
            {
            }
            column(Trad_discount; "Sales Invoice Header"."CD Availed from Utilisation")
            {
            }
            column(gst_type; "Sales Invoice Header"."GST Customer Type")
            {
            }
            column(gstnr; gstn)
            {
            }
            column(TotalQty; TotalQty)
            {
            }
            column(Tax_base; "Sales Invoice Header"."Tax Base")
            {
            }
            column(DocNo; "No.")
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("No." = FILTER(<> ''),
                                          Type = FILTER('Item|Fixed Asset|Resource'),
                                          Quantity = FILTER(<> 0));
                // 16630   Supplementary = FILTER(false));
                RequestFilterFields = "Unit of Measure Code", /*"Tax %", Field16352,*/ Type, "Item Category Code", "Quantity Discount Amount", "Accrued Discount";
                column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }
                column(AccruedDiscount_SalesInvoiceLine; "Sales Invoice Line"."Accrued Discount")
                {
                }
                column(QuantityDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Quantity Discount Amount")
                {
                }
                column(Value; Value)
                {
                }
                column(ExciseAmount_SalesInvoiceLine; 0) //16630 blank "Sales Invoice Line".Excise Amount
                {
                }
                column(SalesValue; SalesValue)
                {
                }
                column(TotalValue; TotalValue)
                {
                }
                column(NetValue; NetValue)
                {
                }
                column(PerJud_2; PerJud[2])
                {
                }
                column(ET1; ET1)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(tgVATCess; tgVATCess)
                {
                }
                column(TaxAmount_SalesInvoiceLine; 0) // 16630 blank "Sales Invoice Line". Tax Amount
                {
                }
                column(Insurance1; Insurance1)
                {
                }
                column(Export; Export)
                {
                }
                column(StateCode; StateCodeNum)
                {
                }
                column(Roundoff; Roundoff)
                {
                }
                column(ADD1; "Sales Invoice Line"."Discount Amt 1")
                {
                }
                column(ADD2; "Sales Invoice Line"."Discount Amt 2")
                {
                }
                column(ADD3; "Sales Invoice Line"."Discount Amt 3")
                {
                }
                column(ADD4; "Sales Invoice Line"."Discount Amt 4")
                {
                }
                column(VATAmountMinustgVATCess; VATAmount - tgVATCess)
                {
                }
                column(TotalValueMinusInvDisc; TotalValue - ABS(InvDisc))
                {
                }
                column(NetValueMinusInvDisc; NetValue - ABS(InvDisc))
                {
                }
                column(CustTINNo; 0) // 16630 blank Cust.T.I.N. No.
                {
                }
                column(ExceptionType; "Sales Invoice Header"."CR Exception Type")
                {
                }
                column(CRApprovedQty; "Sales Invoice Header"."CR Approved By")
                {
                }
                column(SelltoCustNo; 'C' + "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(ShiptoAdd; "Sales Invoice Header"."Ship-to Address")
                {
                }
                column(ShiptoAdd2; "Sales Invoice Header"."Ship-to Address 2")
                {
                }
                column(ShiptoCity; "Sales Invoice Header"."Ship-to City")
                {
                }
                column(GRNo; "Sales Invoice Header"."GR No.")
                {
                }
                column(TruckNo; "Sales Invoice Header"."Truck No.")
                {
                }
                column(TransNAME; "Sales Invoice Header"."Transporter's Name")
                {
                }
                column(TaxBaseAmt; 0) // 16630 blank "Sales Invoice Line".Tax Base Amount
                {
                }
                column(Dim1; Cust."Global Dimension 1 Code")
                {
                }
                column(SIHSalesType; "Sales Invoice Header"."Sales Type")
                {
                }
                column(PchCode; PchCode)
                {
                }
                column(GPchCode; GPchCode)
                {
                }
                column(PriPchCode; PriPchCode)
                {
                }
                column(InvDisNew; InvDisNew)
                {
                }
                column(InvDisc; InvDisc)
                {
                }
                column(TaxPer_SalesInvoiceLine; 0) // 16630 blank  "Sales Invoice Line".Tax %
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
                column(OthClm; OthClm)
                {
                }
                column(FrightChargeAmt; FrightChargeAmt)
                {
                }
                column(InsuranceClm; InsuranceClm)
                {
                }
                column(TotalCDAmt; TotalCDAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(ExAmount);
                    SqrMtr := 0;
                    tgVATCess := 0; // TRI G.D 06.05.08
                    SqrMtr := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);

                    TaxBaseAmt := 0;
                    Insurance1 := 0;
                    //InvDisc := 0;
                    ET1 := 0;
                    GenLegSetup.GET;


                    /* 16630     PostedStrOrderLineDetails.RESET;
                         PostedStrOrderLineDetails.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");//Rahul 060706
                         PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                         PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
                         PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                         PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
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
                                             //IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN //Kulbhushan
                                             // IF PostedStrOrderLineDetails."Tax/Charge Group" ='DISCOUNT' THEN
                                             //InvDisc := InvDisc + ABS(PostedStrOrderLineDetails.Amount);
                                             IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                                 ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                                             // TRI SC
                                         END;
                                 END;
                             UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ // 16630


                    /*
                    //rohit added for VAT
                    PostedStrOrderLineDetails.RESET;
                    PostedStrOrderLineDetails.SETCURRENTKEY(Type,"Invoice No.","Item No.","Line No.","Tax/Charge Type");//Rahul 060706
                    PostedStrOrderLineDetails.SETRANGE(Type,PostedStrOrderLineDetails.Type::Sale);
                    PostedStrOrderLineDetails.SETRANGE("Document Type",PostedStrOrderLineDetails."Document Type"::Invoice);
                    PostedStrOrderLineDetails.SETRANGE("Invoice No.","Sales Invoice Line"."Document No.");
                    PostedStrOrderLineDetails.SETRANGE("Line No.","Sales Invoice Line"."Line No.");
                    //PostedStrOrderLineDetails.SETRANGE(PostedStrOrderLineDetails."Tax/Charge Type",PostedStrOrderLineDetails."Tax/Charge Type"::
                    //+"Wrong Express");
                    IF PostedStrOrderLineDetails.FIND('-') THEN
                    REPEAT
                      VATAmount:=VATAmount+ PostedStrOrderLineDetails.Amount;
                    UNTIL PostedStrOrderLineDetails.NEXT = 0
                    ELSE
                    VATAmount := 0;
                    */
                    //TRI DG Add Start
                    /* 16630   VATAmount := 0;
                        Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                        IF Location.GET("Location Code") THEN BEGIN
                            IF Location."State Code" = Cust."State Code" THEN
                                VATAmount := "Sales Invoice Line"."Tax Amount";
                            TINNo := Location."T.I.N. No.";
                        END;*/ // 16630
                               //TRI DG Add Stop
                               /*
                               IF "Free Supply" = FALSE THEN
                                BEGIN
                                ExAmount:= ROUND(("Sales Invoice Line"."Unit Price"*"Sales Invoice Line".Quantity) +
                                 "Sales Invoice Line"."Excise Amount",0.01,'=');
                                Value:= ROUND(ExAmount - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                               //MSKS
                               IF InvDisc1 >0 THEN
                                SalesValue:= Value - ABS(InvDisc1)
                               ELSE
                                SalesValue:= Value - (InvDisc1);
                               // SalesValue:= Value - abs(InvDisc);
                               //MSKS

                                END ELSE
                                 BEGIN

                                 ExAmount:= Amount;
                                  //Value:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                                  SalesValue:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=') - abs(InvDisc);
                                 END;
                                */
                               /* IF "Free Supply" = FALSE THEN BEGIN
                                    IF Amount <> 1 THEN
                                        ExAmount := Amount
                                    ELSE
                                        IF "Free Supply" = TRUE THEN
                                            IF Amount <> 0 THEN
                                                ExAmount := Amount

                                            ELSE
                                                IF "Sales Invoice Line"."Line Discount %" <> 100 THEN
                                                    ExAmount := ROUND(("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity) +
                                                     "Sales Invoice Line".Amount, 0.01, '='); // 16630 Excise Amount replace in amount
                                    //MSKS
                                    // SalesValue:= Value - abs(InvDisc);
                                    //MSKS

                                    //  Value := ExAmount - ABS(InvDisc);

                                    SalesValue := Value + Amount;
                                END ELSE BEGIN
                                    ExAmount := Amount;
                                    //Value:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                                    SalesValue := Value + Amount;
                                END;
                                InvDisc := 0;
                                 PostedStrOrderLDetails.RESET;
                                 PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
                                 PostedStrOrderLDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                                 PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
                                 IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                                     REPEAT
                                         InvDisc += PostedStrOrderLDetails.Amount;
                                     UNTIL PostedStrOrderLDetails.NEXT = 0;
                                 END;*/ // 16630

                    CLEAR(InvDisNew);
                    CLEAR(Roundoff);
                    IF SILDocNoNew <> "Sales Invoice Line"."Document No." THEN BEGIN
                        InvDisNew := InvDisc;
                        RecSalesInvLine.RESET;
                        RecSalesInvLine.SETRANGE("Document No.", "Document No.");
                        RecSalesInvLine.SETRANGE(RecSalesInvLine."System-Created Entry", TRUE);
                        IF RecSalesInvLine.FINDFIRST THEN
                            Roundoff := RecSalesInvLine.Amount;
                    END;

                    SILDocNoNew := "Sales Invoice Line"."Document No.";

                    IF InvDisNew > 0 THEN
                        Value := ExAmount - ABS(InvDisNew)
                    ELSE
                        Value := ExAmount - ABS(InvDisNew);



                    /*
                    //Rohit ends for VAT
                     ExAmount := Amount;
                    Value := ExAmount - abs(InvDisc);
                    SalesValue := Value + "Excise Amount";
                    */
                    //TotalValue := SalesValue + "Tax Amount" + Insurance1+VATAmount + ET1 + tgVATCess ;
                    /*
                    IF "Sales Invoice Header"."Export Document" = "Sales Invoice Header"."Export Document"::"1" THEN
                       Export := '*'
                    ELSE
                       Export := '';
                    */
                    //TRISC

                    i := 0;
                    FOR i := 1 TO 3 DO BEGIN
                        JudText[i] := '';
                        PerJud[i] := 0;
                    END;

                    i := 0;
                    IF "Tax Liable" = TRUE THEN BEGIN
                        /*   IF "Tax %" <> 0 THEN
                               TaxBaseAmt := ("Tax Amount" / "Tax %") * 100;*/ // 16630

                        TaxAreaLine.RESET;
                        TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', "Tax Area Code");
                        IF TaxAreaLine.FIND('-') THEN
                            REPEAT
                                //    i := i + 1;
                                TaxDetails.RESET;
                                // 16630  TaxDetails.SETCURRENTKEY("Tax Jurisdiction Code", "Tax Group Code", "Form Code", "Effective Date");//Rahul 060706
                                TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                                TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', "Tax Group Code");
                                // 16630   TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                                TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                                IF TaxDetails.FIND('+') THEN
                                    IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                        /*
                                            IF TaxAreaLine."Tax No." <> 0 THEN BEGIN
                                            JudText[TaxAreaLine."Tax No."] := TaxDetails."Tax Jurisdiction Code";
                                            PerJud[TaxAreaLine."Tax No."] := (TaxBaseAmt * TaxDetails."Tax Below Maximum")/100 ;
                                          END;
                                          */
                                    END;
                            UNTIL TaxAreaLine.NEXT = 0;
                    END;
                    /*     IF "Sales Invoice Line"."Tax %" <> 0 THEN BEGIN
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
                                             TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                                             TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                                             IF TaxDetails.FIND('+') THEN;
                                             tgVATCess := ("Sales Invoice Line"."Tax Base Amount" * TaxDetails."Tax Below Maximum") / 100;
                                         END;
                                     END;
                                 UNTIL TaxAreaLine.NEXT = 0;
                         END;*/ // 16630
                    IF VATAmount = 0 THEN
                        tgVATCess := 0;
                    // tgVATCess := "Sales Invoice Line"."eCess Amount";
                    //TotalValue := SalesValue + "Tax Amount" + Insurance1+VATAmount + ET1 + tgVATCess ;
                    // 16630  TotalValue := SalesValue + "Tax Amount" + Insurance1 + ET1;
                    // TRI SC
                    IF RecState.GET("Sales Invoice Header".State) THEN;
                    CLEAR(StateCodeNum);
                    IF EVALUATE(StateCodeNum, RecState.Code) THEN;

                    ///Kulbhushan Sharma Begin
                    //MSBS.Rao Start-0713
                    //MSBS.Rao Stop-0713


                    ///Kulbhushan Sharma End
                    //Value := Value - ABS(InvDisc);
                    //SalesValue:=SalesValue-ABS(InvDisc);
                    NetValue := ROUND(TotalValue, 1, '=');
                    RecSalesInvLine.RESET;
                    RecSalesInvLine.SETRANGE("Document No.", "Document No.");
                    RecSalesInvLine.SETRANGE(RecSalesInvLine."System-Created Entry", TRUE);
                    IF RecSalesInvLine.FINDFIRST THEN
                        //Roundoff := RecSalesInvLine.Amount;
                        NetValue := TotalValue + Roundoff;


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
                                CAmount := (DetailedGSTLedgerEntry."GST Amount") * -1;
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                //SRate := DetailedGSTLedgerEntry."GST %";
                                sAmount := (DetailedGSTLedgerEntry."GST Amount") * -1;
                                sAmount1 += sAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                //IRate := DetailedGSTLedgerEntry."GST %";
                                IAmount := (DetailedGSTLedgerEntry."GST Amount") * -1;
                                IAmount1 += IAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                //URate := DetailedGSTLedgerEntry."GST %";
                                UAmount := (DetailedGSTLedgerEntry."GST Amount") * -1;
                                UAmount1 += UAmount;
                            END;

                        UNTIL
DetailedGSTLedgerEntry.NEXT = 0;



                    //msvrn 041017>>
                    FrightChargeAmt := 0;
                    OthClm := 0;
                    InsuranceClm := 0;
                    /* 16630 PostedStrOrderLineDetails1.RESET;
                    PostedStrOrderLineDetails1.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");//Rahul 060706
                    PostedStrOrderLineDetails1.SETRANGE(Type, PostedStrOrderLineDetails1.Type::Sale);
                    PostedStrOrderLineDetails1.SETRANGE("Document Type", PostedStrOrderLineDetails1."Document Type"::Invoice);
                    PostedStrOrderLineDetails1.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                    PostedStrOrderLineDetails1.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
                    IF PostedStrOrderLineDetails1.FIND('-') THEN
                        REPEAT
                            IF NOT PostedStrOrderLineDetails1."Payable to Third Party" THEN BEGIN
                                IF PostedStrOrderLineDetails1."Tax/Charge Type" = PostedStrOrderLineDetails1."Tax/Charge Type"::Charges THEN BEGIN
                                    CASE PostedStrOrderLineDetails1."Tax/Charge Group" OF
                                        'FREIGHT':
                                            BEGIN
                                                FrightChargeAmt := FrightChargeAmt + PostedStrOrderLineDetails1.Amount;
                                            END;
                                        'OTH_CLAIM':
                                            BEGIN
                                                OthClm := OthClm + PostedStrOrderLineDetails1.Amount;
                                            END;
                                        'INS_CLAIM':
                                            BEGIN
                                                InsuranceClm := InsuranceClm + PostedStrOrderLineDetails1.Amount;
                                            END;
                                    END;
                                END;
                            END;
                        UNTIL PostedStrOrderLineDetails1.NEXT = 0;*/ //16630
                    //msvrn<<

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalQty := 0;
                recSalesInvLn.RESET;
                recSalesInvLn.SETRANGE("Document No.", "No.");
                recSalesInvLn.SETRANGE(Type, recSalesInvLn.Type::Item);
                IF recSalesInvLn.FINDFIRST THEN
                    REPEAT
                        TotalQty += recSalesInvLn.Quantity;
                    UNTIL recSalesInvLn.NEXT = 0;

                TotalCDAmt += "Sales Invoice Header"."CD Availed from Utilisation";

                //MSAK.BEGIN 050515
                PchCode := '';
                GPchCode := '';
                PriPchCode := '';
                IF Customer2.GET("Sales Invoice Header"."Sell-to Customer No.") THEN BEGIN
                    PchCode := Customer2."PCH Code";
                    GPchCode := Customer2."Govt. SP Resp.";
                    PriPchCode := Customer2."Private SP Resp.";
                END;
                //MSAK.END 050515
                CLEAR(FrieghtCharge);
                /* 16630 PostedStructureOrderDetails.RESET;
                 PostedStructureOrderDetails.SETRANGE(Type, PostedStructureOrderDetails.Type::Sale);
                 PostedStructureOrderDetails.SETRANGE("Document Type", PostedStructureOrderDetails."Document Type"::Invoice);
                 PostedStructureOrderDetails.SETRANGE("No.", "Sales Invoice Header"."No.");
                 PostedStructureOrderDetails.SETRANGE("Tax/Charge Group", 'FREIGHT');
                 IF PostedStructureOrderDetails.FINDFIRST THEN
                     FrieghtCharge := PostedStructureOrderDetails."Calculation Value";*/ //16630
            end;

            trigger OnPostDataItem()
            begin

                CurrReport.CREATETOTALS(SqrMtr, ExAmount, Value, SalesValue, Insurance1, TotalValue, NetValue, Roundoff, VATAmount);
                CurrReport.CREATETOTALS(ET1, tgVATCess, "Sales Invoice Line"."Quantity Discount Amount", "Sales Invoice Line"."Accrued Discount");
                CurrReport.CREATETOTALS("Sales Invoice Line"."Discount Amt 1", "Sales Invoice Line"."Discount Amt 2",
                                         "Sales Invoice Line"."Discount Amt 3");
                FOR i := 1 TO 3 DO
                    CurrReport.CREATETOTALS(PerJud[i]);
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                GLSetup.GET;

                CurrReport.CREATETOTALS("Sales Invoice Line".Quantity, SqrMtr, ExAmount, "Sales Invoice Line"."Line Discount Amount", Value,
                                        "Sales Invoice Line".Amount, SalesValue, "Sales Invoice Line".D1, Insurance1,
                                        TotalValue); // 16630 replace here "Tax Amount" by D1

                CurrReport.CREATETOTALS(InvDisc, NetValue, Roundoff, VATAmount, ET1, tgVATCess, "Sales Invoice Line"."Quantity Discount Amount"
                , "Sales Invoice Line"."Accrued Discount");
                CurrReport.CREATETOTALS("Sales Invoice Line"."Discount Amt 1", "Sales Invoice Line"."Discount Amt 2",
                                         "Sales Invoice Line"."Discount Amt 3");

                FOR i := 1 TO 3 DO
                    CurrReport.CREATETOTALS(PerJud[i]);
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

    trigger OnInitReport()
    begin
        //ERROR('Report is under development, Pls co-operate');
    end;

    trigger OnPostReport()
    begin

        // RepAuditMgt.CreateAudit(50015)
    end;

    trigger OnPreReport()
    begin

        IF "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Unit of Measure Code") = '' THEN
            ERROR('Please enter the Unit of Measure')
        ELSE
            uom := "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Unit of Measure Code");

        IF STRPOS(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date")), '.') <> 1 THEN
            DateFrom := FORMAT("Sales Invoice Header".GETRANGEMIN("Sales Invoice Header"."Posting Date"));

        IF STRPOS(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date")), '.')
          <> STRLEN(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date"))) - 1 THEN
            DateTo := FORMAT("Sales Invoice Header".GETRANGEMAX("Sales Invoice Header"."Posting Date"));

        Filters := "Sales Invoice Header".GETFILTERS + ' ' + "Sales Invoice Line".GETFILTERS;
    end;

    var
        CompInfo: Record "Company Information";
        // 16630 PostedStrOrderLineDetails: Record 13798;
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
        uom: Code[10];
        UnitofMeasure: Record "Unit of Measure";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        i: Integer;
        SalesInvLine1: Record "Sales Invoice Line";
        TaxBaseAmt: Decimal;
        InvDisc: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        GLSetup: Record "General Ledger Setup";
        VATAmount: Decimal;
        ET1: Decimal;
        tgVATCess: Decimal;
        RecState: Record State;
        Location: Record Location;
        TaxJurisdiction: Record "Tax Jurisdiction";
        Cust: Record Customer;
        CompanyName2: Text[100];
        RowNo: Text[50];
        // 16630  PostedStrOrderLDetails: Record 13798;
        "Tin No.": Code[10];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        PchCode: Code[20];
        GPchCode: Code[20];
        PriPchCode: Code[20];
        Customer2: Record Customer;
        RecSalesInvLine: Record "Sales Invoice Line";
        Text001: Label 'As of %1';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        Text012: Label 'Filters 2';
        Text01: Label 'Sales Journal';
        Text002: Label 'Sales Data';
        Filters: Text[250];
        SILDocNoNew: Code[30];
        InvDisNew: Decimal;
        StateCodeNum: Integer;
        TINNo: Code[30];
        // 16630 PostedStructureOrderDetails: Record 13760;
        FrieghtCharge: Decimal;
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
        FrightChargeAmt: Decimal;
        OthClm: Decimal;
        InsuranceClm: Decimal;
        // 16630 PostedStrOrderLineDetails1: Record 13798;
        TotalQty: Decimal;
        recSalesInvLn: Record "Sales Invoice Line";
        TotalCDAmt: Decimal;
}

