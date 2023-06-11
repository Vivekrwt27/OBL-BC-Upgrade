page 50179 "Customer To Customer Contra"
{
   /*  AutoSplitKey = true;
    Caption = 'General Journal Customize';
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Gen. Journal Line  Customize";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Include Serv. Tax in TDS Base"; Rec."Include Serv. Tax in TDS Base")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Tax Type"; Rec."Service Tax Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("GTA Service Type"; Rec."GTA Service Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Declaration Form (GTA)"; Rec."Declaration Form (GTA)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("T.C.A.N. No."; Rec."T.C.A.N. No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("T.A.N. No."; Rec."T.A.N. No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("E.C.C. No."; Rec."E.C.C. No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
                {
                    Caption = 'TCS Nature of Collection';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assessee Code"; Rec."Assessee Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("TDS/TCS %"; Rec."TDS/TCS %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TDS/TCS Amount"; Rec."TDS/TCS Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Surcharge %"; Rec."Surcharge %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Surcharge Amount"; Rec."Surcharge Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("eCESS %"; Rec."eCESS %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("eCESS on TDS/TCS Amount"; Rec."eCESS on TDS/TCS Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("SHE Cess % on TDS/TCS"; Rec."SHE Cess % on TDS/TCS")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("SHE Cess on TDS/TCS Amount"; Rec."SHE Cess on TDS/TCS Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total TDS/TCS Incl. SHE CESS"; Rec."Total TDS/TCS Incl. SHE CESS")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Work Tax Base Amount"; Rec."Work Tax Base Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Tax %"; Rec."Work Tax %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Tax Amount"; Rec."Work Tax Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
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
                field("Currency Code"; Rec."Currency Code")
                {
                    AssistEdit = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bal. VAT Amount"; Rec."Bal. VAT Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bal. VAT Difference"; Rec."Bal. VAT Difference")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
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
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
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
                field("Service Tax Rounding Type"; Rec."Service Tax Rounding Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                }
                field("Service Tax Rounding Precision"; Rec."Service Tax Rounding Precision")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
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
                        IF CONFIRM('Do You want post!', FALSE) THEN BEGIN
                            CreateEntry(Rec);
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
        OnActivateForm;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        AccName: Text[50];
        BalAccName: Text[50];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        Text000: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        OpenedFromBatch: Boolean;
        Text13700: Label 'Select the TDS payable account against payment is to be made.';
        Text13701: Label 'There are no tds entries for account %1.';
        Text13702: Label 'Select the Work Tax payable account against payment is to be made.';
        Text13703: Label 'There are no work tax entries for account %1.';
        Text13704: Label 'Select the Sales tax payable account against which payment is to be made.';
        Text13705: Label 'There are no Sales tax entries for Account %1.';
        Text13706: Label 'Select the Excise payable account against which payment is to be made.';
        Text13707: Label 'There are no excise entries for account %1.';
        Text16350: Label 'Select the VAT Payable Account against which payment is to be made.';
        Text16351: Label 'There are no VAT Entries for Account No. %1.';
        Text16352: Label 'There are no VAT Entries available for Refund.';
        Text16353: Label 'Account Type must be G/L Account or Bank Account,';
        RecGLAccount: Record "G/L Account";
        RecGLAccount1: Record "G/L Account";
        RecCustomer: Record Customer;
        GenJournlLine: Record "Gen. Journal Line";
        LineNO: Decimal;
        PurSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Docno: Code[10];
        RecJLine: Record "Gen. Journal Line  Customize";
        SaleSetup: Record "Sales & Receivables Setup";

    local procedure UpdateBalance()
    begin
    end;


    procedure CreateEntry(GJL: Record "Gen. Journal Line  Customize")
    begin
        //Docno := 'ABC-0001';
        SaleSetup.GET;
        SaleSetup.TESTFIELD(SaleSetup."Inter Customer A/c");
        GJL.TESTFIELD("Location Code");
        //LineNO := 10000;

        CLEAR(GenJournlLine);
        GenJournlLine.INIT;

        GenJournlLine.RESET;
        GenJournlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournlLine.SETRANGE("Journal Batch Name", 'INTERCUST');
        IF GenJournlLine.FINDLAST THEN
            GenJournlLine."Line No." += 10000
        ELSE
            GenJournlLine."Line No." := 10000;

        GenJournlLine."Journal Template Name" := 'GENERAL';
        GenJournlLine."Journal Batch Name" := 'INTERCUST';

        GenJournlLine.SetUpNewLine(GenJournlLine, 0, FALSE);

        GenJournlLine."Account Type" := GenJournlLine."Account Type"::Customer;
        GenJournlLine.VALIDATE("Account No.", GJL."Account No.");
        GenJournlLine."Posting Date" := WORKDATE;
        GenJournlLine."External Document No." := rec."External Document No.";
        GenJournlLine."Document Type" := Rec."Document Type"::"Credit Memo";
        GenJournlLine."Bal. Account Type" := GenJournlLine."Account Type"::"G/L Account";
        GenJournlLine."Bal. Account No." := SaleSetup."Inter Customer A/c";
        GenJournlLine.VALIDATE(Amount, -1 * GJL.Amount);
        GenJournlLine.VALIDATE("Location Code", GJL."Location Code");
        GenJournlLine."Source Code" := 'INTERCUST';
        //GenJournlLine.ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        //GenJournlLine.ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        GenJournlLine.INSERT;
        // GenJournlLine.Narration := GJL.Narration;
        GenJournlLine.MODIFY;

        COMMIT;

        //For Second Entry

        GenJournlLine.RESET;
        GenJournlLine.INIT;
        GenJournlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournlLine.SETRANGE("Journal Batch Name", 'INTERCUST');
        IF GenJournlLine.FINDLAST THEN
            GenJournlLine."Line No." += 10000
        ELSE
            GenJournlLine."Line No." := 10000;

        GenJournlLine.SetUpNewLine(GenJournlLine, 0, FALSE);
        GenJournlLine."Account Type" := GenJournlLine."Account Type"::Customer;
        GenJournlLine.VALIDATE("Account No.", GJL."Bal. Account No.");
        GenJournlLine."Posting Date" := WORKDATE;
        GenJournlLine."Document Type" := Rec."Document Type"::Invoice;
        GenJournlLine."Bal. Account Type" := GenJournlLine."Account Type"::"G/L Account";
        GenJournlLine.VALIDATE("Bal. Account No.", SaleSetup."Inter Customer A/c");
        GenJournlLine.VALIDATE(Amount, GJL.Amount);
        GenJournlLine.VALIDATE("Location Code", GJL."Location Code");
        GenJournlLine."Source Code" := 'INTERCUST';
        //GenJournlLine.ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        //GenJournlLine.ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        GenJournlLine.INSERT;
        //GenJournlLine.Narration := GJL.Narration;
        GenJournlLine.MODIFY;
        COMMIT;

        CODEUNIT.RUN(Codeunit::"Gen. Jnl.-Post Batch", GenJournlLine);

        rec.DELETE;

        //RecJLine.RESET;
        //RecJLine.SETRANGE("Document No.","Document No.");
        //IF RecJLine.FINDFIRST THEN BEGIN
        //  REPEAT
        //   RecJLine.DELETE;
        //UNTIL RecJLine.NEXT=0;
        //END;
    end;

    local procedure OnActivateForm()
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
    end;

    local procedure OnBeforePutRecord()
    begin
        rec."Account Type" := rec."Account Type"::Customer;
        rec."Bal. Account Type" := rec."Bal. Account Type"::Customer;
    end;
 */}

