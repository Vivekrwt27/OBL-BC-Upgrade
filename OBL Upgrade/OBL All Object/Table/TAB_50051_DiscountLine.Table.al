table 50051 "Discount Line"
{

    fields
    {
        field(1; "Document No."; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(4; "Line No."; Integer)
        {
        }
        field(5; "Group Type"; Option)
        {
            OptionMembers = "Item Type",Size,"Tile Group",Item;

            trigger OnValidate()
            begin
                IF Description <> '' THEN
                    Description := '';
            end;
        }
        field(6; "Code"; Code[20])
        {
        }
        field(7; "Include/Exclude"; Option)
        {
            OptionMembers = Include,Exclude;
        }
        field(10; All; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Code, '');

                // For Item type
                DiscountLine.RESET;
                DiscountLine.SETRANGE("Group Type", "Group Type"::"Item Type");
                DiscountLine.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                DiscountLine.SETFILTER(Code, '<>%1', '');
                IF DiscountLine.FINDFIRST THEN;
                //ERROR(Text50000,DiscountLine."Document No.");
            end;
        }
        field(12; "Valid From"; Date)
        {
        }
        field(13; "Valid To"; Date)
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = ' ,Enable,Disable';
            OptionMembers = " ",Enable,Disable;
        }
        field(15; Description2; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Status, All, "Valid From", "Valid To")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DiscountHeader.RESET;
        DiscountHeader.SETRANGE(DiscountHeader."No.", "Document No.");
        IF DiscountHeader.FIND('-') THEN BEGIN
            // Status:=DiscountHeader.Status;
        END;

        IF Status = Status::Enable THEN BEGIN
            ERROR(Text50002);

        END;
    end;

    trigger OnInsert()
    begin
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Document No.", "Document No.");
        DiscountLine.SETRANGE("Group Type", "Group Type");
        DiscountLine.SETRANGE(Code, Code);

        IF DiscountLine.FIND('-') THEN
            REPEAT
                IF DiscountLine."Line No." <> "Line No." THEN
                    ERROR(Text50001, "Group Type");
            UNTIL DiscountLine.NEXT = 0;
    end;

    trigger OnModify()
    begin
        DiscountHeader.RESET;
        DiscountHeader.SETRANGE(DiscountHeader."No.", "Document No.");
        IF DiscountHeader.FIND('-') THEN BEGIN
            Status := DiscountHeader.Status;
        END;

        IF Status = Status::Enable THEN BEGIN
            //  ERROR(Text50002);
        END;
    end;

    var
        Text50000: Label 'Item Type(s) already defined for Discount No. %1.';
        DiscountLine: Record "Discount Line";
        Text50001: Label 'This %1 already exists in the offer with the same Status';
        DiscountHeader: Record "Discount Header";
        Text50002: Label 'You cannot change Discount offer after it Enabled';
}

