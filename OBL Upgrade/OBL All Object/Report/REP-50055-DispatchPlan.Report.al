report 50055 "Dispatch Plan"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DispatchPlan.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING(State, "Sell-to Customer No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Order),
                                      Status = CONST(Released));
            RequestFilterFields = "No.";
            column(Detail; Detail)
            {
            }
            column(GrossWt_SalesHeader; "Sales Header"."Gross Wt.")
            {
            }
            column(SalesLine_GrossWeight; SalesLine."Gross Weight")
            {
            }
            column(CompanyName; ConpInfo.Name)
            {
            }
            column(CustNoSH; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(CustNameSl; "Sell-to Customer Name" + ' ,' + FORMAT("Customer Type"))
            {
            }
            column(Comment1; Comment1)
            {
            }
            column(Add1; "Sell-to Address" + ',' + "Sell-to Address 2" + ',' + "Sell-to City" + ' - ' + "Sell-to Post Code")
            {
            }
            column(ShipAdd; "Ship-to Address" + ',' + "Ship-to Address 2" + ',' + "Ship-to City" + ' - ' + "Ship-to Post Code")
            {
            }
            column(DocNo; "No.")
            {
            }
            column(ReleaseDate; "Releasing Date")
            {
            }
            column(ReqDelivDate; "Requested Delivery Date")
            {
            }
            column(QtyCtr; QtyCtr)
            {
            }
            column(QtySqm; QtySqm)
            {
            }
            column(Qty; Qty)
            {
            }
            column(MF; MF)
            {
            }
            column(MP; MP)
            {
            }
            column(TRD; TRD)
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(Pay; FORMAT(Pay))
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(StateDesc1; StateDesc1)
            {
            }
            column(CustType; "Sales Header"."Customer Type")
            {
            }
            column(SellToCustName; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(desp_remark; "Sales Header"."Despatch Remarks")
            {
            }
            column(Ship_pin; "Sales Header"."Ship to Pin")
            {
            }
            column(Sell_pin; custpin)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesLine.RESET;
                SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                IF SalesLine.FINDFIRST THEN;

                Qty := 0;
                QtyCtr := 0;
                QtySqm := 0;
                //TRI DG Add Start
                MF := 0;
                MP := 0;
                TRD := 0;
                //TRI DG Add Stop

                SalesLine.RESET;
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETFILTER(SalesLine."Document No.", '%1', "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        IF (SalesLine.Type <> SalesLine.Type::"Charge (Item)") AND (SalesLine.Type <> SalesLine.Type::"G/L Account")
                          AND (SalesLine.Quantity <> SalesLine."Quantity Shipped") THEN BEGIN
                            Qty += item.UomToGrossWeight(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                            SalesLine."Quantity Shipped")) / 1000;//ori ut

                            QtyCtr += item.UomToCart(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity - SalesLine."Quantity Shipped"));
                            QtySqm += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                            SalesLine."Quantity Shipped"));
                            IF SalesLine."Plant Code" IN ['W', 'T', 'P', 'N', 'S', 'L'] THEN
                                TRD += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                                       SalesLine."Quantity Shipped"));

                            //TRI DG Add Stop

                            //TRI SC
                            IF SalesLine."Plant Code" = 'M' THEN BEGIN
                                ReservationEntry.RESET;
                                ReservationEntry.SETRANGE(ReservationEntry."Source ID", SalesLine."Document No.");
                                ReservationEntry.SETRANGE(ReservationEntry."Item No.", SalesLine."No.");
                                IF ReservationEntry.FIND('-') THEN BEGIN
                                    IF ReservationEntry1.GET(ReservationEntry."Entry No.", TRUE) THEN BEGIN
                                        IF ILE.GET(ReservationEntry1."Source Ref. No.") THEN
                                            IF ILE."Production Plant Code" IN ['SKD-MF 1', 'SKD-MF 2', 'SKD-MF 3', 'SKD-DCOR'] THEN
                                                MF += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                                                     SalesLine."Quantity Shipped"));
                                        IF ILE."Production Plant Code" IN ['SKD-MP 1', 'SKD-MP 2', 'SKD-MP 4'] THEN
                                            MP += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                                                SalesLine."Quantity Shipped"));
                                    END;
                                END;
                            END;

                            // TRI SC

                        END;
                    UNTIL SalesLine.NEXT = 0;

                Stat := '';
                IF "Ship-to Code" = '' THEN
                    Stat := "Sales Header".State
                ELSE BEGIN
                    IF ShipToadd.GET("Sell-to Customer No.", "Ship-to Code") THEN
                        Stat := ShipToadd.State;
                END;
                IF StateRec.GET(Stat) THEN
                    StateDesc1 := StateRec.Description;

                RecSalesCommentLine.RESET;
                RecSalesCommentLine.SETRANGE("Document Type", "Document Type");
                RecSalesCommentLine.SETRANGE("No.", "No.");
                IF RecSalesCommentLine.FINDFIRST THEN
                    Comment1 := RecSalesCommentLine.Comment
                ELSE
                    Comment1 := '';


                IF Qty = 0 THEN
                    CurrReport.SKIP;

                IF cust.GET("Sell-to Customer No.") THEN
                    custpin := cust."Pin Code";
            end;

            trigger OnPreDataItem()
            begin

                SETFILTER("Promised Delivery Date", ShipmentdateFilter);
                SETFILTER("Location Code", '%1', LocationFilter1);
                IF VarStatus = VarStatus::Open THEN
                    SETRANGE(Status, Status::Open);
                IF VarStatus = VarStatus::Released THEN
                    SETRANGE(Status, Status::Released);
            end;
        }
        dataitem("Sales Header Archive"; 5107)
        {
            DataItemTableView = SORTING(State, "Sell-to Customer No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Order),
                                      Status = CONST(Released),
                                      Deleted = CONST(false),
                                      "No." = CONST('0'));
            column(CNoSHA; 'C' + '' + "Sell-to Customer No.")
            {
            }
            column(CNameSHA; "Sell-to Customer Name")
            {
            }
            column(AddSHA; "Sell-to Address" + ',' + "Sell-to Address 2" + ',' + "Sell-to City" + ' - ' + "Sell-to Post Code")
            {
            }
            column(AddShipSHA; "Ship-to Address" + ',' + "Ship-to Address 2" + ',' + "Ship-to City" + ' - ' + "Ship-to Post Code")
            {
            }
            column(DocNoSHA; "No.")
            {
            }
            column(ReDelDateSHA; FORMAT("Requested Delivery Date"))
            {
            }
            column(QtyCtrSHA; FORMAT(QtyCtr))
            {
            }
            column(QtySqmSHA; FORMAT(QtySqm))
            {
            }
            column(QtySHA; FORMAT(Qty))
            {
            }
            column(MFSHA; FORMAT(MF))
            {
            }
            column(MPSHA; FORMAT(MP))
            {
            }
            column(TRDSHA; FORMAT(TRD))
            {
            }
            column(TruchSHA; "Truck No.")
            {
            }
            column(PaySHA; FORMAT(Pay))
            {
            }
            column(ShipSHA; "Ship-to City")
            {
            }
            column(StateDesc1SHA; StateDesc1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Qty := 0;
                QtyCtr := 0;
                QtySqm := 0;
                //TRI DG Add Start
                MF := 0;
                MP := 0;
                TRD := 0;
                //TRI DG Add Stop

                SalesLineArc.RESET;
                SalesLineArc.SETRANGE(SalesLineArc."Document Type", SalesLineArc."Document Type"::Order);
                SalesLineArc.SETFILTER(SalesLineArc."Document No.", '%1', "No.");
                SalesLineArc.SETRANGE(SalesLineArc."Doc. No. Occurrence", "Doc. No. Occurrence");
                SalesLineArc.SETRANGE(SalesLineArc."Version No.", "Sales Header Archive"."Version No.");
                IF SalesLineArc.FIND('-') THEN
                    REPEAT
                        IF (SalesLineArc.Type <> SalesLineArc.Type::"Charge (Item)") AND (SalesLineArc.Type <> SalesLineArc.Type::"G/L Account")
                          AND (SalesLineArc.Quantity <> SalesLineArc."Quantity Shipped") THEN BEGIN
                            Qty += item.UomToWeight(SalesLineArc."No.", SalesLineArc."Unit of Measure Code", SalesLineArc.Quantity) / 1000;
                            QtyCtr += SalesLineArc."Quantity in Cartons";
                            QtySqm += SalesLineArc."Quantity in Sq. Mt.";

                            //TRI DG Add Start
                            IF SalesLineArc."Plant Code" IN ['A', 'B', 'I', 'J'] THEN
                                MF += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                                       SalesLine."Quantity Shipped"));
                            IF SalesLineArc."Plant Code" IN ['C', 'D', 'E', 'H'] THEN
                                MP += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                                       SalesLine."Quantity Shipped"));
                            // IF SalesLineArc."Plant Code" IN ['0','1','2','3','4'] THEN
                            IF SalesLineArc."Plant Code" IN ['W', 'T', 'P', 'N', 'S', 'L'] THEN
                                TRD += item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", (SalesLine.Quantity -
                                       SalesLine."Quantity Shipped"));

                            //TRI DG Add Stop

                        END;
                    UNTIL SalesLineArc.NEXT = 0;
                //TotalQty := item.UomToWeight("No.","Unit of Measure Code",Quantity)/1000;

                Stat := '';
                IF "Ship-to Code" = '' THEN
                    Stat := "Sales Header".State
                ELSE BEGIN
                    IF ShipToadd.GET("Sell-to Customer No.", "Ship-to Code") THEN
                        Stat := ShipToadd.State;
                END;

                IF StateRec.GET(Stat) THEN
                    StateDesc1 := StateRec.Description;

                IF Qty = 0 THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin

                SETFILTER("Promised Delivery Date", ShipmentdateFilter);
                SETFILTER("Location Code", '%1', LocationFilter1);
                IF VarStatus = VarStatus::Open THEN
                    SETRANGE(Status, Status::Open);
                IF VarStatus = VarStatus::Released THEN
                    SETRANGE(Status, Status::Released);
            end;
        }
        dataitem("Transfer Header"; 5740)
        {
            DataItemTableView = SORTING("Transfer-to State", "Transfer-to Code")
                                ORDER(Ascending)
                                WHERE("Transfer order Status" = CONST(Released));
            RequestFilterFields = "No.";
            column(TotalWeight_TransferHeader; "Transfer Header"."Total Weight")
            {
            }
            column(TransferCode; "Transfer-to Code")
            {
            }
            column(TransferName; "Transfer-to Name")
            {
            }
            column(TransferAdd; "Transfer-to Address" + ',' + "Transfer-to Address 2" + ',' + "Transfer-to City" + ' - ' + "Transfer-to Post Code")
            {
            }
            column(TransferAdd2; "Transfer-to Address" + ',' + "Transfer-to Address 2" + ',' + "Transfer-to City" + ' - ' + "Transfer-to Post Code")
            {
            }
            column(DocNoTransfer; "No.")
            {
            }
            column(ReleaseDateTransfer; FORMAT("Releasing Date"))
            {
            }
            column(QtyCtrTransfer; FORMAT(QtyCtr))
            {
            }
            column(QtySqmTransfre; FORMAT(QtySqm))
            {
            }
            column(QtyTransfer; FORMAT(Qty))
            {
            }
            column(MFTranfer; FORMAT(MF))
            {
            }
            column(MPTransfer; FORMAT(MP))
            {
            }
            column(TRDTransfer; FORMAT(TRD))
            {
            }
            column(TruckNoTransfer; "Truck No.")
            {
            }
            column(PayTransfer; FORMAT(Pay))
            {
            }
            column(TransferCity; "Transfer-to City")
            {
            }
            column(StateDesc1Trasnfer; StateDesc1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Transferline.SETFILTER(Transferline."Document No.", '%1', "No.");
                Transferline.SETFILTER(Transferline."Quantity Shipped", '%1', 0);
                Transferline.SETFILTER(Transferline."Derived From Line No.", '=%1', 0);
                IF NOT Transferline.FIND('-') THEN
                    CurrReport.SKIP;

                Qty := 0;
                QtyCtr := 0;
                QtySqm := 0;
                //TRI DG Add Start
                MF := 0;
                MP := 0;
                TRD := 0;
                //TRI DG Add Stop

                Transferline.RESET;
                Transferline.SETFILTER(Transferline."Document No.", '%1', "No.");
                Transferline.SETFILTER(Transferline."Quantity Shipped", '%1', 0);
                Transferline.SETFILTER(Transferline."Derived From Line No.", '=%1', 0);
                IF Transferline.FIND('-') THEN
                    REPEAT
                        IF Transferline.Quantity <> Transferline."Quantity Shipped" THEN BEGIN
                            //Qty += item.UomToWeight(Transferline."Item No.",Transferline."Unit of Measure Code",(Transferline.Quantity-
                            //Transferline."Quantity Shipped"))/1000;

                            Qty += item.UomToGrossWeight(Transferline."Item No.", Transferline."Unit of Measure Code", (Transferline.Quantity -
                            Transferline."Quantity Shipped")) / 1000;
                            //Qty+=Transferline."Gross Weight"/1000;

                            //      QtyCtr += Transferline."Qty in Carton.";
                            //      QtySqm += Transferline."Qty in Sq. Mt.";
                            QtyCtr += item.UomToCart(Transferline."Item No.", Transferline."Unit of Measure Code", (Transferline.Quantity -
                            Transferline."Quantity Shipped"));
                            QtySqm += item.UomToSqm(Transferline."Item No.", Transferline."Unit of Measure Code", (Transferline.Quantity -
                            Transferline."Quantity Shipped"));
                            //TRI DG Add Start

                            IF item.GET(Transferline."Item No.") THEN
                                IF item."Default Prod. Plant Code" IN ['SKD-MF 1', 'SKD-MF 2', 'SKD-MF 3', 'SKD-DCOR'] THEN
                                    MF += item.UomToSqm(Transferline."Item No.", Transferline."Unit of Measure Code", (Transferline.Quantity -
                                         Transferline."Quantity Shipped"));

                            IF item."Default Prod. Plant Code" IN ['SKD-MP 1', 'SKD-MP 2', 'SKD-MP 4'] THEN
                                MP += item.UomToSqm(Transferline."Item No.", Transferline."Unit of Measure Code", (Transferline.Quantity -
                                   Transferline."Quantity Shipped"));

                            //IF Transferline."Plant Code" IN ['0','1','2','3','4'] THEN
                            IF Transferline."Plant Code" IN ['W', 'T', 'P', 'N', 'S', 'L'] THEN
                                TRD += item.UomToSqm(Transferline."Item No.", Transferline."Unit of Measure Code", (Transferline.Quantity -
                                   Transferline."Quantity Shipped"));


                            //TRI DG Add Stop

                        END;

                        IF StateRec.GET("Transfer Header"."Transfer-to State") THEN
                            StateDesc1 := StateRec.Description;

                    UNTIL Transferline.NEXT = 0;
                IF Qty = 0 THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin

                SETFILTER("Shipment Date", ShipmentdateFilter);
                SETFILTER("Transfer-from Code", '%1', LocationFilter1);
                IF VarStatus = VarStatus::Open THEN
                    SETRANGE(Status, Status::Open);
                IF VarStatus = VarStatus::Released THEN
                    SETRANGE(Status, Status::Released);
            end;
        }
        dataitem("Sales Line"; 37)
        {
            column(ItemNo; "Sales Line"."No.")
            {
            }
            column(ReservedQty; "Sales Line"."Reserved Quantity")
            {
            }
            column(Wt; Wt)
            {
            }
            column(QtySqmt; QtySqmt)
            {
            }
            column(ItemDesc; Item2.Description + ' ' + Item2."Description 2")
            {
            }
            column(ItemUOM; Item2."Base Unit of Measure")
            {
            }
            column(Ex; SalesHeader."Despatch Remarks")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                Ex := '';
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", "Sales Line"."Document No.");
                SalesHeader.SETRANGE("Despatch Remarks", 'Executable');
                IF NOT SalesHeader.FINDFIRST THEN
                  //Ex := "Sales Header"."Despatch Remarks";
                  CurrReport.SKIP;
                  */

                CLEAR(SalesHeader);
                IF SalesHeader.GET("Document Type", "Document No.") THEN;
                IF SalesHeader."Despatch Remarks" <> 'Executable' THEN
                    CurrReport.SKIP;

                Wt := 0;
                QtySqmt := 0;

                Wt := "Sales Line"."Gross Weight";

                CLEAR(Item2);
                IF Item2.GET("No.") THEN
                    IF Item2."Group Code" = '05' THEN
                        QtySqmt := "Quantity in Sq. Mt."
                    ELSE
                        QtySqmt := ROUND(Item2.UomToSqm("No.", "Unit of Measure Code", Quantity), 1, '=');

            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Promised Delivery Date", ShipmentdateFilter);
                SETFILTER("Location Code", '%1', LocationFilter1);
                IF VarStatus = VarStatus::Open THEN
                    SETRANGE(Status, Status::Open);
                IF VarStatus = VarStatus::Released THEN
                    SETRANGE(Status, Status::Released);
            end;
        }
        dataitem("Transfer Line"; 5741)
        {
            DataItemTableView = SORTING("Item No.", "Variant Code")
                                ORDER(Ascending);
            column(ItemNo1; "Item No.")
            {
            }
            column(ReservedQty1; "Reserved Quantity Outbnd.")
            {
            }
            column(Wt1; Wt1)
            {
            }
            column(QtySqmt1; QtySqmt1)
            {
            }
            column(ItemDesc1; Item2.Description + ' ' + Item2."Description 2")
            {
            }
            column(ItemUOM1; Item2."Base Unit of Measure")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Wt1 := 0;
                QtySqmt1 := 0;

                Wt1 := "Gross Weight";

                CLEAR(Item2);
                IF Item2.GET("Item No.") THEN
                    IF Item2."Group Code" = '05' THEN
                        QtySqmt1 := "Qty in Sq. Mt."
                    ELSE
                        QtySqmt1 := ROUND(Item2.UomToSqm("Item No.", "Unit of Measure Code", Quantity), 1, '=');
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Shipment Date", ShipmentdateFilter);
                SETFILTER("Transfer-from Code", '%1', LocationFilter1);
                IF VarStatus = VarStatus::Open THEN
                    SETRANGE(Status, Status::Open);
                IF VarStatus = VarStatus::Released THEN
                    SETRANGE(Status, Status::Released);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Shipment Date"; ShipmentdateFilter)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //IF ApplicationMgt.MakeDateFilter(ShipmentdateFilter) = 0 THEN BEGIN
                        "Sales Header Archive".SETFILTER("Promised Delivery Date", ShipmentdateFilter);
                        ShipmentdateFilter := "Sales Header Archive".GETFILTER("Promised Delivery Date");
                        //END;
                    end;
                }
                field(Location; LocationFilter1)
                {
                    ApplicationArea = All;
                }
                field(Status; VarStatus)
                {
                    ApplicationArea = All;
                }
                field(Detail; Detail)
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

        IF ShipmentdateFilter = '' THEN
            ERROR('Shipment Date must not be empty on request form');

        IF LocationFilter1 = '' THEN
            ERROR('Location must not be empty on request form');
        ConpInfo.GET();
    end;

    var
        //  ApplicationMgt: Codeunit 1;
        ShipmentdateFilter1: Date;
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        item: Record Item;
        SalesLine: Record "Sales Line";
        SalesLineArc: Record "Sales Line Archive";
        Transferline: Record "Transfer Line";
        ShipmentdateFilter: Text[100];
        Qty: Decimal;
        QtyCtr: Decimal;
        QtySqm: Decimal;
        GrandTotal: Decimal;
        LocationFilter1: Code[30];
        StateRec: Record State;
        StateDesc: Text[50];
        TotalQty: Decimal;
        TotalQtyCtr: Decimal;
        TotalQtySqm: Decimal;
        recDocDim: Record "Gen. Jnl. Dim. Filter";
        ExcelBuffer: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        MF: Decimal;
        MP: Decimal;
        TRD: Decimal;
        Rowno: Integer;
        TotMF: Decimal;
        TotMP: Decimal;
        TotTRD: Decimal;
        VarStatus: Option " ",Open,Released;
        ShipToadd: Record "Ship-to Address";
        Stat: Text[50];
        StateDesc1: Text[100];
        ReservationEntry: Record "Reservation Entry";
        ILE: Record "Item Ledger Entry";
        ReservationEntry1: Record "Reservation Entry";
        RecSalesCommentLine: Record "Sales Comment Line";
        Comment1: Text[150];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ConpInfo: Record "Company Information";
        "-----------------------------Detail Data------------------------": Integer;
        Detail: Boolean;
        Item2: Record Item;
        Wt: Decimal;
        QtySqmt: Decimal;
        Wt1: Decimal;
        QtySqmt1: Decimal;
        SalesHeader: Record "Sales Header";
        Ex: Code[20];
        cust: Record Customer;
        custpin: Code[10];
}

