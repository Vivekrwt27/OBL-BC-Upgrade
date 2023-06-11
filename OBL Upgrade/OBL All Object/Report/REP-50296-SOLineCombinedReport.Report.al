report 50296 "SO Line Combined Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SOLineCombinedReport.rdl';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order),
                                      "Sell-to Customer No." = FILTER(<> ''),
                                      "Type" = FILTER(Item),
                                      "Quantity" = FILTER(> 0),
                                      "Location Code" = FILTER('<>SKD-SAMPLE'));
            column(PendingTo; "PendingTo..")
            {
            }
            column(CustRegion; CustRegion)
            {
            }
            column(DisLocation; DisLocation)
            {
            }
            column(StateName; StateName)
            {
            }
            column(SalesTerritory; SalesTerritory)
            {
            }
            column(SellToCustNo; "Sell-to Customer No.")
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(CustCity; CustCity)
            {
            }
            column(CustType; CustType)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(OrderStatus; OrderStatus)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(OrderAgeing; OrderAgeing)
            {
            }
            column(ReleasingDate; ReleasingDate)
            {
            }
            column(ReleaseAgeing; ReleaseAgeing)
            {
            }
            column(PromisedDate; PromisedDate)
            {
            }
            column(ItemNo; "No.")
            {
            }
            column(ItemDecs; RecItem."Complete Description")
            {
            }
            column(ItemManfStrategy; RecItem."Manuf. Strategy")
            {
            }
            column(ADRemarks; "AD Remarks")
            {
            }
            column(ItemNPD; RecItem.NPD)
            {
            }
            column(GroupedOrderComments; GroupedOrderComments)
            {
            }
            column(OutstandingQty; "Outstanding Qty. (Base)")
            {
            }
            column(ReservedQty; "Reserved Qty. (Base)")
            {
            }
            column(OutstandingAmt; "Outstanding Amount (LCY)")
            {
            }
            //16225  column(AmtToCust; "Amount To Customer")
            column(AmtToCust; AmttoCustomerSalesLine("Sales Line"))
            {
            }
            column(CustOutstanding; CustOutstanding)
            {
            }
            column(CustOverDue; CustOverDue)
            {
            }
            column(CustCreditLimit; CustCreditLimit)
            {
            }
            column(ACPCY; RecCustomer."ACP (Current Year)")
            {
            }
            column(AgainstAdvPayment; AgainstAdvPayment)
            {
            }
            column(ItemSize; RecItem."Size Code Desc.")
            {
            }
            column(ItemProdPlantCode; RecItem."Default Prod. Plant Code")
            {
            }
            column(MfgLocation; MfgLocation)
            {
            }
            column(Reservation; Reservation)
            {
            }
            column(ItemTabProdGroup; RecItem."Tableau Product Group")
            {
            }
            column(AgeingforNomaterial; AgeingforNomaterial)
            {
            }
            column(Ord_come1; OrderComments)//16767
            {
            }
            column(Price_app1; "Approval Required")
            {
            }
            column(Inv_avail1; Inv_available)
            {
            }
            column(Ord_come; SalesHeader."Credit Approved")
            {
            }
            column(Inv_avail; SalesHeader."Inventory Approved")
            {
            }
            column(Price_app; SalesHeader."Price Approved")
            {
            }//16767

            trigger OnAfterGetRecord()
            begin
                IF "Sales Line"."Quantity (Base)" = "Sales Line"."Quantity Shipped" THEN
                    CurrReport.SKIP;

                IF RecItem.GET("Sales Line"."No.") THEN;

                CLEAR(MfgLocation);
                recItem1.RESET;
                IF recItem1.GET("Sales Line"."No.") THEN BEGIN
                    IF COPYSTR(recItem1."Default Prod. Plant Code", 1, 3) = 'SKD' THEN
                        MfgLocation := 'SKD'
                    ELSE
                        IF COPYSTR(recItem1."Default Prod. Plant Code", 1, 3) = 'HSK' THEN
                            MfgLocation := 'HSK'
                        ELSE
                            IF COPYSTR(recItem1."Default Prod. Plant Code", 1, 3) = 'DRA' THEN
                                MfgLocation := 'DRA'
                            ELSE
                                IF (COPYSTR(recItem1."Default Prod. Plant Code", 1, 8) = 'DP-MORBI') OR (COPYSTR(recItem1."Default Prod. Plant Code", 1, 10) = 'DP-BIKANER') THEN
                                    MfgLocation := 'WZ'
                                ELSE
                                    MfgLocation := 'DEPOT';
                END;

                IF (COPYSTR("Sales Line"."Location Code", 1, 8) = 'DP-MORBI') OR (COPYSTR("Sales Line"."Location Code", 1, 10) = 'DP-BIKANER') THEN
                    DisLocation := 'TRD'
                ELSE
                    IF COPYSTR("Sales Line"."Location Code", 1, 3) = 'SKD' THEN
                        DisLocation := 'SKD'
                    ELSE
                        IF COPYSTR("Sales Line"."Location Code", 1, 3) = 'HSK' THEN
                            DisLocation := 'HSK'
                        ELSE
                            IF COPYSTR("Sales Line"."Location Code", 1, 3) = 'DRA' THEN
                                DisLocation := 'DRA'
                            ELSE
                                DisLocation := 'DEPOT';


                RecSalesHeader.RESET;
                RecSalesHeader.SETRANGE("No.", "Sales Line"."Document No.");
                IF RecSalesHeader.FIND('-') THEN BEGIN
                    IF TODAY - RecSalesHeader."Order Date" <= 1 THEN
                        OrderAgeing := '0 - 1 Day'
                    ELSE
                        IF (TODAY - RecSalesHeader."Order Date" > 1) AND (TODAY - RecSalesHeader."Order Date" <= 2) THEN
                            OrderAgeing := '1 - 2 Days'
                        ELSE
                            IF (TODAY - RecSalesHeader."Order Date" > 2) AND (TODAY - RecSalesHeader."Order Date" <= 3) THEN
                                OrderAgeing := '2 - 3 Days'
                            ELSE
                                IF (TODAY - RecSalesHeader."Order Date" > 3) AND (TODAY - RecSalesHeader."Order Date" <= 10) THEN
                                    OrderAgeing := '4 - 10 Days'
                                ELSE
                                    IF (TODAY - RecSalesHeader."Order Date" > 10) THEN
                                        OrderAgeing := '> 10 Days';

                    IF (RecSalesHeader."Payment Terms Code" = '0') OR (RecSalesHeader."Payment Terms Code" = '00') THEN
                        AgainstAdvPayment := 'Yes'
                    ELSE
                        AgainstAdvPayment := '';

                    IF RecSalesHeader."Location Code" <> 'DP-MORBI' THEN BEGIN
                        OrderStatus := FORMAT(RecSalesHeader.Status);
                        IF RecSalesHeader.Status = RecSalesHeader.Status::Released THEN BEGIN
                            "PendingTo.." := 'Pending to Dispatch';
                            GroupedOrderComments := RecSalesHeader."Despatch Remarks";
                        END ELSE BEGIN
                            "PendingTo.." := 'Pending to Release';
                            GroupedOrderComments := RecSalesHeader.Commitment;
                        END;
                    END ELSE
                        IF RecSalesHeader."Location Code" = 'DP-MORBI' THEN BEGIN
                            IF RecSalesHeader."Payment Date 3" = 0D THEN BEGIN
                                "PendingTo.." := 'Pending to Release';
                                OrderStatus := FORMAT(RecSalesHeader.Status);
                                GroupedOrderComments := RecSalesHeader.Commitment;
                            END ELSE BEGIN
                                "PendingTo.." := 'Pending to Dispatch';
                                OrderStatus := 'Release';
                                GroupedOrderComments := RecSalesHeader."Despatch Remarks";
                                OrderComments := RecSalesHeader."Credit Approved";
                            END;
                        END;
                END;

                CLEAR(ReleasingDate);
                RecSalesHeader.RESET;
                RecSalesHeader.SETRANGE("No.", "Sales Line"."Document No.");
                IF RecSalesHeader.FIND('-') THEN BEGIN
                    OrderDate := RecSalesHeader."Order Date";
                    IF COPYSTR(RecSalesHeader."Location Code", 1, 3) = 'DP-' THEN BEGIN
                        ReleasingDate := RecSalesHeader."Payment Date 3"
                    END ELSE BEGIN
                        ReleasingDate := RecSalesHeader."Releasing Date";
                    END;
                    PromisedDate := RecSalesHeader."Promised Delivery Date";
                END;

                IF "PendingTo.." = '' THEN BEGIN
                    AgeingforNomaterial := ''
                END ELSE
                    IF ("PendingTo.." <> '') AND (OrderDate <> 0D) THEN BEGIN
                        IF TODAY - OrderDate <= 1 THEN
                            AgeingforNomaterial := '0 - 1 day'
                        ELSE
                            IF (TODAY - OrderDate > 1) AND (TODAY - OrderDate <= 7) THEN
                                AgeingforNomaterial := '2 - 7 days'
                            ELSE
                                IF (TODAY - OrderDate > 7) AND (TODAY - OrderDate <= 10) THEN
                                    AgeingforNomaterial := '8 - 10 days'
                                ELSE
                                    IF (TODAY - OrderDate > 10) AND (TODAY - OrderDate <= 20) THEN
                                        AgeingforNomaterial := '11 - 20 days'
                                    ELSE
                                        IF (TODAY - OrderDate > 20) AND (TODAY - OrderDate <= 30) THEN
                                            AgeingforNomaterial := '21 - 30 days'
                                        ELSE
                                            IF (TODAY - OrderDate > 30) THEN
                                                AgeingforNomaterial := ' + 30 days';
                    END;

                IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
                    // RecCustomer.CALCFIELDS("Outstanding Amount");
                    SalesTerritory := RecCustomer."Area Code";
                    CustomerName := RecCustomer.Name;
                    CustCity := RecCustomer.City;
                    CustOutstanding := RecCustomer."Outstanding IBOT";
                    CustCreditLimit := RecCustomer."Credit Limit (LCY)";
                    CustOverDue := RecCustomer."OverDue Amt IBOT";
                    IF RecCustomer."Tableau Zone" = 'CKA' THEN
                        CustRegion := 'Enterprise'
                    ELSE
                        CustRegion := RecCustomer."Tableau Zone";
                    IF RecState.GET(RecCustomer."State Code") THEN BEGIN
                        StateName := RecState.Description;
                    END;
                    RecCustType.RESET;
                    RecCustType.SETFILTER(Type, '%1', RecCustType.Type::Customer);
                    RecCustType.SETRANGE(Code, RecCustomer."Customer Type");
                    IF RecCustType.FINDFIRST THEN
                        CustomerType := RecCustType.Description;
                END;

                IF (CustomerType = 'Central Key Account') OR (CustomerType = 'Direct Project') THEN
                    CustType := 'Enterprise'
                ELSE
                    CustType := 'Retail';

                IF ReleasingDate <> 0D THEN BEGIN
                    IF TODAY - ReleasingDate <= 1 THEN
                        ReleaseAgeing := '0 - 1 Day'
                    ELSE
                        IF (TODAY - ReleasingDate > 1) AND (TODAY - ReleasingDate <= 2) THEN
                            ReleaseAgeing := '1 - 2 Days'
                        ELSE
                            IF (TODAY - ReleasingDate > 2) AND (TODAY - ReleasingDate <= 3) THEN
                                ReleaseAgeing := '2 - 3 Days'
                            ELSE
                                IF (TODAY - ReleasingDate > 3) AND (TODAY - ReleasingDate <= 10) THEN
                                    ReleaseAgeing := '4 - 10 Days'
                                ELSE
                                    IF (TODAY - ReleasingDate > 10) THEN
                                        ReleaseAgeing := '> 10 Days';
                END ELSE BEGIN
                    ReleaseAgeing := '';
                END;

                "Sales Line".CALCFIELDS("Reserved Qty. (Base)");

                IF "Sales Line"."Reserved Qty. (Base)" > 0 THEN
                    Reservation := 'Yes'
                ELSE
                    Reservation := 'No';

                //ExcelLine;
                IF SalesHeader.GET("Sales Line"."Document Type", "Document No.") THEN;
                IF "Outstanding Qty. (Base)" <> "Reserved Qty. (Base)" THEN
                    Inv_available := 'FALSE'
                ELSE
                    Inv_available := 'TRUE';

            end;





            trigger OnPreDataItem()
            begin
                "Sales Line".SETFILTER("Sales Line"."Item Category Code", '%1|%2|%3|%4', 'M001', 'D001', 'H001', 'T001');

                CLEAR("PendingTo..");
                CLEAR(StateName);
                CLEAR(CustomerName);
                CLEAR(CustCity);
                CLEAR(SalesTerritory);
                CLEAR(OrderDate);
                CLEAR(CustomerType);
                CLEAR(CustType);
                CLEAR(ReleasingDate);
                CLEAR(OrderAgeing);
                CLEAR(ReleaseAgeing);
                CLEAR(PromisedDate);
                CLEAR(CustOutstanding);
                CLEAR(CustOverDue);
                CLEAR(CustCreditLimit);
                CLEAR(OrderStatus);
                CLEAR(GroupedOrderComments);
                CLEAR(Reservation);
                CLEAR(AgainstAdvPayment);
                CLEAR(AgeingforNomaterial);
                CLEAR(CustRegion);
                CLEAR(DisLocation);
                CLEAR(MfgLocation);
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
        //ExcelBuffer.CreateBookAndOpenExcel('SO Line Combined','SO Line Combined-'+FORMAT(TODAY),'SO Line Combined Report',COMPANYNAME,USERID);
    end;

    trigger OnPreReport()
    begin
        //ExcelHeader;
    end;

    var

        ExcelBuffer: Record "Excel Buffer" temporary;
        RecCustomer: Record Customer;
        RecSalesHeader: Record "Sales Header";
        RecState: Record State;
        RecItem: Record Item;
        recItem1: Record Item;
        RecCustType: Record "Customer Type";
        StateName: Text[80];
        SalesTerritory: Code[12];
        DisLocation: Code[20];
        CustomerName: Text[50];
        CustCity: Text[30];
        CustomerType: Text[50];
        CustType: Text[50];
        Status: Text[30];
        OrderDate: Date;
        OrderAgeing: Text[30];
        ReleasingDate: Date;
        ReleaseAgeing: Text[30];
        PromisedDate: Date;
        CustRegion: Text[10];
        CustOutstanding: Decimal;
        CustCreditLimit: Decimal;
        CustOverDue: Decimal;
        "PendingTo..": Text[30];
        OrderStatus: Text[30];
        GroupedOrderComments: Text[40];
        AgainstAdvPayment: Text[3];
        MfgLocation: Code[20];
        Reservation: Text[3];
        AgeingforNomaterial: Text[30];
        OrderComments: Boolean;
        Inv_available: Text[10];
        SalesHeader: Record 36;
        creditapp: Boolean;
        inv_found: Boolean;
        price: Boolean;

    local procedure ExcelHeader()
    begin
        /*
        ExcelBuffer.AddColumn(' SO Line Combined Report ',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' For Dated ',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TODAY,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Pending to…',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Region',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dispatch Location',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('State Name',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Territory',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bill-to Customer No.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Name',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('City',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Type',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document No.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Status',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Make Order Date',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ageing After Make Order Date',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' Releasing Date',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ageing After Releasing Date',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Promised Delivery Date',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('No.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Description',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Manufacturing Strategy',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('AD Remarks',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Trackers Lag',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Grouped Order Comments',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Outstanding Qty. in Sqm.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Reserved Qty. in Sqm.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Outstanding Order Value',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Outstanding Amount To Customer ',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Outstanding',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Overdue Outstanding',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Credit Limit',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Avg. Collection Period',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Against Adv. Payment',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Size',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Mfg. Location',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Reservation Available',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Tableau Product Group',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order Ageing for No Material',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);

        */

    end;

    local procedure ExcelLine()
    begin
        /*
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("PendingTo..",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustRegion,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DisLocation,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(StateName,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalesTerritory,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line"."Sell-to Customer No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustomerName,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustCity,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustType,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(OrderStatus,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(OrderDate,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(OrderAgeing,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ReleasingDate,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(ReleaseAgeing,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PromisedDate,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Sales Line"."No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(RecItem."Complete Description",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(RecItem."Manuf. Strategy",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line"."AD Remarks",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(RecItem.NPD,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(GroupedOrderComments,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line"."Outstanding Qty. (Base)",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."Reserved Qty. (Base)",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."Outstanding Amount (LCY)",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."Amount To Customer",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(CustOutstanding,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(CustOverDue,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(CustCreditLimit,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecCustomer."ACP (Current Year)",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AgainstAdvPayment,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(RecItem."Size Code Desc.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(RecItem."Default Prod. Plant Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MfgLocation,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Reservation,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(RecItem."Tableau Product Group",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(AgeingforNomaterial,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
      */

    end;

    local procedure AmttoCustomerSalesLine(T37: Record 37): Decimal
    var
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        TotalAmt: Decimal;
        GSTSetup: Record "GST Setup";
        ComponentName: Text;
        TaxTransactionValue: Record "Tax Transaction Value";
        sgstTOTAL: Decimal;
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        GSTSetup.Get();
        TDSSetup.Get();
        Clear(igst);
        Clear(sgst);
        Clear(cgst);
        Clear(TotalAmt);
        Clear(TDSAmt);

        TotalAmt := T37."Line Amount";
        if T37.Type <> T37.Type::" " then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat

                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                ComponentName := 'SGST';
                                sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper3 := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                ComponentName := 'CGST';
                                cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper2 := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                ComponentName := 'IGST';
                                igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper1 := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
            cgstTOTAL += cgst;
            sgstTOTAL += sgst;
            igstTotal += igst;

            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TDSAmt += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;

        exit((TotalAmt + igst + sgst + cgst) - TDSAmt);
    end;

    local procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;


}

