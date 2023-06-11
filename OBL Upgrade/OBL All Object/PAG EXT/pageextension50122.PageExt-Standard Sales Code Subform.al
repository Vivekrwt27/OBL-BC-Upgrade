pageextension 50122 pageextension50122 extends "Standard Sales Code Subform"
{
    layout
    {
        modify("ShortcutDimCode[3]")
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(3, ShortcutDimCode[3]);
            end;
        }
        modify("ShortcutDimCode[4]")
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }

        modify("ShortcutDimCode[6]")
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(6, ShortcutDimCode[6]);
            end;
        }
        modify("ShortcutDimCode[7]")
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(7, ShortcutDimCode[7]);
            end;
        }

        modify("ShortcutDimCode[8]")
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
            end;
        }


    }

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;
}

