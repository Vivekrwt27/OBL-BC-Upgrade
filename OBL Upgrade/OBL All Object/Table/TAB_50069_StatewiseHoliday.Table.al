table 50069 "State wise Holiday"
{

    fields
    {
        field(1; "State Code"; Code[10])
        {
            TableRelation = State;
        }
        field(10; Date; Date)
        {
        }
        field(15; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "State Code", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

