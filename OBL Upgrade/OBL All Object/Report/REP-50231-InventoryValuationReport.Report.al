report 50231 "Inventory Valuation Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\InventoryValuationReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Inventory Posting Group")
                                WHERE("No." = FILTER(<> ''));
            RequestFilterFields = "No.", "Inventory Posting Group";
            column(ItemFilter; ItemFilter)
            {
            }
            column(DateFiletr; FORMAT(StartDate) + '..' + FORMAT(EndDate))
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompName2; CompanyInfo."Name 2")
            {
            }
            column(DesTotal; Item.Description + ' ' + Item."Description 2")
            {
            }
            column(InvPostingGroup; Item."Inventory Posting Group")
            {
            }
            column(BaseUOm; Item."Base Unit of Measure")
            {
            }
            column(FilterCaption; STRSUBSTNO('%1: %2', Item.TABLECAPTION, ItemFilter))
            {
            }
            column(ShowExpected; ShowExpected)
            {
            }
            column(ItemNo; "No.")
            {
            }
            column(FalseCaption; 'FALSE')
            {
            }
            column(InvoicedQty; InvoicedQty)
            {
            }
            column(ValueOfInvoicedQty; ValueOfInvoicedQty)
            {
            }
            column(InvIncreasesDetail1; InvIncreasesDetail[1])
            {
            }
            column(ValueOfInvIncreasesDetail1; ValueOfInvIncreasesDetail[1])
            {
            }
            column(InvIncreasesDetail2; InvIncreasesDetail[2])
            {
            }
            column(ValueOfInvIncreasesDetail2; ValueOfInvIncreasesDetail[2])
            {
            }
            column(InvIncreasesDetail3; InvIncreasesDetail[3])
            {
            }
            column(ValueOfInvIncreasesDetail3; ValueOfInvIncreasesDetail[3])
            {
            }
            column(InvIncreasesDetail4; InvIncreasesDetail[4])
            {
            }
            column(ValueOfInvIncreasesDetail4; ValueOfInvIncreasesDetail[4])
            {
            }
            column(InvIncreasesDetail5; InvIncreasesDetail[5])
            {
            }
            column(ValueOfInvIncreasesDetail5; ValueOfInvIncreasesDetail[5])
            {
            }
            column(InvIncreasesDetail6; InvIncreasesDetail[6])
            {
            }
            column(ValueOfInvIncreasesDetail6; ValueOfInvIncreasesDetail[6])
            {
            }
            column(InvIncreases; InvIncreases)
            {
            }
            column(ValueOfInvIncreases; ValueOfInvIncreases)
            {
            }
            column(InvDecreasesDetail1; InvDecreasesDetail[1])
            {
            }
            column(CostOfInvDecreasesDetail1; CostOfInvDecreasesDetail[1])
            {
            }
            column(InvDecreasesDetail2; InvDecreasesDetail[2])
            {
            }
            column(CostOfInvDecreasesDetail2; CostOfInvDecreasesDetail[2])
            {
            }
            column(InvDecreasesDetail3; InvDecreasesDetail[3])
            {
            }
            column(CostOfInvDecreasesDetail3; CostOfInvDecreasesDetail[3])
            {
            }
            column(InvDecreasesDetail4; InvDecreasesDetail[4])
            {
            }
            column(CostOfInvDecreasesDetail4; CostOfInvDecreasesDetail[4])
            {
            }
            column(InvDecreasesDetail5; InvDecreasesDetail[5])
            {
            }
            column(CostOfInvDecreasesDetail5; CostOfInvDecreasesDetail[5])
            {
            }
            column(InvDecreasesDetail6; InvDecreasesDetail[6])
            {
            }
            column(CostOfInvDecreasesDetail6; CostOfInvDecreasesDetail[6])
            {
            }
            column(InvDecreasesDetail7; InvDecreasesDetail[7])
            {
            }
            column(CostOfInvDecreasesDetail7; CostOfInvDecreasesDetail[7])
            {
            }
            column(InvDecreases; InvDecreases)
            {
            }
            column(CostOfInvDecreases; CostOfInvDecreases)
            {
            }
            column(InvoicedQuantity; ValueEntry."Invoiced Quantity")
            {
            }
            column(CostAmt; ValueEntry."Cost Amount (Actual)")
            {
            }
            column(InvCostPostedToGL; InvCostPostedToGL)
            {
            }
            column(QtyOnHand; QtyOnHand)
            {
            }
            column(ValueOfQtyOnHand; ValueOfQtyOnHand)
            {
            }
            column(RcdIncreasesDetail1; RcdIncreasesDetail[1])
            {
            }
            column(ValueOfRcdIncreasesDetail1; ValueOfRcdIncreasesDetail[1])
            {
            }
            column(RcdIncreasesDetail2; RcdIncreasesDetail[2])
            {
            }
            column(ValueOfRcdIncreasesDetail2; ValueOfRcdIncreasesDetail[2])
            {
            }
            column(RcdIncreasesDetail3; RcdIncreasesDetail[3])
            {
            }
            column(ValueOfRcdIncreasesDetail3; ValueOfRcdIncreasesDetail[3])
            {
            }
            column(RcdIncreasesDetail4; RcdIncreasesDetail[4])
            {
            }
            column(ValueOfRcdIncreasesDetail4; ValueOfRcdIncreasesDetail[4])
            {
            }
            column(RcdIncreasesDetail5; RcdIncreasesDetail[5])
            {
            }
            column(ValueOfRcdIncreasesDetail5; ValueOfRcdIncreasesDetail[5])
            {
            }
            column(RcdIncreasesDetail6; RcdIncreasesDetail[6])
            {
            }
            column(ValueOfRcdIncreasesDetail6; ValueOfRcdIncreasesDetail[6])
            {
            }
            column(RcdIncreases; RcdIncreases)
            {
            }
            column(ValueOfRcdIncreases; ValueOfRcdIncreases)
            {
            }
            column(ShipDecreaseDetail1; ShipDecreaseDetail[1])
            {
            }
            column(CostOfShipDecreasesDetail1; CostOfShipDecreasesDetail[1])
            {
            }
            column(ShipDecreaseDetail2; ShipDecreaseDetail[2])
            {
            }
            column(CostOfShipDecreasesDetail2; CostOfShipDecreasesDetail[2])
            {
            }
            column(ShipDecreaseDetail3; ShipDecreaseDetail[3])
            {
            }
            column(CostOfShipDecreasesDetail3; CostOfShipDecreasesDetail[3])
            {
            }
            column(ShipDecreaseDetail4; ShipDecreaseDetail[4])
            {
            }
            column(CostOfShipDecreasesDetail4; CostOfShipDecreasesDetail[4])
            {
            }
            column(ShipDecreaseDetail5; ShipDecreaseDetail[5])
            {
            }
            column(CostOfShipDecreasesDetail5; CostOfShipDecreasesDetail[5])
            {
            }
            column(ShipDecreaseDetail6; ShipDecreaseDetail[6])
            {
            }
            column(CostOfShipDecreasesDetail6; CostOfShipDecreasesDetail[6])
            {
            }
            column(ShipDecreaseDetail7; ShipDecreaseDetail[7])
            {
            }
            column(CostOfShipDecreasesDetail7; CostOfShipDecreasesDetail[7])
            {
            }
            column(ShipDecreases; ShipDecreases)
            {
            }
            column(CostOfShipDecreases; CostOfShipDecreases)
            {
            }
            column(ItemLedgerEntryQuantity; ValueEntry."Item Ledger Entry Quantity")
            {
            }
            column(Sum2; ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases)
            {
            }
            column(InvCostPostedToGL2; InvCostPostedToGL)
            {
            }
            column(CAmt; CAmt)
            {
            }
            column(ExpectedCodeToPrint; ExpectedCodeToPrint)
            {
            }
            column(Start_Date; StartDate)
            {
            }
            column(End_Date; EndDate)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //CALCFIELDS("Bill of Materials");
                InvandShipDiffer := FALSE;

                QtyOnHand := 0;
                RcdIncreases := 0;
                ShipDecreases := 0;
                ValueOfQtyOnHand := 0;
                ValueOfInvoicedQty := 0;
                InvoicedQty := 0;

                ValueOfRcdIncreases := 0;
                ValueOfInvIncreases := 0;
                InvIncreases := 0;

                CostOfShipDecreases := 0;
                CostOfInvDecreases := 0;
                InvDecreases := 0;

                FOR i := 1 TO 10 DO BEGIN
                    ValueOfInvIncreasesDetail[i] := 0;
                    ValueOfRcdIncreasesDetail[i] := 0;
                    InvIncreasesDetail[i] := 0;
                    CostOfShipDecreasesDetail[i] := 0;
                    CostOfInvDecreasesDetail[i] := 0;
                    InvDecreasesDetail[i] := 0;
                    RcdIncreasesDetail[i] := 0;
                    ShipDecreaseDetail[i] := 0;
                    CLEAR(ValueOfRcdIncreasesDetail[i]);
                    CLEAR(ValueOfInvIncreasesDetail[i]);
                    CLEAR(InvIncreasesDetail[i]);
                    CLEAR(RcdIncreasesDetail[i]);
                    CLEAR(RcdIncreasesDetail[i]);
                    CLEAR(ShipDecreaseDetail[i]);
                    CLEAR(ValueOfRcdIncreasesDetail[i]);
                    CLEAR(ValueOfInvIncreasesDetail[i]);
                    CLEAR(InvIncreasesDetail[i]);
                    CLEAR(CostOfShipDecreasesDetail[i]);
                    CLEAR(CostOfInvDecreasesDetail[i]);
                    CLEAR(InvDecreasesDetail[i])

                END;

                CLEAR(CAmt);
                CLEAR(InvQty);
                CLEAR(InvCostPostedToGL);
                CLEAR(ExpCostPostedToGL);
                WITH ValueEntry DO BEGIN
                    SETRANGE("Item No.", Item."No.");
                    IF EndDate <> 0D THEN
                        SETRANGE("Posting Date", 0D, EndDate);

                    SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                    //MSAK.BEGIN 010515
                    IF (Item.GETFILTER("Location Filter") = 'SKD-PLANT') OR (Item.GETFILTER("Location Filter") = 'DRA-PLANT')
                        OR (Item.GETFILTER("Location Filter") = 'HSK-PLANT') THEN
                        SETFILTER("Location Code", GetLocations(Item.GETFILTER("Location Filter")))
                    ELSE
                        //MSAK.END 010515
                        SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
                    SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
                    IF FINDFIRST THEN BEGIN
                        REPEAT
                            CALCFIELDS("Direct Consumption Entries");
                            IsPositive := GetSign;
                            IF "Item Ledger Entry Quantity" <> 0 THEN BEGIN
                                IF "Posting Date" < StartDate THEN
                                    QtyOnHand += "Item Ledger Entry Quantity"
                                ELSE BEGIN
                                    IF IsPositive THEN BEGIN
                                        RcdIncreases += "Item Ledger Entry Quantity";
                                        IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Purchase THEN
                                            RcdIncreasesDetail[1] += "Item Ledger Entry Quantity"
                                        ELSE
                                            IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::"Positive Adjmt." THEN
                                                RcdIncreasesDetail[2] += "Item Ledger Entry Quantity"
                                            ELSE
                                                IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Output THEN
                                                    RcdIncreasesDetail[3] += "Item Ledger Entry Quantity"
                                                ELSE
                                                    IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Transfer) THEN
                                                        RcdIncreasesDetail[4] += "Item Ledger Entry Quantity"
                                                    ELSE
                                                        IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Sale) THEN
                                                            RcdIncreasesDetail[5] += "Item Ledger Entry Quantity"
                                                        ELSE
                                                            IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Consumption) THEN
                                                                RcdIncreasesDetail[6] += "Item Ledger Entry Quantity"
                                    END
                                    ELSE BEGIN
                                        ShipDecreases := ShipDecreases - "Item Ledger Entry Quantity";
                                        IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Sale THEN
                                            ShipDecreaseDetail[1] := ShipDecreaseDetail[1] - "Item Ledger Entry Quantity"
                                        ELSE
                                            IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::"Negative Adjmt.") AND ("Direct Consumption Entries" = FALSE) THEN
                                                ShipDecreaseDetail[2] := ShipDecreaseDetail[2] - "Item Ledger Entry Quantity"
                                            ELSE
                                                IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::"Negative Adjmt.") AND ("Direct Consumption Entries" = TRUE) THEN
                                                    ShipDecreaseDetail[3] := ShipDecreaseDetail[3] - "Item Ledger Entry Quantity"
                                                ELSE
                                                    IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Consumption THEN
                                                        ShipDecreaseDetail[4] := ShipDecreaseDetail[4] - "Item Ledger Entry Quantity"
                                                    ELSE
                                                        IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Transfer) THEN
                                                            ShipDecreaseDetail[5] := ShipDecreaseDetail[5] - "Item Ledger Entry Quantity"
                                                        ELSE
                                                            IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Purchase) THEN
                                                                ShipDecreaseDetail[6] := ShipDecreaseDetail[6] - "Item Ledger Entry Quantity"
                                                            ELSE
                                                                IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Output) THEN
                                                                    ShipDecreaseDetail[7] := ShipDecreaseDetail[7] - "Item Ledger Entry Quantity"
                                    END;
                                END;
                            END;

                            IF "Posting Date" < StartDate THEN
                                SetAmount(ValueOfQtyOnHand, ValueOfInvoicedQty, InvoicedQty, 1)
                            ELSE BEGIN
                                IF IsPositive THEN BEGIN
                                    SetAmount(ValueOfRcdIncreases, ValueOfInvIncreases, InvIncreases, 1);

                                    IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Purchase THEN
                                        SetAmount(ValueOfRcdIncreasesDetail[1], ValueOfInvIncreasesDetail[1], InvIncreasesDetail[1], 1)
                                    ELSE
                                        IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::"Positive Adjmt." THEN
                                            SetAmount(ValueOfRcdIncreasesDetail[2], ValueOfInvIncreasesDetail[2], InvIncreasesDetail[2], 1)
                                        ELSE
                                            IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Output THEN
                                                SetAmount(ValueOfRcdIncreasesDetail[3], ValueOfInvIncreasesDetail[3], InvIncreasesDetail[3], 1)
                                            ELSE
                                                IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Transfer) THEN
                                                    SetAmount(ValueOfRcdIncreasesDetail[4], ValueOfInvIncreasesDetail[4], InvIncreasesDetail[4], 1)
                                                ELSE
                                                    IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Sale) THEN
                                                        SetAmount(ValueOfRcdIncreasesDetail[5], ValueOfInvIncreasesDetail[5], InvIncreasesDetail[5], 1)
                                                    ELSE
                                                        IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Consumption) THEN
                                                            SetAmount(ValueOfRcdIncreasesDetail[6], ValueOfInvIncreasesDetail[6], InvIncreasesDetail[6], 1)
                                END
                                ELSE BEGIN
                                    SetAmount(CostOfShipDecreases, CostOfInvDecreases, InvDecreases, -1);
                                    IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Sale THEN
                                        SetAmount(CostOfShipDecreasesDetail[1], CostOfInvDecreasesDetail[1], InvDecreasesDetail[1], -1)
                                    ELSE
                                        IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::"Negative Adjmt.") AND ("Direct Consumption Entries" = FALSE) THEN
                                            SetAmount(CostOfShipDecreasesDetail[2], CostOfInvDecreasesDetail[2], InvDecreasesDetail[2], -1)
                                        ELSE
                                            IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::"Negative Adjmt.") AND ("Direct Consumption Entries" = TRUE) THEN
                                                SetAmount(CostOfShipDecreasesDetail[3], CostOfInvDecreasesDetail[3], InvDecreasesDetail[3], -1)
                                            ELSE
                                                IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Consumption THEN
                                                    SetAmount(CostOfShipDecreasesDetail[4], CostOfInvDecreasesDetail[4], InvDecreasesDetail[4], -1)
                                                ELSE
                                                    IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Transfer) THEN
                                                        SetAmount(CostOfShipDecreasesDetail[5], CostOfInvDecreasesDetail[5], InvDecreasesDetail[5], -1)
                                                    ELSE
                                                        IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Purchase) THEN
                                                            SetAmount(CostOfShipDecreasesDetail[6], CostOfInvDecreasesDetail[6], InvDecreasesDetail[6], -1)
                                                        ELSE
                                                            IF ("Item Ledger Entry Type" = "Item Ledger Entry Type"::Output) THEN
                                                                SetAmount(CostOfShipDecreasesDetail[7], CostOfInvDecreasesDetail[7], InvDecreasesDetail[7], -1);
                                END;
                            END;
                            /*IF (ValueOfRcdIncreasesDetail[1] <> 0) AND (ValueOfInvIncreasesDetail[1] <> 0 ) THEN
                              MESSAGE('%1  %2',ValueOfRcdIncreasesDetail[1],ValueOfInvIncreasesDetail[1]);*/
                            //ValueOfQtyOnHand := ValueOfQtyOnHand + ValueOfInvoicedQty;
                            //ValueOfRcdIncreases := ValueOfRcdIncreases + ValueOfInvIncreases;
                            //CostOfShipDecreases := CostOfShipDecreases + CostOfInvDecreases;

                            ExpCostPostedToGL += "Expected Cost Posted to G/L";
                            InvCostPostedToGL += "Cost Posted to G/L";
                            CostPostedToGL := ExpCostPostedToGL + InvCostPostedToGL;
                            InvQty += ValueEntry."Invoiced Quantity";
                            CAmt += ValueEntry."Cost Amount (Actual)"
                        UNTIL NEXT = 0;
                    END ELSE
                        CurrReport.SKIP;
                END;
                ExpectedCodeToPrint := InvAndShipDiffers();

            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("No.",'RMD03030008723');

                IF (Item.GETFILTER("Location Filter") = 'SKD-PLANT') OR (Item.GETFILTER("Location Filter") = 'DRA-PLANT')
                    OR (Item.GETFILTER("Location Filter") = 'HSK-PLANT') THEN
                    SETFILTER("Location Filter", GetLocations(Item.GETFILTER("Location Filter")));
                //MSAK.END 010515

                //MSAK.BEGIN 150914
                //CALCFIELDS(Inventory);
                IF MinimumStock THEN BEGIN
                    SETFILTER("Minimum Inventory", '<>%1', 0);
                END;
                //MSAK.END 150914
                //Item.SETRANGE("No.",'BUD04047001602');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field("Include Expected Cost"; ShowExpected)
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
        CompInfo.GET();

        IF (StartDate = 0D) AND (EndDate = 0D) THEN
            EndDate := WORKDATE;

        IF StartDate IN [0D, 00000101D] THEN//01010000D
            StartDateText := ''
        ELSE
            StartDateText := FORMAT(StartDate - 1);

        ItemFilter := Item.GETFILTERS;
        ValueEntry.SETCURRENTKEY("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Source Type", "Source No.");
    end;

    var
        StartDate: Date;
        EndDate: Date;
        ShowExpected: Boolean;
        ItemFilter: Text[250];
        StartDateText: Text[10];
        ValueOfInvoicedQty: Decimal;
        ValueOfQtyOnHand: Decimal;
        ValueOfInvIncreases: Decimal;
        ValueOfRcdIncreases: Decimal;
        CostOfInvDecreases: Decimal;
        CostOfShipDecreases: Decimal;
        InvCostPostedToGL: Decimal;
        CostPostedToGL: Decimal;
        InvoicedQty: Decimal;
        QtyOnHand: Decimal;
        InvIncreases: Decimal;
        RcdIncreases: Decimal;
        InvDecreases: Decimal;
        ShipDecreases: Decimal;
        ExpCostPostedToGL: Decimal;
        InvandShipDiffer: Boolean;
        IsPositive: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        ValueOfInvIncreasesDetail: array[100] of Decimal;
        ValueOfRcdIncreasesDetail: array[100] of Decimal;
        InvIncreasesDetail: array[100] of Decimal;
        CostOfShipDecreasesDetail: array[100] of Decimal;
        CostOfInvDecreasesDetail: array[100] of Decimal;
        InvDecreasesDetail: array[100] of Decimal;
        RcdIncreasesDetail: array[100] of Decimal;
        ShipDecreaseDetail: array[100] of Decimal;
        i: Integer;
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        MinimumStock: Boolean;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text005: Label 'As of %1';
        Text006: Label 'Inventory Posting Group: %1';
        Text007: Label 'Inventory Posting Group Total: %1';
        Text008: Label 'Expected Cost Included Total: %1';
        Text009: Label 'Expected Cost Total: %1';
        Text0005: Label 'Company Name';
        Text0006: Label 'Report No.';
        Text0007: Label 'Report Name';
        Text0008: Label 'User ID';
        Text0009: Label 'Print Date';
        Text0011: Label 'Filters';
        Text0012: Label 'Filters 2';
        Text001: Label 'Inventory Valuation';
        Text002: Label 'Data';
        CompInfo: Record "Company Information";
        ExpectedCostoShow: Boolean;
        InvQty: Decimal;
        CAmt: Decimal;
        ValueEntry: Record "Value Entry";
        ExpectedCodeToPrint: Boolean;


    procedure InvAndShipDiffers(): Boolean
    begin
        EXIT(
          (QtyOnHand + RcdIncreases - ShipDecreases) <>
          (InvoicedQty + InvIncreases - InvDecreases));
    end;


    procedure GetSign(): Boolean
    begin
        WITH ValueEntry DO
            CASE "Item Ledger Entry Type" OF
                "Item Ledger Entry Type"::Purchase,
              "Item Ledger Entry Type"::"Positive Adjmt.",
              "Item Ledger Entry Type"::Output:
                    EXIT(TRUE);
                "Item Ledger Entry Type"::Transfer:
                    BEGIN
                        IF "Valued Quantity" < 0 THEN
                            EXIT(FALSE)
                        ELSE
                            EXIT(GetOutboundItemEntry("Item Ledger Entry No."));
                    END;
                ELSE
                    EXIT(FALSE)
            END;
    end;


    procedure SetAmount(var CostAmtExp: Decimal; var CostAmtActual: Decimal; var InvQty: Decimal; Sign: Integer)
    begin
        WITH ValueEntry DO BEGIN
            CostAmtExp := CostAmtExp + "Cost Amount (Expected)" * Sign;
            CostAmtActual := CostAmtActual + "Cost Amount (Actual)" * Sign;
            InvQty := InvQty + "Invoiced Quantity" * Sign;
            //IF (ValueEntry."Item Ledger Entry Type"= ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.") AND (ValueEntry."Invoiced Quantity" <> 0) THEN
            //MESSAGE('%1',InvQty);

        END;
    end;

    local procedure GetOutboundItemEntry(ItemLedgerEntryNo: Integer): Boolean
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
        IF NOT ItemApplnEntry.FIND('-') THEN
            EXIT(TRUE);
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");
        ItemLedgEntry.SETRANGE("Item No.", Item."No.");
        ItemLedgEntry.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
        ItemLedgEntry.SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
        ItemLedgEntry.SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
        ItemLedgEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
        ItemLedgEntry."Entry No." := ItemApplnEntry."Outbound Item Entry No.";
        EXIT(NOT ItemLedgEntry.FIND);
    end;


    procedure SetStartDate(DateValue: Date)
    begin
        StartDate := DateValue;
    end;


    procedure SetEndDate(DateValue: Date)
    begin
        EndDate := DateValue;
    end;


    procedure GetLocations(LocationCode: Code[10]): Text[800]
    var
        Loc: Text[800];
        Location: Record Location;
    begin
        //MSAK.BEGIN 010515
        Location.RESET;
        Location.SETFILTER(Code, COPYSTR(LocationCode, 1, 3) + '*');
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := Location.Code
                ELSE
                    Loc := Loc + '|' + Location.Code;
            UNTIL Location.NEXT = 0;
        END;
        IF LocationCode = 'SKD-PLANT' THEN
            EXIT(Loc + '|' + 'O-INTRAN');
        IF LocationCode = 'HSK-PLANT' THEN
            EXIT(Loc + '|' + 'B-INTRAN');
        EXIT(Loc);
        //MSAK.END 010515
    end;
}

