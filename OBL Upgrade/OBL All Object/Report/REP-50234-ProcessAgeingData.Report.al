report 50234 "Process Ageing Data"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ProcessAgeingData.rdl';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            CalcFields = "Cost Amount (Expected)", "Cost Amount (Actual)";
            DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
                                WHERE(Open = CONST(true),
                                      "Location Code" = FILTER('HSK-STORE|DRA-STORE|SKD-STORE'));

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntryAgeingData: Record 50063;
            begin
                IF NOT ItemLedgerEntryAgeingData.GET(ProcessMonthDate, "Item Ledger Entry"."Entry No.") THEN BEGIN
                    ItemLedgerEntryAgeingData.INIT;
                    ItemLedgerEntryAgeingData.TRANSFERFIELDS("Item Ledger Entry");
                    ItemLedgerEntryAgeingData."Ageing Date" := ProcessMonthDate;
                    ItemLedgerEntryAgeingData."Created By" := USERID;
                    ItemLedgerEntryAgeingData."Creation date time" := CURRENTDATETIME;
                    ItemLedgerEntryAgeingData."Cost Amount" := "Item Ledger Entry"."Cost Amount (Actual)";
                    ItemLedgerEntryAgeingData."Cost Amount Expected" := "Item Ledger Entry"."Cost Amount (Expected)";
                    ItemLedgerEntryAgeingData."Cost Amount- Prop." := CalcRemValue(ItemLedgerEntryAgeingData."Remaining Quantity", ItemLedgerEntryAgeingData.Quantity, ItemLedgerEntryAgeingData."Cost Amount", ItemLedgerEntryAgeingData."Cost Amount Expected");
                    ItemLedgerEntryAgeingData."Cost Amount Expected-Prop." := CalcRemValue(ItemLedgerEntryAgeingData."Remaining Quantity", ItemLedgerEntryAgeingData.Quantity, ItemLedgerEntryAgeingData."Cost Amount", ItemLedgerEntryAgeingData."Cost Amount Expected");
                    ItemLedgerEntryAgeingData.INSERT;
                END ELSE BEGIN
                    ItemLedgerEntryAgeingData."Cost Amount" := "Item Ledger Entry"."Cost Amount (Actual)";
                    ItemLedgerEntryAgeingData."Cost Amount Expected" := "Item Ledger Entry"."Cost Amount (Expected)";
                    ItemLedgerEntryAgeingData."Cost Amount- Prop." := CalcRemValue(ItemLedgerEntryAgeingData."Remaining Quantity", ItemLedgerEntryAgeingData.Quantity, ItemLedgerEntryAgeingData."Cost Amount", ItemLedgerEntryAgeingData."Cost Amount Expected");
                    ItemLedgerEntryAgeingData."Cost Amount Expected-Prop." := CalcRemValue(ItemLedgerEntryAgeingData."Remaining Quantity", ItemLedgerEntryAgeingData.Quantity, ItemLedgerEntryAgeingData."Cost Amount", ItemLedgerEntryAgeingData."Cost Amount Expected");
                    ItemLedgerEntryAgeingData.MODIFY;
                END;
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

    trigger OnInitReport()
    begin
        ProcessMonthDate := CALCDATE('-CM', TODAY);
    end;

    var
        ProcessMonthDate: Date;

    local procedure CalcRemValue(RemQty: Decimal; TotQty: Decimal; CostAmtAct: Decimal; CostAmtExp: Decimal): Decimal
    begin
        IF (RemQty = 0) OR (TotQty = 0) THEN
            EXIT(0);
        EXIT(((CostAmtAct + CostAmtExp) / TotQty) * RemQty);
    end;
}

