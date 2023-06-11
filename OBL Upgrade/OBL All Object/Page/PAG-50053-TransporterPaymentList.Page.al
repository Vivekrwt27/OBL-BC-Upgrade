page 50053 "Transporter Payment List"
{
    CardPageID = "Transporter Payment";
    PageType = List;
    SourceTable = "Transporter Payment Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(City; rec.City)
                {
                    ApplicationArea = All;
                }
                field("From Date"; rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Charge Item"; rec."Charge Item")
                {
                    ApplicationArea = All;
                }
                field("Rate/Kg"; rec."Rate/Kg")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Code"; rec."Sales Person Code")
                {
                    ApplicationArea = All;
                }
                field("Commission Type"; rec."Commission Type")
                {
                    ApplicationArea = All;
                }
                field("Calculation Value"; rec."Calculation Value")
                {
                    ApplicationArea = All;
                }
                field("Total Commission"; rec."Total Commission")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Total Weight"; rec."Total Weight")
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

