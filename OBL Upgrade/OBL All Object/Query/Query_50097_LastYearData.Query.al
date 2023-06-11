query 50097 "Last Year Data"
{
    OrderBy = Ascending(SPCode), Ascending(PCHCode), Ascending(Zonal_Manager), Ascending(Zonal_Head);

    elements
    {
        dataitem(Last_Year_Sales_Data; 50076)
        {
            filter(DocumentType; DocumentType)
            {
            }
            filter(PostingDate; PostingDate)
            {
            }
            column(Tableau_Zone; Tableau_Zone)
            {
            }
            column(SPCode; SPCode)
            {
            }
            column(PCHCode; PCHCode)
            {
            }
            column(Zonal_Manager; Zonal_Manager)
            {
            }
            column(Zonal_Head; Zonal_Head)
            {
            }
            column(PMTCode; PMTCode)
            {
            }
            column(SizeCodeDesc; SizeCodeDesc)
            {
            }
            column(TabProdGrp; TabProdGrp)
            {
            }
            column(ItemCatCode; ItemCatCode)
            {
            }
            column(CustomerType; CustomerType)
            {
            }
            column(CustomerNo; CustomerNo)
            {
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
            }
            column(Sum_Quantity_Base; Quantity_Base)
            {
                Method = Sum;
            }
            column(Sum_LineAmount; LineAmount)
            {
                Method = Sum;
            }
            dataitem(Customer; 18)
            {
                DataItemLink = "No." = Last_Year_Sales_Data.CustomerNo;
                column(OBTB_Joining_Date; "OBTB Joining Date")
                {
                }
                column(Area_Code; "Area Code")
                {
                }
            }
        }
    }
}

