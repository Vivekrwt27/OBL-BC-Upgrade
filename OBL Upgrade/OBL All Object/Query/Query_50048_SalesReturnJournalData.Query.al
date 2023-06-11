query 50048 "Sales Return Journal Data"
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
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            /*column(Amount_to_Customer2; "Amount to Customer")
            {
            }*/ // 16767
            column(PMT_Code; "PMT Code")
            {
            }
            dataitem(Sales_Cr_Memo_Line; 115)
            {
                DataItemLink = "Document No." = Sales_Cr_Memo_Header."No.";
                DataItemTableFilter = Type = const(Item),
Quantity = FILTER(<> '0'),
"Item Category Code" = FILTER('M001|T001|D001|H001|SAMPLE');
                column(Document_No_; "Document No.")
                {

                }
                column(Line_No; "Line No.")
                {
                }
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
                }16767*/
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
                column(Item_Category_Code; "Item Category Code")
                {
                }
                /*column(Amount_To_Customer; "Amount To Customer")
                {
                }*/ // 16767
                filter(Item_Category_Code_Filter; "Item Category Code")
                {
                }
                column(Quantity_in_Sq_Mt; "Quantity in Sq. Mt.")
                {
                }
                /*column(Total_GST_Amount; "Total GST Amount")
                {
                }*/ // 16767
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
                    column(Item_no; "No.")
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
                    column(TypeCode; "Type Code")
                    {
                    }
                    column(NPD; NPD)
                    {
                    }
                    column(Size_Code_Desc; "Size Code Desc.")
                    {
                    }
                    column(Quality_Code; "Quality Code")
                    {
                    }
                    column(Design_Code; "Design Code")
                    {
                    }
                    column(Manuf_Strategy; "Manuf. Strategy")
                    {
                    }
                    column(Item_Classification; "Item Classification")
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Cr_Memo_Header."Sell-to Customer No.";
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
                        column(SPCode; "Salesperson Code")
                        {
                        }
                        column(PostCode; "Post Code")
                        {
                        }
                        column(PCHName; "PCH Name")
                        {
                        }
                        column(PCHCode; "PCH Code")
                        {
                        }
                        column(Zonal_Manager; "Zonal Manager")
                        {
                        }
                        column(Zonal_Head; "Zonal Head")
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
                        filter(TableauZoneFilter; "Tableau Zone")
                        {
                        }
                        column(CustomerType; "Customer Type")
                        {
                        }
                        column(Sales_Territory; "Area Code")
                        {
                        }
                        column(Cust_code; "No.")
                        {
                        }
                        column(Creation_Date; "Creation Date")
                        {
                        }
                        column(Revival_Date; "Revival Date")
                        {
                        }
                        column(OBTB_Joining_Date; "OBTB Joining Date")
                        {
                        }
                        column(AWS; Outbreaks)
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
                                dataitem(Item_Wise_Focused_Prod_; 50088)
                                {
                                    DataItemLink = "Goal Sheet Focused Product" = Item."Goal Sheet Focused Product",
"Tableau Zone" = Customer."Tableau Zone";
                                    column(Goal_Sheet_Focused_Product; "Goal Sheet Focused Product")
                                    {
                                    }
                                    dataitem(ZM; 13)
                                    {
                                        DataItemLink = Code = Customer."Zonal Manager";
                                        column(ZM_name; Name)
                                        {
                                        }
                                        dataitem(ZH; 13)
                                        {
                                            DataItemLink = Code = Customer."Zonal Head";
                                            column(ZH_name; Name)
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
        }
    }
}

