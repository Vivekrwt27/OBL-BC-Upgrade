report 50354 "Sales Journa(lDepot)"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesJournalDepot.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            column(ReportCaption; 'Bill Wise Sales Journal for the Period From ' + FORMAT(DateFrom) + ' To ' + FORMAT(DateTo))
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
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);
                RequestFilterFields = "Posting Date", "No.", "Sell-to Customer No.", "Bill-to City", State;
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No."),
                                   "Posting Date" = FIELD("Posting Date");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending)
                                        WHERE("No." = FILTER(<> ''),
                                              "Type" = FILTER("Item" | "Fixed Asset" | "Resource"),
                                              Quantity = FILTER(<> 0));
                    //16225  "Supplementary" = FILTER(false));
                    RequestFilterFields = "Unit of Measure Code", Type, "Item Category Code", "Quantity Discount Amount", "Accrued Discount";//16225 "Tax %",
                    column(DocNo; FORMAT(Export + ' ' + "Document No."))
                    {
                    }
                    column(PostingDate; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(SelltoCustName; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(StateCode; RecState.Code)
                    {
                    }
                    column(DealerCode; "Sales Invoice Header"."Dealer Code")
                    {
                    }
                    column(Quantity; ROUND("Sales Invoice Line".Quantity, 0.01))
                    {
                    }
                    column(SqrMtr; SqrMtr)
                    {
                    }
                    column(ExAmount; ROUND(ExAmount, 0.01))
                    {
                    }
                    column(InvDisc; ROUND(InvDisc, 0.01))
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
                    //16225 column(ExciseAmt; ROUND("Sales Invoice Line"."Excise Amount", 0.01))
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
                    //16225 column(TaxAmount; ROUND("Sales Invoice Line"."Tax Amount", 0.01))
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

                    trigger OnAfterGetRecord()
                    begin

                        SqrMtr := 0;
                        tgVATCess := 0; // TRI G.D 06.05.08
                        SqrMtr := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);

                        TaxBaseAmt := 0;
                        Insurance1 := 0;
                        InvDisc := 0;
                        ET1 := 0;
                        GenLegSetup.GET;

                        //16225 Table N/F start
                        /*  PostedStrOrderLineDetails.RESET;
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
                                              //      IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                              //        InvDisc := InvDisc + ABS(PostedStrOrderLineDetails.Amount);
                                              IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                                  IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                      InvDisc := InvDisc + ABS(PostedStrOrderLineDetails.Amount)
                                                  ELSE //MSBS.Rao 0713
                                                      InvDisc := InvDisc + -PostedStrOrderLineDetails.Amount;//MSBS.Rao 0713

                                              IF PostedStrOrderLineDetails."Tax/Charge Group" = 'ET' THEN
                                                  ET1 := ET1 + ABS(PostedStrOrderLineDetails.Amount);
                                              // TRI SC
                                          END;
                                  END;
                              UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ //16225 Table N/F End



                        VATAmount := 0;
                        Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                        IF Location.GET("Location Code") THEN
                            IF Location."State Code" = Cust."State Code" THEN;
                        //16225 VATAmount := "Sales Invoice Line"."Tax Amount";

                        //16225 Field N/F Start
                        /*  IF "Free Supply" = FALSE THEN BEGIN
                              IF Amount <> 0 THEN
                                  ExAmount := Amount
                              ELSE
                                  IF "Sales Invoice Line"."Line Discount %" <> 100 THEN
                                      ExAmount := ROUND(("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity) +
                                       "Sales Invoice Line"."Excise Amount", 0.01, '=');

                              //Value := ExAmount - InvDisc;
                              IF InvDisc > 0 THEN
                                  Value := ExAmount - ABS(InvDisc) ELSE
                                  Value := ExAmount - (InvDisc);

                              SalesValue := Value + "Excise Amount";
                          END ELSE BEGIN
                              ExAmount := Amount;
                              //Value:= ROUND("Sales Invoice Line"."Excise Amount" - "Sales Invoice Line"."Line Discount Amount",0.01,'=');
                              SalesValue := Value + "Excise Amount";
                          END;
                          *///16225 Field N/F End

                        i := 0;
                        FOR i := 1 TO 3 DO BEGIN
                            JudText[i] := '';
                            PerJud[i] := 0;
                        END;

                        i := 0;
                        //16225 table N/F start
                        /*  IF "Tax Liable" = TRUE THEN BEGIN
                              IF "Tax %" <> 0 THEN
                                  TaxBaseAmt := ("Tax Amount" / "Tax %") * 100;


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
                          END;*///16225 table N/F End
                        IF VATAmount = 0 THEN
                            tgVATCess := 0;
                        // tgVATCess := "Sales Invoice Line"."eCess Amount";
                        //TotalValue := SalesValue + "Tax Amount" + Insurance1+VATAmount + ET1 + tgVATCess ;
                        //16225 TotalValue := SalesValue + "Tax Amount" + Insurance1 + ET1;
                        // TRI SC
                        IF RecState.GET("Sales Invoice Header".State) THEN;


                        NetValue := ROUND(TotalValue, 1, '=');
                        Roundoff := ROUND(TotalValue, 1, '=') - TotalValue;
                    end;
                }

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
                    IF GetStateCode <> '' THEN BEGIN
                        SETFILTER("State Code", GetStateCode);
                    END ELSE BEGIN
                        IF GetPCHCode <> '' THEN BEGIN
                            SETFILTER("PCH Code", GetPCHCode);
                        END;
                    END;
                //MSNK.END 050815
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

    trigger OnPreReport()
    begin

        CompanyInfo.GET;
        CompanyName1 := CompanyInfo.Name;
        CompanyName2 := CompanyInfo."Name 2";

        GLSetup.GET;
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
        ExcelBuf: Record "Excel Buffer";
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
        UserState: Record "User State Setup";
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

    procedure GetStateCode(): Text[800]
    var
        StateCode: Text[800];
    begin
        //MSNK.Begin 05-08-15
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
        //MSNK.End 05-08-15
    end;
}

