query 50045 "Transfer Journal Data"
{

    elements
    {
        dataitem(Transfer_Receipt_Header; 5746)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Transfer_to_Code; "Transfer-to Code")
            {
            }
            dataitem(Transfer_Receipt_Line; 5747)
            {
                DataItemLink = "Document No." = Transfer_Receipt_Header."No.";
                DataItemTableFilter = Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001');
                column(Quantity; Quantity)
                {
                }
                column(Quantity_Base; "Quantity (Base)")
                {
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Transfer_Receipt_Line."Item No.";
                    column(SizeCodeDesc; "Size Code Desc.")
                    {
                    }
                    column(TypeCatCodeDesc; "Item Category Code")
                    {
                    }
                    column(TabProdGrp; "Tableau Product Group")
                    {
                    }
                    column(Size_Code; "Size Code")
                    {
                    }
                }
            }
        }
    }
}

