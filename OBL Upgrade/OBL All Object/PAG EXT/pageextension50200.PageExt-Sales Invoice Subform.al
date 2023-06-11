pageextension 50200 pageextension50200 extends "Sales Invoice Subform"
{
    layout
    {

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Supplementary: Boolean;
            begin
                Supplementary := TRUE;   //TRI DG
            end;
        }


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
        addafter("Line Discount Amount")
        {
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }

        moveafter("No."; Description, "Description 2")
        moveafter("VAT Prod. Posting Group"; "GST Place Of Supply", "GST Group Code", "GST Group Type", "HSN/SAC Code", "GST Jurisdiction Type")
        modify("GST Group Type")
        {
            Editable = true;
        }
        moveafter("Line No."; "Gen. Prod. Posting Group", "Tax Category", "Deferral Code", Exempted)
        addafter("Line No.")
        {
            field("Invoice Type"; Rec."Invoice Type")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        modify(Exempted)
        {
            Visible = false;
        }
    }

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;
}

