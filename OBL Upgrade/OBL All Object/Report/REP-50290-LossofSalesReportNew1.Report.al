report 50290 "Loss of Sales Report New1"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\LossofSalesReportNew1.rdl';

    dataset
    {
        dataitem("Sales Header Archive"; "Sales Header Archive")
        {
            DataItemTableView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                WHERE("Version No." = CONST(1));
            RequestFilterFields = "Location Code", "No.", "Order Date";
            column(No_SalesHeaderArchive; "Sales Header Archive"."No.")
            {
            }
            column(SONo; SONo)
            {
            }
            column(SODate; SODate)
            {
            }
            column(CustNo; "CustNo.")
            {
            }
            column(CustName; CustName)
            {
            }
            column(CustCity; CustCity)
            {
            }
            column(CustType; CustType)
            {
            }
            column(StateName; StateName)
            {
            }
            column(MakeOrderDate; "Sales Header Archive"."Order Date")
            {
            }
            column(ReleaseTime; FORMAT(ReleaseTime))
            {
            }
            column(RsnDesc; RsnDesc)
            {
            }
            column(RsnDate; RsnDate)
            {
            }
            column(DateArchived_SalesHeaderArchive; "Sales Header Archive"."Date Archived")
            {
            }
            column(promisedate; "Sales Header Archive"."Promised Delivery Date")
            {
            }
            column(Order_processdate; "Sales Header Archive"."Payment Date 3")
            {
            }
            column(Reason_hold; "Sales Header Archive".Commitment)
            {
            }
            column(Despatch_rem; "Sales Header Archive"."Despatch Remarks")
            {
            }
            column(SHArchVer; "Sales Header Archive"."Version No.")
            {
            }
            column(DelayDays; DelayDays)
            {
            }
            column(Zone; recCust.Zone)
            {
            }
            column(SalesTerr; recCust."Area Code")
            {
            }
            column(MODRD; MODRD)
            {
            }
            column(RDPD; RDPD)
            {
            }
            column(MODPD; MODPD)
            {
            }
            column(Document_type; "Sales Header Archive"."Document Type")
            {
            }
            column(Status; "Sales Header Archive".Status)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                // CalcFields = "Order No.";
                DataItemLink = "Sell-to Customer No." = FIELD("Sell-to Customer No."),
                               "Order No. 1" = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER(Item),
                                          Quantity = FILTER(<> 0));
                column(TotalShipped1; TotalShipped * "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(ShippedQty; Quantity * "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(LineNo; "Line No.")
                {
                }
                column(SILDocNo; "Document No.")
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(ItemDesc; Item.Description + ' ' + Item."Description 2")
                {
                }
                column(InvSize; COPYSTR((Item.Description + ' ' + Item."Description 2"), 1, 7))
                {
                }
                column(PostingDt; "Posting Date")
                {
                }
                column(manuf_strategy; Item."Manuf. Strategy")
                {
                }
                column(PostingDate_SalesLineArchive; recSLnArch."Posting Date")
                {
                }
                column(No_SalesLineArchive; recSLnArch."No.")
                {
                }
                column(Description_SalesLineArchive; Item.Description + ' ' + Item."Description 2")
                {
                }
                column(OrderQty_SalesLineArchive; OrderQty * "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(QuantityShipped_SalesLineArchive; recSLnArch."Quantity Shipped")
                {
                }
                column(QuantityinSqMt_SalesLineArchive; QtySqMtr)
                {
                }
                column(TotalReservedQuantity_SalesLineArchive; ReservedQty * "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(arc_loca; recSLnArch."Location Code")
                {
                }
                column(AD_rem; ADRem)
                {
                }
                column(LineDisPerSqMeter; LineDisPerSqMeter)
                {
                }
                column(Quantity_SalesLineArchive; SLnArchQuantity)
                {
                }
                column(TotalShipped; TotalShipped)
                {
                }
                column(ReleaseDate; ReleaseDate)
                {
                }
                column(Value; Value)
                {
                }
                // 16225column(MRPPerSqmtr; "MRP Price")
                column(MRPPerSqmtr; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Sqrmtr; Sqrmtr)
                {
                }
                column(Sqmt; Sqmt)
                {
                }
                column(OTIF; OTIF)
                {
                }
                column(OTIFPer; OTIFPer)
                {
                }
                column(OrderCancldYes; OrderCancldYes)
                {
                }
                column(OrderCancldNo; OrderCancldNo)
                {
                }
                column(Counter; Counter)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    OrderQty := 0;
                    SLnArchQuantity := 0;
                    ReservedQty := 0;
                    ADRem := '';
                    QtySqMtr := 0;

                    recSLnArch.RESET;
                    recSLnArch.SETRANGE("Document No.", "Order No. 1");
                    recSLnArch.SETRANGE("Line No.", "Line No.");
                    recSLnArch.SETRANGE("No.", "No.");
                    recSLnArch.SETFILTER("Version No.", '1');
                    IF recSLnArch.FINDFIRST THEN BEGIN
                        OrderQty := recSLnArch.Quantity;
                        SLnArchQuantity := recSLnArch."Order Qty";
                        ReservedQty := recSLnArch."Reserved Quantity";
                        ADRem := recSLnArch."AD Remarks";
                        QtySqMtr := recSLnArch."Quantity in Sq. Mt.";
                    END;

                    TotalShipped := 0;
                    SalesInvLine.RESET;
                    SalesInvLine.SETCURRENTKEY("Sell-to Customer No.", "Unit of Measure");
                    SalesInvLine.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                    SalesInvLine.SETRANGE("Order No. 1", "Order No. 1");
                    SalesInvLine.SETRANGE("No.", "No.");
                    SalesInvLine.SETRANGE("Line No.", "Line No.");
                    IF SalesInvLine.FINDFIRST THEN
                        REPEAT
                            TotalShipped += SalesInvLine.Quantity;
                        UNTIL SalesInvLine.NEXT = 0;

                    Counter := 0;
                    SalesInvLine1.RESET;
                    SalesInvLine1.SETCURRENTKEY("Sell-to Customer No.", "Unit of Measure");
                    SalesInvLine1.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                    SalesInvLine1.SETRANGE("Order No. 1", "Order No. 1");
                    SalesInvLine1.SETRANGE("No.", "No.");
                    SalesInvLine1.SETRANGE("Line No.", "Line No.");
                    IF SalesInvLine1.FINDFIRST THEN
                        //REPEAT
                        Counter += 1;
                    //UNTIL SalesInvLine1.NEXT = 0;


                    /*
                    SalesInvHdr.RESET;
                    SalesInvHdr.SETRANGE("No.", "Document No.");
                    IF SalesInvHdr.FINDFIRST THEN BEGIN
                      IF "Location Code" = 'DP-MORBI' THEN
                        ReleaseDate := SalesInvHdr."Payment Date 3"
                    
                      ELSE IF SalesInvHdr.Status = SalesInvHdr.Status::rel THEN
                        ReleaseDate:= SalesInvHdr."Releasing Date";
                    //    MESSAGE('%1', ReleaseDate);
                    END;
                     */

                    CLEAR(Item);
                    IF Item.GET("No.") THEN;
                    Sqrmtr := ROUND(Item.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                    Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                    IF Sqrmtr <> 0 THEN
                        LineDisPerSqMeter := ROUND(("Discount Amt 1" + "Discount Amt 2" + "Discount Amt 3"
                          + "Discount Amt 4" + "System Discount Amount") / Sqrmtr, 0.01, '=');


                    BalanceQty := OrderQty - TotalShipped;
                    Value := MRPPerSqmtr * Sqrmtr * (BalanceQty);

                    //-OTIF Calc>>

                    OTIF := '';
                    IF (OrderQty * "Sales Invoice Line"."Qty. per Unit of Measure") = 0 THEN
                        OTIF := 'Blank Order'
                    ELSE
                        IF ShippedQty = 0 THEN
                            OTIF := 'Not Dispatched'
                        ELSE
                            //16225 IF ((OrderQty - TotalShipped1) * ("MRP Price" - LineDisPerSqMeter)) < 0 THEN//16225 Remove Field "MRP Price" - 
                            IF ((OrderQty - TotalShipped1) * (LineDisPerSqMeter)) < 0 THEN
                                OTIF := 'Not OTIF'
                            ELSE
                                OTIF := 'OTIF';


                    OTIFPer := '';
                    IF "Order No. 1" = '' THEN
                        OTIFPer := ''
                    ELSE
                        IF OTIF = 'OTIF' THEN
                            OTIFPer := SONo
                        ELSE
                            OTIFPer := '';
                    //-OTIF Calc<<

                    OrderCancldYes := 0;
                    OrderCancldNo := 0;
                    IF RsnDesc <> '' THEN
                        //16225 OrderCancldYes := ((BalanceQty - TotalShipped1) * ("MRP Price"-LineDisPerSqMeter))///16225 Remove Field "MRP Price" -
                        OrderCancldYes := ((BalanceQty - TotalShipped1) * (LineDisPerSqMeter))
                    ELSE
                        OrderCancldNo := ((BalanceQty - TotalShipped1) * (LineDisPerSqMeter))
                    //16225  OrderCancldNo := ((BalanceQty - TotalShipped1) * ("MRP Price"-LineDisPerSqMeter))//16225 Remove Field "MRP Price" -

                end;
            }
            dataitem("<Sales Line Archive1>"; "Sales Line Archive")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Version No." = CONST(1),
                                          "Outstanding Quantity" = FILTER(<> 0));
                column(ArchQty; Quantity * "Qty. per Unit of Measure")
                {
                }
                column(ArchItemNo; "No.")
                {
                }
                column(ArchLineNo; "Line No.")
                {
                }
                column(ArchLocation; "Location Code")
                {
                }
                column(ArcItemDesc; recItem.Description + ' ' + recItem."Description 2")
                {
                }
                column(ArchSize; COPYSTR((recItem.Description + ' ' + recItem."Description 2"), 1, 7))
                {
                }
                column(Archmanuf_strategy; recItem."Manuf. Strategy")
                {
                }
                column(ReleaseDate1; ReleaseDate1)
                {
                }
                column(LineDisPerSqMeter1; LineDisPerSqMeter1)
                {
                }
                //16225 column(MRPPerSqmtr1; "MRP Price")
                column(MRPPerSqmtr1; "Sales Invoice Line"."Unit Price")
                {
                }
                column(aValue; aValue)
                {
                }
                column(Adelaydays; aDelayDays)
                {
                }
                column(RemQty; "<Sales Line Archive1>".Quantity - "<Sales Line Archive1>"."Quantity Shipped")
                {
                }
                column(AdRem1; "AD Remarks")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //SETRANGE("Outstanding Quantity", Quantity);
                    SalesInvLine.RESET;
                    SalesInvLine.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                    SalesInvLine.SETRANGE("Order No. 1", "Document No.");
                    SalesInvLine.SETRANGE("Line No.", "Line No.");
                    IF SalesInvLine.FINDFIRST THEN
                        CurrReport.SKIP;


                    IF recItem.GET("No.") THEN;

                    IF "Posting Date" <> 0D THEN
                        PostingDt := "Posting Date"
                    ELSE
                        PostingDt := "Posting Date1";

                    /*
                    ReleaseDate1 := 0D;
                    IF "Location Code" = 'DP-MORBI' THEN
                      ReleaseDate1 := "Sales Header Archive"."Payment Date 3"
                    ELSE
                      ReleaseDate1 := "Sales Header Archive"."Date of Release";
                     */

                    //Rajiv 280717 Start

                    Sqrmtr1 := 0;
                    Sqmt1 := 0;
                    CLEAR(LineDisPerSqMeter1);
                    IF recItem.GET("No.") THEN;
                    Sqrmtr1 := ROUND(recItem.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                    Sqmt1 := recItem.UomToSqm("No.", "Unit of Measure Code", Quantity);

                    aValue := "Buyer's Price" * Sqrmtr1 * (BalanceQty);


                    IF "Quantity Shipped" <> 0 THEN
                        CurrReport.SKIP;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF TempSalesOrderNo <> "Sales Header Archive"."No." THEN BEGIN
                    SONo := '';
                    IF ("Sales Header Archive"."Promised Delivery Date" <> 0D) AND ("Sales Header Archive"."Date Archived" <> 0D) THEN
                        DelayDays := ABS("Date Archived" - "Promised Delivery Date");

                    IF "Sales Header Archive"."No." <> '' THEN BEGIN
                        SalesHdr.RESET;
                        SalesHdr.SETRANGE("No.", "Sales Header Archive"."No.");
                        IF SalesHdr.FINDFIRST THEN BEGIN
                            SONo := SalesHdr."No.";
                            SODate := SalesHdr."Order Date";
                            "CustNo." := SalesHdr."Sell-to Customer No.";
                            CustName := SalesHdr."Sell-to Customer Name";
                            CustCity := SalesHdr."Sell-to City";
                            CustType := SalesHdr."Customer Type";
                            ReleaseTime := SalesHdr."Releasing Time";
                            //ReleaseDate := SalesHdr."Releasing Date";

                            RecState.RESET;
                            RecState.SETRANGE(Code, State);
                            IF RecState.FINDFIRST THEN BEGIN
                                StateName := RecState.Description;
                                ReasonCode.RESET;
                                ReasonCode.SETRANGE(ReasonCode.Code, "Sales Header Archive"."Reason Code");
                                IF ReasonCode.FINDFIRST THEN
                                    RsnDesc := ReasonCode.Description
                                ELSE
                                    RsnDesc := '';

                            END;
                        END ELSE BEGIN
                            SONo := "Sales Header Archive"."No.";
                            SODate := "Sales Header Archive"."Order Date";
                            "CustNo." := "Sales Header Archive"."Sell-to Customer No.";
                            CustName := "Sales Header Archive"."Sell-to Customer Name";
                            CustCity := "Sales Header Archive"."Sell-to City";
                            CustType := "Sales Header Archive"."Customer Type";


                            //  ReleaseDate:= "Sales Header Archive"."Releasing Date";
                            ReleaseTime := "Sales Header Archive"."Releasing Time";
                            RecState.RESET;
                            RecState.SETRANGE(Code, State);
                            IF RecState.FINDFIRST THEN BEGIN
                                StateName := RecState.Description;
                                ReasonCode.RESET;
                                ReasonCode.SETRANGE(ReasonCode.Code, "Sales Header Archive"."Reason Code");
                                IF ReasonCode.FINDFIRST THEN
                                    RsnDesc := ReasonCode.Description
                                ELSE
                                    RsnDesc := '';

                            END ELSE //MSKS2311 Start
                                CurrReport.SKIP
                            //MSKS2311 End
                        END;
                    END;

                    IF "Location Code" = 'DP-MORBI' THEN BEGIN
                        ReleaseDate := "Payment Date 3";
                    END ELSE
                        IF Status = Status::Released THEN BEGIN
                            ReleaseDate := "Releasing Date";
                        END ELSE
                            ReleaseDate := 0D;

                    MODRD := 0;
                    IF ("Releasing Date" <> 0D) AND ("Order Date" <> 0D) THEN //BEGIN
                                                                              //IF "Promised Delivery Date" <> 0D THEN
                        MODRD := ABS("Releasing Date" - "Order Date")
                    ELSE
                        MODRD := 0;
                    //END;

                    RDPD := 0;
                    IF ("Releasing Date" <> 0D) AND ("Posting Date" <> 0D) THEN
                        // IF "Date Archived" <> 0D THEN
                        RDPD := ABS("Releasing Date" - "Posting Date")
                    ELSE
                        RDPD := 0;
                    //END;

                    MODPD := 0;
                    IF ("Posting Date" <> 0D) AND ("Order Date" <> 0D) THEN //BEGIN
                                                                            // IF "Date Archived" <> 0D THEN
                        MODPD := ABS("Posting Date" - "Order Date")
                    ELSE
                        MODPD := 0;
                    //END;


                    IF recCust.GET("Sell-to Customer No.") THEN;

                    //
                    TempSalesOrderNo := "Sales Header Archive"."No.";
                    SalesInvHdr.RESET;
                    SalesInvHdr.SETRANGE("No.", SalesInvHdr."Order No.");
                    IF SalesInvHdr.FINDFIRST THEN
                        PSI := SalesInvHdr."No.";
                END ELSE
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);
                SETFILTER("Location Code", LocFilter);
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.", "Document Type");
            RequestFilterFields = "Location Code";
            column(OpenOrderNo; "Sales Header"."No.")
            {
            }
            column(OpenSellNo; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(OSellName; "Sales Header"."Bill-to Name")
            {
            }
            column(OMakeOrderDate; "Sales Header"."Make Order Date")
            {
            }
            column(OReleaseDate; OReleaseDate)
            {
            }
            column(OReleaseTime; FORMAT("Releasing Time"))
            {
            }
            column(OOrderDate; "Sales Header"."Order Date")
            {
            }
            column(OCustCity; OCustCity)
            {
            }
            column(OCustType; OCustType)
            {
            }
            column(OStateName; OStateName)
            {
            }
            column(Rele_date; "Sales Header"."Releasing Date")
            {
            }
            column(Opromisedate; "Sales Header"."Promised Delivery Date")
            {
            }
            column(Order_processdate1; "Sales Header"."Payment Date 3")
            {
            }
            column(Reason_hold1; "Sales Header".Commitment)
            {
            }
            column(Despatch_rem1; "Sales Header"."Despatch Remarks")
            {
            }
            column(SHZone; recCust1.Zone)
            {
            }
            column(SHSalesTerr; recCust1."Area Code")
            {
            }
            column(MODRD1; MODRD1)
            {
            }
            column(RDPD1; RDPD1)
            {
            }
            column(MODPD1; MODPD1)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(<> 0));
                RequestFilterFields = "Unit of Measure Code";
                column(OItemNo; "Sales Line"."No.")
                {
                }
                column(ODesc; "Sales Line".Description + ' ' + "Sales Line"."Description 2")
                {
                }
                column(OQty; "Sales Line".Quantity)
                {
                }
                column(OReserveQty; "Sales Line"."Reserved Qty. (Base)")
                {
                }
                column(OLineDisPerSqMeter; OLineDisPerSqMeter)
                {
                }
                column(OMRPPerSqmtr; "Sales Line"."Buyer's Price /Sq.Mt")
                {
                }
                column(sl_loca; "Sales Line"."Location Code")
                {
                }
                column(manuf_strategy1; Item."Manuf. Strategy")
                {
                }
                column(AD_rem1; "Sales Line"."AD Remarks")
                {
                }
                column(QtyShipped; "Sales Line"."Quantity Shipped")
                {
                }
                column(DocNoSLine; "Sales Line"."Document No.")
                {
                }
                column(PostingDt1; "Sales Line"."Posting Date")
                {
                }
                column(PaymentDate31; OReleaseDate)
                {
                }
                column(ODelayDays; ODelayDays)
                {
                }
                column(SLSize; COPYSTR((Item.Description + ' ' + Item."Description 2"), 1, 7))
                {
                }
                column(OrderCancldNo1; OrderCancldNo1)
                {
                }
                column(OrderCancldYes1; OrderCancldYes1)
                {
                }
                column(OTIF1; OTIF1)
                {
                }
                column(OTIFPer1; OTIFPer1)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Cart: Decimal;
                    SQmt: Decimal;
                    wt: Decimal;
                    decrate: Decimal;
                begin
                    OLineDisPerSqMeter := 0;
                    OMRPPerSqmtr := 0;
                    Cart := Item.UomToCart("Sales Line"."No.", "Sales Line"."Unit of Measure Code", "Sales Line".Quantity);
                    SQmt := Item.UomToSqm("Sales Line"."No.", "Sales Line"."Unit of Measure Code", "Sales Line".Quantity);
                    wt := "Sales Line"."Gross Weight";
                    IF "Sales Line"."Quantity in Sq. Mt." <> 0 THEN BEGIN
                        IF SQmt <> 0 THEN
                            decrate := "Sales Line"."Line Discount Amount" / SQmt;
                    END;
                    CLEAR(OMRPPerSqmtr);
                    IF SQmt <> 0 THEN BEGIN
                        IF "Sales Line".Quantity <> 0 THEN
                            OMRPPerSqmtr := ("Sales Line"."Buyer's Price" * "Sales Line".Quantity / SQmt) + decrate;
                    END;

                    IF Sqrmtr <> 0 THEN
                        OLineDisPerSqMeter := ROUND((("Discount Amt 1" + "Discount Amt 2" + "Discount Amt 3"
                        + "Discount Amt 4" + "System Discount Amount") / Sqrmtr), 0.01, '=');


                    TotalShippedQty := 0;
                    SalesLine.RESET;
                    SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    SalesLine.SETRANGE("Document Type", "Document Type");
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Line No.");
                    IF SalesLine.FINDFIRST THEN
                        REPEAT
                            TotalShippedQty += SalesLine."Quantity Shipped";
                        UNTIL SalesLine.NEXT = 0;

                    OrderCancldYes1 := 0;
                    OrderCancldNo1 := 0;
                    IF RsnDesc <> '' THEN
                        //16225 OrderCancldYes1 := ((Quantity - TotalShippedQty) * ("MRP Price" - OLineDisPerSqMeter))
                        OrderCancldYes1 := ((Quantity - TotalShippedQty) * (OLineDisPerSqMeter))// 16225 remove field "MRP Price" -
                    ELSE
                        //16225  OrderCancldNo1 := ((Quantity - TotalShippedQty) * ("MRP Price" -  OLineDisPerSqMeter));
                        OrderCancldNo1 := ((Quantity - TotalShippedQty) * (OLineDisPerSqMeter));//16225 remove field "MRP Price" -

                    //-OTIF Calc>>

                    OTIF1 := '';
                    IF (Quantity * "Qty. per Unit of Measure") = 0 THEN
                        OTIF1 := 'Blank Order'
                    ELSE
                        IF ShippedQty = 0 THEN
                            OTIF1 := 'Not Dispatched'
                        ELSE
                            //16225 IF ((Quantity - TotalShippedQty) * ("MRP Price" - OLineDisPerSqMeter)) < 0 THEN
                            IF ((Quantity - TotalShippedQty) * (OLineDisPerSqMeter)) < 0 THEN//16225 Remove field "MRP Price" -
                                OTIF1 := 'Not OTIF'
                            ELSE
                                OTIF1 := 'OTIF';


                    OTIFPer1 := '';
                    IF "Document No." = '' THEN
                        OTIFPer1 := ''
                    ELSE
                        IF OTIF = 'OTIF' THEN
                            OTIFPer1 := "Document No."
                        ELSE
                            OTIFPer1 := '';
                    //-OTIF Calc<<
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord()
            var
                OpenSalesLine: Record "Sales Line";
            begin
                //CurrReport.SKIP;

                /*
                OpenSalesLine.RESET;
                OpenSalesLine..SETRANGE("Document Type","Document Type");
                OpenSalesLine.SETRANGE("Document No.","No.");
                IF OpenSalesLine.FINDFIRST THEN
                  IF OpenSalesLine.Quantity <> OpenSalesLine."Outstanding Quantity"THEN
                    CurrReport.SKIP;
                */

                OCustCity := "Sell-to City";
                OCustType := "Customer Type";
                RecState.RESET;
                RecState.SETRANGE(RecState.Code, State);
                IF RecState.FINDFIRST THEN
                    OStateName := RecState.Description;

                IF "Location Code" = 'DP-MORBI' THEN
                    OReleaseDate := "Payment Date 3"
                ELSE
                    OReleaseDate := "Releasing Date";

                IF recCust1.GET("Sell-to Customer No.") THEN;

                IF ("Promised Delivery Date" <> 0D) AND ("Order Date" <> 0D) THEN
                    ODelayDays := ABS("Promised Delivery Date" - "Order Date");


                MODRD1 := 0;
                IF ("Releasing Date" <> 0D) AND ("Order Date" <> 0D) THEN //BEGIN
                                                                          //IF "Promised Delivery Date" <> 0D THEN
                    MODRD1 := ABS("Releasing Date" - "Order Date")
                ELSE
                    MODRD1 := 0;
                //END;

                RDPD1 := 0;
                IF ("Releasing Date" <> 0D) AND ("Posting Date" <> 0D) THEN
                    // IF "Date Archived" <> 0D THEN
                    RDPD1 := ABS("Posting Date" - "Releasing Date")
                ELSE
                    RDPD1 := 0;
                //END;

                MODPD1 := 0;
                IF ("Posting Date" <> 0D) AND ("Order Date" <> 0D) THEN //BEGIN
                                                                        // IF "Date Archived" <> 0D THEN
                    MODPD1 := ABS("Posting Date" - "Order Date")
                ELSE
                    MODPD1 := 0;
                //END;

            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.BREAK;
                SETRANGE("Order Date", 20171029D, TODAY);//291017D
                SETFILTER("Location Code", LocFilter);
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
                field(Location; LocFilter)
                {
                    TableRelation = Location;
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

    var
        TempSalesOrderNo: Code[20];
        DOCNO: Code[20];
        RecState: Record State;
        SalesLine: Record "Sales Line";
        SalesHdr: Record "Sales Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvHdr: Record "Sales Invoice Header";
        CompInfo: Record "Company Information";
        Item: Record Item;
        ReasonCode: Record "Reason Code";
        SONo: Code[20];
        SODate: Date;
        "CustNo.": Code[20];
        CustName: Text[50];
        CustName2: Text[40];
        CustAdd: Text[50];
        CustAdd2: Text[50];
        CustCity: Text[30];
        MakeOrderDate: DateTime;
        ReleaseDate: Date;
        ReleaseTime: Time;
        StateName: Text[30];
        InvNo: Code[20];
        InvDate: Date;
        CustType: Text;
        ItemNo: Code[20];
        ItemDesc: Text[50];
        PSI: Code[20];
        ShippedQty: Decimal;
        RsnDesc: Text[50];
        RsnDate: Date;
        Sqrmtr: Decimal;
        Sqmt: Decimal;
        OCustCity: Code[20];
        OCustType: Code[20];
        OStateName: Text[100];
        OLineDisPerSqMeter: Decimal;
        OMRPPerSqmtr: Decimal;
        OReleaseTime: Time;
        StartDate: Date;
        EndDate: Date;
        LocFilter: Code[20];
        PostingDt: Date;
        OReleaseDate: Date;
        recSHdrArch: Record "Sales Header Archive";
        recSLnArch: Record "Sales Line Archive";
        "--MSVRN--": Integer;
        SLnArchQuantity: Decimal;
        ArchShippedQty: Decimal;
        OrderQty: Decimal;
        ReservedQty: Decimal;
        ADRem: Text;
        QtySqMtr: Decimal;
        recItem: Record Item;
        TotalShipped: Decimal;
        TotalShipped1: Decimal;
        ReleaseDate1: Date;
        aValue: Decimal;
        aBalanceQty: Decimal;
        aDelayDays: Decimal;
        Value: Decimal;
        BalanceQty: Decimal;
        DelayDays: Decimal;
        aLineDisPerSqMeter: Decimal;
        aMRPPerSqmtr: Decimal;
        LineDisPerSqMeter1: Decimal;
        Sqrmtr1: Decimal;
        Sqmt1: Decimal;
        MRPPerSqmtr1: Decimal;
        Value1: Decimal;
        LineDisPerSqMeter: Decimal;
        MRPPerSqmtr: Decimal;
        "--NewColumns--": Integer;
        recCust: Record Customer;
        recCust1: Record Customer;
        ODelayDays: Integer;
        MODRD: Integer;
        RDPD: Integer;
        MODPD: Integer;
        MODRD1: Integer;
        RDPD1: Integer;
        MODPD1: Integer;
        Item2: Record Item;
        OTIF: Text;
        OTIFPer: Text;
        OTIF1: Text;
        OTIFPer1: Text;
        OrderCancldYes: Decimal;
        OrderCancldNo: Decimal;
        OrderCancldYes1: Decimal;
        OrderCancldNo1: Decimal;
        TotalShippedQty: Decimal;
        Counter: Integer;
        SalesInvLine1: Record "Sales Invoice Line";


    procedure CalculateOTIF()
    begin
    end;
}

