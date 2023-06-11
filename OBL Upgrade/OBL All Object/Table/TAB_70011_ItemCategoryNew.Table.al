table 70011 "Item Category New"
{
    Caption = 'Item Category';
    LookupPageID = "Item Categories";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[60])
        {
            Caption = 'Description';
        }
        field(4; "Def. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Def. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(5; "Def. Inventory Posting Group"; Code[10])
        {
            Caption = 'Def. Inventory Posting Group';
            TableRelation = "Inventory Posting Group".Code;
        }
        field(6; "Def. Tax Group Code"; Code[10])
        {
            Caption = 'Def. Tax Group Code';
            TableRelation = "Tax Group".Code;
        }
        field(7; "Def. Costing Method"; Option)
        {
            Caption = 'Def. Costing Method';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(8; "Def. VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Def. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(50000; "Excise Product Posting Group"; Code[10])
        {
            // TableRelation = "Excise Prod. Posting Group";//16225 TABLE N/F
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

