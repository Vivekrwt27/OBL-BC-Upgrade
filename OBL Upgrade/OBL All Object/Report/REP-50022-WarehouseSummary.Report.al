report 50022 "Warehouse Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\WarehouseSummary.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Company Information"; 79)
        {
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Name2_CompanyInformation; "Company Information"."Name 2")
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Address2_CompanyInformation; "Company Information"."Address 2")
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PostCode_CompanyInformation; "Company Information"."Post Code")
            {
            }
            column(State_CompanyInformation; "Company Information"."State Code") // 16630 replace here State
            {
            }
            column(FromDate; FORMAT(FromDate))
            {
            }
            column(ToDAte; FORMAT(ToDAte))
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(Date; FORMAT(TODAY, 0, 4))
            {
            }
            column(UserIds; USERID)
            {
            }
            column(Location1; Location1)
            {
            }
        }
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Plant Code", "Type Code", "Size Code", "Packing Code";
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(OpeningQty; OpeningQty)
            {
            }
            column(RcptQty; RcptQty)
            {
            }
            column(AdjmtQty; AdjmtQty)
            {
            }
            column(ConQty; ConQty)
            {
            }
            column(ClosingQty; ClosingQty)
            {
            }

            trigger OnAfterGetRecord()
            begin

                OpeningQty := 0;
                OpeningAmt := 0;
                RcptQty := 0;
                RcptAmt := 0;
                ConQty := 0;
                ConAmt := 0;
                ClosingQty := 0;
                ClosingAmt := 0;
                ConsumptionQty := 0;
                OutputQty := 0;
                OPQtyCR := 0;
                PurchaseQty := 0;
                TransferQty := 0;
                AdjmtQty := 0;
                SaleQty := 0;
                TransferIssue := 0;
                Issue := 0;
                j += 1;

                Win.UPDATE(1, ROUND(j / i * 10000, 1));

                //Calculation of Opening Start
                ILE.RESET;
                ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                ILE.SETRANGE(ILE."Item No.", "No.");
                ILE.SETRANGE(ILE."Posting Date", 0D, FromDate - 1);
                IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                    ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                IF Item.GETFILTER(Item."Type Code") <> '' THEN
                    ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                IF Item.GETFILTER(Item."Size Code") <> '' THEN
                    ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                    ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                IF Location1 <> '' THEN
                    ILE.SETFILTER(ILE."Location Code", Location1);
                IF ILE.FIND('-') THEN
                    REPEAT
                        OpeningQty += ILE.Quantity;
                    UNTIL ILE.NEXT = 0;
                //Calculation of Opening Stop

                //Calculation of Receipt Start
                IF Plant THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Output);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            OPQtyCR += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
                    ILE.SETRANGE(ILE."Re Process Production Order", TRUE);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            ConsumptionQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    OutputQty := OPQtyCR - ABS(ConsumptionQty);
                END;

                IF Store THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Purchase);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            PurchaseQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."External Transfer", FALSE);
                    ILE.SETFILTER(ILE.Quantity, '>%1', 0);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            TransferQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;
                END;

                IF Warehouse THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE.ReProcess, FALSE);
                    ILE.SETRANGE(ILE."External Transfer", FALSE);
                    ILE.SETFILTER(ILE.Quantity, '>%1', 0);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            TransferQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;
                END;

                RcptQty := PurchaseQty + OutputQty + TransferQty;
                FinalReceiptQty += RcptQty;

                //Calculation of Receipt Stop

                //Calculation of Adjustment Start
                ILE.RESET;
                ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                ILE.SETRANGE(ILE."Item No.", "No.");
                ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                ILE.SETFILTER(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::"Positive Adjmt.", ILE."Entry Type"::"Negative Adjmt.",
                              ILE."Entry Type"::Transfer);
                IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                    ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                IF Item.GETFILTER(Item."Type Code") <> '' THEN
                    ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                IF Item.GETFILTER(Item."Size Code") <> '' THEN
                    ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                    ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                IF Location1 <> '' THEN
                    ILE.SETFILTER(ILE."Location Code", Location1);
                IF ILE.FIND('-') THEN
                    REPEAT
                        IF (ILE."Entry Type" = ILE."Entry Type"::Transfer) AND (ILE.ReProcess) THEN
                            AdjmtQty += ILE.Quantity;
                        IF (ILE."Entry Type" = ILE."Entry Type"::"Positive Adjmt.") THEN
                            AdjmtQty += ILE.Quantity;
                        IF (ILE."Entry Type" = ILE."Entry Type"::"Negative Adjmt.") AND (NOT ILE."Direct Consumption Entries") THEN
                            AdjmtQty += ILE.Quantity;
                    UNTIL ILE.NEXT = 0;
                //Calculation of Adjustment Stop

                //Calculation of Issue Start
                IF Warehouse THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Sale);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    //ILE.SETFILTER(ILE.Quantity,'<%1',0);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            SaleQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."External Transfer", TRUE);
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            TransferIssue += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;
                END;

                IF Store THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::"Negative Adjmt.");
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."Direct Consumption Entries", TRUE);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            Issue += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    ILE.RESET;
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDAte);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                        ILE.SETRANGE(ILE."Plant Code", Item.GETFILTER(Item."Plant Code"));
                    IF Item.GETFILTER(Item."Type Code") <> '' THEN
                        ILE.SETRANGE(ILE."Type Code", Item.GETFILTER(Item."Type Code"));
                    IF Item.GETFILTER(Item."Size Code") <> '' THEN
                        ILE.SETRANGE(ILE."Size Code", Item.GETFILTER(Item."Size Code"));
                    IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                        ILE.SETRANGE(ILE."Packing Code", Item.GETFILTER(Item."Packing Code"));
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."External Transfer", FALSE);
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    IF ILE.FIND('-') THEN
                        REPEAT
                            TransferIssue += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;
                END;

                ConQty := ABS(SaleQty) + ABS(TransferIssue) + ABS(Issue);
                //Calculation of Issue Stop

                //Calculation of Closing Stock Start
                ClosingQty := (OpeningQty + RcptQty + AdjmtQty) - (ConQty);

                /*ILE.RESET;
                ILE.SETCURRENTKEY(ILE."Item No.",ILE."Posting Date");
                ILE.SETRANGE(ILE."Item No.","No.");
                ILE.SETRANGE(ILE."Posting Date",0D,ToDAte);
                IF Item.GETFILTER(Item."Plant Code") <> '' THEN
                  ILE.SETRANGE(ILE."Plant Code",Item.GETFILTER(Item."Plant Code"));
                IF Item.GETFILTER(Item."Type Code") <> '' THEN
                  ILE.SETRANGE(ILE."Type Code",Item.GETFILTER(Item."Type Code"));
                IF Item.GETFILTER(Item."Size Code") <> '' THEN
                  ILE.SETRANGE(ILE."Size Code",Item.GETFILTER(Item."Size Code"));
                IF Item.GETFILTER(Item."Packing Code") <> '' THEN
                  ILE.SETRANGE(ILE."Packing Code",Item.GETFILTER(Item."Packing Code"));
                IF Location1 <> '' THEN
                  ILE.SETFILTER(ILE."Location Code",Location1);
                IF ILE.FIND('-') THEN REPEAT
                  ClosingQty += ILE.Quantity;
                UNTIL ILE.NEXT = 0;*/
                //Calculation of Closing Stock Stop

            end;

            trigger OnPostDataItem()
            begin

                Win.CLOSE;
            end;

            trigger OnPreDataItem()
            begin

                SNo := 0;
                FinalReceiptQty := 0;

                CurrReport.CREATETOTALS(OpeningQty, RcptQty, AdjmtQty, ConQty, ClosingQty);

                i := COUNT;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Location Filter"; Location1)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; ToDAte)
                {
                    ApplicationArea = All;
                }
                field(Plant; Plant)
                {
                    ApplicationArea = All;
                }
                field(Warehouse; Warehouse)
                {
                    ApplicationArea = All;
                }
                field(Store; Store)
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

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50022)
    end;

    trigger OnPreReport()
    begin

        IF FromDate = 0D THEN
            ERROR('Please Enter From Date');
        IF ToDAte = 0D THEN
            ERROR('Please Enter To Date');
        //IF Location1 = '' THEN
        //ERROR('Please Enter the Location Code');

        IF (NOT Plant) AND (NOT Warehouse) AND (NOT Store) THEN
            ERROR(tgext002);

        FilterString := Item.GETFILTERS;
        Win.OPEN(tgext001);
    end;

    var
        ILE: Record "Item Ledger Entry";
        FromDate: Date;
        ToDAte: Date;
        OpeningQty: Decimal;
        OpeningAmt: Decimal;
        ClosingQty: Decimal;
        ClosingAmt: Decimal;
        RcptQty: Decimal;
        ConQty: Decimal;
        RcptAmt: Decimal;
        ConAmt: Decimal;
        Item1: Record Item;
        DateFilter1: Text[30];
        DateFilter2: Text[30];
        FilterString: Text[250];
        SNo: Integer;
        Item2: Record Item;
        Item3: Record Item;
        LocationCode: Text[30];
        Location1: Code[1024];
        LocationRec: Record Location;
        ItemCostMgt: Codeunit ItemCostManagement;
        AvCostLCY: Decimal;
        AvCostACY: Decimal;
        GLSetup: Record "General Ledger Setup";
        TrQty: Decimal;
        TrAmt: Decimal;
        Contin: Boolean;
        ClosingQtyTest: Decimal;
        ConsumptionQty: Decimal;
        OPQtyCR: Decimal;
        OutputQty: Decimal;
        PurchaseQty: Decimal;
        TransferQty: Decimal;
        AdjmtQty: Decimal;
        SaleQty: Decimal;
        TransferIssue: Decimal;
        Win: Dialog;
        i: Integer;
        j: Integer;
        FinalReceiptQty: Decimal;
        Issue: Decimal;
        Plant: Boolean;
        Warehouse: Boolean;
        Store: Boolean;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        tgext001: Label 'Processing @1@@@@@@@@@@@@@@@@@@@@@@@';
        tgext002: Label 'Option Plant,Warehouse or Store should not be false at a same time on a request form.';

    procedure CalculateAverageCost(var ILE: Record "Item Ledger Entry"; var AverageCost: Decimal; var AverageCostACY: Decimal): Boolean
    var
        ValueEntry: Record "Value Entry";
        AverageQty: Decimal;
    begin
        WITH ValueEntry DO BEGIN
            RESET;
            SETCURRENTKEY("Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code");
            SETRANGE("Item No.", ILE."Item No.");
            SETRANGE("Expected Cost", FALSE);
            SETFILTER("Valuation Date", ILE.GETFILTER(ILE."Posting Date"));
            //SETFILTER("Location Code",ILE.GETFILTER("Location Filter"));
            //SETFILTER("Variant Code",Item.GETFILTER("Variant Filter"));
            IF LocationRec.GetLocationFilter(Location1, ILE."Location Code") THEN BEGIN
                CALCSUMS("Invoiced Quantity", "Cost Amount (Actual)", "Cost Amount (Actual) (ACY)");
                AverageQty := "Invoiced Quantity";
                AverageCost := "Cost Amount (Actual)";
                AverageCostACY := "Cost Amount (Actual) (ACY)";
            END;
        END;

        IF AverageQty <> 0 THEN BEGIN
            AverageCost := AverageCost / AverageQty;
            AverageCostACY := AverageCostACY / AverageQty;

            IF AverageCost < 0 THEN
                AverageCost := 0;
            GLSetup.GET;
            IF (GLSetup."Additional Reporting Currency" = '') OR (AverageCostACY < 0) THEN
                AverageCostACY := 0;
        END ELSE BEGIN
            AverageCost := 0;
            AverageCostACY := 0;
        END;
        IF AverageQty <= 0 THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure CalculateAverageCost1(var Item: Record Item; var AverageCost: Decimal; var AverageCostACY: Decimal): Boolean
    var
        ValueEntry: Record "Value Entry";
        AverageQty: Decimal;
    begin
        WITH ValueEntry DO BEGIN
            RESET;
            SETCURRENTKEY(
              "Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code");
            SETRANGE("Item No.", Item."No.");
            SETRANGE("Expected Cost", FALSE);
            SETFILTER("Valuation Date", Item.GETFILTER("Date Filter"));
            //SETFILTER("Location Code",Item.GETFILTER("Location Filter"));
            SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
            IF FIND('-') THEN
                REPEAT
                    IF LocationRec.GetLocationFilter(Location1, "Location Code") THEN BEGIN
                        //CALCSUMS("Invoiced Quantity","Cost Amount (Actual)","Cost Amount (Actual) (ACY)");
                        AverageQty += "Invoiced Quantity";
                        AverageCost += "Cost Amount (Actual)";
                        AverageCostACY += "Cost Amount (Actual) (ACY)";
                    END;
                UNTIL ValueEntry.NEXT = 0;
        END;
        IF AverageQty <> 0 THEN BEGIN
            AverageCost := AverageCost / AverageQty;
            AverageCostACY := AverageCostACY / AverageQty;

            IF AverageCost < 0 THEN
                AverageCost := 0;
            GLSetup.GET;
            IF (GLSetup."Additional Reporting Currency" = '') OR (AverageCostACY < 0) THEN
                AverageCostACY := 0;
        END ELSE BEGIN
            AverageCost := 0;
            AverageCostACY := 0;
        END;
        IF AverageQty <= 0 THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;
}

