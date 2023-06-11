query 50069 "PCH SalesPerson"
{

    elements
    {
        dataitem(Customer; 18)
        {
            filter(PCHFilters; "PCH Code")
            {
            }
            column(PCH_Code; "PCH Code")
            {
            }
            column(PCH_Name; "PCH Name")
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column("Count")
            {
                Method = Count;
            }
        }
    }
}

