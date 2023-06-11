report 50059 SalesOrderClearance
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesOrderClearance.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Order Ledger Entry"; 50105)
        {
            DataItemTableView = SORTING("Sales Order No.", "Sales Order Line No.")
                                WHERE(Quantity = FILTER(> 0),
                                      "Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG'),
                                     "Mfg Plant" = FILTER('D001|M001|H001'));
            RequestFilterFields = "Posting Date";
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
            column(CrDt; "Sales Order Ledger Entry"."Creation DateTime")
            {
            }
            column(Qty; "Sales Order Ledger Entry".Quantity)
            {
            }
            column(Month; FORMAT(Month))
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
            column(MfgPlant; MfgPlant)
            {
            }
            column(BoolMtsItem; BoolMtsItem)
            {
            }
            column(MTSQty; MTSQty)
            {
            }
            column(MTOQty; MTOQty)
            {
            }
            column(Default_prod; "Sales Order Ledger Entry"."Default Prod. Line Code")
            {
            }

            trigger OnAfterGetRecord()
            var
                SizeMaster: Record 349;
                CloseDt: Date;
                SalesHeader: Record 36;
                CrApprovalDt: Date;
                Customer: Record 18;
                Item: Record 27;
            begin
                //IF OrderSkipifInvExists("Sales Order Ledger Entry"."Sales Order No.") THEN
                //  CurrReport.SKIP;
                CLEAR(MTSQty);
                CLEAR(MTOQty);
                "Sales Order Ledger Entry".CALCFIELDS("Inventory status");
                IF "Sales Order Ledger Entry"."Inventory status" THEN CurrReport.SKIP;


                BlnCrApproved := FALSE;
                Month := FORMAT("Sales Order Ledger Entry"."Order Date", 0, '<Month Text>');
                CloseDt := GetNoMaterialDate("Sales Order Ledger Entry"."Sales Order No.");
                /* IF CloseDt = 0D THEN BEGIN
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Sales Order Ledger Entry"."Sales Order No.") THEN
                        CloseDt := TODAY;
                END;

                IF CloseDt = 0D THEN
                    CurrReport.SKIP;16630 */

                CrApprovalDt := GetCreditApprovallDate("Sales Order Ledger Entry"."Sales Order No.");

                IF (CrApprovalDt < CloseDt) AND (CrApprovalDt <> 0D) THEN
                    BlnCrApproved := TRUE
                ELSE
                    BlnCrApproved := FALSE;

                IF BlnCrApproved THEN TxtCredit := 'Credit Approved' ELSE TxtCredit := 'Credit Not Approved';

                IF ("Sales Order Ledger Entry"."Order Date" <> 0D) AND (CloseDt <> 0D) THEN
                    Days := (CloseDt - "Sales Order Ledger Entry"."Order Date");

                SizeMaster.RESET;
                SizeMaster.SETRANGE(Code, "Sales Order Ledger Entry"."Size Code");
                IF Customer.GET("Sales Order Ledger Entry"."Customer No.") THEN
                    IF Customer."Tableau Zone" IN ['Enterprise', 'Misc'] THEN CurrReport.SKIP;

                BoolMtsItem := FALSE;
                IF Item.GET("Sales Order Ledger Entry"."No.") THEN
                    BoolMtsItem := (Item."Manuf. Strategy" = Item."Manuf. Strategy"::"Make-to-Stock");

                IF BoolMtsItem THEN
                    MTSQty := "Sales Order Ledger Entry".Quantity
                ELSE
                    MTOQty := "Sales Order Ledger Entry".Quantity;
                IF Item."Default Prod. Plant Code" <> '' THEN
                    MfgPlant := COPYSTR(Item."Default Prod. Plant Code", 1, 3);
                IF MfgPlant = 'MOR' THEN
                    MfgPlant := 'West Zone';
            end;

            trigger OnPreDataItem()
            begin
                //16630 "Sales Order Ledger Entry".SETRANGE("Sales Order Ledger Entry"."Order Date", FromDate, EndDate);
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
        /* FromDate := CALCDATE('-2M-CM', TODAY);
        EndDate := CALCDATE('CM', TODAY);16630 */
        ;
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
        BoolMtsItem: Boolean;
        MfgPlant: Text;
        MTSQty: Decimal;
        MTOQty: Decimal;

    local procedure GetNoMaterialDate(SalesOrderNo: Code[20]): Date
    var
        SalesOrderStatusLog: Record 50060;
    begin
        SalesOrderStatusLog.SETRANGE("Sales Order No.", SalesOrderNo);
        SalesOrderStatusLog.SETFILTER(Status, '%1', SalesOrderStatusLog.Status::"Inventory Approved");
        IF SalesOrderStatusLog.FINDLAST THEN
            EXIT(DT2DATE(SalesOrderStatusLog."Change Datetime"));
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

