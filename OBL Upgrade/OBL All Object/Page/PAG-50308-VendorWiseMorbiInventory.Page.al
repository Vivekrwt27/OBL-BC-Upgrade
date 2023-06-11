page 50308 "Vendor Wise Morbi Inventory"
{
    PageType = List;
    SourceTable = "Transport Method";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Morbi Inventory"; rec."Morbi Inventory")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Morbi Location Code"; rec."Morbi Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

