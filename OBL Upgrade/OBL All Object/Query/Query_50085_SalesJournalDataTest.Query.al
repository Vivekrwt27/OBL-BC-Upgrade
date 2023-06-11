query 50085 "Sales Journal Data Test"
{
    OrderBy = Ascending(LocationCode), Ascending(PostingDate);

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            DataItemTableFilter = "No." = FILTER('SIPL/2021/008192');
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(CustomerNo; "Sell-to Customer No.")
            {
            }
            column(CustomerName; "Sell-to Customer Name")
            {
            }
            column(SellToCity; "Sell-to City")
            {
            }
            column(State; State)
            {
            }
            column(CustomerType; "Customer Type")
            {
            }
            column(InvoiceNo; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(TransportMethod; "Shipping Agent Code")
            {
            }
            column(Pay; Pay)
            {
            }
            column(Sales_Type; "Sales Type")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Discount_Charges; "Discount Charges %")
            {
            }
            column(PMTCode; "PMT Code")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Order_No; "Order No.")
            {
            }
            column(Govt_proj; "Govt. Project Sales")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001|SAMPLE');
                column(ItemNo; "No.")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(UOM; "Unit of Measure")
                {
                }
                column(Quantity_Base; "Quantity (Base)")
                {
                }
                column(LineAmount; "Line Amount")
                {
                }
                /*column(AmountToCustomer; "Amount To Customer")
                {
                }
                column(MRPPrice; "MRP Price")
                {
                }*/ //16767
                column(D1; D1)
                {
                }
                column(D2; D2)
                {
                }
                column(D3; D3)
                {
                }
                column(D4; D4)
                {
                }
                column(S1; S1)
                {
                }
                column(D6; D6)
                {
                }
                column(D7; D7)
                {
                }
                column(Discount_Amt_1; "Discount Amt 1")
                {
                }
                column(Discount_Amt_2; "Discount Amt 2")
                {
                }
                column(Discount_Amt_3; "Discount Amt 3")
                {
                }
                column(Discount_Amt_4; "Discount Amt 4")
                {
                }
                column(Discount_Amt_6; "Discount Amt 6")
                {
                }
                column(Discount_Amt_7; "Discount Amt 7")
                {
                }
                column(System_Discount_Amount; "System Discount Amount")
                {
                }
                column(line_discount; "Line Discount Amount")
                {
                }
                filter(Item_Category_Code_Filter; "Item Category Code")
                {
                }
                column(Quantity_in_Sq_Mt; "Quantity in Sq. Mt.")
                {
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    column(TypeCode; "Type Code")
                    {
                    }
                    column(ItemDescc; Description)
                    {
                    }
                    column(ItemDescc2; "Description 2")
                    {
                    }
                    column(SizeCodeDesc; "Size Code Desc.")
                    {
                    }
                    column(TypeCodeDesc; "Type Code Desc.")
                    {
                    }
                    column(TypeCatCodeDesc; "Item Category Code")
                    {
                    }
                    column(TabProdGrp; "Tableau Product Group")
                    {
                    }
                    column(TypeCatCode; "Type Catogery Code")
                    {
                    }
                    column(Item_npd; NPD)
                    {
                    }
                    column(QualityCode; "Quality Code")
                    {
                    }
                    column(Size_Code; "Size Code")
                    {
                    }
                    column(Size_Code_Desc_Filter; "Size Code Desc.")
                    {
                    }
                    column(Sample_Group; "Sample Group")
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                        filter(CXOTieUp; "CXO Tie Up")
                        {
                        }
                        filter(AreaFilter; "Area Code")
                        {
                        }
                        filter(PCHFilter; "PCH Code")
                        {
                        }
                        filter(SalesPersonFilter; "Salesperson Code")
                        {
                        }
                        column(Balance; Balance)
                        {
                        }
                        column(PostCode; "Post Code")
                        {
                        }
                        column(SPCode; "Salesperson Code")
                        {
                        }
                        column(PCHName; "PCH Name")
                        {
                        }
                        column(PCHCode; "PCH Code")
                        {
                        }
                        column(SPName; "Salesperson Description")
                        {
                        }
                        column(AreaCode; "Area Code")
                        {
                        }
                        column(GovtSPResp; "Govt. SP Resp.")
                        {
                        }
                        column(PrivateSPResp; "Private SP Resp.")
                        {
                        }
                        column(TableauZone; "Tableau Zone")
                        {
                        }
                        column(Sales_Territory; "Area Code")
                        {
                        }
                        column(Zonal_Manager; "Zonal Manager")
                        {
                        }
                        column(Zonal_Head; "Zonal Head")
                        {
                        }
                        column(Cust_Code; "No.")
                        {
                        }
                        column(Revival_Date; "Revival Date")
                        {
                        }
                        dataitem(GOVT; 13)
                        {
                            DataItemLink = Code = Customer."Govt. SP Resp.";
                            column(GovtName; Name)
                            {
                            }
                            dataitem(Salesperson_Purchaser; 13)
                            {
                                DataItemLink = Code = Customer."Private SP Resp.";
                                column(PrivateSP_Name; Name)
                                {
                                }
                                /*   dataitem(QueryElement1000000082; 13798)
                                   {
                                       DataItemLink = Invoice No.=Sales_Invoice_Line."Document No.",
   Item No.=Sales_Invoice_Line."No.";
                                       DataItemTableFilter = Tax/Charge Group=FILTER(DISCOUNT);
                                       column(Amount;Amount)
                                       {
                                       }
                                   }*/ //16767
                            }
                        }
                    }
                }
            }
        }
    }
}

