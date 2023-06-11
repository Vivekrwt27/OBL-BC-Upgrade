query 50088 "Employee Detail IBOT"
{

    elements
    {
        dataitem(Salesperson_Purchaser; 13)
        {
            DataItemTableFilter = "Employee Type" = FILTER(<> ' ');
            column(Employee_Code; "Code")
            {
            }
            column(Employee_Name; Name)
            {
            }
            column(Employee_Type; "Employee Type")
            {
            }
        }
    }
}

