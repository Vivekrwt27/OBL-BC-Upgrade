page 50224 TransferSOSaleLine
{
    Caption = 'Transfer SO Sale Line List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Transfer SO Line";
    Permissions = tabledata "Transfer SO Line" = rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Id"; Rec."Id") { ApplicationArea = All; }
                field("Size"; Rec."Size") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
                field("Item No"; Rec."Item No") { ApplicationArea = All; }
                field("SKU Category"; Rec."SKU Category") { ApplicationArea = All; }
                field("Stock"; Rec."Stock") { ApplicationArea = All; }
                field("Quantity in Carton"; Rec."Quantity in Carton") { ApplicationArea = All; }
                field("Total Discount sqmt"; Rec."Total Discount sqmt") { ApplicationArea = All; }
                field("Sales Type"; Rec."Sales Type") { ApplicationArea = All; }
                field("LineID"; Rec."LineID") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Description 2"; Rec."Description 2") { ApplicationArea = All; }
                field("Freight"; Rec."Freight") { ApplicationArea = All; }
                field("ORC"; Rec."ORC") { ApplicationArea = All; }
                field("Reg Discount Approval"; Rec."Reg Discount Approval") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("NET Realisation"; Rec."NET Realisation") { ApplicationArea = All; }
                field("ItemMsr"; Rec."ItemMsr") { ApplicationArea = All; }
                field("ItemWeight"; Rec."ItemWeight") { ApplicationArea = All; }
                field("Quantity in sqmt"; Rec."Quantity in sqmt") { ApplicationArea = All; }
                field("List Price in sqmt"; Rec."List Price in sqmt") { ApplicationArea = All; }
                field("Billing sqmt"; Rec."Billing sqmt") { ApplicationArea = All; }
                field("ItemOrgWeight"; Rec."ItemOrgWeight") { ApplicationArea = All; }
                field("Plant Code"; Rec."Plant Code") { ApplicationArea = All; }
                field("Sales Order Created"; Rec."Sales Order Created") { ApplicationArea = All; }
                field("Retained"; Rec."Retained") { ApplicationArea = All; }
                field("Manuf. Strategy"; Rec."Manuf. Strategy") { ApplicationArea = All; }
                field("NPD"; Rec."NPD") { ApplicationArea = All; }
                field("Layer"; Rec."Layer") { ApplicationArea = All; }
                field("Pallet Value"; Rec."Pallet Value") { ApplicationArea = All; }
                field("Tableau Product Group"; Rec."Tableau Product Group") { ApplicationArea = All; }
                field("SO No,"; Rec."SO No,") { ApplicationArea = All; }
                field("So Date"; Rec."So Date") { ApplicationArea = All; }

            }
        }
        area(Factboxes)
        {

        }
    }
}