report 50366 "Depot Wise Dispatch Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DepotWiseDispatchReport.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("Transfer-to Code")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date";
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(Quant300; Quant300)
            {
            }
            column(Quant395; Quant395)
            {
            }
            column(Quant400; Quant400)
            {
            }
            column(Quant600; Quant600)
            {
            }
            column(Quant700; Quant700)
            {
            }
            column(TransfertoCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(DepoName; DepoName)
            {
            }
            column(Total; Total)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Quant300 := 0;
                Quant395 := 0;
                Quant400 := 0;
                Quant600 := 0;
                Quant700 := 0;
                Total := 0;
                DepoName := '';

                IF RecLoc.GET("Transfer-to Code") THEN
                    DepoName := RecLoc.Name;

                RecTrfShpLine.RESET;
                RecTrfShpLine.SETRANGE("Document No.", "No.");
                IF RecTrfShpLine.FINDFIRST THEN
                    REPEAT
                        NewDesc := COPYSTR(RecTrfShpLine.Description, 1, 7);
                        IF RecTrfShpLine."Unit of Measure" = 'Pieces' THEN BEGIN
                            IF NewDesc = '300X300' THEN
                                Quant300 += RecTrfShpLine."Qty in Sq. Mt.";
                            IF NewDesc = '395X395' THEN
                                Quant395 += RecTrfShpLine."Qty in Sq. Mt.";
                            IF NewDesc = '400X400' THEN
                                Quant400 += RecTrfShpLine."Qty in Sq. Mt.";
                            IF NewDesc = '600X600' THEN
                                Quant600 += RecTrfShpLine."Qty in Sq. Mt.";
                            IF NewDesc = '295X295' THEN
                                Quant700 += RecTrfShpLine."Qty in Sq. Mt.";
                        END ELSE BEGIN
                            IF NewDesc = '300X300' THEN
                                Quant300 += RecTrfShpLine."Quantity (Base)";
                            IF NewDesc = '395X395' THEN
                                Quant395 += RecTrfShpLine."Quantity (Base)";
                            IF NewDesc = '400X400' THEN
                                Quant400 += RecTrfShpLine."Quantity (Base)";
                            IF NewDesc = '600X600' THEN
                                Quant600 += RecTrfShpLine."Quantity (Base)";
                            IF NewDesc = '295X295' THEN
                                Quant700 += RecTrfShpLine."Quantity (Base)";

                        END;
                    UNTIL RecTrfShpLine.NEXT = 0;

                Total := Quant300 + Quant395 + Quant400 + Quant600 + Quant700;
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

        //RepAuditMgt.CreateAudit(50366)
    end;

    var
        NewDesc: Text[30];
        RecTrfShpHdr: Record "Transfer Shipment Header";
        Quant300: Decimal;
        RecTrfShpLine: Record "Transfer Shipment Line";
        Quant395: Decimal;
        Quant400: Decimal;
        Quant600: Decimal;
        ExcelBuf: Record "Excel Buffer" temporary;
        Total: Decimal;
        PrintToExcel: Boolean;
        RecLoc: Record Location;
        DepoName: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text010: Label 'Filters';
        Text005: Label 'Company Name';
        Text007: Label 'Report Name';
        Text008: Label 'USERID';
        Text009: Label 'Date';
        Quant700: Decimal;
}

