report 50061 "Sales GST Data Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesGSTDataReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; 2000000026)
        {
            DataItemTableView = SORTING(Number);
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            dataitem("Sales Invoice Header"; 112)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Posting Date";
                column(UserID_SIH; "User ID")
                {
                }
                column(LocationCode_SIH; "Location Code")
                {
                }
                column(ReturnPeriod; FORMAT(Month1) + FORMAT(Year))
                {
                }
                column(SupplierGSTIN_SIH; RecLocation."GST Registration No.")
                {
                }
                column(SupplyType_SIH; SupplyType_SIH)
                {
                }
                column(No_SIH; "No.")
                {
                }
                column(PostingDate_SIH; "Posting Date")
                {
                }
                column(CustGSTIN_SIH; RecCustomer."GST Registration No.")
                {
                }
                column(CustName_SIH; RecCustomer.Name)
                {
                }
                column(CustCode_SIH; "Sell-to Customer No.")
                {
                }
                column(BillToStateSIH; BillToStateSIH)
                {
                }
                column(ShipToStateSIH; ShipToStateSIH)
                {
                }
                column(BillToStateCodeSIH; BillToStateCodeSIH)
                {
                }
                column(AckNo_SIH; "Acknowledgement No.")
                {
                }
                column(AckDt_SIH; AcknDt_SIH)
                {
                }
                column(EWayBillNo_SIH; "E-Way Bill No.")
                {
                }
                column(EWayBillDate_SIH; Ewaydt_SIH)
                {
                }
                column(AmountToCustomer_SIH; GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.")) // 16630 AmountToCustomer_SIH; "Amount to Customer"
                {
                }
                dataitem("Sales Invoice Line"; 113)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    column(PlantCode_SIL; "Plant Code")
                    {
                    }
                    column(SrNo_SIL; SrNo_SIL)
                    {
                    }
                    column(HSNCode_SIL; "HSN/SAC Code")
                    {
                    }
                    column(ItemCode_SIL; "No.")
                    {
                    }
                    column(ItemDescription_SIL; Description)
                    {
                    }
                    column(ProductGroupCode_SIL; "Sales Invoice Line"."Group Code") // 16630 replace Product Group Code
                    {
                    }
                    column(UOM_SIL; UOM_SIL)
                    {
                    }
                    column(Quantity_SIL; "Quantity in Sq. Mt.")
                    {
                    }
                    column(Qty_SIL; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(GSTBaseAmount_SIL; GetGSTBaseAmtPostedLine("Document No.", "Line No.")) // 16630 GST Base Amount
                    {
                    }
                    column(TaxBaseAmount_SIL; 0) // 16630 blank Tax Base Amount
                    {
                    }
                    column(IGSTRate_SIL; IGSTRate_SIL)
                    {
                    }
                    column(IGSTAmt_SIL; IGSTAmt_SIL)
                    {
                    }
                    column(CGSTRate_SIL; CGSTRate_SIL)
                    {
                    }
                    column(CGSTAmt_SIL; CGSTAmt_SIL)
                    {
                    }
                    column(SGSTRate_SIL; SGSTRate_SIL)
                    {
                    }
                    column(SGSTAmt_SIL; SGSTAmt_SIL)
                    {
                    }
                    column(AmountToCustomer_SIL; GetAmttoCustomerPostedLine("Document No.", "Line No.")) // 16630 AmountToCustomer_SIL; "Amount To Customer"
                    {
                    }
                    column(TCSAmount_SIL; GetTCSAmount("Document No.")) // 16630  TDS/TCS Amount
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF "Sales Invoice Line".Quantity + "Sales Invoice Line"."Quantity in Sq. Mt." = 0 THEN
                            CurrReport.SKIP;

                        SrNo_SIL += 1;

                        CLEAR(UOM_SIL);
                        IF "Unit of Measure Code" = 'CRT' THEN
                            UOM_SIL := 'SQM'
                        ELSE
                            IF "Unit of Measure Code" = 'PCS.' THEN
                                UOM_SIL := 'SQM'
                            ELSE
                                UOM_SIL := "Unit of Measure Code";

                        CLEAR(CGSTRate_SIL);
                        CLEAR(CGSTAmt_SIL);
                        CLEAR(SGSTRate_SIL);
                        CLEAR(SGSTAmt_SIL);
                        CLEAR(IGSTRate_SIL);
                        CLEAR(IGSTAmt_SIL);

                        RecGST.RESET;
                        RecGST.SETRANGE("Entry Type", RecGST."Entry Type"::"Initial Entry");
                        RecGST.SETRANGE("Document No.", "Document No.");
                        RecGST.SETRANGE("No.", "No.");
                        RecGST.SETRANGE("Document Line No.", "Line No.");
                        RecGST.SETRANGE("Transaction Type", RecGST."Transaction Type"::Sales);
                        //RecGST.SETRANGE("Item Charge Entry",FALSE);
                        IF RecGST.FINDFIRST THEN
                            REPEAT
                                IF RecGST."GST Component Code" = 'CGST' THEN BEGIN
                                    CGSTAmt_SIL := ABS(RecGST."GST Amount");
                                    CGSTRate_SIL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTAmt_SIL := ABS(RecGST."GST Amount");
                                    SGSTRate_SIL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt_SIL := ABS(RecGST."GST Amount");
                                    IGSTRate_SIL := RecGST."GST %";
                                END;
                            UNTIL RecGST.NEXT = 0;
                        IGSTAmt := 0;
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
                        TotalAmount += LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;

                    end;
                }

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
                    TotalAmtSIH := 0;




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
                    TotalAmtSIH += LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;

                    IF RecCustomer.GET("Sell-to Customer No.") THEN;

                    IF RecLocation.GET("Location Code") THEN;

                    CLEAR(AcknDt_SIH);
                    /* 16630 IF "Acknowledgement Date" <> '' THEN
                         AcknDt_SIH := COPYSTR("Acknowledgement Date", 9, 2) + '-' + COPYSTR("Acknowledgement Date", 6, 2)
                                            + '-' + COPYSTR("Acknowledgement Date", 1, 4)
                     ELSE
                         AcknDt_SIH := '';*/ // 16630

                    CLEAR(Ewaydt_SIH);
                    IF "Sales Invoice Header"."E-Way Bill Date" <> '' THEN
                        Ewaydt_SIH := COPYSTR("E-Way Bill Date", 9, 2) + '-' + COPYSTR("E-Way Bill Date", 6, 2)
                                          + '-' + COPYSTR("E-Way Bill Date", 1, 4)
                    ELSE
                        Ewaydt_SIH := '';
                    /*//070222
                    CLEAR(SupplyType_SIH);
                    IF ("Customer Posting Group" = 'DOMESTIC') THEN
                      SupplyType_SIH := 'TAX'
                    */
                    //070222RK>>>
                    IF ("Customer Posting Group" = 'DOMESTIC') AND ("GST Customer Type" <> "GST Customer Type"::"SEZ Unit") THEN
                        SupplyType_SIH := 'TAX'
                    ELSE
                        IF ("Customer Posting Group" = 'DOMESTIC') AND ("GST Customer Type" = "GST Customer Type"::"SEZ Unit") THEN
                            SupplyType_SIH := 'EXPWT'
                        //070222<<<
                        ELSE
                            IF "Customer Posting Group" = 'EXIM' THEN
                                SupplyType_SIH := 'EXPWT'
                            ELSE
                                IF "Customer Posting Group" = 'N&B' THEN
                                    SupplyType_SIH := 'EXPWT';

                    CLEAR(BillToStateCodeSIH);
                    CLEAR(BillToStateSIH);
                    CLEAR(ShipToStateSIH);
                    CLEAR(SupplierGSTIN_SIH);

                    RecCustomer.RESET;
                    IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
                        SupplierGSTIN_SIH := RecCustomer."GST Registration No.";
                        RecState.RESET;
                        IF RecState.GET(RecCustomer."State Code") THEN BEGIN
                            BillToStateSIH := RecState.Description;
                            IF BillToStateSIH = 'Nepal' THEN
                                BillToStateCodeSIH := '97'
                            ELSE
                                BillToStateCodeSIH := RecState."State Code (GST Reg. No.)";
                        END;
                    END;

                    RecLocation.RESET;
                    IF RecLocation.GET("Ship-to Code") THEN BEGIN
                        RecState.RESET;
                        RecState.SETRANGE(Code, RecLocation."State Code");
                        IF RecState.FINDFIRST THEN
                            ShipToStateSIH := RecState.Description;
                    END;

                end;
            }
            dataitem("Sales Cr.Memo Header"; 114)
            {
                DataItemTableView = SORTING("Posting Date");
                column(UserID_SCrH; "User ID")
                {
                }
                column(LocationCode_SCrH; "Location Code")
                {
                }
                column(SupplierGSTIN_SCrH; RecLocation."GST Registration No.")
                {
                }
                column(SupplyType_SCrH; SupplyType_SCrH)
                {
                }
                column(No_SCrH; "No.")
                {
                }
                column(PostingDate_SCrH; "Posting Date")
                {
                }
                column(CustGSTIN_SCrH; RecCustomer."GST Registration No.")
                {
                }
                column(CustName_SCrH; RecCustomer.Name)
                {
                }
                column(CustCode_SCrH; "Sell-to Customer No.")
                {
                }
                column(BillToStateSCrH; BillToStateSCrH)
                {
                }
                column(ShipToStateSCrH; ShipToStateSCrH)
                {
                }
                column(BillToStateCodeSCrH; BillToStateCodeSCrH)
                {
                }
                column(AckNo_SCrH; "Acknowledgement No.")
                {
                }
                column(AckDt_SCrH; AcknDt_SCrH)
                {
                }
                column(EWayBillNo_SCrH; "E-Way Bill No.")
                {
                }
                column(ReturnPeriodSCrH; FORMAT(Month1) + FORMAT(Year))
                {
                }
                column(OriginalDoc_SCrH; "Applies-to Doc. No.")
                {
                }
                column(OriginalDocdt_SCrH; OriginalDocdt_SCrH)
                {
                }
                column(AmountToCustomer_SCrH; GetAmttoCustomerPostedLine("Sales Cr.Memo Line"."Document No.", "Sales Cr.Memo Line"."Line No.")) // 16630 AmountToCustomer_SCrH; "Amount to Customer"
                {
                }
                dataitem("Sales Cr.Memo Line"; 115)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "No.")
                                        WHERE("Sell-to Customer No." = FILTER(<> ''),
                                              Type = FILTER('Item|G/L Account'),
                                              Quantity = FILTER(> 0));
                    column(SrNo_SCrL; SrNo_SCrL)
                    {
                    }
                    column(HSNCode_SCrL; "HSN/SAC Code")
                    {
                    }
                    column(ItemCode_SCrL; "No.")
                    {
                    }
                    column(ItemDescription_SCrL; Description)
                    {
                    }
                    column(ProductGroupCode_SCrL; "Discount Amt 1") // 16630 replace Product Group Code
                    {
                    }
                    column(UOM_SCrL; UOM_SCrL)
                    {
                    }
                    column(Quantity_SCrL; "Quantity in Sq. Mt.")
                    {
                    }
                    column(Qty_SCrL; Quantity)
                    {
                    }
                    column(GSTBaseAmount_SCrL; GetGSTBaseAmtPostedLine("Document No.", "Line No.")) // 16630 GST Base Amount
                    {
                    }
                    column(IGSTRate_SCrL; IGSTRate_SCrL)
                    {
                    }
                    column(IGSTAmt_SCrL; IGSTAmt_SCrL)
                    {
                    }
                    column(CGSTRate_SCrL; CGSTRate_SCrL)
                    {
                    }
                    column(CGSTAmt_SCrL; CGSTAmt_SCrL)
                    {
                    }
                    column(SGSTRate_SCrL; SGSTRate_SCrL)
                    {
                    }
                    column(SGSTAmt_SCrL; SGSTAmt_SCrL)
                    {
                    }
                    column(TotalAmtSCML; GetAmttoCustomerPostedLine("Sales Cr.Memo Line"."Document No.", "Sales Cr.Memo Line"."Line No.")) // 16630 AmountToCustomer_SCrL; "Amount To Customer"
                    {
                    }
                    column(TCSAmount_SCrL; GetTCSAmount("Document No.")) // 16630 TDS/TCS Amount
                    {
                    }

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
                        TotalAmtSCML := 0;




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
                        TotalAmtSCML += LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;

                        IF "Sales Cr.Memo Line".Quantity + "Sales Cr.Memo Line"."Quantity in Sq. Mt." = 0 THEN
                            CurrReport.SKIP;

                        SrNo_SCrL += 1;

                        CLEAR(UOM_SCrL);
                        IF "Unit of Measure Code" = 'CRT' THEN
                            UOM_SCrL := 'SQM'
                        ELSE
                            IF "Unit of Measure Code" = 'PCS.' THEN
                                UOM_SCrL := 'SQM'
                            ELSE
                                UOM_SCrL := "Unit of Measure Code";

                        CLEAR(CGSTRate_SCrL);
                        CLEAR(CGSTAmt_SCrL);
                        CLEAR(SGSTRate_SCrL);
                        CLEAR(SGSTAmt_SCrL);
                        CLEAR(IGSTRate_SCrL);
                        CLEAR(IGSTAmt_SCrL);

                        RecGST.RESET;
                        RecGST.SETRANGE("Entry Type", RecGST."Entry Type"::"Initial Entry");
                        RecGST.SETRANGE("Document No.", "Document No.");
                        RecGST.SETRANGE("No.", "No.");
                        RecGST.SETRANGE("Document Line No.", "Line No.");
                        RecGST.SETRANGE("Transaction Type", RecGST."Transaction Type"::Sales);
                        RecGST.SETRANGE("Item Charge Entry", FALSE);
                        IF RecGST.FINDFIRST THEN
                            REPEAT
                                IF RecGST."GST Component Code" = 'CGST' THEN BEGIN
                                    CGSTAmt_SCrL := ABS(RecGST."GST Amount");
                                    CGSTRate_SCrL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTAmt_SCrL := ABS(RecGST."GST Amount");
                                    SGSTRate_SCrL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt_SCrL := ABS(RecGST."GST Amount");
                                    IGSTRate_SCrL := RecGST."GST %";
                                END;
                            UNTIL RecGST.NEXT = 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IGSTAmt := 0;
                    IGSTper := 0;
                    SGSTAmt := 0;
                    SGSTper := 0;
                    CGSTAmt := 0;
                    CGSTper := 0;
                    GSTBaseAmt := 0;
                    TotalAmtSCMH := 0;




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
                    TotalAmtSCMH += LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;

                    IF RecCustomer.GET("Sell-to Customer No.") THEN;

                    IF RecLocation.GET("Location Code") THEN;

                    CLEAR(AcknDt_SCrH);
                    /* 16630 IF "Acknowledgement Date" <> '' THEN
                        AcknDt_SCrH := COPYSTR("Acknowledgement Date", 9, 2) + '-' + COPYSTR("Acknowledgement Date", 6, 2)
                                          + '-' + COPYSTR("Acknowledgement Date", 1, 4)
                    ELSE
                        AcknDt_SCrH := '';*/ // 16630 


                    CLEAR(OriginalDocdt_SCrH);
                    IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN BEGIN
                        IF "Applies-to Doc. No." <> '' THEN BEGIN
                            RecSIH.RESET;
                            RecSIH.SETRANGE("No.", "Applies-to Doc. No.");
                            IF RecSIH.FINDFIRST THEN
                                OriginalDocdt_SCrH := RecSIH."Posting Date"
                            ELSE
                                OriginalDocdt_SCrH := 0D;
                        END;
                    END;


                    CLEAR(SupplyType_SCrH);
                    IF "Customer Posting Group" = 'DOMESTIC' THEN
                        SupplyType_SCrH := 'TAX'
                    ELSE
                        IF "Customer Posting Group" = 'EXIM' THEN
                            SupplyType_SCrH := 'EXPWT'
                        ELSE
                            IF "Customer Posting Group" = 'N&B' THEN
                                SupplyType_SCrH := 'EXPWT';

                    CLEAR(BillToStateCodeSCrH);
                    CLEAR(BillToStateSCrH);
                    CLEAR(ShipToStateSCrH);
                    CLEAR(SupplierGSTIN_SCrH);

                    RecCustomer.RESET;
                    IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
                        SupplierGSTIN_SCrH := RecCustomer."GST Registration No.";
                        RecState.RESET;
                        IF RecState.GET(RecCustomer."State Code") THEN BEGIN
                            BillToStateSCrH := RecState.Description;
                            IF BillToStateSCrH = 'Nepal' THEN
                                BillToStateCodeSCrH := '97'
                            ELSE
                                BillToStateCodeSCrH := RecState."State Code (GST Reg. No.)"
                        END;
                    END;

                    RecLocation.RESET;
                    IF RecLocation.GET("Ship-to Code") THEN BEGIN
                        RecState.RESET;
                        RecState.SETRANGE(Code, RecLocation."State Code");
                        IF RecState.FINDFIRST THEN
                            ShipToStateSCrH := RecState.Description;
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    SETFILTER("Posting Date", "Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date"));
                end;
            }
            dataitem("Transfer Shipment Header"; 5744)
            {
                DataItemTableView = SORTING("No.");
                column(LocationCode_TrH; "Transfer-from Code")
                {
                }
                column(SupplierGSTIN_TrH; RLocation."GST Registration No.")
                {
                }
                column(SupplyType_TrH; SupplyType_TrH)
                {
                }
                column(No_TrH; "No.")
                {
                }
                column(PostingDate_TrH; "Posting Date")
                {
                }
                column(CustGSTIN_TrH; RLocation2."GST Registration No.")
                {
                }
                column(CustName_TrH; CustName_TrH)
                {
                }
                column(BillToState_TrH; BillToStateTrH)
                {
                }
                column(ShipToState_TrH; ShipToStateTrH)
                {
                }
                column(BillToStateCode_TrH; COPYSTR(RLocation2."GST Registration No.", 1, 2))
                {
                }
                column(AckNo_TrH; "Acknowledgement No.")
                {
                }
                column(AckDt_TrH; AcknDt_SCrH)
                {
                }
                column(EWayBillNo_TrH; "E-Way Bill No.")
                {
                }
                column(ReturnPeriod_TrH; FORMAT(Month1) + FORMAT(Year))
                {
                }
                column(OriginalDocdt_TrH; OriginalDocdt_TrH)
                {
                }
                column(UserID_TrH; '"User ID"')
                {
                }
                column(CustCode_TrH; '"Sell-to Customer No."')
                {
                }
                column(OriginalDoc_TrH; '"Applies-to Doc. No."')
                {
                }
                dataitem("Transfer Shipment Line"; 5745)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    column(SrNo_TrL; SrNo_TrL)
                    {
                    }
                    column(HSNCode_TrL; "HSN/SAC Code")
                    {
                    }
                    column(ItemCode_TrL; "Item No.")
                    {
                    }
                    column(ItemDescription_TrL; Description)
                    {
                    }
                    column(ProductGroupCode_TrL; "Group Code") // 16630 replace Product Group Code
                    {
                    }
                    column(UOM_TrL; UOM_TrL)
                    {
                    }
                    column(Quantity_TrL; "Qty in Sq. Mt.")
                    {
                    }
                    column(Qty_TrL; Quantity)
                    {
                    }
                    column(GSTBaseAmount_TrL; GetGSTBaseAmtPostedLine("Document No.", "Line No.")) // 16630 GST Base Amount
                    {
                    }
                    column(IGSTRate_TrL; IGSTRate_TrL)
                    {
                    }
                    column(IGSTAmt_TrL; IGSTAmt_TrL)
                    {
                    }
                    column(CGSTRate_TrL; CGSTRate_TrL)
                    {
                    }
                    column(CGSTAmt_TrL; CGSTAmt_TrL)
                    {
                    }
                    column(SGSTRate_TrL; SGSTRate_TrL)
                    {
                    }
                    column(SGSTAmt_TrL; SGSTAmt_TrL)
                    {
                    }
                    column(AmountToCustomer_TrL; "Short Quantity") // 16630 replace Total Amount to Transfer
                    {
                    }
                    column(ExternalTransfer; "External Transfer")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF ("Transfer Shipment Line".Quantity + "Transfer Shipment Line"."Qty in Sq. Mt." = 0) OR ("Transfer Shipment Line"."External Transfer" = FALSE) THEN
                            CurrReport.SKIP;

                        SrNo_TrL += 1;

                        CLEAR(UOM_TrL);
                        IF "Unit of Measure Code" = 'CRT' THEN
                            UOM_TrL := 'SQM'
                        ELSE
                            IF "Unit of Measure Code" = 'PCS.' THEN
                                UOM_TrL := 'SQM'
                            ELSE
                                UOM_TrL := "Unit of Measure Code";

                        CLEAR(CGSTRate_TrL);
                        CLEAR(CGSTAmt_TrL);
                        CLEAR(SGSTRate_TrL);
                        CLEAR(SGSTAmt_TrL);
                        CLEAR(IGSTRate_TrL);
                        CLEAR(IGSTAmt_TrL);

                        RecGST.RESET;
                        RecGST.SETRANGE("Entry Type", RecGST."Entry Type"::"Initial Entry");
                        RecGST.SETRANGE("Document No.", "Document No.");
                        //RecGST.SETRANGE("No.","No.");
                        RecGST.SETRANGE("No.", "Item No.");
                        RecGST.SETRANGE("Document Line No.", "Line No.");
                        RecGST.SETRANGE("Transaction Type", RecGST."Transaction Type"::Sales);
                        RecGST.SETRANGE("Item Charge Entry", FALSE);
                        IF RecGST.FINDFIRST THEN
                            REPEAT
                                IF RecGST."GST Component Code" = 'CGST' THEN BEGIN
                                    CGSTAmt_TrL := ABS(RecGST."GST Amount");
                                    CGSTRate_TrL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTAmt_TrL := ABS(RecGST."GST Amount");
                                    SGSTRate_TrL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt_TrL := ABS(RecGST."GST Amount");
                                    IGSTRate_TrL := RecGST."GST %";
                                END;
                            UNTIL RecGST.NEXT = 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    RecTrL.RESET;
                    RecTrL.SETFILTER("External Transfer",'%1',TRUE);
                    RecTrL.SETRANGE("Document No.","Transfer Shipment Header"."No.");
                    IF NOT RecTrL.FINDSET THEN
                      CurrReport.SKIP;
                      */
                    CLEAR(BillToStateCodeTrH);
                    //IF RecCustomer.GET("Sell-to Customer No.") THEN;
                    RLocation2.RESET;
                    IF RLocation2.GET("Transfer-to Code") THEN
                        //BillToStateCodeTrH:=COPYSTR(RecCustomer."GST Registration No.",1,2);

                        //IF RecLocation.GET("Location Code") THEN;
                        RLocation.RESET;
                    IF RLocation.GET("Transfer-from Code") THEN;

                    CLEAR(AcknDt_TrH);
                    IF "Acknowledgement Date" <> '' THEN
                        AcknDt_TrH := COPYSTR("Acknowledgement Date", 9, 2) + '-' + COPYSTR("Acknowledgement Date", 6, 2)
                                          + '-' + COPYSTR("Acknowledgement Date", 1, 4)
                    ELSE
                        AcknDt_TrH := '';


                    CLEAR(OriginalDocdt_TrH);
                    /*
                    IF "Applies-to Doc. Type"  ="Applies-to Doc. Type"::Invoice THEN BEGIN
                      IF "Applies-to Doc. No."<>'' THEN BEGIN
                        RecSIH.RESET;
                        RecSIH.SETRANGE("No.","Applies-to Doc. No.");
                        IF RecSIH.FINDFIRST THEN
                          OriginalDocdt_TrH := RecSIH."Posting Date"
                        ELSE
                          OriginalDocdt_TrH := 0D;
                      END;
                    END;
                    */
                    /*
                    CLEAR(SupplyType_TrH);
                    IF "Customer Posting Group" = 'DOMESTIC' THEN
                      SupplyType_TrH := 'TAX'
                    ELSE IF "Customer Posting Group" = 'EXIM' THEN
                      SupplyType_TrH := 'EXPWT'
                    ELSE IF "Customer Posting Group" = 'N&B' THEN
                      SupplyType_TrH := 'EXPWT';
                      */
                    //CLEAR(BillToStateCodeTrH);
                    CLEAR(BillToStateTrH);
                    CLEAR(ShipToStateTrH);
                    CLEAR(SupplierGSTIN_TrH);

                    RecLocation1.RESET;
                    //IF RecLocation.GET("Ship-to Code") THEN BEGIN
                    IF RecLocation1.GET("Transfer-to Code") THEN BEGIN
                        //BillToStateCodeTrH := RecLocation1."State Code";
                        CustName_TrH := RecLocation1.Name;
                        RecState.RESET;
                        RecState.SETRANGE(Code, RecLocation1."State Code");
                        IF RecState.FINDFIRST THEN
                            ShipToStateTrH := RecState.Description;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", "Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date"));
                end;
            }

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, 1);
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
        CompInfo.GET();
    end;

    trigger OnPreReport()
    begin
        FromDate := "Sales Invoice Header".GETRANGEMIN("Posting Date");
        ToDate := "Sales Invoice Header".GETRANGEMAX("Posting Date");

        Month := DATE2DMY(FromDate, 2);
        Year := DATE2DMY(FromDate, 3);

        IF Month = 1 THEN
            Month1 := '01'
        ELSE
            IF Month = 2 THEN
                Month1 := '02'
            ELSE
                IF Month = 3 THEN
                    Month1 := '03'
                ELSE
                    IF Month = 4 THEN
                        Month1 := '04'
                    ELSE
                        IF Month = 5 THEN
                            Month1 := '05'
                        ELSE
                            IF Month = 6 THEN
                                Month1 := '06'
                            ELSE
                                IF Month = 7 THEN
                                    Month1 := '07'
                                ELSE
                                    IF Month = 8 THEN
                                        Month1 := '08'
                                    ELSE
                                        IF Month = 9 THEN
                                            Month1 := '09'
                                        ELSE
                                            IF Month = 10 THEN
                                                Month1 := '10'
                                            ELSE
                                                IF Month = 11 THEN
                                                    Month1 := '11'
                                                ELSE
                                                    IF Month = 12 THEN
                                                        Month1 := '12';
    end;

    var
        RecLocation: Record Location;
        RecLocation1: Record Location;
        RecState: Record State;
        CompInfo: Record "Company Information";
        RecCustomer: Record Customer;
        RecGST: Record "Detailed GST Ledger Entry";
        Month: Integer;
        Month1: Text;
        Year: Integer;
        FromDate: Date;
        ToDate: Date;
        SrNo_SIL: Integer;
        BillToStateCodeSIH: Code[4];
        BillToStateSIH: Text[100];
        SupplierGSTIN_SIH: Code[15];
        ShipToStateSIH: Text[100];
        CGSTRate_SIL: Decimal;
        SGSTRate_SIL: Decimal;
        IGSTRate_SIL: Decimal;
        CGSTAmt_SIL: Decimal;
        SGSTAmt_SIL: Decimal;
        IGSTAmt_SIL: Decimal;
        AcknDt_SIH: Text;
        Ewaydt_SIH: Text;
        SupplyType_SIH: Text;
        RecSIH: Record "Sales Invoice Header";
        UOM_SIL: Code[10];
        State_SIH: Code[10];
        SrNo_SCrL: Integer;
        BillToStateCodeSCrH: Code[4];
        BillToStateSCrH: Text[100];
        SupplierGSTIN_SCrH: Code[15];
        ShipToStateSCrH: Text[100];
        CGSTRate_SCrL: Decimal;
        SGSTRate_SCrL: Decimal;
        IGSTRate_SCrL: Decimal;
        CGSTAmt_SCrL: Decimal;
        SGSTAmt_SCrL: Decimal;
        IGSTAmt_SCrL: Decimal;
        AcknDt_SCrH: Text;
        OriginalDocdt_SCrH: Date;
        SupplyType_SCrH: Text;
        UOM_SCrL: Code[10];
        State_SCrH: Code[10];
        RecTrL: Record "Transfer Shipment Line";
        CustName_TrH: Text[100];
        SrNo_TrL: Integer;
        BillToStateCodeTrH: Code[4];
        BillToStateTrH: Text[100];
        SupplierGSTIN_TrH: Code[15];
        ShipToStateTrH: Text[100];
        CGSTRate_TrL: Decimal;
        SGSTRate_TrL: Decimal;
        IGSTRate_TrL: Decimal;
        CGSTAmt_TrL: Decimal;
        SGSTAmt_TrL: Decimal;
        IGSTAmt_TrL: Decimal;
        AcknDt_TrH: Text;
        OriginalDocdt_TrH: Date;
        SupplyType_TrH: Text;
        UOM_TrL: Code[10];
        State_TrH: Code[10];
        RLocation: Record Location;
        RLocation2: Record Location;
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        LineAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
        TotalAmtSCMH: Decimal;
        TotalAmtSCML: Decimal;
        TotalAmtSIH: Decimal;

    procedure GetTCSAmount(DocNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Invoice Line";
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: record "TCS Setup";
        TCSAmount: Decimal;
    begin
        Clear(TCSAmount);

        TCSSetup.Get();
        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TCSAmount += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;
        TCSAmount := Round(TCSAmount, 1);
    end;

    procedure GetAmttoCustomerPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
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

    procedure GetGSTBaseAmtPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record "Sales Invoice Line";
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        GSTBaseAmt: Decimal;
    begin
        Clear(GSTBaseAmt);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            GSTBaseAmt := Abs(DetGstLedEntry."GST Base Amount");


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            IF DetGstLedEntry.FINDFIRST THEN
                GSTBaseAmt := Abs(DetGstLedEntry."GST Base Amount");

        EXIT(GSTBaseAmt);
    end;



}

