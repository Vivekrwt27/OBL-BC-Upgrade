query 50010 "WS Location"
{

    elements
    {
        dataitem(Location; 14)
        {
            DataItemTableFilter = Blocked = CONST(false);
            column("Code"; "Code")
            {
            }
            column(name; "Code")
            {
            }
            column(blocked; Blocked)
            {
            }
            column(last_modified_date; "Last Date Modified")
            {
            }
        }
    }
}

