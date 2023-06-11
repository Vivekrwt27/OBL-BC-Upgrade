report 50138 "Commercial Invoice Nepal"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CommercialInvoiceNepal1.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            RequestFilterFields = "No.";
            column(TermsofDelivery; TermsofDelivery)
            {
            }
            column(PlaceofDischargeCustom; PlaceofDischargeCustom)
            {
            }
            column(PlaceofFianlDelivery; PlaceofFianlDelivery)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(Outstand; Outstand)
            {
            }
            column(Phone; 'Phone No : 28521206,11')
            {
            }
            column(Fax; 'Fax : 28521273')
            {
            }
            column(Company_Name; CompanyName1)
            {
            }
            column(Address; Address)
            {
            }
            column(LocGSTIN; LocGSTIN)
            {
            }
            column(LocCity; LocCity + ', ( ' + LocState + '),  ' + LocCountry)
            {
            }
            column(TransportBy; TransportMethod.Description)
            {
            }
            column(Invoice_No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(CommercialInvoice; 'Retail/Sale/Commercial Invoice')
            {
            }
            column(GroupCodeDescription2; GroupCode.Description + ' ' + GroupCode.Description2)
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SellToCustomerName2; "Sell-to Customer Name 2")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SellToCity; "Sell-to City" + ' - ' + "State name")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(Sell; "Sell-to City")
            {
            }
            column(DestinationCountry; "State name")
            {
            }
            column(CINNo; 'CIN No. L14101UP1977PLC021546')
            {
            }
            column(GRNo; "GR No.")
            {
            }
            column(GRDate; "GR Date")
            {
            }
            column(LST_No; LST)
            {
            }
            column(CST_No; CST)
            {
            }
            column(TransporterName; "Transporter Name")
            {
            }
            column(ShipToName2; "Sales Invoice Header"."Ship-to Name 2")
            {
            }
            column(ShipToAddress; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShipToAddress2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City" + ' - ' + "Ship-to Post Code")
            {
            }
            column(Statename; "State name")
            {
            }
            column(TINNo; "TINNo.")
            {
            }
            column(Location_CSTNo; Location."C.S.T. No.")
            {
            }
            column(Customer_PANNo; Customer."P.A.N. No.")
            {
            }
            column(Customer_TINNo; Customer."Customer Type") // 16630 replace here T.I.N. No.
            {
            }
            column(EximCode; Customer."Customer Type") // 16630 replace here E.C.C. No.
            {
            }
            column(GR_No; "GR No.")
            {
            }
            column(GR_Date; "GR Date")
            {
            }
            column(NoText11; NoText[1])
            {
            }
            column(NoText22; NoText[2])
            {
            }
            column(Rs1; 'Rs' + ' ' + FORMAT(Outstand) + ' ' + '(' + 'Including this Invoice' + ')')
            {
            }
            column(policy11; policy)
            {
            }
            column(SubTotal11; SubTotal + Taxtotal - InvDisc - InsDisc - ROUND("Sales Invoice Line".Amount, 1, '=')) // 16630 replace here Excise Amount
            {
            }
            column(A; 0.0)
            {
            }
            column(SubTotal111; ROUND((SubTotal + Taxtotal - InvDisc - InsDisc), 1, '=') - ROUND("Sales Invoice Line".Amount, 1, '='))// 16630 replace here Excise Amount
            {
            }
            column(LCIssueBank; LCIssueBank)
            {
            }
            column(IssueDate; IssueDate)
            {
            }
            column(ImpExpCode; RecLocation.IEC)
            {
            }
            column(ILCNo; ILCNo)
            {
            }
            column(ILCDate; ILCDate)
            {
            }
            column(PINo; PINo)
            {
            }
            column(PIDate; PIDate)
            {
            }
            column(ExporterBankAccountNo; ExporterBankAccountNo)
            {
            }
            column(ExporterBankName; ExporterBankName)
            {
            }
            column(ExporterBankAdd1; ExporterBankAdd1)
            {
            }
            column(ExporterBankAdd2; ExporterBankAdd2)
            {
            }
            column(ExporterBankCity; ExporterBankCity)
            {
            }
            column(ExporterBankPostCode; ExporterBankPostCode)
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0), Type = const(Item));
                column(HSNSACCode; "HSN/SAC Code")
                {
                }
                column(ItemDesc; RecItem."Complete Description")
                {
                }
                column(ItemPacking; RecItem."Packing Code Desc.")
                {
                }
                column(ItemSize; RecItem."Size Code Desc.")
                {
                }
                column(BuyersPrice; "Buyer's Price")
                {
                }
                column(ItemSizeDesc; RecItem."Size Description")
                {
                }
                column(SubTotalNew1; SubTotalNew1)
                {
                }
                column(sno1; sno)
                {
                }
                column(Description; Description + ' ' + "Description 2")
                {
                }
                column(TypeDesc1; TypeDesc)
                {
                }
                column(Quantity1; Quantity)
                {
                }
                column(UnitofMeasureCode; "Unit of Measure Code")
                {
                }
                column(Sqmt1; Sqmt)
                {
                }
                column(DiscPerSqmt1; DiscPerSqmt)
                {
                }
                column(BuyersRatePerSqMtr1; BuyersRatePerSqMtr)
                {
                }
                column(SaleInvoiceLineMRPPrice; "Sales Invoice Line"."MRP Price")
                {
                }
                column(Value; Value)
                {
                }
                column(Cart1; Cart)
                {
                }
                column(Pcsqty; Pcsqty)
                {
                }
                column(GrossWeight; "Gross Weight")
                {
                }
                column(PhoneNo; 'E-Mail:customercare@orientbell.com, Website:www.orientbell.com')
                {
                }
                column(OtherTaxes1; OtherTaxes)//16630
                {
                }
                column(VATAmt1; VATAmt)
                {
                }
                column(FormCode1; FormCode)
                {
                }
                column(JudText1; JudText[1])
                {
                }
                column(FORMAT; FORMAT(PerJud[1]) + ' %')
                {
                }
                column(QdText1; QdText)
                {
                }
                column(AqdText1; AqdText)
                {
                }
                column(QcText1; QcText)
                {
                }
                column(QD1; QD)
                {
                }
                column(AQD1; AQD)
                {
                }
                column(InsDisc; ABS(InsDisc))
                {
                }
                column(InvDisc; ABS(InvDisc))
                {
                }
                column(SubTotal2; SubTotal)
                {
                }
                column(SalesTaxAmt1; SalesTaxAmt)
                {
                }
                column(ChargeAmt1; ABS("Sales Invoice Header"."Freight Amt"))
                {
                }
                column(InsuranceAmt1; Abs("Sales Invoice Header"."Insurance Amount"))
                {
                }
                column(FormNo1; FormNo)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(AmountInWords; NoText[1])
                {
                }
                column(Perjud; FORMAT(PerJud[1]) + ' %')
                {
                }


                trigger OnAfterGetRecord()
                begin


                    IF RecItem.GET("Sales Invoice Line"."No.") THEN;

                    Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                    Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                    Pcsqty := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<');
                    Wt := "Sales Invoice Line"."Gross Weight";

                    IF Quantity <> 0 THEN
                        // BuyersPrice := (Amount + "Excise Amount") / Quantity; 16630
                        BuyersPrice := Amount / Quantity;

                    IF Sqmt <> 0 THEN BEGIN
                        BuyersRatePerSqMtr := BuyersPrice * Quantity / Sqmt;
                        DiscPerSqmt := "Line Discount Amount" / Sqmt;
                    END;
                    IF "Quantity in Sq. Mt." <> 0 THEN BEGIN
                        DecRate := ("Quantity Discount Amount" / "Quantity in Sq. Mt.");
                        LineDis := ("Line Discount Amount" / "Quantity in Sq. Mt.");
                    END;
                    BuyersRatePerSqMtr += DecRate;

                    Value := (BuyersRatePerSqMtr * "Quantity in Sq. Mt.");

                    SubTotalNew1 += Value - "Inv. Discount Amount";

                    QD += "Quantity Discount Amount" - "Accrued Discount";
                    IF QD <> 0 THEN
                        QdText := 'QD DISCOUNT';
                    AQD += "Accrued Discount";
                    IF AQD <> 0 THEN
                        AqdText := 'AQD DISCOUNT';

                    TypeName := '';
                    SizeName := '';

                    InventorySetup.GET;
                    IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                        SizeName := DimensionValue.Name;
                    IF DimensionValue.GET(InventorySetup."Type Code", "Type Code") THEN
                        TypeName := DimensionValue.Name;
                    IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                        PackingName := DimensionValue.Name;

                    sno := sno + 1;

                    TypeDesc := '';
                    DimensionValue.RESET;
                    DimensionValue.SETFILTER("Dimension Code", '=%1', 'CATG');
                    DimensionValue.SETRANGE(Code, "Type Catogery Code");
                    IF DimensionValue.FINDFIRST THEN
                        TypeDesc := DimensionValue.Name;

                    SubTotal := Value - "Inv. Discount Amount";

                    /* 16630 ExciseAmt := "Sales Invoice Line"."Excise Amount";
                    BEDAmt := "Sales Invoice Line"."BED Amount";
                    ECessAmt := "Sales Invoice Line"."eCess Amount";
                    ExAmt += "Sales Invoice Line"."Excise Amount";*/ // 16630
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(Value, Cart, Sqmt, Wt, Pcsqty);

                end;
            }
            /* 16630 dataitem(DataItem1000000002; 13798)
             {
                 DataItemLink = "Invoice No." = FIELD("No.");
                 DataItemTableView = SORTING("Tax/Charge Type", "Tax/Charge Code")
                                     ORDER(Ascending)
                                     WHERE(Type = FILTER(Sale),
                                           "Document Type" = FILTER(Invoice));
                 column(OtherTaxes1; OtherTaxes)
                 {
                 }
                 column(VATAmt1; VATAmt)
                 {
                 }
                 column(FormCode1; FormCode)
                 {
                 }
                 column(JudText1; JudText[1])
                 {
                 }
                 column(FORMAT; FORMAT(PerJud[1]) + ' %')
                 {
                 }
                 column(QdText1; QdText)
                 {
                 }
                 column(AqdText1; AqdText)
                 {
                 }
                 column(QcText1; QcText)
                 {
                 }
                 column(QD1; QD)
                 {
                 }
                 column(AQD1; AQD)
                 {
                 }
                 column(InsDisc; ABS(InsDisc))
                 {
                 }
                 column(InvDisc; ABS(InvDisc))
                 {
                 }
                 column(SubTotal2; SubTotal)
                 {
                 }
                 column(SalesTaxAmt1; SalesTaxAmt)
                 {
                 }
                 column(ChargeAmt1; ChargeAmt)
                 {
                 }
                 column(InsuranceAmt1; InsuranceAmt)
                 {
                 }
                 column(FormNo1; FormNo)
                 {
                 }
                 column(GrandTotal; GrandTotal)
                 {
                 }
                 column(AmountInWords; NoText[1])
                 {
                 }
                 column(Perjud; FORMAT(PerJud[1]) + ' %')
                 {
                 }

                 trigger OnAfterGetRecord()
                 begin
                     TempCount += 1;

                     GenLegSetup.GET;
                     CASE "Tax/Charge Type" OF
                         "Tax/Charge Type"::Charges:
                             BEGIN
                                 CASE "Charge Type" OF
                                     "Charge Type"::" ", "Charge Type"::Freight, "Charge Type"::Commission:
                                         IF ("Tax/Charge Group" <> GenLegSetup."Discount Charge") AND
                                          ("Tax/Charge Group" <> GenLegSetup.AddInsuranceDisc) THEN
                                             ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;
                                     "Charge Type"::Insurance:
                                         InsuranceAmt += "Posted Str Order Line Details".Amount;
                                 END;
                                 IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                     InvDisc += "Posted Str Order Line Details".Amount;
                                 IF "Tax/Charge Group" = GenLegSetup.AddInsuranceDisc THEN
                                     InsDisc += "Posted Str Order Line Details".Amount;
                             END;
                         "Tax/Charge Type"::"Sales Tax":
                             SalesTaxAmt += "Posted Str Order Line Details".Amount;
                         "Tax/Charge Type"::"Other Taxes":
                             OtherTaxes += "Posted Str Order Line Details".Amount;
                         "Tax/Charge Type"::"Service Tax":
                             VATAmt += "Posted Str Order Line Details".Amount;
                         "Tax/Charge Type"::Excise:
                             OtherTaxes += "Posted Str Order Line Details".Amount;
                     END;

                     IF InsDisc = 0 THEN
                         QcText := ''
                     ELSE
                         QcText := 'Qc Discount';

                     IF "Sales Invoice Header"."Free Supply" = FALSE THEN BEGIN
                         ExciseText[1] := ExciseAmt;
                         ExciseLabel[1] := 'Excise';
                         Taxtotal := Amount;
                         ExciseText[2] := 0;
                         ExciseLabel[2] := '';
                     END ELSE BEGIN
                         ExciseText[2] := ExciseAmt;
                         ExciseLabel[2] := 'Excise';
                         Taxtotal := Amount - ExciseAmt;
                         ExciseText[1] := 0;
                         ExciseLabel[1] := '';
                     END;

                     FOR i := 1 TO 3 DO BEGIN
                         JudText[i] := '';
                         PerJud[i] := 0;
                     END;
                     i := 0;
                     SalesInvLine1.RESET;
                     SalesInvLine1.SETFILTER(SalesInvLine1."Document No.", '%1', "Sales Invoice Header"."No.");
                     SalesInvLine1.SETFILTER(SalesInvLine1."Tax Liable", '%1', TRUE);
                     IF SalesInvLine1.FIND('-') THEN BEGIN
                         TaxAreaLine.RESET;
                         TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area", '%1', SalesInvLine1."Tax Area Code");
                         IF TaxAreaLine.FIND('-') THEN
                             REPEAT
                                 i := i + 1;
                                 TaxDetails.RESET;
                                 TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code", '%1', TaxAreaLine."Tax Jurisdiction Code");
                                 TaxDetails.SETFILTER(TaxDetails."Tax Group Code", '%1', SalesInvLine1."Tax Group Code");
                                 TaxDetails.SETFILTER(TaxDetails."Form Code", '%1', "Sales Invoice Header"."Form Code");
                                 TaxDetails.SETFILTER(TaxDetails."Effective Date", '..%1', "Sales Invoice Header"."Posting Date");
                                 IF TaxDetails.FIND('+') THEN
                                     IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
                                         JudText[i] := TaxDetails."Tax Jurisdiction Code";
                                         PerJud[i] := TaxDetails."Tax Below Maximum";
                                     END;
                             UNTIL TaxAreaLine.NEXT = 0;
                     END;

                     SalesInvLine1.RESET;
                     SalesInvLine1.SETFILTER(SalesInvLine1."Document No.", '%1', "Sales Invoice Header"."No.");
                     IF SalesInvLine1.FIND('-') THEN
                         tgVat := SalesInvLine1."VAT %";
                     IF TempCount = COUNT THEN BEGIN
                         GrandTotal := ROUND((SubTotalNew1 + Taxtotal - InvDisc - InsDisc + InsuranceAmt + ChargeAmt), 1, '=') - ROUND(ExAmt, 1, '=');
                         CheckReport.InitTextVariable;
                         CheckReport.FormatNoText(NoText, ROUND((GrandTotal), 1, '='), '');
                     END
                 end;

                 trigger OnPreDataItem()
                 begin
                     CLEAR(TempCount);
                 end;
             }*/

            trigger OnAfterGetRecord()
            begin
                IF "Sales Invoice Header"."Currency Code" <> '' THEN
                    CurrCode := "Sales Invoice Header"."Currency Code" + ' Only'
                ELSE
                    CurrCode := 'Rupees and Zero Paisa Only';

                RecLocation.RESET;
                IF "Sales Invoice Header"."Location Code" <> '' THEN
                    IF RecLocation.GET("Sales Invoice Header"."Location Code") THEN;

                IF Location.GET("Location Code") THEN BEGIN
                    Address := Location.Address + Location."Address 2" + ' ' + Location.City;
                    Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                    Fax := Location."Fax No.";
                    LocCity := Location.City;
                    IF Location."State Code" <> '' THEN
                        IF RecState.GET(Location."State Code") THEN
                            LocState := RecState.Description;
                    IF Location."Country/Region Code" <> '' THEN
                        IF CountryRegion.GET(Location."Country/Region Code") THEN
                            LocCountry := CountryRegion.Name;
                    LocGSTIN := 'GST No. ' + Location."GST Registration No.";
                END;

                IF "Sales Invoice Header"."Transport Method" <> '' THEN
                    IF TransportMethod.GET("Sales Invoice Header"."Transport Method") THEN;

                GroupCode.SETRANGE(GroupCode."Group Code", "Sales Invoice Header"."Group Code");
                IF GroupCode.FIND('-') THEN
                    Location.RESET;
                Location.SETRANGE(Code, "Location Code");
                IF Location.FINDFIRST THEN
                    //16630 HeaderTextLatest := DocumentPrint.PrintInvoiceType("Sales Invoice Header", Location);

                    IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                        //16630LST := Customer."L.S.T. No.";
                        //16630CST := Customer."C.S.T. No.";
                        //EximCode := Customer."E.C.C. No.";
                        Customer.CALCFIELDS(Customer.Balance);
                        Outstand := ROUND((Customer.Balance), 1, '=');
                    END;

                IF "Posting Date" >= 20140107D THEN BEGIN
                    policy := NewPolicy
                END ELSE
                    policy := Text13704;

                SubTotal := 0;
                CLEAR(ExciseText);
                CLEAR(ExciseLabel);
                ExciseAmt := 0;
                BEDAmt := 0;
                ECessAmt := 0;
                FormCode := '';
                FormNo := '';
                ChargeAmt := 0;
                SalesTaxAmt := 0;
                OtherTaxes := 0;
                VATAmt := 0;
                InsuranceAmt := 0;
                /* 
                                 IF FormCodes.GET("Form Code") THEN BEGIN
                                     FormCode := 'Against ' + FormCodes.Description;
                                     FormNo := 'Form No. ' + "Form No.";
                                 END;

                                 IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                                     LST := Customer."L.S.T. No.";
                                     CST := Customer."C.S.T. No.";
                                     CustomerTINNo := Customer."T.I.N. No.";
                                 END;
                                 sno := 0;

                                 IF tin_no1.GET(Location."T.I.N. No.") THEN
                                     "TINNo." := tin_no1.Description; */

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoTextExcise, ExciseAmt, '');

                CompanyInfo.GET;
                WorkAddress := 'Works    : ' + CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo.City;

                CLEAR(TermsofDelivery);
                CLEAR(PlaceofDischargeCustom);
                CLEAR(PlaceofFianlDelivery);
                //CLEAR(EximCode);
                CLEAR(IssueDate);
                CLEAR(ILCNo);
                CLEAR(ILCDate);
                CLEAR(LCIssueBank);
                CLEAR(PINo);
                CLEAR(PIDate);
                LCDetailforExport.RESET;
                LCDetailforExport.SETCURRENTKEY("LC No.");
                LCDetailforExport.SETRANGE("Customer Code", "Sales Invoice Header"."Sell-to Customer No.");
                //16630 LCDetailforExport.SETRANGE("LC No.", "Sales Invoice Header"."LC No.");
                IF LCDetailforExport.FINDFIRST THEN BEGIN
                    TermsofDelivery := LCDetailforExport."Terms of Delivery";
                    PlaceofDischargeCustom := LCDetailforExport."Place of Discharge";
                    PlaceofFianlDelivery := LCDetailforExport."Plant of Final Distenation";
                    //EximCode := LCDetailforExport."Customer Exim Code";
                    IssueDate := LCDetailforExport."Issueing Date";
                    ILCNo := LCDetailforExport."LC No.";
                    ILCDate := LCDetailforExport."LC Date";
                    LCIssueBank := LCDetailforExport."LC Issuing Bank";
                    PINo := LCDetailforExport."Proforma Invoice";
                    PIDate := LCDetailforExport."Proforma Invoice Date";
                    BankAccount.RESET;
                    IF LCDetailforExport."Exporter Bank Detail" <> '' THEN
                        IF BankAccount.GET(LCDetailforExport."Exporter Bank Detail") THEN BEGIN
                            ExporterBankAccountNo := BankAccount."Bank Account No.";
                            ExporterBankName := BankAccount.Name;
                            ExporterBankAdd1 := BankAccount.Address;
                            ExporterBankAdd2 := BankAccount."Address 2";
                            ExporterBankCity := BankAccount.City;
                            ExporterBankPostCode := BankAccount."Post Code";
                        END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
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

    var
        Customer: Record Customer;
        RateperCart: Decimal;
        DiscPerCart: Decimal;
        Item: Record Item;
        RecItem: Record Item;
        Value: Decimal;
        SubTotal: Decimal;
        Taxtotal: Decimal;
        Netamt: Decimal;
        Location: Record Location;
        Address: Text[250];
        LocCity: Text[100];
        LocState: Text[100];
        LocCountry: Text[100];
        Ph: Text[100];
        Fax: Text[100];
        LocGSTIN: Text[30];
        OurTIN: Code[50];
        CheckReport: Report "Check Report";
        NoText: array[2] of Text[80];
        ExciseAmt: Decimal;
        NoTextExcise: array[2] of Text[80];
        LST: Code[100];
        CST: Code[100];
        CustomerTINNo: Text[30];
        ChargeAmt: Decimal;
        SalesTaxAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        InsuranceAmt: Decimal;
        BEDAmt: Decimal;
        ECessAmt: Decimal;
        FormCode: Text[50];
        FormNo: Text[50];
        // 16630 FormCodes: Record 13756;
        ExciseLabel: array[2] of Text[50];
        ExciseText: array[2] of Decimal;
        sno: Integer;
        GenLegSetup: Record "General Ledger Setup";
        InvDisc: Decimal;
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        "TINNo.": Text[30];
        TypeName: Text[50];
        SizeName: Text[50];
        PackingName: Text[50];
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        WorkAddress: Text[250];
        PhoneNo: Integer;
        Cart: Decimal;
        Sqmt: Decimal;
        Wt: Decimal;
        DiscPerSqmt: Decimal;
        BuyersPrice: Decimal;
        BuyersRatePerSqMtr: Decimal;
        // 16630 tin_no1: Record 13701;
        i: Integer;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        SalesInvLine1: Record "Sales Invoice Line";
        tgVat: Decimal;
        GroupCode: Record "Item Group";
        TypeDesc: Text[30];
        Pcsqty: Decimal;
        Outstand: Decimal;
        CompanyName2: Text[50];
        HeaderTextLatest: Text[100];
        DocumentPrint: Codeunit "Document-Print";
        DecRate: Decimal;
        LineDis: Decimal;
        QD: Decimal;
        AQD: Decimal;
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        QdText: Text[50];
        AqdText: Text[50];
        InsDisc: Decimal;
        QcText: Text[30];
        policy: Text[200];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text13704: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        TempCount: Integer;
        GrandTotal: Decimal;
        SubTotalNew1: Decimal;
        ExAmt: Decimal;
        CurrCode: Text[50];
        TransportMethod: Record "Transport Method";
        PlaceofDischargeCustom: Text[250];
        PlaceofFianlDelivery: Text[250];
        TermsofDelivery: Text[250];
        Error1: Label 'Report Under Process. Don''t Close and Refresh the Page.';
        LCDetailforExport: Record "LC Detail for Export";
        LCIssueBank: Text;
        IssueDate: Date;
        EximCode: Text;
        ILCNo: Text;
        ILCDate: Date;
        RecLocation: Record Location;
        PINo: Code[16];
        PIDate: Date;
        ExporterBankDetail: Code[10];
        BankAccount: Record "Bank Account";
        ExporterBankName: Text[50];
        ExporterBankAccountNo: Text[30];
        ExporterBankAdd1: Text[50];
        ExporterBankAdd2: Text[50];
        ExporterBankCity: Text[30];
        ExporterBankPostCode: Text[20];
        CountryRegion: Record "Country/Region";
        RecState: Record State;
        CountryRegion1: Record "Country/Region";
        Customer1: Record Customer;
        PartialShipment: Text[200];
        DescriptionofGoods: Text[200];
        HarmonicCode: Text[30];
        PortofCustomEntry: Text[100];
}

