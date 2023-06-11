page 50035 "Phy.Jrnl.Loc. Wise Inventory"
{
    Editable = false;
    PageType = List;
    SourceTable = "Location Wise Inventory";
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Inventory at Location"; Rec."Inventory at Location")
                {
                    ApplicationArea = All;
                }
                field("Phys.Jrnl. Output Ent. Exists"; Rec."Phys.Jrnl. Output Ent. Exists")
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

