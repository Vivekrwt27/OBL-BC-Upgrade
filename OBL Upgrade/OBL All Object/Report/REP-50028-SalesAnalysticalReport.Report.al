report 50028 SalesAnalysticalReport
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesAnalysticalReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Order Ledger Entry"; 50105)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Quantity = FILTER(> 0),
                                      "Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG'),
                                      Closed = CONST(true),
                                      "Mfg Plant" = FILTER('D001|T001|M001|H001'));
            column(FromDate; FromDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(LocationCode; "Sales Order Ledger Entry"."Location Code")
            {
            }
            column(SalesOrderNo; "Sales Order Ledger Entry"."Sales Order No.")
            {
            }
            column(ItemNO; "Sales Order Ledger Entry"."No.")
            {
            }
            column(SizeCode; "Sales Order Ledger Entry"."Size Description")
            {
            }
            column(Orderdate; "Sales Order Ledger Entry"."Order Date")
            {
            }
            column(CrDt; CloseDt)
            {
            }
            column(Qty; "Sales Order Ledger Entry".Quantity)
            {
            }
            column(Month; Month)
            {
            }
            column(Days; Days)
            {
            }
            column(WeightQty; ("Sales Order Ledger Entry".Quantity) * Days)
            {
            }
            column(Location_Code; "Sales Order Ledger Entry"."Location Code")
            {
            }
            column(Order_No; "Sales Order Ledger Entry"."Sales Order No.")
            {
            }
            column(CrApproved; TxtCredit)
            {
            }
            column("Count"; 1)
            {
            }
            column(MfgPolicy; MfgPolicy)
            {
            }
            column(ItemDesc; Item."Complete Description")
            {
            }
            column(Manuf_plant; "Sales Order Ledger Entry"."Default Prod. Line Code")
            {
            }
            column(Desp; "Sales Order Ledger Entry"."Order Plant")
            {
            }
            column(Size; "Sales Order Ledger Entry"."Size Description")
            {
            }

            trigger OnAfterGetRecord()
            var
                SizeMaster: Record 349;
                SalesHeader: Record 36;
                CrApprovalDt: Date;
                Customer: Record 18;
            begin
                //IF OrderSkipifInvExists("Sales Order Ledger Entry"."Sales Order No.") THEN
                //  CurrReport.SKIP;

                //"Sales Order Ledger Entry".CALCFIELDS("Inventory status");
                //IF "Sales Order Ledger Entry"."Inventory status" THEN CurrReport.SKIP;

                BlnCrApproved := FALSE;
                Month := FORMAT("Sales Order Ledger Entry"."Order Date", 0, '<Month Text>');

                CloseDt := GetNoMaterialDate("Sales Order Ledger Entry"."Sales Order No.");

                IF CloseDt = 0D THEN BEGIN
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Sales Order Ledger Entry"."Sales Order No.") THEN
                        CloseDt := TODAY;
                END;

                //IF CloseDt=0D THEN
                //  CurrReport.SKIP;
                /*
                CrApprovalDt:= GetCreditApprovallDate("Sales Order Ledger Entry"."Sales Order No.");
                
                IF (CrApprovalDt < CloseDt) AND (CrApprovalDt<>0D) THEN
                  BlnCrApproved := TRUE
                ELSE
                  BlnCrApproved :=FALSE;
                
                IF BlnCrApproved THEN TxtCredit := 'Credit Approved' ELSE TxtCredit := 'Credit Not Approved';
                */
                IF ("Sales Order Ledger Entry"."Order Date" <> 0D) AND (CloseDt <> 0D) THEN
                    Days := (CloseDt - "Sales Order Ledger Entry"."Order Date");

                SizeMaster.RESET;
                SizeMaster.SETRANGE(Code, "Sales Order Ledger Entry"."Size Code");

                IF Item.GET("Sales Order Ledger Entry"."No.") THEN
                    MfgPolicy := FORMAT(Item."Manuf. Strategy");
                IF Customer.GET("Sales Order Ledger Entry"."Customer No.") THEN
                    IF Customer."Tableau Zone" IN ['Enterprise', 'Misc'] THEN CurrReport.SKIP;

            end;

            trigger OnPreDataItem()
            begin
                "Sales Order Ledger Entry".SETRANGE("Sales Order Ledger Entry"."Order Date", FromDate, EndDate);
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
        FromDate := CALCDATE('-CM', TODAY);
        EndDate := CALCDATE('CM', TODAY);

    end;

    trigger OnPreReport()
    begin
        //MESSAGE('%1--%2',FromDate,EndDate);
    end;

    var
        FromDate: Date;
        EndDate: Date;
        Month: Text;
        Days: Integer;
        BlnCrApproved: Boolean;
        TxtCredit: Text;
        CloseDt: Date;
        MfgPolicy: Text;
        Item: Record 27;

    local procedure GetNoMaterialDate(SalesOrderNo: Code[20]): Date
    var
        SalesOrderStatusLog: Record 50060;
        SalesHeaderArchive: Record 5107;
        SalesOrderLedgerEntry: Record 50105;
        SalesInvoiceHeader: Record 112;
    begin
        /*
        SalesOrderStatusLog.SETRANGE("Sales Order No.",SalesOrderNo);
        SalesOrderStatusLog.SETFILTER(Status,'%1',SalesOrderStatusLog.Status::"Inventory Approved");
        IF SalesOrderStatusLog.FINDLAST THEN
          EXIT(DT2DATE(SalesOrderStatusLog."Change Datetime"));
        
        SalesHeaderArchive.RESET;
        SalesHeaderArchive.SETRANGE("No.",SalesOrderNo);
        IF SalesHeaderArchive.FINDLAST THEN
        EXIT(SalesHeaderArchive."Date Archived");
        
        SalesOrderLedgerEntry.RESET;
        SalesOrderLedgerEntry.SETRANGE("Sales Order No.",SalesOrderNo);
        IF SalesOrderLedgerEntry.FINDLAST THEN
        EXIT(DT2DATE(SalesOrderLedgerEntry."Creation DateTime"));
        */

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETRANGE("Order No.", SalesOrderNo);
        IF SalesInvoiceHeader.FINDLAST THEN
            EXIT(SalesInvoiceHeader."Releasing Date");

    end;

    local procedure GetCreditApprovallDate(SalesOrderNo: Code[20]): Date
    var
        SalesOrderStatusLog: Record 50060;
    begin
        SalesOrderStatusLog.SETRANGE("Sales Order No.", SalesOrderNo);
        SalesOrderStatusLog.SETFILTER(Status, '%1', SalesOrderStatusLog.Status::"Credit Approved");
        IF SalesOrderStatusLog.FINDLAST THEN
            EXIT(DT2DATE(SalesOrderStatusLog."Change Datetime"));
    end;

    local procedure OrderSkipifInvExists(SalesOrderNo: Code[20]): Boolean
    var
        SalesOrderStatusLog: Record 50060;
    begin
        SalesOrderStatusLog.SETRANGE("Sales Order No.", SalesOrderNo);
        //SalesOrderStatusLog.SETFILTER(Processed,'%1',TRUE);
        //SalesOrderStatusLog.SETRANGE("Inventory Approved",TRUE);
        //IF SalesOrderStatusLog.FINDFIRST THEN
        //  EXIT(SalesOrderStatusLog."Inventory Approved");
        //SalesOrderStatusLog.CALCFIELDS("Inventory status")
        //SalesOrderStatusLog.SETFILTER("Inventory status",'%1',TRUE);
    end;
}

