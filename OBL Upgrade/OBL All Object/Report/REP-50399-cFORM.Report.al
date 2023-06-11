report 50399 "c-FORM"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Group Code")//16225"Form Code"
                                WHERE("Group Code" = FILTER('<>05'));//16225 ("Form Code" = CONST("FORM C"),


            trigger OnAfterGetRecord()
            var
            /*            IGSTAmt: Decimal;
                       IGSTper: Decimal;
                       SGSTAmt: Decimal;
                       SGSTper: Decimal;
                       CGSTAmt: Decimal;
                       CGSTper: Decimal;
                       GSTBaseAmt: Decimal;
                       TotalAmount: Decimal;
                       RecDGLE: Record "Detailed GST Ledger Entry";

             */
            begin
                /* IGSTAmt := 0;
                IGSTper := 0;
                SGSTAmt := 0;
                SGSTper := 0;
                CGSTAmt := 0;
                CGSTper := 0;
                GSTBaseAmt := 0;
                TotalAmount := 0;
                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    REPEAT
                        IGSTAmt += abs(RecDGLE."GST Amount");
                    UNTIL RecDGLE.NEXT = 0;
                END;


                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'SGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    REPEAT
                        SGSTAmt += abs(RecDGLE."GST Amount");
                    UNTIL RecDGLE.NEXT = 0;
                END;
                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    REPEAT
                        CGSTAmt += abs(RecDGLE."GST Amount");
                    UNTIL RecDGLE.NEXT = 0;
                END;


                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    repeat
                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                    until RecDGLE.next = 0;
                END;
                RecDGLE.RESET();
                RecDGLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                IF RecDGLE.FINDFIRST THEN BEGIN
                    repeat
                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                    until RecDGLE.Next() = 0;

                END;
16630 */

                Window.OPEN('#1#######################');
                Window.UPDATE(1, "No.");
                CALCFIELDS("Tax Base");
                CALCFIELDS("Invoice Discount Amount");

                IF (NOT Cform.GET("No.")) THEN BEGIN
                    Window.UPDATE(1, "No.");
                    Cform."No." := "No.";
                    Cform."Customer No." := "Sell-to Customer No.";
                    Cform."Location Code" := "Location Code";
                    Cform."Branch Code" := "Shortcut Dimension 1 Code";
                    Cform."Customer Type" := "Customer Type";
                    Cform."ORC Dealer Code" := "Dealer Code";
                    Cform."Sell To Customer Name" := "Sell-to Customer Name";
                    Cform."Post Code" := "Sell-to Post Code";
                    CALCFIELDS("State name");
                    Cform."State Desc." := "State name";
                    Cform."Tin No." := "Tin No.";
                    Cform."Posting Date" := "Posting Date";
                    Cform."Salesperson Code" := "Salesperson Code";
                    //16225  CALCFIELDS("Amount to Customer");
                    //16225 Cform."Invoice Amount" := "Amount to Customer";
                    Cform."Invoice Amount" := GetAmttoCustomerPostedLine(SIL."Document No.", SIL."Line No.");// 16630

                    CALCFIELDS("Tax Base");
                    CALCFIELDS("Invoice Discount Amount");

                    IF (COPYSTR(Cform."No.", 1, 4) = 'SIGJ') OR (COPYSTR(Cform."No.", 1, 4) = 'HIGJ') THEN BEGIN
                        CALCFIELDS("Invoice Discount Amount");
                        Cform."Tax Base Amount" := "Tax Base" - ABS("Invoice Discount Amount");
                        //Cform."Tax Base Amount" := "Tax Base"+"Invoice Discount Amount";
                        Cform."Full Tax Liability" := (Cform."Tax Base Amount" / 1.02 * 12 / 100);
                    END ELSE
                        Cform."Tax Base Amount" := "Tax Base";

                    CALCFIELDS("Sales Tax Amount");
                    Cform."Cst Amount" := "Sales Tax Amount";
                    Cform."Tax Code" := "Tax Area Code";

                    tAXpERCENTAGE := 0;
                    tAL.RESET;
                    tAL.SETRANGE("Tax Area", "Tax Area Code");
                    IF tAL.FINDFIRST THEN BEGIN
                        REPEAT
                            tAL.CALCFIELDS("Tax %");
                            tAXpERCENTAGE += tAL."Tax %";
                        UNTIL tAL.NEXT = 0;
                    END;
                    Cform."Tax %" := tAXpERCENTAGE;
                    //16225 Table N/F Start
                    /*  Periods.RESET;
                      Periods.SETFILTER("Starting Date", '>=%1', "Posting Date");
                      IF Periods.FINDFIRST THEN
                          Cform.Period := FORMAT(Periods.Quarter);*///16225 Table N/F End

                    IF CUSTOMER.GET(Cform."Customer No.") THEN
                        Cform."PCH Code" := CUSTOMER."PCH Code";
                    Cform."Current Sales Invoice" := TRUE;
                    Cform.INSERT;
                END;

                IF Cform.GET("No.") THEN BEGIN
                    //Window.UPDATE(1,"No.");
                    //  CALCFIELDS("Sales Tax Amount");
                    //  Cform."Cst Amount" := "Sales Tax Amount";
                    //  Cform."Tax Code" := "Tax Area Code";
                    //  Cform."Tax Base Amount" := "Tax Base";

                    IF (COPYSTR(Cform."No.", 1, 4) = 'SIGJ') OR (COPYSTR(Cform."No.", 1, 4) = 'HIGJ') THEN BEGIN
                        CALCFIELDS("Invoice Discount Amount");
                        Cform."Tax Base Amount" := "Tax Base" - ABS("Invoice Discount Amount");
                        Cform."Full Tax Liability" := (Cform."Tax Base Amount" / 1.02 * 12 / 100)
                    END ELSE
                        Cform."Full Tax Liability" := (Cform."Tax Base Amount" * Cform."Tax %" / 100);
                    Cform."Differential Tax Liability" := (Cform."Full Tax Liability" - Cform."Cst Amount");
                    Cform."No of Days" := TODAY - "Posting Date";
                    Cform.Interest := ((Cform."Differential Tax Liability" * 24 / 100) / 365 * Cform."No of Days");
                    Cform."Total Tax Liability" := (Cform."Differential Tax Liability" + Cform.Interest);

                    IF Cform."C Form No." <> '' THEN BEGIN
                        Cform."C-Form Recd Amt" := Cform."Tax Base Amount";
                        Cform."Followup Status" := 'Received';
                        Cform."Differential Tax Liability" := 0;
                        Cform.Interest := 0;
                        Cform."Total Tax Liability" := 0;
                    END ELSE BEGIN
                        Cform."C-Form Recd Amt" := 0;
                        Cform."Followup Status" := 'Pending';
                        Cform."Differential Tax Liability" := (Cform."Full Tax Liability" - Cform."Cst Amount");
                        Cform.Interest := ((Cform."Differential Tax Liability" * 24 / 100) / 365 * Cform."No of Days");
                        Cform."Total Tax Liability" := (Cform."Differential Tax Liability" + Cform.Interest);
                        Cform."C Form Recd Date" := 0D;
                    END;

                    Cform."C-Form Pending Amt" := Cform."Tax Base Amount" - Cform."C-Form Recd Amt";
                    Cform."Current Sales Invoice" := TRUE;
                    Cform.MODIFY;
                END;

                //FOR INVOICES NOT EXISTS IN SALES INVOICE HEADER
                /*
                   Cform.SETCURRENTKEY("No.");
                    IF Cform.FINDFIRST THEN BEGIN
                       IF Cform."No." <> "No." THEN BEGIN
                       Window.UPDATE(1,"No.");
                           REPEAT
                             IF (COPYSTR(Cform."No.",1,4) = 'SIGJ') OR (COPYSTR(Cform."No.",1,4) = 'HIGJ') THEN
                                IF Cform."Posting Date" <010413D THEN
                                   Cform."Full Tax Liability" := (Cform."Tax Base Amount"*Cform."Tax %"/100)
                                  ELSE
                                   Cform."Full Tax Liability" := (Cform."Tax Base Amount"/1.02*12/100)
                              ELSE
                                Cform."Full Tax Liability" := (Cform."Tax Base Amount"*Cform."Tax %"/100);
                                Cform."Differential Tax Liability" := (Cform."Full Tax Liability"-Cform."Cst Amount");
                                Cform."No of Days" := TODAY-Cform."Posting Date";
                                Cform.Interest := ((Cform."Differential Tax Liability"*24/100)/365*Cform."No of Days");
                                Cform."Total Tax Liability" := (Cform."Differential Tax Liability"+Cform.Interest);

                                  IF  Cform."C Form No." <> '' THEN BEGIN
                                      Cform."C-Form Recd Amt" := Cform."Tax Base Amount";
                                      Cform."Followup Status" := 'Received';
                                      Cform."Differential Tax Liability" := 0;
                                      Cform.Interest := 0;
                                      Cform."Total Tax Liability" := 0;
                                   END ELSE BEGIN
                                      Cform."C-Form Recd Amt" := 0;
                                      Cform."Followup Status" := 'Pending';
                                      Cform."Differential Tax Liability" := (Cform."Full Tax Liability"-Cform."Cst Amount");
                                      Cform.Interest := ((Cform."Differential Tax Liability"*24/100)/365*Cform."No of Days");
                                      Cform."Total Tax Liability" := (Cform."Differential Tax Liability"+Cform.Interest);
                                      Cform."C Form Recd Date" := 0D;
                                    END;
                                      Cform."C-Form Pending Amt" := Cform."Tax Base Amount"-Cform."C-Form Recd Amt";
                                      Cform.MODIFY;
                           UNTIL Cform.NEXT=0;
                        END;
                    END;
               */
                Window.CLOSE;

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
        sih: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";
        Cform: Record "C-form";
        cUST: Text[30];
        State1: Record State;
        STATE: Text[50];
        nod: Integer;
        tAL: Record "Tax Area Line";
        tAXpERCENTAGE: Decimal;
        //16225 Periods: Record "16501;
        CUSTOMER: Record Customer;
        Window: Dialog;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Intmonth: Integer;

    local procedure GetAmttoCustomerPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdSalesInv: Record 113;
        PstdSalesCrMemoLine: Record 115;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        LineAmt: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(LineAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
            //GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            SGSTAmt := abs(DetGstLedEntry."GST Amount");

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
            // GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;

        if PstdSalesCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdSalesCrMemoLine.Type <> PstdSalesCrMemoLine.Type::" " then
                LineAmt := PstdSalesCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdSalesCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdSalesInv.Get(DocumentNo, DocLineNo) then begin
            if PstdSalesInv.Type <> PstdSalesInv.Type::" " then
                LineAmt := PstdSalesInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdSalesInv.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        Clear(TotalAmt);
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt) - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;

}

