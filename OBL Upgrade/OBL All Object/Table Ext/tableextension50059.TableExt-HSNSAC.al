tableextension 50059 tableextension50059 extends "HSN/SAC"
{
    fields
    {
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
        modify("Code")
        {
            Caption = 'Code';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify(Type)
        {
            Caption = 'Type';
            OptionCaption = 'HSN,SAC';
        }
        field(5; Blocked; Boolean)
        {
        }
    }
}

