report 50339 "Overall Pending Orders"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\OverallPendingOrders.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order));
            column(CustType; CustType)
            {
            }
            column(PendingTo; PendingTo)
            {
            }
            column(LocCode; LocCode)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = FILTER(Order),
                                          Type = FILTER(Item),
                                          Quantity = FILTER(> 0),
                                          "Item Category Code" = FILTER('M001' | 'T001' | 'D001' | 'H001'));
                column(SKDAmt; SKDAmt / 100000)
                {
                }
                column(TRDAmt; TRDAmt / 100000)
                {
                }
                column(DRAAmt; DRAAmt / 100000)
                {
                }
                column(HSKAmt; HSKAmt / 100000)
                {
                }
                column(DepotAmt; DepotAmt / 100000)
                {
                }
                column(SKDQty; SKDQty)
                {
                }
                column(TRDQty; TRDQty)
                {
                }
                column(DRAQty; DRAQty)
                {
                }
                column(HSKQty; HSKQty)
                {
                }
                column(DepotQty; DepotQty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Line"."Quantity (Base)" = "Sales Line"."Quantity Shipped" THEN
                        CurrReport.SKIP;

                    CLEAR(SKDAmt);
                    CLEAR(TRDAmt);
                    CLEAR(HSKAmt);
                    CLEAR(DRAAmt);
                    CLEAR(DepotAmt);
                    CLEAR(SKDQty);
                    CLEAR(TRDQty);
                    CLEAR(HSKQty);
                    CLEAR(DRAQty);
                    CLEAR(DepotQty);

                    IF "Sales Line"."Location Code" = 'SKD-WH-MFG' THEN BEGIN
                        SKDAmt := "Sales Line"."Outstanding Amount (LCY)";
                        SKDQty := "Sales Line"."Outstanding Qty. (Base)";
                    END;
                    IF "Sales Line"."Location Code" = 'DRA-WH-MFG' THEN BEGIN
                        DRAAmt := "Sales Line"."Outstanding Amount (LCY)";
                        DRAQty := "Sales Line"."Outstanding Qty. (Base)";
                    END;
                    IF "Sales Line"."Location Code" = 'HSK-WH-MFG' THEN BEGIN
                        HSKAmt := "Sales Line"."Outstanding Amount (LCY)";
                        HSKQty := "Sales Line"."Outstanding Qty. (Base)";
                    END;
                    IF ("Sales Line"."Location Code" = 'DP-MORBI') OR ("Sales Line"."Location Code" = 'DP-BIKANER') THEN BEGIN
                        TRDAmt := "Sales Line"."Outstanding Amount (LCY)";
                        TRDQty := "Sales Line"."Outstanding Qty. (Base)";
                    END;
                    IF ("Sales Line"."Location Code" <> 'DP-MORBI') AND ("Sales Line"."Location Code" <> 'DP-BIKANER') AND
                       (COPYSTR("Sales Line"."Location Code", 1, 3) = 'DP-') THEN BEGIN
                        DepotAmt := "Sales Line"."Outstanding Amount (LCY)";
                        DepotQty := "Sales Line"."Outstanding Qty. (Base)";

                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //"Sales Line".SETFILTER("Sales Line"."Item Category Code",'%1|%2|%3|%4','M001','D001','H001','T001');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(CustType);
                IF ("Sales Header"."Customer Type" = 'CKA') OR ("Sales Header"."Customer Type" = 'DIRECTPROJ') THEN BEGIN
                    CustType := 'Enterprise';
                END ELSE BEGIN
                    CustType := 'Retail';
                END;

                CLEAR(PendingTo);
                /*
                IF "Sales Header".Commitment<>'' THEN BEGIN
                  PendingTo := "Sales Header".Commitment
                END ELSE BEGIN
                  PendingTo := 'No Comments';
                END;
                */
                /*
                IF ("Sales Header"."Location Code"<>'DP-MORBI') OR  ("Sales Header"."Location Code"<>'DP-BIKANER') THEN BEGIN
                  IF ("Sales Header".Status <>"Sales Header".Status::Released) AND ("Sales Header".Commitment<>'') THEN BEGIN
                    PendingTo := "Sales Header".Commitment;
                  END ELSE IF ("Sales Header".Status = "Sales Header".Status::Released) AND ("Sales Header"."Despatch Remarks"<>'') THEN BEGIN
                    PendingTo := "Sales Header"."Despatch Remarks";
                  END ELSE IF ("Sales Header".Commitment = '') AND ("Sales Header"."Despatch Remarks" = '') THEN BEGIN
                    PendingTo := 'No Comments';
                  END;
                END ELSE IF ("Sales Header"."Location Code"='DP-MORBI') OR ("Sales Header"."Location Code"='DP-BIKANER') THEN BEGIN
                  IF ("Sales Header"."Payment Date 3">0D) AND ("Sales Header"."Despatch Remarks"<>'') THEN BEGIN
                    PendingTo := "Sales Header"."Despatch Remarks";
                  END ELSE IF ("Sales Header"."Payment Date 3">0D) AND ("Sales Header"."Despatch Remarks"='') THEN BEGIN
                    PendingTo := 'No Comments';
                  END;
                  IF ("Sales Header"."Payment Date 3"<=0D) AND ("Sales Header".Commitment<>'') THEN BEGIN
                    PendingTo := "Sales Header".Commitment;
                  END ELSE IF (("Sales Header"."Payment Date 3"<=0D) AND ("Sales Header".Commitment = '')) THEN BEGIN
                    PendingTo := 'No Comments';
                  END;
                END;
                */
                //>>New Start

                IF ("Sales Header"."Location Code" = 'DP-MORBI') OR ("Sales Header"."Location Code" = 'DP-BIKANER') THEN BEGIN
                    IF "Sales Header"."Payment Date 3" > 0D THEN BEGIN
                        IF "Sales Header"."Despatch Remarks" <> '' THEN BEGIN
                            PendingTo := "Sales Header"."Despatch Remarks";
                        END ELSE BEGIN
                            PendingTo := 'No Comments';
                        END;
                    END ELSE BEGIN
                        IF "Sales Header".Commitment <> '' THEN BEGIN
                            PendingTo := "Sales Header".Commitment;
                        END ELSE BEGIN
                            PendingTo := 'No Comments';
                        END;
                    END;
                END ELSE
                    IF ("Sales Header"."Location Code" = 'SKD-WH-MFG') OR ("Sales Header"."Location Code" = 'HSK-WH-MFG') OR
             ("Sales Header"."Location Code" = 'DRA-WH-MFG') OR (COPYSTR("Sales Header"."Location Code", 1, 3) = 'DP-') THEN BEGIN
                        IF "Sales Header".Status = "Sales Header".Status::Released THEN BEGIN
                            IF "Sales Header"."Despatch Remarks" <> '' THEN BEGIN
                                PendingTo := "Sales Header"."Despatch Remarks";
                            END ELSE BEGIN
                                PendingTo := 'No Comments';
                            END;
                        END ELSE BEGIN
                            IF "Sales Header".Commitment <> '' THEN BEGIN
                                PendingTo := "Sales Header".Commitment;
                            END ELSE BEGIN
                                PendingTo := 'No Comments';
                            END;
                        END;
                    END;

                //<<New End
                IF PendingTo = '' THEN
                    CurrReport.SKIP;


                CLEAR(LocCode);
                IF "Sales Header"."Location Code" = 'SKD-WH-MFG' THEN
                    LocCode := 'SKD'
                ELSE
                    IF ("Sales Header"."Location Code" = 'DP-MORBI') OR ("Sales Header"."Location Code" = 'DP-BIKANER') THEN
                        LocCode := 'TRD'
                    ELSE
                        IF "Sales Header"."Location Code" = 'DRA-WH-MFG' THEN
                            LocCode := 'DRA'
                        ELSE
                            IF "Sales Header"."Location Code" = 'HSK-WH-MFG' THEN
                                LocCode := 'HSK'
                            ELSE
                                IF ("Sales Header"."Location Code" <> 'DP-MORBI') AND ("Sales Header"."Location Code" <> 'DP-BIKANER') AND
                             (COPYSTR("Sales Header"."Location Code", 1, 3) = 'DP-') THEN
                                    LocCode := 'DEPOT';

            end;

            trigger OnPreDataItem()
            begin
                CLEAR(PendingTo);
                CLEAR(CustType);
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
        SalesLine: Record "Sales Line";
        PendingTo: Text[40];
        CustType: Text[50];
        LocCode: Code[20];
        SKDAmt: Decimal;
        TRDAmt: Decimal;
        DRAAmt: Decimal;
        HSKAmt: Decimal;
        DepotAmt: Decimal;
        SKDQty: Decimal;
        TRDQty: Decimal;
        DRAQty: Decimal;
        HSKQty: Decimal;
        DepotQty: Decimal;
}

