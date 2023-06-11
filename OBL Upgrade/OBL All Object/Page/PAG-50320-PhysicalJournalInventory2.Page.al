page 50320 "Physical Journal Inventory2"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Physical Journ Inventory Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("System Inventory"; Rec."System Inventory")
                {
                    ApplicationArea = All;
                }
                field("Physical Inventory"; Rec."Physical Inventory")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

