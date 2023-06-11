report 50019 "Applied Entries To Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\AppliedEntriesToVoucher.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry Document Loop"; 17)
        {
            DataItemTableView = SORTING("Document No.", "Posting Date", Amount)
                                ORDER(Ascending);
            RequestFilterFields = "Document Type", "Posting Date", "Document No.";
            column(PrintLineNarration; PrintLineNarration)
            {
            }
            column(LocationAddress; LocationAddress)
            {
            }
            column(AmtinWords; AmtInWORDS[1])
            {
            }
            column(DocNo; "G/L Entry Document Loop"."Document No.")
            {
            }
            column(PostingDate; FORMAT("G/L Entry Document Loop"."Posting Date"))
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompName2; CompanyInfo."Name 2")
            {
            }
            column(ViewDimen; ViewDimen)
            {
            }
            column(ViewDetails; ViewDetails)
            {
            }
            dataitem("G/L Entry"; 17)
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Posting Date", Amount)
                                    ORDER(Ascending);
                column(NoText1; NoText[1])
                {
                }
                column(NoText2; NoText[2])
                {
                }
                column(CheqNo; CheqNo)
                {
                }
                column(CheqDate; CheqDate)
                {
                }
                column(BName; BName)
                {
                }
                column(EntryNo; "G/L Entry"."Entry No.")
                {
                }
                column(ToText; ToText)
                {
                }
                column(Particulars; Particulars)
                {
                }
                column(CreditAmt; CreditAmt)
                {
                }
                column(DebitAmt; DebitAmt)
                {
                }
                column(Description; "G/L Entry".Description)
                {
                }
                column(DrText; DrText)
                {
                }
                column(DebitSum; DebitSum)
                {
                }
                column(CreditSum; CreditSum)
                {
                }
                dataitem("Ledger Entry Dimension"; 355)
                {
                    /* DataItemLink = "Entry No." = FIELD("Entry No.");
                     DataItemTableView = SORTING("Table ID", "Entry No.", "Dimension Code")
                                         ORDER(Ascending)
                                         WHERE("Table ID" = CONST(17));*/
                    column(LedEntryNo; '') // 16630  "Ledger Entry Dimension".Entry No.
                    {
                    }
                    column(Dim; Dim)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        DimValue := '';
                        Dim := '';
                        /* IF DimensionValue.GET("Dimension Code", "Dimension Value Code") THEN
                             DimValue := DimensionValue.Name;*/

                        IF Dimension.GET("Dimension Code") THEN
                            Dim := Dimension.Name;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF DocNoGlob <> "Document No." THEN BEGIN
                        CLEAR(DebitSum);
                        CLEAR(CreditSum);
                    END;

                    DocNoGlob := "Document No.";

                    BName := '';
                    GenJournalBatch.RESET;
                    GenJournalBatch.SETFILTER(GenJournalBatch.Name, "Journal Batch Name");
                    IF GenJournalBatch.FIND('-') THEN
                        BName := GenJournalBatch.Description;



                    recpurchINvline.RESET;
                    recpurchINvline.SETRANGE(recpurchINvline."Document No.", "G/L Entry"."Document No.");
                    IF recpurchINvline.FIND('-') THEN
                        Narration := recpurchINvline.Description;

                    //TRI VKG 220910
                    IF (("Source Code" = 'PURCHAPPL') OR ("Source Code" = 'UNAPPPURCH')) THEN
                        IF NOT (("G/L Account No." = '21252108') OR ("G/L Account No." = '21252109')) THEN
                            CurrReport.SKIP;



                    IF VendorledgEntry.GET("Entry No.") THEN BEGIN
                        IF vendor.GET(VendorledgEntry."Vendor No.") THEN
                            Particulars := vendor.Name;
                    END ELSE BEGIN
                        IF CustomerLedgEntry.GET("Entry No.") THEN BEGIN
                            IF Customer.GET(CustomerLedgEntry."Customer No.") THEN
                                Particulars := Customer.Name;
                        END ELSE BEGIN
                            IF BankLedgEntry.GET("Entry No.") THEN BEGIN
                                CheqNo := BankLedgEntry."Cheque No.";
                                CheqDate := BankLedgEntry."Cheque Date";
                                IF Bank.GET(BankLedgEntry."Bank Account No.") THEN
                                    Particulars := Bank.Name;
                            END ELSE BEGIN
                                GLAccount.RESET;
                                GLAccount.SETFILTER("No.", "G/L Account No.");
                                IF GLAccount.FIND('-') THEN
                                    Particulars := GLAccount.Name;
                            END;
                        END;
                    END;

                    CreditAmt := 0;
                    DebitAmt := 0;
                    ToText := '';
                    DrText := '';
                    IF Amount <= 0 THEN BEGIN
                        CreditAmt := Amount * (-1);
                        ToText := '    To ';
                    END ELSE
                        IF Amount > 0 THEN BEGIN
                            DebitAmt := Amount;
                            DrText := 'Dr ';
                        END;

                    DebitSum += ABS("Debit Amount");
                    CreditSum += ABS("Credit Amount");

                    //MESSAGE('%1  %2',DebitSum,CreditSum);
                    CLEAR(NoText);
                    CheckRep.InitTextVariable;
                    CheckRep.FormatNoText(NoText, DebitSum, '');

                    recpurchINvline.RESET;
                    recpurchINvline.SETRANGE(recpurchINvline."Document No.", "Document No.");
                    IF recpurchINvline.FIND('-') THEN
                        var1 := recpurchINvline.Description;


                    GeneralLedgerSetup.GET;


                    BName := '';
                    GenJournalBatch.RESET;
                    GenJournalBatch.SETFILTER(GenJournalBatch.Name, "Journal Batch Name");
                    IF GenJournalBatch.FIND('-') THEN
                        BName := GenJournalBatch.Description;
                end;
            }
            dataitem(GLEntry; 17)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Posting Date")
                                    ORDER(Ascending);
                column(DocumentNo2; GLEntry."Document No.")
                {
                }
                column(ToText1; ToText)
                {
                }
                column(Particulars1; Particulars)
                {
                }
                column(CreditAmt2; CreditAmt1)
                {
                }
                column(DebitAmt2; DebitAmt2)
                {
                }
                column(ToText2; ToText)
                {
                }
                column(DrText2; DrText)
                {
                }
                dataitem("Vendor Ledger Entry"; 25)
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Entry No.");
                    dataitem(VendLedEntry; 25)
                    {
                        DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                        DataItemTableView = SORTING("Entry No.");
                        column(VendorLedCheck2; VendorLedCheck2)
                        {
                        }
                        column(VendNo2; "Vendor No.")
                        {
                        }
                        column(VendAdd2; vendor.Name + ' , ' + vendor.Address + ', ' + vendor."Address 2" + ', ' + vendor."Post Code")
                        {
                        }
                        column(VendPostingDate2; FORMAT("Posting Date"))
                        {
                        }
                        column(VendDocNo2; "Document No.")
                        {
                        }
                        column(VednDes2; Description)
                        {
                        }
                        column(CurrCode2; "Currency Code")
                        {
                        }
                        column(DesCons2; Description + ' ' + Description2)
                        {
                        }
                        column(Amount2; Amount)
                        {
                        }
                        column(VendEntryNo2; "Entry No.")
                        {
                        }
                        column(VendorInvNo3; VendorInvNo2)
                        {
                        }
                        column(VendorInvDate3; VendorInvDate2)
                        {
                        }
                        column(TDSAmt3; TDSAmt2)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VendorLedCheck2 := TRUE;
                            IF vendor.GET("Vendor No.") THEN
                                Name := vendor.Name;

                            VendorInvNo := '';
                            CLEAR(VendorInvDate);
                            PurchInvHdr.RESET;
                            IF VendLedEntry."Document Type" = VendLedEntry."Document Type"::Invoice THEN
                                // IF PurchInvHdr.GET(VendorLedgerEntry1."Document No.") THEN BEGIN
                                PurchInvHdr.SETRANGE(PurchInvHdr."No.", VendLedEntry."Document No.");
                            IF PurchInvHdr.FIND('-') THEN BEGIN
                                VendorInvNo := PurchInvHdr."Vendor Invoice No.";
                                VendorInvDate := PurchInvHdr."Vendor Invoice Date";
                            END
                            ELSE
                                VendorInvNo := VendLedEntry."External Document No.";
                            VendorInvDate := VendLedEntry."Posting Date";

                            TDSEntry.RESET;
                            TDSEntry.SETRANGE(TDSEntry."Document No.", VendLedEntry."Document No.");
                            IF TDSEntry.FINDSET THEN BEGIN
                                TDSAmt := TDSEntry."TDS Amount";
                            END;
                        end;
                    }
                    dataitem(VendLedEntry2; 25)
                    {
                        DataItemLink = "Entry No." = FIELD("Closed by Entry No.");
                        DataItemTableView = SORTING("Entry No.");
                        column(VendorLedCheck; VendorLedCheck)
                        {
                        }
                        column(VendNo; VendLedEntry2."Vendor No.")
                        {
                        }
                        column(VendAdd; vendor.Name + ' , ' + vendor.Address + ', ' + vendor."Address 2" + ', ' + vendor."Post Code")
                        {
                        }
                        column(VendPostingDate; FORMAT(VendLedEntry2."Posting Date"))
                        {
                        }
                        column(VendDocNo; VendLedEntry2."Document No.")
                        {
                        }
                        column(VednDes; VendLedEntry2.Description)
                        {
                        }
                        column(CurrCode; VendLedEntry2."Currency Code")
                        {
                        }
                        column(DesCons; Description + ' ' + Description2)
                        {
                        }
                        column(Amount; VendLedEntry2.Amount)
                        {
                        }
                        column(VendEntryNo; VendLedEntry2."Entry No.")
                        {
                        }
                        column(VendorInvNo2; VendorInvNo2)
                        {
                        }
                        column(VendorInvDate2; VendorInvDate2)
                        {
                        }
                        column(TDSAmt2; TDSAmt2)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            VendorLedCheck := TRUE;
                            //MESSAGE(FORMAT(VendorLedCheck));
                            IF vendor.GET("Vendor No.") THEN
                                Name := vendor.Name;

                            VendorInvNo2 := '';
                            CLEAR(VendorInvDate2);
                            PurchInvHdr.RESET;
                            IF VendLedEntry2."Document Type" = VendLedEntry2."Document Type"::Invoice THEN
                                // IF PurchInvHdr.GET(VendorLedgerEntry1."Document No.") THEN BEGIN
                                PurchInvHdr.SETRANGE(PurchInvHdr."No.", VendLedEntry2."Document No.");
                            IF PurchInvHdr.FIND('-') THEN BEGIN
                                VendorInvNo2 := PurchInvHdr."Vendor Invoice No.";
                                VendorInvDate2 := PurchInvHdr."Vendor Invoice Date";
                            END
                            ELSE
                                VendorInvNo2 := VendLedEntry2."External Document No.";
                            VendorInvDate2 := VendLedEntry2."Posting Date";

                            TDSEntry.RESET;
                            TDSEntry.SETRANGE(TDSEntry."Document No.", VendLedEntry2."Document No.");
                            IF TDSEntry.FINDSET THEN BEGIN
                                TDSAmt2 := TDSEntry."TDS Amount";
                            END;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF vendor.GET("Vendor No.") THEN
                            Name := vendor.Name;
                    end;
                }
                dataitem("Cust. Ledger Entry"; 21)
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Entry No.");
                    dataitem(CustLedEntry; 21)
                    {
                        DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                        DataItemTableView = SORTING("Entry No.");
                        column(CusNo1; "Customer No.")
                        {
                        }
                        column(CustName2; Name)
                        {
                        }
                        column(PostingDateCust2; FORMAT("Posting Date"))
                        {
                        }
                        column(DocNoCust2; "Document No.")
                        {
                        }
                        column(DesTotal2; Description + ' ' + Description2)
                        {
                        }
                        column(CurrCust2; "Currency Code")
                        {
                        }
                        column(AmountCusr2; Amount)
                        {
                        }
                        column(EntryNoCust2; "Entry No.")
                        {
                        }
                        column(CustLedCheckBool2; CustLedCheckBool2)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CustLedCheckBool2 := TRUE;
                            IF Customer.GET("Customer No.") THEN
                                Name := Customer.Name;
                        end;
                    }
                    dataitem(CustLedEntry2; 21)
                    {
                        DataItemLink = "Entry No." = FIELD("Closed by Entry No.");
                        DataItemTableView = SORTING("Entry No.");
                        column(CusNo; "Customer No.")
                        {
                        }
                        column(CustName; Name)
                        {
                        }
                        column(PostingDateCust; FORMAT("Posting Date"))
                        {
                        }
                        column(DocNoCust; "Document No.")
                        {
                        }
                        column(DesTotal; Description + ' ' + Description2)
                        {
                        }
                        column(CurrCust; "Currency Code")
                        {
                        }
                        column(AmountCusr; Amount)
                        {
                        }
                        column(EntryNoCust; CustLedEntry2."Entry No.")
                        {
                        }
                        column(CustLedCheckBool; CustLedCheckBool)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CustLedCheckBool := TRUE;
                            IF Customer.GET("Customer No.") THEN
                                Name := Customer.Name;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    //TRI VKG 220910
                    IF (("Source Code" = 'PURCHAPPL') OR ("Source Code" = 'UNAPPPURCH')) THEN
                        IF NOT (("G/L Account No." = '21252108') OR ("G/L Account No." = '21252109')) THEN
                            CurrReport.SKIP;



                    IF NOT ViewDetails THEN
                        CurrReport.SKIP;
                    IF VendorledgEntry.GET("Entry No.") THEN BEGIN
                        IF vendor.GET(VendorledgEntry."Vendor No.") THEN
                            Particulars := vendor.Name;
                    END ELSE BEGIN
                        IF CustomerLedgEntry.GET("Entry No.") THEN BEGIN
                            IF Customer.GET(CustomerLedgEntry."Customer No.") THEN
                                Particulars := Customer.Name;
                        END ELSE BEGIN
                            IF BankLedgEntry.GET("Entry No.") THEN BEGIN
                                IF Bank.GET(BankLedgEntry."Bank Account No.") THEN
                                    Particulars := Bank.Name;
                            END ELSE BEGIN
                                GLAccount.RESET;
                                GLAccount.SETFILTER("No.", "G/L Account No.");
                                IF GLAccount.FIND('-') THEN
                                    Particulars := GLAccount.Name;
                            END;
                        END;
                    END;
                    IF DocNoGlob <> "Document No." THEN BEGIN
                        CLEAR(DebitSum);
                        CLEAR(CreditSum);
                    END;

                    DocNoGlob := "Document No.";


                    ToText := '';
                    DrText := '';
                    IF Amount <= 0 THEN BEGIN
                        CreditAmt1 := Amount * (-1);
                        ToText := 'To ';
                    END ELSE
                        IF Amount > 0 THEN BEGIN
                            DebitAmt2 := Amount;
                            DrText := 'Dr ';
                        END;
                    //MESSAGE('%1   %2',CreditAmt,DebitAmt);
                    DebitSum += ABS("Debit Amount");
                    CreditSum += ABS("Credit Amount");
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Entry No.", '%1', "G/L Entry"."Entry No.");
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLENTRY: Record "G/L Entry";
                State: Record State;
            begin
                GLENTRY.RESET;
                GLENTRY.SETRANGE("Document No.", "Document No.");
                GLENTRY.CALCSUMS("Debit Amount");
                CLEAR(AmtInWORDS);
                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(AmtInWORDS, GLENTRY."Debit Amount", '');

                /*GeneralLedgerSetup.GET;
                LedgerEntryDim.RESET;
                LedgerEntryDim.SETRANGE("Dimension Set ID","Dimension Set ID");
                LedgerEntryDim.SETRANGE("Dimension Code",'BRANCH');
                IF LedgerEntryDim.FIND('-') THEN
                  IF LocationRec.GET(LedgerEntryDim."Dimension Value Code") THEN
                    LocationAddress := LocationRec.Address + ' ' + LocationRec."Address 2" +
                      ' ' + LocationRec.City;*/

                GLENTRY.RESET;
                GLENTRY.SETRANGE("Document No.", "Document No.");
                IF GLENTRY.FINDFIRST THEN;
                /* 16630 IF LocationRec.GET( GLENTRY."Location Code") THEN BEGIN
                      State.GET(LocationRec."State Code");
                      LocationAddress := LocationRec.Address + ' ' + LocationRec."Address 2" + ' ' + LocationRec.City + '(' + State.Description + ') ' + LocationRec."Phone No.";
                  END;*/ // 16630

                //TRI VKG 220910
                IF (("Source Code" = 'PURCHAPPL') OR ("Source Code" = 'UNAPPPURCH')) THEN
                    IF NOT (("G/L Account No." = '21252108') OR ("G/L Account No." = '21252109')) THEN
                        CurrReport.SKIP;


                //--Tri. PG 07112006 -- Multi Voucher Printing
                mvarCtr := mvarCtr + 1;
                IF mCheckDocNo = "G/L Entry Document Loop"."Document No." THEN BEGIN
                    CurrReport.SKIP;
                END ELSE BEGIN
                    IF mvarCtr > 1 THEN CurrReport.NEWPAGE;
                END;
                mCheckDocNo := "G/L Entry Document Loop"."Document No.";
                //--Tri. PG 07112006 -- Multi Voucher Printing

            end;

            trigger OnPreDataItem()
            begin
                CLEAR(CustLedCheckBool);
                CLEAR(VendorLedCheck);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("View Detail"; ViewDetails)
                {
                    ApplicationArea = All;
                }
                field("View Dimension"; ViewDimen)
                {
                    ApplicationArea = All;
                }
                field("Print Narration"; PrintLineNarration)
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET();
    end;

    var
        GLAccount: Record "G/L Account";
        Bank: Record "Bank Account";
        Customer: Record Customer;
        vendor: Record Vendor;
        VendorledgEntry: Record "Vendor Ledger Entry";
        CustomerLedgEntry: Record "Cust. Ledger Entry";
        BankLedgEntry: Record "Bank Account Ledger Entry";
        Particulars: Text[250];
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        ToText: Text[30];
        DrText: Text[30];
        Name: Text[100];
        ViewDetails: Boolean;
        Desc: Text[250];
        CheckRep: Report "Check Report";
        NoText: array[2] of Text[80];
        DimensionValue: Record "Dimension Value";
        Dimension: Record Dimension;
        DimValue: Text[250];
        Dim: Text[250];
        LocationRec: Record Location;
        GenJournalBatch: Record "Gen. Journal Batch";
        BName: Text[250];
        LedgerEntryDim: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        LocationAddress: Text[250];
        ViewDimensions: Boolean;
        PurchInvHdr: Record "Purch. Inv. Header";
        VendorInvNo: Code[20];
        VendorInvDate: Date;
        CustInvNo: Code[20];
        CustInvDate: Date;
        SalesInvHdr: Record "Sales Invoice Header";
        mCheckDocNo: Code[20];
        mvarCtr: Integer;
        //RecPostNarration: Record 16548;
        PrintLineNarration: Boolean;
        "---OriUT-----": Integer;
        Narration: Text[1000];
        recpurchINvline: Record "Purch. Inv. Line";
        "G/L Entry2": Record "G/L Entry";
        var1: Text[1000];
        PurchInvHeader: Record "Purch. Inv. Header";
        TDSEntry: Record "TDS Entry";
        TDSAmt: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        VendorInvNo2: Code[30];
        VendorInvDate2: Date;
        TDSAmt2: Decimal;
        CompanyInfo: Record "Company Information";
        CheqNo: Code[30];
        CheqDate: Date;
        ViewDimen: Boolean;
        DebitSum: Decimal;
        CreditSum: Decimal;
        VendorLedCheck: Boolean;
        CustLedCheckBool: Boolean;
        DocNoGlob: Code[30];
        AmtInWORDS: array[10] of Text[100];
        CustLedCheckBool2: Boolean;
        VendorLedCheck2: Boolean;
        CreditAmt1: Decimal;
        DebitAmt2: Decimal;
}

