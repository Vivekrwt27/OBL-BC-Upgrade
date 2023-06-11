page 50312 "Physical Journal Inventory"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Physical Journ Inventory Lines" = rimd;
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
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transfer Qty"; Rec."Physical Inventory")
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

