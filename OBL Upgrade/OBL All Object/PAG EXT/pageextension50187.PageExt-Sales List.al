pageextension 50187 pageextension50187 extends "Sales List"
{
    layout
    {

        addafter("Ship-to Name")
        {
            field("Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
            }
            field("Ship-to Address"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
            }
            field("Ship-to Address 2"; Rec."Ship-to Address 2")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {

            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
            }

            field("Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
            }

            field("Sell-to City"; Rec."Sell-to City")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field(State; Rec.State)
            {
                ApplicationArea = All;
            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

