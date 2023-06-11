report 50025 "State Cust.Wise SalesJrnl-New"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\StateCustWiseSalesJrnlNew.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 .. 2));
            dataitem("Sales Invoice Header"; 112)
            {
                DataItemTableView = SORTING(State, "Sell-to Customer No.")
                                    ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Posting Date", "No.", "Sell-to Customer No.", "Bill-to City", "Customer Type";
                column(DateFrom; DateFrom)
                {
                }
                column(DateTo; DateTo)
                {
                }
                column(Detailed; Detailed)
                {
                }
                column(Statecode; Statecode)
                {
                }
                column(Statename; Statename)
                {
                }
                column(InvNo; "Sales Invoice Header"."No.")
                {
                }
                column(PostingDate; "Sales Invoice Header"."Posting Date")
                {
                }
                column(CustNo; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(CustName; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(City; "Sales Invoice Header"."Sell-to City")
                {
                }
                column(DealerCode; DealerCode)
                {
                }
                column(SIHpay; "Sales Invoice Header".Pay)
                {
                }
                column(CustType; "Sales Invoice Header"."Customer Type")
                {
                }
                column(SalesType; "Sales Invoice Header"."Sales Type")
                {
                }
                column(OrderNo; "Sales Invoice Header"."Order No.")
                {
                }
                column(ReleDate; FORMAT("Sales Invoice Header"."Releasing Date"))
                {
                }
                column(CDAvail; "Sales Invoice Header"."CD Availed from Utilisation")
                {
                }
                dataitem("Sales Invoice Line"; 113)
                {
                    DataItemLink = "Document No." = FIELD("No."),
                                   "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                    DataItemTableView = WHERE("No." = FILTER(<> ''),
                                              Type = FILTER('Item|Fixed Asset|Resource'),
                                              Quantity = FILTER(<> 0));
                    RequestFilterFields = "Unit of Measure Code";
                    column(Descrip; "Sales Invoice Line".Description + ' ' + "Sales Invoice Line"."Description 2")
                    {
                    }
                    column(Quantity; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(UOM; "Sales Invoice Line"."Unit of Measure")
                    {
                    }
                    column(SqrMtr; SqrMtr)
                    {
                    }
                    column(UnitPriceMulQual; "Sales Invoice Line"."Unit Price" * Quantity)
                    {
                    }
                    column(ExAmount; ExAmount)
                    {
                    }
                    column(LineDisAmt; "Sales Invoice Line"."Line Discount Amount")
                    {
                    }
                    column(DisAmtMinsAqAmt; "Sales Invoice Line"."Quantity Discount Amount" - "Sales Invoice Line"."Accrued Discount")
                    {
                    }
                    column(AccDis; "Sales Invoice Line"."Accrued Discount")
                    {
                    }
                    column(Val; Value)
                    {
                    }
                    column(ExciseAmt; 0) // 16630 blank "Sales Invoice Line".Excise Amount
                    {
                    }
                    column(SalesValue; SalesValue)
                    {
                    }
                    column(Taxamount; Taxamount)
                    {
                    }
                    column(Insurance1; Insurance1)
                    {
                    }
                    column(tgVATCess; tgVATCess)
                    {
                    }
                    column(TotalValue; TotalValue)
                    {
                    }
                    column(Roundoff; Roundoff)
                    {
                    }
                    column(NetValue; NetValue)
                    {
                    }
                    column(EXAmt1; 0) // 16630 blank "Sales Invoice Line".Excise Amount
                    {
                    }
                    column(Dis1; "Sales Invoice Line"."Discount Amt 1")
                    {
                    }
                    column(Dis2; "Sales Invoice Line"."Discount Amt 2")
                    {
                    }
                    column(Dis3; "Sales Invoice Line"."Discount Amt 3")
                    {
                    }
                    column(Dis4; "Sales Invoice Line"."Discount Amt 4")
                    {
                    }
                    column(VatAmtMinVatCess; VATAmount - tgVATCess)
                    {
                    }
                    column(SILTaxAmt; 0) // 16630 blank "Sales Invoice Line".Tax Amount
                    {
                    }
                    column(ET1; ET1)
                    {
                    }
                    column(SILNo; "Sales Invoice Line"."No.")
                    {
                    }
                    column(ItemClass; Item."Item Classification")
                    {
                    }
                    column(ItemCatCode; "Sales Invoice Line"."Item Category Code")
                    {
                    }
                    column(ItemGrpDes; TgItemGrp.Description)
                    {
                    }
                    column(QualityCode; "Sales Invoice Line"."Quality Code")
                    {
                    }
                    column(LocationCode; "Sales Invoice Line"."Location Code")
                    {
                    }
                    column(MRPPrice; 0) // 16630 blank "Sales Invoice Line".MRP Price
                    {
                    }
                    column(MRPPerSqmtr; MRPPerSqmtr)
                    {
                    }
                    column(D1; "Sales Invoice Line".D1)
                    {
                    }
                    column(D2; "Sales Invoice Line".D2)
                    {
                    }
                    column(D3; "Sales Invoice Line".D3)
                    {
                    }
                    column(D4; "Sales Invoice Line".D4)
                    {
                    }
                    column(LineDisPerSqMeter; ROUND(("Sales Invoice Line"."Line Discount Amount" / SqrMtr), 0.01, '='))
                    {
                    }
                    column(BillingRate; BillingRate)
                    {
                    }
                    column(BuyerRateSqm; BuyerRateSqm)
                    {
                    }
                    column(SalesPersonName; Salesperson.Name)
                    {
                    }
                    column(PCHName; Salesperson1.Name)
                    {
                    }
                    column(GovtSPName; Salesperson2.Name)
                    {
                    }
                    column(PrivSPName; Salesperson3.Name)
                    {
                    }
                    column(InvDisc1; InvDisc1)
                    {
                    }
                    column(OthClm; OthClm)
                    {
                    }
                    column(InsuranceClm; InsuranceClm)
                    {
                    }
                    column(TotalQty; TotalQty)
                    {
                    }
                    column(TotalCDAvail; TotalCDAvail)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //msvrn 041017>>
                        TotalQty := 0;
                        recSalesInvLn.RESET;
                        recSalesInvLn.SETRANGE("Document No.", "Document No.");
                        recSalesInvLn.SETRANGE(Type, recSalesInvLn.Type::Item);
                        IF recSalesInvLn.FINDFIRST THEN
                            REPEAT
                                TotalQty += recSalesInvLn.Quantity;
                            UNTIL recSalesInvLn.NEXT = 0;


                        /* 16630   FrightChargeAmt := 0;
                           OthClm := 0;
                           InsuranceClm := 0;
                           PostedStrOrderLineDetails1.RESET;
                           PostedStrOrderLineDetails1.SETCURRENTKEY(Type, "Invoice No.", "Item No.", "Line No.");
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
                               UNTIL PostedStrOrderLineDetails1.NEXT = 0;*/ // 16630
                                                                            //msvrn<<


                        // TRI G.D 06.05.08
                        /* 16630  Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                          IF Location.GET("Location Code") THEN
                              IF Location."State Code" = Cust."State Code" THEN
                                  VATAmount := "Sales Invoice Line"."Tax Amount";

                          Taxamount := ROUND("Tax Amount", 0.01, '=');
                          CLEAR(Insurance1);
                          CLEAR(InvDisc1);
                          PostedStrOrderLineDetails.RESET;
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
                                              // IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                              //    InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount);
                                              IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                                  ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                                              // TRI SC
                                          END;
                                  END;
                              UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ // 16630

                        /* 16630   IF "Sales Invoice Line"."Tax %" <> 0 THEN BEGIN
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
                           END;
                           IF VATAmount = 0 THEN
                               tgVATCess := 0;
                           GLSetup.GET;
                           PostedStrOrderLineDetails.RESET;
                           PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                           PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
                           PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                           PostedStrOrderLineDetails.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                           IF PostedStrOrderLineDetails.FIND('-') THEN
                               REPEAT
                                   CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                       PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                           BEGIN
                                               //IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                               //  InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount);
                                               IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                                   IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                       InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount)
                                                   ELSE //MSBS.Rao 0713
                                                       InvDisc1 := InvDisc1 + -PostedStrOrderLineDetails.Amount;//MSBS.Rao 0713
                                           END;
                                   END;

                               UNTIL PostedStrOrderLineDetails.NEXT = 0;
                           // TRI SC use VATAmount


                           //TRI SC
                           ExAmount := ROUND(("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity) +
                            "Sales Invoice Line"."Excise Amount", 0.01, '=');
                           Value := ROUND(ExAmount - "Sales Invoice Line"."Line Discount Amount"
                                               - "Sales Invoice Line"."Quantity Discount Amount", 0.01, '=');

                           IF InvDisc1 > 0 THEN
                               SalesValue := Value - ABS(InvDisc1) ELSE
                               SalesValue := Value - InvDisc1;
                           IF Salesperson.GET("Salesperson Code") THEN;
                           NetValue := ROUND(SalesValue + "Sales Invoice Line"."CESS Amount" + Taxamount + Insurance1 + ET1, 0.01, '=');
                           // Temp Coment
                           SqrMtr := ROUND(Item.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                           Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                           IF Sqmt <> 0 THEN
                               MRPPerSqmtr := ROUND(("MRP Price" * Quantity / Sqmt), 0.01, '=');
                           IF SqrMtr <> 0 THEN
                               BillingRate := ROUND(Value / SqrMtr, 0.01, '=');*/ // 16630
                                                                                  //TRI SC 050510
                                                                                  //MSSS
                        DealerCode := '';
                        SalesInvHeader.RESET;
                        SalesInvHeader.SETRANGE("No.", "Document No.");
                        IF SalesInvHeader.FIND('-') THEN BEGIN
                            SalespersonPurchaser.RESET;
                            IF SalespersonPurchaser.GET(SalesInvHeader."Dealer Code") THEN
                                DealerCode := SalespersonPurchaser."Customer No.";
                        END;

                        BuyerRateSqm := (ROUND((("Sales Invoice Line"."Line Discount Amount" / SqrMtr) +
                                                             (ExAmount - "Sales Invoice Line"."Line Discount Amount") / SqrMtr), 0.01, '='));
                        //RB

                        IF Salesperson1.GET(RecCustomer."PCH Code") THEN;
                        IF Salesperson3.GET(RecCustomer."Private SP Resp.") THEN;
                        IF Salesperson2.GET(RecCustomer."Govt. SP Resp.") THEN;

                        GrandTaxAmount := GrandTaxAmount + Taxamount;

                        //TRISC
                        TotalBasicAmt := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity;
                    end;

                    trigger OnPreDataItem()
                    begin

                        GLSetup.GET;
                        //Vipul
                        Value := 0;
                        NetValue := 0;
                        Insurance1 := 0;
                        VATAmount := 0;
                        tgVATCess := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TotalCDAvail += "Sales Invoice Header"."CD Availed from Utilisation";

                    IF StateRec.GET(State) THEN
                        Statename := StateRec.Description;
                    Statecode := StateRec.Code;
                    IF RecCustomer.GET("Sales Invoice Header"."Sell-to Customer No.") THEN;
                end;

                trigger OnPreDataItem()
                begin
                    IF Integer.Number = 1 THEN BEGIN
                        SETRANGE("Location Code", LocationNew);
                        SETFILTER(State, '<>%1', StateCode2);
                    END ELSE BEGIN
                        //SETFILTER("Location Code",'<>%1',LocationNew);
                        SETFILTER(State, '%1', StateCode2);
                    END;

                    //SETRANGE("Location Code",LocationNew);
                    //SETFILTER(State,'<>%1',StateCode2);
                    //MESSAGE('%1',COUNT)
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Detail; Detailed)
                {
                    ApplicationArea = All;
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

    trigger OnPreReport()
    begin

        IF STRPOS(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date")), '.') <> 1 THEN
            DateFrom := FORMAT("Sales Invoice Header".GETRANGEMIN("Sales Invoice Header"."Posting Date"));

        IF STRPOS(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date")), '.')
          <> STRLEN(FORMAT("Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date"))) - 1 THEN
            DateTo := FORMAT("Sales Invoice Header".GETRANGEMAX("Sales Invoice Header"."Posting Date"));

        UserLocation1.RESET;
        UserLocation1.SETRANGE("User ID", USERID);
        UserLocation1.SETFILTER("Create Sales Order", '%1', TRUE);
        IF UserLocation1.FINDFIRST THEN BEGIN
            LocationNew := UserLocation1."Location Code";
        END;
        IF LocationNew = '' THEN
            LocationNew := 'DRA-PLANT';


        RecLocation.GET(LocationNew);
        StateCode2 := RecLocation."State Code";
    end;

    var
        // 16630  PostedStrOrderLineDetails: Record 13798;
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
        // 16630 StructureLineDetails: Record 13798;
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
        StateCode1: Code[10];
        RecUserLocation: Record "User Location";
        RecCustomer: Record Customer;
        BranchCode: Code[20];
        UserLocation: Record "User Location";
        UserStateSetup: Record "User State Setup";
        "--MSBS.Rao_MIPL--": Integer;
        ExportToExcel: Boolean;
        RowNo: Text[50];
        TBasicAmt: Decimal;
        TDissmt: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        UserLocation1: Record "User Location";
        LocationNew: Code[30];
        RecLocation: Record Location;
        StateCode2: Code[20];
        Salesperson1: Record "Salesperson/Purchaser";
        Salesperson2: Record "Salesperson/Purchaser";
        Salesperson3: Record "Salesperson/Purchaser";
        "//msvrn": Integer;
        TotalQty: Integer;
        recSalesInvLn: Record "Sales Invoice Line";
        FrightChargeAmt: Decimal;
        OthClm: Decimal;
        InsuranceClm: Decimal;
        // 16630 PostedStrOrderLineDetails1: Record 13798;
        TotalCDAvail: Decimal;
}

