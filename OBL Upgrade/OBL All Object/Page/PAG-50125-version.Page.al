page 50125 version
{
    PageType = List;
    SourceTable = "Production BOM Version";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Production BOM No."; rec."Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; rec."No. Series")
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

