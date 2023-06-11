report 50038 "Creditors Report MIS"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CreditorsReportMIS.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(GblStartDate; FORMAT(GblStartDate))
            {
            }
            column(GBLEndDate; FORMAT(GBLEndDate))
            {
            }
            column(CustNo; Vendor."No.")
            {
            }
            column(CustName; Vendor.Name)
            {
            }
            column(OpenBal; -1 * (OpenBal - CFormAmt))
            {
            }
            column(CFormAmt; -1 * CFormAmt)
            {
            }
            column(VendorPostingGroup_Vendor; Vendor."Vendor Posting Group")
            {
            }
            column(DeptName; recVendorPostingGroup."Department Name")
            {
            }
            column(OwnerNAme; recVendorPostingGroup."Owner Name")
            {
            }
            column(ClosBal; -1 * ClosBal)
            {
            }
            column(Balance; Balance / InLac)
            {
            }
            column(CustSales; CustomerSales / InLac)
            {
            }
            column(MSMETpye; MSMEType)
            {
            }
            column(Detailes; Detailes)
            {
            }
            column(cdPOLst; cdPOLst)
            {
            }
            column(cdPaymentTermLst; cdPaymentTermLst)
            {
            }
            column(optDueDateCalOnLst; optDueDateCalOnLst)
            {
            }
            column(datecaption1; DateCaption[1])
            {
            }
            column(datecaption2; DateCaption[2])
            {
            }
            column(datecaption3; DateCaption[3])
            {
            }
            column(datecaption4; DateCaption[4])
            {
            }
            column(datecaption5; DateCaption[5])
            {
            }
            column(datecaption6; DateCaption[6])
            {
            }
            column(datecaption7; DateCaption[7])
            {
            }
            column(datecaption8; DateCaption[8])
            {
            }
            column(datecaption9; DateCaption[9])
            {
            }
            column(datecaption10; DateCaption[10])
            {
            }
            column(datecaption11; DateCaption[11])
            {
            }
            column(datecaption12; DateCaption[12])
            {
            }
            column(datecaption13; DateCaption[13])
            {
            }
            column(datecaption14; DateCaption[14])
            {
            }
            column(datecaption15; DateCaption[15])
            {
            }
            column(datecaption16; DateCaption[16])
            {
            }
            column(datecaption17; DateCaption[17])
            {
            }
            column(datecaption18; DateCaption[18])
            {
            }
            column(datecaption19; DateCaption[19])
            {
            }
            column(datecaption20; DateCaption[20])
            {
            }
            column(datecaption21; DateCaption[21])
            {
            }
            column(datecaption22; DateCaption[22])
            {
            }
            column(datecaption23; DateCaption[23])
            {
            }
            column(datecaption24; DateCaption[24])
            {
            }
            column(datecaption25; DateCaption[25])
            {
            }
            column(datecaption26; DateCaption[26])
            {
            }
            column(datecaption27; DateCaption[27])
            {
            }
            column(datecaption28; DateCaption[28])
            {
            }
            column(datecaption29; DateCaption[29])
            {
            }
            column(datecaption30; DateCaption[30])
            {
            }
            column(datecaption31; DateCaption[31])
            {
            }
            column(decPayble; decPayble / InLac)
            {
            }
            dataitem(Integer; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                column(cdPONo; cdPONo)
                {
                }
                column(cdPaymentTerm; cdPaymentTerm)
                {
                }
                column(optDueDateCalOn; optDueDateCalOn)
                {
                }
                column(BalanceNew; -1 * Bal)
                {
                }
                column(Detailed; Detailed)
                {
                }
                column(PostDate; dtPostDate)
                {
                }
                column(decAmount; decAmount)
                {
                }
                column(cdDocNo; cdDocNo)
                {
                }
                column(decOverDueBal; decOverDueBal[1])
                {
                }
                column(decOverDueBal2; decOverDueBal[2])
                {
                }
                column(decOverDueBal3; decOverDueBal[3])
                {
                }
                column(decOverDueBal4; decOverDueBal[4])
                {
                }
                column(intOverDueDays; intOverDueDays)
                {
                }
                column(decNotDueAmt; decNotDueAmt)
                {
                }
                column(decOutStand; decOutStand)
                {
                }
                column(Day1; -1 * DueAmt[1])
                {
                }
                column(Day2; -1 * DueAmt[2])
                {
                }
                column(Day3; -1 * DueAmt[3])
                {
                }
                column(Day4; -1 * DueAmt[4])
                {
                }
                column(Day5; -1 * DueAmt[5])
                {
                }
                column(Day6; -1 * DueAmt[6])
                {
                }
                column(Day7; -1 * DueAmt[7])
                {
                }
                column(Day8; -1 * DueAmt[8])
                {
                }
                column(Day9; -1 * DueAmt[9])
                {
                }
                column(Day10; -1 * DueAmt[10])
                {
                }
                column(Day11; -1 * DueAmt[11])
                {
                }
                column(Day12; -1 * DueAmt[12])
                {
                }
                column(Day13; -1 * DueAmt[13])
                {
                }
                column(Day14; -1 * DueAmt[14])
                {
                }
                column(Day15; -1 * DueAmt[15])
                {
                }
                column(Day16; -1 * DueAmt[16])
                {
                }
                column(Day17; -1 * DueAmt[17])
                {
                }
                column(Day18; -1 * DueAmt[18])
                {
                }
                column(Day19; -1 * DueAmt[19])
                {
                }
                column(Day20; -1 * DueAmt[20])
                {
                }
                column(Day21; -1 * DueAmt[21])
                {
                }
                column(Day22; -1 * DueAmt[22])
                {
                }
                column(Day23; -1 * DueAmt[23])
                {
                }
                column(Day24; -1 * DueAmt[24])
                {
                }
                column(Day25; -1 * DueAmt[25])
                {
                }
                column(Day26; -1 * DueAmt[26])
                {
                }
                column(Day27; -1 * DueAmt[27])
                {
                }
                column(Day28; -1 * DueAmt[28])
                {
                }
                column(Day29; -1 * DueAmt[29])
                {
                }
                column(Day30; -1 * DueAmt[30])
                {
                }
                column(Day31; -1 * DueAmt[31])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(DueAmt);
                    intOverDueDays := 0;
                    CLEAR(decOverDueBal);
                    CLEAR(DateCaptionlbl);
                    decNotDueAmt := 0;

                    // decOutStand:=0;

                    IF Detailes = FALSE THEN BEGIN
                        IF NOT CustAgeingMGT.READ THEN BEGIN
                            RecordNotFound := TRUE;
                            CurrReport.BREAK;
                        END;
                        //IF NOT FirstRecordNotExist THEN

                        FOR I := 1 TO 31 DO BEGIN
                            DateCaptionlbl[I] := GblStartDate - 1 + I;
                            IF DateCaptionlbl[I] = CustAgeingMGT.Due_Date THEN
                                DueAmt[I] := CustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                        END;
                        //  IF CustAgeingMGT.Due_Date < GblStartDate-1 THEN BEGIN
                        IF (CustAgeingMGT.Sum_Remaining_Amt_LCY < 0) THEN BEGIN
                            IF (CustAgeingMGT.Due_Date <= GblStartDate) AND (CustAgeingMGT.Due_Date >= GblStartDate - 30) THEN BEGIN
                                //MESSAGE('%1..%2',GblStartDate-61,GblStartDate-90);
                                decOverDueBal[1] += ABS(CustAgeingMGT.Sum_Remaining_Amt_LCY) / InLac;
                            END ELSE
                                IF (CustAgeingMGT.Due_Date <= GblStartDate - 31) AND (CustAgeingMGT.Due_Date >= GblStartDate - 60) THEN BEGIN
                                    decOverDueBal[2] += ABS(CustAgeingMGT.Sum_Remaining_Amt_LCY) / InLac;
                                END ELSE
                                    IF (CustAgeingMGT.Due_Date <= GblStartDate - 61) AND (CustAgeingMGT.Due_Date >= GblStartDate - 90) THEN BEGIN
                                        decOverDueBal[3] += ABS(CustAgeingMGT.Sum_Remaining_Amt_LCY) / InLac;
                                    END ELSE
                                        IF (CustAgeingMGT.Due_Date < GblStartDate - 90) THEN BEGIN
                                            decOverDueBal[4] += ABS(CustAgeingMGT.Sum_Remaining_Amt_LCY) / InLac;
                                        END;

                            intOverDueDays := GblStartDate - CustAgeingMGT.Due_Date;
                        END;
                        //  END;

                        dtPostDate := CustAgeingMGT.Posting_Date;
                        decAmount := -1 * CustAgeingMGT.Sum_Amount / InLac;


                        //  decOutStand:=ABS(CustAgeingMGT.Sum_Remaining_Amt_LCY)/InLac;
                    END ELSE BEGIN
                        //Details Section Keshav13072020
                        IF NOT VendorAgeingMGTDetails.READ THEN BEGIN
                            RecordNotFound := TRUE;
                            CurrReport.BREAK;
                        END;
                        FOR I := 1 TO 31 DO BEGIN
                            DateCaptionlbl[I] := GblStartDate - 1 + I;
                            IF DateCaptionlbl[I] = VendorAgeingMGTDetails.Due_Date THEN
                                DueAmt[I] := VendorAgeingMGTDetails.Sum_Remaining_Amt_LCY / InLac;
                        END;
                        cdDocNo := VendorAgeingMGTDetails.Document_No;
                        dtPostDate := VendorAgeingMGTDetails.Posting_Date;
                        decAmount := -1 * VendorAgeingMGTDetails.Sum_Amount / InLac;
                        IF VendorAgeingMGTDetails.Due_Date < GblStartDate - 1 THEN BEGIN
                            decOverDueBal[1] := ABS(VendorAgeingMGTDetails.Sum_Remaining_Amt_LCY) / InLac;
                            intOverDueDays := GblStartDate - VendorAgeingMGTDetails.Due_Date;
                        END;


                        IF VendorAgeingMGTDetails.Due_Date > GBLEndDate + 1 THEN
                            decNotDueAmt := ABS(VendorAgeingMGTDetails.Sum_Remaining_Amt_LCY) / InLac;

                        //  decOutStand:=ABS(VendorAgeingMGTDetails.Sum_Remaining_Amt_LCY)/InLac;
                        cdPONo := '';
                        cdPaymentTerm := '';
                        optDueDateCalOn := optDueDateCalOn::" ";
                        recPurchInvLine.RESET;
                        recPurchInvLine.SETRANGE("Document No.", cdDocNo);
                        recPurchInvLine.SETFILTER(Type, '<>%1', recPurchInvLine.Type::" ");
                        IF recPurchInvLine.FIND('-') THEN BEGIN
                            recPurchRcptHdr.RESET;
                            recPurchRcptHdr.SETRANGE("No.", recPurchInvLine."Receipt No.");
                            IF recPurchRcptHdr.FIND('-') THEN BEGIN
                                cdPONo := recPurchRcptHdr."Order No.";
                                recPurchaseHeader.RESET;
                                recPurchaseHeader.SETRANGE("Document Type", recPurchaseHeader."Document Type"::Order);
                                recPurchaseHeader.SETRANGE("No.", cdPONo);
                                IF recPurchaseHeader.FIND('-') THEN BEGIN
                                    cdPaymentTerm := recPurchaseHeader."Payment Terms Code";
                                    optDueDateCalOn := recPurchaseHeader."Due Date Calc. On";
                                END;
                            END;
                        END;
                        IF cdPaymentTerm = '' THEN
                            cdPaymentTerm := 'P 90 DAYS';
                        //Details Section Keshav13072020
                    END;

                    //IF NOT RecordNotFound THEN
                    IF (CustCode = Vendor."No.") THEN BEGIN
                        OpenBal := 0;
                        CFormAmt := 0;
                        //  Bal :=0;
                    END;

                    CustCode := Vendor."No.";
                end;

                trigger OnPreDataItem()
                begin
                    IF Detailes = FALSE THEN BEGIN
                        CLEAR(CustAgeingMGT);
                        CustAgeingMGT.SETFILTER(CustAgeingMGT.Due_Date, '%1..%2', 0D, GBLEndDate);
                        CustAgeingMGT.SETRANGE(CustAgeingMGT.No, Vendor."No.");
                        //  CustAgeingMGT.SETFILTER(CustAgeingMGT.Document_Type,'%1',CustAgeingMGT.Document_Type::Invoice);
                        CustAgeingMGT.SETFILTER(CustAgeingMGT.Sum_Remaining_Amt_LCY, '<>%1', 0);
                        CustAgeingMGT.OPEN;
                    END ELSE BEGIN
                        CLEAR(VendorAgeingMGTDetails);
                        VendorAgeingMGTDetails.SETFILTER(VendorAgeingMGTDetails.Due_Date, '%1..%2', 0D, GBLEndDate);
                        VendorAgeingMGTDetails.SETRANGE(VendorAgeingMGTDetails.No, Vendor."No.");
                        //  VendorAgeingMGTDetails.SETFILTER(VendorAgeingMGTDetails.Document_Type,'%1',VendorAgeingMGTDetails.Document_Type::Invoice);
                        VendorAgeingMGTDetails.SETFILTER(VendorAgeingMGTDetails.Sum_Remaining_Amt_LCY, '<>%1', 0);
                        VendorAgeingMGTDetails.OPEN;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //IF Vendor."Vendor Posting Group"='EMP' THEN
                //  CurrReport.SKIP;

                recVendorPostingGroup.RESET;
                recVendorPostingGroup.SETRANGE(Code, Vendor."Vendor Posting Group");
                IF recVendorPostingGroup.FIND('-') THEN BEGIN

                END;

                OpenBal := 0;
                ClosBal := 0;
                CFormAmt := 0;
                RecordNotFound := FALSE;
                Vendor.CALCFIELDS(Balance);

                CLEAR(OCCustAgeingMGT);

                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.No, '%1', Vendor."No.");
                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.Due_Date, '%1..%2', 0D, GblStartDate - 1);
                OCCustAgeingMGT.OPEN;
                WHILE OCCustAgeingMGT.READ DO BEGIN
                    OpenBal += OCCustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                    //  IF OCCustAgeingMGT.Not_Enclude_CFORM THEN
                    //  CFormAmt += OCCustAgeingMGT.Sum_Remaining_Amt_LCY/InLac;
                END;

                CLEAR(OCCustAgeingMGT);
                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.No, '%1', Vendor."No.");
                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.Due_Date, '%1..%2', GBLEndDate + 1, 99990331D);
                OCCustAgeingMGT.OPEN;
                WHILE OCCustAgeingMGT.READ DO BEGIN
                    ClosBal += OCCustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                END;

                IF Vendor.Balance < 10 THEN
                    CurrReport.SKIP;

                cdPaymentTermLst := '';
                cdPOLst := '';
                optDueDateCalOnLst := 0;
                IF Detailes = FALSE THEN BEGIN
                    recPurchaseHeader.RESET;
                    recPurchaseHeader.SETCURRENTKEY("Order Date");
                    recPurchaseHeader.SETRANGE("Document Type", recPurchaseHeader."Document Type"::Order); //MSMK 02-07-2020;
                    recPurchaseHeader.SETFILTER(Status, '%1|%2', recPurchaseHeader.Status::Released, recPurchaseHeader.Status::"Short Close");//MSMK 02-07-2020;
                    recPurchaseHeader.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                    IF recPurchaseHeader.FINDLAST THEN BEGIN
                        cdPOLst := recPurchaseHeader."No.";
                        cdPaymentTermLst := recPurchaseHeader."Payment Terms Code";
                        optDueDateCalOnLst := recPurchaseHeader."Due Date Calc. On";
                    END ELSE BEGIN

                    END;
                END;
                IF cdPaymentTermLst = '' THEN
                    cdPaymentTermLst := 'P 90 DAYS';
                //Keshav08072020
                MSMEType := '';
                IF Vendor."Micro Enterprises" = TRUE THEN
                    MSMEType := 'Micro Enterprises';
                IF Vendor."Small Enterprises" THEN
                    MSMEType := 'Small Enterprises';
                IF Vendor."Medium Enterprises" THEN
                    MSMEType := 'Medium Enterprises';
                CLEAR(DateCaption);
                FOR I := 1 TO 31 DO
                    DateCaption[I] := GblStartDate - 1 + I;

                decOutStand := 0;
                /*
                recVendorLedger.RESET;
                recVendorLedger.SETRANGE("Vendor No.",Vendor."No.");
                recVendorLedger.SETRANGE("Posting Date",0D,GblStartDate);
                IF recVendorLedger.FIND('-') THEN REPEAT
                  recVendorLedger.CALCFIELDS("Amount (LCY)");
                  decOutStand+=ABS(recVendorLedger."Amount (LCY)"/InLac);
                UNTIL recVendorLedger.NEXT=0;
                */
                Vendor.CALCFIELDS(Balance);
                decOutStand := Vendor.Balance / InLac;
                decPayble := 0;
                CLEAR(CustAgeingMGT);
                CustAgeingMGT.SETFILTER(CustAgeingMGT.No, Vendor."No.");
                CustAgeingMGT.OPEN;
                WHILE CustAgeingMGT.READ DO BEGIN
                    IF CustAgeingMGT.Sum_Remaining_Amt_LCY < 0 THEN
                        decPayble += ABS(CustAgeingMGT.Sum_Remaining_Amt_LCY);
                END;

            end;

            trigger OnPreDataItem()
            begin
                // Vendor.SETRANGE("Date Filter",GblStartDate,GBLEndDate);
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
                field("As On Date"; GblStartDate)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ending Date"; GBLEndDate)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Detailes; Detailes)
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
    begin
        //GblStartDate := 010119D;
        //GBLEndDate := 310119D;
        InLac := 100000;
        // GblStartDate := TODAY();
        // GBLEndDate := CALCDATE('CM', TODAY);
        GblStartDate := TODAY;
    end;

    trigger OnPostReport()
    begin
        IF Detailes = FALSE THEN
            CustAgeingMGT.CLOSE
        ELSE
            VendorAgeingMGTDetails.CLOSE;
    end;

    trigger OnPreReport()
    begin
        GblStartDate := TODAY;
        GBLEndDate := GblStartDate + 30
    end;

    var
        GblStartDate: Date;
        GBLEndDate: Date;
        Detailed: Boolean;
        CustAgeingMGT: Query "Vendor Ageing MGT";
        VendorAgeingMGTDetails: Query "Vendor Ageing MGT Details";
        OpenBal: Decimal;
        CustNo: Code[20];
        DueAmt: array[64] of Decimal;
        I: Integer;
        ClosBal: Decimal;
        OCCustAgeingMGT: Query "Vendor Ageing MGT";
        InLac: Decimal;
        CFormAmt: Decimal;
        FirstRecordNotExist: Boolean;
        CustCode: Code[20];
        Bal: Decimal;
        RecordNotFound: Boolean;
        DSO: Decimal;
        CustomerSales: Decimal;
        recPurchaseHeader: Record "Purchase Header";
        cdPONo: Code[20];
        cdPaymentTerm: Code[20];
        optDueDateCalOn: Option " ","Vendor Invoice Date","Posting Date","GRN Date","Document Date";
        MSMEType: Text;
        Detailes: Boolean;
        dtPostDate: Date;
        decAmount: Decimal;
        cdDocNo: Code[20];
        recPurchInvLine: Record "Purch. Inv. Line";
        recPurchRcptHdr: Record "Purch. Rcpt. Header";
        cdPOLst: Code[20];
        cdPaymentTermLst: Code[20];
        optDueDateCalOnLst: Option " ","Vendor Invoice Date","Posting Date","GRN Date","Document Date";
        intOverDueDays: Integer;
        decOverDueBal: array[4] of Decimal;
        DateCaption: array[31] of Date;
        DateCaptionlbl: array[31] of Date;
        decNotDueAmt: Decimal;
        decOutStand: Decimal;
        recVendorLedger: Record "Vendor Ledger Entry";
        recVendorPostingGroup: Record "Vendor Posting Group";
        decPayble: Decimal;
}

