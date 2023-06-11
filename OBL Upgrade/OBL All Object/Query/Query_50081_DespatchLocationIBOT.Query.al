query 50081 "Despatch Location IBOT"
{

    elements
    {
        dataitem(Location; 14)
        {
            DataItemTableFilter = "Tableau Location" = FILTER('Yes'),
Code = FILTER('DRA-WH-MFG|SKD-WH-MFG|HSK-WH-MFG|DP-MORBI');
            column("Code"; "Code")
            {
            }
            column(Despatch_Name; "Location Name")
            {
            }
        }
    }
}

