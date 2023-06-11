query 50016 "WS Location List"
{

    elements
    {
        dataitem(Location; 14)
        {
            DataItemTableFilter = Depot = CONST(true);
            column("Code"; "Code")
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
            column(Phone_No; "Phone No.")
            {
            }
            column(Post_Code; "Post Code")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(GST_Registration_No; "GST Registration No.")
            {
            }
        }
    }
}

