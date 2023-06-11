page 50010 "SMS - Mobile No."
{
    PageType = List;
    SourceTable = "SMS - Mobile No.";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("Mobile No."; rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Link With"; rec."Link With")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Link Code"; rec."Link Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(date; rec.date)
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Send Mobile Communication"; rec."Send Mobile Communication")
                {
                    ApplicationArea = All;
                }
                field("Send Generic Message"; rec."Send Generic Message")
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

