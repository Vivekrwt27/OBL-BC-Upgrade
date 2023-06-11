query 50001 "WS Inventory"
{

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = "Design Code" = FILTER(<> ''),
Blocked = CONST(false),
"Item Category Code" = FILTER(<> 'SAMPLE');
            column(no; "No.")
            {
            }
            column(complete_description; "Complete Description")
            {
            }
            column(design_code; "Design Code")
            {
            }
            column(size_code; "Size Code")
            {
            }
            column(design_code_desc; "Design Code Desc.")
            {
            }
            column(size_code_desc; "Size Code Desc.")
            {
            }
            column(last_modified_date; "Last Date Modified")
            {
            }
            column(color_code; "Color Code")
            {
            }
            column(color_code_desc; "Color Code Desc.")
            {
            }
            column(Manuf_Str; "Manuf. Strategy")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.",
"Location Code" = Item."Location Filter";
                column(location_code; "Location Code")
                {
                }
                column(sum_quantity; Quantity)
                {
                    ColumnFilter = sum_quantity = FILTER(> 10);
                    Method = Sum;
                }
                column(res_qty; "Reserved Quantity")
                {
                    Method = Sum;
                }
                dataitem(Location; 14)
                {
                    DataItemLink = Code = Item_Ledger_Entry."Location Code";
                    column(blocked; Blocked)
                    {
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    var
        rev: Decimal;
        item: Record Item;
    begin
    end;
}

