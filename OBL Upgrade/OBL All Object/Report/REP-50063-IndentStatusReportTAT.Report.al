report 50063 "Indent Status Report (TAT)"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Indent Line"; 50017)
        {
            CalcFields = "Authorization Date";
            DataItemTableView = SORTING(Date, "Location Code");
            RequestFilterFields = "Location Code";

            trigger OnAfterGetRecord()
            begin

                IF "Indent Line"."No." = '' THEN
                    CurrReport.SKIP;

                "Indent Line".CALCFIELDS("Authorization Date");
                "Indent Line".CALCFIELDS("Indent Line"."Header Status");

                IF ("Indent Line"."Header Status" = "Indent Line"."Header Status"::Authorized) AND ("Indent Line"."Authorization Date" <> 0D) THEN BEGIN

                    IF ("Indent Line"."Header Status" = "Indent Line"."Header Status"::Authorized) THEN BEGIN

                        //CASE "Indent Line".Date OF  //Rajiv0204
                        CASE "Indent Line"."Authorization Date" OF  //Rajiv0204
                            QYStart[1] .. QYEnd[1]:
                                BEGIN
                                    AuthorisedLines[1] += 1;
                                    IF (Date <> 0D) THEN BEGIN
                                        AvgAuthdays[1] += ("Authorization Date" - Date);
                                        AvgAuthLines[1] += 1;
                                    END;
                                    IF ("Order Date" <> 0D) THEN BEGIN
                                        AvgReleasePODays[1] += ("Order Date" - "Authorization Date");
                                        AvgReleasePOLines[1] += 1;
                                    END;
                                END;
                            QYStart[2] .. QYEnd[2]:
                                BEGIN
                                    AuthorisedLines[2] += 1;
                                    IF (Date <> 0D) THEN BEGIN
                                        AvgAuthdays[2] += ("Authorization Date" - Date);
                                        AvgAuthLines[2] += 1;
                                    END;
                                    IF ("Order Date" <> 0D) THEN BEGIN
                                        AvgReleasePODays[2] += ("Order Date" - "Authorization Date");
                                        AvgReleasePOLines[2] += 1;
                                    END;
                                END;
                            QYStart[3] .. QYEnd[3]:
                                BEGIN
                                    AuthorisedLines[3] += 1;
                                    IF (Date <> 0D) THEN BEGIN
                                        AvgAuthdays[3] += ("Authorization Date" - Date);
                                        AvgAuthLines[3] += 1;
                                    END;
                                    IF ("Order Date" <> 0D) THEN BEGIN
                                        AvgReleasePODays[3] += ("Order Date" - "Authorization Date");
                                        AvgReleasePOLines[3] += 1;
                                    END;
                                END;
                            QYStart[4] .. QYEnd[4]:
                                BEGIN
                                    AuthorisedLines[4] += 1;
                                    IF (Date <> 0D) THEN BEGIN
                                        AvgAuthdays[4] += ("Authorization Date" - Date);
                                        AvgAuthLines[4] += 1;
                                        // MESSAGE('%1 = %2',AvgAuthdays[4],AvgAuthLines[4]);
                                    END;
                                    IF ("Order Date" <> 0D) THEN BEGIN
                                        AvgReleasePODays[4] += ("Order Date" - "Authorization Date");
                                        AvgReleasePOLines[4] += 1;
                                    END;
                                END;
                        END;
                    END;

                    recPurchRcptLn.RESET;
                    recPurchRcptLn.SETCURRENTKEY("Indent No.", "Indent Line No.");
                    recPurchRcptLn.SETRANGE("Indent No.", "Document No.");
                    recPurchRcptLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                    IF recPurchRcptLn.FINDFIRST THEN BEGIN
                        recPurchRcptLn.CALCFIELDS("Posting Date Head");
                        REPEAT
                            IF (recPurchRcptLn."Indent Date" <> 0D) AND (recPurchRcptLn."Posting Date Head" <> 0D) AND (recPurchRcptLn."Indent No." <> '') THEN BEGIN
                                CASE recPurchRcptLn."Indent Date" OF
                                    QYStart[1] .. QYEnd[1]:
                                        BEGIN
                                            AvgwrtAuthDays[1] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Authorization Date");
                                            AvgwrtAuthLines[1] += 1;
                                            IF "Indent Line"."Order Date" <> 0D THEN BEGIN
                                                AvgwrtPODays[1] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Order Date");
                                            END;
                                            IF recPurchRcptLn.Quantity = Quantity THEN BEGIN
                                                FullyExecuted[1] += 1;
                                            END ELSE
                                                IF recPurchRcptLn.Quantity < Quantity THEN BEGIN
                                                    PartlyExecuted[1] += 1;
                                                END;
                                        END;
                                    QYStart[2] .. QYEnd[2]:
                                        BEGIN
                                            AvgwrtAuthDays[2] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Authorization Date");
                                            AvgwrtAuthLines[2] += 1;
                                            IF "Indent Line"."Order Date" <> 0D THEN BEGIN
                                                AvgwrtPODays[2] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Order Date");
                                            END;
                                            IF recPurchRcptLn.Quantity = Quantity THEN BEGIN
                                                FullyExecuted[2] += 1;
                                            END ELSE
                                                IF recPurchRcptLn.Quantity < Quantity THEN BEGIN
                                                    PartlyExecuted[2] += 1;
                                                END;
                                        END;
                                    QYStart[3] .. QYEnd[3]:
                                        BEGIN
                                            AvgwrtAuthDays[3] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Authorization Date");
                                            AvgwrtAuthLines[3] += 1;
                                            IF "Indent Line"."Order Date" <> 0D THEN BEGIN
                                                AvgwrtPODays[3] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Order Date");
                                            END;
                                            IF recPurchRcptLn.Quantity = Quantity THEN BEGIN
                                                FullyExecuted[3] += 1;
                                            END ELSE
                                                IF recPurchRcptLn.Quantity < Quantity THEN BEGIN
                                                    PartlyExecuted[3] += 1;
                                                END;
                                        END;
                                    QYStart[4] .. QYEnd[4]:
                                        BEGIN
                                            AvgwrtAuthDays[4] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Authorization Date");
                                            AvgwrtAuthLines[4] += 1;
                                            IF "Indent Line"."Order Date" <> 0D THEN BEGIN
                                                AvgwrtPODays[4] += (recPurchRcptLn."Posting Date Head" - "Indent Line"."Order Date");
                                            END;
                                            IF recPurchRcptLn.Quantity = Quantity THEN BEGIN
                                                FullyExecuted[4] += 1;
                                            END ELSE
                                                IF recPurchRcptLn.Quantity < Quantity THEN BEGIN
                                                    PartlyExecuted[4] += 1;
                                                END;
                                        END;
                                END;
                            END;
                        UNTIL recPurchRcptLn.NEXT = 0;
                    END;
                END;

                IF "Indent Line"."PO Qty" = 0 THEN BEGIN
                    //CASE Date OF //Rajiv0204
                    CASE "Indent Line"."Authorization Date" OF  //Rajiv0204
                        QYStart[1] .. QYEnd[1]:
                            BEGIN
                                NotPO[1] += 1;
                            END;
                        QYStart[2] .. QYEnd[2]:
                            BEGIN
                                NotPO[2] += 1;
                            END;
                        QYStart[3] .. QYEnd[3]:
                            BEGIN
                                NotPO[3] += 1;
                            END;
                        QYStart[4] .. QYEnd[4]:
                            BEGIN
                                NotPO[4] += 1;
                            END;
                    END;
                END;

                recPurchLn.RESET;
                recPurchLn.SETCURRENTKEY("Indent No.", "Indent Line No.");
                //recPurchLn.SETRANGE("Location Code",RecIndentLine."Location Code");
                recPurchLn.SETRANGE("Indent No.", "Document No.");
                recPurchLn.SETRANGE("Indent Line No.", "Line No.");
                IF recPurchLn.FINDFIRST THEN BEGIN
                    //CASE "Indent Line".Date OF  //Rajiv0204
                    CASE "Indent Line"."Authorization Date" OF  //Rajiv0204
                        QYStart[1] .. QYEnd[1]:
                            BEGIN
                                IF recPurchLn.Quantity = Quantity THEN
                                    FullyPO[1] += 1
                                ELSE
                                    IF recPurchLn.Quantity < Quantity THEN
                                        PartlyPO[1] += 1;
                            END;
                        QYStart[2] .. QYEnd[2]:
                            BEGIN
                                IF recPurchLn.Quantity = Quantity THEN
                                    FullyPO[2] += 1
                                ELSE
                                    IF recPurchLn.Quantity < Quantity THEN
                                        PartlyPO[2] += 1;
                            END;
                        QYStart[3] .. QYEnd[3]:
                            BEGIN
                                IF recPurchLn.Quantity = Quantity THEN
                                    FullyPO[3] += 1
                                ELSE
                                    IF recPurchLn.Quantity < Quantity THEN
                                        PartlyPO[3] += 1;
                            END;
                        QYStart[4] .. QYEnd[4]:
                            BEGIN
                                IF recPurchLn.Quantity = Quantity THEN
                                    FullyPO[4] += 1
                                ELSE
                                    IF recPurchLn.Quantity < Quantity THEN
                                        PartlyPO[4] += 1;
                            END;
                    END;
                END;

                //Rajiv 02042021>>>>
                IF RpDocumentNo <> "Indent Line"."Document No." THEN BEGIN
                    RecIndentHeader.RESET;
                    //RecIndentHeader.SETCURRENTKEY("Indent Date");
                    RecIndentHeader.SETRANGE("No.", "Indent Line"."Document No.");
                    RecIndentHeader.SETFILTER("Indent Date", '<>%1', 0D);
                    RecIndentHeader.SETFILTER("Validate Upto", '<>%1', 0D);
                    IF RecIndentHeader.FINDFIRST THEN BEGIN
                        CASE RecIndentHeader."Indent Date" OF
                            QYStart[1] .. QYEnd[1]:
                                BEGIN
                                    AvgExecDays[1] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                                    AvgExecLines[1] += 1;
                                END;
                            QYStart[2] .. QYEnd[2]:
                                BEGIN
                                    AvgExecDays[2] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                                    AvgExecLines[2] += 1;
                                END;
                            QYStart[3] .. QYEnd[3]:
                                BEGIN
                                    AvgExecDays[3] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                                    AvgExecLines[3] += 1;
                                END;
                            QYStart[4] .. QYEnd[4]:
                                BEGIN
                                    AvgExecDays[4] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                                    AvgExecLines[4] += 1;
                                END;
                        END;
                        recPurchRcptLn.RESET;
                        recPurchRcptLn.SETCURRENTKEY("Indent No.", "Indent Line No.");
                        recPurchRcptLn.SETRANGE("Indent No.", RecIndentHeader."No.");
                        IF recPurchRcptLn.FINDFIRST THEN BEGIN
                            recPurchRcptLn.CALCFIELDS("Posting Date Head");
                            IF (recPurchRcptLn."Indent Date" <> 0D) AND (recPurchRcptLn."Posting Date Head" <> 0D) AND (recPurchRcptLn."Indent No." <> '') THEN BEGIN
                                recPurchRcptHdr.RESET;
                                recPurchRcptHdr.SETCURRENTKEY("Posting Date");
                                recPurchRcptHdr.SETFILTER("No.", recPurchRcptLn."Document No.");
                                IF recPurchRcptHdr.FINDFIRST THEN BEGIN
                                    CASE recPurchRcptHdr."Posting Date" OF
                                        QYStart[1] .. QYEnd[1]:
                                            BEGIN
                                                AvgwrtNeedMRNDays[1] += (recPurchRcptLn."Posting Date" - RecIndentHeader."Validate Upto");
                                            END;
                                        QYStart[2] .. QYEnd[2]:
                                            BEGIN
                                                AvgwrtNeedMRNDays[2] += (recPurchRcptLn."Posting Date" - RecIndentHeader."Validate Upto");
                                            END;
                                        QYStart[3] .. QYEnd[3]:
                                            BEGIN
                                                AvgwrtNeedMRNDays[3] += (recPurchRcptLn."Posting Date" - RecIndentHeader."Validate Upto");
                                            END;
                                        QYStart[4] .. QYEnd[4]:
                                            BEGIN
                                                AvgwrtNeedMRNDays[4] += (recPurchRcptLn."Posting Date" - RecIndentHeader."Validate Upto");
                                            END;
                                    END;
                                END;
                            END;
                        END;
                        //END
                    END;
                END;
                RpDocumentNo := "Indent Line"."Document No.";

                //Rajiv 02042021<<<<

                //Rajiv 05042021>>>>
                RecIndentHeader.RESET;

                /*
                IF MRNDocNo <> "Indent Line"."Document No." THEN BEGIN
                  recPurchRcptLn.RESET;
                  recPurchRcptLn.SETCURRENTKEY("Indent Date");
                  recPurchRcptLn.SETRANGE("Indent No.","Document No.");
                  IF recPurchRcptLn.FINDFIRST THEN BEGIN
                    recPurchRcptLn.CALCFIELDS("Posting Date Head");
                    IF (recPurchRcptLn."Indent Date" <>0D) AND (recPurchRcptLn."Posting Date Head"<>0D) AND (recPurchRcptLn."Indent No."<>'' ) THEN BEGIN
                      recPurchRcptHdr.RESET;
                      recPurchRcptHdr.SETCURRENTKEY("Posting Date");
                      recPurchRcptHdr.SETFILTER("No.",recPurchRcptLn."Document No.");
                      IF recPurchRcptHdr.FINDFIRST THEN BEGIN
                          CASE recPurchRcptHdr."Posting Date" OF
                        QYStart[1]..QYEnd[1]:
                          BEGIN
                            AvgwrtNeedMRNDays[1] += FORMAT(recPurchRcptLn."Posting Date");
                          END;
                        QYStart[2]..QYEnd[2]:
                          BEGIN
                            AvgwrtNeedMRNDays[2] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                          END;
                        QYStart[3]..QYEnd[3]:
                          BEGIN
                            AvgwrtNeedMRNDays[3] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                          END;
                        QYStart[4]..QYEnd[4]:
                          BEGIN
                            AvgwrtNeedMRNDays[4] += (RecIndentHeader."Validate Upto" - RecIndentHeader."Indent Date");
                          END;
                       END;
                      END;
                    END;
                  END;
                END;
                MRNDocNo := "Indent Line"."Document No.";
                */

            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('%1 = %2',AvgExecDays[1],AvgExecLines[1]);
                ExcelData;
            end;

            trigger OnPreDataItem()
            begin
                "Indent Line".SETFILTER(Date, '%1..%2', QYStart[1], QYEnd[4]);
                //CLEAR(AuthorisedLines);
                "Indent Line".SETFILTER(Type, '%1', "Indent Line".Type::Item);
                "Indent Line".SETFILTER(Quantity, '<>%1', 0);
                "Indent Line".SETCURRENTKEY("Document No.");

                RpDocumentNo := '';
                MRNDocNo := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Select Date"; ReportDate)
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

    trigger OnPostReport()
    begin
        // ExcelBuffer.CreateBookAndOpenExcel('Indent Status', 'Indent Status Summary', 'Indent Status Report', COMPANYNAME, USERID);

        // TempExcelBuffer.CreateBookAndOpenExcel('GSTR1', 'GST Return', COMPANYNAME, USERID, '');
        //16225  TempExcelBuffer.GiveUserControl;
        ExcelBuffer.CreateNewBook('Indent Status Summary');
        ExcelBuffer.WriteSheet('Indent Status Report', COMPANYNAME, USERID);
        ExcelBuffer.SetFriendlyFilename('Indent Status');
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
    end;

    trigger OnPreReport()
    begin
        IF ReportDate = 0D THEN
            ERROR('Select Date !!!');

        IF ReportDate > 0D THEN
            Month := DATE2DMY(ReportDate, 2);

        intFyYearFrst := 0;
        intFyYearLst := 0;
        IF Month < 4 THEN BEGIN
            intFyYearLst := DATE2DMY(ReportDate, 3);
            intFyYearFrst := intFyYearLst - 1;
        END ELSE BEGIN
            intFyYearFrst := DATE2DMY(ReportDate, 3);
            intFyYearLst := intFyYearFrst + 1;
        END;

        ISQtr1 := FALSE;
        ISQtr2 := FALSE;
        ISQtr3 := FALSE;
        ISQtr4 := FALSE;

        QYStart[1] := 0D;
        QYEnd[1] := 0D;
        QYStart[2] := 0D;
        QYEnd[2] := 0D;
        QYStart[3] := 0D;
        QYEnd[3] := 0D;
        QYStart[4] := 0D;
        QYEnd[4] := 0D;

        QYStart[1] := DMY2DATE(1, 4, intFyYearFrst);
        QYEnd[1] := DMY2DATE(30, 6, intFyYearFrst);
        QYStart[2] := DMY2DATE(1, 7, intFyYearFrst);
        QYEnd[2] := DMY2DATE(30, 9, intFyYearFrst);
        QYStart[3] := DMY2DATE(1, 10, intFyYearFrst);
        QYEnd[3] := DMY2DATE(31, 12, intFyYearFrst);
        QYStart[4] := DMY2DATE(1, 1, intFyYearLst);
        QYEnd[4] := DMY2DATE(31, 3, intFyYearLst);

        //ExcelData;
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        ReportDate: Date;
        RecIndentLine: Record "Indent Line";
        RecIndentLine1: Record "Indent Line";
        RecIndentHeader: Record "Indent Header";
        AuthorisedLines: array[5] of Integer;
        FullyPO: array[5] of Integer;
        PartlyPO: array[5] of Integer;
        NotPO: array[5] of Integer;
        FullyExecuted: array[5] of Integer;
        PartlyExecuted: array[5] of Integer;
        AvgAuthdays: array[5] of Integer;
        AvgAuthLines: array[5] of Integer;
        AvgExecDays: array[5] of Integer;
        AvgExecLines: array[5] of Integer;
        AvgReleasePODays: array[5] of Integer;
        AvgReleasePOLines: array[5] of Integer;
        AvgwrtAuthDays: array[5] of Integer;
        AvgwrtAuthLines: array[5] of Integer;
        AvgwrtPODays: array[5] of Integer;
        PODaysTotal: array[5] of Integer;
        MRNDaysTotal: array[5] of Integer;
        AvgwrtNeedDays: array[5] of Integer;
        AvgwrtNeedMRNDays: array[5] of Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        StartDt: Date;
        EndDt: Date;
        intFyYearFrst: Integer;
        intFyYearLst: Integer;
        MnthTxt: Text[10];
        QYStart: array[5] of Date;
        QYEnd: array[5] of Date;
        recPurchLn: Record "Purchase Line";
        recPurchRcptLn: Record "Purch. Rcpt. Line";
        recPurchRcptHdr: Record "Purch. Rcpt. Header";
        ISQtr1: Boolean;
        ISQtr2: Boolean;
        ISQtr3: Boolean;
        ISQtr4: Boolean;
        RpDocumentNo: Text;
        check: Integer;
        MRNDocNo: Text;

    local procedure ExcelData()
    begin
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' Indent Status Report ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(' Item Code Selection ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' From:  ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYStart[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(' To: ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYEnd[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Details', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 1', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 2', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 3', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 4', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYStart[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYStart[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYStart[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYStart[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYEnd[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYEnd[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYEnd[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(QYEnd[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Number of indent lines Authorised', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(AuthorisedLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AuthorisedLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AuthorisedLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AuthorisedLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Number of indent lines converted to Purchase Order 100% ', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FullyPO[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(FullyPO[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(FullyPO[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(FullyPO[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Number of indent lines converted to Purchase Order Partly ', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PartlyPO[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PartlyPO[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PartlyPO[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PartlyPO[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Number of indent lines waiting for convertion to Purchase Order', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(NotPO[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(NotPO[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(NotPO[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(NotPO[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Number of indent lines executed 100%', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FullyExecuted[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(FullyExecuted[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(FullyExecuted[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(FullyExecuted[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Number of indent lines executed Partly', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PartlyExecuted[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PartlyExecuted[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PartlyExecuted[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PartlyExecuted[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Average # of days taken for authorising the indents ', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (AvgAuthdays[1] <> 0) AND (AvgAuthLines[1] > 0) THEN
            ExcelBuffer.AddColumn(AvgAuthdays[1] / AvgAuthLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgAuthdays[2] <> 0) AND (AvgAuthLines[2] > 0) THEN
            ExcelBuffer.AddColumn(AvgAuthdays[2] / AvgAuthLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgAuthdays[3] <> 0) AND (AvgAuthLines[3] > 0) THEN
            ExcelBuffer.AddColumn(AvgAuthdays[3] / AvgAuthLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgAuthdays[4] <> 0) AND (AvgAuthLines[4] > 0) THEN
            ExcelBuffer.AddColumn(AvgAuthdays[4] / AvgAuthLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Average # of days given for execution', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (AvgExecDays[1] <> 0) AND (AvgExecLines[1] > 0) THEN
            ExcelBuffer.AddColumn(AvgExecDays[1] / AvgExecLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgExecDays[2] <> 0) AND (AvgExecLines[2] > 0) THEN
            ExcelBuffer.AddColumn(AvgExecDays[2] / AvgExecLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgExecDays[3] <> 0) AND (AvgExecLines[3] > 0) THEN
            ExcelBuffer.AddColumn(AvgExecDays[3] / AvgExecLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgExecDays[4] <> 0) AND (AvgExecLines[4] > 0) THEN
            ExcelBuffer.AddColumn(AvgExecDays[4] / AvgExecLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Average # of days taken for releasing purchase order', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (AvgReleasePODays[1] <> 0) AND (AvgReleasePOLines[1] > 0) THEN
            ExcelBuffer.AddColumn(AvgReleasePODays[1] / AvgReleasePOLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgReleasePODays[2] <> 0) AND (AvgReleasePOLines[2] > 0) THEN
            ExcelBuffer.AddColumn(AvgReleasePODays[2] / AvgReleasePOLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgReleasePODays[3] <> 0) AND (AvgReleasePOLines[3] > 0) THEN
            ExcelBuffer.AddColumn(AvgReleasePODays[3] / AvgReleasePOLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgReleasePODays[4] <> 0) AND (AvgReleasePOLines[4] > 0) THEN
            ExcelBuffer.AddColumn(AvgReleasePODays[4] / AvgReleasePOLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Average # of days taken for execution w.r.t indent authorisation date', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (AvgwrtAuthDays[1] <> 0) AND (AvgwrtAuthLines[1] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtAuthDays[1] / AvgwrtAuthLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtAuthDays[2] <> 0) AND (AvgwrtAuthLines[2] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtAuthDays[2] / AvgwrtAuthLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtAuthDays[3] <> 0) AND (AvgwrtAuthLines[3] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtAuthDays[3] / AvgwrtAuthLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtAuthDays[4] <> 0) AND (AvgwrtAuthLines[4] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtAuthDays[4] / AvgwrtAuthLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Average # of days taken for execution w.r.t purchase order date', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (AvgwrtPODays[1] <> 0) AND (AvgwrtAuthLines[1] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtPODays[1] / AvgwrtAuthLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtPODays[2] <> 0) AND (AvgwrtAuthLines[2] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtPODays[2] / AvgwrtAuthLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtPODays[3] <> 0) AND (AvgwrtAuthLines[3] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtPODays[3] / AvgwrtAuthLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtPODays[4] <> 0) AND (AvgwrtAuthLines[4] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtPODays[4] / AvgwrtAuthLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Average # of days taken for execution w.r.t need date', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (AvgwrtNeedMRNDays[1] <> 0) AND (AvgExecLines[1] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtNeedMRNDays[1] / AvgExecLines[1], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtNeedMRNDays[2] <> 0) AND (AvgExecLines[2] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtNeedMRNDays[2] / AvgExecLines[2], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtNeedMRNDays[3] <> 0) AND (AvgExecLines[3] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtNeedMRNDays[3] / AvgExecLines[3], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        IF (AvgwrtNeedMRNDays[4] <> 0) AND (AvgExecLines[4] > 0) THEN
            ExcelBuffer.AddColumn(AvgwrtNeedMRNDays[4] / AvgExecLines[4], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
    end;

    local procedure CalcDays(Month: Integer) TotalDays: Integer
    begin
        CASE Month OF
            1, 3, 5, 7, 8, 10, 12:
                TotalDays := 31;

            4, 6, 9, 11:
                TotalDays := 30;

            2:
                TotalDays := 28;
        END;
    end;

    local procedure CalcMonth(Month: Integer) MonthText: Text[10]
    begin
        CASE Month OF
            1:
                MonthText := 'Jan';
            2:
                MonthText := 'Feb';
            3:
                MonthText := 'Mar';
            4:
                MonthText := 'April';
            5:
                MonthText := 'May';
            6:
                MonthText := 'June';
            7:
                MonthText := 'July';
            8:
                MonthText := 'Aug';
            9:
                MonthText := 'Sep';
            10:
                MonthText := 'Oct';
            11:
                MonthText := 'Nov';
            12:
                MonthText := 'Dec';
        END;
    end;

    local procedure QYCalc(QMonth: Integer) QM: Integer
    begin
        CASE QMonth OF
            4, 5, 6:
                QM := 1;

            7, 8, 9:
                QM := 2;

            10, 11, 12:
                QM := 3;

            1, 2, 3:
                QM := 4;
        END;
    end;
}

