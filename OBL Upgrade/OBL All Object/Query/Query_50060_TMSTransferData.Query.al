query 50060 "TMS Transfer Data"
{
    ReadState = ReadExclusive;

    elements
    {
        dataitem(Transfer_Header; 5740)
        {
            DataItemTableFilter = "External Transfer" = CONST(true),
"Transfer-from Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG|SKD-SAMPLE|DRA-SAMPLE|HSK-SAMPLE'),
"Shipment Date" = FILTER(>= '06-01-21');
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(No; "No.")
            {
            }
            column(Transfer_from_Code; "Transfer-from Code")
            {
            }
            column(Transfer_to_Code; "Transfer-to Code")
            {
            }
            column(Status; Status)
            {
            }
            dataitem(Transfer_Line; 5741)
            {
                DataItemLink = "Document No." = Transfer_Header."No.";
                DataItemTableFilter = "Item No." = FILTER(<> '');
                column(Item_No; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(Quantity_Base; "Quantity (Base)")
                {
                }
                column(Qty_Shipped_Base; "Qty. Shipped (Base)")
                {
                }
                column(Qty_Received_Base; "Qty. Received (Base)")
                {
                }
                column(Outstanding_Qty_Base; "Outstanding Qty. (Base)")
                {
                }
                dataitem(locationto; 14)
                {
                    DataItemLink = Code = Transfer_Header."Transfer-to Code";
                    column(Location_To; "Location Name")
                    {
                    }
                    column(To_City; City)
                    {
                    }
                    dataitem(State; 18547)
                    {
                        DataItemLink = Code = locationto."State Code";
                        column(To_State; Description)
                        {
                        }
                        dataitem(locationfrm; 14)
                        {
                            DataItemLink = Code = Transfer_Header."Transfer-from Code";
                            column(From_location; "Location Name")
                            {
                            }
                            column(From_city; City)
                            {
                            }
                            dataitem(Statefrm; 18547)
                            {
                                DataItemLink = Code = locationfrm."State Code";
                                column(from_State; Description)
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

