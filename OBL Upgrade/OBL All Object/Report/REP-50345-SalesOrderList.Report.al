report 50345 "Sales Order List"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesOrderList.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order),
                                      // 16225 Structure=FILTER('GST+FID+TD'|'GST+FD+TD'|'GST+FD+TDI'),
                                      "Qty in Sq. Mt." = FILTER(<> 0),
                                      "Location Code" = FILTER('<>SKD-SAMPLE' & '<>HSK-SAMPLE' & '<>DRA-SAMPLE' & '<>HEADOFFICE'));
            RequestFilterFields = "Posting Date";
            column(Status_SalesHeader; "Sales Header".Status)
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(CustomerType_SalesHeader; "Sales Header"."Customer Type")
            {
            }
            column(PaymentTermsCode_SalesHeader; "Sales Header"."Payment Terms Code")
            {
            }
            column(DealerCode_SalesHeader; "Sales Header"."Dealer Code")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(ShiptoCity_SalesHeader; "Sales Header"."Ship-to City")
            {
            }
            column(Quantity_SalesHeader; "Sales Header".Quantity)
            {
            }
            column(QtyinSqMt_SalesHeader; "Sales Header"."Qty in Sq. Mt.")
            {
            }
            column(ReleasingDate_SalesHeader; "Sales Header"."Releasing Date")
            {
            }
            column(ReleasingTime_SalesHeader; "Sales Header"."Releasing Time")
            {
            }
            //16225 column(Structure_SalesHeader;"Sales Header".Structure)
            column(Structure_SalesHeader; '')
            {
            }
            column(OpenerID_SalesHeader; "Sales Header"."Opener ID")
            {
            }
            column(DateofReopen_SalesHeader; "Sales Header"."Date of Reopen")
            {
            }
            column(TimeofReopen_SalesHeader; "Sales Header"."Time of Reopen")
            {
            }
            column(ReleaserID_SalesHeader; "Sales Header"."Releaser ID")
            {
            }
            column(OrderCreatedID_SalesHeader; "Sales Header"."Order Created ID")
            {
            }
            //16225 column(AmounttoCustomer_SalesHeader;"Sales Header"."Amount to Customer")
            column(AmounttoCustomer_SalesHeader; AmttoCustomer("Sales Header"))
            {
            }
            column(DiscountCharges_SalesHeader; "Sales Header"."Discount Charges %")
            {
            }
            column(GrossWt_SalesHeader; "Sales Header"."Gross Wt.")
            {
            }
            column(MakeOrderDate_SalesHeader; FORMAT("Sales Header"."Make Order Date"))
            {
            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
            }
            column(Remarks_SalesHeader; "Sales Header".Remarks)
            {
            }
            column(ApprovalPendingAt_SalesHeader; "Sales Header"."Approval Pending At")
            {
            }
            column(ReservedQty_SalesHeader; "Sales Header"."Reserved Qty")
            {
            }
            column(RequestedDeliveryDate_SalesHeader; "Sales Header"."Requested Delivery Date")
            {
            }
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
            {
            }
            column(OrderDate_SalesHeader; "Sales Header"."Order Date")
            {
            }
            column(DocumentDate_SalesHeaders; "Sales Header"."Document Date")
            {
            }
            column(TruckNo_SalesHeader; "Sales Header"."Truck No.")
            {
            }
            column(PromisedDeliveryDate_SalesHeader; "Sales Header"."Promised Delivery Date")
            {
            }
            column(DespatchRemarks_SalesHeader; "Sales Header"."Despatch Remarks")
            {
            }
            column(CDAvailableforUtilisation_SalesHeader; "Sales Header"."CD Available for Utilisation")
            {
            }
            column(StateDescription; RecState.Description)
            {
            }
            column(CustName; RecCust.Name)
            {
            }
            column(CustGSTRebNo; RecCust."GST Registration No.")
            {
            }
            column(SentTime; SentTime)
            {
            }
            column(PCHTime; PCHTime)
            {
            }
            column(ZMTime; ZMTime)
            {
            }
            column(PSMTime; PSMTime)
            {
            }
            column(PACTime; PACTime)
            {
            }
            column(OrderProcessDate; "Sales Header"."Payment Date 3")
            {
            }
            column(ReasontoHold; Commitment)
            {
            }
            column(DespatchRemarks; "Despatch Remarks")
            {
            }
            column(Pendingat; Pendingat)
            {
            }
            column(out_qty; "Sales Header"."Outstanding Qty")
            {
            }
            column(out_amt; "Sales Header"."Outstanding Amount")
            {
            }
            column(Sales_Terretory; SalesTerr)
            {
            }
            column(pay; "Sales Header".Pay)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // IF "Sales Header"."Posting Date" = 0D THEN
                //  CurrReport.SKIP;
                //
                Pendingat := '';
                IF Status = Status::"Pending Approval" THEN BEGIN
                    AppEntry.RESET;
                    AppEntry.SETRANGE(AppEntry."Document No.", "No.");
                    AppEntry.SETRANGE(AppEntry.Status, AppEntry.Status::Created);
                    IF AppEntry.FINDFIRST THEN
                        IF SP.GET(AppEntry."Approver Code") THEN
                            Pendingat := SP.Name;
                END;

                //MSAK - 050318
                IF RecCust.GET("Sales Header"."Bill-to Customer No.") THEN;
                IF RecState.GET(RecCust."State Code") THEN;

                IF RecCust.GET("Sales Header"."Sell-to Customer No.") THEN
                    SalesTerr := RecCust."Area Code";


                //
                CLEAR(SentTime);
                CLEAR(PACTime);
                ArchiveApprovalEntryREC.RESET;
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", "No.");
                IF ArchiveApprovalEntryREC.FINDFIRST THEN
                    SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

                ArchiveApprovalEntryREC.RESET;
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", "No.");
                IF ArchiveApprovalEntryREC.FINDFIRST THEN
                    REPEAT
                        IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                            PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
                    UNTIL ArchiveApprovalEntryREC.NEXT = 0;

                CLEAR(Count1);
                CLEAR(PCHTime);
                CLEAR(ZMTime);
                CLEAR(PSMTime);
                ArchiveApprovalEntryREC.RESET;
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", "No.");
                IF ArchiveApprovalEntryREC.FINDFIRST THEN
                    REPEAT
                        Count1 += 1;
                        IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                            PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                        IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                            ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                        IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                            PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                    UNTIL ArchiveApprovalEntryREC.NEXT = 0;
                //MSAK
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
        RecCust: Record Customer;
        RecState: Record State;
        ArchiveApprovalEntryREC: Record "Archive Approval Entry";
        SentTime: DateTime;
        PACTime: DateTime;
        Count1: Integer;
        PCHTime: DateTime;
        ZMTime: DateTime;
        PSMTime: DateTime;
        AppEntry: Record "Approval Entry";
        Pendingat: Text[50];
        SP: Record "Salesperson/Purchaser";
        SalesTerr: Text[50];
        salesline: Record "Sales Line";


    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
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

    procedure AmttoCustomer(T36: Record 36): Decimal
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
        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document Type", T36."Document Type");
        ReccSalesLine.SetRange("Document No.", T36."No.");
        if ReccSalesLine.FindSet() then
            repeat
                TotalAmt += ReccSalesLine."Line Amount";


                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
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
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Value ID", 7);
                    //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            TDSAmt += TaxTransactionValue.Amount;
                        until TaxTransactionValue.Next() = 0;
                end;
            until ReccSalesLine.Next() = 0;
        exit((TotalAmt + igst + sgst + cgst) - TDSAmt);
    end;



}

