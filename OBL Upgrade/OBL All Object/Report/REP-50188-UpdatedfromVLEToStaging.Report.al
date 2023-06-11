report 50188 "Updated from VLE To Staging"
{
    Caption = 'Updated from VLE To Staging';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Vendor Ledger Entry"; 25)
        {
            DataItemTableView = SORTING("Document No.")
                                ORDER(Ascending)
                                WHERE("Updated in Staging" = FILTER(false),
                                      "Document Type" = FILTER('Credit Memo|Invoice'));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                IGSTAmt := 0;
                IGSTper := 0;
                SGSTAmt := 0;
                SGSTper := 0;
                CGSTAmt := 0;
                CGSTper := 0;
                GSTBaseAmt := 0;
                TotalAmount := 0;

                //Updating Purchase register staging from Posted Purchase Invoice
                IF ("Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Invoice) THEN BEGIN
                    IF PurchInvHeader.GET("Vendor Ledger Entry"."Document No.") THEN BEGIN
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                        PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
                        IF PurchInvLine.FINDSET THEN BEGIN
                            REPEAT
                                //16225
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchInvLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchInvLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        IGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;


                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchInvLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchInvLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'SGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        SGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchInvLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchInvLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        CGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;


                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchInvLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchInvLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    repeat
                                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                    until RecDGLE.next = 0;
                                END;
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchInvLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchInvLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    repeat
                                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                    until RecDGLE.Next() = 0;

                                END;//16225 End
                                TotalAmount += PurchInvLine."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;//16225

                                EYAIM_PurcahseRegister.INIT;
                                EYAIM_PurcahseRegister.DocumentType := FORMAT("Vendor Ledger Entry"."Document Type");
                                EYAIM_PurcahseRegister.DocumentNumber := "Vendor Ledger Entry"."Document No.";
                                EYAIM_PurcahseRegister."Line No." := PurchInvLine."Line No.";
                                EYAIM_PurcahseRegister."vendor Ledger Entry No." := "Vendor Ledger Entry"."Entry No.";

                                EYAIM_PurcahseRegister."Item Code" := PurchInvLine."No.";
                                //EYAIM_PurcahseRegister.SupplyType :=
                                EYAIM_PurcahseRegister.DocumentDate := "Vendor Ledger Entry"."Posting Date";
                                EYAIM_PurcahseRegister.ReverseChargeFlag := FORMAT("Vendor Ledger Entry".Reversed);
                                EYAIM_PurcahseRegister.SupplierGSTIN := "Vendor Ledger Entry"."Buyer GST Reg. No.";
                                EYAIM_PurcahseRegister.CustomerGSTIN := "Vendor Ledger Entry"."Location GST Reg. No.";

                                IF Location.GET("Vendor Ledger Entry"."Location Code") THEN
                                    IF State.GET(Location."State Code") THEN;
                                EYAIM_PurcahseRegister.BillingPOS := State."State Code (GST Reg. No.)";
                                EYAIM_PurcahseRegister.HSN := PurchInvLine."HSN/SAC Code";

                                DetailedGSTLedgerEntry.RESET;
                                DetailedGSTLedgerEntry.SETRANGE("Document No.", PurchInvLine."Document No.");
                                DetailedGSTLedgerEntry.SETRANGE("Posting Date", "Vendor Ledger Entry"."Posting Date");
                                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", PurchInvLine."Line No.");
                                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                    EYAIM_PurcahseRegister.ItemAssessableAmount := DetailedGSTLedgerEntry."GST Base Amount";
                                EYAIM_PurcahseRegister.IGSTRate := DetailedGSTLedgerEntry."GST %";
                                EYAIM_PurcahseRegister.IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                EYAIM_PurcahseRegister.CGSTRate := DetailedGSTLedgerEntry."GST %";
                                EYAIM_PurcahseRegister.CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                EYAIM_PurcahseRegister.SGSTRate := DetailedGSTLedgerEntry."GST %";
                                EYAIM_PurcahseRegister.SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                EYAIM_PurcahseRegister.CessAdvaloremRate := 0;
                                EYAIM_PurcahseRegister.CessAdvaloremAmount := 0;
                                EYAIM_PurcahseRegister.CessSpecificRate := 0;
                                EYAIM_PurcahseRegister.CessSpecificAmount := 0;
                                EYAIM_PurcahseRegister.StateCessAdvaloremRate := 0;
                                EYAIM_PurcahseRegister.StateCessAdvaloremAmount := 0;
                                EYAIM_PurcahseRegister.StateCessSpecificRate := 0;
                                EYAIM_PurcahseRegister.StateCessSpecificAmount := 0;
                                //16225  EYAIM_PurcahseRegister.TotalItemAmount := PurchInvLine."Amount To Vendor";
                                EYAIM_PurcahseRegister.TotalItemAmount := TotalAmount;
                                //EYAIM_PurcahseRegister.InvoiceAssessableAmount :=
                                //EYAIM_PurcahseRegister.InvoiceIGSTAmount :=
                                //EYAIM_PurcahseRegister.InvoiceCGSTAmount :=
                                //EYAIM_PurcahseRegister.InvoiceSGSTAmount :=
                                //EYAIM_PurcahseRegister.InvoiceCessAdvaloremAmount :=
                                //EYAIM_PurcahseRegister.InvoiceCessSpecificAmount :=
                                EYAIM_PurcahseRegister.InvoiceValue := "Vendor Ledger Entry".Amount;
                                //EYAIM_PurcahseRegister.EligibilityIndicator :=
                                ///EYAIM_PurcahseRegister.AvailableIGST :=
                                //EYAIM_PurcahseRegister.AvailableCGST :=
                                //EYAIM_PurcahseRegister.AvailableSGST :=
                                //EYAIM_PurcahseRegister.AvailableCess :=
                                //EYAIM_PurcahseRegister.PortCode :=
                                EYAIM_PurcahseRegister.BillOfEntry := PurchInvHeader."Bill of Entry No.";
                                EYAIM_PurcahseRegister.BillOfEntryDate := PurchInvHeader."Bill of Entry Date";
                                //EYAIM_PurcahseRegister.ReturnPeriod :=
                                EYAIM_PurcahseRegister.DifferentialPercentageFlag := 'No';
                                EYAIM_PurcahseRegister.Section7OfIGSTFlag := 'No';
                                EYAIM_PurcahseRegister.ClaimRefundFlag := 'No';
                                EYAIM_PurcahseRegister.AutoPopulateToRefund := 'No';
                                EYAIM_PurcahseRegister.INSERT;
                                "Vendor Ledger Entry"."Updated in Staging" := TRUE;
                            //"Vendor Ledger Entry".MODIFY;
                            UNTIL PurchInvLine.NEXT = 0;
                        END;
                    END;
                END;

                //Updating Purchase register staging from Posted Purchase Credit Memo
                IF ("Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::"Credit Memo") THEN BEGIN
                    IF PurchCrMemoHdr.GET("Vendor Ledger Entry"."Document No.") THEN BEGIN
                        PurchCrMemoLine.RESET;
                        PurchCrMemoLine.SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                        PurchCrMemoLine.SETRANGE(Type, PurchCrMemoLine.Type::Item);
                        IF PurchCrMemoLine.FINDSET THEN BEGIN
                            REPEAT
                                //16225
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        IGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;


                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchCrMemoLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'SGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        SGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchCrMemoLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        CGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;


                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchCrMemoLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    repeat
                                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                    until RecDGLE.next = 0;
                                END;
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                                RecDGLE.SetRange("Document Line No.", PurchCrMemoLine."Line No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    repeat
                                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                    until RecDGLE.Next() = 0;

                                END;//16225 End
                                TotalAmount += PurchCrMemoLine."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;//16225

                                EYAIM_PurcahseRegister.INIT;
                                EYAIM_PurcahseRegister.DocumentType := FORMAT("Vendor Ledger Entry"."Document Type");
                                EYAIM_PurcahseRegister.DocumentNumber := "Vendor Ledger Entry"."Document No.";
                                EYAIM_PurcahseRegister."Line No." := PurchCrMemoLine."Line No.";
                                EYAIM_PurcahseRegister."vendor Ledger Entry No." := "Vendor Ledger Entry"."Entry No.";

                                EYAIM_PurcahseRegister."Item Code" := PurchCrMemoLine."No.";
                                //EYAIM_PurcahseRegister.SupplyType :=
                                EYAIM_PurcahseRegister.DocumentDate := "Vendor Ledger Entry"."Posting Date";
                                EYAIM_PurcahseRegister.ReverseChargeFlag := FORMAT("Vendor Ledger Entry".Reversed);
                                EYAIM_PurcahseRegister.SupplierGSTIN := "Vendor Ledger Entry"."Buyer GST Reg. No.";
                                EYAIM_PurcahseRegister.CustomerGSTIN := "Vendor Ledger Entry"."Location GST Reg. No.";

                                IF Location.GET("Vendor Ledger Entry"."Location Code") THEN
                                    IF State.GET(Location."State Code") THEN;
                                EYAIM_PurcahseRegister.BillingPOS := State."State Code (GST Reg. No.)";
                                EYAIM_PurcahseRegister.HSN := PurchCrMemoLine."HSN/SAC Code";

                                DetailedGSTLedgerEntry.RESET;
                                DetailedGSTLedgerEntry.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                                DetailedGSTLedgerEntry.SETRANGE("Posting Date", "Vendor Ledger Entry"."Posting Date");
                                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", PurchCrMemoLine."Line No.");
                                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                                    EYAIM_PurcahseRegister.ItemAssessableAmount := DetailedGSTLedgerEntry."GST Base Amount";

                                EYAIM_PurcahseRegister.IGSTRate := DetailedGSTLedgerEntry."GST %";
                                EYAIM_PurcahseRegister.IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                EYAIM_PurcahseRegister.CGSTRate := DetailedGSTLedgerEntry."GST %";
                                EYAIM_PurcahseRegister.CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                EYAIM_PurcahseRegister.SGSTRate := DetailedGSTLedgerEntry."GST %";
                                EYAIM_PurcahseRegister.SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                EYAIM_PurcahseRegister.CessAdvaloremRate := 0;
                                EYAIM_PurcahseRegister.CessAdvaloremAmount := 0;
                                EYAIM_PurcahseRegister.CessSpecificRate := 0;
                                EYAIM_PurcahseRegister.CessSpecificAmount := 0;
                                EYAIM_PurcahseRegister.StateCessAdvaloremRate := 0;
                                EYAIM_PurcahseRegister.StateCessAdvaloremAmount := 0;
                                EYAIM_PurcahseRegister.StateCessSpecificRate := 0;
                                EYAIM_PurcahseRegister.StateCessSpecificAmount := 0;
                                //16225   EYAIM_PurcahseRegister.TotalItemAmount := PurchCrMemoLine."Amount To Vendor";
                                EYAIM_PurcahseRegister.TotalItemAmount := TotalAmount;
                                //EYAIM_PurcahseRegister.InvoiceAssessableAmount :=
                                //EYAIM_PurcahseRegister.InvoiceIGSTAmount :=
                                //EYAIM_PurcahseRegister.InvoiceCGSTAmount :=
                                //EYAIM_PurcahseRegister.InvoiceSGSTAmount :=
                                //EYAIM_PurcahseRegister.InvoiceCessAdvaloremAmount :=
                                //EYAIM_PurcahseRegister.InvoiceCessSpecificAmount :=
                                EYAIM_PurcahseRegister.InvoiceValue := "Vendor Ledger Entry".Amount;
                                //EYAIM_PurcahseRegister.EligibilityIndicator :=
                                ///EYAIM_PurcahseRegister.AvailableIGST :=
                                //EYAIM_PurcahseRegister.AvailableCGST :=
                                //EYAIM_PurcahseRegister.AvailableSGST :=
                                //EYAIM_PurcahseRegister.AvailableCess :=
                                //EYAIM_PurcahseRegister.PortCode :=
                                EYAIM_PurcahseRegister.BillOfEntry := PurchCrMemoHdr."Bill of Entry No.";
                                EYAIM_PurcahseRegister.BillOfEntryDate := PurchCrMemoHdr."Bill of Entry Date";
                                //EYAIM_PurcahseRegister.ReturnPeriod :=
                                EYAIM_PurcahseRegister.DifferentialPercentageFlag := 'No';
                                EYAIM_PurcahseRegister.Section7OfIGSTFlag := 'No';
                                EYAIM_PurcahseRegister.ClaimRefundFlag := 'No';
                                EYAIM_PurcahseRegister.AutoPopulateToRefund := 'No';
                                EYAIM_PurcahseRegister.INSERT;
                                "Vendor Ledger Entry"."Updated in Staging" := TRUE;
                            //"Vendor Ledger Entry".MODIFY;
                            UNTIL PurchCrMemoLine.NEXT = 0;
                        END;
                    END;
                END;
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
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        EYAIM_PurcahseRegister: Record EYAIM_PurcahseRegister;
        State: Record State;
        Location: Record Location;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
        CalcAmttoVendor: Codeunit CalcAmttoVendor;



}

