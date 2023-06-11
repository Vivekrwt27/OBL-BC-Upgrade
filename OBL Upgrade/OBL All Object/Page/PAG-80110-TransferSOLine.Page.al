page 80110 "Transfer SO Line"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata 50101 = rim;
    SourceTable = 50101;

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
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field("SKU Category"; Rec."SKU Category")
                {
                    ApplicationArea = All;
                }
                field(Stock; Rec.Stock)
                {
                    ApplicationArea = All;
                }
                field("Quantity in Carton"; Rec."Quantity in Carton")
                {
                    ApplicationArea = All;
                }
                field("Total Discount sqmt"; Rec."Total Discount sqmt")
                {
                    ApplicationArea = All;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = all;
                }
                field(LineID; Rec.LineID)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field(Freight; Rec.Freight)
                {
                    ApplicationArea = all;
                }
                field(ORC; Rec.ORC)
                {
                    ApplicationArea = all;
                }
                field("Reg Discount Approval"; Rec."Reg Discount Approval")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("NET Realisation"; Rec."NET Realisation")
                {
                    ApplicationArea = all;
                }
                field(ItemMsr; Rec.ItemMsr)
                {
                    ApplicationArea = all;
                }
                field(ItemWeight; Rec.ItemWeight)
                {
                    ApplicationArea = all;
                }
                field("Quantity in sqmt"; Rec."Quantity in sqmt")
                {
                    ApplicationArea = all;
                }
                field("List Price in sqmt"; Rec."List Price in sqmt")
                {
                    ApplicationArea = all;
                }
                field("Billing sqmt"; Rec."Billing sqmt")
                {
                    ApplicationArea = all;
                }
                field(ItemOrgWeight; Rec.ItemOrgWeight)
                {
                    ApplicationArea = all;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ApplicationArea = all;
                }
                field("Sales Order Created"; Rec."Sales Order Created")
                {
                    ApplicationArea = all;
                }
                field(Retained; Rec.Retained)
                {
                    ApplicationArea = all;
                }
                field("Manuf. Strategy"; Rec."Manuf. Strategy")
                {
                    ApplicationArea = all;
                }
                field(NPD; Rec.NPD)
                {
                    ApplicationArea = all;
                }
                field(Layer; Rec.Layer)
                {
                    ApplicationArea = all;
                }
                field("Pallet Value"; Rec."Pallet Value")
                {
                    ApplicationArea = all;
                }
                field("Tableau Product Group"; Rec."Tableau Product Group")
                {
                    ApplicationArea = all;
                }
                field("SO No,"; Rec."SO No,")
                {
                    ApplicationArea = all;
                }
                field("So Date"; Rec."So Date")
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