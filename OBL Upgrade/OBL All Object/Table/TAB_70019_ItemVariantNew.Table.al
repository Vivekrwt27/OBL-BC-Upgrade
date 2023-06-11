table 70019 "Item Variant New"
{
    Caption = 'Item Variant';
    DataCaptionFields = "Item No.", "Code", Description;
    LookupPageID = "Item Variants";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(4; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
        }
    }

    keys
    {
        key(Key1; "Item No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ItemTranslation: Record "Item Translation";
        SKU: Record "Stockkeeping Unit";
        ItemIdent: Record "Item Identifier";
    begin
        ItemTranslation.SETRANGE("Item No.", "Item No.");
        ItemTranslation.SETRANGE("Variant Code", Code);
        ItemTranslation.DELETEALL;

        SKU.SETRANGE("Item No.", "Item No.");
        SKU.SETRANGE("Variant Code", Code);
        SKU.DELETEALL(TRUE);

        ItemIdent.RESET;
        ItemIdent.SETCURRENTKEY("Item No.");
        ItemIdent.SETRANGE("Item No.", "Item No.");
        ItemIdent.SETRANGE("Variant Code", Code);
        ItemIdent.DELETEALL;
    end;
}

