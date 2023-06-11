query 50000 "GRN Indent Notification"
{

    elements
    {
        dataitem(Purch__Rcpt__Line; 121)
        {
            DataItemTableFilter = "Indent No." = FILTER(<> ''),
            Quantity = FILTER(<> false),
            "Posting Date" = FILTER(>= '20-08-22');
            filter(PostDateFilter; "Posting Date")
            {
            }
            column(Indent_No; "Indent No.")
            {
            }
            column(PPRLineNo; "Line No.")
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Buy_from_Vendor_No; "Buy-from Vendor No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Shortage_Quantity; "Shortage Quantity")
            {
            }
            column(Actual_Quantity; "Actual Quantity")
            {
            }
            column(Order_No; "Order No.")
            {
            }
            column(Indent_Line_No; "Indent Line No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Mailed; Mailed)
            {
            }
            /* dataitem(Indent_Header; "Indent Header")
             {
                 DataItemLink = "No." = Purch_Rcpt_Line."Indent No.";
                 filter(IndentorFilter; "User ID")
                 {
                 }
                 column(Indent_Date; "Indent Date")
                 {
                 }
                 column(Indentor; "User ID")
                 {
                 }
                 column(Created_By; "Created By")
                 {
                 }
             }*/
        }
    }
}

