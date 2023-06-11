report 50318 "Tradingtran Invoicenew"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\TradingtranInvoicenew.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(DocNoNew; DocNoNew)
            {
            }
            column(PosDate; FORMAT("Transfer Shipment Header"."Posting Date"))
            {
            }
            column(LRRRNo_TransferShipmentHeader; "Transfer Shipment Header"."LR/RR No.")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(TruckNo_TransferShipmentHeader; "Transfer Shipment Header"."Truck No.")
            {
            }
            column(vname; vname)
            {
            }
            //16225  column(LocTIN; RecLoc."T.I.N. No.")
            column(LocTIN; RecLoc."T.A.N. No.")
            {
            }
            column(LocCST; RecLoc."C.S.T. No.")
            {
            }
            column(GRNo; "Transfer Shipment Header"."GR No.")
            {
            }
            column(GRDate; "Transfer Shipment Header"."GR Date")
            {
            }
            column(Pay_TransferShipmentHeader; "Transfer Shipment Header".Pay)
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(PageBreak1; FORMAT(PageBreak1))
                {
                }
                column(PageCont; FORMAT(PageCont))
                {
                }
                column(Sno; "S.No.")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }
                column(Description2_TransferShipmentLine; "Transfer Shipment Line"."Description 2")
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(QtyinSQM; QtyinSQM)
                {
                }
                //  column(MRPPrice_TransferShipmentLine; "Transfer Shipment Line"."MRP Price")
                column(MRPPrice_TransferShipmentLine; "Transfer Shipment Line"."Unit Price")
                {
                }
                column(AsseableValue; AsseableValue)
                {
                }
                column(BuyersRatePerSqMtr; BuyersRatePerSqMtr)
                {
                }
                column(Value; Value)
                {
                }
                column(TextContinue; TextContinue)
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }
                column(Text13705; Text13705)
                {
                }
                column(Text13706; Text13706)
                {
                }
                column(wt1; wt1)
                {
                }
                column(NetVal; NetVal)
                {
                }
                column(TotalChargerAmt; TotalChargerAmt)
                {
                }
                column(ECessAmt_Round; ROUND((ECessAmt), 1, '='))
                {
                }
                column(Hecess_Round; ROUND(Hecess, 1, '='))
                {
                }
                column(BEDAmt_Round; ROUND(BEDAmt, 1, '='))
                {
                }
                column(Policy; Policy)
                {
                }
                column(RoundOff_Round; ROUND((Value + TotalChargerAmt + InsuranceAmt), 1, '=') - (Value + TotalChargerAmt + InsuranceAmt))
                {
                }
                column(OtherTaxes; OtherTaxes)
                {
                }
                column(VATAmt; VATAmt)
                {
                }
                column(AmountinWord1_1; AmountinWord1[1])
                {
                }
                column(AmountinWord1_2; AmountinWord1[2])
                {
                }
                column(TSQty; TSQty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "S.No." += 1;
                    Sno += 1;
                    IF (Sno - 1) MOD 14 = 0 THEN
                        PageBreak1 := (Sno - 1) / 14;

                    PageCont := ROUND(COUNT / 14, 1, '<');


                    IF "S.No." > 1 THEN
                        CLEAR(TSQty);

                    DocNoNew := CONVERTSTR("Transfer Shipment Line"."Document No.", '\', '/');

                    wt1 := "Transfer Shipment Line"."Gross Weight";
                    IF "S.No." = 15 THEN
                        CurrReport.NEWPAGE;
                    "S.No." += 1;
                    IF Item.GET("Item No.") THEN BEGIN
                        DimensionValue1.SETRANGE(Code, "Size Code");
                        IF DimensionValue1.FINDFIRST THEN;
                    END;


                    Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                    SqMt := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                    Pcsqty := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", Quantity), 1, '<');

                    //IF Cart <> 0 THEN
                    //  RateperCart := "Unit Price"*Quantity/Cart;

                    //IF Cart <> 0 THEN
                    //  DiscPerCart := "Line Discount Amount"/Cart;
                    //Value := Cart * (RateperCart - DiscPerCart);




                    //MSSS
                    //16225 Table N/F Start
                    /*  ExcisePostingSetup.RESET;
                      ExcisePostingSetup.SETRANGE("Excise Bus. Posting Group", "Excise Bus. Posting Group");
                      ExcisePostingSetup.SETRANGE("Excise Prod. Posting Group", "Excise Prod. Posting Group");
                      IF ("Posting Date" <> 0D) THEN
                          ExcisePostingSetup.SETRANGE("From Date", 0D, "Posting Date")
                      ELSE
                          ExcisePostingSetup.SETRANGE("From Date", 0D, WORKDATE);
                      IF ExcisePostingSetup.FIND('+') THEN BEGIN
                          "BED%" := ExcisePostingSetup."BED %";
                          "eCess%" := ExcisePostingSetup."eCess %";
                          "SHECess%" := ExcisePostingSetup."SHE Cess %";
                      END;*///16225 Table N/F End


                    QuantityinSqMt := Item.UomToSqm("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity);
                    QuantityinCartons := ROUND(Item.UomToCart("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity), 1, '<');
                    //NetWeight := Item.UomToWeight("Item No.","Unit of Measure Code","Transfer Shipment Line".Quantity);
                    IF "Transfer Shipment Line".Quantity > 0 THEN BEGIN
                        NetWeight := Item.UomToGrossWeight("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity);
                    END;
                    Pcs := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity), 1, '<');//-- 3. Tri30.0 PG 14112006

                    //16225   Value := Amount + "Transfer Shipment Line"."Excise Amount";
                    Value := Amount;
                    //16225 Table N/F Start
                    /* IF Quantity <> 0 THEN BEGIN
                         BEDAmt := BEDAmt + "BED Amount";
                         Hecess := Hecess + "SHE Cess Amount";
                         ECessAmt := ECessAmt + "eCess Amount"
                     END;*///16225 Table N/F End

                    //MSSS
                    LineStop := LineStop + 1;


                    vendor1.RESET;
                    vendor1.SETRANGE(vendor1."No.", "Transfer Shipment Header"."Transporter's Name");
                    IF vendor1.FIND('-') THEN
                        vname := vendor1.Name;

                    state1.RESET;
                    state1.SETRANGE(state1.Code, "Transfer Shipment Header"."Transfer-to State");
                    IF state1.FIND('-') THEN
                        stname := state1.Description;



                    IF "Quantity (Base)" <> 0 THEN
                        //16225 ExAmt := "Transfer Shipment Line"."Excise Amount" / "Transfer Shipment Line"."Quantity (Base)";
                        IF "Quantity (Base)" <> 0 THEN
                            BuyersRatePerSqMtr := (Amount / "Quantity (Base)") + ExAmt;
                    //16225 AsseableValue := "Transfer Shipment Line"."Assessable Value" * Quantity;

                    IF "Transfer Shipment Line"."Unit of Measure Code" = 'PCS.' THEN
                        QtyinSQM := ROUND("Transfer Shipment Line"."Qty in Sq. Mt.")
                    ELSE
                        QtyinSQM := ROUND("Transfer Shipment Line"."Quantity (Base)");
                    GrossWieght := Item."Gross Weight" * QtyinSQM;


                    IF "S.No." = 15 THEN BEGIN
                        CurrReport.SHOWOUTPUT(TRUE);
                        TextContinue := 'Continue....';
                    END ELSE BEGIN
                        CurrReport.SHOWOUTPUT(FALSE);
                        TextContinue := ''
                    END;



                    CheckReport.InitTextVariable;
                    //16225    CheckReport.FormatNoText(AmountinWord1, ROUND("Excise Amount", 1), '');
                    //------------------------------------
                    //CurrReport.SHOWOUTPUT("S.No.">15);//Msdr
                    NetVal := ROUND((Value + TotalChargerAmt + InsuranceAmt), 1, '=');
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(AmountinWord1, ROUND(NetVal, 1), '');
                end;

                trigger OnPreDataItem()
                begin
                    "S.No." := 0;



                    CurrReport.CREATETOTALS(AsseableValue, wt1);

                    //16225   CurrReport.CREATETOTALS(Value, "Transfer Shipment Line"."Assessable Value", QtyinSQM);//Msdr


                    CLEAR("S.No.");
                end;
            }
            /*  dataitem(DataItem1000000040; Table13798)//16225 Table N/F
              {
                  DataItemLink = Invoice No.=FIELD(No.);
                  DataItemTableView = SORTING (Tax/Charge Type, Charge Type)
                                      ORDER(Ascending)
                                      WHERE (Type = FILTER (Transfer));
                  column(OtherTaxes; OtherTaxes)
                  {
                  }
                  column(VATAmt; VATAmt)
                  {
                  }
                  column(AmountinWord1_1; AmountinWord1[1])
                  {
                  }
                  column(AmountinWord1_2; AmountinWord1[2])
                  {
                  }
                  column(TSQty; TSQty)
                  {
                  }

                  trigger OnAfterGetRecord()
                  begin

                      CASE "Tax/Charge Type" OF
                          "Tax/Charge Type"::Charges:
                              BEGIN
                                  CASE "Charge Type" OF
                                      "Charge Type"::" ", "Charge Type"::Freight, "Charge Type"::Commission:
                                          ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;
                                      "Charge Type"::Insurance:
                                          InsuranceAmt := "Posted Str Order Line Details".Amount;
                                  END;
                                  IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                      InvDisc := "Posted Str Order Line Details".Amount;
                              END;

                          "Tax/Charge Type"::"Sales Tax":
                              SalesTaxAmt := "Posted Str Order Line Details".Amount;
                          "Tax/Charge Type"::Excise:
                              ExciseAmt := "Posted Str Order Line Details".Amount;
                          "Tax/Charge Type"::"Other Taxes":
                              OtherTaxes := "Posted Str Order Line Details".Amount;
                          "Tax/Charge Type"::"Service Tax":
                              VATAmt := "Posted Str Order Line Details".Amount;
                      END;
                  end;
              }*/
            dataitem(InsRow; Integer)
            {
                column(IncRowas; IncRowas)
                {
                }
                column(BEDAmt; BEDAmt)
                {
                }
                column(ECessAmt; ECessAmt)
                {
                }
                column(Hecess; Hecess)
                {
                }
                column(SalesTaxAmt; SalesTaxAmt)
                {
                }
                column(ChargeAmt; ChargeAmt)
                {
                }
                column(InsuranceAmt; InsuranceAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IncRowas += 1;
                end;

                trigger OnPreDataItem()
                begin
                    IF Sno < 14 THEN
                        rowstogen := 14 - Sno
                    ELSE BEGIN
                        rowstogen := Sno - 14 * PageBreak1;
                        rowstogen := 14 - rowstogen;
                    END;

                    SETRANGE(Number, 1, rowstogen);//,rowstogen+3);
                    CLEAR(IncRowas)
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF "Posting Date" >= 20140107D THEN BEGIN//070114D
                    Policy := NewPolicy
                END ELSE
                    Policy := Text13704;

                IF Recvendor.GET("Transporter's Name") THEN;

                IF RecLoc.GET("Transfer Shipment Header"."Transfer-from Code") THEN
                    CST := RecLoc."C.S.T. No.";

                IF RecLoc.GET("Transfer Shipment Header"."Transfer-to Code") THEN
                    //16225 Table N/F Start
                    /*    PostedStrOrderLineDetails.RESET;
                    PostedStrOrderLineDetails.SETRANGE(PostedStrOrderLineDetails."Invoice No.", "Transfer Shipment Header"."No.");
                    PostedStrOrderLineDetails.SETRANGE("Charge Type", PostedStrOrderLineDetails."Charge Type"::Insurance);
                    PostedStrOrderLineDetails.SETRANGE("Tax/Charge Type", PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
                    IF PostedStrOrderLineDetails.FINDSET THEN BEGIN
                        REPEAT
                            InsuranceAmt += PostedStrOrderLineDetails.Amount;
                        UNTIL PostedStrOrderLineDetails.NEXT = 0;
                    END;*///16225 Table N/F End


                    CurrReport.SHOWOUTPUT("S.No." > 15);//Msdr
                NetVal := ROUND((Value + TotalChargerAmt + InsuranceAmt), 1, '=');
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(AmountinWord, ROUND(NetVal, 1), '');

                TSQty := InsuranceAmt;
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
        //RepAuditMgt.CreateAudit(50317)
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        // PostedDocDim1: Record 359;
        // PostedDocDim2: Record 359;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        OrderNoText: Text[100];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Decimal;
        NoOfLoops: Integer;
        CopyText: Text[100];
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
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        //16225  PostedStrOrderLineDetails: Record "13798";
        "Corp-Addition------------": Integer;
        TccChargeAmount: Decimal;
        ChargePercentTCC: Decimal;
        BEDChargeAmount: Decimal;
        ChargePercentBED: Decimal;
        EcessChargeAmount: Decimal;
        ChargePercentEcess: Decimal;
        InsurenceChargeAmount: Decimal;
        ChargePercentIns: Decimal;
        CSTchargeAmount: Decimal;
        ChargePercentCST: Decimal;
        FrightChargeAmt: Decimal;
        SalesHeader: Record "Sales Header";
        BillToAddr: array[8] of Text[80];
        TempSalesLine: Record "Sales Line" temporary;
        AgentName: Text[40];
        SalesPersonRec: Record "Salesperson/Purchaser";
        CheckReport: Report "Check Report";
        NumberText: array[2] of Text[80];
        NumberText1: array[2] of Text[80];
        NumberText2: array[2] of Text[80];
        NumberText3: array[2] of Text[80];
        NumberText5: array[2] of Text[80];
        NumberText4: array[2] of Text[80];
        GenJnlLine: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        Amt: Decimal;
        GTotal: Decimal;
        StateTable: Record State;
        StateDescription: Text[50];
        Location: Record Location;
        LocName: Text[50];
        LocAddress: Text[50];
        LocAddress2: Text[50];
        LocCity: Text[50];
        LocPhone: Text[30];
        "LocE-mail": Text[80];
        LocRst: Code[30];
        LocCst: Code[30];
        LocTin: Code[20];
        LocState: Text[30];
        "Cust TIN": Code[20];
        "Cust LST": Code[20];
        "Cust CST": Code[20];
        CompInfo: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        Unit: Text[30];
        Hecess: Decimal;
        Hecesspercent: Decimal;
        Excisetotal: Decimal;
        Disctotal: Decimal;
        Item: Record Item;
        LotNo: Code[20];
        Bagtotal: Integer;
        salesinvoiceline: Record "Sales Invoice Line";
        Kgtotal: Decimal;
        Locpin: Code[10];
        ShippingAgent: Record "Shipping Agent";
        Shipingdes: Text[50];
        Cust1: Record Customer;
        challanno: Code[20];
        Salesshipment: Record "Sales Shipment Header";
        SalesInvoiceLine1: Record "Sales Invoice Line";
        TotalBed: Decimal;
        TotalEcess: Decimal;
        TotalShcess: Decimal;
        TotalTradeDisc: Decimal;
        TotalCashDic: Decimal;
        "AddCst/Vat": Option " ",VAT,CST;
        TaxArea: Record "Tax Area";
        TaxLineArea: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        Location2: Record Location;
        IntRate: Decimal;
        Intdays: Text[50];
        Complaindays: Text[30];
        Juridiction: Text[30];
        InvoiceNotification: Text[200];
        Insurance: Text[100];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        PaymentTerm: Text[50];
        ShipmentDes: Text[50];
        DueDate: Date;
        VatChargeAmount: Decimal;
        SalesInvoiceLine3: Record "Sales Invoice Line";
        A: Code[10];
        VatPercentAmount: Decimal;
        InvoiceDicount: Decimal;
        Customer: Record Customer;
        CustECCNo: Code[20];
        CustRange: Code[200];
        CustCommissionerate: Code[200];
        CustPANNo: Code[20];
        "CST%": Text[30];
        "VAT%": Text[30];
        "InvoiceDisc%": Text[30];
        "Insurance%": Text[30];
        "Cust.InvoiceDisc.": Record "Cust. Invoice Disc.";
        "TradeDic%": Text[30];
        TradePercente: Decimal;
        SalesInvoiceHeader4: Record "Sales Invoice Header";
        ShiptoAddress: Record "Ship-to Address";
        ShipEccNo: Code[20];
        ShipregNo: Code[20];
        ShipRange: Code[20];
        ShipCommissionerate: Code[20];
        ShipPanNo: Code[20];
        Customer1: Record Customer;
        BaleCharges: Decimal;
        LabourCharges: Decimal;
        OtherCharges: Decimal;
        "S.No.": Integer;
        TotalLineAmount: Decimal;
        CopyNo: Integer;
        PageTitle: Text[30];
        VAT: Code[20];
        //16225 ExcisePostingSetup: Record "13711";
        "BED%": Decimal;
        "eCess%": Decimal;
        "SHECess%": Decimal;
        SIL: Record "Sales Invoice Line";
        TraiffNo: Code[20];
        SalesOrderNo: Code[20];
        AmountinWord: array[2] of Text[100];
        GrandTotal: Decimal;
        Respcent: Record "Responsibility Center";
        RespCntrAddr: array[15] of Text[250];
        NoInText: array[10] of Text[250];
        ExInText: array[10] of Text[50];
        //16225 ExcisePGP: Record "13710";
        BarCodeRequired: Boolean;
        SIH: Record "Sales Invoice Header";
        txt: Text[100];
        Range: Text[100];
        Division: Text[100];
        LineStop: Integer;
        Exessiblegoods: Decimal;
        //16225 "Excise Prod.Posting Group": Record "13710";
        Desc: Text[60];
        NOOFPKG: Decimal;
        //16225 ExciseProdPostingGroup: Record "13710";
        QTYPERPKG: Decimal;
        CLE: Record "Cust. Ledger Entry";
        VendorCode: Code[20];
        SINC: Record "Sales Invoice Line";
        Type1: Code[20];
        ItemPartNo: array[600] of Code[20];
        MSFNo: Code[20];
        SIHeader: Record "Sales Invoice Header";
        Roundoff: Decimal;
        Value: Decimal;
        Cart: Decimal;
        SqMt: Decimal;
        Wt: Decimal;
        LineDiscount: Decimal;
        DiscPerCart: Decimal;
        RateperCart: Decimal;
        Pcs: Decimal;
        BEDAmt: Decimal;
        ECess: Decimal;
        Pcsqty: Decimal;
        BuyersPrice: Decimal;
        BuyersRatePerSqMtr: Decimal;
        DiscPerSqmt: Decimal;
        Outstand: Decimal;
        QD: Decimal;
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        AQD: Decimal;
        AmountinWord1: array[2] of Text[100];
        Recvendor: Record Vendor;
        DeleveryAdd: array[4] of Text[30];
        TextContinue: Text[30];
        AqdText: Text[30];
        QdText: Text[30];
        DimensionValue1: Record "Dimension Value";
        RecLoc: Record Location;
        AsseableValue: Decimal;
        QtyinSQM: Decimal;
        "------------------------------": Integer;
        SalesTaxAmt: Decimal;
        ChargeAmt: Decimal;
        InsuranceAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        TotalChargerAmt: Decimal;
        NetVal: Decimal;
        ECessAmt: Decimal;
        QuantityinSqMt: Decimal;
        QuantityinCartons: Decimal;
        NetWeight: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        InvDisc: Decimal;
        ExciseAmt: Decimal;
        Taxtotal: Decimal;
        vendor1: Record Vendor;
        vname: Text[50];
        state1: Record State;
        stname: Text[50];
        GrossWieght: Decimal;
        ExAmt: Decimal;
        wt1: Decimal;
        CST: Text[50];
        Policy: Text[200];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        Text13706: Label 'Assesable Value is calculated @ 55% of MRP';
        Text13705: Label 'Freight :';
        Text13704: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        DocNoNew: Code[20];
        TSQty: Decimal;
        Sno1: Integer;
        Sno: Integer;
        rowstogen: Integer;
        IncRowas: Integer;
        PageBreak1: Integer;
        PageCont: Integer;
}

