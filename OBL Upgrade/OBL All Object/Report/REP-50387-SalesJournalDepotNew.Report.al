report 50387 "Sales Journa(lDepot) New"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesJournalDepotNew.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 .. 2));
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);
                RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to City", "Location Code";
                column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
                {
                }
                column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(RecStateCode; RecState.Code)
                {
                }
                column(DealerCode_SalesInvoiceHeader; "Sales Invoice Header"."Dealer Code")
                {
                }
                column(trad_disc; "Sales Invoice Header"."CD Availed from Utilisation")
                {
                }
                column(gstrn; gstn)
                {
                }
                column(CDAvail; "Sales Invoice Header"."CD Availed from Utilisation")
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No."),
                                   "Posting Date" = FIELD("Posting Date");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending)
                                        WHERE("No." = FILTER(<> ''),
                                              Type = FILTER("Item" | "Fixed Asset" | "Resource"),
                                              Quantity = FILTER(<> 0));
                    //16225  "Supplementary" = FILTER(false));
                    RequestFilterFields = "Unit of Measure Code", Type, "Item Category Code", "Quantity Discount Amount", "Accrued Discount";//16225, "Tax %"
                    column(SILDocNo; "Sales Invoice Line"."Document No.")
                    {
                    }
                    column(SILPostingDate; FORMAT("Sales Invoice Line"."Posting Date"))
                    {
                    }
                    column(DateFrom; DateFrom)
                    {
                    }
                    column(DateTo; DateTo)
                    {
                    }
                    column(CompanyName1; CompanyName1)
                    {
                    }
                    column(CompanyName2; CompanyName2)
                    {
                    }
                    column(Filters; Filters)
                    {
                    }
                    column(uom; uom)
                    {
                    }
                    column(Export; Export)
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                    {
                    }
                    column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(SqrMtr; SqrMtr)
                    {
                    }
                    column(ExAmount; ExAmount)
                    {
                    }
                    column(InvDisc; InvDisc)
                    {
                    }
                    column(QD; "Sales Invoice Line"."Quantity Discount Amount" - "Sales Invoice Line"."Accrued Discount")
                    {
                    }
                    column(AQD; "Sales Invoice Line"."Accrued Discount")
                    {
                    }
                    column(Value; Value)
                    {
                    }
                    //16225 column(ExciseAmount_SalesInvoiceLine; "Sales Invoice Line"."Excise Amount")
                    column(ExciseAmount_SalesInvoiceLine; '')
                    {
                    }
                    column(SalesValue; SalesValue)
                    {
                    }
                    column(PerJud; PerJud[2])
                    {
                    }
                    column(ET1; ET1)
                    {
                    }
                    column(VATAmount; VATAmount - tgVATCess)
                    {
                    }
                    column(tgVATCess; tgVATCess)
                    {
                    }
                    //16225  column(TaxAmount_SalesInvoiceLine; "Sales Invoice Line"."Tax Amount")
                    column(TaxAmount_SalesInvoiceLine; '')
                    {
                    }
                    column(Insurance1; Insurance1)
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
                    column(TODAY; FORMAT(TODAY))
                    {
                    }
                    column(TINNo; "Sales Invoice Header"."Tin No.")
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
                    column(AreaCode; AreaCode)
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
                    column(InsuranceClm; InsuranceClm)
                    {
                    }
                    column(TotalQty; TotalQty)
                    {
                    }
                    column(TotalCDAvail; TotalCDAvail)
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


                        FrightChargeAmt := 0;
                        OthClm := 0;
                        InsuranceClm := 0;
                        //16225 Table N/F start
                        /*  PostedStrOrderLineDetails1.RESET;
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
                              UNTIL PostedStrOrderLineDetails1.NEXT = 0;*///16225 Table N/F End
                                                                          //msvrn<<


                        SqrMtr := 0;
                        tgVATCess := 0; // TRI G.D 06.05.08
                        SqrMtr := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);

                        TaxBaseAmt := 0;
                        Insurance1 := 0;
                        InvDisc := 0;
                        ET1 := 0;
                        GenLegSetup.GET;

                        //16225 Table N/F start
                        /*   PostedStrOrderLineDetails.RESET;
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
                                               //IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                               //  InvDisc := InvDisc + ABS(PostedStrOrderLineDetails.Amount);
                                               IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                                   IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                       InvDisc := InvDisc + ABS(PostedStrOrderLineDetails.Amount)
                                                   ELSE //MSBS.Rao 0713
                                                       InvDisc := InvDisc + -PostedStrOrderLineDetails.Amount;//MSBS.Rao 0713

                                               IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                                   ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                                               // TRI SC
                                           END;
                                   END;
                               UNTIL PostedStrOrderLineDetails.NEXT = 0;*///16225 Table N/F End
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
                        VATAmount := 0;
                        Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                        IF Location.GET("Location Code") THEN
                            IF Location."State Code" = Cust."State Code" THEN;
                        //16225   VATAmount := "Sales Invoice Line"."Tax Amount";
                        //TRI DG Add Stop
                        /*
                        IF "Free Supply" = FALSE THEN
                         BEGIN
                         ExAmount:= ROUND(("Sales Invoice Line"."Unit Price"*"Sales Invoice Line".Quantity) +
                          "Sales Invoice Line"."Excise Amount",0.01,'=');
                         Value:= ROUND(ExAmount - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                         SalesValue:= Value - InvDisc;
                        
                         END ELSE
                          BEGIN
                           ExAmount:= Amount;
                           //Value:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                           SalesValue:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=') - InvDisc;
                          END;
                         */
                        //16225 Table N/F start
                        /* IF "Free Supply" = FALSE THEN BEGIN
                             IF Amount <> 0 THEN
                                 ExAmount := Amount
                             ELSE
                                 IF "Sales Invoice Line"."Line Discount %" <> 100 THEN
                                     ExAmount := ROUND(("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity) +
                                      "Sales Invoice Line"."Excise Amount", 0.01, '=');
                             IF InvDisc > 0 THEN
                                 Value := ExAmount - ABS(InvDisc) ELSE
                                 Value := ExAmount - (InvDisc);
                             //  MESSAGE('%1=%2=%3',ExAmount,Value , InvDisc) ;
                             SalesValue := Value + "Excise Amount";
                         END ELSE BEGIN
                             ExAmount := Amount;
                             //Value:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                             SalesValue := Value + "Excise Amount";
                         END;*///16225 Table N/F End

                        /*
                        //Rohit ends for VAT
                         ExAmount := Amount;
                        Value := ExAmount - InvDisc;
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
                            //16225  IF "Tax %" <> 0 THEN
                            //16225   TaxBaseAmt := ("Tax Amount" / "Tax %") * 100;

                            TaxAreaLine.RESET;
                            TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', "Tax Area Code");
                            IF TaxAreaLine.FIND('-') THEN
                                REPEAT
                                    //    i := i + 1;
                                    TaxDetails.RESET;
                                    TaxDetails.SETCURRENTKEY("Tax Jurisdiction Code", "Tax Group Code", "Effective Date");  //16225, "Form Code"//Rahul 060706
                                    TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                                    TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', "Tax Group Code");
                                    //16225  TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
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
                        //16225 Field N/F Start
                        /*IF "Sales Invoice Line"."Tax %" <> 0 THEN BEGIN
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
                        END;*///16225 Field N/F End
                        IF VATAmount = 0 THEN
                            tgVATCess := 0;
                        // tgVATCess := "Sales Invoice Line"."eCess Amount";
                        //TotalValue := SalesValue + "Tax Amount" + Insurance1+VATAmount + ET1 + tgVATCess ;
                        //16225  TotalValue := SalesValue + "Tax Amount" + Insurance1 + ET1;
                        // TRI SC
                        IF RecState.GET("Sales Invoice Header".State) THEN;

                        NetValue := ROUND(TotalValue, 1, '=');
                        Roundoff := ROUND(TotalValue, 1, '=') - TotalValue;

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
                        CLEAR(NetValue);
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    PchCode := '';
                    GPchCode := '';
                    PriPchCode := '';
                    IF Customer2.GET("Sales Invoice Header"."Sell-to Customer No.") THEN BEGIN
                        PchCode := Customer2."PCH Code";
                        GPchCode := Customer2."Govt. SP Resp.";
                        PriPchCode := Customer2."Private SP Resp.";
                        AreaCode := Customer2."Area Code";
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF Integer.Number = 1 THEN BEGIN
                        SETRANGE("Location Code", LocationNew);
                        SETFILTER(State, '<>%1', StateCode);
                    END ELSE BEGIN
                        //SETFILTER("Location Code",'<>%1',LocationNew);
                        SETFILTER(State, '%1', StateCode);
                    END;
                end;
            }
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

    trigger OnPreReport()
    begin
        CLEAR("Sales Invoice Header"."Posting Date");

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

        UserLocation1.RESET;
        UserLocation1.SETRANGE("User ID", USERID);
        UserLocation1.SETFILTER("Create Sales Order", '%1', TRUE);
        IF UserLocation1.FINDFIRST THEN BEGIN
            LocationNew := UserLocation1."Location Code";
        END;

        RecLocation.GET(LocationNew);
        StateCode := RecLocation."State Code";
    end;

    var
        //16225 PostedStrOrderLineDetails: Record "13798";
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
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        Filters: Text[250];
        GLSetup: Record "General Ledger Setup";
        VATAmount: Decimal;
        ET1: Decimal;
        tgVATCess: Decimal;
        RecState: Record State;
        Location: Record Location;
        TaxJurisdiction: Record "Tax Jurisdiction";
        Cust: Record Customer;
        CompanyName2: Text[100];
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        RecUserLocation: Record "User Location";
        VarLocation: Code[10];
        StateCode: Code[10];
        RecCustomer: Record Customer;
        UserLocation: Record "User Location";
        RecSIH: Record "Sales Invoice Header";
        UserStateSetup: Record "User State Setup";
        "--MIPL--": Integer;
        ExportToExcel: Boolean;
        RowNo: Text[50];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        UserLocation1: Record "User Location";
        IncludeDirectSale: Boolean;
        LocationNew: Code[20];
        RecLocation: Record Location;
        PchCode: Code[20];
        GPchCode: Code[20];
        PriPchCode: Code[20];
        AreaCode: Code[20];
        Customer2: Record Customer;
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
        "//msvrn": Integer;
        TotalQty: Integer;
        recSalesInvLn: Record "Sales Invoice Line";
        FrightChargeAmt: Decimal;
        OthClm: Decimal;
        InsuranceClm: Decimal;
        //16225  PostedStrOrderLineDetails1: Record "13798";
        TotalCDAvail: Decimal;

    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
    begin
        //MSBS.Rao Begin Dt. 01-08-12
        UserLocation.RESET;
        UserLocation.SETRANGE("User ID", USERID);
        UserLocation.SETFILTER("Create Sales Order", '%1', TRUE);
        IF UserLocation.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := UserLocation."Location Code"
                ELSE
                    Loc := Loc + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;
        END;
        EXIT(Loc);
        //MSBS.Rao End Dt. 01-08-12
    end;

    procedure GetStates(): Text[800]
    var
        StateCode: Text[800];
    begin
        //MSBS.Rao Begin Dt. 01-08-12
        UserStateSetup.RESET;
        UserStateSetup.SETRANGE("User ID", USERID);
        IF UserStateSetup.FINDFIRST THEN BEGIN
            REPEAT
                IF StateCode = '' THEN
                    StateCode := UserStateSetup.State
                ELSE
                    StateCode := StateCode + '|' + UserStateSetup.State;
            UNTIL UserStateSetup.NEXT = 0;
        END;
        EXIT(StateCode);
        //MSBS.Rao End Dt. 01-08-12
    end;

    procedure GetPCHCode(): Text[800]
    var
        PCHCode: Text[800];
    begin
        //MSAK.Begin 30-04-15
        UserStateSetup.RESET;
        UserStateSetup.SETRANGE("User ID", USERID);
        IF UserStateSetup.FINDFIRST THEN BEGIN
            REPEAT
                IF PCHCode = '' THEN
                    PCHCode := UserStateSetup."PCH Code"
                ELSE
                    PCHCode := PCHCode + '|' + UserStateSetup."PCH Code";
            UNTIL UserStateSetup.NEXT = 0;
        END;
        EXIT(PCHCode);
        //MSAK.End 30-04-15
    end;

    procedure GetPCHStateCode(): Text[800]
    var
        PCHStateCode: Text[800];
    begin
        //MSAK.Begin 30-04-15
        UserStateSetup.RESET;
        UserStateSetup.SETRANGE("User ID", USERID);
        IF UserStateSetup.FINDFIRST THEN BEGIN
            REPEAT
                IF PCHStateCode = '' THEN
                    PCHStateCode := UserStateSetup.State
                ELSE
                    PCHStateCode := PCHStateCode + '|' + UserStateSetup.State;
            UNTIL UserStateSetup.NEXT = 0;
        END;
        EXIT(PCHStateCode);
        //MSAK.End 30-04-15
    end;
}

