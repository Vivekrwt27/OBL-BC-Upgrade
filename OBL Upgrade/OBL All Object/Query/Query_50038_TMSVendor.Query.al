query 50038 "TMS Vendor"
{

    elements
    {
        dataitem(Vendor; 23)
        {
            DataItemTableFilter = "Vendor Posting Group" = FILTER('<>EMP&<>TPR&<>CUST&<>ADV&<>BNK');
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
            column(State_Desc; "State Desc")
            {
            }
            column(Phone_No; "Phone No.")
            {
            }
            column(Contact; Contact)
            {
            }
            column(GST_Registration_No; "GST Registration No.")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
        }
    }
}

