pageextension 50413 pageextension50413 extends "Bank Receipt Voucher"
{

    //Unsupported feature: Property Modification (PageType) on ""Bank Receipt Voucher"(Page 16569)".

    layout
    {

        //Unsupported feature: Code Modification on "Control 33.OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.SetCodes(PAGE::"Bank Receipt Voucher",3,FALSE,FALSE);//6700
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        modify(Description)
        {
            Caption = 'Narration';
        }

        addafter("External Document No.")
        {
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
            }
            field("Issuing Bank"; Rec."Issuing Bank")
            {
                ApplicationArea = all;
            }
            field("GST Inv. Rounding Precision"; Rec."GST Inv. Rounding Precision")
            {
                ApplicationArea = All;
            }
            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = All;
            }


        }
        moveafter("External Document No."; "Ship-to Code", "GST on Advance Payment", "GST Group Code", "GST Group Type", "GST Place of Supply", "GST Vendor Type", "HSN/SAC Code")
        moveafter(Amount; "Debit Amount", "Credit Amount")
        addafter("Reason Code")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Reason Code"; Correction)
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }


    }

    actions
    {
        modify(Preview)
        {
            Visible = false;
        }

        modify(Post)
        {
            ShortcutKey = 'F9';
            trigger OnAfterAction()
            begin
                Rec.TESTFIELD("Shortcut Dimension 1 Code");

                IF Rec."External Document No." = '' THEN BEGIN
                    Rec.TESTFIELD("External Document No.")
                END
                ELSE
                    //code added in upgrade end(-)
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                CurrPage.UPDATE(FALSE);

            end;
        }
    }
    var
        CurrentJnlBatchName: Code[10];




}

