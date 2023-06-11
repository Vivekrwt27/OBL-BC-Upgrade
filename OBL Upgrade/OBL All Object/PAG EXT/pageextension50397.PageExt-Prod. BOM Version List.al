pageextension 50397 pageextension50397 extends "Prod. BOM Version List"
{
    layout
    {
        addfirst(content)
        {
            field("Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

