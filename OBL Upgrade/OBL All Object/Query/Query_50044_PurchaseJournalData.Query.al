query 50044 "Purchase Journal Data"
{

    elements
    {
        dataitem(Purch__Rcpt__Header; 120)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            /*  dataitem(Purch__Rcpt__Line; 121)
              {
                  // DataItemLink = "Document No." = Purch_Rcpt_Header."No.";
                  DataItemTableFilter = Type = FILTER(Item),
                Quantity = FILTER(<> 0),
                "Item Category Code" = FILTER('M001|T001|D001|H001');
                  column(Quantity; Quantity)
                  {
                  }
                  column(Quantity_Base; "Quantity (Base)")
                  {
                  }
                  dataitem(Item; 27)
                  {
                      DataItemLink = "No." = Purch_Rcpt_Line."No.";
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
                  }*/
        }
    }
}


