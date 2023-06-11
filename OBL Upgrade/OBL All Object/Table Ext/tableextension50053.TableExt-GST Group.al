tableextension 50053 tableextension50053 extends "GST Group"
{
    fields
    {
        modify("Code")
        {
            Caption = 'Code';
        }
        modify("GST Place Of Supply")
        {
            Caption = 'GST Place Of Supply';
            OptionCaption = ' ,Bill-to Address,Ship-to Address,Location Address';
        }
        modify(Description)
        {
            Caption = 'Description';
        }

        field(50000; "Org. GST Group Type"; Option)
        {
            OptionCaption = 'Goods,Service';
            OptionMembers = Goods,Service;
        }
        field(50001; Blocked; Boolean)
        {
        }
    }
}

