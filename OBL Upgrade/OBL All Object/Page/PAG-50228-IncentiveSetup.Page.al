page 50228 "Incentive Setup"
{
    Editable = false;
    PageType = List;
    SourceTable = "Capex Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                //16225 table Field N/F
                /*field("Between 80-85"; "Between 80-85")
                {
                }*/
                field("Total GST Amount"; Rec."Total GST Amount")
                {
                    ApplicationArea = All;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    ApplicationArea = All;
                }
                field("Amount to Vendor"; Rec."Amount to Vendor")
                {
                    ApplicationArea = All;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
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

