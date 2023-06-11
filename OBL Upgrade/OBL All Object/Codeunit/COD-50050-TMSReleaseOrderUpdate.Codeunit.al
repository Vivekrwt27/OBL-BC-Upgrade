codeunit 50050 "TMS Release Order Update"
{

    trigger OnRun()
    begin
        //InsertTMSData('');
        UpdateTMSData;
        UpdatePMSData;
        IF GUIALLOWED THEN MESSAGE('Done');
        /*
        InsertDataIntoNAVT;
        IF HASTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL, 'data') THEN
          UNREGISTERTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL,'data');
        REGISTERTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL, 'data', 'Data Source=DBNAV2013T;Initial Catalog=DBNAV2016;Integrated Security=SSPI;');
        SETDEFAULTTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL,'data');
        */

        ////open 231219
        /*
        recSQL2NAV.RESET;
        recSQL2NAV.SETRANGE(SOCreated, FALSE);
        IF recSQL2NAV.FINDFIRST THEN
          REPEAT
            REPORT.RUNMODAL(50288, TRUE, FALSE, recSQL2NAV);
          UNTIL recSQL2NAV.NEXT = 0;
        */

        /*
        recSQL2NAV.RESET;
        IF recSQL2NAV.FINDSET THEN
          REPEAT
            recSQL2NAV.SOCreated := TRUE;
            recSQL2NAV.MODIFY;
          UNTIL recSQL2NAV.NEXT = 0;
        */
        /*
        recSQL2NAV.RESET;
        IF recSQL2NAV.FINDSET THEN
          REPEAT
            recSQL2NAV.SOCreated := FALSE;
            recSQL2NAV.MODIFY;
          UNTIL recSQL2NAV.NEXT = 0;
          */

    end;

    var
        recSQL2NAV: Record "Item Wise Focused Prod.";
    // PgSQL2NAV: Page 50079;

    local procedure InsertDataIntoNAVT()
    var
        // ExecuteBat: DotNet ProcessStartInfo;
        // Process: DotNet Process;
        Command: Text;
        Result: Text;
        ErrorMsg: Text;
    begin
        Command := 'D:\EmailReader\EmailReaderByNAV.bat';
        // ExecuteBat := ExecuteBat.ProcessStartInfo('cmd', '/c "' + Command + '"');     //Provide Details of the Process that need to be Executed.
        //ExecuteBat.RedirectStandardError := TRUE;      // In Case of Error the Error Should be Redirected.
        //ExecuteBat.RedirectStandardOutput := TRUE;     // In Case of Sucess the Error Should be Redirected.
        //ExecuteBat.UseShellExecute := FALSE;
        //ExecuteBat.CreateNoWindow := TRUE;             // In case we want to see the window set it to False.
        // Process := Process.Process;                    // Constructor
        //Process.StartInfo(ExecuteBat);
        // Process.Start;
        // ErrorMsg := Process.StandardError.ReadToEnd(); // Check Error Exist or Not
        /*
        IF ErrorMsg <> '' THEN
          ERROR('%1','Error occured!')
        ELSE BEGIN
          Result := Process.StandardOutput.ReadToEnd();// Display the Query in the Batch File.
          MESSAGE('%1','Data inderted!');
        END;
        */

    end;


    procedure InsertTMSData(SalesOrderNo: Code[20])
    var
        TMSSalesOrder: Query "TMS Sales Order for Order Rele";
        TMSData: Record "TMS Data";
    begin
        IF SalesOrderNo = '' THEN EXIT;
        CLEAR(TMSSalesOrder);
        IF SalesOrderNo <> '' THEN
            TMSSalesOrder.SETFILTER(TMSSalesOrder.SaleOrderFilter, '%1', SalesOrderNo);
        TMSSalesOrder.SETFILTER(TMSSalesOrder.Status, '%1', TMSSalesOrder.Status::Released);
        TMSSalesOrder.OPEN;
        WHILE TMSSalesOrder.READ DO BEGIN
            IF TMSData.GET(TMSSalesOrder.SO_Number) THEN
                TMSData.DELETE;

            TMSData."Sales Order No." := TMSSalesOrder.SO_Number;
            TMSData."Make Order Date" := TMSSalesOrder.SO_Date_n_time;
            TMSData."Bill-to Name" := TMSSalesOrder.Buyer_Name;
            TMSData."Ship-to City" := TMSSalesOrder.Ship_to_City;
            TMSData."From Plant Name" := TMSSalesOrder.From_Plant_Name;
            TMSData."Total Load(KG)" := TMSSalesOrder.Total_Load_Kg;
            TMSData.Status := FORMAT(TMSSalesOrder.Status);
            TMSData."Loading Officer" := TMSSalesOrder.Loading_officer;
            TMSData."Transport Method" := TMSSalesOrder.Transport_method;
            TMSData."Releasing Date" := TMSSalesOrder.Releasing_date;
            TMSData."Quantity in SqMt." := TMSSalesOrder.Quantity_Sqmt;
            TMSData.VALIDATE("Outstanding Qty.", TMSSalesOrder.Outstanding_Quantity);
            TMSData."Quantity Invoiced" := TMSSalesOrder.Sum_Quantity_Invoiced;
            TMSData."Gross Wt. Shipped" := TMSSalesOrder.Shipped_Load_kg;
            TMSData."Gross Wt. Outstanding" := TMSSalesOrder.Balance_Load_KG;
            TMSData."Dispatch City" := TMSSalesOrder.From_Plant_Name;
            TMSData."Sales Person MobileNo." := TMSSalesOrder.Sales_Officer_no;
            TMSData."Sales Person Name" := TMSSalesOrder.Sales_officer_Name;
            TMSData."Customer Type" := TMSSalesOrder.Customer_Type;
            TMSData."State Code" := TMSSalesOrder.Code;
            TMSData."Ship to State Description" := TMSSalesOrder.Ship_to_State;
            TMSData.INSERT;
        END;
    end;

    local procedure UpdateTMSData()
    var
        TMSData: Record "TMS Data";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        TMSData.RESET;
        IF TMSData.FINDFIRST THEN
            REPEAT
                TMSData.CALCFIELDS("Sales Order No Main");
                TMSData.Closed := (TMSData."Sales Order No Main" = '');
                TMSData.MODIFY;
            UNTIL TMSData.NEXT = 0;

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETCURRENTKEY("Posting Date");
        SalesInvoiceHeader.SETFILTER("Posting Date", '%1..%2', TODAY - 5, TODAY);
        SalesInvoiceHeader.SETFILTER("Order No.", '<>%1', '');
        SalesInvoiceHeader.SETFILTER("Truck No.", '%1', 'ADV');
        IF SalesInvoiceHeader.FINDFIRST THEN
            REPEAT
                IF TMSData.GET(SalesInvoiceHeader."Order No.") THEN BEGIN
                    TMSData.Closed := FALSE;
                    TMSData.MODIFY;
                END;
            UNTIL SalesInvoiceHeader.NEXT = 0;
    end;

    local procedure UpdatePMSData()
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesRetJournalData: Query "Sales Return Journal Data";
        PMTDiscountMaster: Record "PMT Discount Master";
        DesQty: Decimal;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ADAmt: Decimal;
        MaxDt: Date;
        MinDt: Date;
        RetQty: Decimal;
    begin
        CLEAR(SalesJournalData);

        PMTDiscountMaster.RESET;
        //PMTDiscountMaster.SETRANGE("PMT ID",58589);
        PMTDiscountMaster.SETCURRENTKEY(Closed);
        PMTDiscountMaster.SETRANGE(Closed, FALSE);
        IF PMTDiscountMaster.FINDFIRST THEN BEGIN
            REPEAT
                DesQty := 0;
                RetQty := 0;
                ADAmt := 0;
                MinDt := 99990101D;
                MaxDt := 0D;
                CLEAR(SalesJournalData);

                SalesJournalData.SETFILTER(SalesJournalData.PMTCode, '%1', PMTDiscountMaster."Lead ID");
                //IF PMTDiscountMaster."Customer No."<>'' THEN
                //  SalesJournalData.SETFILTER(SalesJournalData.CustomerNo,'%1',PMTDiscountMaster."Customer No.");
                SalesJournalData.SETFILTER(SalesJournalData.ItemNo, '%1', PMTDiscountMaster."Item No.");
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    IF MaxDt <= SalesJournalData.PostingDate THEN
                        MaxDt := SalesJournalData.PostingDate;
                    IF MinDt > SalesJournalData.PostingDate THEN
                        MinDt := SalesJournalData.PostingDate;
                    DesQty += SalesJournalData.Quantity_Base;
                    ADAmt += SalesJournalData.line_discount;
                END;

                SalesRetJournalData.SETFILTER(SalesRetJournalData.PMT_Code, '%1', PMTDiscountMaster."Lead ID");
                //    IF PMTDiscountMaster."Customer No."<>'' THEN
                //  SalesRetJournalData.SETFILTER(SalesRetJournalData.CustomerNo,'%1',PMTDiscountMaster."Customer No.");

                SalesRetJournalData.SETFILTER(SalesRetJournalData.ItemNo, '%1', PMTDiscountMaster."Item No.");
                SalesRetJournalData.OPEN;
                WHILE SalesRetJournalData.READ DO BEGIN
                    RetQty += SalesRetJournalData.Quantity_Base;
                END;
                PMTDiscountMaster."Despatch Qty." := DesQty;

                SalesHeader.RESET;
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SETRANGE("PMT Code", PMTDiscountMaster."Lead ID");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    DesQty := 0;
                    REPEAT
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.SETRANGE("No.", PMTDiscountMaster."Item No.");
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                DesQty += SalesLine."Outstanding Qty. (Base)"
                            UNTIL SalesLine.NEXT = 0;
                    UNTIL SalesHeader.NEXT = 0;
                    PMTDiscountMaster."Order Qty." := DesQty;

                END ELSE BEGIN
                    PMTDiscountMaster."Order Qty." := 0;

                END;
                /*    PMTDiscountMaster."Remaining Qty." := (PMTDiscountMaster."PMT Qty."+PMTDiscountMaster.Tolerance)-(PMTDiscountMaster."Despatch Qty."+ PMTDiscountMaster."Order Qty."+ PMTDiscountMaster."Despatch Qty. 310322");

                 IF (PMTDiscountMaster."Despatch Qty."+ PMTDiscountMaster."Order Qty.")<>0 THEN BEGIN
                     PMTDiscountMaster.Closed := (PMTDiscountMaster."Remaining Qty."<=0);
                    PMTDiscountMaster."Remaining Qty." := (PMTDiscountMaster."PMT Qty."+PMTDiscountMaster.Tolerance)-(PMTDiscountMaster."Despatch Qty."+ PMTDiscountMaster."Order Qty."+ PMTDiscountMaster."Despatch Qty. 310322");
                 END ELSE BEGIN*/
                //END;

                PMTDiscountMaster."Remaining Qty." := (PMTDiscountMaster."PMT Qty." + PMTDiscountMaster.Tolerance + PMTDiscountMaster."Sales Return") - (PMTDiscountMaster."Despatch Qty." + PMTDiscountMaster."Order Qty." + PMTDiscountMaster."Despatch Qty. 310322");
                PMTDiscountMaster.Closed := (PMTDiscountMaster."Remaining Qty." <= 0);

                PMTDiscountMaster."Total AD" := ADAmt;
                IF MaxDt <> 0D THEN
                    PMTDiscountMaster."Last Inv Date" := MaxDt;
                IF (MinDt < 99990101D) AND (PMTDiscountMaster."First Inv Date" = 0D) THEN
                    PMTDiscountMaster."First Inv Date" := MinDt;
                IF PMTDiscountMaster."Despatch Qty." <> 0 THEN
                    PMTDiscountMaster."Actual AD" := PMTDiscountMaster."Total AD" / PMTDiscountMaster."Despatch Qty.";
                PMTDiscountMaster."Sales Return" := RetQty;
                PMTDiscountMaster.MODIFY;

            UNTIL PMTDiscountMaster.NEXT = 0;
        END;

    end;
}

