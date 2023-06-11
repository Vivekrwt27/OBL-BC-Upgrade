page 65000 "Permission Modify"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata Permission = rimd;
    SourceTable = Permission;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                }
                field("Role Name"; Rec."Role Name")
                {
                    ApplicationArea = all;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = all;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = all;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = all;
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ApplicationArea = all;
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ApplicationArea = all;
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ApplicationArea = all;
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ApplicationArea = all;
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ApplicationArea = all;
                }
                field("Security Filter"; Rec."Security Filter")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}