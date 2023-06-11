report 50253 "Orders Fulfilment Details"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\OrdersFulfilmentDetails.rdl';

    dataset
    {
        dataitem("Integer"; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1));
            column(AsonDate; AsOnDate)
            {
            }
            column(SKDBookedAmt; SKDBookedAmt / 100000)
            {
            }
            column(DRABookedAmt; DRABookedAmt / 100000)
            {
            }
            column(HSKBookedAmt; HSKBookedAmt / 100000)
            {
            }
            column(TRDBookedAmt; TRDBookedAmt / 100000)
            {
            }
            column(DepotBookedAmt; DepotBookedAmt / 100000)
            {
            }
            column(SKDBookedAmtSIL; SKDBookedAmtSIL / 100000)
            {
            }
            column(DRABookedAmtSIL; DRABookedAmtSIL / 100000)
            {
            }
            column(HSKBookedAmtSIL; HSKBookedAmtSIL / 100000)
            {
            }
            column(TRDBookedAmtSIL; TRDBookedAmtSIL / 100000)
            {
            }
            column(DepotBookedAmtSIL; DepotBookedAmtSIL / 100000)
            {
            }
            column(MTDSKDBookedAmt; MTDSKDBookedAmt / 100000)
            {
            }
            column(MTDDRABookedAmt; MTDDRABookedAmt / 100000)
            {
            }
            column(MTDHSKBookedAmt; MTDHSKBookedAmt / 100000)
            {
            }
            column(MTDTRDBookedAmt; MTDTRDBookedAmt / 100000)
            {
            }
            column(MTDDepotBookedAmt; MTDDepotBookedAmt / 100000)
            {
            }
            column(MTDSKDBookedAmtSIL; MTDSKDBookedAmtSIL / 100000)
            {
            }
            column(MTDDRABookedAmtSIL; MTDDRABookedAmtSIL / 100000)
            {
            }
            column(MTDHSKBookedAmtSIL; MTDHSKBookedAmtSIL / 100000)
            {
            }
            column(MTDTRDBookedAmtSIL; MTDTRDBookedAmtSIL / 100000)
            {
            }
            column(MTDDepotBookedAmtSIL; MTDDepotBookedAmtSIL / 100000)
            {
            }
            column(SKDReleasedAmt; SKDReleasedAmt / 100000)
            {
            }
            column(DRAReleasedAmt; DRAReleasedAmt / 100000)
            {
            }
            column(HSKReleasedAmt; HSKReleasedAmt / 100000)
            {
            }
            column(TRDReleasedAmt; TRDReleasedAmt / 100000)
            {
            }
            column(DepotReleasedAmt; DepotReleasedAmt / 100000)
            {
            }
            column(MTDSKDReleasedAmt; MTDSKDReleasedAmt / 100000)
            {
            }
            column(MTDDRAReleasedAmt; MTDDRAReleasedAmt / 100000)
            {
            }
            column(MTDHSKReleasedAmt; MTDHSKReleasedAmt / 100000)
            {
            }
            column(MTDTRDReleasedAmt; MTDTRDReleasedAmt / 100000)
            {
            }
            column(MTDDepotReleasedAmt; MTDDepotReleasedAmt / 100000)
            {
            }
            column(SKDDispatchAmt; SKDDispatchAmt / 100000)
            {
            }
            column(DRADispatchAmt; DRADispatchAmt / 100000)
            {
            }
            column(HSKDispatchAmt; HSKDispatchAmt / 100000)
            {
            }
            column(TRDDispatchAmt; TRDDispatchAmt / 100000)
            {
            }
            column(DepotDispatchAmt; DepotDispatchAmt / 100000)
            {
            }
            column(MTDSKDDispatchAmt; MTDSKDDispatchAmt / 100000)
            {
            }
            column(MTDDRADispatchAmt; MTDDRADispatchAmt / 100000)
            {
            }
            column(MTDHSKDispatchAmt; MTDHSKDispatchAmt / 100000)
            {
            }
            column(MTDTRDDispatchAmt; MTDTRDDispatchAmt / 100000)
            {
            }
            column(MTDDepotDispatchAmt; MTDDepotDispatchAmt / 100000)
            {
            }
            column(SKDReleaseHdrAmt; SKDReleaseHdrAmt / 100000)
            {
            }
            column(DRAReleaseHdrAmt; DRAReleaseHdrAmt / 100000)
            {
            }
            column(HSKReleaseHdrAmt; HSKReleaseHdrAmt / 100000)
            {
            }
            column(TRDReleaseHdrAmt; TRDReleaseHdrAmt / 100000)
            {
            }
            column(DepotReleaseHdrAmt; DepotReleaseHdrAmt / 100000)
            {
            }
            column(MTDSKDReleaseHdrAmt; MTDSKDReleaseHdrAmt / 100000)
            {
            }
            column(MTDDRAReleaseHdrAmt; MTDDRAReleaseHdrAmt / 100000)
            {
            }
            column(MTDHSKReleaseHdrAmt; MTDHSKReleaseHdrAmt / 100000)
            {
            }
            column(MTDTRDReleaseHdrAmt; MTDTRDReleaseHdrAmt / 100000)
            {
            }
            column(MTDDepotReleaseHdrAmt; MTDDepotReleaseHdrAmt / 100000)
            {
            }
            column(SKDPendingToDispatch; SKDPendingToDispatch / 100000)
            {
            }
            column(DRAPendingToDispatch; DRAPendingToDispatch / 100000)
            {
            }
            column(HSKPendingToDispatch; HSKPendingToDispatch / 100000)
            {
            }
            column(TRDPendingToDispatch; TRDPendingToDispatch / 100000)
            {
            }
            column(DepotPendingToDispatch; DepotPendingToDispatch / 100000)
            {
            }
            column(SKDPendingToRelease; SKDPendingToRelease / 100000)
            {
            }
            column(DRAPendingToRelease; DRAPendingToRelease / 100000)
            {
            }
            column(HSKPendingToRelease; HSKPendingToRelease / 100000)
            {
            }
            column(TRDPendingToRelease; TRDPendingToRelease / 100000)
            {
            }
            column(DepotPendingToRelease; DepotPendingToRelease / 100000)
            {
            }
            column(SKDPendingToReleaseRetail; SKDPendingToReleaseRetail / 100000)
            {
            }
            column(DRAPendingToReleaseRetail; DRAPendingToReleaseRetail / 100000)
            {
            }
            column(HSKPendingToReleaseRetail; HSKPendingToReleaseRetail / 100000)
            {
            }
            column(TRDPendingToReleaseRetail; TRDPendingToReleaseRetail / 100000)
            {
            }
            column(DepotPendingToReleaseRetail; DepotPendingToReleaseRetail / 100000)
            {
            }
            column(SKDOverAllCancellation; SKDOverAllCancellation / 100000)
            {
            }
            column(DRAOverAllCancellation; DRAOverAllCancellation / 100000)
            {
            }
            column(HSKOverAllCancellation; HSKOverAllCancellation / 100000)
            {
            }
            column(TRDOverAllCancellation; TRDOverAllCancellation / 100000)
            {
            }
            column(DepotOverAllCancellation; DepotOverAllCancellation / 100000)
            {
            }
            column(SKDOverAllCancellationRelease; SKDOverAllCancellationRelease / 100000)
            {
            }
            column(DRAOverAllCancellationRelease; DRAOverAllCancellationRelease / 100000)
            {
            }
            column(HSKOverAllCancellationRelease; HSKOverAllCancellationRelease / 100000)
            {
            }
            column(TRDOverAllCancellationRelease; TRDOverAllCancellationRelease / 100000)
            {
            }
            column(DepotOverAllCancellationRelease; DepotOverAllCancellationRelease / 100000)
            {
            }
            column(SKDBookedQty; SKDBookedQty)
            {
            }
            column(DRABookedQty; DRABookedQty)
            {
            }
            column(HSKBookedQty; HSKBookedQty)
            {
            }
            column(TRDBookedQty; TRDBookedQty)
            {
            }
            column(DepotBookedQty; DepotBookedQty)
            {
            }
            column(SKDBookedQtySIL; SKDBookedQtySIL)
            {
            }
            column(DRABookedQtySIL; DRABookedQtySIL)
            {
            }
            column(HSKBookedQtySIL; HSKBookedQtySIL)
            {
            }
            column(TRDBookedQtySIL; TRDBookedQtySIL)
            {
            }
            column(DepotBookedQtySIL; DepotBookedQtySIL)
            {
            }
            column(MTDSKDBookedQty; MTDSKDBookedQty)
            {
            }
            column(MTDDRABookedQty; MTDDRABookedQty)
            {
            }
            column(MTDHSKBookedQty; MTDHSKBookedQty)
            {
            }
            column(MTDTRDBookedQty; MTDTRDBookedQty)
            {
            }
            column(MTDDepotBookedQty; MTDDepotBookedQty)
            {
            }
            column(MTDSKDBookedQtySIL; MTDSKDBookedQtySIL)
            {
            }
            column(MTDDRABookedQtySIL; MTDDRABookedQtySIL)
            {
            }
            column(MTDHSKBookedQtySIL; MTDHSKBookedQtySIL)
            {
            }
            column(MTDTRDBookedQtySIL; MTDTRDBookedQtySIL)
            {
            }
            column(MTDDepotBookedQtySIL; MTDDepotBookedQtySIL)
            {
            }
            column(SKDReleasedQty; SKDReleasedQty)
            {
            }
            column(DRAReleasedQty; DRAReleasedQty)
            {
            }
            column(HSKReleasedQty; HSKReleasedQty)
            {
            }
            column(TRDReleasedQty; TRDReleasedQty)
            {
            }
            column(DepotReleasedQty; DepotReleasedQty)
            {
            }
            column(MTDSKDReleasedQty; MTDSKDReleasedQty)
            {
            }
            column(MTDDRAReleasedQty; MTDDRAReleasedQty)
            {
            }
            column(MTDHSKReleasedQty; MTDHSKReleasedQty)
            {
            }
            column(MTDTRDReleasedQty; MTDTRDReleasedQty)
            {
            }
            column(MTDDepotReleasedQty; MTDDepotReleasedQty)
            {
            }
            column(SKDDispatchQty; SKDDispatchQty)
            {
            }
            column(DRADispatchQty; DRADispatchQty)
            {
            }
            column(HSKDispatchQty; HSKDispatchQty)
            {
            }
            column(TRDDispatchQty; TRDDispatchQty)
            {
            }
            column(DepotDispatchQty; DepotDispatchQty)
            {
            }
            column(MTDSKDDispatchQty; MTDSKDDispatchQty)
            {
            }
            column(MTDDRADispatchQty; MTDDRADispatchQty)
            {
            }
            column(MTDHSKDispatchQty; MTDHSKDispatchQty)
            {
            }
            column(MTDTRDDispatchQty; MTDTRDDispatchQty)
            {
            }
            column(MTDDepotDispatchQty; MTDDepotDispatchQty)
            {
            }
            column(SKDReleaseHdrQty; SKDReleaseHdrQty)
            {
            }
            column(DRAReleaseHdrQty; DRAReleaseHdrQty)
            {
            }
            column(HSKReleaseHdrQty; HSKReleaseHdrQty)
            {
            }
            column(TRDReleaseHdrQty; TRDReleaseHdrQty)
            {
            }
            column(DepotReleaseHdrQty; DepotReleaseHdrQty)
            {
            }
            column(MTDSKDReleaseHdrQty; MTDSKDReleaseHdrQty)
            {
            }
            column(MTDDRAReleaseHdrQty; MTDDRAReleaseHdrQty)
            {
            }
            column(MTDHSKReleaseHdrQty; MTDHSKReleaseHdrQty)
            {
            }
            column(MTDTRDReleaseHdrQty; MTDTRDReleaseHdrQty)
            {
            }
            column(MTDDepotReleaseHdrQty; MTDDepotReleaseHdrQty)
            {
            }
            column(SKDPendingToDispatchQty; SKDPendingToDispatchQty)
            {
            }
            column(DRAPendingToDispatchQty; DRAPendingToDispatchQty)
            {
            }
            column(HSKPendingToDispatchQty; HSKPendingToDispatchQty)
            {
            }
            column(TRDPendingToDispatchQty; TRDPendingToDispatchQty)
            {
            }
            column(DepotPendingToDispatchQty; DepotPendingToDispatchQty)
            {
            }
            column(SKDPendingToReleaseQty; SKDPendingToReleaseQty)
            {
            }
            column(DRAPendingToReleaseQty; DRAPendingToReleaseQty)
            {
            }
            column(HSKPendingToReleaseQty; HSKPendingToReleaseQty)
            {
            }
            column(TRDPendingToReleaseQty; TRDPendingToReleaseQty)
            {
            }
            column(DepotPendingToReleaseQty; DepotPendingToReleaseQty)
            {
            }
            column(SKDPendingToReleaseRetailQty; SKDPendingToReleaseRetailQty)
            {
            }
            column(DRAPendingToReleaseRetailQty; DRAPendingToReleaseRetailQty)
            {
            }
            column(HSKPendingToReleaseRetailQty; HSKPendingToReleaseRetailQty)
            {
            }
            column(TRDPendingToReleaseRetailQty; TRDPendingToReleaseRetailQty)
            {
            }
            column(DepotPendingToReleaseRetailQty; DepotPendingToReleaseRetailQty)
            {
            }
            column(SKDOverAllCancellationQty; SKDOverAllCancellationQty)
            {
            }
            column(DRAOverAllCancellationQty; DRAOverAllCancellationQty)
            {
            }
            column(HSKOverAllCancellationQty; HSKOverAllCancellationQty)
            {
            }
            column(TRDOverAllCancellationQty; TRDOverAllCancellationQty)
            {
            }
            column(DepotOverAllCancellationQty; DepotOverAllCancellationQty)
            {
            }
            column(SKDOverAllCancellationReleaseQty; SKDOverAllCancellationReleaseQty)
            {
            }
            column(DRAOverAllCancellationReleaseQty; DRAOverAllCancellationReleaseQty)
            {
            }
            column(HSKOverAllCancellationReleaseQty; HSKOverAllCancellationReleaseQty)
            {
            }
            column(TRDOverAllCancellationReleaseQty; TRDOverAllCancellationReleaseQty)
            {
            }
            column(DepotOverAllCancellationReleaseQty; DepotOverAllCancellationReleaseQty)
            {
            }

            trigger OnAfterGetRecord()
            var
                SalesInvoiceLine: Record "Sales Invoice Line";
                MakeOrderDt: Date;
            begin
                SalesHeader.RESET;
                SalesHeader.SETRANGE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
                IF SalesHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        MakeOrderDt := DT2DATE(SalesHeader."Make Order Date");
                        //    IF (MakeOrderDt < MnthStartDate) AND (MakeOrderDt>MnthEndDate)
                        //    THEN CurrReport.SKIP;
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY(SalesLine."Document No.", SalesLine."No.");
                        SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                DtReleaseDt := 0D;
                                DtReleaseDt := GetReleaseDate(SalesLine);
                                IF (DtReleaseDt < MnthStartDate) AND (DtReleaseDt > MnthEndDate) THEN CurrReport.SKIP;
                                CASE MakeOrderDt OF
                                    AsOnDate - 1:
                                        BEGIN
                                            IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                                SKDBookedAmt += SalesLine."Outstanding Amount";
                                                SKDBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                                DRABookedAmt += SalesLine."Outstanding Amount";
                                                DRABookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                                HSKBookedAmt += SalesLine."Outstanding Amount";
                                                HSKBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER']) THEN BEGIN
                                                TRDBookedAmt += SalesLine."Outstanding Amount";
                                                TRDBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER') AND
                                              (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                                //IF COPYSTR(SalesLine."Location Code",1,3)= 'DP-' THEN
                                                DepotBookedAmt += SalesLine."Outstanding Amount";
                                                DepotBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                        END;
                                    MnthStartDate .. MnthEndDate:
                                        BEGIN
                                            IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                                MTDSKDBookedAmt += SalesLine."Outstanding Amount";
                                                MTDSKDBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                                MTDDRABookedAmt += SalesLine."Outstanding Amount";
                                                MTDDRABookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                                MTDHSKBookedAmt += SalesLine."Outstanding Amount";
                                                MTDHSKBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER']) THEN BEGIN
                                                MTDTRDBookedAmt += SalesLine."Outstanding Amount";
                                                MTDTRDBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            //ELSE
                                            //IF COPYSTR(SalesLine."Location Code",1,3)= 'DP-' THEN
                                            IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER') AND
                                              (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                                MTDDepotBookedAmt += SalesLine."Outstanding Amount";
                                                MTDDepotBookedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                        END;
                                END;
                                //
                                CASE (DtReleaseDt) OF
                                    AsOnDate - 1:
                                        BEGIN
                                            IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                                SKDReleasedAmt += SalesLine."Outstanding Amount";
                                                SKDReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                                DRAReleasedAmt += SalesLine."Outstanding Amount";
                                                DRAReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                                HSKReleasedAmt += SalesLine."Outstanding Amount";
                                                HSKReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER']) THEN BEGIN
                                                TRDReleasedAmt += SalesLine."Outstanding Amount";
                                                TRDReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER') AND
                                              (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                                //IF COPYSTR(SalesLine."Location Code",1,3)= 'DP-' THEN
                                                DepotReleasedAmt += SalesLine."Outstanding Amount";
                                                DepotReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                        END;
                                    MnthStartDate .. MnthEndDate:
                                        BEGIN
                                            IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                                MTDSKDReleasedAmt += SalesLine."Outstanding Amount";
                                                MTDSKDReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                                MTDDRAReleasedAmt += SalesLine."Outstanding Amount";
                                                MTDDRAReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                                MTDHSKReleasedAmt += SalesLine."Outstanding Amount";
                                                MTDHSKReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER']) THEN BEGIN
                                                MTDTRDReleasedAmt += SalesLine."Outstanding Amount";
                                                MTDTRDReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER') AND
                                              (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                                MTDDepotReleasedAmt += SalesLine."Outstanding Amount";
                                                MTDDepotReleasedQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                        END;
                                END;


                                //*

                                IF SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER'] THEN
                                    //IF (SalesLine."Quantity Invoiced" = 0) AND (SalesLine."Outstanding Amount">0) THEN
                                    IF SalesLine."Outstanding Amount" > 0 THEN
                                        IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                                            IF SalesHeader."Payment Date 3" <> 0D THEN BEGIN
                                                TRDPendingToDispatch += SalesLine."Outstanding Amount";
                                                TRDPendingToDispatchQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                /*
                                    IF (SalesLine."Location Code"='DP-MORBI') AND (SalesLine."Location Code"='DP-BIKANER') AND (SalesLine."Outstanding Amount">0) THEN BEGIN
                                        IF SalesHeader.GET(SalesLine."Document Type",SalesLine."Document No.") THEN
                                          IF SalesHeader."Payment Date 3"<> 0D THEN BEGIN
                                            TRDPendingToDispatch += SalesLine."Outstanding Amount";
                                            TRDPendingToDispatchQty += SalesLine."Outstanding Qty. (Base)";
                                          END;
                                    END;
                                */
                                IF (SalesLine.Status = SalesLine.Status::Released) AND (SalesLine."Quantity Invoiced" = 0) AND (SalesLine."Outstanding Amount" > 0) THEN BEGIN
                                    IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                        SKDPendingToDispatch += SalesLine."Outstanding Amount";
                                        SKDPendingToDispatchQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                        DRAPendingToDispatch += SalesLine."Outstanding Amount";
                                        DRAPendingToDispatchQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                        HSKPendingToDispatch += SalesLine."Outstanding Amount";
                                        HSKPendingToDispatchQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER')
                                          AND (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                        DepotPendingToDispatch += SalesLine."Outstanding Amount";
                                        DepotPendingToDispatchQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;

                                IF (SalesLine."Location Code" = 'DP-MORBI') OR (SalesLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    // IF SalesHeader.GET(SalesLine."Document Type",SalesLine."Document No.") THEN  //Rk200821
                                    IF SalesHeader."Payment Date 3" = 0D THEN BEGIN
                                        TRDPendingToRelease += SalesLine."Outstanding Amount";
                                        TRDPendingToReleaseQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;
                                //MESSAGE('%1  =%2', SalesHeader."Payment Date 3",TRDPendingToRelease);
                                IF (SalesLine.Status <> SalesLine.Status::Released) THEN BEGIN
                                    IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                        SKDPendingToRelease += SalesLine."Outstanding Amount";
                                        SKDPendingToReleaseQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                        DRAPendingToRelease += SalesLine."Outstanding Amount";
                                        DRAPendingToReleaseQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                        HSKPendingToRelease += SalesLine."Outstanding Amount";
                                        HSKPendingToReleaseQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER')
                                          AND (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                        DepotPendingToRelease += SalesLine."Outstanding Amount";
                                        DepotPendingToReleaseQty += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;

                                IF SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER'] THEN
                                    IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                                        IF (SalesHeader."Payment Date 3" = 0D) AND (SalesHeader."Customer Type" <> 'CKA') AND (SalesHeader."Customer Type" <> 'DIRECTPROJ') THEN BEGIN
                                            TRDPendingToReleaseRetail += SalesLine."Outstanding Amount";
                                            TRDPendingToReleaseRetailQty += SalesLine."Outstanding Qty. (Base)";
                                        END;

                                IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP_BIKANER') THEN BEGIN
                                    IF (SalesHeader.Status <> SalesHeader.Status::Released) AND (SalesHeader."Customer Type" <> 'CKA') AND (SalesHeader."Customer Type" <> 'DIRECTPROJ') THEN
                                        IF (SalesLine.Status <> SalesLine.Status::Released) THEN BEGIN
                                            IF SalesLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                                SKDPendingToReleaseRetail += SalesLine."Outstanding Amount";
                                                SKDPendingToReleaseRetailQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                                DRAPendingToReleaseRetail += SalesLine."Outstanding Amount";
                                                DRAPendingToReleaseRetailQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF SalesLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                                HSKPendingToReleaseRetail += SalesLine."Outstanding Amount";
                                                HSKPendingToReleaseRetailQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                            IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER')
                                                  AND (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                                DepotPendingToReleaseRetail += SalesLine."Outstanding Amount";
                                                DepotPendingToReleaseRetailQty += SalesLine."Outstanding Qty. (Base)";
                                            END;
                                        END;
                                END;

                            //*
                            UNTIL SalesLine.NEXT = 0;
                    UNTIL SalesHeader.NEXT = 0;
                END;
                /*
                SKDDispatchAmt := GetDispatchAmt('SKD',AsOnDate-1,AsOnDate-1,TRUE);
                DRADispatchAmt := GetDispatchAmt('DRA',AsOnDate-1,AsOnDate-1,TRUE);
                HSKDispatchAmt := GetDispatchAmt('HSK',AsOnDate-1,AsOnDate-1,TRUE);
                TRDDispatchAmt := GetDispatchAmt('TRD',AsOnDate-1,AsOnDate-1,TRUE);
                DepotDispatchAmt := (GetDispatchAmt('DEPOT',AsOnDate-1,AsOnDate-1,TRUE)-GetDispatchAmt('TRD',AsOnDate-1,AsOnDate-1,TRUE));
                
                MTDSKDDispatchAmt := GetDispatchAmt('SKD',MnthStartDate,MnthEndDate,TRUE);
                MTDDRADispatchAmt := GetDispatchAmt('DRA',MnthStartDate,MnthEndDate,TRUE);
                MTDHSKDispatchAmt := GetDispatchAmt('HSK',MnthStartDate,MnthEndDate,TRUE);
                MTDTRDDispatchAmt := GetDispatchAmt('TRD',MnthStartDate,MnthEndDate,TRUE);
                MTDDepotDispatchAmt := GetDispatchAmt('DEPOT',MnthStartDate,MnthEndDate,TRUE);
                
                SKDDispatchQty := GetDispatchQty('SKD',AsOnDate-1,AsOnDate-1,TRUE);
                DRADispatchQty := GetDispatchQty('DRA',AsOnDate-1,AsOnDate-1,TRUE);
                HSKDispatchQty := GetDispatchQty('HSK',AsOnDate-1,AsOnDate-1,TRUE);
                TRDDispatchQty := GetDispatchQty('TRD',AsOnDate-1,AsOnDate-1,TRUE);
                DepotDispatchQty := (GetDispatchQty('DEPOT',AsOnDate-1,AsOnDate-1,TRUE)-GetDispatchQty('TRD',AsOnDate-1,AsOnDate-1,TRUE));
                
                MTDSKDDispatchQty := GetDispatchQty('SKD',MnthStartDate,MnthEndDate,TRUE);
                MTDDRADispatchQty := GetDispatchQty('DRA',MnthStartDate,MnthEndDate,TRUE);
                MTDHSKDispatchQty := GetDispatchQty('HSK',MnthStartDate,MnthEndDate,TRUE);
                MTDTRDDispatchQty := GetDispatchQty('TRD',MnthStartDate,MnthEndDate,TRUE);
                MTDDepotDispatchQty := GetDispatchQty('DEPOT',MnthStartDate,MnthEndDate,TRUE);
                */


                //>>>>Cancellation>>>>>
                ArchiveHeader.RESET;
                ArchiveHeader.SETCURRENTKEY(ArchiveHeader."No.");
                ArchiveHeader.SETFILTER(ArchiveHeader."Document Type", '%1', ArchiveHeader."Document Type"::Order);
                ArchiveHeader.SETFILTER(ArchiveHeader."Reason Code", '<>%1', '');
                ArchiveHeader.SETRANGE(ArchiveHeader."Order Date", MnthStartDate, MnthEndDate);
                IF ArchiveHeader.FINDLAST THEN BEGIN
                    RpDocumentNo := '';
                    REPEAT
                        IF (ArchiveHeader."No." <> RpDocumentNo) THEN BEGIN
                            ArchiveLine.RESET;
                            ArchiveLine.SETCURRENTKEY(ArchiveLine."Document No.", ArchiveLine."Line No.");
                            ArchiveLine.SETRANGE(ArchiveLine."Document Type", ArchiveHeader."Document Type"::Order);
                            ArchiveLine.SETRANGE(ArchiveLine."Document No.", ArchiveHeader."No.");
                            ArchiveLine.SETRANGE(ArchiveLine."Version No.", ArchiveHeader."Version No.");
                            ArchiveLine.SETFILTER(ArchiveLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                            //ArchiveLine.SETFILTER("Quantity Invoiced",'%1',0);
                            ArchiveLine.SETFILTER(ArchiveLine."Outstanding Amount", '>%1', 0);
                            IF ArchiveLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF ArchiveLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                        SKDOverAllCancellation += ArchiveLine."Outstanding Amount";
                                        SKDOverAllCancellationQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF ArchiveLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                        DRAOverAllCancellation += ArchiveLine."Outstanding Amount";
                                        DRAOverAllCancellationQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF ArchiveLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                        HSKOverAllCancellation += ArchiveLine."Outstanding Amount";
                                        HSKOverAllCancellationQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF (ArchiveLine."Location Code" = 'DP-MORBI') OR (ArchiveLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                        TRDOverAllCancellation += ArchiveLine."Outstanding Amount";
                                        TRDOverAllCancellationQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF (ArchiveLine."Location Code" <> 'DP-MORBI') AND (ArchiveLine."Location Code" <> 'DP-BIKANER')
                                        AND (COPYSTR(ArchiveLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                        DepotOverAllCancellation += ArchiveLine."Outstanding Amount";
                                        DepotOverAllCancellationQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                UNTIL ArchiveLine.NEXT = 0;
                            END;
                        END;
                        RpDocumentNo := ArchiveHeader."No.";
                    UNTIL ArchiveHeader.NEXT(-1) = 0;
                END;

                ArchiveHeader.RESET;
                ArchiveHeader.SETCURRENTKEY(ArchiveHeader."No.");
                ArchiveHeader.SETFILTER(ArchiveHeader."Document Type", '%1', ArchiveHeader."Document Type"::Order);
                ArchiveHeader.SETFILTER(ArchiveHeader."Reason Code", '<>%1', '');
                ArchiveHeader.SETRANGE(ArchiveHeader."Releasing Date", MnthStartDate, MnthEndDate);
                IF ArchiveHeader.FINDLAST THEN BEGIN
                    RpDocumentNo := '';
                    REPEAT
                        IF (ArchiveHeader."No." <> RpDocumentNo) THEN BEGIN
                            ArchiveLine.RESET;
                            ArchiveLine.SETCURRENTKEY(ArchiveLine."Document No.", ArchiveLine."Line No.");
                            ArchiveLine.SETRANGE(ArchiveLine."Document Type", ArchiveHeader."Document Type"::Order);
                            ArchiveLine.SETRANGE(ArchiveLine."Document No.", ArchiveHeader."No.");
                            ArchiveLine.SETRANGE(ArchiveLine."Version No.", ArchiveHeader."Version No.");
                            ArchiveLine.SETFILTER(ArchiveLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                            //ArchiveLine.SETFILTER("Quantity Invoiced",'%1',0);
                            ArchiveLine.SETFILTER(ArchiveLine."Outstanding Amount", '>%1', 0);
                            IF ArchiveLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF ArchiveLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                        SKDOverAllCancellationRelease += ArchiveLine."Outstanding Amount";
                                        SKDOverAllCancellationReleaseQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF ArchiveLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                        DRAOverAllCancellationRelease += ArchiveLine."Outstanding Amount";
                                        DRAOverAllCancellationReleaseQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF ArchiveLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                        HSKOverAllCancellationRelease += ArchiveLine."Outstanding Amount";
                                        HSKOverAllCancellationReleaseQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                    IF (ArchiveLine."Location Code" <> 'DP-MORBI') AND (ArchiveLine."Location Code" <> 'DP-BIKANER')
                                        AND (COPYSTR(ArchiveLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                        DepotOverAllCancellationRelease += ArchiveLine."Outstanding Amount";
                                        DepotOverAllCancellationReleaseQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                UNTIL ArchiveLine.NEXT = 0;
                            END;
                        END;
                        RpDocumentNo := ArchiveHeader."No.";
                    UNTIL ArchiveHeader.NEXT(-1) = 0;
                END;

                ArchiveHeader.RESET;
                ArchiveHeader.SETCURRENTKEY(ArchiveHeader."No.");
                ArchiveHeader.SETFILTER(ArchiveHeader."Document Type", '%1', ArchiveHeader."Document Type"::Order);
                ArchiveHeader.SETFILTER(ArchiveHeader."Reason Code", '<>%1', '');
                ArchiveHeader.SETRANGE(ArchiveHeader."Payment Date 3", MnthStartDate, MnthEndDate);
                IF ArchiveHeader.FINDLAST THEN BEGIN
                    RpDocumentNo := '';
                    REPEAT
                        IF (ArchiveHeader."No." <> RpDocumentNo) THEN BEGIN
                            ArchiveLine.RESET;
                            ArchiveLine.SETCURRENTKEY(ArchiveLine."Document No.", ArchiveLine."Line No.");
                            ArchiveLine.SETRANGE(ArchiveLine."Document Type", ArchiveHeader."Document Type"::Order);
                            ArchiveLine.SETRANGE(ArchiveLine."Document No.", ArchiveHeader."No.");
                            ArchiveLine.SETRANGE(ArchiveLine."Version No.", ArchiveHeader."Version No.");
                            ArchiveLine.SETFILTER(ArchiveLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                            //ArchiveLine.SETFILTER("Quantity Invoiced",'%1',0);
                            ArchiveLine.SETFILTER(ArchiveLine."Outstanding Amount", '>%1', 0);
                            IF ArchiveLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF (ArchiveLine."Location Code" = 'DP-MORBI') OR (ArchiveLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                        TRDOverAllCancellationRelease += ArchiveLine."Outstanding Amount";
                                        TRDOverAllCancellationReleaseQty += ArchiveLine."Outstanding Qty. (Base)";
                                    END;
                                UNTIL ArchiveLine.NEXT = 0;
                            END;
                        END;
                        RpDocumentNo := ArchiveHeader."No.";
                    UNTIL ArchiveHeader.NEXT(-1) = 0;
                END;

                TRDOverAllCancellationReleaseTot := TRDOverAllCancellationRelease;

                //<<<<<Cancellation<<<<

                //Releasing from Archive>>>>>
                //120821>>> Closed
                /*
                ArchiveHeader.RESET;
                ArchiveHeader.SETCURRENTKEY("No.");
                ArchiveHeader.SETFILTER("Document Type",'%1',ArchiveHeader."Document Type"::Order);
                ArchiveHeader.SETRANGE("Releasing Date",AsOnDate-1);
                IF ArchiveHeader.FINDLAST THEN BEGIN
                  RpDocumentNo := '';
                  REPEAT
                    IF (ArchiveHeader."No." <> RpDocumentNo) THEN BEGIN
                      ArchiveLine.RESET;
                      ArchiveLine.SETCURRENTKEY("Document No.","Line No.");
                      ArchiveLine.SETRANGE("Document Type",ArchiveHeader."Document Type"::Order);
                      ArchiveLine.SETRANGE("Document No.",ArchiveHeader."No.");
                      ArchiveLine.SETRANGE("Version No.",ArchiveHeader."Version No.");
                      ArchiveLine.SETFILTER("Item Category Code",'%1|%2|%3|%4','M001','T001','D001','H001');
                      IF ArchiveLine.FINDSET THEN BEGIN
                        REPEAT
                          IF ArchiveLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                            SKDReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            SKDReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF ArchiveLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                            DRAReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            DRAReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF ArchiveLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                            HSKReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            HSKReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF (ArchiveLine."Location Code" = 'DP-MORBI') OR (ArchiveLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                            TRDReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            TRDReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF (ArchiveLine."Location Code" <> 'DP-MORBI') AND (ArchiveLine."Location Code" <> 'DP-BIKANER')
                              AND (COPYSTR(ArchiveLine."Location Code",1,3) = 'DP-') THEN BEGIN
                            DepotReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            DepotReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                        UNTIL ArchiveLine.NEXT = 0;
                      END;
                    END;
                    RpDocumentNo := ArchiveHeader."No.";
                  UNTIL ArchiveHeader.NEXT(-1) =0 ;
                END;
                
                ArchiveHeader.RESET;
                ArchiveHeader.SETCURRENTKEY("No.");
                ArchiveHeader.SETFILTER("Document Type",'%1',ArchiveHeader."Document Type"::Order);
                ArchiveHeader.SETRANGE("Releasing Date",MnthStartDate,MnthEndDate);
                IF ArchiveHeader.FINDLAST THEN BEGIN
                  RpDocumentNo := '';
                  REPEAT
                    IF (ArchiveHeader."No." <> RpDocumentNo) THEN BEGIN
                      ArchiveLine.RESET;
                      ArchiveLine.SETCURRENTKEY("Document No.","Line No.");
                      ArchiveLine.SETRANGE("Document Type",ArchiveHeader."Document Type"::Order);
                      ArchiveLine.SETRANGE("Document No.",ArchiveHeader."No.");
                      ArchiveLine.SETRANGE("Version No.",ArchiveHeader."Version No.");
                      ArchiveLine.SETFILTER("Item Category Code",'%1|%2|%3|%4','M001','T001','D001','H001');
                      IF ArchiveLine.FINDSET THEN BEGIN
                        REPEAT
                          IF ArchiveLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                            MTDSKDReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            MTDSKDReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF ArchiveLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                            MTDDRAReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            MTDDRAReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF ArchiveLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                            MTDHSKReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            MTDHSKReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                          IF (ArchiveLine."Location Code" <> 'DP-MORBI') AND (ArchiveLine."Location Code" <> 'DP-BIKANER')
                              AND (COPYSTR(ArchiveLine."Location Code",1,3) = 'DP-') THEN BEGIN
                            MTDDepotReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            MTDDepotReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                        UNTIL ArchiveLine.NEXT = 0;
                      END;
                    END;
                    RpDocumentNo := ArchiveHeader."No.";
                  UNTIL ArchiveHeader.NEXT(-1) =0 ;
                END;
                
                ArchiveHeader.RESET;
                ArchiveHeader.SETCURRENTKEY("No.");
                ArchiveHeader.SETFILTER("Document Type",'%1',ArchiveHeader."Document Type"::Order);
                ArchiveHeader.SETRANGE("Payment Date 3",MnthStartDate,MnthEndDate);
                IF ArchiveHeader.FINDLAST THEN BEGIN
                  RpDocumentNo := '';
                  REPEAT
                    IF (ArchiveHeader."No." <> RpDocumentNo) THEN BEGIN
                      ArchiveLine.RESET;
                      ArchiveLine.SETCURRENTKEY("Document No.","Line No.");
                      ArchiveLine.SETRANGE("Document Type",ArchiveHeader."Document Type"::Order);
                      ArchiveLine.SETRANGE("Document No.",ArchiveHeader."No.");
                      ArchiveLine.SETRANGE("Version No.",ArchiveHeader."Version No.");
                      ArchiveLine.SETFILTER("Item Category Code",'%1|%2|%3|%4','M001','T001','D001','H001');
                      IF ArchiveLine.FINDSET THEN BEGIN
                        REPEAT
                          IF (ArchiveLine."Location Code" = 'DP-MORBI') OR (ArchiveLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                            MTDTRDReleaseHdrAmt += ArchiveLine."Outstanding Amount";
                            MTDTRDReleaseHdrQty += ArchiveLine."Outstanding Qty. (Base)";
                          END;
                        UNTIL ArchiveLine.NEXT = 0;
                      END;
                    END;
                    RpDocumentNo := ArchiveHeader."No.";
                  UNTIL ArchiveHeader.NEXT(-1) =0 ;
                END;
                */
                //120821Close<<<

                //Booked>>>>>
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Order Date", AsOnDate - 1);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDSET THEN BEGIN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                    SKDBookedAmtSIL += SalesInvoiceLine.Amount;
                                    SKDBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                    DRABookedAmtSIL += SalesInvoiceLine.Amount;
                                    DRABookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                    HSKBookedAmtSIL += SalesInvoiceLine.Amount;
                                    HSKBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    //MESSAGE('%1=%2 = %3',SalesInvoiceLine."Document No.",SalesInvoiceLine."Line No.",SalesInvoiceLine."Quantity (Base)");
                                END;
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    TRDBookedAmtSIL += SalesInvoiceLine.Amount;
                                    TRDBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER')
                                    AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    DepotBookedAmtSIL += SalesInvoiceLine.Amount;
                                    DepotBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;
                END;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Order Date", MnthStartDate, MnthEndDate);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDSET THEN BEGIN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                    MTDSKDBookedAmtSIL += SalesInvoiceLine.Amount;
                                    MTDSKDBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                    MTDDRABookedAmtSIL += SalesInvoiceLine.Amount;
                                    MTDDRABookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                    MTDHSKBookedAmtSIL += SalesInvoiceLine.Amount;
                                    MTDHSKBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    //MESSAGE('%1=%2 = %3',SalesInvoiceLine."Document No.",SalesInvoiceLine."Line No.",SalesInvoiceLine."Quantity (Base)");
                                END;
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    MTDTRDBookedAmtSIL += SalesInvoiceLine.Amount;
                                    MTDTRDBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER')
                                    AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    MTDDepotBookedAmtSIL += SalesInvoiceLine.Amount;
                                    MTDDepotBookedQtySIL += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;
                END;

                //Release>>>>>
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Posting Date", '%1', AsOnDate - 1);
                SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Releasing Date", '%1', AsOnDate - 1);
                IF SalesInvoiceHeader.FINDFIRST THEN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                    SKDReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    SKDReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                    DRAReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    DRAReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                    HSKReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    HSKReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER')
                                   AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    DepotReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    DepotReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    //END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Posting Date", '%1', AsOnDate - 1);
                SalesInvoiceHeader.SETFILTER(SalesInvoiceHeader."Payment Date 3", '%1', AsOnDate - 1);
                IF SalesInvoiceHeader.FINDFIRST THEN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    TRDReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    TRDReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    //END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;

                SalesInvoiceHeader.RESET;
                //SalesInvoiceHeader.SETRANGE("Posting Date",MnthStartDate,MnthEndDate);
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Releasing Date", MnthStartDate, MnthEndDate);
                IF SalesInvoiceHeader.FINDFIRST THEN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                    MTDSKDReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    MTDSKDReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                    MTDDRAReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    MTDDRAReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                    MTDHSKReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    MTDHSKReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER')
                                   AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    MTDDepotReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    MTDDepotReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    //END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;

                SalesInvoiceHeader.RESET;
                //SalesInvoiceHeader.SETRANGE("Posting Date",MnthStartDate,MnthEndDate);
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Payment Date 3", MnthStartDate, MnthEndDate);
                IF SalesInvoiceHeader.FINDFIRST THEN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    MTDTRDReleaseHdrAmt += SalesInvoiceLine.Amount;
                                    MTDTRDReleaseHdrQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    //END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;

                //Dispatch>>>>>
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Posting Date", AsOnDate - 1);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDSET THEN BEGIN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                    SKDDispatchAmt += SalesInvoiceLine.Amount;
                                    SKDDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                    DRADispatchAmt += SalesInvoiceLine.Amount;
                                    DRADispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                    HSKDispatchAmt += SalesInvoiceLine.Amount;
                                    HSKDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    TRDDispatchAmt += SalesInvoiceLine.Amount;
                                    TRDDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER')
                                    AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    DepotDispatchAmt += SalesInvoiceLine.Amount;
                                    DepotDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;
                END;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Posting Date", MnthStartDate, MnthEndDate);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDSET THEN BEGIN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                                    MTDSKDDispatchAmt += SalesInvoiceLine.Amount;
                                    MTDSKDDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                                    MTDDRADispatchAmt += SalesInvoiceLine.Amount;
                                    MTDDRADispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF SalesInvoiceLine."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                                    MTDHSKDispatchAmt += SalesInvoiceLine.Amount;
                                    MTDHSKDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    MTDTRDDispatchAmt += SalesInvoiceLine.Amount;
                                    MTDTRDDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER')
                                    AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    MTDDepotDispatchAmt += SalesInvoiceLine.Amount;
                                    MTDDepotDispatchQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;
                END;

                MTDSKDBookedAmt := MTDSKDBookedAmt + SKDBookedAmt;
                MTDSKDBookedQty := MTDSKDBookedQty + SKDBookedQty;
                MTDDRABookedAmt := MTDDRABookedAmt + DRABookedAmt;
                MTDDRABookedQty := MTDDRABookedQty + DRABookedQty;
                MTDHSKBookedAmt := MTDHSKBookedAmt + HSKBookedAmt;
                MTDHSKBookedQty := MTDHSKBookedQty + HSKBookedQty;
                MTDTRDBookedAmt := MTDTRDBookedAmt + TRDBookedAmt;
                MTDTRDBookedQty := MTDTRDBookedQty + TRDBookedQty;
                MTDDepotBookedAmt := MTDDepotBookedAmt + DepotBookedAmt;
                MTDDepotBookedQty := MTDDepotBookedQty + DepotBookedQty;

                MTDSKDReleasedAmt := MTDSKDReleasedAmt + SKDReleasedAmt;
                MTDSKDReleasedQty := MTDSKDReleasedQty + SKDReleasedQty;
                MTDDRAReleasedAmt := MTDDRAReleasedAmt + DRAReleasedAmt;
                MTDDRAReleasedQty := MTDDRAReleasedQty + DRAReleasedQty;
                MTDHSKReleasedAmt := MTDHSKReleasedAmt + HSKReleasedAmt;
                MTDHSKReleasedQty := MTDHSKReleasedQty + HSKReleasedQty;
                MTDTRDReleasedAmt := MTDTRDReleasedAmt + TRDReleasedAmt;
                MTDTRDReleasedQty := MTDTRDReleasedQty + TRDReleasedQty;
                MTDDepotReleasedAmt := MTDDepotReleasedAmt + DepotReleasedAmt;
                MTDDepotReleasedQty := MTDDepotReleasedQty + DepotReleasedQty;

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
        AsOnDate := TODAY;
        //AsOnDate := 040821D; //Testing On Test
        MnthStartDate := CALCDATE('-CM', AsOnDate - 1);
        MnthEndDate := AsOnDate - 1;
        //ERROR('%1= %2',MnthStartDate,MnthEndDate);
    end;

    var
        Booked: Decimal;
        Released: Decimal;
        Dispatched: Decimal;
        SalesLine: Record "Sales Line";
        AsOnDate: Date;
        MnthStartDate: Date;
        MnthEndDate: Date;
        DtReleaseDt: Date;
        SalesHeader: Record "Sales Header";
        ArchiveHeader: Record "Sales Header Archive";
        ArchiveLine: Record "Sales Line Archive";
        RpDocumentNo: Text;
        SKDBookedAmt: Decimal;
        DRABookedAmt: Decimal;
        HSKBookedAmt: Decimal;
        TRDBookedAmt: Decimal;
        DepotBookedAmt: Decimal;
        SKDReleasedAmt: Decimal;
        DRAReleasedAmt: Decimal;
        HSKReleasedAmt: Decimal;
        TRDReleasedAmt: Decimal;
        DepotReleasedAmt: Decimal;
        SKDDispatchAmt: Decimal;
        DRADispatchAmt: Decimal;
        HSKDispatchAmt: Decimal;
        TRDDispatchAmt: Decimal;
        DepotDispatchAmt: Decimal;
        MTDSKDBookedAmt: Decimal;
        MTDDRABookedAmt: Decimal;
        MTDHSKBookedAmt: Decimal;
        MTDTRDBookedAmt: Decimal;
        MTDDepotBookedAmt: Decimal;
        MTDSKDReleasedAmt: Decimal;
        MTDDRAReleasedAmt: Decimal;
        MTDHSKReleasedAmt: Decimal;
        MTDTRDReleasedAmt: Decimal;
        MTDDepotReleasedAmt: Decimal;
        MTDSKDDispatchAmt: Decimal;
        MTDDRADispatchAmt: Decimal;
        MTDHSKDispatchAmt: Decimal;
        MTDTRDDispatchAmt: Decimal;
        MTDDepotDispatchAmt: Decimal;
        SKDReleaseHdrAmt: Decimal;
        HSKReleaseHdrAmt: Decimal;
        DRAReleaseHdrAmt: Decimal;
        TRDReleaseHdrAmt: Decimal;
        DepotReleaseHdrAmt: Decimal;
        MTDTRDReleaseHdrAmt: Decimal;
        MTDSKDReleaseHdrAmt: Decimal;
        MTDDRAReleaseHdrAmt: Decimal;
        MTDHSKReleaseHdrAmt: Decimal;
        MTDDepotReleaseHdrAmt: Decimal;
        SKDPendingToDispatch: Decimal;
        DRAPendingToDispatch: Decimal;
        HSKPendingToDispatch: Decimal;
        TRDPendingToDispatch: Decimal;
        DepotPendingToDispatch: Decimal;
        SKDPendingToRelease: Decimal;
        DRAPendingToRelease: Decimal;
        HSKPendingToRelease: Decimal;
        TRDPendingToRelease: Decimal;
        DepotPendingToRelease: Decimal;
        SKDPendingToReleaseRetail: Decimal;
        DRAPendingToReleaseRetail: Decimal;
        HSKPendingToReleaseRetail: Decimal;
        TRDPendingToReleaseRetail: Decimal;
        DepotPendingToReleaseRetail: Decimal;
        SKDOverAllCancellation: Decimal;
        HSKOverAllCancellation: Decimal;
        DRAOverAllCancellation: Decimal;
        TRDOverAllCancellation: Decimal;
        DepotOverAllCancellation: Decimal;
        SKDOverAllCancellationRelease: Decimal;
        HSKOverAllCancellationRelease: Decimal;
        DRAOverAllCancellationRelease: Decimal;
        TRDOverAllCancellationRelease: Decimal;
        DepotOverAllCancellationRelease: Decimal;
        SKDOverAllCancellationTot: Decimal;
        DRAOverAllCancellationTot: Decimal;
        HSKOverAllCancellationTot: Decimal;
        TRDOverAllCancellationTot: Decimal;
        DepotOverAllCancellationTot: Decimal;
        SKDOverAllCancellationReleaseTot: Decimal;
        DRAOverAllCancellationReleaseTot: Decimal;
        HSKOverAllCancellationReleaseTot: Decimal;
        TRDOverAllCancellationReleaseTot: Decimal;
        DepotOverAllCancellationReleaseTot: Decimal;
        SKDBookedQty: Decimal;
        DRABookedQty: Decimal;
        HSKBookedQty: Decimal;
        TRDBookedQty: Decimal;
        DepotBookedQty: Decimal;
        SKDReleasedQty: Decimal;
        DRAReleasedQty: Decimal;
        HSKReleasedQty: Decimal;
        TRDReleasedQty: Decimal;
        DepotReleasedQty: Decimal;
        SKDDispatchQty: Decimal;
        DRADispatchQty: Decimal;
        HSKDispatchQty: Decimal;
        TRDDispatchQty: Decimal;
        DepotDispatchQty: Decimal;
        MTDSKDBookedQty: Decimal;
        MTDDRABookedQty: Decimal;
        MTDHSKBookedQty: Decimal;
        MTDTRDBookedQty: Decimal;
        MTDDepotBookedQty: Decimal;
        MTDSKDReleasedQty: Decimal;
        MTDDRAReleasedQty: Decimal;
        MTDHSKReleasedQty: Decimal;
        MTDTRDReleasedQty: Decimal;
        MTDDepotReleasedQty: Decimal;
        MTDSKDDispatchQty: Decimal;
        MTDDRADispatchQty: Decimal;
        MTDHSKDispatchQty: Decimal;
        MTDTRDDispatchQty: Decimal;
        MTDDepotDispatchQty: Decimal;
        SKDReleaseHdrQty: Decimal;
        HSKReleaseHdrQty: Decimal;
        DRAReleaseHdrQty: Decimal;
        TRDReleaseHdrQty: Decimal;
        DepotReleaseHdrQty: Decimal;
        MTDTRDReleaseHdrQty: Decimal;
        MTDSKDReleaseHdrQty: Decimal;
        MTDDRAReleaseHdrQty: Decimal;
        MTDHSKReleaseHdrQty: Decimal;
        MTDDepotReleaseHdrQty: Decimal;
        SKDPendingToDispatchQty: Decimal;
        DRAPendingToDispatchQty: Decimal;
        HSKPendingToDispatchQty: Decimal;
        TRDPendingToDispatchQty: Decimal;
        DepotPendingToDispatchQty: Decimal;
        SKDPendingToReleaseQty: Decimal;
        DRAPendingToReleaseQty: Decimal;
        HSKPendingToReleaseQty: Decimal;
        TRDPendingToReleaseQty: Decimal;
        DepotPendingToReleaseQty: Decimal;
        SKDPendingToReleaseRetailQty: Decimal;
        DRAPendingToReleaseRetailQty: Decimal;
        HSKPendingToReleaseRetailQty: Decimal;
        TRDPendingToReleaseRetailQty: Decimal;
        DepotPendingToReleaseRetailQty: Decimal;
        SKDOverAllCancellationQty: Decimal;
        HSKOverAllCancellationQty: Decimal;
        DRAOverAllCancellationQty: Decimal;
        TRDOverAllCancellationQty: Decimal;
        DepotOverAllCancellationQty: Decimal;
        SKDOverAllCancellationReleaseQty: Decimal;
        HSKOverAllCancellationReleaseQty: Decimal;
        DRAOverAllCancellationReleaseQty: Decimal;
        TRDOverAllCancellationReleaseQty: Decimal;
        DepotOverAllCancellationReleaseQty: Decimal;
        SKDOverAllCancellationQtyTot: Decimal;
        DRAOverAllCancellationQtyTot: Decimal;
        HSKOverAllCancellationQtyTot: Decimal;
        TRDOverAllCancellationQtyTot: Decimal;
        DepotOverAllCancellationQtyTot: Decimal;
        SKDOverAllCancellationReleaseQtyTot: Decimal;
        DRAOverAllCancellationReleaseQtyTot: Decimal;
        HSKOverAllCancellationReleaseQtyTot: Decimal;
        TRDOverAllCancellationReleaseQtyTot: Decimal;
        DepotOverAllCancellationReleaseQtyTot: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SKDBookedAmtSIL: Decimal;
        DRABookedAmtSIL: Decimal;
        HSKBookedAmtSIL: Decimal;
        TRDBookedAmtSIL: Decimal;
        DepotBookedAmtSIL: Decimal;
        SKDBookedQtySIL: Decimal;
        DRABookedQtySIL: Decimal;
        HSKBookedQtySIL: Decimal;
        TRDBookedQtySIL: Decimal;
        DepotBookedQtySIL: Decimal;
        MTDSKDBookedAmtSIL: Decimal;
        MTDDRABookedAmtSIL: Decimal;
        MTDHSKBookedAmtSIL: Decimal;
        MTDTRDBookedAmtSIL: Decimal;
        MTDDepotBookedAmtSIL: Decimal;
        MTDSKDBookedQtySIL: Decimal;
        MTDDRABookedQtySIL: Decimal;
        MTDHSKBookedQtySIL: Decimal;
        MTDTRDBookedQtySIL: Decimal;
        MTDDepotBookedQtySIL: Decimal;

    local procedure GetReleaseDate(LclSalesLine: Record "Sales Line"): Date
    var
        SalesHeader: Record "Sales Header";
    begin
        LclSalesLine.CALCFIELDS("Releasing Date");
        IF LclSalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER'] THEN BEGIN
            IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                EXIT(SalesHeader."Payment Date 3");
        END ELSE BEGIN
            EXIT(LclSalesLine."Releasing Date");
        END;
    end;

    local procedure GetDispatchAmt(Plant: Code[10]; FromDt: Date; ToDate: Date; Qty: Boolean) Amt: Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
    begin
        /*
        CLEAR(SalesJournalData);
        //EXIT;
        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',FromDt,ToDate);
        CASE Plant OF
          'SKD':
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1','SKD-WH-MFG');
          'DRA' :
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1','DRA-WH-MFG');
          'HSK':
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1','HSK-WH-MFG');
          'TRD' :
          SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1|%2','DP-MORBI','DP-BIKANER');
          'DEPOT':
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'DP-*&<>%2&<>%3','DP-MORBI','DP-BIKANER');
        END;
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO
          //Amt += SalesJournalData.AmountToCustomer;
          Amt += SalesJournalData.GSTBaseAmount;
          */

    end;

    local procedure GetSalesInvAmt(RecSalesLine: Record "Sales Line") Amt: Decimal
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        /*
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("Order No.",RecSalesLine."Document No.");
        IF SalesInvoiceHeader.FINDFIRST THEN
        REPEAT
          IF SalesInvoiceLine.GET(SalesInvoiceHeader."No.",RecSalesLine."Line No.") THEN
            Amt += SalesInvoiceLine.Amount;
        UNTIL SalesInvoiceHeader.NEXT=0;
        */

    end;

    local procedure GetDispatchQty(Plant: Code[10]; FromDt: Date; ToDate: Date; Amt: Boolean) Qty: Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
    begin
        /*
        CLEAR(SalesJournalData);
        //EXIT;
        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',FromDt,ToDate);
        CASE Plant OF
          'SKD':
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1','SKD-WH-MFG');
          'DRA' :
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1','DRA-WH-MFG');
          'HSK':
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1','HSK-WH-MFG');
          'TRD' :
          SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'%1|%2','DP-MORBI','DP-BIKANER');
          'DEPOT':
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode,'DP-*&<>%2&<>%3','DP-MORBI','DP-BIKANER');
        END;
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO
          Qty += SalesJournalData.Quantity_in_Sq_Mt;
        */

    end;

    local procedure GetSalesInvQty(RecSalesLine: Record "Sales Line") Qty: Decimal
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        /*
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("Order No.",RecSalesLine."Document No.");
        IF SalesInvoiceHeader.FINDFIRST THEN
        REPEAT
          IF SalesInvoiceLine.GET(SalesInvoiceHeader."No.",RecSalesLine."Line No.") THEN
            Qty += SalesInvoiceLine."Quantity in Sq. Mt.";
        UNTIL SalesInvoiceHeader.NEXT=0;
        */

    end;
}

