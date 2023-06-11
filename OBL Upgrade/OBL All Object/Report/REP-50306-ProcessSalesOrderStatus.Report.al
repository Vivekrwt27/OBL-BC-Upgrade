report 50306 "Process Sales Order Status"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order), "Status" = FILTER(Open | "Pending Approval" | "Credit Approved" | "Price Approved" | "Not in Inventory"), "Bypass Auto Order Process" = CONST(false), "Order Date" = FILTER('<10/07/22'));

            trigger OnAfterGetRecord()
            begin
                //16225"Sales Header".CALCFIELDS("Sales Header"."Amount to Customer");
                IF AmttoCustomer("Sales Header") = 0 THEN
                    CurrReport.SKIP;

                //Sample Order
                IF "Sales Header"."Group Code" = '05' THEN BEGIN
                    "Sales Header".Status := "Sales Header".Status::Approved;
                    "Sales Header".MODIFY;
                END;


                IF "Sales Header"."Group Code" = '' THEN BEGIN
                    "Sales Header".Status := "Sales Header".Status::Approved;
                    "Sales Header".MODIFY;
                END;

                IF ("Sales Header".Status = "Sales Header".Status::Open) AND ("Sales Header"."Customer Type" IN ['GET', 'SET', 'PET']) THEN
                    CurrReport.SKIP;

                IF ("Sales Header".State = '19') AND ("Sales Header".Status = "Sales Header".Status::Open) THEN CurrReport.SKIP;

                IF ("Sales Header"."Discount Charges %" <> 0) AND ("Sales Header".Status = "Sales Header".Status::Open) THEN CurrReport.SKIP;

                //IF ("Sales Header"."Group Code" = '05') AND ("Sales Header".Status = "Sales Header".Status::Open) THEN CurrReport.SKIP;

                //Open|Pending Approval|Credit Approved|Price Approved
                CASE "Sales Header".Status OF
                    "Sales Header".Status::Open:
                        BEGIN
                            IF (TODAY - "Sales Header"."Order Date") > 2 THEN
                                EXIT
                            ELSE BEGIN
                                "Sales Header".SendForCreditApproval("Sales Header");
                                "Sales Header".MODIFY;
                            END;
                        END;
                    "Sales Header".Status::"Credit Approved":
                        BEGIN
                            "Sales Header".SendForApproval;
                            "Sales Header".MODIFY;
                        END;
                    "Sales Header".Status::"Not in Inventory":
                        BEGIN
                            IF "Sales Header".ISReadytoDespatch("Sales Header") THEN BEGIN
                                "Sales Header".Status := "Sales Header".Status::Approved;
                                //"Sales Header"."Inventory Directly Approved" := TRUE;
                            END ELSE BEGIN
                                "Sales Header".Status := "Sales Header".Status::"Not in Inventory";
                                "Sales Header"."InventoryNot Directly Approved" := TRUE;
                            END;
                            "Sales Header".MODIFY;
                        END;
                    "Sales Header".Status::"Price Approved":
                        BEGIN
                            IF "Sales Header".ISReadytoDespatch("Sales Header") THEN
                                "Sales Header".Status := "Sales Header".Status::Approved
                            ELSE BEGIN
                                "Sales Header".Status := "Sales Header".Status::"Not in Inventory";
                                "Sales Header"."InventoryNot Directly Approved" := TRUE;
                            END;
                            "Sales Header".MODIFY;
                        END;


                //  "Sales Header".Status::"Pending Approval":
                //   BEGIN
                //    "Sales Header".SendForApproval;
                //   "Sales Header".MODIFY;
                // END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("Sales Header"."Order Date",'%1..',TODAY-2);
                Message('Done');
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
        WeightedAvg: Record "LC Detail for Export";
        totalamount1: Decimal;

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

}

