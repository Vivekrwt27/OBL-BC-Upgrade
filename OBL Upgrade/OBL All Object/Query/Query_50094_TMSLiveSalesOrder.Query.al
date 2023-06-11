query 50094 "TMS Live Sales Order"
{

    elements
    {
        dataitem(Sales_Header; 36)
        {
            DataItemTableFilter = "Document Type" = FILTER('Order'),
"Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG|SKD-SAMPLE|SKD-STORE|DRA-STORE|HSK-STORE|DRA-SAMPLE|HSK-SAMPLE'),
"Sell-to Customer No." = FILTER(<> '');
            column(SO_Number; "No.")
            {
            }
            column(SO_Date_n_time; "Make Order Date")
            {
            }
            column(Status; Status)
            {
            }
            column(Location_Code; "Location Code")
            {
            }
        }
    }
}

