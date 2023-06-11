page 50251 "Vehicle Reminder Report"
{
    Editable = false;
    PageType = List;
    SourceTable = "Vehicle Notification  Entries";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Key"; rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Date"; rec."Sales Order Date")
                {
                    ApplicationArea = All;
                }
                field("Releasing Date"; rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("No. of Reminder"; rec."No. of Reminder")
                {
                    ApplicationArea = All;
                }
                field("Zonal Manager"; rec."Zonal Manager")
                {
                    ApplicationArea = All;
                }
                field("Branch Head"; rec."Branch Head")
                {
                    ApplicationArea = All;
                }
                field("Zonal Head"; rec."Zonal Head")
                {
                    ApplicationArea = All;
                }
                field(Salesperson; rec.Salesperson)
                {
                    ApplicationArea = All;
                }
                field(CSO; rec.CSO)
                {
                    ApplicationArea = All;
                }
                field("Mail Send Date"; rec."Mail Send Date")
                {
                    ApplicationArea = All;
                }
                field("Mail Send Time"; rec."Mail Send Time")
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

