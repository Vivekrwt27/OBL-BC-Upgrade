table 50048 "IC Out Header"
{
    DrillDownPageID = "Posted IC Transfer - Out List";
    LookupPageID = "Posted IC Transfer - Out List";

    fields
    {
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Inter Company';
            OptionMembers = "Inter Company";
        }
        field(20; "No."; Code[20])
        {
        }
        field(30; "From Company"; Text[30])
        {
        }
        field(40; "To Company"; Text[30])
        {
            TableRelation = Company;
        }
        field(50; "From Location"; Code[20])
        {
        }
        field(60; "To Location"; Code[20])
        {
        }
        field(70; "Posting Date"; Date)
        {
        }
        field(80; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(90; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(100; "No. Series"; Code[20])
        {
        }
        field(110; "Transfer Type"; Option)
        {
            OptionCaption = 'Transfer In,Transfer Out';
            OptionMembers = "Transfer In","Transfer Out";
        }
        field(50001; "IC Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'IC Gen. Bus. Posting Group';
            Description = 'MSBS.Rao';
            TableRelation = "Gen. Business Posting Group";
        }
    }

    keys
    {
        key(Key1; "Transfer Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TEXT50000: Label 'From Company and To Company cannot be Same';
}

