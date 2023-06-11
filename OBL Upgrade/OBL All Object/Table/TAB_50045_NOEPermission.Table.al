table 50045 "NOE Permission"
{

    fields
    {
        field(2; NOE; Code[15])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('NOE'));
        }
        field(11; SNOE; Code[15])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SNOE'));
        }
        field(12; Approver; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(13; Limit; Decimal)
        {
        }
        field(14; Location; Code[20])
        {
            TableRelation = Location;
        }
        field(15; Name; Text[100])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Code" = FIELD(NOE),
                                                               "Dimension Code" = CONST('NOE')));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; NOE, Location, Approver, Limit)
        {
        }
        key(Key2; Limit)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        //fieldgroup(Primary; Field1, NOE, Approver, Location, Limit) //16225 Field1 N/F 
        fieldgroup(Primary; NOE, Approver, Location, Limit)
        {
        }
    }
}

