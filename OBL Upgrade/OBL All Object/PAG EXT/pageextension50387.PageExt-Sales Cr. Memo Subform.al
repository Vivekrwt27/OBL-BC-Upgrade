pageextension 50387 pageextension50387 extends "Sales Cr. Memo Subform"
{
    layout
    {
        moveafter("No."; "Gen. Prod. Posting Group")
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
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
        addafter("No.")
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
            }

        }
        addafter(ShortcutDimCode8)
        {

            field("Assessee Code"; Rec."Assessee Code")
            {
                ApplicationArea = All;
            }
            /*    field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
               {
                   ApplicationArea = All;
               } */

            field("Return Receipt No."; Rec."Return Receipt No.")
            {
                ApplicationArea = All;
            }
            field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
            {
                ApplicationArea = all;
            }
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = all;
                Editable = true;
            }

        }
        moveafter("Return Receipt No."; "Gen. Prod. Posting Group", "Tax Group Code", "Description 2")
    }

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        RecSalesHeader: Record "Sales Header";
    begin
        RecSalesHeader.Reset;
        RecSalesHeader.SetRange("No.", Rec."Document No.");
        if RecSalesHeader.FindFirst then begin
            RecSalesHeader."Trade Discount" := 0;
            RecSalesHeader."Structure Freight Amount" := 0;
            RecSalesHeader."Discount Amount" := 0;
            RecSalesHeader."Insurance Amount" := 0;

            RecSalesHeader.Modify;

            CurrPage.Update;
        end;
    end;

}