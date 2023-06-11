table 50057 "QD Buffer Table"
{

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Sales,Purchase';
            OptionMembers = " ",Sales,Purchase;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Document Line No."; Integer)
        {
        }
        field(5; "Entry No"; Integer)
        {
        }
        field(6; "Offer Code"; Code[20])
        {
            Caption = 'Offer Code';
            TableRelation = "Discount Header";
        }
        field(7; "Customer Entry"; Boolean)
        {
        }
        field(8; "Group Code"; Text[30])
        {
        }
        field(9; "Group Type"; Option)
        {
            OptionCaption = ' ,Item Type,Size,Tile Group,Item,State,Customer Type,Customer';
            OptionMembers = " ","Item Type",Size,"Tile Group",Item,State,"Customer Type",Customer;
        }
        field(10; Marks; Decimal)
        {
        }
        field(11; "Total Pts"; Decimal)
        {
            CalcFormula = Sum("QD Buffer Table".Marks WHERE("Type" = FIELD(Type),
                                                             "Document Type" = FIELD("Document Type"),
                                                             "Document No." = FIELD("Document No."),
                                                             "Document Line No." = FIELD("Document Line No."),
                                                             "Offer Code" = FIELD("Offer Code")));
            FieldClass = FlowField;
        }
        field(12; All; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Type, "Document Type", "Document No.", "Entry No", "Document Line No.")
        {
            SumIndexFields = Marks;
        }
        key(Key2; Type, "Document Type", "Document No.", "Document Line No.", "Offer Code", "Customer Entry")
        {
            Clustered = true;
            SumIndexFields = Marks;
        }
        key(Key3; Type, "Document Type", "Document No.", "Offer Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        GetEntryNo;
    end;

    procedure GetEntryNo()
    var
        QDBufferTable: Record "QD Buffer Table";
    begin
        QDBufferTable.RESET;
        IF QDBufferTable.FINDLAST THEN
            "Entry No" := QDBufferTable."Entry No" + 1
        ELSE
            "Entry No" := 1;
    end;
}

