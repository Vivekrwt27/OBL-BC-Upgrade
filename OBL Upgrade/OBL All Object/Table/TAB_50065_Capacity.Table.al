table 50065 Capacity
{

    fields
    {
        field(1; "Production Line"; Code[10])
        {
            TableRelation = Location."Code" WHERE("Production Location" = CONST(true));
        }
        field(2; Size; Code[10])
        {
        }
        field(3; Capicity; Decimal)
        {
        }
        field(4; "type Category Code"; Code[2])
        {
        }
        field(5; "Capacity Prod"; Decimal)
        {
        }
        field(6; Body; Decimal)
        {
        }
        field(7; Glaze; Decimal)
        {
        }
        field(8; Packing; Decimal)
        {
        }
        field(9; "S&S"; Decimal)
        {
        }
        field(10; "V Cw/f"; Decimal)
        {
        }
        field(11; "Gas Cost"; Decimal)
        {
        }
        field(12; Other; Decimal)
        {
        }
        field(13; "P&F"; Decimal)
        {
        }
        field(14; Total; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Production Line", "type Category Code", Size)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

