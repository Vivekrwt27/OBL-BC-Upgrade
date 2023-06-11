tableextension 50136 tableextension50136 extends "Post Code"
{
    fields
    {
        field(50095; Longitude; Decimal)
        {
        }
        field(50096; Latitude; Decimal)
        {
        }
        field(50097; Zone; Text[7])
        {
        }
        field(50098; "Old Post Code"; Code[20])
        {
        }
        field(50099; "CD Not Allowed"; Boolean)
        {
            Description = 'Uncheck to Disable the CD % Field';
        }
        field(50100; "Town Pop Category"; Text[30])
        {
        }
        field(50101; Population; Decimal)
        {
        }
        field(50102; "State Code"; Code[10])
        {
            CalcFormula = Lookup(Customer."State Code" WHERE("Post Code" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; "State Name"; Text[30])
        {
            CalcFormula = Lookup(Customer."State Desc." WHERE("Post Code" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50104; "Sales Terretory"; Code[10])
        {
            CalcFormula = Lookup(Customer."Area Code" WHERE("Post Code" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Matrix Master"."Type 1";
        }
    }
}

