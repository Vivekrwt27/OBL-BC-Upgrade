report 50279 "Production Planning Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ProductionPlanningReport.rdl';

    dataset
    {
        dataitem("Sales Order Ledger Entry"; "Sales Order Ledger Entry")
        {
            DataItemTableView = SORTING("Mfg Plant", "Order Plant", "Size Code", "No.")
                                WHERE(Closed = CONST(false));
            column(BlnSummary; BlnSummary)
            {
            }
            column(ItemNo; "Sales Order Ledger Entry"."No.")
            {
            }
            column(ItemDesc; RecItem."Complete Description")
            {
            }
            column(SizeCodeDesc; "Sales Order Ledger Entry"."Size Description")
            {
            }
            column(SourcePlant; "Sales Order Ledger Entry"."Order Plant")
            {
            }
            column(ItemPlant; MfgPlant)
            {
            }
            column(decOpng; ABS(decQty))
            {
            }
            column(IncQty; IncQty)
            {
            }
            column(Qty; "Sales Order Ledger Entry".Quantity)
            {
            }
            column(openQty; OpenQty)
            {
            }
            column(DecValue; ABS(decValue / DicFactor))
            {
            }
            column(IncValue; IncValue / DicFactor)
            {
            }
            column(OpenValue; OpenValue / DicFactor)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(AsOnDate; AsOnDate)
            {
            }
            column(AsOnLastday; AsOnDate - 1)
            {
            }
            column(Order_No; "Sales Order Ledger Entry"."Sales Order No.")
            {
            }
            column(Default_prod; "Sales Order Ledger Entry"."Default Prod. Line Code")
            {
            }
            column(Order_date; "Sales Order Ledger Entry"."Order Date")
            {
            }
            column(manuf; RecItem."Manuf. Strategy")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SourcePlant := '';
                ItemPlant := '';
                decQty := 0;
                IncQty := 0;
                OpenQty := 0;
                decValue := 0;
                IncValue := 0;
                OpenValue := 0;

                IF RecItem.GET("Sales Order Ledger Entry"."No.") THEN;

                rItem.RESET;
                rItem.SETRANGE("No.", "Sales Order Ledger Entry"."No.");
                IF rItem.FIND THEN;
                Inventory := 0;
                MfgPlant := '';

                CASE "Sales Order Ledger Entry"."Mfg Plant" OF
                    'M001':
                        MfgPlant := 'SKD';
                    'H001':
                        MfgPlant := 'HSK';
                    'D001':
                        MfgPlant := 'Dora';

                END;
                IF LastItemNo <> "Sales Order Ledger Entry"."No." THEN BEGIN
                    CASE "Sales Order Ledger Entry"."Order Plant" OF
                        'SKD':
                            Inventory := CalculateInventory("Sales Order Ledger Entry"."No.", 'SKD-WH-MFG');
                        'DRA':
                            Inventory := CalculateInventory("Sales Order Ledger Entry"."No.", 'DRA-WH-MFG');
                        'HSK':
                            Inventory := CalculateInventory("Sales Order Ledger Entry"."No.", 'HSK-WH-MFG');

                    END;
                END;

                IF "Sales Order Ledger Entry"."Posting Date" < AsOnDate - 1 THEN BEGIN
                    OpenQty := "Sales Order Ledger Entry".Quantity;
                    OpenValue := "Sales Order Ledger Entry"."Basic Value";
                END;
                IF "Sales Order Ledger Entry"."Posting Date" = AsOnDate THEN BEGIN
                    IF "Sales Order Ledger Entry".Quantity > 0 THEN BEGIN
                        IncQty := "Sales Order Ledger Entry".Quantity;
                        IncValue := "Sales Order Ledger Entry"."Basic Value";
                    END ELSE BEGIN
                        decQty := "Sales Order Ledger Entry".Quantity;
                        decValue := "Sales Order Ledger Entry"."Basic Value";
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Sales Order Ledger Entry"."Posting Date", '..%1', AsOnDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("AS on date"; AsOnDate)
                {
                    ApplicationArea = All;
                }
                field(Detailed; BlnSummary)
                {
                    ApplicationArea = All;
                }
                field("Print Values (Lacs)"; PrintValuesInLacs)
                {
                    Enabled = false;
                    Visible = false;
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

    trigger OnInitReport()
    begin
        AsOnDate := TODAY - 1;

        CODEUNIT.RUN(Codeunit::"Sales Order History Mgt");
        COMMIT;

        IF PrintValuesInLacs THEN
            DicFactor := 100000
        ELSE
            DicFactor := 1;
    end;

    var
        rItem: Record Item;
        SourcePlant: Text;
        ItemPlant: Text;
        decQty: Decimal;
        AsOnDate: Date;
        IncQty: Decimal;
        OpenQty: Decimal;
        BlnSummary: Boolean;
        decValue: Decimal;
        IncValue: Decimal;
        OpenValue: Decimal;
        PrintValuesInLacs: Boolean;
        DicFactor: Decimal;
        LastItemNo: Code[20];
        Inventory: Decimal;
        MfgPlant: Text;
        RecItem: Record Item;
        MANUF: Option;

    local procedure CalculateInventory(ItemCode: Code[20]; LocCode: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Posting Date", "Entry Type", "Location Code");
        ItemLedgerEntry.SETFILTER("Item No.", '%1', ItemCode);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, AsOnDate);
        ItemLedgerEntry.SETFILTER("Location Code", '%1', LocCode);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
    end;
}

