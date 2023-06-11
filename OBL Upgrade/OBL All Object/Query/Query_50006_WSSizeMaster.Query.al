query 50006 "WS Size Master"
{

    elements
    {
        dataitem(Dimension_Value; 349)
        {
            DataItemTableFilter = "Dimension Code" = FILTER('SIZE');
            column("code"; "Code")
            {
            }
            column(name; Name)
            {
            }
            column(blocked; Blocked)
            {
            }
            column(last_modified_date; "Last Modify Date")
            {
            }
        }
    }
}

