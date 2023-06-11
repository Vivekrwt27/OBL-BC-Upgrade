page 50223 TransferSOSalesHeader
{
    Caption = 'Transfer SO Sale Header List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Transfer SO Sales Header";
    Permissions = tabledata "Transfer SO Sales Header" = rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;

                }
                field("Filled Date"; Rec."Filled Date")
                {
                    ApplicationArea = All;

                }
                field("Filled By Emp No."; Rec."Filled By Emp No.")
                {
                    ApplicationArea = All;

                }
                field("Filled By Emp Name"; Rec."Filled By Emp Name")
                {
                    ApplicationArea = All;

                }
                field("Filled Location"; Rec."Filled Location")
                {
                    ApplicationArea = All;

                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;

                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;

                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ApplicationArea = All;

                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;

                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2") { ApplicationArea = All; }
                field("Bill-to City"; Rec."Bill-to City") { ApplicationArea = All; }
                field("Bill-to Contact"; Rec."Bill-to Contact") { ApplicationArea = All; }
                field("Your Reference"; Rec."Your Reference") { ApplicationArea = All; }
                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = All; }
                field("Ship-to Name"; Rec."Ship-to Name") { ApplicationArea = All; }
                field("Ship-to Name 2"; Rec."Ship-to Name 2") { ApplicationArea = All; }
                field("Ship-to Address"; Rec."Ship-to Address") { ApplicationArea = All; }
                field("Ship-to Address 2"; Rec."Ship-to Address 2") { ApplicationArea = All; }
                field("Ship-to City"; Rec."Ship-to City") { ApplicationArea = All; }
                field("Ship-to Contact"; Rec."Ship-to Contact") { ApplicationArea = All; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; }
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; }
                field("Shipment Method Code"; Rec."Shipment Method Code") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2") { ApplicationArea = All; }
                field("Sell-to Address"; Rec."Sell-to Address") { ApplicationArea = All; }
                field("Sell-to Address 2"; Rec."Sell-to Address 2") { ApplicationArea = All; }
                field("Sell-to City"; Rec."Sell-to City") { ApplicationArea = All; }
                field("Sell-to Contact"; Rec."Sell-to Contact") { ApplicationArea = All; }
                field("Bill-to Post Code"; Rec."Bill-to Post Code") { ApplicationArea = All; }
                field("Bill-to County"; Rec."Bill-to County") { ApplicationArea = All; }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code") { ApplicationArea = All; }
                field("Sell-to Post Code"; Rec."Sell-to Post Code") { ApplicationArea = All; }
                field("Sell-to County"; Rec."Sell-to County") { ApplicationArea = All; }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code") { ApplicationArea = All; }
                field("Ship-to Post Code"; Rec."Ship-to Post Code") { ApplicationArea = All; }
                field("Ship-to County"; Rec."Ship-to County") { ApplicationArea = All; }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code") { ApplicationArea = All; }
                field("PO No."; Rec."PO No.") { ApplicationArea = All; }
                field("Qty in Sq. Mt."; Rec."Qty in Sq. Mt.") { ApplicationArea = All; }
                field("Quantity"; Rec."Quantity") { ApplicationArea = All; }
                field("Payment Terms"; Rec."Payment Terms") { ApplicationArea = All; }
                field("Dealer Code"; Rec."Dealer Code") { ApplicationArea = All; }
                field("Dealer's Salesperson Code"; Rec."Dealer's Salesperson Code") { ApplicationArea = All; }
                field("Sales Type"; Rec."Sales Type") { ApplicationArea = All; }
                field("Group Code"; Rec."Group Code") { ApplicationArea = All; }
                field(Pay; Rec.Pay) { ApplicationArea = All; }
                field("ORC Terms"; Rec."ORC Terms") { ApplicationArea = All; }
                field(Set; Rec.Set) { ApplicationArea = All; }
                field(Get; Rec.Get) { ApplicationArea = All; }
                field(None; Rec.None) { ApplicationArea = All; }
                field("Specified Ent Team"; Rec."Specified Ent Team") { ApplicationArea = All; }
                field("Govt Ent Team"; Rec."Govt Ent Team") { ApplicationArea = All; }
                field("Ship to Pin Code"; Rec."Ship to Pin Code") { ApplicationArea = All; }
                field("State Code"; Rec."State Code") { ApplicationArea = All; }
                field("Placed By BH"; Rec."Placed By BH") { ApplicationArea = All; }
                field(Pet; Rec.Pet) { ApplicationArea = All; }
                field("Private Ent Team"; Rec."Private Ent Team") { ApplicationArea = All; }
                field(Retail; Rec.Retail) { ApplicationArea = All; }
                field("Retail Code"; Rec."Retail Code") { ApplicationArea = All; }
                field("PMT Code"; Rec."PMT Code") { ApplicationArea = All; }
                field("Vehicle Provided"; Rec."Vehicle Provided") { ApplicationArea = All; }
                field("Collection Within"; Rec."Collection Within") { ApplicationArea = All; }
                field("Cash Discount"; Rec."Cash Discount") { ApplicationArea = All; }
                field("Vehicle Code"; Rec."Vehicle Code") { ApplicationArea = All; }
                field("Vehicle Desc"; Rec."Vehicle Desc") { ApplicationArea = All; }
                field("Total Net"; Rec."Total Net") { ApplicationArea = All; }
                field("GST Value"; Rec."GST Value") { ApplicationArea = All; }
                field("Total Value"; Rec."Total Value") { ApplicationArea = All; }
                field("Project Name"; Rec."Project Name") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Plant Code"; Rec."Plant Code") { ApplicationArea = All; }
                field("Sales Order Created"; Rec."Sales Order Created") { ApplicationArea = All; }
                field("Discount Percentage"; Rec."Discount Percentage") { ApplicationArea = All; }
                field("Sales Order No."; Rec."Sales Order No.") { ApplicationArea = All; }
                field("Line Count"; Rec."Line Count") { ApplicationArea = All; }

            }
        }
        area(Factboxes)
        {

        }
    }
}