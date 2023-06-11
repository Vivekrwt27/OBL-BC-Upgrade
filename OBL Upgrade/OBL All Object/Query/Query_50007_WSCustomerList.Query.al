query 50007 "WS Customer List"
{

    elements
    {
        dataitem(Customer; 18)
        {
            SqlJoinType = LeftOuterJoin;
            DataItemTableFilter = "Customer Type" = FILTER('DEALER');
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Address_2; "Address 2")
            {
            }
            column(City; City)
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(State_Code; "State Code")
            {
            }
            column(State_Desc; "State Desc.")
            {
            }
            column(Longitude; Longitude)
            {
            }
            column(Latitude; Latitude)
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
        }
    }
}

