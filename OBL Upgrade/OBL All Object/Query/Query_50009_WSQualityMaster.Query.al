query 50009 "WS Quality Master"
{

    elements
    {
        dataitem(Dimension_Value; 349)
        {
            DataItemTableFilter = "Dimension Code" = FILTER('QUALITY');
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

