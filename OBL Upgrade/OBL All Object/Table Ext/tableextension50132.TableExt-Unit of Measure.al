tableextension 50132 tableextension50132 extends "Unit of Measure"
{
    fields
    {
        field(50100; "E-Way Code"; Code[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50101; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

