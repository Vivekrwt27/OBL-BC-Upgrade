query 50008 "WS Colour Master"
{

    elements
    {
        dataitem(Dimension_Value; 349)
        {
            DataItemTableFilter = "Dimension Code" = FILTER('COLOUR');
            column("Code"; "Code")
            {
            }
            column(Name; Name)
            {
            }
            column(Blocked; Blocked)
            {
            }
        }
    }
}

