report 50095 Check1111_AxisBank
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\Check1111AxisBank.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(VoidGenJnlLine; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                IF BankAccNo = '' THEN
                    IF VoidGenJnlLine."Bal. Account Type" = VoidGenJnlLine."Bal. Account Type"::"Bank Account" THEN
                        BankAccNo := VoidGenJnlLine."Bal. Account No."
                    ELSE
                        IF VoidGenJnlLine."Account Type" = VoidGenJnlLine."Account Type"::"Bank Account" THEN
                            BankAccNo := VoidGenJnlLine."Bal. Account No."
                        ELSE
                            ERROR('Please select Bank Code as the bank is not available in Line');



                IF EVALUATE(CheqNo, "Cheque No.") THEN
                    UseCheckNo := FORMAT(CheqNo - 1);
                IF UseCheckNo = '' THEN
                    ERROR(Text001);
                //monika

                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem()
            begin

                GGL.COPY(VoidGenJnlLine);
                IF TestPrint THEN
                    CurrReport.BREAK;

                IF NOT ReprintChecks THEN
                    CurrReport.BREAK;

                IF (GETFILTER("Line No.") <> '') OR (GETFILTER("Document No.") <> '') THEN
                    ERROR(
                      Text002, FIELDCAPTION("Line No."), FIELDCAPTION("Document No."));

                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", TRUE);
            end;
        }
        dataitem(GenJnlLine; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            dataitem(CheckPages; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                dataitem(PrintSettledLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    begin

                        IF NOT TestPrint THEN BEGIN
                            IF FoundLast THEN BEGIN
                                IF RemainingAmount <> 0 THEN BEGIN
                                    DocType := Text015;
                                    DocNo := '';
                                    LineAmount := RemainingAmount;
                                    LineAmount2 := RemainingAmount;
                                    LineDiscount := 0;
                                    RemainingAmount := 0;
                                END ELSE
                                    CurrReport.BREAK;
                            END ELSE BEGIN
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustLedgEntry.RESET;
                                                        CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                                                        CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                        CustLedgEntry.FIND('-');
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendLedgEntry.RESET;
                                                        VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                                                        VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                        VendLedgEntry.FIND('-');
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            FoundLast := TRUE;
                                        END;
                                    ApplyMethod::OneLineID:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                        FoundLast := (CustLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            CustLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT CustLedgEntry.FIND('-');
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                        FoundLast := (VendLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            VendLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT VendLedgEntry.FIND('-');
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        BEGIN
                                            CurrentLineAmount := GenJnlLine2.Amount;
                                            IF GenJnlLine2."Applies-to ID" <> '' THEN
                                                ERROR(
                                                  Text016 +
                                                  Text017);
                                            GenJnlLine2.TESTFIELD("Check Printed", FALSE);
                                            GenJnlLine2.TESTFIELD("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");

                                            IF GenJnlLine2."Applies-to Doc. No." = '' THEN BEGIN
                                                DocType := Text015;
                                                DocNo := '';
                                                LineAmount := CurrentLineAmount;
                                                LineDiscount := 0;
                                            END ELSE BEGIN
                                                CASE BalancingType OF
                                                    BalancingType::"G/L Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        END;
                                                    BalancingType::Customer:
                                                        BEGIN
                                                            CustLedgEntry.RESET;
                                                            CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                                                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                            CustLedgEntry.FIND('-');
                                                            CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::Vendor:
                                                        BEGIN
                                                            VendLedgEntry.RESET;
                                                            VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                                                            VendLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                            VendLedgEntry.FIND('-');
                                                            VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::"Bank Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        END;
                                                END;
                                            END;
                                            FoundLast := GenJnlLine2.NEXT = 0;
                                        END;
                                END;
                            END;

                            TotalLineAmount := TotalLineAmount + LineAmount2;
                            TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        END ELSE BEGIN
                            IF FoundLast THEN
                                CurrReport.BREAK;
                            FoundLast := TRUE;
                            DocType := Text018;
                            DocNo := Text010;
                            LineAmount := 0;
                            LineDiscount := 0;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin

                        IF NOT TestPrint THEN
                            IF FirstPage THEN BEGIN
                                FoundLast := TRUE;
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        FoundLast := FALSE;
                                    ApplyMethod::OneLineID:
                                        CASE BalancingType OF
                                            BalancingType::Customer:
                                                BEGIN
                                                    CustLedgEntry.RESET;
                                                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                                    CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                    CustLedgEntry.SETRANGE(Open, TRUE);
                                                    CustLedgEntry.SETRANGE(Positive, TRUE);
                                                    CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT CustLedgEntry.FIND('-');
                                                    IF FoundLast THEN BEGIN
                                                        CustLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT CustLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                            BalancingType::Vendor:
                                                BEGIN
                                                    VendLedgEntry.RESET;
                                                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                                    VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                    VendLedgEntry.SETRANGE(Open, TRUE);
                                                    VendLedgEntry.SETRANGE(Positive, TRUE);
                                                    VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT VendLedgEntry.FIND('-');
                                                    IF FoundLast THEN BEGIN
                                                        VendLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT VendLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        FoundLast := FALSE;
                                END;
                            END
                            ELSE
                                FoundLast := FALSE;
                    end;
                }
                dataitem(PrintCheck; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(AcPayee1; AcPayee[1])
                    {
                    }
                    column(AcPayee2; AcPayee[2])
                    {
                    }
                    column(Amt8; Amt[8])
                    {
                    }
                    column(Amt9; Amt[9])
                    {
                    }
                    column(Amt10; Amt[10])
                    {
                    }
                    column(Name3; Name[3])
                    {
                    }
                    column(Name4; Name[4])
                    {
                    }
                    column(Name5; Name[5])
                    {
                    }
                    column(AmtText6; AmtText[6])
                    {
                    }
                    column(AmtText7; AmtText[7])
                    {
                    }
                    column(AmtText18; AmtText[8])
                    {
                    }
                    column(AmtText8; AmtText1[8])
                    {
                    }
                    column(AmtText9; AmtText1[9])
                    {
                    }
                    column(Dt1; Dt[1])
                    {
                    }
                    column(Dt2; Dt[2])
                    {
                    }
                    column(Dt3; Dt[3])
                    {
                    }
                    column(Dt4; Dt[4])
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        NoText1: Text[250];
                        CheckReport: Report "Check Report";
                        NoText2: Text[250];
                        b: Integer;
                        NoTex: array[2] of Text[80];
                    begin

                        IF NOT TestPrint THEN BEGIN
                            CheckLedgEntry.INIT;
                            CheckLedgEntry."Bank Account No." := BankAccNo;
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document Type" := GenJnlLine."Document Type";
                            // NAVIN
                            CheckLedgEntry."Document No." := GenJnlLine."Document No.";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            // NAVIN
                            // 16630  CheckLedgEntry.Description := Narration;
                            CheckLedgEntry."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
                            CheckLedgEntry."Bal. Account Type" := CheckLedgEntry."Bal. Account Type"::"G/L Account";
                            CheckLedgEntry."Bal. Account No." := '';
                            //CheckLedgEntry."Bal. Account Type" :="Account Type";
                            //CheckLedgEntry."Bal. Account No." := "Account No.";
                            IF FoundLast THEN BEGIN
                                /*
                                  IF TotalLineAmount < 0 THEN
                                    ERROR(
                                    Text020,
                                    UseCheckNo,TotalLineAmount);
                                 */
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                                //commented by monika CheckLedgEntry.Amount := TotalLineAmount;
                                //changed by monika
                                CheckLedgEntry.Amount := ABS(TotalLineAmount);
                            END ELSE BEGIN
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                                CheckLedgEntry.Amount := 0;
                            END;
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, CheckLedgEntry.RECORDID);


                            IF FoundLast THEN BEGIN
                                CheckAmountText := FORMAT(ABS(GenJnlLine.Amount) - TDSAmount - WorkTaxAmount, 0);
                                // NAVIN //monika
                                i := STRPOS(CheckAmountText, '.');
                                CASE TRUE OF
                                    i = 0:
                                        CheckAmountText := CheckAmountText + '.00';
                                    i = STRLEN(CheckAmountText) - 1:
                                        CheckAmountText := CheckAmountText + '0';
                                    i > STRLEN(CheckAmountText) - 2:
                                        CheckAmountText := COPYSTR(CheckAmountText, 1, i + 2);
                                END;
                                FormatNoText(DescriptionLine, (ABS(GenJnlLine.Amount) - TDSAmount - WorkTaxAmount), BankAcc2."Currency Code");
                                // NAVIN
                                VoidText := '';
                            END ELSE BEGIN
                                CLEAR(CheckAmountText);
                                CLEAR(DescriptionLine);
                                DescriptionLine[1] := Text021;
                                DescriptionLine[2] := DescriptionLine[1];
                                VoidText := Text022;
                            END;


                        END ELSE BEGIN
                            CheckLedgEntry.INIT;
                            CheckLedgEntry."Bank Account No." := BankAccNo;
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := Text023;
                            CheckLedgEntry."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
                            CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, CheckLedgEntry.RECORDID);

                            CheckAmountText := Text024;
                            DescriptionLine[1] := Text025;
                            DescriptionLine[2] := DescriptionLine[1];
                            VoidText := Text022;

                        END;

                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := FALSE;


                        CLEAR(AcPayee);
                        IF a THEN BEGIN
                            AcPayee[1] := '_________';
                            AcPayee[2] := 'A/C PAYEE';
                        END;
                        //commented by monika IF BancAccount.GET(GenJnlLine."Bal. Account No.") THEN BEGIN
                        IF BancAccount.GET(GenJnlLine."Bal. Account No.") THEN BEGIN
                            FOR i := 1 TO BancAccount."Amount X" DO
                                Amt[BancAccount."Amount Y"] += ' ';
                            //Amt[BancAccount."Amount Y"] := Amt[BancAccount."Amount Y"] + '**' + CheckAmountText;
                            Amt[BancAccount."Amount Y"] := Amt[BancAccount."Amount Y"] + '**' + FORMAT((ABS(GenJnlLine.Amount) - TDSAmount - WorkTaxAmount)) + ' /-';

                            FOR i := 1 TO BancAccount."Name X" DO
                                Name[BancAccount."Name Y"] += ' ';
                            //IF VendorRec.GET(GenJnlLine."Account No.") THEN
                            Name[BancAccount."Name Y"] := Name[BancAccount."Name Y"] + UPPERCASE(CheckToAddr[1]) + '*****';

                            FOR i := 1 TO BancAccount."Date X" DO
                                Dt[BancAccount."Date Y"] += ' ';
                            Dt[BancAccount."Date Y"] := Dt[BancAccount."Date Y"] + FORMAT(CheckDateText);

                            CheckReport.InitTextVariable;
                            //commented by monika CheckReport.FormatNoText(NoTex,(CheckLedgEntry.Amount - TDSAmount - WorkTaxAmount),'');
                            CheckReport.FormatNoText(NoTex, (ABS(GenJnlLine.Amount) - TDSAmount - WorkTaxAmount), ''); //monika
                            No1 := BancAccount."Text Amount L1 Length";
                            NoText1 := COPYSTR(NoTex[1] + NoTex[2], 6, STRLEN(NoTex[1] + NoTex[2]));
                            Flag := FALSE;
                            FOR b := No1 DOWNTO 1 DO BEGIN
                                IF (COPYSTR(NoText1, b, 1) = ' ') AND NOT Flag THEN BEGIN
                                    No1 := b;
                                    Flag := TRUE;
                                END;
                            END;

                            NoText2 := COPYSTR(NoText1, No1, STRLEN(NoText1));
                            NoText1 := COPYSTR(NoText1, 1, No1);
                            FOR i := 1 TO BancAccount."Text Amount L1 X" DO
                                AmtText[BancAccount."Text Amount L1 Y"] += ' ';
                            AmtText[BancAccount."Text Amount L1 Y"] := AmtText[BancAccount."Text Amount L1 Y"] + NoText1;

                            FOR i := 1 TO BancAccount."Text Amount L2 X" DO
                                AmtText1[BancAccount."Text Amount  L2 Y"] += ' ';
                            AmtText1[BancAccount."Text Amount  L2 Y"] := AmtText1[BancAccount."Text Amount  L2 Y"] + NoText2;

                        END ELSE BEGIN
                            IF BancAccount.GET(GenJnlLine."Account No.") THEN BEGIN
                                FOR i := 1 TO BancAccount."Amount X" DO
                                    Amt[BancAccount."Amount Y"] += ' ';
                                //Amt[BancAccount."Amount Y"] := Amt[BancAccount."Amount Y"] + '**' + CheckAmountText;
                                Amt[BancAccount."Amount Y"] := Amt[BancAccount."Amount Y"] + '**' + FORMAT((ABS(GenJnlLine.Amount) - TDSAmount - WorkTaxAmount)) + ' /-';

                                FOR i := 1 TO BancAccount."Name X" DO
                                    Name[BancAccount."Name Y"] += ' ';
                                //IF VendorRec.GET(GenJnlLine."Account No.") THEN
                                Name[BancAccount."Name Y"] := Name[BancAccount."Name Y"] + UPPERCASE(CheckToAddr[1]) + '*****';

                                FOR i := 1 TO BancAccount."Date X" DO
                                    Dt[BancAccount."Date Y"] += ' ';
                                Dt[BancAccount."Date Y"] := Dt[BancAccount."Date Y"] + FORMAT(CheckDateText);

                                //CheckReport.InitTextVariable;
                                //commented by monika CheckReport.FormatNoText(NoTex,(CheckLedgEntry.Amount - TDSAmount - WorkTaxAmount),'');
                                FormatNoText(NoTex, (ABS(GenJnlLine.Amount) - TDSAmount - WorkTaxAmount), ''); //monika
                                No1 := BancAccount."Text Amount L1 Length";
                                NoText1 := COPYSTR(NoTex[1] + NoTex[2], 6, STRLEN(NoTex[1] + NoTex[2]));
                                Flag := FALSE;
                                FOR b := No1 DOWNTO 1 DO BEGIN
                                    IF (COPYSTR(NoText1, b, 1) = ' ') AND NOT Flag THEN BEGIN
                                        No1 := b;
                                        Flag := TRUE;
                                    END;
                                END;

                                NoText2 := COPYSTR(NoText1, No1, STRLEN(NoText1));
                                NoText1 := COPYSTR(NoText1, 1, No1);
                                FOR i := 1 TO BancAccount."Text Amount L1 X" DO
                                    AmtText[BancAccount."Text Amount L1 Y"] += ' ';
                                AmtText[BancAccount."Text Amount L1 Y"] := AmtText[BancAccount."Text Amount L1 Y"] + NoText1;

                                FOR i := 1 TO BancAccount."Text Amount L2 X" DO
                                    AmtText1[BancAccount."Text Amount  L2 Y"] += ' ';
                                AmtText1[BancAccount."Text Amount  L2 Y"] := AmtText1[BancAccount."Text Amount  L2 Y"] + NoText2;

                            END;
                        END;

                    end;

                    trigger OnPreDataItem()
                    var
                        NoText1: Text[250];
                        CheckReport: Report "Check Report";
                        NoText2: Text[250];
                        b: Integer;
                        NoTex: array[2] of Text[80];
                    begin
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF FoundLast THEN
                        CurrReport.BREAK;

                    UseCheckNo := INCSTR(UseCheckNo);
                    IF NOT TestPrint THEN
                        CheckNoText := UseCheckNo
                    ELSE
                        CheckNoText := Text011;
                end;

                trigger OnPostDataItem()
                begin

                    IF NOT TestPrint THEN BEGIN
                        IF UseCheckNo <> GenJnlLine."Cheque No." THEN BEGIN
                            GenJnlLine3.RESET;
                            GenJnlLine3.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Cheque No.");
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3.SETRANGE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3.SETRANGE("Cheque No.", UseCheckNo);
                            IF GenJnlLine3.FIND('-') THEN
                                GenJnlLine3.FIELDERROR("Cheque No.", STRSUBSTNO(Text013, UseCheckNo));
                        END;

                        IF ApplyMethod <> ApplyMethod::MoreLinesOneEntry THEN BEGIN
                            GenJnlLine3 := GenJnlLine;
                            //    GenJnlLine3.TESTFIELD("Posting No. Series",'');
                            GenJnlLine3."Document No." := UseCheckNo;
                            // NAVIN
                            GenJnlLine3."Cheque No." := UseCheckNo;
                            //commented by monika GenJnlLine3."Issuing Bank" := GenJnlLine."Account No.";
                            GenJnlLine3."Cheque Date" := WORKDATE;
                            // NAVIN
                            GenJnlLine3."Check Printed" := TRUE;
                            GenJnlLine3.MODIFY;
                        END ELSE BEGIN
                            IF GenJnlLine2.FIND('-') THEN BEGIN
                                HighestLineNo := GenJnlLine2."Line No.";
                                REPEAT
                                    IF GenJnlLine2."Line No." > HighestLineNo THEN
                                        HighestLineNo := GenJnlLine2."Line No.";
                                    GenJnlLine3 := GenJnlLine2;
                                    GenJnlLine3.TESTFIELD("Posting No. Series", '');
                                    GenJnlLine3."Bal. Account No." := '';
                                    GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::" ";
                                    GenJnlLine3."Document No." := UseCheckNo;
                                    GenJnlLine3."Check Printed" := TRUE;
                                    // NAVIN
                                    GenJnlLine3."Cheque No." := UseCheckNo;
                                    GenJnlLine3."Issuing Bank" := GenJnlLine."Account No."; //monika
                                    GenJnlLine3."Cheque Date" := WORKDATE;
                                    // NAVIN
                                    GenJnlLine3.VALIDATE(Amount);
                                    GenJnlLine3.MODIFY;
                                UNTIL GenJnlLine2.NEXT = 0;
                            END;

                            GenJnlLine3.RESET;
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3."Line No." := HighestLineNo;
                            IF GenJnlLine3.NEXT = 0 THEN
                                GenJnlLine3."Line No." := HighestLineNo + 10000
                            ELSE BEGIN
                                WHILE GenJnlLine3."Line No." = HighestLineNo + 1 DO BEGIN
                                    HighestLineNo := GenJnlLine3."Line No.";
                                    IF GenJnlLine3.NEXT = 0 THEN
                                        GenJnlLine3."Line No." := HighestLineNo + 20000;
                                END;
                                GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) DIV 2;
                            END;
                            GenJnlLine3.INIT;
                            GenJnlLine3.VALIDATE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                            // GenJnlLine3."Document No." := GenJnlLine."Document No.";
                            // NAVIN
                            IF UseCheckNo <> '' THEN
                                GenJnlLine3."Document No." := UseCheckNo
                            ELSE
                                GenJnlLine3."Document No." := GenJnlLine."Document No.";
                            GenJnlLine3."Cheque No." := UseCheckNo;
                            //commented by monika GenJnlLine3."Issuing Bank" := GenJnlLine."Bal. Account No.";
                            GenJnlLine3."Issuing Bank" := GenJnlLine."Account No."; //monika
                            GenJnlLine3."Cheque Date" := WORKDATE;
                            // NAVIN
                            GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                            GenJnlLine3.VALIDATE("Account No.", BankAccNo);
                            IF BalancingType <> BalancingType::"G/L Account" THEN
                                // 16630        GenJnlLine3.Narration := STRSUBSTNO(Text014, SELECTSTR(BalancingType + 1, Text062), BalancingNo);
                                GenJnlLine3.VALIDATE(Amount, -TotalLineAmount);
                            GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::"Computer Check";
                            GenJnlLine3."Check Printed" := TRUE;
                            GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                            GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                            GenJnlLine3."Allow Zero-Amount Posting" := TRUE;
                            GenJnlLine3.INSERT;
                        END;
                    END;

                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.MODIFY;

                    COMMIT;
                    CLEAR(CheckManagement);
                end;

                trigger OnPreDataItem()
                begin

                    FirstPage := TRUE;
                    FoundLast := FALSE;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //monika

                IF EVALUATE(CheqNo, "Cheque No.") THEN
                    UseCheckNo := FORMAT(CheqNo - 1);
                //MESSAGE(UseCheckNo);
                IF UseCheckNo = '' THEN
                    ERROR(Text001);
                //monika
                //commented by monika
                /*
                IF OneCheckPrVendor AND (GenJnlLine."Currency Code" <> '') AND
                
                      (GenJnlLine."Currency Code" <> Currency.Code)
                THEN BEGIN
                  Currency.GET(GenJnlLine."Currency Code");
                  Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                  Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                END;
                */
                TESTFIELD(Description2);

                IF NOT TestPrint THEN BEGIN
                    IF Amount = 0 THEN
                        CurrReport.SKIP;
                    /*
                    //changed by monika
                   //*********
                  TESTFIELD("Account Type","Account Type"::"Bank Account");
                  IF "Account No." <> BankAccNo THEN
                    CurrReport.SKIP;
                   //*********
                   */
                    IF ("Account No." <> '') THEN BEGIN
                        BalancingType := "Account Type".AsInteger();
                        BalancingNo := "Account No.";
                        RemainingAmount := Amount;
                        // NAVIN
                        /*  TDSAmount := ABS("Total TDS/TCS Incl. SHE CESS");
                          WorkTaxAmount := ABS("Work Tax Amount");*/ // 16630
                                                                     // NAVIN
                        IF OneCheckPrVendor THEN BEGIN
                            ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                            GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                            GenJnlLine2.SETRANGE("Posting Date", "Posting Date");
                            GenJnlLine2.SETRANGE("Document No.", "Document No.");
                            GenJnlLine2.SETRANGE("Account Type", "Account Type");
                            GenJnlLine2.SETRANGE("Account No.", "Account No.");
                            //monika GenJnlLine2.SETRANGE("Bal. Account Type","Bal. Account Type");
                            //monika GenJnlLine2.SETRANGE("Bal. Account No.","Bal. Account No.");
                            GenJnlLine2.SETRANGE("Bank Payment Type", "Bank Payment Type");
                            GenJnlLine2.FIND('-');
                            RemainingAmount := 0;
                        END ELSE
                            IF "Applies-to Doc. No." <> '' THEN
                                ApplyMethod := ApplyMethod::OneLineOneEntry
                            ELSE
                                IF "Applies-to ID" <> '' THEN
                                    ApplyMethod := ApplyMethod::OneLineID
                                ELSE
                                    ApplyMethod := ApplyMethod::Payment;
                    END ELSE
                        IF "Account No." = '' THEN
                            FIELDERROR("Account No.", Text004);
                    CLEAR(CheckToAddr);
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CASE BalancingType OF
                        BalancingType::"G/L Account":
                            BEGIN
                                //mo tri1.0 comment start
                                //CheckToAddr[1] := GenJnlLine.Description;
                                //mo tri1.0 comment end
                                //mo tri1.0 start
                                CheckToAddr[1] := GenJnlLine.Description2;
                                //mo tri1.0 end
                            END;
                        BalancingType::Customer:
                            BEGIN
                                Cust.GET(BalancingNo);
                                IF Cust.Blocked = Cust.Blocked::All THEN
                                    ERROR(Text045, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, Cust."No.");
                                Cust.Contact := '';
                                //FormatAddr.Customer(CheckToAddr,Cust);  //TRI V.D 30.06.10 DEL ADD
                                //TRI V.D 30.06.10 START
                                IF GenJnlLine.Description2 = '' THEN
                                    ERROR('Please Fill the Column Description2');
                                CheckToAddr[1] := GenJnlLine.Description2;
                                //TRI V.D 30.06.10 STOP
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN
                                    ERROR(Text005);
                                IF Cust."Salesperson Code" <> '' THEN BEGIN
                                    ContactText := Text006;
                                    SalesPurchPerson.GET(Cust."Salesperson Code");
                                END;
                            END;
                        BalancingType::Vendor:
                            BEGIN
                                Vend.GET(BalancingNo);
                                IF Vend.Blocked IN [Vend.Blocked::All, Vend.Blocked::Payment] THEN
                                    ERROR(Text045, Vend.FIELDCAPTION(Blocked), Vend.Blocked, Vend.TABLECAPTION, Vend."No.");
                                Vend.Contact := '';
                                //FormatAddr.Vendor(CheckToAddr,Vend);
                                CheckToAddr[1] := GenJnlLine.Description2;
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN
                                    ERROR(Text005);
                                IF Vend."Purchaser Code" <> '' THEN BEGIN
                                    ContactText := Text007;
                                    SalesPurchPerson.GET(Vend."Purchaser Code");
                                END;
                            END;
                        BalancingType::"Bank Account":
                            BEGIN
                                BankAcc.GET(BalancingNo);
                                BankAcc.TESTFIELD(Blocked, FALSE);
                                BankAcc.Contact := '';
                                //ND FormatAddr.BankAcc(CheckToAddr,BankAcc);
                                IF GenJnlLine.Description2 = '' THEN
                                    ERROR('Please Fill the Column Description2');
                                CheckToAddr[1] := GenJnlLine.Description2;  //ND
                                IF BankAcc2."Currency Code" <> BankAcc."Currency Code" THEN
                                    ERROR(Text008);
                                IF BankAcc."Our Contact Code" <> '' THEN BEGIN
                                    ContactText := Text009;
                                    SalesPurchPerson.GET(BankAcc."Our Contact Code");
                                END;
                            END;
                    END;
                    IF "Cheque Date" <> 0D THEN BEGIN
                        //TSPL Gaurav 20-04-11 : Start
                        //CheckDateText := FORMAT("Cheque Date",0,5)
                        CheckDateText := '';
                        D := DATE2DMY("Cheque Date", 1);
                        M := DATE2DMY("Cheque Date", 2);
                        Y := DATE2DMY("Cheque Date", 3);
                        IF D IN [1 .. 9] THEN
                            CheckDateText := '0' + FORMAT(D)
                        ELSE
                            CheckDateText := FORMAT(D);

                        IF M IN [1 .. 9] THEN
                            CheckDateText := CheckDateText + '0' + FORMAT(M)
                        ELSE
                            CheckDateText := CheckDateText + FORMAT(M);

                        CheckDateText := CheckDateText + FORMAT(Y);
                    END ELSE BEGIN
                        //CheckDateText :=FORMAT("Posting Date",0,5);
                        CheckDateText := '';
                        D := DATE2DMY("Posting Date", 1);
                        M := DATE2DMY("Posting Date", 2);
                        Y := DATE2DMY("Posting Date", 3);
                        IF D IN [1 .. 9] THEN
                            CheckDateText := '0' + FORMAT(D)
                        ELSE
                            CheckDateText := FORMAT(D);

                        IF M IN [1 .. 9] THEN
                            CheckDateText := CheckDateText + '0' + FORMAT(M)
                        ELSE
                            CheckDateText := CheckDateText + FORMAT(M);

                        CheckDateText := CheckDateText + FORMAT(Y);

                    END;
                    FOR J := 1 TO 8 DO BEGIN
                        IF J = 3 THEN
                            DChar := DChar + ' ' + ' ' + '' + COPYSTR(CheckDateText, J, 1)  //Dot removed becuase
                        ELSE
                            IF J = 5 THEN
                                DChar := DChar + ' ' + ' ' + '' + COPYSTR(CheckDateText, J, 1)
                            ELSE
                                DChar := DChar + ' ' + ' ' + COPYSTR(CheckDateText, J, 1);
                    END;
                    CheckDateText := DChar;
                    //TSPL Gaurav 20-04-11 : End
                    //CheckDateText := FORMAT("Posting Date",0,4);
                END ELSE BEGIN
                    IF ChecksPrinted > 0 THEN
                        CurrReport.BREAK;
                    BalancingType := BalancingType::Vendor;
                    BalancingNo := Text010;
                    CLEAR(CheckToAddr);
                    FOR i := 1 TO 5 DO
                        CheckToAddr[i] := Text003;
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CheckNoText := Text011;
                    CheckDateText := Text012;
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF GGL.FINDLAST THEN;
                IF BankAccNo = '' THEN
                    IF GGL."Bal. Account Type" = GGL."Bal. Account Type"::"Bank Account" THEN
                        BankAccNo := GGL."Bal. Account No."
                    ELSE
                        IF GGL."Account Type" = GGL."Account Type"::"Bank Account" THEN
                            BankAccNo := GGL."Account No."
                        ELSE
                            ERROR('Please select Bank Code as the bank is not available in Line');


                GenJnlLine.COPY(VoidGenJnlLine);
                CompanyInfo.GET;
                IF NOT TestPrint THEN BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BankAcc2.GET(BankAccNo);
                    BankAcc2.TESTFIELD(Blocked, FALSE);
                    COPY(VoidGenJnlLine);
                    SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                    SETRANGE("Check Printed", FALSE);
                END ELSE BEGIN
                    CLEAR(CompanyAddr);
                    FOR i := 1 TO 5 DO
                        CompanyAddr[i] := Text003;
                END;
                ChecksPrinted := 0;

                SETRANGE("Account Type", GenJnlLine."Account Type"::"Fixed Asset");
                IF FIND('-') THEN
                    GenJnlLine.FIELDERROR("Account Type");

                SETRANGE("Account Type");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Bank Account"; BankAccNo)
                {
                    TableRelation = "Bank Account";
                    ApplicationArea = All;
                }
                field("Reprint Check"; ReprintChecks)
                {
                    ApplicationArea = All;
                }
                field("Test Print"; TestPrint)
                {
                    ApplicationArea = All;
                }
                field("Preprinted Stub"; PreprintedStub)
                {
                    ApplicationArea = All;
                }
                field("A/C Payee"; a)
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

    trigger OnInitReport()
    var
        GnJnlLine: Record "Gen. Journal Line";
    begin

        a := TRUE;
    end;

    trigger OnPostReport()
    begin

        //RepAuditMgt.CreateAudit(50087)
    end;

    trigger OnPreReport()
    begin

        InitTextVariable;
    end;

    var
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[250];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[100];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[132];
        DocType: Text[30];
        DocNo: Text[30];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        LineAmount2: Decimal;
        GLSetup: Record "General Ledger Setup";
        "-NAVIN-": Integer;
        Tens1: Integer;
        Ones1: Integer;
        TDSAmount: Decimal;
        WorkTaxAmount: Decimal;
        "--Nitin--": Integer;
        BancAccount: Record "Bank Account";
        VendorRec: Record Vendor;
        Amt: array[100] of Text[500];
        Name: array[100] of Text[500];
        AmtText: array[100] of Text[500];
        Dt: array[100] of Text[500];
        NoText: array[2] of Text[80];
        CheqNo: Integer;
        No1: Integer;
        Flag: Boolean;
        AcPayee: array[2] of Code[20];
        a: Boolean;
        D: Integer;
        M: Integer;
        Y: Integer;
        DChar: Text[100];
        J: Integer;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'LAKH';
        Text061: Label 'CRORE';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        AmtText1: array[100] of Text[500];
        CheckReport: Report "Check Report";
        SBI2Check: Boolean;
        BankAccNo: Code[30];
        GGL: Record "Gen. Journal Line";

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Curr: Record Currency;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';  // NAVIN

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;

                // NAVIN
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                // NAVIN
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                // NAVIN
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
            // NAVIN
        END;

        IF (CurrencyCode <> '') THEN BEGIN
            Curr.GET(CurrencyCode);
            // 16630  AddToNoText1(NoText, NoTextIndex, PrintExponent, ' ' + Curr."Currency Numeric Description");
        END ELSE
            AddToNoText1(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        // NAVIN
        //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');
        //ND Start
        /* IF (CurrencyCode <> '') THEN
             AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Curr."Currency Decimal Description" + ' ONLY')
         ELSE
             AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA');*/ // 16630
                                                                          //ND END

        Tens1 := ((No * 100) MOD 100) DIV 10;
        Ones1 := (No * 100) MOD 10;
        IF Tens1 >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens1]);
            IF Ones1 > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones1]);
        END ELSE
            IF (Tens1 * 10 + Ones1) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens1 * 10 + Ones1])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text026);
        /*//ND Start
        IF (CurrencyCode <> '') THEN
          AddToNoText1(NoText,NoTextIndex,PrintExponent,' ' + Curr."Currency Decimal Description" {+ ' ONLY'})
        ELSE
          AddToNoText1(NoText,NoTextIndex,PrintExponent,' PAISA');
        *///ND END
        AddToNoText1(NoText, NoTextIndex, PrintExponent, ' ONLY');

        //AddToNoText(NoText,NoTextIndex,PrintExponent,' PAISA ONLY');
        // NAVIN

        // IF CurrencyCode <> '' THEN
        //  AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);

    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry"; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SETRANGE("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF GenJnlLine3.FIND('-') THEN
                GenJnlLine3.FIELDERROR(
                  "Applies-to Doc. No.",
                  STRSUBSTNO(
                    Text030,
                    CustLedgEntry2."Document Type", CustLedgEntry2."Document No.",
                    CustLedgEntry2."Customer No."));
        END;

        DocType := FORMAT(CustLedgEntry2."Document Type");
        DocNo := CustLedgEntry2."Document No.";
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";

        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount := -(CustLedgEntry2."Remaining Amount" - CustLedgEntry2."Remaining Pmt. Disc. Possible" -
          CustLedgEntry2."Accepted Payment Tolerance");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::Invoice) AND
           (GenJnlLine."Posting Date" <= CustLedgEntry2."Pmt. Discount Date") AND
           (LineAmount2 <= RemainingAmount2)) OR CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            IF CustLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF RemainingAmount2 >=
               ROUND(
                -(ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                  CustLedgEntry2."Remaining Amount")), Currency."Amount Rounding Precision")
            THEN
                LineAmount2 :=
                  ROUND(
                    -(ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      CustLedgEntry2."Remaining Amount")), Currency."Amount Rounding Precision")
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry"; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF GenJnlLine3.FIND('-') THEN
                GenJnlLine3.FIELDERROR(
                  "Applies-to Doc. No.",
                  STRSUBSTNO(
                    Text031,
                    VendLedgEntry2."Document Type", VendLedgEntry2."Document No.",
                    VendLedgEntry2."Vendor No."));
        END;

        DocType := FORMAT(VendLedgEntry2."Document Type");
        DocNo := VendLedgEntry2."Document No.";
        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount := -(VendLedgEntry2."Remaining Amount" - VendLedgEntry2."Remaining Pmt. Disc. Possible" -
          VendLedgEntry2."Accepted Payment Tolerance");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((VendLedgEntry2."Document Type" = VendLedgEntry2."Document Type"::Invoice) AND
           (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date") AND
           (LineAmount2 <= RemainingAmount2)) OR VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            IF VendLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF RemainingAmount2 >=
                ROUND(
                 -(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                   VendLedgEntry2."Remaining Amount")), Currency."Amount Rounding Precision")
             THEN
                LineAmount2 :=
                  ROUND(
                    -(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      VendLedgEntry2."Remaining Amount")), Currency."Amount Rounding Precision")
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean)
    begin
        IF BankAcc <> '' THEN
            IF BankAcc2.GET(BankAcc) THEN BEGIN
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            END;
    end;

    procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        ELSE
            IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
            ELSE
                IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
                ELSE
                    Amount2 := Amount;
    end;

    local procedure AddToNoText1(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(AddText + ' ' + NoText[NoTextIndex], '<');
    end;
}

