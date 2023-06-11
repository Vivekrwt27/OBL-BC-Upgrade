pageextension 50169 pageextension50169 extends "Item Reclass. Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode5)
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }

}

