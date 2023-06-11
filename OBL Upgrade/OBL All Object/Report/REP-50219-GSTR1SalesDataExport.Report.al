report 50219 "GSTR-1 Sales Data Export"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("Prepayment Invoice" = FILTER(false));
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''),
                                          Quantity = FILTER(<> 0));

                trigger OnAfterGetRecord()
                begin

                    IF "No." <> '503730' THEN BEGIN
                        IF Location.GET("Sales Invoice Line"."Location Code") THEN;
                        Customer.GET("Bill-to Customer No.");

                        //State Code Start
                        CLEAR(State2);
                        CLEAR(StateCode);
                        IF "Sales Invoice Header"."GST Ship-to State Code" <> '' THEN BEGIN
                            IF State2.GET("Sales Invoice Header"."GST Ship-to State Code") THEN
                                StateCode := State2."State Code (GST Reg. No.)"
                        END;
                        IF "Sales Invoice Header"."GST Bill-to State Code" <> '' THEN BEGIN
                            IF State2.GET("Sales Invoice Header"."GST Bill-to State Code") THEN
                                StateCode := State2."State Code (GST Reg. No.)"
                        END ELSE BEGIN
                            //16225IF State2.GET("Sales Invoice Header"."Bill to Customer State") THEN
                            StateCode := State2."State Code (GST Reg. No.)";
                        END;
                        //State Code End

                        IF ExportB2bData AND NOT ("Sales Invoice Header"."Customer Posting Group" = 'FOREIGN') THEN
                            EnterB2bRowData;
                        IF (ExportGstExportData) AND ("Sales Invoice Header"."Customer Posting Group" = 'FOREIGN') THEN
                            EnterExportRowData;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //IF ExportJnlVoucherData THEN
                //  CurrReport.SKIP;
            end;

            trigger OnPostDataItem()
            begin
                IF ExportB2bData THEN BEGIN
                    //TempB2bExcelBuffer.CreateBook(B2bInvoiceDataTxt,B2bInvoiceDataTxt);
                    // TempB2bExcelBuffer.CreateBookAndOpenExcel('', B2bInvoiceDataTxt, '', COMPANYNAME, USERID);
                    TempB2bExcelBuffer.CreateNewBook(B2bInvoiceDataTxt);//16767
                    TempB2bExcelBuffer.WriteSheet(B2bInvoiceDataTxt, CompanyName, UserId);//16767
                    TempB2bExcelBuffer.CloseBook;
                    TempB2bExcelBuffer.SetFriendlyFilename(StrSubstNo(B2bInvoiceDataTxt, CurrentDateTime, UserId));//16767
                    TempB2bExcelBuffer.OpenExcel;//16767
                    // TempB2bExcelBuffer.OpenExcel;
                    ///  TempB2bExcelBuffer.GiveUserControl;
                END;
                IF ExportGstExportData THEN BEGIN
                    // TempExportExcelBuffer.CreateBookAndOpenExcel('', GSTExportDataTxt, '', COMPANYNAME, USERID);
                    // TempExportExcelBuffer.WriteSheet(GSTExportDataTxt,COMPANYNAME,USERID);
                    TempExportExcelBuffer.CreateNewBook(GSTExportDataTxt);
                    TempExportExcelBuffer.WriteSheet(GSTExportDataTxt, CompanyName, UserId);
                    TempExportExcelBuffer.CloseBook;
                    TempExportExcelBuffer.SetFriendlyFilename(StrSubstNo(GSTExportDataTxt, CurrentDateTime, UserId));
                    TempExportExcelBuffer.OpenExcel;
                    // TempExportExcelBuffer.OpenExcel;
                    /// TempExportExcelBuffer.GiveUserControl;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);

                IF NOT (ExportB2bData OR ExportCrNoteData OR ExportGstExportData OR ExportJnlVoucherData) THEN
                    CurrReport.BREAK;

                RowNo := 1;
                ColumnNo := 1;
                IF ExportB2bData THEN
                    EnterCell(RowNo, ColumnNo, B2bInvoiceDataTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
                IF ExportGstExportData THEN
                    EnterCell(RowNo, ColumnNo, GSTExportDataTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
                IF ExportJnlVoucherData THEN
                    EnterCell(RowNo, ColumnNo, VoucherExportDataTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);

                RowNo += 1;
                IF ExportB2bData THEN
                    EnterCell(RowNo, ColumnNo, GETFILTERS(), TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
                IF ExportGstExportData THEN
                    EnterCell(RowNo, ColumnNo, GETFILTERS(), TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
                IF ExportJnlVoucherData THEN
                    EnterCell(RowNo, ColumnNo, GETFILTERS(), TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);


                RowNo += 1;
                IF ExportB2bData THEN
                    PrePareB2bHeading;
                ColumnNo := 1;
                IF ExportGstExportData THEN
                    PrePareExportHeading;
                ColumnNo := 1;
                IF ExportJnlVoucherData THEN
                    PrePareVoucherHeading;

                IF ExportJnlVoucherData THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''),
                                          Quantity = FILTER(<> 0));

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Cr.Memo Line"."No." <> '503730' THEN BEGIN
                        IF Location.GET("Sales Cr.Memo Line"."Location Code") THEN;
                        CLEAR(State2);
                        CLEAR(StateCode2);
                        IF "Sales Cr.Memo Header"."GST Ship-to State Code" <> '' THEN BEGIN
                            IF State2.GET("Sales Cr.Memo Header"."GST Ship-to State Code") THEN
                                StateCode2 := State2."State Code (GST Reg. No.)"
                        END;
                        IF "Sales Invoice Header"."GST Bill-to State Code" <> '' THEN BEGIN
                            IF State2.GET("Sales Cr.Memo Header"."GST Bill-to State Code") THEN
                                StateCode2 := State2."State Code (GST Reg. No.)"
                        END ELSE BEGIN
                            //16225  IF State2.GET("Sales Cr.Memo Header"."Bill to Customer State") THEN
                            StateCode2 := State2."State Code (GST Reg. No.)"
                        END;

                        Customer.GET("Bill-to Customer No.");
                        EnterCrNoteRowData;
                    END;
                end;
            }

            trigger OnPostDataItem()
            begin
                IF ExportCrNoteData THEN BEGIN
                    // TempCrNoteExcelBuffer.CreateBookAndOpenExcel('', gstr1_CDNTxt, '', COMPANYNAME, USERID);
                    // TempCrNoteExcelBuffer.WriteSheet(gstr1_CDNTxt,COMPANYNAME,USERID);
                    TempCrNoteExcelBuffer.CreateNewBook(gstr1_CDNTxt);//16767
                    TempCrNoteExcelBuffer.WriteSheet(gstr1_CDNTxt, CompanyName, UserId);//16767
                    TempCrNoteExcelBuffer.CloseBook;
                    TempCrNoteExcelBuffer.SetFriendlyFilename(StrSubstNo(gstr1_CDNTxt, CurrentDateTime, UserId));//16767
                    TempCrNoteExcelBuffer.OpenExcel;//16767
                    //  TempCrNoteExcelBuffer.OpenExcel;
                    ///  TempCrNoteExcelBuffer.GiveUserControl;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);

                IF NOT ExportCrNoteData THEN
                    CurrReport.BREAK;

                RowNo := 1;
                ColumnNo := 1;

                EnterCell(RowNo, ColumnNo, gstr1_CDNTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
                RowNo += 1;
                EnterCell(RowNo, ColumnNo, GETFILTERS(), TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
                RowNo += 1;
                PrePareCrNoteHeading;
            end;
        }
        dataitem("Detailed GST Ledger Entry"; "Detailed GST Ledger Entry")
        {
            DataItemTableView = ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Payment | Refund),
                                      "Transaction Type" = FILTER(Sales),
                                      "Source Type" = FILTER(Customer),
                                      "Entry Type" = FILTER('Initial Entry'),
                                      "GST Component Code" = FILTER('CGST' | 'IGST'));
            RequestFilterFields = "Source No.";

            trigger OnAfterGetRecord()
            var
                SumForGstBaseAmt: Query "WS Dealer Outstanding Report";
                QueryForGSTAmount: Query "Dtld. GST Ledg. Entry Comp2";
                DetGstLedgerEntryInfo: Record "Detailed GST Ledger Entry Info";//16225
            begin
                DetGstLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");//16225
                ColumnNo := 1;
                IF ExportJnlVoucherData THEN BEGIN

                    Counter := Counter + 1;
                    Window.UPDATE(1, "Document No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                    ColumnNo := 1;

                    IF VoucherRowNo = 0 THEN
                        VoucherRowNo := RowNo;
                    VoucherRowNo += 1;
                    RowNo := VoucherRowNo;

                    CLE.RESET;
                    //CLE.SETRANGE("Entry No.","CLE/VLE Entry No.");
                    CLE.SETRANGE("Transaction No.", "Detailed GST Ledger Entry"."Transaction No."); //Added on 14/03/18 Abhishek
                    IF CLE.FINDFIRST THEN;

                    GSTPer := 0;
                    IF "GST Component Code" = 'CGST' THEN
                        GSTPer := 2 * "GST %"
                    ELSE
                        GSTPer := "GST %";

                    EnterCell(RowNo, ColumnNo, FORMAT("Location  Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT('Add'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    IF (CLE."Document Type" = CLE."Document Type"::Refund) OR (CLE.Reversed = TRUE) THEN
                        EnterCell(RowNo, ColumnNo, FORMAT('Refund'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                    ELSE
                        EnterCell(RowNo, ColumnNo, FORMAT('Receipt'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);

                    ColumnNo += 1;
                    IF "Reverse Charge" THEN
                        EnterCell(RowNo, ColumnNo, FORMAT('Y'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                    ELSE
                        EnterCell(RowNo, ColumnNo, FORMAT('N'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;

                    EnterCell(RowNo, ColumnNo, "Document No.", FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT("Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempJnlVoucherExcelBuffer."Cell Type"::Date, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, CLE."External Document No.", FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempJnlVoucherExcelBuffer."Cell Type"::Date, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    IF (CLE.Reversed = FALSE) AND (CLE."Document Type" <> CLE."Document Type"::Refund) THEN BEGIN
                        EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS("GST Base Amount"), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        AdvAmount := 0;
                        //Application Entries Start

                        DCLE.RESET;
                        //16225DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.","CLE/VLE Entry No.");
                        DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", DetGstLedgerEntryInfo."CLE/VLE Entry No.");
                        DCLE.SETRANGE(DCLE."Entry Type", DCLE."Entry Type"::Application);
                        DCLE.SETFILTER(DCLE."Document Type", '<>%1', DCLE."Document Type"::Refund);//Added on 14/03/18 Abhishek
                        DCLE.SETRANGE("Posting Date", FromDate, ToDate);
                        IF DCLE.FINDSET THEN
                            REPEAT
                                AdvAmount += (DCLE.Amount / (100 + GSTPer)) * 100;
                            UNTIL DCLE.NEXT = 0;

                        IF AdvAmount = 0 THEN
                            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                        ELSE
                            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(AdvAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        //Application Entries End
                    END ELSE
                        IF (CLE.Reversed = TRUE) AND (CLE."Document Type" = CLE."Document Type"::Payment) THEN BEGIN
                            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS("GST Base Amount"), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                            ColumnNo += 1;

                            DCLE.RESET;
                            //16225 DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.","CLE/VLE Entry No.");
                            DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", DetGstLedgerEntryInfo."CLE/VLE Entry No.");
                            DCLE.SETRANGE(DCLE."Entry Type", DCLE."Entry Type"::Application);
                            DCLE.SETRANGE("Posting Date", FromDate, ToDate);
                            IF DCLE.FINDFIRST THEN
                                EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS("GST Base Amount"), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer)
                            ELSE
                                EnterCell(RowNo, ColumnNo, FORMAT(0), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                            ColumnNo += 1;

                        END ELSE BEGIN
                            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                            ColumnNo += 1;
                            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS("GST Base Amount"), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                            ColumnNo += 1;
                        END;

                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND(GSTPer, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;

                    //GST amount START
                    CGSTAmount := 0;
                    IGSTAmount := 0;
                    SGSTAmount := 0;
                    ECessAmount := 0;
                    QueryForGSTAmount.SETRANGE(Posting_Date, "Posting Date");
                    QueryForGSTAmount.SETFILTER(Document_No, "Document No.");
                    QueryForGSTAmount.SETFILTER(Document_Line_No, '%1', "Document Line No.");
                    QueryForGSTAmount.SETFILTER(Source_Type, 'Customer');
                    QueryForGSTAmount.SETFILTER(Document_Type, FORMAT("Document Type"));
                    QueryForGSTAmount.SETFILTER(Transaction_Type, 'Sales');
                    QueryForGSTAmount.OPEN;
                    WHILE QueryForGSTAmount.READ DO BEGIN
                        IF QueryForGSTAmount.GST_Component_Code = 'IGST' THEN
                            IGSTAmount := QueryForGSTAmount.Sum_GST_Amount;
                        IF QueryForGSTAmount.GST_Component_Code = 'CGST' THEN
                            CGSTAmount := QueryForGSTAmount.Sum_GST_Amount;
                        IF QueryForGSTAmount.GST_Component_Code = 'SGST' THEN
                            SGSTAmount := QueryForGSTAmount.Sum_GST_Amount;
                    END;
                    //GST amount END

                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(IGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(CGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(SGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ECessAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;

                    //state Code START
                    CLEAR(State2);
                    CLEAR(StateCode);
                    //16225 IF "Buyer/Seller State Code" <> '' THEN
                    IF DetGstLedgerEntryInfo."Buyer/Seller State Code" <> '' THEN
                        IF State2.GET(DetGstLedgerEntryInfo."Buyer/Seller State Code") THEN
                            StateCode := State2."State Code (GST Reg. No.)";
                    //State Code END

                    EnterCell(RowNo, ColumnNo, FORMAT(StateCode), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    //ALLE TJ
                    //VendName := COPYSTR(Vendor.Name,1,11);
                    /*
                    IF Customer."GST Customer Type" = Customer."GST Customer Type" :: non THEN
                      SupplyType := 'Non GST'
                    ELSE IF Customer."GST Customer Type" = Customer."GST Customer Type" :: Exempted THEN
                      SupplyType := 'Exempted'
                    ELSE
                      SupplyType := 'Normal';
                    */
                    //ALLE TJ

                    EnterCell(RowNo, ColumnNo, 'Normal', FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    EnterCell(RowNo, ColumnNo, FORMAT("Buyer/Seller Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    ColumnNo += 1;
                    IF Customer2.GET(CLE."Customer No.") THEN;
                    EnterCell(RowNo, ColumnNo, FORMAT(Customer2.Name), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                END;
                //DocNo := "Document No.";

            end;

            trigger OnPreDataItem()
            begin
                IF NOT ExportJnlVoucherData THEN
                    CurrReport.SKIP;

                SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                DocNo := '';

                CounterTotal := COUNT;
                Window.OPEN(Text001);
            end;
        }
        dataitem("Detailed GST Ledger Entry1"; "Detailed GST Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date")
                                WHERE("Document Type" = FILTER(Payment),
                                      "Transaction Type" = FILTER(Sales),
                                      "Source Type" = FILTER(Customer),
                                      "Entry Type" = FILTER(Application),
                                      //16225 "Original Doc. No."=FILTER(<>''),
                                      "GST Component Code" = FILTER('CGST' | 'IGST'));
            RequestFilterFields = "Source No.";

            trigger OnAfterGetRecord()
            var
                DetGstLedgEntryInfo: Record "Detailed GST Ledger Entry Info";
            begin
                DetGstLedgEntryInfo.Get("Detailed GST Ledger Entry1"."Entry No.");
                DetailedGSTLedgerEntry3.RESET;
                DetailedGSTLedgerEntry3.SETRANGE("Entry Type", "Entry Type"::"Initial Entry");
                DetailedGSTLedgerEntry3.SETRANGE("Transaction Type", "Transaction Type"::Sales);
                DetailedGSTLedgerEntry3.SETRANGE("Document Type", "Document Type"::Payment);
                DetailedGSTLedgerEntry3.SETRANGE("Document No.", DetGstLedgEntryInfo."Original Doc. No.");
                IF DetailedGSTLedgerEntry3.FINDFIRST THEN
                    IF (DetailedGSTLedgerEntry3."Posting Date" >= FromDate) AND (DetailedGSTLedgerEntry3."Posting Date" <= ToDate) THEN
                        CurrReport.SKIP;


                IF DocNo <> "Document No." THEN BEGIN
                    AdvAmount := 0;
                    GSTAmount := 0;
                    DetailedGSTLedgerEntry3.RESET;
                    DetailedGSTLedgerEntry3.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry3.SETRANGE("Entry Type", "Entry Type"::Application);
                    DetailedGSTLedgerEntry3.SETRANGE("Posting Date", FromDate, ToDate);
                    DetailedGSTLedgerEntry3.SETFILTER("GST Component Code", '%1|%2', 'CGST', 'IGST');
                    DetailedGSTLedgerEntry3.SETFILTER("Document Type", '%1', "Detailed GST Ledger Entry"."Document Type"::Payment); //Added Abhishek 15-01-18
                    IF DetailedGSTLedgerEntry3.FINDSET THEN
                        REPEAT
                            AdvAmount += DetailedGSTLedgerEntry3."GST Base Amount";
                            GSTAmount += DetailedGSTLedgerEntry3."GST Amount";
                        UNTIL DetailedGSTLedgerEntry3.NEXT = 0;


                    IF AdvAmount = 0 THEN
                        CurrReport.SKIP;

                    IF ExportJnlVoucherData THEN BEGIN
                        RowNo += 1;
                        ColumnNo := 1;
                        CLE.RESET;
                        CLE.SETRANGE("Entry No.", DetGstLedgEntryInfo."CLE/VLE Entry No.");
                        IF CLE.FINDFIRST THEN;

                        EnterCell(RowNo, ColumnNo, FORMAT("Location  Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT('Add'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        IF (CLE."Document Type" = CLE."Document Type"::Refund) OR (CLE.Reversed) THEN
                            EnterCell(RowNo, ColumnNo, FORMAT('Refund'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                        ELSE
                            EnterCell(RowNo, ColumnNo, FORMAT('Receipt'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);

                        ColumnNo += 1;
                        IF "Reverse Charge" THEN
                            EnterCell(RowNo, ColumnNo, FORMAT('Y'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                        ELSE
                            EnterCell(RowNo, ColumnNo, FORMAT('N'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;

                        EnterCell(RowNo, ColumnNo, "Document No.", FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT("Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempJnlVoucherExcelBuffer."Cell Type"::Date, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, CLE."External Document No.", FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempJnlVoucherExcelBuffer."Cell Type"::Date, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT(ROUND(AdvAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        IF "GST Component Code" = 'CGST' THEN
                            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(2 * "GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer)
                        ELSE
                            EnterCell(RowNo, ColumnNo, FORMAT(ROUND("GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        IF "GST Component Code" = 'IGST' THEN BEGIN
                            IGSTAmount := GSTAmount;
                            CLEAR(CGSTAmount);
                            CLEAR(SGSTAmount);
                        END ELSE BEGIN
                            CGSTAmount := GSTAmount;
                            SGSTAmount := GSTAmount;
                            CLEAR(IGSTAmount);
                        END;
                        EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(IGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(CGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(SGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ECessAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        //state Code
                        CLEAR(State2);
                        CLEAR(StateCode);
                        IF DetGstLedgEntryInfo."Buyer/Seller State Code" <> '' THEN
                            //16225 IF State2.GET("Buyer/Seller State Code") THEN
                            IF State2.GET(DetGstLedgEntryInfo."Buyer/Seller State Code") THEN
                                StateCode := State2."State Code (GST Reg. No.)";
                        //State Code

                        EnterCell(RowNo, ColumnNo, FORMAT(StateCode), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;

                        EnterCell(RowNo, ColumnNo, 'Normal', FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        EnterCell(RowNo, ColumnNo, FORMAT("Buyer/Seller Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                        ColumnNo += 1;
                        IF Customer2.GET(CLE."Customer No.") THEN;
                        EnterCell(RowNo, ColumnNo, FORMAT(Customer2.Name), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                    END;
                END;

                DocNo := "Document No.";
                OriginalDocNo := DetGstLedgEntryInfo."Original Doc. No.";
                //16225 OriginalDocNo := "Original Doc. No.";
            end;

            trigger OnPreDataItem()
            begin
                IF NOT ExportJnlVoucherData THEN
                    CurrReport.SKIP;

                SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
            end;
        }
        dataitem("Detailed GST Ledger Entry2"; "Detailed GST Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date")
                                WHERE("Document Type" = FILTER(Invoice),
                                      "Transaction Type" = FILTER(Sales),
                                      "Source Type" = FILTER(Customer),
                                      "Entry Type" = FILTER(Application),
                                      //16225 "Original Doc. No."=FILTER(<>''),
                                      "GST Component Code" = FILTER('CGST' | 'IGST'));
            RequestFilterFields = "Source No.";

            trigger OnAfterGetRecord()
            var
                DetailGstLedgInfo: Record "Detailed GST Ledger Entry Info";//16225
            begin
                DetailGstLedgInfo.Get("Entry No.");//16225
                CLEAR(TempCustLedgerEntry);
                Cnt := 0;
                TotalAmt := 0;
                IF NOT TempCustLedgerEntry.ISEMPTY THEN
                    TempCustLedgerEntry.DELETEALL;

                IF DocNo <> "Document No." THEN BEGIN
                    CreateCustLedgEntry.RESET;
                    CreateCustLedgEntry.SETRANGE("Document Type", CreateCustLedgEntry."Document Type"::Invoice);
                    CreateCustLedgEntry.SETRANGE("Document No.", "Document No.");
                    IF CreateCustLedgEntry.FINDFIRST THEN BEGIN
                        DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
                        DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
                        DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
                        IF DtldCustLedgEntry1.FIND('-') THEN
                            REPEAT
                                IF DtldCustLedgEntry1."Cust. Ledger Entry No." =
                                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                                THEN BEGIN
                                    DtldCustLedgEntry2.INIT;
                                    DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                                    DtldCustLedgEntry2.SETRANGE(
                                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                                    DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                                    DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                                    IF DtldCustLedgEntry2.FIND('-') THEN
                                        REPEAT
                                            IF DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                                            THEN BEGIN
                                                CreateCustLedgEntry2.SETCURRENTKEY("Entry No.");
                                                CreateCustLedgEntry2.SETRANGE("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                                IF CreateCustLedgEntry2.FIND('-') THEN
                                                    InsertTempRecords(CreateCustLedgEntry2, DtldCustLedgEntry2, Amt);
                                            END;
                                        UNTIL DtldCustLedgEntry2.NEXT = 0;
                                END ELSE BEGIN
                                    CreateCustLedgEntry2.SETCURRENTKEY("Entry No.");
                                    CreateCustLedgEntry2.SETRANGE("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                                    IF CreateCustLedgEntry2.FIND('-') THEN
                                        InsertTempRecords(CreateCustLedgEntry2, DtldCustLedgEntry1, Amt);
                                END;
                            UNTIL DtldCustLedgEntry1.NEXT = 0;
                    END;
                    AdvAmount := 0;
                    ColumnNo := 1;
                    GSTAmount := 0;
                    DetailedGSTLedgerEntry3.RESET;
                    DetailedGSTLedgerEntry3.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry3.SETRANGE("Entry Type", "Entry Type"::Application);
                    DetailedGSTLedgerEntry3.SETRANGE("Posting Date", FromDate, ToDate);
                    DetailedGSTLedgerEntry3.SETFILTER("GST Component Code", '%1|%2', 'CGST', 'IGST');
                    DetailedGSTLedgerEntry3.SETFILTER("Document Type", '%1', "Detailed GST Ledger Entry"."Document Type"::Payment); //Added Abhishek 01-15-18
                    IF DetailedGSTLedgerEntry3.FINDSET THEN
                        REPEAT
                            AdvAmount += DetailedGSTLedgerEntry3."GST Base Amount";
                            GSTAmount += DetailedGSTLedgerEntry3."GST Amount";
                        UNTIL DetailedGSTLedgerEntry3.NEXT = 0;


                    //Added Abhishek 15/01/18
                    //IF NOT Flag THEN
                    IF Cnt > 0 THEN
                        IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                            IF ExportJnlVoucherData THEN BEGIN
                                TempCustLedgerEntry.RESET;
                                IF TempCustLedgerEntry.FINDFIRST THEN BEGIN
                                    REPEAT
                                        GSTPer := 0;


                                        CLE.RESET;
                                        CLE.SETFILTER("Document Type", '%1|%2', CLE."Document Type"::Payment, CLE."Document Type"::"Credit Memo");
                                        CLE.SETRANGE("Document No.", TempCustLedgerEntry."Document No.");
                                        IF CLE.FINDFIRST THEN
                                            IF "GST Component Code" = 'CGST' THEN
                                                GSTPer := 2 * "GST %"
                                            ELSE
                                                GSTPer := "GST %";

                                        //         AdvAmount += (TempCustLedgerEntry."Receipt Amount" / (100 + GSTPer ))*100;
                                        //         TotalAmt+=TempCustLedgerEntry."Receipt Amount";
                                        GSTAmount := TotalAmt - AdvAmount;
                                    UNTIL TempCustLedgerEntry.NEXT = 0;
                                END;

                                IF AdvAmount = 0 THEN
                                    CurrReport.SKIP;

                                RowNo += 1;
                                CLE.RESET;
                                CLE.SETRANGE("Entry No.", DetailGstLedgInfo."CLE/VLE Entry No.");
                                IF CLE.FINDFIRST THEN;

                                EnterCell(RowNo, ColumnNo, FORMAT("Location  Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT('Add'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                IF (CLE."Document Type" = CLE."Document Type"::Refund) OR (CLE.Reversed) THEN
                                    EnterCell(RowNo, ColumnNo, FORMAT('Refund'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                                ELSE
                                    EnterCell(RowNo, ColumnNo, FORMAT('Receipt'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);

                                ColumnNo += 1;
                                IF "Reverse Charge" THEN
                                    EnterCell(RowNo, ColumnNo, FORMAT('Y'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer)
                                ELSE
                                    EnterCell(RowNo, ColumnNo, FORMAT('N'), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;

                                EnterCell(RowNo, ColumnNo, "Document No.", FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT("Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempJnlVoucherExcelBuffer."Cell Type"::Date, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, CLE."External Document No.", FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempJnlVoucherExcelBuffer."Cell Type"::Date, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT(ROUND(AdvAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                IF "GST Component Code" = 'CGST' THEN
                                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND(2 * "GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer)
                                ELSE
                                    EnterCell(RowNo, ColumnNo, FORMAT(ROUND("GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                IF "GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmount := GSTAmount;
                                    CLEAR(CGSTAmount);
                                    CLEAR(SGSTAmount);
                                END ELSE BEGIN
                                    CGSTAmount := GSTAmount;
                                    SGSTAmount := GSTAmount;
                                    CLEAR(IGSTAmount);
                                END;
                                EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(IGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(CGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(SGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ECessAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Number, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                //state Code
                                CLEAR(State2);
                                CLEAR(StateCode);
                                //16225 field N/F Start
                                /* IF "Buyer/Seller State Code" <> '' THEN
                                  IF State2.GET("Buyer/Seller State Code") THEN
                                    StateCode := State2."State Code (GST Reg. No.)";*///16225 field N/F End
                                                                                      //State Code

                                EnterCell(RowNo, ColumnNo, FORMAT(StateCode), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;

                                EnterCell(RowNo, ColumnNo, 'Normal', FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                EnterCell(RowNo, ColumnNo, FORMAT("Buyer/Seller Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                                ColumnNo += 1;
                                IF Customer2.GET(CLE."Customer No.") THEN;
                                EnterCell(RowNo, ColumnNo, FORMAT(Customer2.Name), FALSE, FALSE, FALSE, FALSE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
                            END;
                        END;
                END;
                DocNo := "Document No.";
                OriginalDocNo := DetailGstLedgInfo."Original Doc. No.";//16225
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                IF ExportJnlVoucherData THEN BEGIN
                    // TempJnlVoucherExcelBuffer.CreateBook(VoucherExportDataTxt,VoucherExportDataTxt);
                    //TempJnlVoucherExcelBuffer.WriteSheet(VoucherExportDataTxt,COMPANYNAME,USERID);
                    // TempJnlVoucherExcelBuffer.CreateBookAndOpenExcel('', VoucherExportDataTxt, '', COMPANYNAME, USERID);
                    TempJnlVoucherExcelBuffer.CreateNewBook(VoucherExportDataTxt);//16767
                    TempJnlVoucherExcelBuffer.WriteSheet(VoucherExportDataTxt, CompanyName, UserId);//16767
                    TempJnlVoucherExcelBuffer.CloseBook;
                    TempJnlVoucherExcelBuffer.SetFriendlyFilename(StrSubstNo(VoucherExportDataTxt, CurrentDateTime, UserId));//16767
                    TempJnlVoucherExcelBuffer.OpenExcel;//16767
                    //TempJnlVoucherExcelBuffer.OpenExcel;
                    /// TempJnlVoucherExcelBuffer.GiveUserControl;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT ExportJnlVoucherData THEN
                    CurrReport.SKIP;

                SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
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
                field(ExportB2bData; ExportB2bData)
                {
                    Caption = 'Export B2B Data';
                    ApplicationArea = All;
                }
                field(ExportGstExportData; ExportGstExportData)
                {
                    Caption = 'Export Gst Export Data';
                    ApplicationArea = All;
                }
                field(ExportCrNoteData; ExportCrNoteData)
                {
                    Caption = 'Export Cr. Note Data';
                    ApplicationArea = All;
                }
                field(ExportJnlVoucherData; ExportJnlVoucherData)
                {
                    Caption = 'Export Journal Voucher Data';
                    ApplicationArea = All;
                }
                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
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

    trigger OnPreReport()
    begin
        IF (FromDate = 0D) OR (ToDate = 0D) THEN
            ERROR(DateRangeError);
    end;

    var
        TempB2bExcelBuffer: Record "Excel Buffer" temporary;
        TempCrNoteExcelBuffer: Record "Excel Buffer" temporary;
        TempJnlVoucherExcelBuffer: Record "Excel Buffer" temporary;
        TempExportExcelBuffer: Record "Excel Buffer" temporary;
        Customer: Record Customer;
        Vendor: Record Vendor;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        DetailGstLedgerEntryInfo: Record "Detailed GST Ledger Entry Info";
        Location: Record Location;
        GlobalDocumentType: Option " ",Payment,Invoice,"Credit Memo",,,,Refund;
        GlobalTransactionType: Option Purchase,Sales,Transfer,Settlement;
        RowNo: Integer;
        B2bRowNo: Integer;
        GSTExportRowNo: Integer;
        CrNoteRowNo: Integer;
        VoucherRowNo: Integer;
        ColumnNo: Integer;
        SalesDataItemRunning: Boolean;
        PurchDataItemRunning: Boolean;
        DetGstLedgEntryInfo: Record "Detailed GST Ledger Entry Info";
        TransferDataItemRunning: Boolean;
        ExportB2bData: Boolean;
        ExportGstExportData: Boolean;
        ExportCrNoteData: Boolean;
        ExportJnlVoucherData: Boolean;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        ECessAmount: Decimal;
        ServerFileName: Text;
        FromDate: Date;
        ToDate: Date;
        Text001: Label 'Exporting Document  #1########## @2@@@@@@@@@@@@@';
        B2bInvoiceDataTxt: Label 'B2B_B2Cs_B2Cl_Revised';
        GSTExportDataTxt: Label 'Export';
        gstr1_CDNTxt: Label 'gstr1_CDN';
        VoucherExportDataTxt: Label 'GSTR1_voucher';
        SupplierGSTINTxt: Label 'Supplier GSTIN';
        InvoiceStatusTxt: Label 'Invoice Status';
        SupplyTypeTxt: Label 'Supply Type';
        InvoiceNoTxt: Label 'Invoice No.';
        InvoiceDateTxt: Label 'Invoice Date';
        OriginalInvoiceNumberTxt: Label 'Original Invoice Number';
        OriginalInvoiceDateTxt: Label 'Original Invoice Date';
        InvoiceValueTxt: Label 'Invoice Value';
        HSNSACTxt: Label 'HSN/SAC';
        ItemDescriptionTxt: Label 'Item Description';
        QuantityTxt: Label 'Quantity';
        UQCUnitofMeasureTxt: Label 'UQC (Unit of Measure)';
        TaxableValueTxt: Label 'Taxable Value';
        GSTRateTxt: Label 'GST Rate';
        IGSTAmountTxt: Label 'IGST Amount';
        CGSTAmountTxt: Label 'CGST Amount';
        SGSTUTGSTAmountTxt: Label 'SGST/UTGST Amount';
        CESSAmountTxt: Label 'CESS Amount';
        ReverseChargeTxt: Label 'Reverse Charge';
        SalethroughECommerceOperatorYNTxt: Label 'Sale through E-Commerce Operator (Y/N)';
        ETINTxt: Label 'E-TIN';
        CustomerGSTINTxt: Label 'Customer GSTIN';
        CustomerNameTxt: Label 'Customer Name';
        PlaceofSupplyTxt: Label 'Place of Supply';
        DateRangeError: Label 'From and To Date must not be blank.';
        ExportTypeTxt: Label 'Export Type';
        ReceiverGSTINTxt: Label 'Receiver GSTIN';
        ReceiverNameTxt: Label 'Receiver Name';
        ShippingBillNumberTxt: Label 'Shipping Bill Number';
        ShippingBillDateTxt: Label 'Shipping Bill Date';
        PortNumberTxt: Label 'Port Number';
        NoteStatusTxt: Label 'Note Status';
        PreGstTxt: Label 'Pre-GST';
        BuyerTypeTxt: Label 'Buyer Type';
        NoteNumberTxt: Label 'Note Number';
        NoteDateTxt: Label 'Note Date';
        OriginalNoteNumberTxt: Label 'Original Note Number';
        OriginalNoteDateTxt: Label 'Original Note Date';
        NoteValueTxt: Label 'Note Value';
        NoteTypeTxt: Label 'Note Type';
        BuyerGSTINTxt: Label 'Buyer GSTIN';
        BuyerNameTxt: Label 'Buyer Name';
        NoteReasonTxt: Label 'Note Reason';
        InvoiceTypeTxt: Label 'Invoice Type';
        DetailedGSTLedgerEntry2: Record "Detailed GST Ledger Entry";
        VoucherStatusTxt: Label 'Voucher Status';
        VoucherTypeTxt: Label 'Voucher Type';
        VoucherNoTxt: Label 'Voucher Number';
        VoucherDateTxt: Label 'Voucher Date';
        OriginalVoucherNoTxt: Label 'Original Voucher No.';
        OriginalVoucherDateTxt: Label 'Original Voucher Date';
        VoucherValueTxt: Label 'Voucher Value';
        GrAdvanceReceivedAdjustedTxt: Label 'Gross Advance Received/Adjusted';
        CLE: Record "Cust. Ledger Entry";
        StateCode: Code[10];
        State2: Record State;
        StateCode2: Code[10];
        DetailedGSTLedgerEntry3: Record "Detailed GST Ledger Entry";
        Customer2: Record Customer;
        DetailedGSTLedgerEntry4: Record "Detailed GST Ledger Entry";
        DetailedGSTLedgerEntry5: Record "Detailed GST Ledger Entry";
        DetailedGSTLedgerEntry6: Record "Detailed GST Ledger Entry";
        DocNo: Code[20];
        OriginalDocNo: Code[20];
        AdvAmount: Decimal;
        CounterTotal: Integer;
        Window: Dialog;
        Counter: Integer;
        GSTPer: Decimal;
        GSTAmount: Decimal;
        DCLE: Record "Detailed Cust. Ledg. Entry";
        TotalAmt: Decimal;
        TempCustLedgerEntry: Record "Cust. Ledger Entry" temporary;
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        CreateCustLedgEntry2: Record "Cust. Ledger Entry";
        Amt: Decimal;
        Flag: Boolean;
        Cnt: Integer;
        CreateCustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntryGSTNo: Record "Cust. Ledger Entry";

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; DoubleUnderLine: Boolean; Format: Text[30]; CellType: Option; var TempExcelBuffer: Record "Excel Buffer" temporary)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        //IF DoubleUnderLine = TRUE THEN BEGIN
        //  TempExcelBuffer."Double Underline" := TRUE;
        //  TempExcelBuffer.Underline := FALSE;
        //END ELSE BEGIN
        //  TempExcelBuffer."Double Underline" := FALSE;
        //  TempExcelBuffer.Underline := UnderLine;
        //END;
        TempExcelBuffer.NumberFormat := Format;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.INSERT;
    end;

    local procedure PrePareB2bHeading()
    begin
        EnterCell(RowNo, ColumnNo, SupplierGSTINTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceStatusTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SupplyTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceNoTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalInvoiceNumberTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalInvoiceDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceValueTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, HSNSACTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ItemDescriptionTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, QuantityTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, UQCUnitofMeasureTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, TaxableValueTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, GSTRateTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, IGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SGSTUTGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CESSAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ReverseChargeTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SalethroughECommerceOperatorYNTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ETINTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CustomerGSTINTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CustomerNameTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, PlaceofSupplyTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
        B2bRowNo := RowNo;
    end;

    local procedure PrePareExportHeading()
    begin
        EnterCell(RowNo, ColumnNo, SupplierGSTINTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceStatusTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceNoTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ExportTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalInvoiceNumberTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalInvoiceDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceValueTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SupplyTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, HSNSACTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ItemDescriptionTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, QuantityTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, UQCUnitofMeasureTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, TaxableValueTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, GSTRateTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, IGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, PlaceofSupplyTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ReceiverGSTINTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ReceiverNameTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ShippingBillNumberTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ShippingBillDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, PortNumberTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CESSAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        ColumnNo += 1;

        GSTExportRowNo := RowNo;
    end;

    local procedure PrePareCrNoteHeading()
    begin
        EnterCell(RowNo, ColumnNo, SupplierGSTINTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, 'Note Status', TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, PreGstTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceNoTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, NoteNumberTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, NoteDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SupplyTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalNoteNumberTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalNoteDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, NoteValueTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, NoteTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, HSNSACTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ItemDescriptionTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, QuantityTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, UQCUnitofMeasureTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, TaxableValueTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, GSTRateTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, IGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SGSTUTGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CESSAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, BuyerGSTINTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, BuyerNameTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, PlaceofSupplyTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, InvoiceTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, NoteReasonTxt, TRUE, FALSE, TRUE, TRUE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        CrNoteRowNo := RowNo;
    end;

    local procedure PrePareVoucherHeading()
    begin
        EnterCell(RowNo, ColumnNo, 'Supplier GSTIN', TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, VoucherStatusTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, VoucherTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, ReverseChargeTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, VoucherNoTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, VoucherDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalVoucherNoTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, OriginalVoucherDateTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, 'Gross Adv Receiced (excluding tax)', TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, 'Gross Adv Adjusted(excluding tax)', TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, GSTRateTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, IGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SGSTUTGSTAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, CESSAmountTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, PlaceofSupplyTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, SupplyTypeTxt, TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, 'Customer GSTIN', TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);
        ColumnNo += 1;
        EnterCell(RowNo, ColumnNo, 'Customer Name', TRUE, FALSE, TRUE, TRUE, '', TempJnlVoucherExcelBuffer."Cell Type"::Text, TempJnlVoucherExcelBuffer);


        VoucherRowNo := RowNo;
    end;

    local procedure GetGSTCompAmount(DocumentNo: Code[20]; DocumentLineNo: Integer; DocumentType: Option " ",Payment,Invoice,"Credit Memo",,,,Refund; TransactionType: Option Purchase,Sales,Transfer,Settlement; var CGSTAmount: Decimal; var SGSTAmount: Decimal; var IGSTAmount: Decimal; var ECessAmount: Decimal)
    var
        DtldGSTLedgEntryComp: Query "Dtld. GST Ledg. Entry Comp";
    begin
        CGSTAmount := 0;
        IGSTAmount := 0;
        SGSTAmount := 0;
        ECessAmount := 0;
        DtldGSTLedgEntryComp.SETFILTER(Document_No, DocumentNo);
        DtldGSTLedgEntryComp.SETFILTER(Document_Line_No, '%1', DocumentLineNo);
        DtldGSTLedgEntryComp.SETFILTER(Source_Type, 'Customer');
        DtldGSTLedgEntryComp.SETFILTER(Document_Type, FORMAT(DocumentType));
        DtldGSTLedgEntryComp.SETFILTER(Transaction_Type, FORMAT(TransactionType));
        DtldGSTLedgEntryComp.OPEN;
        WHILE DtldGSTLedgEntryComp.READ DO BEGIN
            IF DtldGSTLedgEntryComp.GST_Component_Code = 'IGST' THEN
                IGSTAmount := DtldGSTLedgEntryComp.Sum_GST_Amount;
            IF DtldGSTLedgEntryComp.GST_Component_Code = 'CGST' THEN
                CGSTAmount := DtldGSTLedgEntryComp.Sum_GST_Amount;
            IF DtldGSTLedgEntryComp.GST_Component_Code = 'SGST' THEN
                SGSTAmount := DtldGSTLedgEntryComp.Sum_GST_Amount;
        END;
    end;

    local procedure EnterB2bRowData()
    var
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";

    begin
        //ALLE_ABHISHEK 28/09/18
        CustLedgEntryGSTNo.RESET;
        CustLedgEntryGSTNo.SETRANGE("Document Type", CustLedgEntryGSTNo."Document Type"::Invoice);
        CustLedgEntryGSTNo.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        IF NOT CustLedgEntryGSTNo.FINDFIRST THEN
            CustLedgEntryGSTNo.INIT;
        //ALLE_ABHISHEK 28/09/18
        //16225 AmtCust Code//
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
            until RecDGLE.Next() = 0;//16225 AmtCust Code//End

        END;

        ColumnNo := 1;
        WITH "Sales Invoice Line" DO BEGIN
            TotalAmount += "Sales Invoice Line"."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmount;//16225
            IF B2bRowNo = 0 THEN
                B2bRowNo := RowNo;
            B2bRowNo += 1;
            RowNo := B2bRowNo;
            EnterCell(RowNo, ColumnNo, FORMAT(Location."GST Registration No."), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('Add'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::"Deemed Export" THEN
                EnterCell(RowNo, ColumnNo, FORMAT('Exempted'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('Normal'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Document No."), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempB2bExcelBuffer."Cell Type"::Date, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Sales Invoice Header"."External Document No."), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            //16225 EnterCell(RowNo, ColumnNo, FORMAT(ROUND("Amount To Customer", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(TotalAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("HSN/SAC Code"), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(Description), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(Quantity, 0.001, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('OTH'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            //16225  EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS("GST Base Amount"), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(GSTBaseAmt), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            //16225   EnterCell(RowNo, ColumnNo, FORMAT(ROUND("GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(GSTPer, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            GetGSTCompAmount("Document No.", "Line No.", GlobalDocumentType::Invoice, GlobalTransactionType::Sales, CGSTAmount, SGSTAmount, IGSTAmount, ECessAmount);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(IGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(CGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(SGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ECessAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Number, TempB2bExcelBuffer);
            ColumnNo += 1;
            DetailedGSTLedgerEntry.SETRANGE("Document Type", GlobalDocumentType::Invoice);
            DetailedGSTLedgerEntry.SETRANGE("Transaction Type", GlobalTransactionType::Sales);
            DetailedGSTLedgerEntry.SETRANGE("Source Type", DetailedGSTLedgerEntry."Source Type"::Customer);
            IF DetailedGSTLedgerEntry.FINDFIRST THEN;
            DetailGstLedgerEntryInfo.Get(DetailedGSTLedgerEntry."Entry No.");//16225

            IF DetailedGSTLedgerEntry."Reverse Charge" THEN
                EnterCell(RowNo, ColumnNo, FORMAT('Y'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('N'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            //16225 field N/F Start
            //16225 IF DetailedGSTLedgerEntry."e-Comm. Merchant Id" <> '' THEN
            IF DetailGstLedgerEntryInfo."e-Comm. Merchant Id" <> '' THEN
                EnterCell(RowNo, ColumnNo, FORMAT('Y'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('N'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(DetailGstLedgerEntryInfo."e-Comm. Operator GST Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            //16225 EnterCell(RowNo,ColumnNo,FORMAT(DetailedGSTLedgerEntry."e-Comm. Operator GST Reg. No."),FALSE,FALSE,FALSE,FALSE,'',TempB2bExcelBuffer."Cell Type"::Text,TempB2bExcelBuffer);
            ColumnNo += 1;
            //ALLE_ABHISHEK 28/09/18
            //EnterCell(RowNo,ColumnNo,FORMAT(Customer."GST Registration No."),FALSE,FALSE,FALSE,FALSE,'',TempB2bExcelBuffer."Cell Type"::Text,TempB2bExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(CustLedgEntryGSTNo."Seller GST Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            //ALLE_ABHISHEK 28/09/18
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Sales Invoice Header"."Bill-to Name"), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(StateCode), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);
            ColumnNo += 1;
            IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::"Deemed Export" THEN
                EnterCell(RowNo, ColumnNo, FORMAT('DE'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('R'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempB2bExcelBuffer);

        END;
    end;

    local procedure EnterExportRowData()
    var
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
    begin
        //ALLE_ABHISHEK 28/09/18
        CustLedgEntryGSTNo.RESET;
        CustLedgEntryGSTNo.SETRANGE("Document Type", CustLedgEntryGSTNo."Document Type"::Invoice);
        CustLedgEntryGSTNo.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        IF NOT CustLedgEntryGSTNo.FINDFIRST THEN
            CustLedgEntryGSTNo.INIT;
        //ALLE_ABHISHEK 28/09/18

        //16225 AmtCust Code//
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
            until RecDGLE.Next() = 0;//16225 AmtCust Code//End

        END;



        ColumnNo := 1;
        WITH "Sales Invoice Line" DO BEGIN
            TotalAmount += "Sales Invoice Line"."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmount;//16225
            IF GSTExportRowNo = 0 THEN
                GSTExportRowNo := RowNo;
            GSTExportRowNo += 1;
            RowNo := GSTExportRowNo;
            EnterCell(RowNo, ColumnNo, FORMAT(Location."GST Registration No."), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('Add'), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Document No."), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('WOPAY'), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempExportExcelBuffer."Cell Type"::Date, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            //16225  EnterCell(RowNo, ColumnNo, FORMAT(ROUND("Amount To Customer", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(TotalAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            ColumnNo += 1;
            IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::"Deemed Export" THEN
                EnterCell(RowNo, ColumnNo, FORMAT('Exempted'), FALSE, FALSE, FALSE, FALSE, '', TempB2bExcelBuffer."Cell Type"::Text, TempExportExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('Normal'), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("HSN/SAC Code"), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(Description), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(Quantity, 0.001, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('OTH'), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            //16225   EnterCell(RowNo, ColumnNo, FORMAT(ROUND("Amount To Customer", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(TotalAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            ColumnNo += 1;
            //16225    EnterCell(RowNo, ColumnNo, FORMAT(ROUND("GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(GSTPer, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            ColumnNo += 1;
            GetGSTCompAmount("Document No.", "Line No.", GlobalDocumentType::Invoice, GlobalTransactionType::Sales, CGSTAmount, SGSTAmount, IGSTAmount, ECessAmount);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(IGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Number, TempExportExcelBuffer);
            ColumnNo += 1;
            IF StateCode <> '' THEN
                EnterCell(RowNo, ColumnNo, FORMAT(StateCode), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('97'), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            //ALLE_ABHISHEK 28/09/18
            //EnterCell(RowNo,ColumnNo,FORMAT(Customer."GST Registration No."),FALSE,FALSE,FALSE,FALSE,'',TempExportExcelBuffer."Cell Type"::Text,TempExportExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(CustLedgEntryGSTNo."Seller GST Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            //ALLE_ABHISHEK 28/09/18
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Sales Invoice Header"."Bill-to Name"), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempExportExcelBuffer."Cell Type"::Date, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Sales Invoice Header"."Location Code"), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempExportExcelBuffer."Cell Type"::Text, TempExportExcelBuffer);
        END;
    end;

    local procedure EnterCrNoteRowData()
    var
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
    begin
        //ALLE_ABHISHEK 28/09/18
        CustLedgEntryGSTNo.RESET;
        CustLedgEntryGSTNo.SETRANGE("Document Type", CustLedgEntryGSTNo."Document Type"::"Credit Memo");
        CustLedgEntryGSTNo.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        IF NOT CustLedgEntryGSTNo.FINDFIRST THEN
            CustLedgEntryGSTNo.INIT;
        //ALLE_ABHISHEK 28/09/18
        //16225 AmtCust Code//
        IGSTAmt := 0;
        IGSTper := 0;
        SGSTAmt := 0;
        SGSTper := 0;
        CGSTAmt := 0;
        CGSTper := 0;
        GSTBaseAmt := 0;
        TotalAmount := 0;

        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'IGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                IGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;


        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");

        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'SGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                SGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;
        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'CGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                CGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;


        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'CGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            repeat
                GSTBaseAmt += abs(RecDGLE."GST Base Amount");
            until RecDGLE.next = 0;
        END;
        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'IGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            repeat
                GSTBaseAmt += abs(RecDGLE."GST Base Amount");
            until RecDGLE.Next() = 0;//16225 AmtCust Code//End

        END;


        ColumnNo := 1;
        WITH "Sales Cr.Memo Line" DO BEGIN
            TotalAmount := "Sales Cr.Memo Line"."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;//16225
            IF CrNoteRowNo = 0 THEN
                CrNoteRowNo := RowNo;
            CrNoteRowNo += 1;
            RowNo := CrNoteRowNo;
            /*
            DetailedGSTLedgerEntry2.SETRANGE("Document No.","Sales Cr.Memo Line"."Document No.");
            DetailedGSTLedgerEntry2.SETRANGE("Document Type",GlobalDocumentType::"Credit Memo");
            DetailedGSTLedgerEntry2.SETRANGE("Transaction Type",GlobalTransactionType::Sale);
            DetailedGSTLedgerEntry2.SETRANGE("Source Type",DetailedGSTLedgerEntry2."Source Type"::Customer);
            IF DetailedGSTLedgerEntry2.FINDFIRST THEN;
            */
            EnterCell(RowNo, ColumnNo, FORMAT(Location."GST Registration No."), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('Add'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;

            IF FORMAT("Posting Date") > '01/07/17' THEN
                EnterCell(RowNo, ColumnNo, FORMAT('N'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer)
            ELSE
                EnterCell(RowNo, ColumnNo, FORMAT('Y'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;

            IF "Sales Cr.Memo Header"."External Document No." <> '' THEN
                EnterCell(RowNo, ColumnNo, FORMAT("Sales Cr.Memo Header"."External Document No."), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            // ELSE
            // EnterCell(RowNo,ColumnNo,FORMAT("Sales Cr.Memo Header"."Applied Invoice"),FALSE,FALSE,FALSE,FALSE,'',TempCrNoteExcelBuffer."Cell Type"::Text,TempCrNoteExcelBuffer);

            CustLedgEntry.RESET;
            CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
            //CustLedgEntry.SETRANGE("Document No.","Sales Cr.Memo Header"."Applied Invoice");
            IF NOT CustLedgEntry.FINDFIRST THEN
                CustLedgEntry.INIT;

            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(CustLedgEntry."Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempCrNoteExcelBuffer."Cell Type"::Date, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Document No."), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Posting Date"), FALSE, FALSE, FALSE, FALSE, 'dd/mm/yyyy', TempCrNoteExcelBuffer."Cell Type"::Date, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('Normal'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(''), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            //16225 EnterCell(RowNo, ColumnNo, FORMAT(ROUND("Amount To Customer"s, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer)
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(TotalAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);

            ColumnNo += 1;
            // IF "Sales Cr.Memo Header"."GST Customer Type" = "Sales Cr.Memo Header"."GST Customer Type" :: Registered THEN
            EnterCell(RowNo, ColumnNo, FORMAT('C'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            // ELSE
            //   EnterCell(RowNo,ColumnNo,FORMAT('CNUR'),FALSE,FALSE,FALSE,FALSE,'',TempCrNoteExcelBuffer."Cell Type"::Text,TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("HSN/SAC Code"), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(Description), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(Quantity, 0.001, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT('OTH'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            //16225  EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS("GST Base Amount"), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(GSTBaseAmt), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            //16225    EnterCell(RowNo, ColumnNo, FORMAT(ROUND("GST %", 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(GSTPer, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            GetGSTCompAmount("Document No.", "Line No.", GlobalDocumentType::"Credit Memo", GlobalTransactionType::Sales, CGSTAmount, SGSTAmount, IGSTAmount, ECessAmount);
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(IGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(CGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ABS(SGSTAmount), 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(ROUND(ECessAmount, 0.01, '=')), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Number, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            //ALLE_ABHISHEK 28/09/18
            //EnterCell(RowNo,ColumnNo,FORMAT(Customer."GST Registration No."),FALSE,FALSE,FALSE,FALSE,'',TempCrNoteExcelBuffer."Cell Type"::Text,TempCrNoteExcelBuffer);
            EnterCell(RowNo, ColumnNo, FORMAT(CustLedgEntryGSTNo."Seller GST Reg. No."), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            //ALLE_ABHISHEK 28/09/18
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT("Sales Cr.Memo Header"."Bill-to Name"), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            EnterCell(RowNo, ColumnNo, FORMAT(StateCode2), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;

            //Invoice Type Start
            IF (Customer."GST Registration No." <> '') AND (Location."GST Registration No." <> '') THEN
                EnterCell(RowNo, ColumnNo, FORMAT('B2B'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer)
            ELSE
                //16225 IF (("Sales Cr.Memo Header"."GST Bill-to State Code") <> ("Sales Cr.Memo Header"."Location State Code")) AND ("Amount To Customer" > 250000) THEN
                IF (("Sales Cr.Memo Header"."GST Bill-to State Code") <> ("Sales Cr.Memo Header"."Location State Code")) AND (TotalAmount > 250000) THEN
                    EnterCell(RowNo, ColumnNo, FORMAT('B2CL'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer)
                ELSE
                    //16225 IF ("Amount To Customer" < 250000) THEN
                    IF (TotalAmount < 250000) THEN
                        EnterCell(RowNo, ColumnNo, FORMAT('B2CS'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer)
                    ELSE
                        EnterCell(RowNo, ColumnNo, FORMAT('EXPWOP'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
            ColumnNo += 1;
            //Invoice Type End

            EnterCell(RowNo, ColumnNo, FORMAT('Others'), FALSE, FALSE, FALSE, FALSE, '', TempCrNoteExcelBuffer."Cell Type"::Text, TempCrNoteExcelBuffer);
        END;

    end;

    local procedure EnterVoucherRowData()
    begin
        /*
        ColumnNo :=1;
        
        //WITH "Sales Invoice Line" DO BEGIN
          IF VoucherRowNo = 0 THEN
            VoucherRowNo := RowNo;
          VoucherRowNo += 1;
          RowNo := VoucherRowNo;
        {
          CLE.RESET;
          CLE.SETRANGE("Document No.",DocNo);
          CLE.SETRANGE("Posting Date",PostingDate);
          IF CLE.FINDFIRST THEN;
        }
        DetailedGSTLedgerEntry3.RESET;
        //DetailedGSTLedgerEntry.SETRANGE("Document No.",DocNo);
        DetailedGSTLedgerEntry3.SETFILTER("Document Type",'%1|%2',GlobalDocumentType::Payment,GlobalDocumentType::Refund);
        DetailedGSTLedgerEntry3.SETRANGE("Transaction Type",GlobalTransactionType::Sales);
        DetailedGSTLedgerEntry3.SETRANGE("Source Type",DetailedGSTLedgerEntry3."Source Type"::Customer);
        IF DetailedGSTLedgerEntry3.FINDSET THEN REPEAT
        
          CLE.RESET;
          CLE.SETRANGE("Document No.",DetailedGSTLedgerEntry3."Document No.");
          CLE.SETRANGE("Posting Date",DetailedGSTLedgerEntry3."Posting Date");
          IF CLE.FINDFIRST THEN;
        
        
        
          EnterCell(RowNo,ColumnNo,FORMAT(Location."GST Registration No."),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(''),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          IF DetailedGSTLedgerEntry3."Document Type" = DetailedGSTLedgerEntry3."Document Type" :: Refund THEN
            EnterCell(RowNo,ColumnNo,FORMAT('Refund'),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer)
          ELSE
            EnterCell(RowNo,ColumnNo,FORMAT('Receipt'),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
        
          ColumnNo +=1;
          IF DetailedGSTLedgerEntry3."Reverse Charge" THEN
            EnterCell(RowNo,ColumnNo,FORMAT('Y'),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer)
          ELSE
            EnterCell(RowNo,ColumnNo,FORMAT('N'),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
        
          EnterCell(RowNo,ColumnNo,DetailedGSTLedgerEntry3."Document No.",FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(DetailedGSTLedgerEntry3."Posting Date"),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Date,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,CLE."External Document No.",FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(CLE."Document Date"),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(ROUND(ABS(CLE.Amount),0.01,'=')),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Number,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,'',FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(ROUND(DetailedGSTLedgerEntry3."GST %",0.01,'=')),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Number,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          GetGSTCompAmount(DetailedGSTLedgerEntry3."Document No.",DetailedGSTLedgerEntry3."Document Line No.",DetailedGSTLedgerEntry3."Document Type",GlobalTransactionType::Sales,CGSTAmount,SGSTAmount,IGSTAmount,ECessAmount);
          EnterCell(RowNo,ColumnNo,FORMAT(ROUND(ABS(IGSTAmount),0.01,'=')),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Number,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(ROUND(ABS(CGSTAmount),0.01,'=')),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Number,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(ROUND(ABS(SGSTAmount),0.01,'=')),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Number,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(ROUND(ECessAmount,0.01,'=')),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Number,TempJnlVoucherExcelBuffer);
          ColumnNo +=1;
          EnterCell(RowNo,ColumnNo,FORMAT(StateCode),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo += 1;
          //ALLE TJ
          //VendName := COPYSTR(Vendor.Name,1,11);
          {
          IF Customer."GST Customer Type" = Customer."GST Customer Type" :: non THEN
            SupplyType := 'Non GST'
          ELSE IF Customer."GST Customer Type" = Customer."GST Customer Type" :: Exempted THEN
            SupplyType := 'Exempted'
          ELSE
            SupplyType := 'Normal';
          }
          //ALLE TJ
        
          EnterCell(RowNo,ColumnNo,'Normal',FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo += 1;
          EnterCell(RowNo,ColumnNo,FORMAT(DetailedGSTLedgerEntry3."Buyer/Seller Reg. No."),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
          ColumnNo += 1;
          IF Customer2.GET(CLE."Customer No.") THEN;
          EnterCell(RowNo,ColumnNo,FORMAT(Customer2.Name),FALSE,FALSE,FALSE,FALSE,'',TempJnlVoucherExcelBuffer."Cell Type"::Text,TempJnlVoucherExcelBuffer);
        
        UNTIL DetailedGSTLedgerEntry3.NEXT = 0;
        */

    end;

    procedure InsertTempRecords(PassTempCustLedEntry: Record "Cust. Ledger Entry"; PassDetCustLedEntry: Record "Detailed Cust. Ledg. Entry"; var Amt: Decimal): Boolean
    begin
        Flag := FALSE;
        Amt := 0;

        WITH TempCustLedgerEntry DO BEGIN
            //SETRANGE("Document No.",PassDetCustLedEntry."Document No.");
            TempCustLedgerEntry.SETRANGE("Entry No.", PassTempCustLedEntry."Entry No.");
            IF NOT TempCustLedgerEntry.FINDFIRST THEN BEGIN
                IF (PassTempCustLedEntry."Posting Date" >= FromDate) AND (PassTempCustLedEntry."Posting Date" <= ToDate) THEN BEGIN
                    //CurrReport.SKIP;
                    Flag := TRUE;
                    EXIT(Flag);
                END;
                Amt := PassDetCustLedEntry."Amount (LCY)";
                TempCustLedgerEntry := PassTempCustLedEntry;
                //     TempCustLedgerEntry."Receipt Amount":=PassDetCustLedEntry."Amount (LCY)";
                TempCustLedgerEntry.INSERT;
                Cnt += 1;
            END;
        END;
    end;
}

