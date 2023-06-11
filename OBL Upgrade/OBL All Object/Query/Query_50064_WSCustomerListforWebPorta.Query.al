query 50064 "WS Customer List for Web Porta"
{

    elements
    {
        dataitem(Customer; 18)
        {
            DataItemTableFilter = "Customer Type" = FILTER('DEALER|DISTIBUTOR');
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
            column(State_Desc; "State Desc.")
            {
            }
            column(Phone_No; "Phone No.")
            {
            }
            column(Contact; Contact)
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(OBTB_Channel_Partner; "Coco Customer")
            {
            }
            column(CP_Creation_Date; "Creation Date")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            column(Longitude; Longitude)
            {
            }
            column(Latitude; Latitude)
            {
            }
        }
    }
}

