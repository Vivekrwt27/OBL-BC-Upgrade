report 50069 "Sales Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesDetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE(NPD = FILTER(<> ''));
            column(ItemNo; Item."No.")
            {
            }
            column(SizeCodeDesc; Item."Size Code Desc.")
            {
            }
            column(ItemDes; Item.Description + ' ' + Item."Description 2")
            {
            }
            column(Item_NPD; Item.NPD)
            {
            }
            column(No_SalesLine; Item."No.")
            {
            }
            column(decInventory; decInventory)
            {
            }
            column(OrdQnty; decBooking)
            {
            }
            column(intSalMonth; intSalMonth)
            {
            }
            column(intSalYear; intSalYear)
            {
            }
            column(txtMonthGrp; txtMonthGrp)
            {
            }
            column(decPending; decPending)
            {
            }
            column(decRealeased; decRealeased)
            {
            }
            column(decToShp; decToShp)
            {
            }
            column(decTotToSh; decTotToSh)
            {
            }
            column(decTotPending; decTotPending)
            {
            }
            column(TB_code; Item."Tableau Product Group")
            {
            }
            column(Item_category_code; Item."Item Category Code")
            {
            }
            dataitem(MonthDespatch; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(txtMonthGrpDis1; txtMonthGrpDis[1])
                {
                }
                column(txtMonthGrpDis2; txtMonthGrpDis[2])
                {
                }
                column(txtMonthGrpDis3s; txtMonthGrpDis[3])
                {
                }
                column(txtMonthGrpDis4; txtMonthGrpDis[4])
                {
                }
                column(txtMonthGrpDis5; txtMonthGrpDis[5])
                {
                }
                column(txtMonthGrpDis6; txtMonthGrpDis[6])
                {
                }
                column(txtMonthGrpDis7; txtMonthGrpDis[7])
                {
                }
                column(txtMonthGrpDis8; txtMonthGrpDis[8])
                {
                }
                column(txtMonthGrpDis9; txtMonthGrpDis[9])
                {
                }
                column(txtMonthGrpDis10; txtMonthGrpDis[10])
                {
                }
                column(txtMonthGrpDis11; txtMonthGrpDis[11])
                {
                }
                column(txtMonthGrpDis12; txtMonthGrpDis[12])
                {
                }
                column(intMonthDis1; intMonthDis[1])
                {
                }
                column(intMonthDis2; intMonthDis[2])
                {
                }
                column(intMonthDis3; intMonthDis[3])
                {
                }
                column(intMonthDis4; intMonthDis[4])
                {
                }
                column(intMonthDis5; intMonthDis[5])
                {
                }
                column(intMonthDis6; intMonthDis[6])
                {
                }
                column(intMonthDis7; intMonthDis[7])
                {
                }
                column(intMonthDis8; intMonthDis[8])
                {
                }
                column(intMonthDis9; intMonthDis[9])
                {
                }
                column(intMonthDis10; intMonthDis[10])
                {
                }
                column(intMonthDis11; intMonthDis[11])
                {
                }
                column(intMonthDis12; intMonthDis[12])
                {
                }
                column(decDispatch1; decDispatch[1])
                {
                }
                column(decDispatch2; decDispatch[2])
                {
                }
                column(decDispatch3; decDispatch[3])
                {
                }
                column(decDispatch4; decDispatch[4])
                {
                }
                column(decDispatch5; decDispatch[5])
                {
                }
                column(decDispatch6; decDispatch[6])
                {
                }
                column(decDispatch7; decDispatch[7])
                {
                }
                column(decDispatch8; decDispatch[8])
                {
                }
                column(decDispatch9; decDispatch[9])
                {
                }
                column(decDispatch10; decDispatch[10])
                {
                }
                column(decDispatch11; decDispatch[11])
                {
                }
                column(decDispatch12; decDispatch[12])
                {
                }

                trigger OnAfterGetRecord()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    OrderDate: Date;
                    DesSalesInvoiceLine: Record "Sales Invoice Line";
                begin
                    CLEAR(decDispatch);
                    CLEAR(intMonthDis);
                    decMTDShpd := 0;

                    CLEAR(SalesInvoiceQuantity);
                    SalesInvoiceQuantity.SETFILTER(SalesInvoiceQuantity.PostingDateFilter, '%1..%2', dtStartDate, dtEndDate);
                    SalesInvoiceQuantity.SETFILTER(SalesInvoiceQuantity.ItemNoFilter, '%1', Item."No.");
                    SalesInvoiceQuantity.OPEN;
                    WHILE SalesInvoiceQuantity.READ DO BEGIN
                        OrderDate := 0D;
                        OrderDate := SalesInvoiceQuantity.Posting_Date;
                        i := DATE2DMY(OrderDate, 2);
                        intMonthDis[i] := DATE2DMY(OrderDate, 2);
                        txtMonthGrpDis[i] := FORMAT(OrderDate, 0, '<Month Text>') + '-' + FORMAT(DATE2DMY(OrderDate, 3));
                        decDispatch[i] += SalesInvoiceQuantity.Sum_Quantity_Base;
                    END;

                    /*
                    // CLEAR(txtMonthGrpDis);
                    DesSalesInvoiceLine.RESET;
                    DesSalesInvoiceLine.SETCURRENTKEY("No.",Type);
                    DesSalesInvoiceLine.SETFILTER("No.",'%1',Item."No.");
                    IF DesSalesInvoiceLine.FINDFIRST THEN
                      REPEAT
                      IF SalesInvoiceHeader.GET(DesSalesInvoiceLine."Document No.") THEN
                        IF (SalesInvoiceHeader."Order Date" >= dtStartDate) AND (SalesInvoiceHeader."Order Date"<= dtEndDate) THEN BEGIN
                          OrderDate := 0D;
                          OrderDate := SalesInvoiceHeader."Order Date";
                    
                          i := DATE2DMY(OrderDate,2);
                    
                          intMonthDis[i]:=DATE2DMY(OrderDate,2);
                          txtMonthGrpDis[i]:=FORMAT(OrderDate,0,'<Month Text>')+'-'+FORMAT(DATE2DMY(OrderDate,3));
                          decDispatch[i]+=DesSalesInvoiceLine."Quantity in Sq. Mt.";
                        END;
                        UNTIL DesSalesInvoiceLine.NEXT=0;
                    
                    recSalesInvLn.RESET;
                    recSalesInvLn.SETRANGE("No.","Sales Line"."No.");
                    recSalesInvLn.SETRANGE("Posting Date",dtStartDate,dtEndDate);
                    IF recSalesInvLn.FIND('-') THEN REPEAT
                      FOR i:=1 TO 12 DO BEGIN
                        IF DATE2DMY(recSalesInvLn."Posting Date",2)=i THEN BEGIN
                          intMonthDis[i]:=DATE2DMY(recSalesInvLn."Posting Date",2);
                          txtMonthGrpDis[i]:=FORMAT(recSalesInvLn."Posting Date",0,'<Month Text>')+'-'+FORMAT(DATE2DMY(recSalesInvLn."Posting Date",3));
                          decDispatch[i]+=recSalesInvLn."Quantity in Sq. Mt.";
                        END;
                      END;
                    UNTIL recSalesInvLn.NEXT=0;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Inventory);
                decInventory := Inventory;
                ItemNPD := NPD;

                // SalesHeader.RESET;
                // SalesHeader.SETRANGE("Order Date",dtStartDate,dtEndDate);
                // IF NOT SalesHeader.FIND('-') THEN BEGIN
                //
                //  recSalInvHdr.RESET;
                //  recSalInvHdr.SETRANGE("Posting Date",dtStartDate,dtEndDate);
                //  IF NOT recSalInvHdr.FIND('-') THEN
                //    CurrReport.SKIP;
                // END;
                decBooking := 0;
                decBooking := CalculateBookingQty(Item."No.", dtStartDate, dtEndDate);
                decRealeased := 0;
                decPending := 0;
                decToShp := 0;
                CLEAR(SalesLineOutstandingQty);
                SalesLineOutstandingQty.SETFILTER(SalesLineOutstandingQty.OrderDateFilter, '%1..%2', dtStartDate, dtEndDate);
                SalesLineOutstandingQty.SETFILTER(SalesLineOutstandingQty.ItemNoFilter, '%1', Item."No.");
                SalesLineOutstandingQty.OPEN;
                WHILE SalesLineOutstandingQty.READ DO BEGIN
                    IF SalesLineOutstandingQty.Status = SalesLineOutstandingQty.Status::Released THEN BEGIN
                        decToShp += SalesLineOutstandingQty.Sum_Outstanding_Qty_Base;//As per Sharma G Keshav02112020
                        decTotToSh += SalesLineOutstandingQty.Sum_Outstanding_Quantity;
                    END;
                    IF SalesLineOutstandingQty.Status <> SalesLineOutstandingQty.Status::Released THEN BEGIN
                        decPending += SalesLineOutstandingQty.Sum_Outstanding_Qty_Base;//As per Sharma G Keshav02112020
                        decTotPending += SalesLineOutstandingQty.Sum_Outstanding_Quantity;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                recItem.SETRANGE("No.", "No.");
                FOR i := 1 TO 12 DO
                    txtMonthGrpDis[i] := FORMAT(CALCDATE('+CM', dtStartDate), 0, '<Month Text>') + '-' + FORMAT(DATE2DMY(CALCDATE('+CM', dtStartDate), 3));

                intSalYear := DATE2DMY(dtEndDate, 3);
            end;
        }
        dataitem(Integer; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending);
            column(cdItemNo; cdItemNo)
            {
            }
            column(txtItemDes; txtItemDes)
            {
            }
            column(ItemNPD; recItem.NPD)
            {
            }
            column(TownClass; recCust."Pop Tag")
            {
            }
            column(typecatdesc; recItem."Item Category Code")
            {
            }
            column(tableaugrp; recItem."Tableau Product Group")
            {
            }
            column(CustNoOrd; recCust."No.")
            {
            }
            column(CustName; recCust.Name)
            {
            }
            column(CustCity; recCust.City)
            {
            }
            column(CustState; recCust."State Desc.")
            {
            }
            column(CustRegion; recCust."Tableau Zone")
            {
            }
            column(res; reason)
            {
            }
            column(CustType; recCust."Customer Type")
            {
            }
            column(CustTerritory; recCust."Area Code")
            {
            }
            column(decMTDShpd; decMTDShpd)
            {
            }
            column(decBooking3; decBooking3)
            {
            }
            column(LocCodeOrd; LocCodeOrd)
            {
            }

            trigger OnAfterGetRecord()
            begin
                decBooking3 := 0;
                decMTDShpd := 0;

                IF intMTDSalCnt > intMTDSalRow THEN BEGIN
                    intMTDSalRow += 1;
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", recSalesLine."Document No.");
                    SalesHeader.SETRANGE("Order Date", dtStartDate, dtEndDate);
                    IF SalesHeader.FIND('-') THEN BEGIN
                        reason := SalesHeader.Commitment;
                        cdItemNo := recSalesLine."No.";
                        txtItemDes := recSalesLine.Description + ' ' + recSalesLine."Description 2";
                        recItem.RESET;
                        recItem.GET(recSalesLine."No.");
                        IF recItem."Item Category Code" IN ['D001', 'H001', 'M001', 'T001'] THEN BEGIN
                            decBooking3 := recSalesLine."Outstanding Qty. (Base)";
                            LocCodeOrd := recSalesLine."Location Code";
                            recCust.RESET;
                            recCust.SETRANGE("No.", recSalesLine."Sell-to Customer No.");
                            IF recCust.FIND('-') THEN;
                        END ELSE BEGIN
                            //CurrReport.SKIP;
                        END;
                    END ELSE BEGIN
                        //CurrReport.SKIP;
                    END;
                    recSalesLine.NEXT;
                END ELSE
                    IF intMTDInvCnt > intMTDInvRow THEN BEGIN
                        intMTDInvRow += 1;
                        cdItemNo := recSalInvLine."No.";
                        txtItemDes := recSalInvLine.Description + ' ' + recSalInvLine."Description 2";
                        recItem.RESET;
                        recItem.GET(recSalInvLine."No.");
                        IF recItem."Item Category Code" IN ['D001', 'H001', 'M001', 'T001'] THEN BEGIN
                            LocCodeOrd := recSalInvLine."Location Code";
                            decMTDShpd := recSalInvLine."Quantity in Sq. Mt.";
                            recCust.RESET;
                            recCust.SETRANGE("No.", recSalInvLine."Sell-to Customer No.");
                            IF recCust.FIND('-') THEN;

                        END ELSE BEGIN
                            //CurrReport.SKIP;
                        END;
                        recSalInvLine.NEXT;
                    END;
            end;

            trigger OnPreDataItem()
            begin

                recSalesLine.RESET;
                recSalesLine.SETCURRENTKEY("No.", Type);
                // recSalesLine.SETRANGE("No.",Item."No.");
                recSalesLine.SETRANGE("Document Type", recSalesLine."Document Type"::Order);
                //recSalesLine.SETFILTER(Status,'%1|%2',recSalesLine.Status::Open,recSalesLine.Status::"Pending Approval");
                recSalesLine.SETFILTER(Quantity, '<>%1', 0);
                recSalesLine.SETRANGE(Type, recSalesLine.Type::Item);
                IF recSalesLine.FIND('-') THEN BEGIN
                    intMTDSalCnt := recSalesLine.COUNT;
                END;
                recSalInvLine.RESET;
                recSalInvLine.SETCURRENTKEY("No.", Type);
                // recSalInvLine.SETRANGE("No.",Item."No.");
                recSalInvLine.SETRANGE("Posting Date", CALCDATE('-CM', dtEndDate), dtEndDate);
                recSalInvLine.SETFILTER(Quantity, '<>%1', 0);
                recSalInvLine.SETRANGE(Type, recSalInvLine.Type::Item);
                IF recSalInvLine.FIND('-') THEN BEGIN
                    intMTDInvCnt := recSalInvLine.COUNT;
                END;
                Integer.SETRANGE(Number, 1, intMTDInvCnt + intMTDSalCnt);
            end;
        }
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("Order Date");
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(Item),
                                          "Item Category Code" = FILTER('M001|T001|H001|D001'),
                                          Quantity = FILTER(<> 0));
                column(intInvMonth; intInvMonth)
                {
                }
                column(intInvYear; intInvYear)
                {
                }
                column(txtMonthGrpInv; txtMonthGrpInv)
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                {
                }
                column(PostingDateInv; "Sales Invoice Line"."Posting Date")
                {
                }
                column(Item_NPDInv; ItemNPDInv)
                {
                }
                column(SizeCodeDescInv; recItem."Size Code Desc.")
                {
                }
                column(ItemDesInv; recItem.Description + ' ' + recItem."Description 2")
                {
                }
                column(tbprod; recItem."Tableau Product Group")
                {
                }
                column(typecat; recItem."Item Category Code")
                {
                }
                column(InvQty; "Sales Invoice Line".Quantity)
                {
                }
                column(InvQtySqmt; "Sales Invoice Line"."Quantity in Sq. Mt.")
                {
                }
                column(IntAmnt; "Sales Invoice Line".Amount)
                {
                }
                column(DocumentNoInv; "Sales Invoice Line"."Document No.")
                {
                }
                column(InvDate; "Sales Invoice Line"."Posting Date")
                {
                }
                column(txtCustName; txtCustName)
                {
                }
                column(txtCustState; txtCustState)
                {
                }
                column(txtCustRegion; txtCustRegion)
                {
                }
                column(txtSalesTerritory; txtSalesTerritory)
                {
                }
                column(txtCustCity; txtCustCity)
                {
                }
                column(cdCustType; cdCustType)
                {
                }
                column(CustNo; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(LocationCode; "Sales Invoice Line"."Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    intInvMonth := DATE2DMY("Sales Invoice Header"."Posting Date", 2);
                    intInvYear := DATE2DMY("Sales Invoice Header"."Posting Date", 3);
                    txtMonthGrpInv := FORMAT("Sales Invoice Header"."Posting Date", 0, '<Month Text>') + '-' + FORMAT(intInvYear);

                    recItem.RESET;
                    recItem.SETFILTER("No.", '%1', "Sales Invoice Line"."No.");
                    IF recItem.FIND('-') THEN BEGIN
                        ItemNPDInv := recItem.NPD;
                    END;
                    IF ItemNPDInv = '' THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    // "Sales Invoice Line".SETRANGE("Sales Invoice Line"."No.",Item."No.");
                    ItemNPDInv := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                txtSalesTerritory := "Sales Invoice Header"."Sales Territory";

                recCust.RESET;
                recCust.SETRANGE("No.", "Sell-to Customer No.");
                IF recCust.FIND('-') THEN BEGIN
                    txtCustName := recCust.Name;
                    cdCustType := recCust."Customer Type";
                    txtCustCity := recCust.City;
                    txtCustRegion := recCust."Tableau Zone";
                    txtCustType := recCust."Customer Type";
                    txtCustState := recCust."State Desc.";
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Sales Invoice Header"."Posting Date", dtStartDate, dtEndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; dtStartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; dtEndDate)
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
        ItemNPD := '';
        ItemNPDInv := '';
    end;

    var
        recItem: Record Item;
        dtStartDate: Date;
        dtEndDate: Date;
        intSalMonth: Integer;
        intInvMonth: Integer;
        intSalYear: Integer;
        intInvYear: Integer;
        recCust: Record Customer;
        txtCustName: Text;
        txtCustState: Text;
        txtCustRegion: Text;
        txtSalesTerritory: Text;
        txtCustCity: Text;
        txtCustType: Text;
        recSalInvHdr: Record "Sales Invoice Header";
        decPending: Decimal;
        decRealeased: Decimal;
        decToShp: Decimal;
        txtMonthGrp: Text;
        txtMonthGrpInv: Text;
        decInventory: Decimal;
        ItemNPD: Code[20];
        ItemNPDInv: Code[20];
        recSalesInvLn: Record "Sales Invoice Line";
        decDispatch: array[12] of Decimal;
        txtMonthGrpDis: array[12] of Text;
        intMonthDis: array[12] of Integer;
        decBooking: Decimal;
        ItemAmount: Record "Item Amount";
        cdCustType: Code[20];
        decMTDShpd: Decimal;
        i: Integer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvLn: Record "Sales Invoice Line";
        intSalCnt: Integer;
        intInvCnt: Integer;
        SalesLineArchive: Record "Sales Line Archive";
        intSalArchCnt: Integer;
        intSalRow: Integer;
        intArchRow: Integer;
        SalesHeaderArchive: Record "Sales Header Archive";
        recSalInvLine: Record "Sales Invoice Line";
        recSalesLine: Record "Sales Line";
        intMTDSalCnt: Integer;
        intMTDInvCnt: Integer;
        intMTDSalRow: Integer;
        intMTDInvRow: Integer;
        decBooking3: Decimal;
        LocCodeOrd: Code[20];
        SalesInvoiceQuantity: Query "Sales Invoice Quantity";
        SalesLineOutstandingQty: Query "Sales Line OutstandingQty";
        decTotToSh: Decimal;
        decTotPending: Decimal;
        cdItemNo: Code[20];
        txtItemDes: Text;
        reason: Text[100];

    local procedure CalculateBookingQty(ItemNo: Code[20]; OrderStDate: Date; OrderEndDate: Date) Qty: Decimal
    var
        SalesLine: Record "Sales Line";
        PendQty: Decimal;
        SalesHeader: Record "Sales Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesLineOutstandingQty: Query "Sales Line OutstandingQty";
        SalesInvoiceQuantity: Query "Sales Invoice Quantity";
    begin
        CLEAR(SalesLineOutstandingQty);
        SalesLineOutstandingQty.SETFILTER(SalesLineOutstandingQty.OrderDateFilter, '%1..%2', OrderStDate, OrderEndDate);
        SalesLineOutstandingQty.SETFILTER(SalesLineOutstandingQty.ItemNoFilter, '%1', ItemNo);
        SalesLineOutstandingQty.OPEN;
        WHILE SalesLineOutstandingQty.READ DO BEGIN
            Qty += SalesLineOutstandingQty.Sum_Outstanding_Qty_Base;
        END;

        CLEAR(SalesInvoiceQuantity);
        SalesInvoiceQuantity.SETFILTER(SalesInvoiceQuantity.PostingDateFilter, '%1..%2', OrderStDate, OrderEndDate);
        SalesInvoiceQuantity.SETFILTER(SalesInvoiceQuantity.ItemNoFilter, '%1', ItemNo);
        SalesInvoiceQuantity.OPEN;
        WHILE SalesInvoiceQuantity.READ DO BEGIN
            Qty += SalesInvoiceQuantity.Sum_Quantity_in_Sq_Mt;
        END;

        /*
        SalesLine.RESET;
        SalesLine.SETFILTER("Document Type",'%1',SalesLine."Document Type"::Order);
        SalesLine.SETFILTER(Type,'%1',SalesLine.Type::Item);
        SalesLine.SETFILTER("No.",'%1',ItemNo);
        IF SalesLine.FINDFIRST THEN
          REPEAT
            IF SalesHeader.GET(SalesLine."Document Type",SalesLine."Document No.") THEN
            IF (SalesHeader."Order Date" >OrderStDate) AND (SalesHeader."Order Date"<OrderEndDate) THEN
            Qty += (SalesLine.Quantity - SalesLine."Quantity Invoiced");
          UNTIL SalesLine.NEXT=0;
        
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETFILTER(Type,'%1',SalesLine.Type::Item);
        SalesInvoiceLine.SETFILTER("No.",'%1',ItemNo);
        IF SalesInvoiceLine.FINDFIRST THEN
          REPEAT
            IF SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.") THEN
            IF (SalesInvoiceHeader."Order Date" >OrderStDate) AND (SalesInvoiceHeader."Order Date"<OrderEndDate) THEN
            Qty += (SalesInvoiceLine.Quantity );
          UNTIL SalesLine.NEXT=0;
        */

    end;

    procedure SetReportFilter("Date From": Date; "Date To": Date)
    begin
        dtStartDate := "Date From";
        dtEndDate := "Date To";
    end;
}

