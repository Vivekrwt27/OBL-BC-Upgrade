page 50310 "CD Entry Modify"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata 50066 = rim;
    SourceTable = 50066;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Cust. Entry No."; Rec."Cust. Entry No.")
                {
                    ApplicationArea = All;
                }
                field("CD Document Type"; Rec."CD Document Type")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Cust. No."; Rec."Cust. No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = all;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = all;
                }
                field("CD Days"; Rec."CD Days")
                {
                    ApplicationArea = all;
                }
                field("CD % age"; Rec."CD % age")
                {
                    ApplicationArea = all;
                }
                field("CD Base Amount"; Rec."CD Base Amount")
                {
                    ApplicationArea = all;
                }
                field("CD Amount"; Rec."CD Amount")
                {
                    ApplicationArea = all;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = all;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Reciept Date"; Rec."Reciept Date")
                {
                    ApplicationArea = all;
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ApplicationArea = all;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = all;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }
                field("Holidays Grace"; Rec."Holidays Grace")
                {
                    ApplicationArea = all;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = all;
                }
                field("Next Slab Date"; Rec."Next Slab Date")
                {
                    ApplicationArea = all;
                }
                field("Order No."; Rec."Order No.")
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