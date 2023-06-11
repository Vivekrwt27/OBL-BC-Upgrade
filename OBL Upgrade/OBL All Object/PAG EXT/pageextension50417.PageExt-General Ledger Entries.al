pageextension 50417 pageextension50417 extends "General Ledger Entries"
{
    layout
    {

        addfirst(Control1)
        {
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                ApplicationArea = All;
            }
        }

        moveafter("Posting Date"; "Source Code", "Source Type", "Source No.", "Debit Amount", "Credit Amount")
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        addafter("Document Type")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("G/L Account No.")
        {
            field("System-Created Entry"; Rec."System-Created Entry")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; vendinvdate)
            {
                Caption = 'Vendor Invoice Date';
                ApplicationArea = All;
            }
            field("Transfer Shipment No."; trfInvno)
            {
                Caption = 'Transfer Shipment No.';
                ApplicationArea = All;
            }
        }
        moveafter("G/L Account No."; Reversed)
        moveafter("System-Created Entry"; "External Document No.")
        addafter(Amount)
        {
            field("Transfer Shipment Date"; trfshdt)
            {
                Caption = 'Transfer Shipment Date';
                ApplicationArea = All;
            }
        }
        modify("G/L Account Name")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter("Print Voucher")
        {
            action("Print Voucher In Order")
            {
                Caption = 'Print Voucher In Order';
                ApplicationArea = All;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    GLEntry.SETRANGE("Document No.", Rec."Document No.");
                    GLEntry.SETRANGE("Posting Date", Rec."Posting Date");
                    IF GLEntry.FINDFIRST THEN
                        REPORT.RUNMODAL(Report::"Applied Entries To Voucher", TRUE, TRUE, GLEntry);
                end;
            }
            action("GST Voucher")
            {
                Caption = 'GST Voucher';
                ApplicationArea = All;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    GLEntry.SETRANGE("Document No.", Rec."Document No.");
                    GLEntry.SETRANGE("Posting Date", Rec."Posting Date");
                    IF GLEntry.FINDFIRST THEN
                        REPORT.RUNMODAL(50379, TRUE, TRUE, GLEntry);
                end;
            }
        }
    }

    var
        DocType: Text[30];
        ItemLedgerEntry: Record "Item Ledger Entry";
        purchinvhead: Record "Purch. Inv. Header";
        vendinvdate: Date;
        transferrect: Record "Transfer Receipt Header";
        trfInvno: Code[20];
        trfshipdate: Record "Transfer Shipment Header";
        trfshdt: Date;
        dimval: Record "Dimension Value";
        naoname: Text[50];

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord1;

        IF purchinvhead.GET(Rec."Document No.") THEN
            vendinvdate := purchinvhead."Vendor Invoice Date"
        ELSE
            vendinvdate := 0D;

        IF transferrect.GET(Rec."Document No.") THEN
            transferrect.CALCFIELDS("Trf Shipment Inv No.");
        trfInvno := transferrect."Trf Shipment Inv No.";

        IF trfshipdate.GET(trfInvno) THEN
            trfshdt := trfshipdate."Posting Date";
        naoname := '';

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord1;
    end;


    local procedure OnAfterGetCurrRecord1()
    begin
        xRec := Rec;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Document No.", Rec."Document No.");
        IF ItemLedgerEntry.FINDFIRST THEN
            DocType := FORMAT(ItemLedgerEntry."Entry Type")
        ELSE
            DocType := '';
    end;
}

