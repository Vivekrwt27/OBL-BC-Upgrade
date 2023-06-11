query 50042 "Sales Journal Data"
{
    OrderBy = Ascending(Goal_Sheet_Focused_Product), Ascending(CustomerNo);

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            filter(CustCodeFilter; "Sell-to Customer No.")
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
            column(CD; "Discount Charges %")
            {
            }
            column(Govt_proj; "Govt. Project Sales")
            {
            }
            column(CKA_Code; "CKA Code")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(GR_No; "GR No.")
            {
            }
            column(ORC_Code; "Dealer Code")
            {
            }
            column(Make_Order_Date; "Make Order Date")
            {
            }
            column(Releasing_Date; "Releasing Date")
            {
            }
            column(Payment_Date_3; "Payment Date 3")
            {
            }
            column(Credit_App_Not_Req; "Direct Not Approved")
            {
            }
            column(Inventory_not_found; "InventoryNot Directly Approved")
            {
            }
            column(External_Document_No; "External Document No.")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
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
                } 16767*/
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
                /* column(GSTBaseAmount; "GST Base Amount")
                 {
                 }
                 column(TDS_TCS_Amount; "TDS/TCS Amount")
                 {
                 }*/ // 16767
                column(Gross_Weight; "Gross Weight")
                {
                }
                column(Net_Weight; "Net Weight")
                {
                }
                /* column(GST_per; "GST %")
                 {
                 }*/ // 16767
                column(TCS_Nature_of_Collection; "TCS Nature of Collection")
                {
                }
                column(Approval_Required; "Approval Required")
                {
                }
                /* column(Total_GST_Amount; "Total GST Amount")
                 {
                 }*/ // 16767
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
                    column(Item_no; "No.")
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
                    column(item_class; "Item Classification")
                    {
                    }
                    column(Design_Code; "Design Code")
                    {
                    }
                    column(Manuf_stategy; "Manuf. Strategy")
                    {
                    }
                    column(obtb; "OBTB Focused Product")
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
                        filter(Tableau_Zone1; "Tableau Zone")
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
                        column(Tableau_Zone; "Tableau Zone")
                        {
                        }
                        column(OBTB_Joining_Date; "OBTB Joining Date")
                        {
                        }
                        column(Coco_Customer; "Coco Customer")
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
                                        column(ZM_Name; Name)
                                        {
                                        }
                                        dataitem(ZH; 13)
                                        {
                                            DataItemLink = Code = Customer."Zonal Head";
                                            column(ZH_Name; Name)
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

