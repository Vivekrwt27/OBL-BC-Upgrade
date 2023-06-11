report 50207 "Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CreditMemo.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(INV_NO; CustLedEntry."Document No.")
            {
            }
            column(AcknowledgementNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Acknowledgement No.")
            {
            }
            column(IRNHash_SalesCrMemoHeader; "Sales Cr.Memo Header"."IRN Hash")
            {
            }
            column(QRCode_SalesCrMemoHeader; "Sales Cr.Memo Header"."QR Code")
            {
            }
            column(INV_Date; FORMAT(CustLedEntry."Posting Date"))
            {
            }
            column(GST_No_loc; Location."GST Registration No.")
            {
            }
            column(GST_No_CUS; customer."GST Registration No.")
            {
            }
            column(Cust_POstCode; customer."Pin Code")
            {
            }
            column(date; TODAY)
            {
            }
            column(User; USERID)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(LocAddr; Location.Address)
            {
            }
            column(LocAddr2; Location."Address 2")
            {
            }
            column(LocCity; Location.City)
            {
            }
            column(LocPostCode; Location."Post Code")
            {
            }
            column(LocState; Location."State Code")
            {
            }
            column(LocPinCode; Location."Pin Code")
            {
            }
            column(LocStateName; StateName)
            {
            }
            column(LocCountryName; CountryName)
            {
            }
            column(RoundedAmt; RoundedAmt)
            {
            }
            column(StDESC; StDESC)
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
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
            {
            }
            column(ExternalDocumentNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."External Document No.")
            {
            }
            column(SelltoCustomerNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer Name 2")
            {
            }
            column(SelltoAddress_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Address")
            {
            }
            column(SelltoAddress2_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Address 2")
            {
            }
            column(SelltoCity_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to City")
            {
            }
            column(PostingDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Posting Date"))
            {
            }
            column(Amt3; Amt3)
            {
            }
            column(NetAmt; NetAmt)
            {
            }
            column(RndOff; RndOff)
            {
            }

            column(SaleTax; SaleTax)
            {
            }
            column(Excise; Excise)
            {
            }
            column(Amt; Amt1)
            {
            }
            dataitem("Sales Cr.Memo Line"; 115)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
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
                column(Description_SalesCrMemoLine; "Sales Cr.Memo Line".Description)
                {
                }
                column(Description2_SalesCrMemoLine; "Sales Cr.Memo Line"."Description 2")
                {
                }
                column(Amount_SalesCrMemoLine; "Sales Cr.Memo Line".Amount)
                {
                }
                //16225  column(TotalTDSTCSInclSHECESS_SalesCrMemoLine; "Sales Cr.Memo Line"."Total TDS/TCS Incl SHE CESS")
                column(TotalTDSTCSInclSHECESS_SalesCrMemoLine; TotalTCS)
                {
                }
                column(NetWeight_SalesCrMemoLine; "Sales Cr.Memo Line"."Net Weight")
                {
                }
                column(GrossWeight_SalesCrMemoLine; "Sales Cr.Memo Line"."Gross Weight")
                {
                }
                column(DisAmt1; DisAmt1)
                {
                }
                column(tds; tds)
                {
                }
                column(SalesQTYCRT; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(SalesQTYSQMTR; "Sales Cr.Memo Line"."Quantity (Base)")
                {
                }
                column(SalesPriceSQMTR; SalesPriceSQMTR)
                {
                }
                column(InvDisc; InvDisc)
                {
                }
                column(InsuranceAmt; InsuranceAmt)
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
                var
                    TCSEntry: Record "TCS Entry";
                begin
                    Clear(TotalTCS);
                    TCSEntry.Reset();
                    TCSEntry.SetRange("Document No.", "Document No.");
                    if TCSEntry.FindSet() then
                        repeat
                            TotalTCS += TCSEntry."Total TCS Including SHE CESS";
                        until TCSEntry.Next() = 0;
                    Clear(TotalLineAmt);
                    SCML.Reset();
                    SCML.SetRange("Document No.", "Document No.");
                    if SCML.FindSet() then
                        repeat
                            TotalLineAmt += SCML.Amount;
                            if SCML."No." = '51157000' then
                                RoundOff := SCML.Amount;
                        until SCML.Next() = 0;

                    NetAmt := TotalLineAmt + IAmount + SAmount + CAmount - TotalTCS;
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(NoText, ROUND(NetAmt, 1.0), "Sales Cr.Memo Header"."Currency Code");

                    DiscAmt := Amount;
                    //16225  tds := tds + "Sales Cr.Memo Line"."Total TDS/TCS Incl SHE CESS";
                    DisAmt1 += Amount;
                    //GST

                    CRate := 0;
                    SRate := 0;
                    IRate := 0;
                    URate := 0;
                    CAmount := 0;
                    SAmount := 0;
                    IAmount := 0;
                    UAmount := 0;

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
                                //IAmount1+=IAmount;
                            END;

                        UNTIL
DetailedGSTLedgerEntry.NEXT = 0;

                    // MS - 290818 - Incase line type is "Charge(Item)"
                    IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"Charge (Item)" THEN BEGIN
                        GSTLedgerEntry.RESET;
                        GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
                        GSTLedgerEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                        GSTLedgerEntry.SETRANGE("Posting Date", "Sales Cr.Memo Line"."Posting Date");
                        IF GSTLedgerEntry.FINDFIRST THEN
                            REPEAT
                                IF GSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                    CAmount := GSTLedgerEntry."GST Amount";
                                    DetailedGSTLedgerEntry.RESET;
                                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                        REPEAT
                                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                                                CRate := DetailedGSTLedgerEntry."GST %";
                                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                END;
                                IF GSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                    SAmount := GSTLedgerEntry."GST Amount";
                                    DetailedGSTLedgerEntry.RESET;
                                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                        REPEAT
                                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                                                SRate := DetailedGSTLedgerEntry."GST %";
                                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                END;
                                IF GSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                    IAmount := GSTLedgerEntry."GST Amount";
                                    DetailedGSTLedgerEntry.RESET;
                                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                        REPEAT
                                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                                                IRate := DetailedGSTLedgerEntry."GST %";
                                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                END;
                                IF GSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                    UAmount := GSTLedgerEntry."GST Amount";
                                    DetailedGSTLedgerEntry.RESET;
                                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                        REPEAT
                                            IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN
                                                URate := DetailedGSTLedgerEntry."GST %";
                                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                END;
                            UNTIL GSTLedgerEntry.NEXT = 0;
                    END;
                    //

                    //MIPLRK 160719>>>
                    CLEAR(SalesQTYCRT);
                    CLEAR(SalesQTYSQMTR);
                    CLEAR(SalesPriceSQMTR);
                    IF "Sales Cr.Memo Header"."Applies-to Doc. Type" = "Sales Cr.Memo Header"."Applies-to Doc. Type"::Invoice THEN BEGIN
                        IF "Sales Cr.Memo Header"."Applies-to Doc. No." <> '' THEN BEGIN
                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETFILTER(Type, '%1', SalesInvoiceLine.Type::Item);
                            SalesInvoiceLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                            SalesInvoiceLine.SETRANGE("No.", "No.");
                            IF SalesInvoiceLine.FINDFIRST THEN
                                REPEAT
                                    SalesQTYCRT := SaleCredMemoLine.Quantity;
                                    SalesQTYSQMTR := SaleCredMemoLine."Quantity (Base)";
                                    SalesPriceSQMTR := SalesInvoiceLine."Buyer's Price" / SalesInvoiceLine."Qty. per Unit of Measure";
                                UNTIL SalesInvoiceLine.NEXT = 0;
                        END ELSE BEGIN
                            IF "Sales Cr.Memo Header"."Applies-to Doc. No." <> '' THEN BEGIN
                                SalesInvoiceLine.RESET;
                                SalesInvoiceLine.SETFILTER(Type, '%1', SalesInvoiceLine.Type::"G/L Account");
                                SalesInvoiceLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                                SalesInvoiceLine.SETRANGE("No.", "No.");
                                IF SalesInvoiceLine.FINDFIRST THEN
                                    REPEAT
                                        SalesQTYCRT := SaleCredMemoLine.Quantity;
                                        SalesQTYSQMTR := SaleCredMemoLine."Quantity (Base)";
                                        ;
                                        SalesPriceSQMTR := SalesInvoiceLine."Buyer's Price" / SalesInvoiceLine."Qty. per Unit of Measure";
                                    UNTIL SalesInvoiceLine.NEXT = 0;
                            END;
                        END;
                    END ELSE BEGIN
                        IF "Sales Cr.Memo Header"."Applies-to Doc. Type" = "Sales Cr.Memo Header"."Applies-to Doc. Type"::" " THEN BEGIN
                            SalesQTYCRT := "Sales Cr.Memo Line".Quantity;
                            SalesPriceSQMTR := "Sales Cr.Memo Line"."Unit Price";
                            SalesQTYSQMTR := 0;
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    tds := 0;
                end;
            }
            //16225 Dataitem Table N/F Start
            /*  dataitem(DataItem1000000002; Table13798)
              {
                  DataItemLink = Invoice No.=FIELD(No.);
                  DataItemTableView = SORTING(Tax/Charge Type, Tax/Charge Code)
                                      ORDER(Ascending)
                                      WHERE(Type = CONST(Sale),
                                            Document Type=CONST(Credit Memo));
                  column(InvDisc; InvDisc)
                  {
                  }
                  column(InsuranceAmt; InsuranceAmt)
                  {
                  }

                  trigger OnAfterGetRecord()
                  begin
                      GenLegSetup.GET;
                      IF ("Tax/Charge Type" = "Tax/Charge Type"::Charges) AND ("Charge Type" = "Charge Type"::" ") THEN
                          IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                              InvDisc := Amount;
                      InvDisc1 += Amount;

                      IF ("Tax/Charge Type" = "Tax/Charge Type"::Charges) AND ("Charge Type" = "Charge Type"::Insurance) THEN
                          InsuranceAmt := Amount;
                      InsuranceAmt1 += Amount;

                      IF "Tax/Charge Type" = "Tax/Charge Type"::Charges THEN
                          Amt := Amount - InvDisc - InsuranceAmt
                      ELSE
                          Amt := Amount;

                      TotalAmt := TotalAmt + Amt;
                  end;

                  trigger OnPreDataItem()
                  begin
                      TotalAmt := 0;
                  end;
              }

              trigger OnAfterGetRecord()
              begin
                  IF Location.GET("Sales Cr.Memo Header"."Location Code") THEN;
                  IF customer.GET("Sales Cr.Memo Header"."Sell-to Customer No.") THEN;
                  CustLedEntry.SETRANGE(CustLedEntry."Document No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                  IF CustLedEntry.FINDFIRST THEN;

                  CLEAR(StateName);
                  CLEAR(CountryName);
                  IF Location2.GET("Sales Cr.Memo Header"."Location Code") THEN BEGIN
                      State2.RESET;
                      State2.SETRANGE(State2.Code, Location2."State Code");
                      IF State2.FINDFIRST THEN
                          StateName := State2.Description;

                      CountryRegion.RESET;
                      CountryRegion.SETRANGE(Code, Location2."Country/Region Code");
                      IF CountryRegion.FINDFIRST THEN
                          CountryName := CountryRegion.Name;
                  END;

                  State1.RESET;
                  State1.SETRANGE(State1.Code, State);
                  IF State1.FIND('-') THEN
                      StDESC := State1.Description;
                  CLEAR(InvDisc);
                  CLEAR(InsuranceAmt);
                  CLEAR(Amt3);
                  CLEAR(tds);
                  CLEAR(DisAmt1);
                  CLEAR(Amt1);
                  CLEAR(Amt);
                  /*
                  NetAmt := DiscAmt + InvDisc + InsuranceAmt + TotalAmt-tds;
                  RndOff := ROUND(NetAmt,1,'=') - NetAmt;

                  CheckReport.InitTextVariable;
                  CheckReport.FormatNoText(NoText,ROUND(NetAmt,1,'='),'');
                  */
            /* PostedStrOrderLineDetails.RESET;
             PostedStrOrderLineDetails.SETFILTER(Type, 'Sale');
             PostedStrOrderLineDetails.SETFILTER("Document Type", 'Credit Memo');
             PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Header"."No.");
             PostedStrOrderLineDetails.SETRANGE("Tax/Charge Type", PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
             PostedStrOrderLineDetails.SETRANGE("Charge Type", PostedStrOrderLineDetails."Charge Type"::" ");
             PostedStrOrderLineDetails.SETRANGE("Tax/Charge Group", GenLegSetup."Discount Charge");
             IF PostedStrOrderLineDetails.FINDSET THEN
                 REPEAT
                     InvDisc += PostedStrOrderLineDetails.Amount;
                 UNTIL
                 PostedStrOrderLineDetails.NEXT = 0;

             PostedStrOrderLineDetails.RESET;
             PostedStrOrderLineDetails.SETFILTER(Type, 'Sale');
             PostedStrOrderLineDetails.SETFILTER("Document Type", 'Credit Memo');
             PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Header"."No.");
             PostedStrOrderLineDetails.SETRANGE("Tax/Charge Type", PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
             PostedStrOrderLineDetails.SETRANGE("Charge Type", PostedStrOrderLineDetails."Charge Type"::Insurance);
             IF PostedStrOrderLineDetails.FINDSET THEN
                 REPEAT
                     InsuranceAmt += PostedStrOrderLineDetails.Amount;
                 UNTIL
                 PostedStrOrderLineDetails.NEXT = 0;
             PostedStrOrderLineDetails.RESET;
             PostedStrOrderLineDetails.SETFILTER(Type, 'Sale');
             PostedStrOrderLineDetails.SETFILTER("Document Type", 'Credit Memo');
             PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Header"."No.");
             PostedStrOrderLineDetails.SETFILTER("Tax/Charge Type", '<>%1', PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
             IF PostedStrOrderLineDetails.FINDSET THEN
                 REPEAT
                     Amt2 += PostedStrOrderLineDetails.Amount;
                 UNTIL
                 PostedStrOrderLineDetails.NEXT = 0;

             PostedStrOrderLineDetails.RESET;
             PostedStrOrderLineDetails.SETFILTER(Type, 'Sale');
             PostedStrOrderLineDetails.SETFILTER("Document Type", 'Credit Memo');
             PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Header"."No.");
             PostedStrOrderLineDetails.SETRANGE("Tax/Charge Type", PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
             IF PostedStrOrderLineDetails.FINDSET THEN
                 REPEAT
                     Amt += PostedStrOrderLineDetails.Amount;
                 UNTIL
                 PostedStrOrderLineDetails.NEXT = 0;
             Amt1 := Amt - InvDisc - InsuranceAmt;

             PostedStrOrderLineDetails.RESET;
             PostedStrOrderLineDetails.SETFILTER(Type, 'Sale');
             PostedStrOrderLineDetails.SETFILTER("Document Type", 'Credit Memo');
             PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Header"."No.");
             PostedStrOrderLineDetails.SETFILTER("Tax/Charge Type", '%1', PostedStrOrderLineDetails."Tax/Charge Type"::"Sales Tax");
             IF PostedStrOrderLineDetails.FINDSET THEN
                 REPEAT
                     SaleTax += PostedStrOrderLineDetails.Amount;
                 UNTIL
                 PostedStrOrderLineDetails.NEXT = 0;
             PostedStrOrderLineDetails.RESET;
             PostedStrOrderLineDetails.SETFILTER(Type, 'Sale');
             PostedStrOrderLineDetails.SETFILTER("Document Type", 'Credit Memo');
             PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Sales Cr.Memo Header"."No.");
             PostedStrOrderLineDetails.SETFILTER("Tax/Charge Type", '%1', PostedStrOrderLineDetails."Tax/Charge Type"::Excise);
             IF PostedStrOrderLineDetails.FINDSET THEN
                 REPEAT
                     Excise += PostedStrOrderLineDetails.Amount;
                 UNTIL
                 PostedStrOrderLineDetails.NEXT = 0;

             Amt3 := Amt1 + Amt2;

             SaleCredMemoLine.RESET;
             SaleCredMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
             IF SaleCredMemoLine.FINDSET THEN BEGIN
                 REPEAT
                     DisAmt1 += SaleCredMemoLine.Amount;
                     tds += SaleCredMemoLine."Total TDS/TCS Incl SHE CESS";
                 UNTIL SaleCredMemoLine.NEXT = 0;
             END;

             NetAmt := DisAmt1 + InvDisc + InsuranceAmt + Amt3 - tds;
             RoundedAmt := ROUND(NetAmt);
             RndOff := RoundedAmt - NetAmt;
             CheckReport.InitTextVariable;
             CheckReport.FormatNoText(NoText, RoundedAmt, '');*/
            /*
            //MIPLRK 160719>>>
            CLEAR(SalesQTYCRT);
            CLEAR(SalesQTYSQMTR);
            CLEAR(SalesPriceSQMTR);
            IF "Sales Cr.Memo Header"."Applies-to Doc. Type" = "Sales Cr.Memo Header"."Applies-to Doc. Type"::Invoice THEN BEGIN
              IF "Sales Cr.Memo Header"."Applies-to Doc. No."<>'' THEN BEGIN
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.","Sales Cr.Memo Header"."Applies-to Doc. No.");
                IF SalesInvoiceLine.FINDFIRST THEN REPEAT
                SalesQTYCRT := SalesInvoiceLine."Quantity in Cartons";
                SalesQTYSQMTR := SalesInvoiceLine."Quantity in Sq. Mt.";
                SalesPriceSQMTR := SalesInvoiceLine."Buyer's Price"/SalesInvoiceLine."Qty. per Unit of Measure";
                UNTIL SalesInvoiceLine.NEXT = 0;
              END;
            END;


        end;

        trigger OnPreDataItem()
        begin
            CompInfo.GET();
        end;*///16225 Dataitem Table N/F end
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

        IF COMPANYNAME = 'Orient Bell Limited' THEN
            CompanyName1 := 'Orient Bell Limited';
    end;

    var
        CustLedEntry: Record "Cust. Ledger Entry";
        SCML: Record "Sales Cr.Memo Line";
        TotalLineAmt: Decimal;
        RoundOff: Decimal;
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
        customer: Record Customer;
        CompInfo: Record "Company Information";
        RndOff: Decimal;
        CheckReport: Report "Check Report";
        NoText: array[2] of Text[80];
        GenLegSetup: Record "General Ledger Setup";
        //16225 PostedStrOrderLineDetails: Record "13798";
        ChargeAmt: Decimal;
        SalesTaxAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        InsuranceAmt: Decimal;
        ExciseAmt: Decimal;
        InvDisc: Decimal;
        DiscAmt: Decimal;
        NetAmt: Decimal;
        TotalAmt: Decimal;
        Amt: Decimal;
        tds: Decimal;
        Location: Record Location;
        StDESC: Text[100];
        State1: Record State;
        CompanyName1: Text[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        TextAddress1: Label 'Regd. office:  8 Ind Area Sikandrabad';
        TextAddress2: Label ' Distt. Bulandshahr, Uttar Pradesh';
        TextCity: Label '  SIKANDRABAD.';
        TextPhone: Label '  Phone: 011 47119100  Fax: 011 28521273';
        TextCIN: Label '  PAN - AAACO0305P, CIN No. L14101UP1977PLC021546';
        DisAmt1: Decimal;
        InsuranceAmt1: Decimal;
        InvDisc1: Decimal;
        Amt1: Decimal;
        Amt2: Decimal;
        Amt3: Decimal;
        SaleCredMemoLine: Record "Sales Cr.Memo Line";
        RoundedAmt: Decimal;
        SaleTax: Decimal;
        Excise: Decimal;
        GSTLedgerEntry: Record "GST Ledger Entry";
        Location2: Record Location;
        State2: Record State;
        StateName: Text;
        CountryName: Text;
        CountryRegion: Record "Country/Region";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesQTYCRT: Decimal;
        SalesQTYSQMTR: Decimal;
        SalesPriceSQMTR: Decimal;
        TotalTCS: Decimal;
}

