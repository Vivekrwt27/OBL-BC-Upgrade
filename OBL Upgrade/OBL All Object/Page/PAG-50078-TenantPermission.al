page 80011 "Tenant Permission"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tenant Permission";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("App ID"; Rec."App ID")
                {
                    ApplicationArea = All;
                }
                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                }
                field("Role Name"; Rec."Role Name")
                {
                    ApplicationArea = All;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ApplicationArea = All;
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ApplicationArea = All;
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ApplicationArea = All;
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ApplicationArea = All;
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}