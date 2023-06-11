page 50211 "Manufacturing Plan"
{
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "Manufacturing Plan";

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
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Output (Quantity)"; Rec."Output (Quantity)")
                {
                    ApplicationArea = All;
                }
                field("Output Date"; Rec."Output Date")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description2"; Rec."Item Description2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production Plant"; Rec."Production Plant")
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

