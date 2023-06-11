report 50355 "State Cust. Wise SalesJournal"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\StateCustWiseSalesJournal.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            column(Customern; Customer."No.")
            {
            }
            column(Detailed; Detailed)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("State", "Sell-to Customer No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Posting Date", "No.", "Sell-to Customer No.", "Bill-to City", "Customer Type", State;
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No."),
                                   "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                    DataItemTableView = WHERE("No." = FILTER(<> ''),
                                              Type = FILTER("Item" | "Fixed Asset" | "Resource"),
                                              Quantity = FILTER(<> 0));
                    RequestFilterFields = "Unit of Measure Code";
                    column(InvDisc1; InvDisc1)
                    {
                    }
                    column(Statename; Statename)
                    {
                    }
                    column(Statecode; "Sales Invoice Header".State)
                    {
                    }
                    column(DocNo; Export + ' ' + "Sales Invoice Header"."No.")
                    {
                    }
                    column(PostingDate; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(NameAndCity; "Sales Invoice Header"."Sell-to Customer Name" + ' , ' + "Sales Invoice Header"."Sell-to City")
                    {
                    }
                    column(DesTotal; Description + ' ' + "Description 2")
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
                    column(DiscountAmt1; ROUND("Sales Invoice Line"."Discount Amt 1", 0.01))
                    {
                    }
                    column(DiscountAmt2; ROUND("Sales Invoice Line"."Discount Amt 2", 0.01))
                    {
                    }
                    column(DiscountAmt3; ROUND("Sales Invoice Line"."Discount Amt 3", 0.01))
                    {
                    }
                    column(DiscountAmt4; ROUND("Sales Invoice Line"."Discount Amt 4", 0.01))
                    {
                    }
                    column(LineDisAmount; ROUND("Sales Invoice Line"."Line Discount Amount", 0.01))
                    {
                    }
                    column(ExAmount; ROUND(ExAmount, 0.01))
                    {
                    }
                    column(UnitAndQty; "Sales Invoice Line"."Unit Price" * Quantity)
                    {
                    }
                    column(DisAmtMinisAquiredDis; ROUND("Sales Invoice Line"."Quantity Discount Amount" - "Sales Invoice Line"."Accrued Discount", 0.01))
                    {
                    }
                    column(AccruedDiscount; ROUND("Sales Invoice Line"."Accrued Discount", 0.01))
                    {
                    }
                    column(Value; ROUND(Value, 0.01))
                    {
                    }
                    //16225   column(ExciseAmt; ROUND("Sales Invoice Line"."Excise Amount", 0.01))
                    column(ExciseAmt; ROUND("Sales Invoice Line"."Amount", 0.01))
                    {
                    }
                    column(SalesValue; ROUND(SalesValue, 0.01))
                    {
                    }
                    column(ET1; ROUND(ET1, 0.01))
                    {
                    }
                    column(VatAmtMinusTgs; ROUND(VATAmount - tgVATCess, 0.01))
                    {
                    }
                    column(tgVATCess; ROUND(tgVATCess, 0.01))
                    {
                    }
                    //16225   column(TaxAmount; ROUND("Sales Invoice Line"."Tax Amount", 0.01))
                    column(TaxAmount; ROUND("Sales Invoice Line"."Amount", 0.01))
                    {
                    }
                    column(Insurance1; ROUND(Insurance1, 0.01))
                    {
                    }
                    column(TotalValue; ROUND(TotalValue, 0.01))
                    {
                    }
                    column(Roundoff; ROUND(Roundoff, 0.01))
                    {
                    }
                    column(NetValue; ROUND(NetValue, 0.01))
                    {
                    }
                    column(TINNo; "Sales Invoice Header"."Tin No.")
                    {
                    }
                    column(GlobalDimCode; Customer."Global Dimension 1 Code")
                    {
                    }
                    column(ItemCode; 'C' + "Sales Invoice Line"."No.")
                    {
                    }
                    column(ItemClass; Item."Item Classification")
                    {
                    }
                    column(ItemCatCode; "Sales Invoice Line"."Item Category Code")
                    {
                    }
                    column(ItemGrpDescription; TgItemGrp.Description)
                    {
                    }
                    column(Qualitycode; "Sales Invoice Line"."Quality Code")
                    {
                    }
                    column(Locationcode; "Sales Invoice Line"."Location Code")
                    {
                    }
                    column(Pay; "Sales Invoice Header".Pay)
                    {
                    }
                    column(CustomerNo; 'C' + "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(CustomerName; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(SelltoCity; "Sales Invoice Header"."Sell-to City")
                    {
                    }
                    column(CustomerType; "Sales Invoice Header"."Customer Type")
                    {
                    }
                    column(SalesType; "Sales Invoice Header"."Sales Type")
                    {
                    }
                    column(DealerCode; DealerCode)
                    {
                    }
                    column(OrderNo; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(ReleaseDate; "Sales Invoice Header"."Releasing Date")
                    {
                    }
                    //16225   column(MRPPrice; ROUND("Sales Invoice Line"."MRP Price"))
                    column(MRPPrice; ROUND("Sales Invoice Line"."Unit Price"))
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
                    column(LineDisAmtperSqrMtr; ROUND(("Sales Invoice Line"."Line Discount Amount" / SqrMtr), 0.01, '='))
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
                    column(SPName; Salesperson2.Name)
                    {
                    }
                    column(PrivateSPName; Salesperson3.Name)
                    {
                    }
                    column(BranchCode; "Sales Invoice Header"."Shortcut Dimension 1 Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF Item.GET("Sales Invoice Line"."No.") THEN;
                        IF TgItemGrp.GET("Sales Invoice Line"."Group Code") THEN;
                        Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                        IF Location.GET("Location Code") THEN
                            IF Location."State Code" = Cust."State Code" THEN;
                        //16225  VATAmount := "Sales Invoice Line"."Tax Amount";

                        CLEAR(Insurance1);
                        CLEAR(ET1);
                        //16225 table N/F Start
                        /*   Taxamount := ROUND("Tax Amount", 0.01, '=');
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
                               UNTIL PostedStrOrderLineDetails.NEXT = 0;

                           IF "Sales Invoice Line"."Tax %" <> 0 THEN BEGIN
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
                           CLEAR(InvDisc1);
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
                                               //      IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                               //        InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount);
                                               IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                                   IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                       InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount)
                                                   ELSE //MSBS.Rao 0713
                                                       InvDisc1 := InvDisc1 + -PostedStrOrderLineDetails.Amount;//MSBS.Rao 0713

                                           END;
                                   END;

                               UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ //16225 table N/F End
                                                                           // TRI SC use VATAmount


                        //TRI SC
                        //16225 ExAmount := ROUND(("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity) +
                        //16225 "Sales Invoice Line"."Excise Amount", 0.01, '=');
                        ExAmount := ROUND("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity);
                        Value := ROUND(ExAmount - "Sales Invoice Line"."Line Discount Amount"
                                            - "Sales Invoice Line"."Quantity Discount Amount", 0.01, '=');

                        // SalesValue:= Value - InvDisc1;
                        IF InvDisc1 > 0 THEN
                            SalesValue := Value - ABS(InvDisc1) ELSE
                            SalesValue := Value - InvDisc1;


                        //16225  NetValue := ROUND(SalesValue + "Sales Invoice Line"."CESS Amount" + Taxamount + Insurance1 + ET1, 0.01, '=');
                        // Temp Coment
                        SqrMtr := ROUND(Item.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                        Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                        IF Sqmt <> 0 THEN;
                        //16225   MRPPerSqmtr := ROUND(("MRP Price" * Quantity / Sqmt), 0.01, '=');
                        IF SqrMtr <> 0 THEN
                            BillingRate := ROUND(Value / SqrMtr, 0.01, '=');
                        //TRI SC 050510


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
                        TotalBasicAmt := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity;
                        //TRI SC Open
                        // TRI SC

                        IF SqrMtr <> 0 THEN
                            BuyerRateSqm := (ROUND((("Sales Invoice Line"."Line Discount Amount" / SqrMtr) +
                                                                  (ExAmount - "Sales Invoice Line"."Line Discount Amount") / SqrMtr), 0.01, '='));
                        IF Salesperson.GET("Salesperson Code") THEN;
                        IF Salesperson1.GET(Customer."PCH Code") THEN;
                        IF Salesperson2.GET(Customer."Govt. SP Resp.") THEN;
                        IF Salesperson3.GET(Customer."Private SP Resp.") THEN;
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
                    IF StateRec.GET(State) THEN
                        Statename := StateRec.Description;
                end;

                trigger OnPreDataItem()
                begin

                    UserLocation1.RESET;
                    UserLocation1.SETRANGE("User ID", USERID);
                    IF NOT UserLocation1.ISEMPTY THEN BEGIN
                        IF GetLocations <> '' THEN
                            SETFILTER("Location Code", GetLocations);
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin

                //MSNK.BEGIN 050815
                UserStateSetup.RESET;
                UserStateSetup.SETRANGE("User ID", USERID);
                IF NOT UserStateSetup.ISEMPTY THEN
                    IF GetStates <> '' THEN BEGIN
                        SETFILTER("State Code", GetStates);
                    END ELSE BEGIN
                        IF GetPCHCode <> '' THEN BEGIN
                            SETFILTER("PCH Code", GetPCHCode);
                        END;
                    END;
                //MSNK STOP 150815
            end;
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
        Text001: Label 'State Cust. Wise Sales Journal';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        Salesperson1: Record "Salesperson/Purchaser";
        Salesperson2: Record "Salesperson/Purchaser";
        Salesperson3: Record "Salesperson/Purchaser";

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
}

