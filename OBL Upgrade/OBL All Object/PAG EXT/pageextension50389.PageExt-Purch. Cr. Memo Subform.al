pageextension 50389 pageextension50389 extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify(ShortcutDimCode3)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(3, ShortcutDimCode[3]);
            end;
        }
        modify(ShortcutDimCode4)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(4, ShortcutDimCode[4]);
            end;
        }
        modify(ShortcutDimCode5)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }
        modify(ShortcutDimCode6)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(6, ShortcutDimCode[6]);
            end;
        }
        modify(ShortcutDimCode7)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(7, ShortcutDimCode[7]);
            end;
        }
        modify(ShortcutDimCode8)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
            end;
        }
        moveafter("No."; "Tax Liable", "Tax Group Code", "Tax Area Code")

        addafter("Tax Area Code")
        {
            field("Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
            }
        }

        moveafter("Posting Group"; "IC Partner Code", "GST Credit", "GST Group Code", "GST Group Type", "HSN/SAC Code")
        moveafter(ShortcutDimCode8; "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Description 2")

    }
    actions
    {
        addafter(GetReturnShipmentLines)
        {
            action("Detailed GST Entry Buffer")
            {
                RunObject = Page "Detailed GST Entry Buffer";
                RunPageLink = "Document No." = FIELD("Document No.");
                ShortCutKey = 'Ctrl+G';
                ApplicationArea = All;
            }
        }
    }

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;
}

