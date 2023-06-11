table 50088 "Item Wise Focused Prod."
{

    fields
    {
        field(1; "Goal Sheet Focused Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Goal Sheet Focused Product';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('GOALSHEET'));
        }
        field(2; "Tableau Zone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Goal Sheet Focused Product", "Tableau Zone")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

