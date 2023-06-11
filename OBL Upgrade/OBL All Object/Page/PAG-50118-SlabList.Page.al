page 50118 "Slab List"
{
    PageType = Card;
    SourceTable = Slabs;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                Editable = false;
                field("Slab Group"; rec."Slab Group")
                {
                    ApplicationArea = All;
                }
                field("Qty (Sq Mt.)"; rec."Qty (Sq Mt.)")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Period; rec.Period)
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

