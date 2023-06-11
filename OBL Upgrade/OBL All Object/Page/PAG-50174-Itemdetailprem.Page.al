page 50174 "Item detail prem"
{
    PageType = Card;
    SourceTable = Item;
    SourceTableView = SORTING("Size Code", "Type Code", "Design Code")
                      WHERE("Description 2" = FILTER('@* Prem*'),
                            Blocked = CONST(false),
                            "Item Category Code" = FILTER('D001' | 'H001' | 'M001' | 'T001'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Size Code Desc."; Rec."Size Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Desc."; Rec."Item Category Desc.")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; Rec."Type Code")
                {
                    ApplicationArea = All;
                }
                field("Type Code Desc."; Rec."Type Code Desc.")
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

