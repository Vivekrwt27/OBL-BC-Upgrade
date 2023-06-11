report 50311 "GSTR-1 Report"
{
    // --MSVRN--
    // GSTR-1 220917
    // 
    // --MSVRN--
    // GSTR-1 161117 >> Modified

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Detailed GST Ledger Entry"; "Detailed GST Ledger Entry")
        {
            DataItemTableView = SORTING("Transaction Type", "Document Type", "Document No.", "Document Line No.")
                                ORDER(Ascending)
                                WHERE("Entry Type" = FILTER("Initial Entry"),
                                      "Transaction Type" = FILTER("Sales" | "Purchase"));
            RequestFilterFields = "Posting Date", "Document No.";

            trigger OnAfterGetRecord()
            begin
                //--GSTR1--

                IF (Docno <> "Detailed GST Ledger Entry"."Document No.") OR (DocLnNo <> "Detailed GST Ledger Entry"."Document Line No.") THEN BEGIN

                    /*
                    IF ("Reverse Charge" = TRUE) AND ("Transaction Type" = "Transaction Type"::Purchase) THEN BEGIN
                      GSTRDataNewFormat("Detailed GST Ledger Entry");
                    END ELSE IF "Transaction Type" = "Transaction Type"::Sales THEN
                      GSTRDataNewFormat("Detailed GST Ledger Entry")
                    END ELSE IF "Transaction Type" = "Transaction Type"::Sales THEN
                      GSTRDataNewFormat("Detailed GST Ledger Entry")
                    ELSE
                      CurrReport.SKIP;
                     */

                    IF ("Transaction Type" = "Transaction Type"::Purchase) AND ("GST Vendor Type" = "GST Vendor Type"::Registered) THEN
                        CurrReport.SKIP;

                    GSTRDataNewFormat("Detailed GST Ledger Entry");
                    Docno := "Detailed GST Ledger Entry"."Document No.";
                    DocLnNo := "Detailed GST Ledger Entry"."Document Line No.";

                END;


                /*
                IF Docno1 <> "Detailed GST Ledger Entry"."Document no." THEN BEGIN
                  AdvancedetHdrExcel("Detailed GST Ledger Entry");
                  Docno1 := "Detailed GST Ledger Entry"."Document No.";
                END;
                 */

            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuffer.NewRow;
            end;

            trigger OnPreDataItem()
            begin
                StartDate := GETRANGEMIN("Detailed GST Ledger Entry"."Posting Date");
                EndDate := GETRANGEMAX("Detailed GST Ledger Entry"."Posting Date");


                //IF RegNo = '' THEN
                //ERROR('Please select GST Registration No.!');

                //SETRANGE("Location  Reg. No.", RegNo);

                GSTRHdrNewFormat;
                //AdvanceDetData;
            end;
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("GST Customer Type" = FILTER(Export));
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    //-- GST Customer Type : Export Data
                    ItemTypeDesc1 := '';
                    CASE Type OF
                        Type::Item:
                            IF Item1.GET("No.") THEN
                                ItemTypeDesc1 := Item1.Description;

                        Type::"Fixed Asset":
                            IF FA1.GET("No.") THEN
                                ItemTypeDesc1 := FA1.Description;

                        Type::Resource:
                            IF Resource1.GET("No.") THEN
                                ItemTypeDesc1 := Resource1.Name;

                        Type::"G/L Account":
                            IF GL1.GET("No.") THEN
                                ItemTypeDesc1 := GL1.Name;
                    END;

                    SACCode := '';
                    HSNCode := '';
                    HSNorSAC.RESET;
                    HSNorSAC.SETRANGE(Code, "HSN/SAC Code");
                    IF HSNorSAC.FINDFIRST THEN BEGIN
                        CASE HSNorSAC.Type OF
                            HSNorSAC.Type::HSN:
                                HSNCode := HSNorSAC.Code;
                            HSNorSAC.Type::SAC:
                                SACCode := HSNorSAC.Code;
                        END;
                    END;

                    IF recLoc.GET("Location Code") THEN;
                    IF recCust.GET("Sell-to Customer No.") THEN;

                    SrNo2 += 1;
                    TempExcelBuffer.AddColumn(FORMAT(SrNo2), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("Sales Invoice Header"."GST Customer Type"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(recLoc."GST Registration No."), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(recLoc."Location Dimension"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(recCust."GST Registration No."), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(recCust.Name), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("Document No."), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("Posting Date"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(ItemTypeDesc1), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(HSNCode), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                    //--New Column >>
                    TempExcelBuffer.AddColumn(FORMAT(SACCode), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//9
                    //--New Column <<

                    TempExcelBuffer.AddColumn(FORMAT(Quantity), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("Unit of Measure Code"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("GST Jurisdiction Type"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("Sales Invoice Header"."Nature of Supply"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT("Sales Invoice Header"."GST Without Payment of Duty"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(recCust."State Code"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    // 16625  TempExcelBuffer.AddColumn(FORMAT("Amount To Customer"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(GetAmttoCustomerPostedLine("Document No.", "Line No.")), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(GetGSTBaseAmtPostedLine("Document No.", "Line No.")), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    // 16225 TempExcelBuffer.AddColumn(FORMAT("GST Base Amount"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.NewRow;
                end;
            }

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);

                TempExcelBuffer.AddColumn('GST Customer Type "Export" Data', FALSE, '', TRUE, TRUE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.NewRow;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("GST Registration No."; RegNo)
                {
                    TableRelation = "GST Registration Nos.".Code;
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

    trigger OnPostReport()
    begin
        // TempExcelBuffer.CreateBookAndOpenExcel('GSTR1', 'GST Return', COMPANYNAME, USERID, '');
        //16225  TempExcelBuffer.GiveUserControl;
        TempExcelBuffer.CreateNewBook('GSTR1');
        TempExcelBuffer.WriteSheet('GSTR1', CompanyName, UserId);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo('GSTR1', CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    var
        Docno: Code[20];
        DocLnNo: Integer;
        Docno1: Code[20];
        "--DrValue--": Integer;
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTRate: Decimal;
        SGSTAmt: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        UTGSTRate: Decimal;
        UTGSTAmt: Decimal;
        "--CrValue--": Integer;
        CrCGSTRate: Decimal;
        CrCGSTAmt: Decimal;
        CrSGSTRate: Decimal;
        CrSGSTAmt: Decimal;
        CrIGSTRate: Decimal;
        CrIGSTAmt: Decimal;
        CrUTGSTRate: Decimal;
        CrUTGSTAmt: Decimal;
        "--CrValueEnd--": Integer;
        "--Adv--": Integer;
        AdvCGSTRate: Decimal;
        AdvCGSTAmt: Decimal;
        AdvSGSTRate: Decimal;
        AdvSGSTAmt: Decimal;
        AdvIGSTRate: Decimal;
        AdvIGSTAmt: Decimal;
        AdvUTGSTRate: Decimal;
        AdvUTGSTAmt: Decimal;
        "--AdvEnd--": Integer;
        DocNoB2B: Code[20];
        LineNoB2B: Integer;
        SrNo1: Integer;
        Vend1: Record Vendor;
        Cust1: Record Customer;
        Item1: Record Item;
        GL1: Record "G/L Account";
        FA1: Record "Fixed Asset";
        Resource1: Record Resource;
        ItemTypeDesc: Text;
        Partyname: Text;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        DocLnNoB2B: Integer;
        recCustLedgEnt: Record "Cust. Ledger Entry";
        AdvAdjustedAmt: Decimal;
        RegNo: Code[20];
        HSNorSAC: Record "HSN/SAC";
        HSNCode: Code[20];
        SACCode: Code[20];
        recLocation: Record Location;
        "----SILn----": Integer;
        ItemTypeDesc1: Text[50];
        StartDate: Date;
        EndDate: Date;
        SrNo2: Integer;
        recLoc: Record Location;
        recCust: Record Customer;
        recSCrMHdr: Record "Sales Cr.Memo Header";
        PurchInvLine: Record "Purch. Inv. Line";
        TotalAmt1: Decimal;
        TotalAmt: Decimal;

    procedure GSTRHdrNewFormat()
    begin
        TempExcelBuffer.AddColumn(FORMAT('Sr. No.'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Whether recipient is registered or unregistered'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('GSTIN Location'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('GSTIN Location Name'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('GSTIN / UIN of recipient'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Name of recipient(Refer Note 4 below)'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Invoice Number'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Invoice Date'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Description of goods / services provided'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('HSN code for goods & services'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        //--New Column >>
        TempExcelBuffer.AddColumn(FORMAT('SAC for services (Refer Note 4 below)'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//9
        //--New Column <<

        TempExcelBuffer.AddColumn(FORMAT('Quantity of goods sold'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Unit Quantity Code / UOM'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Whether supply is an inter-state supply or an intra-state supply'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Nature of supply(Refer Note 2 below)'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Whether export /supplies to SEZ undertaken without payment of IGST under Bond / LUT or with payment of IGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Place of Supply(Name of State / UT)'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Serial number of Shipping Bill in case of exports'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Date of Shipping Bill in case of exports'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Serial number of Bill of Export in case of supplies to SEZs or deemed exports'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Date of Bill of Export in case of supplies to SEZs or deemed exports'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Total invoice value'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Taxable value of goods / services'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of CGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of CGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of SGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of SGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of UTGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of UTGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of IGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of IGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of Cess'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of Cess'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        //-- New Columns >>
        TempExcelBuffer.AddColumn(FORMAT('Serial number of Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Date of Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Serial number of revised Shipping Bill'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Date of revised Shipping Bill'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Corresponding invoice number against which Debit note / Credit note is issued'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Corresponding invoice date against which Debit note / Credit note is issued'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Differential value for which Debit note / Credit note is issued / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of CGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of CGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of SGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of SGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of UTGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of UTGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of IGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of IGST charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of Cess charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of Cess charged on Debit note / Credit note / Refund Voucher'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        //-- New Columns <<

        //--Old
        TempExcelBuffer.AddColumn(FORMAT('Receipt Voucher No.'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Receipt Date'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        //--Old

        //-- New Columns >>
        TempExcelBuffer.AddColumn(FORMAT('Advance adjusted against Invoice'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of CGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of CGST adjusted'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of SGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of SGST adjusted'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of UTGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of UTGST adjusted'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of IGST'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of IGST adjusted'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Rate of Cess'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT('Amount of Cess adjusted'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        //-- New Columns <<

        //TempExcelBuffer.AddColumn(FORMAT('Receipt Amount'),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text); //--
        TempExcelBuffer.NewRow;
    end;

    local procedure GSTRDataNewFormat(DetailedGSTLedgerEntryExcel: Record "Detailed GST Ledger Entry")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DetGSTLE: Record "Detailed GST Ledger Entry";
    begin
        //TempExcelBuffer.AddColumn(FORMAT('B2B'),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
        //IF CheckBln <> TRUE THEN BEGIN
        CGSTAmt := 0;
        SGSTAmt := 0;
        IGSTAmt := 0;
        UTGSTAmt := 0;
        CGSTRate := 0;
        SGSTRate := 0;
        IGSTRate := 0;
        UTGSTRate := 0;

        CrCGSTAmt := 0;
        CrSGSTAmt := 0;
        CrIGSTAmt := 0;
        CrUTGSTAmt := 0;
        CrCGSTRate := 0;
        CrSGSTRate := 0;
        CrIGSTRate := 0;
        CrUTGSTRate := 0;

        AdvCGSTAmt := 0;
        AdvSGSTAmt := 0;
        AdvIGSTAmt := 0;
        AdvUTGSTAmt := 0;
        AdvCGSTRate := 0;
        AdvSGSTRate := 0;
        AdvIGSTRate := 0;
        AdvUTGSTRate := 0;
        AdvAdjustedAmt := 0;

        DetailedGSTLedgerEntryExcel.RESET;
        DetailedGSTLedgerEntryExcel.SETRANGE("Document No.", "Detailed GST Ledger Entry"."Document No.");
        DetailedGSTLedgerEntryExcel.SETRANGE("Document Line No.", "Detailed GST Ledger Entry"."Document Line No.");
        IF DetailedGSTLedgerEntryExcel.FINDFIRST THEN
            REPEAT
                IF (DocNoB2B <> DetailedGSTLedgerEntryExcel."Document No.") OR (DocLnNoB2B <> DetailedGSTLedgerEntryExcel."Document Line No.") THEN BEGIN
                    DetGSTLE.RESET;
                    DetGSTLE.SETRANGE("Document No.", DetailedGSTLedgerEntryExcel."Document No.");
                    DetGSTLE.SETRANGE("Document Line No.", DetailedGSTLedgerEntryExcel."Document Line No.");
                    IF DetGSTLE.FINDFIRST THEN
                        REPEAT
                            IF (DetGSTLE."Transaction Type" = DetGSTLE."Transaction Type"::Sales) AND (DetGSTLE."Document Type" = DetGSTLE."Document Type"::Invoice) THEN BEGIN
                                CASE DetGSTLE."GST Component Code" OF
                                    'CGST':
                                        BEGIN
                                            CGSTRate := DetGSTLE."GST %";
                                            CGSTAmt := DetGSTLE."GST Amount";
                                        END;
                                    'SGST':
                                        BEGIN
                                            SGSTRate := DetGSTLE."GST %";
                                            SGSTAmt := DetGSTLE."GST Amount";
                                        END;
                                    'IGST':
                                        BEGIN
                                            IGSTRate := DetGSTLE."GST %";
                                            IGSTAmt := DetGSTLE."GST Amount";
                                        END;
                                    'UGST':
                                        BEGIN
                                            UTGSTRate := DetGSTLE."GST %";
                                            UTGSTAmt := DetGSTLE."GST Amount";
                                        END;
                                END;
                            END ELSE
                                IF (DetGSTLE."Transaction Type" = DetGSTLE."Transaction Type"::Sales) AND (DetGSTLE."Document Type" = DetGSTLE."Document Type"::"Credit Memo") THEN BEGIN
                                    CASE DetGSTLE."GST Component Code" OF
                                        'CGST':
                                            BEGIN
                                                CrCGSTRate := DetGSTLE."GST %";
                                                CrCGSTAmt := DetGSTLE."GST Amount";
                                            END;
                                        'SGST':
                                            BEGIN
                                                CrSGSTRate := DetGSTLE."GST %";
                                                CrSGSTAmt := DetGSTLE."GST Amount";
                                            END;
                                        'IGST':
                                            BEGIN
                                                CrIGSTRate := DetGSTLE."GST %";
                                                CrIGSTAmt := DetGSTLE."GST Amount";
                                            END;
                                        'UGST':
                                            BEGIN
                                                CrUTGSTRate := DetGSTLE."GST %";
                                                CrUTGSTAmt := DetGSTLE."GST Amount";
                                            END;
                                    END;
                                END ELSE
                                    IF (DetGSTLE."Transaction Type" = DetGSTLE."Transaction Type"::Sales) AND
                                      (DetGSTLE."Document Type" = DetGSTLE."Document Type"::Payment) AND
                                      (DetGSTLE."GST on Advance Payment" = TRUE) THEN BEGIN
                                        CASE DetGSTLE."GST Component Code" OF
                                            'CGST':
                                                BEGIN
                                                    AdvCGSTRate := DetGSTLE."GST %";
                                                    AdvCGSTAmt := DetGSTLE."GST Amount";
                                                END;
                                            'SGST':
                                                BEGIN
                                                    AdvSGSTRate := DetGSTLE."GST %";
                                                    AdvSGSTAmt := DetGSTLE."GST Amount";
                                                END;
                                            'IGST':
                                                BEGIN
                                                    AdvIGSTRate := DetGSTLE."GST %";
                                                    AdvIGSTAmt := DetGSTLE."GST Amount";
                                                END;
                                            'UGST':
                                                BEGIN
                                                    AdvUTGSTRate := DetGSTLE."GST %";
                                                    AdvUTGSTAmt := DetGSTLE."GST Amount";
                                                END;
                                        END;
                                        AdvAdjustedAmt := TotalAmt / TotalAmt1;
                                        //16767 AdvAdjustedAmt := GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.") / GetAmttoVendorPostedLine(PurchInvLine."Document No.", PurchInvLine."Line No.");
                                        //16225 AdvAdjustedAmt := DetGSTLE."Amount to Customer/Vendor";
                                    END ELSE
                                        IF (DetGSTLE."Transaction Type" = DetGSTLE."Transaction Type"::Purchase) AND
                                          (DetGSTLE."GST Vendor Type" = DetGSTLE."GST Vendor Type"::Unregistered) AND
                                          (DetGSTLE."Reverse Charge" = TRUE) THEN BEGIN
                                            CASE DetGSTLE."GST Component Code" OF
                                                'CGST':
                                                    BEGIN
                                                        AdvCGSTRate := DetGSTLE."GST %";
                                                        AdvCGSTAmt := DetGSTLE."GST Amount";
                                                    END;
                                                'SGST':
                                                    BEGIN
                                                        AdvSGSTRate := DetGSTLE."GST %";
                                                        AdvSGSTAmt := DetGSTLE."GST Amount";
                                                    END;
                                                'IGST':
                                                    BEGIN
                                                        AdvIGSTRate := DetGSTLE."GST %";
                                                        AdvIGSTAmt := DetGSTLE."GST Amount";
                                                    END;
                                                'UGST':
                                                    BEGIN
                                                        AdvUTGSTRate := DetGSTLE."GST %";
                                                        AdvUTGSTAmt := DetGSTLE."GST Amount";
                                                    END;
                                            END;
                                            AdvAdjustedAmt := TotalAmt / TotalAmt1;
                                            //16767AdvAdjustedAmt := GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.") / GetAmttoVendorPostedLine(PurchInvLine."Document No.", PurchInvLine."Line No.");
                                            //16225 AdvAdjustedAmt := DetGSTLE."Amount to Customer/Vendor";
                                        END;

                        UNTIL DetGSTLE.NEXT = 0;

                    SrNo1 += 1;
                    Partyname := '';
                    CASE DetailedGSTLedgerEntryExcel."Source Type" OF
                        DetailedGSTLedgerEntryExcel."Source Type"::Vendor:
                            IF Vend1.GET(DetailedGSTLedgerEntryExcel."Source No.") THEN
                                Partyname := Vend1.Name;

                        DetailedGSTLedgerEntryExcel."Source Type"::Customer:
                            IF Cust1.GET(DetailedGSTLedgerEntryExcel."Source No.") THEN
                                Partyname := Cust1.Name;
                    END;

                    ItemTypeDesc := '';
                    CASE DetailedGSTLedgerEntryExcel.Type OF
                        DetailedGSTLedgerEntryExcel.Type::Item:
                            IF Item1.GET(DetailedGSTLedgerEntryExcel."No.") THEN
                                ItemTypeDesc := Item1.Description;

                        DetailedGSTLedgerEntryExcel.Type::"Fixed Asset":
                            IF FA1.GET(DetailedGSTLedgerEntryExcel."No.") THEN
                                ItemTypeDesc := FA1.Description;

                        DetailedGSTLedgerEntryExcel.Type::Resource:
                            IF Resource1.GET(DetailedGSTLedgerEntryExcel."No.") THEN
                                ItemTypeDesc := Resource1.Name;

                        DetailedGSTLedgerEntryExcel.Type::"G/L Account":
                            IF GL1.GET(DetailedGSTLedgerEntryExcel."No.") THEN
                                ItemTypeDesc := GL1.Name;
                    END;

                    recCustLedgEnt.RESET;
                    recCustLedgEnt.SETRANGE("Document No.", DetailedGSTLedgerEntryExcel."Document No.");
                    IF DetailedGSTLedgerEntryExcel.FINDFIRST THEN;

                    SACCode := '';
                    HSNCode := '';
                    HSNorSAC.RESET;
                    HSNorSAC.SETRANGE(Code, DetailedGSTLedgerEntryExcel."HSN/SAC Code");
                    IF HSNorSAC.FINDFIRST THEN BEGIN
                        CASE HSNorSAC.Type OF
                            HSNorSAC.Type::HSN:
                                HSNCode := HSNorSAC.Code;
                            HSNorSAC.Type::SAC:
                                SACCode := HSNorSAC.Code;
                        END;
                    END;


                    IF recSCrMHdr.GET(DetailedGSTLedgerEntryExcel."Document No.") THEN;

                    recLocation.RESET;
                    recLocation.SETRANGE(recLocation."GST Registration No.", DetailedGSTLedgerEntryExcel."Location  Reg. No.");
                    IF recLocation.FINDFIRST THEN;
                    //Excel Data begin >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.
                    /*
                    IF (DetailedGSTLedgerEntryExcel."Transaction Type" = DetailedGSTLedgerEntryExcel."Transaction Type"::purch) AND
                      (DetailedGSTLedgerEntryExcel."GST Vendor Type" = DetailedGSTLedgerEntryExcel."GST Vendor Type"::unre) THEN
                      CurrReport.SKIP;
                     */

                    TempExcelBuffer.AddColumn(SrNo1, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    IF DetailedGSTLedgerEntryExcel."Transaction Type" = DetailedGSTLedgerEntryExcel."Transaction Type"::Sales THEN
                        TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."GST Customer Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text)
                    ELSE
                        IF DetailedGSTLedgerEntryExcel."Transaction Type" = DetailedGSTLedgerEntryExcel."Transaction Type"::Purchase THEN
                            TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."GST Vendor Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                    TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Location  Reg. No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//MSVRN 091117
                    TempExcelBuffer.AddColumn(FORMAT(recLocation."Location Dimension"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//MSVRN 091117
                    TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Buyer/Seller Reg. No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(Partyname), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Document No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(DetailedGSTLedgerEntryExcel."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn(FORMAT(ItemTypeDesc), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(HSNCode), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                    //--New Row >>
                    TempExcelBuffer.AddColumn(FORMAT(SACCode), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//9
                                                                                                                                      //--New Row <<

                    TempExcelBuffer.AddColumn(-1 * (DetailedGSTLedgerEntryExcel.Quantity), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(FORMAT('UOM'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."GST Jurisdiction Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    //16225  TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Nature of Supply"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."GST Without Payment of Duty"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    //16225  TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Buyer/Seller State Code"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    //IF DetailedGSTLedgerEntryExcel."GST Customer Type" = DetailedGSTLedgerEntryExcel."GST Customer Type"::Export THEN BEGIN
                    //TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Bill Of Export No."),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    //TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Bill Of Export Date"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    //END ELSE IF DetailedGSTLedgerEntryExcel."GST Customer Type" = DetailedGSTLedgerEntryExcel."GST Customer Type"::"Deemed Export" THEN BEGIN
                    //TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Bill Of Export No."),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    //TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Bill Of Export Date"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    //END ELSE BEGIN
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    //END;
                    TempExcelBuffer.AddColumn(Abs(TotalAmt / TotalAmt1), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    //16767 TempExcelBuffer.AddColumn(ABS(GetAmttoCustomerPostedLine("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.") + GetAmttoVendorPostedLine(PurchInvLine."Document No.", PurchInvLine."Line No.")), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    // 16625 TempExcelBuffer.AddColumn(ABS(DetailedGSTLedgerEntryExcel."Amount to Customer/Vendor"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(ABS(DetailedGSTLedgerEntryExcel."GST Base Amount"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(ABS(CGSTAmt), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(ABS(SGSTAmt), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(UTGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(ABS(UTGSTAmt), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(ABS(IGSTAmt), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text); //Rate of Cess
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text); //Amount of Cess

                    //-- New Columns (Debit note / Credit note / Refund Voucher) >>
                    IF (DetailedGSTLedgerEntryExcel."Document Type" = DetailedGSTLedgerEntryExcel."Document Type"::"Credit Memo") OR
                      (DetailedGSTLedgerEntryExcel."Document Type" = DetailedGSTLedgerEntryExcel."Document Type"::Refund) AND
                      (DetailedGSTLedgerEntryExcel."Reverse Charge") THEN BEGIN
                        TempExcelBuffer.AddColumn(FORMAT(recSCrMHdr."Applies-to Doc. No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(DetailedGSTLedgerEntryExcel."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    END ELSE BEGIN
                        TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    END;

                    TempExcelBuffer.AddColumn(FORMAT('Serial number of revised Shipping Bill'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT('Date of revised Shipping Bill'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Application Doc. No"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(recCustLedgEnt."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);

                    //16225  TempExcelBuffer.AddColumn(DetailedGSTLedgerEntryExcel."Amount to Customer/Vendor",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrCGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrCGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrSGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrSGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrUTGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrUTGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrIGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CrIGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);

                    IF (DetailedGSTLedgerEntryExcel."Transaction Type" = DetailedGSTLedgerEntryExcel."Transaction Type"::Sales) AND
                      (DetailedGSTLedgerEntryExcel."Document Type" = DetailedGSTLedgerEntryExcel."Document Type"::Payment) THEN BEGIN
                        TempExcelBuffer.AddColumn(DetailedGSTLedgerEntryExcel."GST %", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(ABS(DetailedGSTLedgerEntryExcel."GST Amount"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    END ELSE BEGIN
                        TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    //-- New Columns <<

                    //--Old
                    TempExcelBuffer.AddColumn(FORMAT('Receipt Voucher No.'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT('Receipt Date'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    //--Old

                    //-- New Columns >>
                    TempExcelBuffer.AddColumn(AdvAdjustedAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvCGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvCGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvSGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvSGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvUTGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvUTGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvIGSTRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(AdvIGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    //-- New Columns <<

                    //MSVRN >> Not clear
                    // TempExcelBuffer.AddColumn(FORMAT('N/A'),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(FORMAT('N/A'),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(FORMAT('N/A'),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);

                    // TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Transaction Type"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Document Type"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Document No."),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Reverse Charge"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);

                    //Excel Data end >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.
                    /*
                        IF (DetailedGSTLedgerEntryExcel."GST on Advance Payment" = TRUE) AND
                         (DetailedGSTLedgerEntryExcel."Document Type" = DetailedGSTLedgerEntryExcel."Document Type"::Payment) THEN BEGIN
                          TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Document No."),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                          TempExcelBuffer.AddColumn(DetailedGSTLedgerEntryExcel."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Date);
                          TempExcelBuffer.AddColumn(FORMAT(DetailedGSTLedgerEntryExcel."Amount to Customer/Vendor"),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                        END;
                    */

                    //MSVRN <<

                    TempExcelBuffer.NewRow;
                    DocNoB2B := DetailedGSTLedgerEntryExcel."Document No.";
                    DocLnNoB2B := DetailedGSTLedgerEntryExcel."Document Line No."
                END;
            UNTIL DetailedGSTLedgerEntryExcel.NEXT = 0;
        //END;
        //END;

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
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt); //16767 - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;

    procedure GetAmttoVendorPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record 123;
        PstdPurchCrMemoLine: Record 125;
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

        if PstdPurchCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchCrMemoLine.Type <> PstdPurchCrMemoLine.Type::" " then
                LineAmt := PstdPurchCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdPurchInv.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchInv.Type <> PstdPurchInv.Type::" " then
                LineAmt := PstdPurchInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchInv.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        Clear(TotalAmt);
        TotalAmt1 := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt);//16767- TDSAmt;
        EXIT(ABS(TotalAmt));
    end;//

    procedure GetGSTBaseAmtPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record 113;
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




    procedure GSTRDataNewFormatSILn(DocNo: Code[20]; LineNo: Integer)
    var
        SrNo1: Integer;
        recSILn: Record "Sales Invoice Line";
        recLoc: Record Location;
        recCust: Record Customer;
    begin
        recSILn.RESET;
        recSILn.SETRANGE("Document No.", DocNo);
        recSILn.SETRANGE("Line No.", LineNo);
        IF recSILn.FINDFIRST THEN;

        ItemTypeDesc1 := '';
        CASE recSILn.Type OF
            recSILn.Type::Item:
                IF Item1.GET(recSILn."No.") THEN
                    ItemTypeDesc1 := Item1.Description;

            recSILn.Type::"Fixed Asset":
                IF FA1.GET(recSILn."No.") THEN
                    ItemTypeDesc1 := FA1.Description;

            recSILn.Type::Resource:
                IF Resource1.GET(recSILn."No.") THEN
                    ItemTypeDesc1 := Resource1.Name;

            recSILn.Type::"G/L Account":
                IF GL1.GET(recSILn."No.") THEN
                    ItemTypeDesc1 := GL1.Name;
        END;

        SACCode := '';
        HSNCode := '';
        HSNorSAC.RESET;
        HSNorSAC.SETRANGE(Code, recSILn."HSN/SAC Code");
        IF HSNorSAC.FINDFIRST THEN BEGIN
            CASE HSNorSAC.Type OF
                HSNorSAC.Type::HSN:
                    HSNCode := HSNorSAC.Code;
                HSNorSAC.Type::SAC:
                    SACCode := HSNorSAC.Code;
            END;
        END;

        IF recLoc.GET(recSILn."Location Code") THEN;
        IF recCust.GET(recSILn."Sell-to Customer No.") THEN;

        SrNo1 += 1;
        TempExcelBuffer.AddColumn(FORMAT(SrNo1), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT("Sales Invoice Header"."GST Customer Type"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recLoc."GST Registration No."), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recLoc."Location Dimension"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recCust."GST Registration No."), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recCust.Name), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recSILn."Document No."), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recSILn."Posting Date"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(ItemTypeDesc1), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(HSNCode), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        //--New Column >>
        TempExcelBuffer.AddColumn(FORMAT(SACCode), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//9
        //--New Column <<

        TempExcelBuffer.AddColumn(FORMAT(recSILn.Quantity), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recSILn."Unit of Measure Code"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recSILn."GST Jurisdiction Type"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT("Sales Invoice Header"."Nature of Supply"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT("Sales Invoice Header"."GST Without Payment of Duty"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(recCust."State Code"), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(GetAmttoCustomerPostedLine(recSILn."Document No.", recSILn."Line No.")), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FORMAT(GetGSTBaseAmtPostedLine(recSILn."Document No.", recSILn."Line No.")), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        //16225  TempExcelBuffer.AddColumn(FORMAT(recSILn."Amount To Customer"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
        //16225   TempExcelBuffer.AddColumn(FORMAT(recSILn."GST Base Amount"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
    end;
}

