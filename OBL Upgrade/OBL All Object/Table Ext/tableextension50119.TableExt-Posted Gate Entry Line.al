tableextension 50119 tableextension50119 extends "Posted Gate Entry Line"
{
    fields
    {
        field(50000; "Order Qty"; Decimal)
        {
        }
        field(50001; "Gate Pass Qty"; Decimal)
        {
        }
        field(50002; "Item No"; Code[20])
        {
        }
        field(50003; "Item Description"; Text[40])
        {
        }
        field(50004; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;
        }
    }
    keys
    {
        key(Key3; "Source No.", "Source Name")
        {
        }
    }
}

