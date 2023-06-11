query 50051 "Sales Return Jrnl Data1"
{
    OrderBy = Ascending(LocationCode), Ascending(PostingDate);

    elements
    {
        dataitem(Sales_Cr_Memo_Header; 114)
        {
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
            column(Sales_Type; "Sales Type")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            dataitem(Sales_Cr_Memo_Line; 115)
            {
                DataItemLink = "Document No." = Sales_Cr_Memo_Header."No.";
                DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001');
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
                }*/ //16767
                column(MRPPrice; "MRP Price")
                {
                }
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
                column(System_Discount_Amount; "System Discount Amount")
                {
                }
                column(line_discount; "Line Discount Amount")
                {
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Cr_Memo_Line."No.";
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
                    column(QualityCode; "Quality Code")
                    {
                    }
                    column(Size_Code; "Size Code")
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Cr_Memo_Header."Sell-to Customer No.";
                        filter(AreaFilter; "Area Code")
                        {
                        }
                        filter(PCHFilter; "PCH Code")
                        {
                        }
                        filter(SalesPersonFilter; "Salesperson Code")
                        {
                        }
                        column(CustType; "Customer Type")
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
                        column(Tableau_Zone; "Tableau Zone")
                        {
                        }
                        column(Sales_Territory; "Area Code")
                        {
                        }
                        dataitem(GOVT; 13)
                        {
                            DataItemLink = Code = Customer."Govt. SP Resp.";
                            column(GovtName; Name)
                            {
                            }
                            dataitem(Private; 13)
                            {
                                DataItemLink = Code = Customer."Private SP Resp.";
                                column(PrivateSP_Name; Name)
                                {
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

