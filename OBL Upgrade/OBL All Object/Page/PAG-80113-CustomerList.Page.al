page 79990 "Customer Creation List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Customer Creation List';
    UsageCategory = Lists;
    Permissions = tabledata 18 = rimd;
    SourceTable = 18;
    CardPageId = 79991;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Virtual ID"; Rec."Virtual ID")
                {
                    ApplicationArea = all;
                }


            }
        }

    }


}