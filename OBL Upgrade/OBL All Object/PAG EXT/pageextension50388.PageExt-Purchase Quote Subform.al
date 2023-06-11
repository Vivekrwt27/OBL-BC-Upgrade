pageextension 50388 pageextension50388 extends "Purchase Quote Subform"
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
        moveafter(Description; "Description 2")
    }

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;
}

