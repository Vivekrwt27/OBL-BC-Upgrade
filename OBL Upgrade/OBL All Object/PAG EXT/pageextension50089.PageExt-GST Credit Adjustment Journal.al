pageextension 50089 pageextension50089 extends "GST Credit Adjustment Journal"
{
    layout
    {
    }
    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Line Dimension")
        {
            Visible = false;
        }
    }
}

