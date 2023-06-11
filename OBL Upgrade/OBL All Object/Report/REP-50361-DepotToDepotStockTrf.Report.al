report 50361 "Depot To Depot Stock Trf"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DepotToDepotStockTrf.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.";
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(BranchSalesDeport; 'Branch Sales Depot : ' + Address)
            {
            }
            column(DocNo; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Ph; Ph)
            {
            }
            column(Fax; Fax)
            {
            }
            column(TIN; TIN)
            {
            }
            column(CST; CST)
            {
            }
            column(GroupCodeDes; GroupCode.Description + ' ' + GroupCode.Description2)
            {
            }
            column(TrnsToName; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TrnsToName2; "Transfer Shipment Header"."Transfer-to Name 2")
            {
            }
            column(TrnsToAdd; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TrnsToAdd2; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TrnsToCity; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(CinNo; 'CIN No. L14101UP1977PLC021546')
            {
            }
            column(LST; LST)
            {
            }
            column(CST2; CST2)
            {
            }
            column(TIN2; TIN2)
            {
            }
            column(OrderNo; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(OrderDate; "Transfer Shipment Header"."Transfer Order Date")
            {
            }
            column(TransName; TransName)
            {
            }
            column(CompPhoneNo; FORMAT(CompanyInfo."Phone No."))
            {
            }
            column(LocPhNo; FORMAT(Location."Phone No. 2"))
            {
            }
            column(LocFax; Location."Fax No.")
            {
            }
            //16225  column(FormCode; "Transfer Shipment Header"."Form Code")
            column(FormCode; '')
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(sno; sno)
                {
                }
                column(DesTotal; Description + ' ' + "Description 2")
                {
                }
                column(TypeDesc; TypeDesc)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(UOM; "Unit of Measure Code")
                {
                }
                column(Sqmt; Sqmt)
                {
                }
                column(DiscPerSqmt; DiscPerSqmt)
                {
                }
                column(BuyersRatePerSqMtr; BuyersRatePerSqMtr)
                {
                }
                column(Value; Value)
                {
                }
                column(Cart; Cart)
                {
                }
                column(Pcs; Pcs)
                {
                }
                column(Wt; Wt)
                {
                }
                column(JudText1; JudText[1])
                {
                }
                column(InvDisc; ABS(InvDisc))
                {
                }
                column(SubTotal; SubTotal)
                {
                }
                column(tgcstper; tgcstper)
                {
                }
                column(CstTot; CstTot)
                {
                }
                column(tgvatper; tgvatper)
                {
                }
                column(VatTot; VatTot)
                {
                }
                column(tgaddPer; tgaddPer)
                {
                }
                column(AdditionalTot; AdditionalTot)
                {
                }
                column(ChargeAmt; ChargeAmt)
                {
                }
                column(InsuranceAmt; InsuranceAmt)
                {
                }
                column(OtherTaxes; OtherTaxes)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                    Sqmt := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                    Wt := "Gross Weight";
                    Pcs := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", Quantity), 1, '<');

                    //IF Cart <> 0 THEN
                    //  RateperCart := "Unit Price"*Quantity/Cart;

                    //IF Cart <> 0 THEN
                    //  DiscPerCart := "Line Discount Amount"/Cart;
                    //Value := Cart * (RateperCart - DiscPerCart);

                    IF Quantity <> 0 THEN;
                    //16225  BuyersPrice := (Amount + "Excise Amount") / Quantity;

                    IF Sqmt <> 0 THEN BEGIN
                        BuyersRatePerSqMtr := BuyersPrice * Quantity / Sqmt;
                        //DiscPerSqmt := "Line Discount Amount"/Sqmt;
                    END;

                    //16225  Value := Amount + "Excise Amount";

                    TypeDesc := '';
                    //TRI NM 170308 Add Start
                    DimensionValue.RESET;
                    DimensionValue.SETFILTER("Dimension Code", '=%1', 'CATG');
                    DimensionValue.SETRANGE(Code, "Type Catogery Code");
                    IF DimensionValue.FINDFIRST THEN
                        TypeDesc := DimensionValue.Name;
                    //TRI NM 170308 Add Stop


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
                    //TRI 22.02.08 N.K Add Start
                    ItemType.SETRANGE(ItemType."No.", "Item No.");
                    IF ItemType.FIND('-') THEN
                        //TRI 22.02.08 N.K Add Stop

                        TypeDesc := '';
                    //TRI NM 170308 Add Start
                    DimensionValue.RESET;
                    DimensionValue.SETFILTER("Dimension Code", '=%1', 'CATG');
                    DimensionValue.SETRANGE(Code, "Type Catogery Code");
                    IF DimensionValue.FINDFIRST THEN
                        TypeDesc := DimensionValue.Name;
                end;
            }
            /* dataitem(DataItem1000000002; Table13798)//16225 table N/F
             {
                 DataItemLink = Invoice No.=FIELD(No.);
                 DataItemTableView = SORTING (Tax/Charge Type, Tax/Charge Code)
                                     ORDER(Ascending)
                                     WHERE (Type = FILTER (Sale));

                 trigger OnAfterGetRecord()
                 begin

                     GenLegSetup.GET;
                     CASE "Tax/Charge Type" OF
                         "Tax/Charge Type"::Charges:
                             BEGIN
                                 CASE "Charge Type" OF
                                     "Charge Type"::" ", "Charge Type"::Freight, "Charge Type"::Commission:
                                         IF "Tax/Charge Group" <> GenLegSetup."Discount Charge" THEN
                                             ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;
                                     "Charge Type"::Insurance:
                                         InsuranceAmt += "Posted Str Order Line Details".Amount;
                                 END;
                                 IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                     InvDisc += "Posted Str Order Line Details".Amount;
                             END;
                         "Tax/Charge Type"::"Sales Tax":
                             SalesTaxAmt += "Posted Str Order Line Details".Amount;
                         "Tax/Charge Type"::"Other Taxes":
                             OtherTaxes += "Posted Str Order Line Details".Amount;
                         "Tax/Charge Type"::"Service Tax":
                             VATAmt += "Posted Str Order Line Details".Amount;
                     END;
                 end;
             }*/

            trigger OnAfterGetRecord()
            begin

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";



                WorkAddress := 'Works    : ' + CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo.City;

                IF Location.GET("Transfer-from Code") THEN BEGIN
                    Address := Location.Address + Location."Address 2" + ' ' + Location.City;
                    Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                    Fax := Location."Fax No.";
                    //16225   LST := Location."L.S.T. No.";
                    CST := Location."C.S.T. No.";
                    //16225   TIN := Location."T.I.N. No.";
                END;

                //CurrReport.SHOWOUTPUT(FALSE);
                //TRI N.K 22.02.08 Add Start
                GroupCode.SETRANGE(GroupCode."Group Code", "Group Code");
                IF GroupCode.FIND('-') THEN
                    IF RecLocation.GET("Transfer-to Code") THEN BEGIN
                        //16225     TIN2 := RecLocation."T.I.N. No.";
                        CST2 := RecLocation."C.S.T. No.";
                    END;

                sno := 0;

                //IF CompanyInfo.GET THEN                           //Anurag
                //  "TINNo." := CompanyInfo."T.I.N. No.";           //Anurag
                //16225IF tin_no1.GET(Location."T.I.N. No.") THEN          //Anurag
                //16225  "TINNo." := tin_no1.Description;                  //Anurag
                IF RecVendor.GET("Transporter's Name") THEN
                    TransName := RecVendor.Name
                ELSE
                    TransName := '';


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
                //16225 table N/F start
                /* IF FormCodes.GET("Form Code") THEN BEGIN
                     FormCode := 'Against ' + FormCodes.Description;
                     FormNo := 'Form No. ' + "Form No.";
                 END;
                 PostedStrOrderLineDetails.RESET;
                 PostedStrOrderLineDetails.SETRANGE(PostedStrOrderLineDetails."Invoice No.", "Transfer Shipment Header"."No.");
                 PostedStrOrderLineDetails.SETRANGE("Charge Type", PostedStrOrderLineDetails."Charge Type"::Insurance);
                 PostedStrOrderLineDetails.SETRANGE("Tax/Charge Type", PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
                 IF PostedStrOrderLineDetails.FINDSET THEN BEGIN
                     REPEAT
                         InsuranceAmt += PostedStrOrderLineDetails.Amount;
                     UNTIL PostedStrOrderLineDetails.NEXT = 0;
                 END;*///16225 table N/F End
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
        Value: Decimal;
        SubTotal: Decimal;
        Taxtotal: Decimal;
        Netamt: Decimal;
        Location: Record Location;
        Address: Text[250];
        Ph: Text[100];
        Fax: Text[100];
        OurTIN: Code[50];
        CheckReport1: Report "Check Report";
        NoText: array[2] of Text[80];
        ExciseAmt: Decimal;
        NoTextExcise: array[2] of Text[80];
        LST: Code[100];
        CST: Code[100];
        CustomerTINNo: Text[11];
        ChargeAmt: Decimal;
        SalesTaxAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        InsuranceAmt: Decimal;
        BEDAmt: Decimal;
        ECessAmt: Decimal;
        FormCode: Text[50];
        FormNo: Text[50];
        //16225 FormCodes: Record "13756";
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
        //16225 tin_no1: Record "13701";
        i: Integer;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        SalesInvLine1: Record "Sales Invoice Line";
        tgVat: Decimal;
        Pcs: Decimal;
        GroupCode: Record "Item Group";
        ItemType: Record Item;
        TypeDesc: Text[30];
        "---------TRI------": Integer;
        //16225 DetailedTaxEntry: Record "16522";
        CstTot: Decimal;
        AdditionalTot: Decimal;
        VatTot: Decimal;
        VatPercent: Decimal;
        AdditionalPercent: Decimal;
        CstPercent: Decimal;
        tgvatper: Text[30];
        tgaddPer: Text[30];
        tgcstper: Text[30];
        CheckReport: Report "Check Report";
        Outstand: Decimal;
        CompanyName2: Text[50];
        RecVendor: Record Vendor;
        TransName: Text[50];
        TIN: Code[20];
        TIN2: Code[20];
        RecLocation: Record Location;
        CST2: Code[20];
        policy: Text[200];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        //16225   PostedStrOrderLineDetails: Record "13798";
        Text13704: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
}

