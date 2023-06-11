report 50072 "Order TAT Report_NEW"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\OrderTATReportNEW.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("No.", "Document Type")
                                WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "No.";
            column(No_SalesHeader1; "Sales Header"."No.")
            {
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = FILTER(Order),
                                          Type = FILTER(Item),
                                          "Item Category Code" = FILTER('M001|T001|D001|H001'));
                column(ItemCategoryCode_SalesLine; "Sales Line"."Item Category Code")
                {
                }
                column(ApprovedTime; ApprovedTime)
                {
                }
                column(SentTimeApproval; SentTimeApproval)
                {
                }
                column(MaxApprovTime; MaxApprovTime)
                {
                }
                column(No_SalesHeader; "Sales Line"."Document No.")
                {
                }
                column(Status_SalesHeader; "Sales Line".Status)
                {
                }
                column(Ship_SalesHeader; SalesHeader.Ship)
                {
                }
                column(BilltoCustomerNo_SalesHeader; SalesHeader."Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesHeader; SalesHeader."Bill-to Name")
                {
                }
                column(BilltoCity_SalesHeader; SalesHeader."Bill-to City")
                {
                }
                column(StateDesc_SalesHeader; "Sales Line"."State Name")//"Sales Line"."State Name")
                {
                }
                column(CustomerType_SalesHeader; SalesHeader."Customer Type")
                {
                }
                column(PaymentTermsCode_SalesHeader; SalesHeader."Payment Terms Code")
                {
                }
                column(QtyinSqMt_SalesHeader; SalesHeader."Qty in Sq. Mt.")
                {
                }
                column(OutstandingQty_SalesHeader; SalesHeader."Outstanding Qty")
                {
                }
                column(AmounttoCustomer_SalesHeader; AmttoCustomerSL("Sales Line")) // 16630 SalesHeader."Amount to Customer"
                {
                }
                column(MakeOrderDate_SalesHeader; SalesHeader."Make Order Date")
                {
                }
                column(PaymentDiscount_SalesHeader; SalesHeader."Discount Charges %")
                {
                }
                column(Dispatch_Remarks; SalesHeader."Despatch Remarks")
                {
                }
                column(Order_Received; SalesHeader."Order Booked Date")
                {
                }
                column(OrderCreatedID_SalesHeader; SalesHeader."Order Created ID")
                {
                }
                column(ReleasingDate_SalesHeader; FORMAT("Sales Header"."Date of Release"))
                {
                }
                column(PostingDate_SalesHeader; SalesHeader."Posting Date")
                {
                }
                column(DueDate_SalesHeader; SalesHeader."Due Date")
                {
                }
                column(OrderReceivedDate; SalesHeader."Order Date")
                {
                }
                column(ReleasingTime_SalesHeader; FORMAT("Sales Header"."Time of Release"))
                {
                }
                column(SalesTerritory; Customer."Area Code")
                {
                }
                column(Zone; Customer.Zone)
                {
                }
                column(ReasonToHold; SalesHeader.Commitment)
                {
                }
                dataitem("Sales Invoice Header"; 112)
                {
                    DataItemLink = "Order No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Order No.");
                    column(PostingDate_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
                    {
                    }
                    column(InvoicedQty; InvoicedQty)
                    {
                    }
                    column(AmounttoCustomer_SalesInvoiceHeader; InvoicedValue)
                    {
                    }
                    column(CollectedAmt; CollectedAmt)
                    {
                    }
                    column(LastPaymentReceiptDate_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."Last Payment Receipt Date"))
                    {
                    }
                    column(AvgFulFilmentTime; "Sales Invoice Header"."Posting Date" - "Sales Invoice Header"."Order Date")
                    {
                    }
                    column(NoDays; NoofDays)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF TempSILno <> "Sales Invoice Header"."No." THEN BEGIN
                            TempSILno := "Sales Invoice Header"."No.";
                            CLEAR(InvoicedQty);
                            CLEAR(InvoicedValue);
                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                            SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            IF SalesInvoiceLine.FINDSET THEN
                                REPEAT
                                    InvoicedQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    InvoicedValue += SalesInvoiceLine."Line Amount";
                                UNTIL SalesInvoiceLine.NEXT = 0;

                            CLEAR(CollectedAmt);
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                            CustLedgerEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            IF CustLedgerEntry.FINDSET THEN BEGIN
                                CustLedgerEntry.CALCFIELDS("Amount (LCY)", "Remaining Amt. (LCY)");
                                CollectedAmt := CustLedgerEntry."Amount (LCY)" - CustLedgerEntry."Remaining Amt. (LCY)";
                            END;

                            CLEAR(NoofDays);
                            //CLEAR(InvValue);
                            //CLEAR(TotalInvoicedValue);
                            //CLEAR(NoDays);
                            //"Sales Invoice Header".CALCFIELDS("Sales Invoice Header"."Last Payment Receipt Date");
                            IF "Sales Invoice Header"."Last Payment Receipt Date" <> 0D THEN
                                NoofDays := "Sales Invoice Header"."Last Payment Receipt Date" - "Sales Invoice Header"."Posting Date";
                            /*
                           IF NoofDays > 0 THEN BEGIN
                             InvValue := NoofDays * "Sales Invoice Header".Amount;
                             TotalInvoicedValue := "Sales Invoice Header".Amount;
                           END;
                           IF (InvValue>0) AND (TotalInvoicedValue>0) THEN
                             NoDays := (InvValue / TotalInvoicedValue);
                           */
                        END;

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /* sgstTOTAL := 0;
                    igst := 0;
                    igstTotal := 0;
                    sgst := 0;
                    GSTper3 := 0;
                    cgst := 0;
                    GSTper1 := 0;
                    GSTper2 := 0;
                    cgstTOTAL := 0;
                    TotalAmt := 0;
                    TotalAmtSL := 0;




                    Clear(sgst);
                    Clear(igst);
                    Clear(cgst);
                    Clear(TotalAmt);
                    ReccSalesLine.Reset();
                    ReccSalesLine.SetRange("Document Type", "Sales Header Archive"."Document Type");
                    ReccSalesLine.SetRange("Document No.", "Sales Header Archive"."No.");
                    if ReccSalesLine.FindSet() then
                        repeat
                            TotalAmt += ReccSalesLine."Line Amount";
                            GSTSetup.Get();
                            if GSTSetup."GST Tax Type" = GSTLbl then
                                if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                                    ComponentName := IGSTLbl
                                else
                                    ComponentName := CGSTLbl
                            else
                                if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                                    ComponentName := CESSLbl;

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
                                                    sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper3 := TaxTransactionValue.Percent;
                                                end;
                                            2:
                                                begin
                                                    cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper2 := TaxTransactionValue.Percent;
                                                end;
                                            3:
                                                begin
                                                    igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper1 := TaxTransactionValue.Percent;
                                                end;
                                        end;
                                    until TaxTransactionValue.Next() = 0;
                                cgstTOTAL += cgst;
                                sgstTOTAL += sgst;
                                igstTotal += igst;
                            end;
                            TotalAmtSL += "Line Amount" + igst + sgst + cgst;
                        until ReccSalesLine.Next() = 0;
16630 */
                    //MESSAGE('%1', "Sales Line"."Document No.");
                    IF TempSL <> "Sales Line"."Document No." THEN BEGIN
                        TempSL := "Sales Line"."Document No.";
                        SalesHeader.RESET;
                        IF SalesHeader.GET("Sales Line"."Document Type", "Sales Line"."Document No.") THEN
                            // 16630    SalesHeader.CALCFIELDS("Qty in Sq. Mt.", "Outstanding Qty", "Amount to Customer");


                            //CLEAR(MaxApprovTime); //Commented
                            CLEAR(SentTimeApproval);
                        CLEAR(ApprovedTime);
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                        ApprovalEntry.SETRANGE("Document No.", "Sales Line"."Document No.");
                        IF ApprovalEntry.FINDLAST THEN
                            REPEAT
                                ApprovedTime := ApprovalEntry."Last TimeStamp";
                                SentTimeApproval := ApprovalEntry."Date-Time Sent for Approval";
                            // MaxApprovTime := ApprovalEntry."Last TimeStamp" - ApprovalEntry."Date-Time Sent for Approval"; //Commented
                            UNTIL ApprovalEntry.NEXT = 0;

                        Customer.RESET;
                        IF Customer.GET("Sales Line"."Sell-to Customer No.") THEN;
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                SETFILTER("Sales Header"."Order Date", '%1..%2', StartDate, EndDate);
            end;
        }
        dataitem("Sales Header Archive"; 5107)
        {
            DataItemTableView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                WHERE("Document Type" = FILTER(Order),
                                      "Version No." = CONST(1));
            RequestFilterFields = "No.";
            column(No_SalesHeaderArchive2; "Sales Header Archive"."No.")
            {
            }
            dataitem("Sales Line Archive"; 5108)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
                                    WHERE("Document Type" = FILTER(Order),
                                          Type = FILTER(Item),
                                          "Item Category Code" = FILTER('M001|T001|D001|H001'));
                column(Quantitysqmt_SalesHeaderArchive; SalesHeaderArchive."Quantity sq.mt")
                {
                }
                column(Status_SalesHeaderArchive; SalesHeaderArchive.Status)
                {
                }
                column(BilltoCustomerNo_SalesHeaderArchive; SalesHeaderArchive."Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesHeaderArchive; SalesHeaderArchive."Bill-to Name")
                {
                }
                column(BilltoCity_SalesHeaderArchive; SalesHeaderArchive."Bill-to City")
                {
                }
                column(StateDesc_SalesHeaderArchive; RecState.Description)
                {
                }
                column(CustomerType_SalesHeaderArchive; SalesHeaderArchive."Customer Type")
                {
                }
                column(PaymentTermsCode_SalesHeaderArchive; SalesHeaderArchive."Payment Terms Code")
                {
                }
                column(QtyOutstanding_SalesHeaderArchive; SalesHeaderArchive."Qty Outstanding")
                {
                }
                column(AmounttoCustomer_SalesHeaderArchive; AmttoCustomerSalesLine("Sales Line Archive")) // 16630 SalesHeaderArchive."Amount to Customer"
                {
                }
                column(DiscountCharges_SalesHeaderArchive; SalesHeaderArchive."Discount Charges %")
                {
                }
                column(OrderDate_SalesHeaderArchive; SalesHeaderArchive."Order Date")
                {
                }
                column(OpenerID_SalesHeaderArchive; SalesHeaderArchive."Opener ID")
                {
                }
                column(ReleasingDate_SalesHeaderArchive; FORMAT(SalesHeaderArchive."Date of Release"))
                {
                }
                column(PostingDate_SalesHeaderArchive; SalesHeaderArchive."Posting Date")
                {
                }
                column(DueDate_SalesHeaderArchive; SalesHeaderArchive."Due Date")
                {
                }
                column(ReleasingTime_SalesHeaderArchive; FORMAT(SalesHeaderArchive."Time of Release"))
                {
                }
                column(Commitment_SalesHeaderArchive; SalesHeaderArchive.Commitment)
                {
                }
                column(DespatchRemarks_SalesHeaderArchive; SalesHeaderArchive."Despatch Remarks")
                {
                }
                column(DocumentDate_SalesHeaderArchive; SalesHeaderArchive."Document Date")
                {
                }
                column(ItemCategoryCode_SalesLineArchive; "Sales Line Archive"."Item Category Code")
                {
                }
                column(No_SalesHeaderArchive; "Sales Line Archive"."Document No.")
                {
                }
                column(SalesTerritory2; Customer."Area Code")
                {
                }
                column(Zone2; Customer.Zone)
                {
                }
                column(SentTimeApproval2; SentTimeApproval)
                {
                }
                dataitem("<Sales Invoice Header2>"; 112)
                {
                    DataItemLink = "Order No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Order No.");
                    column(PostingDate_SalesInvoiceHeader2; FORMAT("<Sales Invoice Header2>"."Posting Date"))
                    {
                    }
                    column(OrderNo_SalesInvoiceHeader2; "<Sales Invoice Header2>"."Order No.")
                    {
                    }
                    column(No_SalesInvoiceHeader2; "<Sales Invoice Header2>"."No.")
                    {
                    }
                    column(InvoicedQty2; InvoicedQty)
                    {
                    }
                    column(AmounttoCustomer_SalesInvoiceHeader2; InvoicedValue)
                    {
                    }
                    column(CollectedAmt2; CollectedAmt)
                    {
                    }
                    column(LastPaymentReceiptDate_SalesInvoiceHeader2; "<Sales Invoice Header2>"."Last Payment Receipt Date")
                    {
                    }
                    column(AvgFulFilmentTime2; "<Sales Invoice Header2>"."Posting Date" - "<Sales Invoice Header2>"."Order Date")
                    {
                    }
                    column(NoDays2; NoofDays2)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF TempSHA <> "<Sales Invoice Header2>"."No." THEN BEGIN
                            TempSHA := "<Sales Invoice Header2>"."No.";

                            CLEAR(InvoicedQty);
                            CLEAR(InvoicedValue);

                            SalesInvoiceLine.RESET;
                            //SalesInvoiceLine.SETCURRENTKEY(Type, "Document No.");
                            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                            SalesInvoiceLine.SETRANGE("Document No.", "<Sales Invoice Header2>"."No.");
                            IF SalesInvoiceLine.FINDSET THEN
                                REPEAT
                                    InvoicedQty += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    InvoicedValue += SalesInvoiceLine."Line Amount";
                                UNTIL SalesInvoiceLine.NEXT = 0;

                            CLEAR(CollectedAmt);
                            CustLedgerEntry.RESET;
                            //CustLedgerEntry.SETCURRENTKEY("Document Type", "Document No.");
                            CustLedgerEntry.CALCFIELDS("Amount (LCY)", "Remaining Amt. (LCY)");
                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                            CustLedgerEntry.SETRANGE("Document No.", "<Sales Invoice Header2>"."No.");
                            IF CustLedgerEntry.FINDSET THEN BEGIN
                                CustLedgerEntry.CALCFIELDS("Amount (LCY)", "Remaining Amt. (LCY)");
                                CollectedAmt := CustLedgerEntry."Amount (LCY)" - CustLedgerEntry."Remaining Amt. (LCY)";
                            END;

                            CLEAR(NoofDays2);
                            //CLEAR(InvValue);
                            //CLEAR(TotalInvoicedValue);
                            //CLEAR(NoDays);
                            //"Sales Invoice Header".CALCFIELDS("Sales Invoice Header"."Last Payment Receipt Date");
                            IF "<Sales Invoice Header2>"."Last Payment Receipt Date" <> 0D THEN
                                NoofDays2 := "<Sales Invoice Header2>"."Last Payment Receipt Date" - "<Sales Invoice Header2>"."Posting Date";
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /* sgstTOTAL := 0;
                    igst := 0;
                    igstTotal := 0;
                    sgst := 0;
                    GSTper3 := 0;
                    cgst := 0;
                    GSTper1 := 0;
                    GSTper2 := 0;
                    cgstTOTAL := 0;
                    TotalAmt := 0;
                    TotalAmtSLA := 0;




                    Clear(sgst);
                    Clear(igst);
                    Clear(cgst);
                    Clear(TotalAmt);
                    ReccSalesLine.Reset();
                    ReccSalesLine.SetRange("Document Type", "Sales Header Archive"."Document Type");
                    ReccSalesLine.SetRange("Document No.", "Sales Header Archive"."No.");
                    if ReccSalesLine.FindSet() then
                        repeat
                            TotalAmt += ReccSalesLine."Line Amount";
                            GSTSetup.Get();
                            if GSTSetup."GST Tax Type" = GSTLbl then
                                if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                                    ComponentName := IGSTLbl
                                else
                                    ComponentName := CGSTLbl
                            else
                                if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                                    ComponentName := CESSLbl;

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
                                                    sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper3 := TaxTransactionValue.Percent;
                                                end;
                                            2:
                                                begin
                                                    cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper2 := TaxTransactionValue.Percent;
                                                end;
                                            3:
                                                begin
                                                    igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper1 := TaxTransactionValue.Percent;
                                                end;
                                        end;
                                    until TaxTransactionValue.Next() = 0;
                                cgstTOTAL += cgst;
                                sgstTOTAL += sgst;
                                igstTotal += igst;
                            end;
                            TotalAmtSLA += "Line Amount" + igst + sgst + cgst;
                        until ReccSalesLine.Next() = 0;
16630 */
                    IF TempSLA <> "Sales Line Archive"."Document No." THEN BEGIN
                        TempSLA := "Sales Line Archive"."Document No.";
                        SalesHeaderArchive.RESET;
                        IF SalesHeaderArchive.GET("Sales Line Archive"."Document Type", "Sales Line Archive"."Document No.",
                          "Sales Line Archive"."Doc. No. Occurrence", "Sales Line Archive"."Version No.") THEN
                            // 16630    SalesHeaderArchive.CALCFIELDS(SalesHeaderArchive."Quantity sq.mt", SalesHeaderArchive."Amount to Customer");

                            RecState.RESET;
                        // 16630 IF RecState.GET(state) THEN;
                        //CLEAR(MaxApprovTime);
                        CLEAR(SentTimeApproval);
                        //CLEAR(ApprovedTime);
                        PostedApprovalEntry.RESET;
                        //PostedApprovalEntry.SETCURRENTKEY(Status, "Document No.");
                        PostedApprovalEntry.SETRANGE(Status, PostedApprovalEntry.Status::Approved);
                        PostedApprovalEntry.SETRANGE("Document No.", "Sales Line Archive"."Document No.");
                        IF PostedApprovalEntry.FINDLAST THEN
                            REPEAT
                                //ApprovedTime := PostedApprovalEntry."Last TimeStamp";
                                SentTimeApproval := PostedApprovalEntry."Date-Time Sent for Approval";
                            //MaxApprovTime := PostedApprovalEntry."Last TimeStamp" - PostedApprovalEntry."Date-Time Sent for Approval";
                            UNTIL PostedApprovalEntry.NEXT = 0;

                        Customer.RESET;
                        IF Customer.GET("Sales Line Archive"."Sell-to Customer No.") THEN;
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                SETFILTER("Sales Header Archive"."Order Date", '%1..%2', StartDate, EndDate);
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
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
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

    var
        ApprovalEntry: Record "Approval Entry";
        PCHApprovTime: DateTime;
        ZHApprovTime: DateTime;
        PACApprovTime: DateTime;
        SentTimeApproval: DateTime;
        PCHtime: Duration;
        ZHtime: Duration;
        MaxApprovTime: Duration;
        PACtime: Duration;
        SalesLine: Record "Sales Line";
        InvoicedQty: Decimal;
        QtySQM: Decimal;
        Customer: Record Customer;
        StartDate: Date;
        EndDate: Date;
        SalesInvoiceLine: Record "Sales Invoice Line";
        InvoicedValue: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CollectedAmt: Decimal;
        ApprovedTime: DateTime;
        PostedApprovalEntry: Record "Posted Approval Entry";
        SalesHeader: Record "Sales Header";
        TempSILno: Code[30];
        TempSL: Code[30];
        TempSHA: Code[30];
        TempSLA: Code[30];
        SalesHeaderArchive: Record "Sales Header Archive";
        NoofDays: Integer;
        InvValue: Decimal;
        TotalInvoicedValue: Decimal;
        NoDays: Integer;
        STdate: Date;
        RecState: Record State;
        NoofDays2: Integer;
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;
        TotalAmtSLA: Decimal;
        TotalAmtSL: Decimal;




    local procedure VariableInitialize()
    begin
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
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

    procedure AmttoCustomerSalesLine(T37: Record "Sales Line Archive"): Decimal
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

    procedure AmttoCustomerSL(T37: Record "Sales Line"): Decimal
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

}

