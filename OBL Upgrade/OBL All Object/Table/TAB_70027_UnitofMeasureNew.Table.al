table 70027 "Unit of Measure New"
{
    Caption = 'Unit of Measure';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Units of Measure";
    LookupPageID = "Units of Measure";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[10])
        {
            Caption = 'Description';
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

    trigger OnDelete()
    begin
        UnitOfMeasureTranslation.SETRANGE(Code, Code);
        UnitOfMeasureTranslation.DELETEALL;
    end;

    var
        UnitOfMeasureTranslation: Record "Unit of Measure Translation";
}

