page 50083 "General Journal not posted"
{
    AutoSplitKey = true;
    Caption = 'General Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Gen. Journal Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    //CurrentJnlBatchNameOnAfterValidate;
                    CurrentJnlBatchNameOnAfterVali
                end;
            }
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Party Code"; Rec."Party Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("T.A.N. No."; Rec."T.A.N. No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                /*field("E.C.C. No."; Rec."E.C.C. No.")
                {
                    Visible = false;
                }
                field(Narration; Rec.Narration)
                {
                }*/
                field(Description2; Rec.Description2)
                {
                    ApplicationArea = All;
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*field(Deferred; Rec.Deferred)
                {
                    Visible = false;
                }
                field("Excise Charge"; Rec."Excise Charge")
                {
                    Visible = false;
                }
                field(PLA; Rec.PLA)
                {
                    Visible = false;
                }*/
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*field("Assessee Code"; Rec."Assessee Code")
                {
                    Visible = false;
                }
                field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
                {
                    Visible = false;
                }
                field("TDS/TCS %"; Rec."TDS/TCS %")
                {
                    Visible = false;
                }
                field("TDS/TCS Amount"; Rec."TDS/TCS Amount")
                {
                    Visible = false;
                }
                field("Surcharge %"; Rec."Surcharge %")
                {
                    Visible = false;
                }
                field("Surcharge Amount"; Rec."Surcharge Amount")
                {
                    Visible = false;
                }
                field("TDS/TCS Amt Incl Surcharge"; Rec."TDS/TCS Amt Incl Surcharge")
                {
                    Visible = false;
                }
                field("eCESS %"; Rec."eCESS %")
                {
                    Visible = false;
                }
                field("eCESS on TDS/TCS Amount"; Rec."eCESS on TDS/TCS Amount")
                {
                    Visible = false;
                }
                field("Total TDS/TCS Incl. SHE CESS"; Rec."Total TDS/TCS Incl. SHE CESS")
                {
                    Visible = false;
                }*/
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*  field("Work Tax Base Amount"; Rec."Work Tax Base Amount")
                  {
                      Visible = false;
                  }
                  field("Work Tax %"; Rec."Work Tax %")
                  {
                      Visible = false;
                  }
                  field("Work Tax Amount"; Rec."Work Tax Amount")
                  {
                      Visible = false;
                  }*/
                field("Currency Code"; Rec."Currency Code")
                {
                    AssistEdit = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");

                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal. Gen. Posting Type"; Rec."Bal. Gen. Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Bal. Gen. Bus. Posting Group"; Rec."Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Bal. Gen. Prod. Posting Group"; Rec."Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to/Order Address Code"; Rec."Ship-to/Order Address Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Payment Type"; Rec."Bank Payment Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*field("Service Tax Registration No."; Rec."Service Tax Registration No.")
                {
                    Visible = false;
                }
                field("Service Tax Entry"; Rec."Service Tax Entry")
                {
                    Visible = false;
                }
                field("Goes to Excise Entry"; Rec."Goes to Excise Entry")
                {
                }
                field("Check Printed"; Rec."Check Printed")
                {
                    Editable = false;
                }*/
            }
            group(General)
            {
                /*field(AccName; Rec.AccName)
                {
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(BalAccName; Rec.BalAccName)
                {
                    Caption = 'Bal. Account Name';
                    Editable = false;
                }*/
                field(Balance; Balance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                    ApplicationArea = All;
                }
                field(TotalBalance; TotalBalance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Dim. Values per Account";
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Codeunit "Gen. Jnl.-Show Card";
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Codeunit "Gen. Jnl.-Show Entries";
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
            }
            group("&Payments")
            {
                Caption = '&Payments';
                action("P&review Check")
                {
                    Caption = 'P&review Check';
                    RunObject = Page "Check Preview";
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                                  "Journal Batch Name" = FIELD("Journal Batch Name"),
                                  "Line No." = FIELD("Line No.");
                    ApplicationArea = All;
                }
                action("Print Check")
                {
                    Caption = 'Print Check';
                    Ellipsis = true;
                    Image = PrintCheck;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        GenJnlLine.RESET;
                        GenJnlLine.COPY(Rec);
                        GenJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        GenJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                        DocPrint.PrintCheck(GenJnlLine);
                        //REPORT.RUNMODAL(50087,TRUE,TRUE,GenJnlLine);
                        CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance", Rec);
                    end;
                }
                action("Void Check")
                {
                    Caption = 'Void Check';
                    Image = VoidCheck;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Bank Payment Type", Rec."Bank Payment Type"::"Computer Check");
                        Rec.TESTFIELD("Check Printed", TRUE);
                        IF CONFIRM(Text000, FALSE, Rec."Document No.") THEN
                            CheckManagement.VoidCheck(Rec);
                    end;
                }
                action("Void &All Checks")
                {
                    Caption = 'Void &All Checks';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM(Text010, FALSE) THEN BEGIN
                            GenJnlLine.RESET;
                            GenJnlLine.COPY(Rec);
                            GenJnlLine.SETRANGE("Bank Payment Type", Rec."Bank Payment Type"::"Computer Check");
                            GenJnlLine.SETRANGE("Check Printed", TRUE);
                            IF GenJnlLine.FIND('-') THEN
                                REPEAT
                                    GenJnlLine2 := GenJnlLine;
                                    CheckManagement.VoidCheck(GenJnlLine2);
                                UNTIL GenJnlLine.NEXT = 0;
                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    RunObject = Codeunit "Gen. Jnl.-Apply";
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    RunObject = Codeunit "Adjust Gen. Journal Balance";
                    ApplicationArea = All;
                }
                action("Pay TDS")
                {
                    Caption = 'Pay TDS';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // NAVIN
                        IF Rec."Document No." = '' THEN
                            Rec.TESTFIELD("Document No.");
                        IF Rec."Account No." = '' THEN
                            ERROR(Text001)
                        ELSE BEGIN
                            Rec.TESTFIELD("T.A.N. No.");
                            CLEAR(TDSEntryForm);
                            Rec."Pay TDS" := TRUE;
                            Rec.MODIFY;
                            TDSEntry.RESET;
                            TDSEntry.SETRANGE("Account No.", Rec."Account No.");
                            TDSEntry.SETRANGE("T.A.N. No.", Rec."T.A.N. No.");
                            TDSEntry.SETFILTER("Total TDS Including SHE CESS", '<>%1', 0);
                            TDSEntry.SETRANGE("TDS Paid", FALSE);
                            IF TDSEntry.FIND('-') THEN BEGIN
                                // 16630      TDSEntryForm.SetBatch(Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Line No.");
                                TDSEntryForm.SETTABLEVIEW(TDSEntry);
                                TDSEntryForm.RUN;
                            END ELSE BEGIN
                                MESSAGE(Text008, Rec."Account No.");
                                Rec."Pay TDS" := FALSE;
                                Rec.MODIFY;
                            END;
                        END;
                        // NAVIN
                    end;
                }
                action("Pay Worktax")
                {
                    Caption = 'Pay Worktax';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // NAVIN
                        IF Rec."Account No." = '' THEN
                            ERROR(Text002)
                        ELSE BEGIN
                            /*   CLEAR(WorkTaxEntryForm);
                               "Pay Work Tax" := TRUE;
                               Rec.MODIFY;
                               TDSEntry.RESET;
                               TDSEntry.SETRANGE("Work Tax Account", Rec."Account No.");
                               TDSEntry.SETRANGE("Work Tax Paid", FALSE);
                               IF TDSEntry.FIND('-') THEN BEGIN
                                   WorkTaxEntryForm.SetBatch(Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Line No.");
                                   WorkTaxEntryForm.SETTABLEVIEW(TDSEntry);
                                   WorkTaxEntryForm.RUN;
                               END ELSE BEGIN
                                   MESSAGE(Text009, Rec."Account No.");
                                   "Pay Work Tax" := FALSE;
                                   Rec.MODIFY;
                               END;*/ // 16630
                        END;
                        // NAVIN
                    end;
                }
                action("Pay Salestax")
                {
                    Caption = 'Pay Salestax';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // NAVIN
                        IF Rec."Account No." = '' THEN
                            ERROR(Text005)
                        ELSE BEGIN
                            /*    "Pay Sales Tax" := TRUE;
                                Rec.MODIFY;
                                TaxEntry.SETRANGE(Rec."Account No.", Rec."Account No.");
                                TaxEntry.SETRANGE(Type, TaxEntry.Type::Sale);
                                TaxEntry.SETRANGE(Paid, FALSE);
                                IF TaxEntry.FIND('-') THEN BEGIN
                                    TaxEntryForm.SetBatch(Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Line No.");
                                    TaxEntryForm.SETTABLEVIEW(TaxEntry);
                                    TaxEntryForm.RUN;
                                    // FORM.RUN(FORM::"Pay Sales tax",TaxEntry)
                                END ELSE BEGIN
                                    MESSAGE(Text003, Rec."Account No.");
                                    "Pay Sales Tax" := FALSE;
                                    Rec.MODIFY;
                                END;*/ // 16630
                        END;
                        // NAVIN
                    end;
                }
                action("Pay Excise")
                {
                    Caption = 'Pay Excise';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // NAVIN
                        IF Rec."Document No." = '' THEN
                            Rec.TESTFIELD("Document No.");
                        IF Rec."Account No." = '' THEN
                            ERROR(Text006)
                        ELSE BEGIN
                            /*    Rec.TESTFIELD("E.C.C. No.");
                                CLEAR(ExciseForm);
                                "Pay Excise" := TRUE;
                                Rec.MODIFY;
                                ExciseEntry.RESET;
                                ExciseEntry.SETRANGE(Rec."Account No.", Rec."Account No.");
                                ExciseEntry.SETRANGE("E.C.C. No.", "E.C.C. No.");
                                ExciseEntry.SETFILTER(Type, '%1|%2', ExciseEntry.Type::Sale, ExciseEntry.Type::Charges);
                                ExciseEntry.SETFILTER(Rec."Document Type", '<>%1', ExciseEntry."Document Type"::"Credit Memo");
                                ExciseEntry.SETRANGE(Paid, FALSE);
                                IF ExciseEntry.FIND('-') THEN BEGIN
                                    ExciseForm.SetBatch(Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Line No.");
                                    ExciseForm.SETTABLEVIEW(ExciseEntry);
                                    ExciseForm.RUN;
                                END ELSE BEGIN
                                    MESSAGE(Text007, Rec."Account No.");
                                    "Pay Excise" := FALSE;
                                    Rec.MODIFY;
                                END;*/ // 16630
                        END;
                        // NAVIN
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.RUN;
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action("Test Report1")
                {
                    Caption = 'Test Report1';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        GenJournalLine.RESET;
                        GenJournalLine.SETFILTER(GenJournalLine."Journal Template Name", Rec."Journal Template Name");
                        GenJournalLine.SETFILTER(GenJournalLine."Journal Batch Name", Rec."Journal Batch Name");
                        GeneralJournalVoucher.SETTABLEVIEW(GenJournalLine);
                        GeneralJournalVoucher.RUN;
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := TRUE;
        BalanceVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
        Rec.SetUpNewLine(xRec, Balance, BelowxRec);
        CLEAR(ShortcutDimCode);
        CLEAR(AccName);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        AccName: Text[30];
        BalAccName: Text[30];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        "--NAVIN--": Integer;
        TDSEntry: Record "TDS Entry";
        // 16630    TaxEntry: Record 13700;
        // 16630    ExciseEntry: Record 13712;
        VATEntry: Record "VAT Entry";
        Text001: Label 'Select the TDS payable account against payment is to be made.';
        Text002: Label 'Select the Work Tax payable account against payment is to be made.';
        Text003: Label 'There are no Sales tax entries for Account %1.';
        Text005: Label 'Select the Sales tax payable account against which payment is to be made.';
        Text006: Label 'Select the Excise payable account against which payment is to be made.';
        Text007: Label 'There are no excise entries for account %1.';
        Text008: Label 'There are no tds entries for account %1.';
        Text009: Label 'There are no work tax entries for account %1.';
        Text16350: Label 'Select the VAT Payable Account against which payment is to be made.';
        Text16351: Label 'There are no VAT Entries for Account No. %1.';
        GenJournalLine: Record "Gen. Journal Line";
        GeneralJournalVoucher: Report "Sales Journal";
        GenJnlLine: Record "Gen. Journal Line";
        DocPrint: Codeunit "Document-Print";
        CheckManagement: Codeunit CheckManagement;
        GenJnlLine2: Record "Gen. Journal Line";
        Text000: Label 'Void Check %1?';
        Text010: Label 'Void all printed checks?';
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;
        TDSEntryForm: Page "Pay TDS";
        // 16630    WorkTaxEntryForm: Page 13723;
        // 16630    TaxEntryForm: Page 13797;
        // 16630    ExciseForm: Page 13701;
        GLReconcile: Page Reconciliation;
        ChangeExchangeRate: Page "Change Exchange Rate";

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
    end;
}

