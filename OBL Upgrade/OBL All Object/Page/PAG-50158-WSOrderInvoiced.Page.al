page 50158 "WS Order Invoiced"
{
    SourceTable = "Sales Invoice Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field(State; rec.State)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                /*field("Amount to Customer"; "Amount to Customer")
                {
                    ApplicationArea = All;
                }*/
                field("Qty. in Sq. Meter"; rec."Qty. in Sq. Meter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Posting Date", TODAY);
    end;
}

