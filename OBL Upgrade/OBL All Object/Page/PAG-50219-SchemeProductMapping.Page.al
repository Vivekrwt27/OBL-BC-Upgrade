page 50219 "Scheme Product Mapping"
{
    PageType = List;
    SourceTable = "Sales Jpurnal Data";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field(CRT; rec.CRT)
                {
                    ApplicationArea = All;
                }
                field("Basic Amount"; rec."Basic Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Amount"; rec."Excise Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        IF UPPERCASE(USERID) <> 'FA017' THEN
            ERROR('Sorry You are not Authorized to Run this Page');
    end;
}

