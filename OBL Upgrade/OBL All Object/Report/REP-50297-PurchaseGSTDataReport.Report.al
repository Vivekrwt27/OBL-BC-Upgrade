report 50297 "Purchase GST Data Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\PurchaseGSTDataReport.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemTableView = SORTING("No.")
                                    WHERE("GST Vendor Type" = FILTER(Registered));
                RequestFilterFields = "Posting Date";
                column(UserID_PIH; "User ID")
                {
                }
                column(LocationCode_PIH; "Location Code")
                {
                }
                column(ReturnPeriod; FORMAT(Month1) + FORMAT(Year))
                {
                }
                column(SupplierGSTIN_PIH; RecLocation."GST Registration No.")
                {
                }
                column(SupplyType_PIH; SupplyType_PIH)
                {
                }
                column(No_PIH; "No.")
                {
                }
                column(PostingDate_PIH; "Posting Date")
                {
                }
                column(VendGSTIN_PIH; RecVendor."GST Registration No.")
                {
                }
                column(VendName_PIH; RecVendor.Name)
                {
                }
                column(VendCode_PIH; "Buy-from Vendor No.")
                {
                }
                column(BillToStatePIH; BillToStatePIH)
                {
                }
                column(ShipToStatePIH; ShipToStatePIH)
                {
                }
                column(BillToStateCodePIH; BillToStateCodePIH)
                {
                }
                column(AckNo_PIH; '"Acknowledgement No."')
                {
                }
                column(AckDt_PIH; 'AcknDt_PIH')
                {
                }
                column(EWayBillNo_PIH; "E-Way Bill No.")
                {
                }
                column(EWayBillDate_PIH; Ewaydt_PIH)
                {
                }
                column(VendorInvoiceNo_PIH; "Vendor Invoice No.")
                {
                }
                column(VendorInvoiceDate_PIH; "Vendor Invoice Date")
                {
                }
                column(VendorOrderNo_PIH; "Vendor Order No.")
                {
                }
                dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE("Buy-from Vendor No." = FILTER(<> ''),
                                              "Type" = FILTER(Item | "G/L Account" | "Charge (Item)"),
                                              "Quantity" = FILTER(> 0));
                    //16225  "Total GST Amount" = FILTER(> 0));
                    column(PlantCode_PIL; '"Plant Code"')
                    {
                    }
                    column(SrNo_PIL; SrNo_PIL)
                    {
                    }
                    column(HSNCode_PIL; "HSN/SAC Code")
                    {
                    }
                    column(ItemCode_PIL; "No.")
                    {
                    }
                    column(ItemDescription_PIL; Description)
                    {
                    }
                    column(ItemDescription2_PIL; "Description 2")
                    {
                    }
                    //16225 column(ProductGroupCode_PIL; "Product Group Code")
                    column(ProductGroupCode_PIL; '"Product Group Code"')
                    {
                    }
                    column(UOM_PIL; UOM_PIL)
                    {
                    }
                    column(Quantity_PIL; '"Quantity in Sq. Mt."')
                    {
                    }
                    column(Qty_PIL; Quantity)
                    {
                    }
                    //16225 column(TaxBaseAmount_PIL; "GST Base Amount")
                    column(TaxBaseAmount_PIL; "Amount")
                    {
                    }
                    column(IGSTRate_PIL; IGSTRate_PIL)
                    {
                    }
                    column(IGSTAmt_PIL; IGSTAmt_PIL)
                    {
                    }
                    column(CGSTRate_PIL; CGSTRate_PIL)
                    {
                    }
                    column(CGSTAmt_PIL; CGSTAmt_PIL)
                    {
                    }
                    column(SGSTRate_PIL; SGSTRate_PIL)
                    {
                    }
                    column(SGSTAmt_PIL; SGSTAmt_PIL)
                    {
                    }
                    // column(AmountToVendor_PIL; "Amount To Vendor")
                    column(AmountToVendor_PIL; "Amount")
                    {
                    }
                    column(TCSAmount_PIL; '"TDS/TCS Amount"')
                    {
                    }
                    column(ItemCodePIL; ItemCodePIL)
                    {
                    }
                    column(EligibilityIndicatorPIL; EligibilityIndicatorPIL)
                    {
                    }
                    column(DivisionPIH; DivisionPIH)
                    {
                    }
                    column(SubDivision_PIL; "GST Credit")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Description = 'System Rounding Off' THEN
                            CurrReport.SKIP;

                        SrNo_PIL += 1;

                        CLEAR(UOM_PIL);
                        IF ("Unit of Measure Code" = 'CRT') OR ("Unit of Measure Code" = 'PCS.') THEN
                            UOM_PIL := 'SQM'
                        ELSE
                            UOM_PIL := "Unit of Measure Code";

                        CLEAR(EligibilityIndicatorPIL);
                        CLEAR(ItemCodePIL);
                        IF "GST Group Type" = "GST Group Type"::Service THEN BEGIN
                            ItemCodePIL := 'S';
                            EligibilityIndicatorPIL := 'IS';
                        END ELSE
                            IF "GST Group Type" = "GST Group Type"::Goods THEN BEGIN
                                ItemCodePIL := 'G';
                                EligibilityIndicatorPIL := 'IG';
                            END;

                        CLEAR(DivisionPIH);
                        IF "Purch. Inv. Line"."GST Credit" = "Purch. Inv. Line"."GST Credit"::Availment THEN BEGIN
                            IF ("Purch. Inv. Line"."Location Code" = 'ISD-CHD') OR ("Purch. Inv. Line"."Location Code" = 'ISD-DELHI') THEN
                                DivisionPIH := '4. Eligible_ITC_A_ ITC Avail_Inward supplies from ISD'
                            ELSE
                                DivisionPIH := '4. Eligible ITC - (A) ITC Available_other';
                        END ELSE
                            IF "Purch. Inv. Line"."GST Credit" = "Purch. Inv. Line"."GST Credit"::"Non-Availment" THEN BEGIN
                                IF ("Purch. Inv. Line"."Location Code" = 'ISD-CHD') OR ("Purch. Inv. Line"."Location Code" = 'ISD-DELHI') THEN
                                    DivisionPIH := '4. Eligible ITC - (D) Ineligible ITC_Other'
                                ELSE
                                    DivisionPIH := '4. Eligible ITC - (D) Ineligible ITC_As per rules';
                            END;

                        CLEAR(CGSTRate_PIL);
                        CLEAR(CGSTAmt_PIL);
                        CLEAR(SGSTRate_PIL);
                        CLEAR(SGSTAmt_PIL);
                        CLEAR(IGSTRate_PIL);
                        CLEAR(IGSTAmt_PIL);

                        RecGST.RESET;
                        RecGST.SETCURRENTKEY("Document No.", "Document Line No.");
                        RecGST.SETRANGE("Entry Type", RecGST."Entry Type"::"Initial Entry");
                        RecGST.SETRANGE("Document No.", "Document No.");
                        RecGST.SETRANGE("No.", "No.");
                        RecGST.SETRANGE("Document Line No.", "Line No.");
                        RecGST.SETRANGE("Transaction Type", RecGST."Transaction Type"::Purchase);
                        //RecGST.SETRANGE("Item Charge Entry",FALSE);
                        IF RecGST.FINDFIRST THEN
                            REPEAT
                                IF RecGST."GST Component Code" = 'CGST' THEN BEGIN
                                    CGSTAmt_PIL := ABS(RecGST."GST Amount");
                                    CGSTRate_PIL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTAmt_PIL := ABS(RecGST."GST Amount");
                                    SGSTRate_PIL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt_PIL := ABS(RecGST."GST Amount");
                                    IGSTRate_PIL := RecGST."GST %";
                                END;
                            UNTIL RecGST.NEXT = 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecVendor.GET("Buy-from Vendor No.") THEN;

                    IF RecLocation.GET("Location Code") THEN;
                    /*
                    CLEAR(AcknDt_SIH);
                    IF "Acknowledgement Date"<>'' THEN
                      AcknDt_SIH := COPYSTR("Acknowledgement Date",9,2)+'-'+COPYSTR("Acknowledgement Date",6,2)
                                         +'-'+COPYSTR("Acknowledgement Date",1,4)
                    ELSE
                      AcknDt_SIH := '';
                    
                    CLEAR(Ewaydt_SIH);
                    IF "E-Way Bill Date"<>'' THEN
                      Ewaydt_SIH := COPYSTR("E-Way Bill Date",9,2)+'-'+COPYSTR("E-Way Bill Date",6,2)
                                        +'-'+COPYSTR("E-Way Bill Date",1,4)
                    ELSE
                      Ewaydt_SIH := '';
                      */
                    CLEAR(SupplyType_PIH);
                    IF ("Vendor Posting Group" = 'DOMESTIC') OR ("Vendor Posting Group" = 'EXIM') OR ("Vendor Posting Group" = 'N&B') THEN
                        SupplyType_PIH := 'TAX'
                    ELSE
                        SupplyType_PIH := '';

                    CLEAR(BillToStateCodePIH);
                    CLEAR(BillToStatePIH);
                    CLEAR(ShipToStatePIH);
                    CLEAR(SupplierGSTIN_PIH);

                    RecVendor.RESET;
                    IF RecVendor.GET("Buy-from Vendor No.") THEN BEGIN
                        SupplierGSTIN_PIH := RecVendor."GST Registration No.";
                        RecState.RESET;
                        IF RecState.GET(RecVendor."State Code") THEN BEGIN
                            BillToStatePIH := RecState.Description;
                            IF BillToStatePIH = 'Nepal' THEN
                                BillToStateCodePIH := '97'
                            ELSE
                                BillToStateCodePIH := RecState."State Code (GST Reg. No.)";
                        END;
                    END;

                    RecLocation.RESET;
                    IF RecLocation.GET("Ship-to Code") THEN BEGIN
                        RecState.RESET;
                        RecState.SETRANGE(Code, RecLocation."State Code");
                        IF RecState.FINDFIRST THEN
                            ShipToStatePIH := RecState.Description;
                    END;

                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemTableView = SORTING("No.")
                                    WHERE("GST Vendor Type" = FILTER(Registered));
                column(UserID_PCrH; "User ID")
                {
                }
                column(LocationCode_PCrH; "Location Code")
                {
                }
                column(SupplierGSTIN_PCrH; RecLocation."GST Registration No.")
                {
                }
                column(SupplyType_PCrH; SupplyType_PCrH)
                {
                }
                column(No_PCrH; "No.")
                {
                }
                column(PostingDate_PCrH; "Posting Date")
                {
                }
                column(VendGSTIN_PCrH; RecVendor."GST Registration No.")
                {
                }
                column(VendName_PCrH; RecVendor.Name)
                {
                }
                column(VendCode_PCrH; "Buy-from Vendor No.")
                {
                }
                column(BillToStatePCrH; BillToStatePCrH)
                {
                }
                column(ShipToStatePCrH; ShipToStatePCrH)
                {
                }
                column(BillToStateCodePCrH; BillToStateCodePCrH)
                {
                }
                column(AckNo_PCrH; '"Acknowledgement No."')
                {
                }
                column(AckDt_PCrH; AcknDt_PCrH)
                {
                }
                column(EWayBillNo_PCrH; "E-Way Bill No.")
                {
                }
                column(ReturnPeriodPCrH; FORMAT(Month1) + FORMAT(Year))
                {
                }
                column(OriginalDoc_PCrH; "Applies-to Doc. No.")
                {
                }
                column(OriginalDocdt_PCrH; OriginalDocdt_PCrH)
                {
                }
                column(VendorInvoiceNo_PCrH; "Vendor Invoice No.")
                {
                }
                column(VendorInvoiceDate_PCrH; "Vendor Invoice Date")
                {
                }
                column(LastSrNo_PIL; LastSrNo_PIL)
                {
                }
                dataitem("<Purch. Cr. Memo Line>"; "Purch. Cr. Memo Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE("Buy-from Vendor No." = FILTER(<> ''),
                                              Type = FILTER(Item | "G/L Account" | "Charge (Item)"),
                                              Quantity = FILTER(> 0));
                    // 16225 "Total GST Amount"=FILTER(>0));
                    column(SrNo_PCrL; SrNo_PCrL)
                    {
                    }
                    column(HSNCode_PCrL; "HSN/SAC Code")
                    {
                    }
                    column(ItemCode_PCrL; "No.")
                    {
                    }
                    column(ItemDescription_PCrL; Description)
                    {
                    }
                    column(ItemDescription2_PCrL; "Description 2")
                    {
                    }
                    //16225 column(ProductGroupCode_PCrL;"Product Group Code")
                    column(ProductGroupCode_PCrL; '"Product Group Code"')
                    {
                    }
                    column(UOM_PCrL; UOM_PCrL)
                    {
                    }
                    column(Quantity_PCrL; '"Quantity in Sq. Mt."')
                    {
                    }
                    column(Qty_PCrL; Quantity)
                    {
                    }
                    //16225  column(TaxBaseAmount_PCrL;"GST Base Amount")
                    column(TaxBaseAmount_PCrL; '"GST Base Amount"')
                    {
                    }
                    column(IGSTRate_PCrL; IGSTRate_PCrL)
                    {
                    }
                    column(IGSTAmt_PCrL; IGSTAmt_PCrL)
                    {
                    }
                    column(CGSTRate_PCrL; CGSTRate_PCrL)
                    {
                    }
                    column(CGSTAmt_PCrL; CGSTAmt_PCrL)
                    {
                    }
                    column(SGSTRate_PCrL; SGSTRate_PCrL)
                    {
                    }
                    column(SGSTAmt_PCrL; SGSTAmt_PCrL)
                    {
                    }
                    //16225 column(AmountToVendor_PCrL;"Amount To Vendor")
                    column(AmountToVendor_PCrL; "Amount")
                    {
                    }
                    column(TCSAmount_PCrL; '"TDS/TCS Amount"')
                    {
                    }
                    column(ItemCodePCrL; ItemCodePCrL)
                    {
                    }
                    column(EligibilityIndicatorPCrL; EligibilityIndicatorPCrL)
                    {
                    }
                    column(DivisionPCrH; DivisionPCrH)
                    {
                    }
                    column(SubDivision_PCrL; "GST Credit")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Description = 'System Rounding Off' THEN
                            CurrReport.SKIP;

                        SrNo_PCrL += 1;

                        CLEAR(UOM_PCrL);
                        IF ("Unit of Measure Code" = 'CRT') OR ("Unit of Measure Code" = 'PCS.') THEN
                            UOM_PCrL := 'SQM'
                        ELSE
                            UOM_PCrL := "Unit of Measure Code";

                        CLEAR(EligibilityIndicatorPCrL);
                        CLEAR(ItemCodePCrL);
                        IF "GST Group Type" = "GST Group Type"::Service THEN BEGIN
                            ItemCodePCrL := 'S';
                            EligibilityIndicatorPCrL := 'IS';
                        END ELSE
                            IF "GST Group Type" = "GST Group Type"::Goods THEN BEGIN
                                ItemCodePCrL := 'G';
                                EligibilityIndicatorPCrL := 'IG';
                            END;

                        CLEAR(DivisionPCrH);
                        IF "GST Credit" = "GST Credit"::Availment THEN BEGIN
                            IF ("Location Code" = 'ISD-CHD') OR ("Location Code" = 'ISD-DELHI') THEN
                                DivisionPCrH := '4. Eligible_ITC_A_ ITC Avail_Inward supplies from ISD'
                            ELSE
                                DivisionPCrH := '4. Eligible ITC - (A) ITC Available_other';
                        END ELSE
                            IF "GST Credit" = "GST Credit"::"Non-Availment" THEN BEGIN
                                IF ("Location Code" = 'ISD-CHD') OR ("Location Code" = 'ISD-DELHI') THEN
                                    DivisionPCrH := '4. Eligible ITC - (D) Ineligible ITC_Other'
                                ELSE
                                    DivisionPCrH := '4. Eligible ITC - (D) Ineligible ITC_As per rules';
                            END;

                        CLEAR(CGSTRate_PCrL);
                        CLEAR(CGSTAmt_PCrL);
                        CLEAR(SGSTRate_PCrL);
                        CLEAR(SGSTAmt_PCrL);
                        CLEAR(IGSTRate_PCrL);
                        CLEAR(IGSTAmt_PCrL);

                        RecGST.RESET;
                        RecGST.SETCURRENTKEY("Document No.", "Document Line No.");
                        RecGST.SETRANGE("Entry Type", RecGST."Entry Type"::"Initial Entry");
                        RecGST.SETRANGE("Document No.", "Document No.");
                        RecGST.SETRANGE("No.", "No.");
                        RecGST.SETRANGE("Document Line No.", "Line No.");
                        RecGST.SETRANGE("Transaction Type", RecGST."Transaction Type"::Purchase);
                        RecGST.SETRANGE("Item Charge Entry", FALSE);
                        IF RecGST.FINDFIRST THEN
                            REPEAT
                                IF RecGST."GST Component Code" = 'CGST' THEN BEGIN
                                    CGSTAmt_PCrL := ABS(RecGST."GST Amount");
                                    CGSTRate_PCrL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTAmt_PCrL := ABS(RecGST."GST Amount");
                                    SGSTRate_PCrL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt_PCrL := ABS(RecGST."GST Amount");
                                    IGSTRate_PCrL := RecGST."GST %";
                                END;
                            UNTIL RecGST.NEXT = 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        LastSrNo_PIL := SrNo_PIL;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecVendor.GET("Buy-from Vendor No.") THEN;

                    IF RecLocation.GET("Location Code") THEN;
                    /*
                    CLEAR(AcknDt_SCrH);
                    IF "Acknowledgement Date"<>'' THEN
                      AcknDt_SCrH := COPYSTR("Acknowledgement Date",9,2)+'-'+COPYSTR("Acknowledgement Date",6,2)
                                        +'-'+COPYSTR("Acknowledgement Date",1,4)
                    ELSE
                      AcknDt_SCrH := '';
                    
                    */
                    CLEAR(OriginalDocdt_PCrH);
                    IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN BEGIN
                        IF "Applies-to Doc. No." <> '' THEN BEGIN
                            RecPIH.RESET;
                            RecPIH.SETRANGE("No.", "Applies-to Doc. No.");
                            IF RecPIH.FINDFIRST THEN
                                OriginalDocdt_PCrH := RecPIH."Posting Date"
                            ELSE
                                OriginalDocdt_PCrH := 0D;
                        END;
                    END;


                    CLEAR(SupplyType_PCrH);
                    IF ("Vendor Posting Group" = 'DOMESTIC') OR ("Vendor Posting Group" = 'EXIM') OR ("Vendor Posting Group" = 'N&B') THEN
                        SupplyType_PCrH := 'TAX'
                    ELSE
                        SupplyType_PCrH := '';

                    CLEAR(BillToStateCodePCrH);
                    CLEAR(BillToStatePCrH);
                    CLEAR(ShipToStatePCrH);
                    CLEAR(SupplierGSTIN_PCrH);

                    RecVendor.RESET;
                    IF RecVendor.GET("Buy-from Vendor No.") THEN BEGIN
                        SupplierGSTIN_PCrH := RecVendor."GST Registration No.";
                        RecState.RESET;
                        IF RecState.GET(RecVendor."State Code") THEN BEGIN
                            BillToStatePCrH := RecState.Description;
                            IF BillToStatePCrH = 'Nepal' THEN
                                BillToStateCodePCrH := '97'
                            ELSE
                                BillToStateCodePCrH := RecState."State Code (GST Reg. No.)"
                        END;
                    END;

                    RecLocation.RESET;
                    IF RecLocation.GET("Ship-to Code") THEN BEGIN
                        RecState.RESET;
                        RecState.SETRANGE(Code, RecLocation."State Code");
                        IF RecState.FINDFIRST THEN
                            ShipToStatePCrH := RecState.Description;
                    END;

                end;

                trigger OnPreDataItem()
                begin

                    SETFILTER("Posting Date", "Purch. Inv. Header".GETFILTER("Purch. Inv. Header"."Posting Date"));
                end;
            }
            dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
            {
                DataItemTableView = SORTING("No.");
                column(LocationFromCode_TSH; "Transfer-from Code")
                {
                }
                column(LocationToCode_TSH; "Transfer-to Code")
                {
                }
                column(SupplierGSTIN_TSH; RecLocation1."GST Registration No.")
                {
                }
                column(ReceipentGSTIN_TSH; RecLocation."GST Registration No.")
                {
                }
                column(VendName_TSH; "Transfer-from Name")
                {
                }
                column(VendCode_TSH; "Transfer-to Code")
                {
                }
                column(BillToStateTSH; BillToStateTSH)
                {
                }
                column(ShipToStateTSH; ShipToStateTSH)
                {
                }
                column(BillToStateCodeTSH; BillToStateCodeTSH)
                {
                }
                column(AckNo_TSH; '"Acknowledgement No."')
                {
                }
                column(AckDt_TSH; AcknDt_TSH)
                {
                }
                column(EWayBillNo_TSH; "E-way Bill No.")
                {
                }
                column(ReturnPeriodTSH; FORMAT(Month1) + FORMAT(Year))
                {
                }
                column(OriginalDoc_TSH; "Transfer Order No.")
                {
                }
                column(OriginalDocdt_TSH; "Transfer Order Date")
                {
                }
                column(No_TSH; "No.")
                {
                }
                column(PostingDate_TSH; "Posting Date")
                {
                }
                column(VendorInvoiceNo_TSH; "Trf Shipment Inv No.")
                {
                }
                column(VendorInvDt_TSH; VendorInvDt_TSH)
                {
                }
                column(LastSrNo_PIL1; LastSrNo_PIL1)
                {
                }
                column(LastSrNo_PCrL; LastSrNo_PCrL)
                {
                }
                dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE("Transfer-from Code" = FILTER(<> ''),
                                              Quantity = FILTER(> 0));
                    //16225  "Total GST Amount"=FILTER(>0));
                    column(SrNo_TSL; SrNo_TSL)
                    {
                    }
                    column(HSNCode_TSL; "HSN/SAC Code")
                    {
                    }
                    column(ItemCode_TSL; "Item No.")
                    {
                    }
                    column(LineNo_TSL; "Line No.")
                    {
                    }
                    column(ItemDescription_TSL; Description)
                    {
                    }
                    column(ProductGroupCode_TSL; "Description 2")
                    {
                    }
                    column(UOM_TSL; UOM_TSL)
                    {
                    }
                    column(Quantity_TSL; '"Quantity in Sq. Mt."')
                    {
                    }
                    column(Qty_TSL; Quantity)
                    {
                    }
                    //16225  column(TaxBaseAmount_TSL;"GST Base Amount")
                    column(TaxBaseAmount_TSL; "Transfer Receipt Line".Amount)
                    {
                    }
                    column(IGSTRate_TSL; IGSTRate_TSL)
                    {
                    }
                    column(IGSTAmt_TSL; IGSTAmt_TSL)
                    {
                    }
                    column(CGSTRate_TSL; CGSTRate_TSL)
                    {
                    }
                    column(CGSTAmt_TSL; CGSTAmt_TSL)
                    {
                    }
                    column(SGSTRate_TSL; SGSTRate_TSL)
                    {
                    }
                    column(SGSTAmt_TSL; SGSTAmt_TSL)
                    {
                    }
                    //16225  column(AmountToVendor_TSL;"Total Amount to Transfer")
                    column(AmountToVendor_TSL; "Transfer Receipt Line".Amount)
                    {
                    }
                    column(TCSAmount_TSL; '"TDS/TCS Amount"')
                    {
                    }
                    column(ItemCodeTSL; ItemCodeTSL)
                    {
                    }
                    column(DivisionTSH; DivisionTSH)
                    {
                    }
                    column(SubDivision_TSL; "GST Credit")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Description = 'System Rounding Off' THEN
                            CurrReport.SKIP;

                        SrNo_TSL += 1;

                        CLEAR(UOM_TSL);
                        IF ("Unit of Measure Code" = 'CRT') OR ("Unit of Measure Code" = 'PCS.') THEN
                            UOM_TSL := 'SQM'
                        ELSE
                            UOM_TSL := "Unit of Measure Code";
                        /*
                        CLEAR(EligibilityIndicatorTSL);
                        CLEAR(ItemCodeTSL);
                        IF "GST Group Type" = "GST Group Type"::Service THEN BEGIN
                          ItemCodePCrL := 'S';
                          EligibilityIndicatorPCrL := 'IS';
                        END ELSE IF "GST Group Type" = "GST Group Type"::Goods THEN BEGIN
                          ItemCodePCrL := 'G';
                          EligibilityIndicatorPCrL := 'IG';
                        END;
                        */
                        CLEAR(DivisionTSH);
                        IF "GST Credit" = "GST Credit"::Availment THEN BEGIN
                            IF ("Transfer-to Code" = 'ISD-CHD') OR ("Transfer-to Code" = 'ISD-DELHI') THEN
                                DivisionTSH := '4. Eligible_ITC_A_ ITC Avail_Inward supplies from ISD'
                            ELSE
                                DivisionTSH := '4. Eligible ITC - (A) ITC Available_other';
                        END ELSE
                            IF "GST Credit" = "GST Credit"::"Non-Availment" THEN BEGIN
                                IF ("Transfer-to Code" = 'ISD-CHD') OR ("Transfer-to Code" = 'ISD-DELHI') THEN
                                    DivisionTSH := '4. Eligible ITC - (D) Ineligible ITC_Other'
                                ELSE
                                    DivisionTSH := '4. Eligible ITC - (D) Ineligible ITC_As per rules';
                            END;

                        CLEAR(CGSTRate_TSL);
                        CLEAR(CGSTAmt_TSL);
                        CLEAR(SGSTRate_TSL);
                        CLEAR(SGSTAmt_TSL);
                        CLEAR(IGSTRate_TSL);
                        CLEAR(IGSTAmt_TSL);

                        RecGST.RESET;
                        RecGST.SETCURRENTKEY("Document No.", "Document Line No.");
                        RecGST.SETRANGE("Entry Type", RecGST."Entry Type"::"Initial Entry");
                        RecGST.SETRANGE("Document No.", "Document No.");
                        RecGST.SETRANGE("No.", "Item No.");
                        RecGST.SETRANGE("Document Line No.", "Line No.");
                        RecGST.SETRANGE("Transaction Type", RecGST."Transaction Type"::Purchase);
                        RecGST.SETRANGE("Item Charge Entry", FALSE);
                        IF RecGST.FINDFIRST THEN
                            REPEAT
                                IF RecGST."GST Component Code" = 'CGST' THEN BEGIN
                                    CGSTAmt_TSL := ABS(RecGST."GST Amount");
                                    CGSTRate_TSL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTAmt_TSL := ABS(RecGST."GST Amount");
                                    SGSTRate_TSL := RecGST."GST %";
                                END;
                                IF RecGST."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt_TSL := ABS(RecGST."GST Amount");
                                    IGSTRate_TSL := RecGST."GST %";
                                END;
                            UNTIL RecGST.NEXT = 0;

                    end;

                    trigger OnPreDataItem()
                    begin
                        LastSrNo_PCrL := SrNo_PCrL;
                        LastSrNo_PIL1 := SrNo_PIL;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF RecLocation1.GET("Transfer-from Code") THEN;

                    IF RecLocation.GET("Transfer-to Code") THEN;

                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETFILTER("No.", '%1', "Transfer Receipt Header"."Trf Shipment Inv No.");
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        VendorInvDt_TSH := TransferShipmentHeader."Posting Date";
                    END;

                    /*
                    CLEAR(AcknDt_SCrH);
                    IF "Acknowledgement Date"<>'' THEN
                      AcknDt_SCrH := COPYSTR("Acknowledgement Date",9,2)+'-'+COPYSTR("Acknowledgement Date",6,2)
                                        +'-'+COPYSTR("Acknowledgement Date",1,4)
                    ELSE
                      AcknDt_SCrH := '';
                    
                    */


                    CLEAR(BillToStateCodeTSH);
                    RecLocation.RESET;
                    IF RecLocation.GET("Transfer-from Code") THEN BEGIN
                        RecState.RESET;
                        IF RecState.GET(RecLocation."State Code") THEN BEGIN
                            BillToStateCodeTSH := RecState."State Code (GST Reg. No.)";
                        END;
                    END;

                    /*
                    RecLocation.RESET;
                    IF RecLocation.GET("Ship-to Code") THEN BEGIN
                      RecState.RESET;
                      RecState.SETRANGE(Code,RecLocation."State Code");
                      IF RecState.FINDFIRST THEN
                        ShipToStatePCrH := RecState.Description;
                    END;
                    
                    */

                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", "Purch. Inv. Header".GETFILTER("Purch. Inv. Header"."Posting Date"));
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
        FromDate := "Purch. Inv. Header".GETRANGEMIN("Posting Date");
        ToDate := "Purch. Inv. Header".GETRANGEMAX("Posting Date");

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
        RecVendor: Record Vendor;
        RecGST: Record "Detailed GST Ledger Entry";
        Month: Integer;
        Month1: Text;
        Year: Integer;
        FromDate: Date;
        ToDate: Date;
        SrNo_PIL: Integer;
        LastSrNo_PIL: Integer;
        LastSrNo_PIL1: Integer;
        BillToStateCodePIH: Code[4];
        BillToStatePIH: Text[100];
        SupplierGSTIN_PIH: Code[15];
        ShipToStatePIH: Text[100];
        CGSTRate_PIL: Decimal;
        SGSTRate_PIL: Decimal;
        IGSTRate_PIL: Decimal;
        CGSTAmt_PIL: Decimal;
        SGSTAmt_PIL: Decimal;
        IGSTAmt_PIL: Decimal;
        AcknDt_PIL: Text;
        Ewaydt_PIH: Text;
        SupplyType_PIH: Text;
        RecPIH: Record "Purch. Inv. Header";
        UOM_PIL: Code[10];
        State_PIH: Code[10];
        DivisionPIH: Code[80];
        ItemCodePIL: Code[2];
        EligibilityIndicatorPIL: Code[2];
        SrNo_PCrL: Integer;
        LastSrNo_PCrL: Integer;
        BillToStateCodePCrH: Code[4];
        BillToStatePCrH: Text[100];
        SupplierGSTIN_PCrH: Code[15];
        ShipToStatePCrH: Text[100];
        CGSTRate_PCrL: Decimal;
        SGSTRate_PCrL: Decimal;
        IGSTRate_PCrL: Decimal;
        CGSTAmt_PCrL: Decimal;
        SGSTAmt_PCrL: Decimal;
        IGSTAmt_PCrL: Decimal;
        AcknDt_PCrH: Text;
        OriginalDocdt_PCrH: Date;
        SupplyType_PCrH: Text;
        UOM_PCrL: Code[10];
        State_PCrH: Code[10];
        DivisionPCrH: Code[80];
        ItemCodePCrL: Code[5];
        EligibilityIndicatorPCrL: Code[2];
        SrNo_TSL: Integer;
        BillToStateCodeTSH: Code[4];
        BillToStateTSH: Text[100];
        SupplierGSTIN_TSH: Code[15];
        ShipToStateTSH: Text[100];
        CGSTRate_TSL: Decimal;
        SGSTRate_TSL: Decimal;
        IGSTRate_TSL: Decimal;
        CGSTAmt_TSL: Decimal;
        SGSTAmt_TSL: Decimal;
        IGSTAmt_TSL: Decimal;
        AcknDt_TSH: Text;
        OriginalDocdt_TSH: Date;
        SupplyType_TSH: Text;
        UOM_TSL: Code[10];
        State_TSH: Code[10];
        DivisionTSH: Code[80];
        ItemCodeTSL: Code[5];
        EligibilityIndicatorTSL: Code[2];
        TransferShipmentHeader: Record "Transfer Shipment Header";
        VendorInvDt_TSH: Date;
}

