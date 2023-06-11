page 50068 "Sales Order Archive Subform1"
{
    Caption = 'Sales Order Archive Subform';
    PageType = Card;
    SourceTable = "Branch Wise focused Prod IBOT";
    //SourceTableView = WHERE("Item No." = CONST('1'));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                /*
                field("Location Filter"; Rec."Location Filter")
                {
                    ApplicationArea = All;
                }
                 field("No.";Rec. "No.")
                 {
                     ApplicationArea = All;
                 }
                 field(Schemes; Schemes)
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Cross-Reference No."; "Cross-Reference No.")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                */
                /*  field("Substitution Available"; "Substitution Available")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Purchasing Code"; "Purchasing Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field(Nonstock; Nonstock)
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field(Description; Description)
                  {
                      ApplicationArea = All;
                  }
                  field("Description 2"; "Description 2")
                  {
                      ApplicationArea = All;
                  }
                  field("Drop Shipment"; "Drop Shipment")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Special Order"; "Special Order")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Return Reason Code"; "Return Reason Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Location Code"; "Location Code")
                  {
                      ApplicationArea = All;
                  }
                  field(Reserve; Reserve)
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field(Quantity; Quantity)
                  {
                      ApplicationArea = All;
                  }
                  field("Unit of Measure Code"; "Unit of Measure Code")
                  {
                      ApplicationArea = All;
                  }
                  field("Unit of Measure"; "Unit of Measure")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Unit Price"; "Unit Price")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Line Amount"; "Line Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Line Discount %"; "Line Discount %")
                  {
                      ApplicationArea = All;
                  }
                  field("Line Discount Amount"; "Line Discount Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Allow Invoice Disc."; "Allow Invoice Disc.")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Inv. Discount Amount"; "Inv. Discount Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Qty. to Ship"; "Qty. to Ship")
                  {
                      ApplicationArea = All;
                  }
                  field("Quantity Shipped"; "Quantity Shipped")
                  {
                      ApplicationArea = All;
                  }
                  field("Qty. to Invoice"; "Qty. to Invoice")
                  {
                      ApplicationArea = All;
                  }
                  field("Quantity Invoiced"; "Quantity Invoiced")
                  {
                      ApplicationArea = All;
                  }
                  field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Requested Delivery Date"; "Requested Delivery Date")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Promised Delivery Date"; "Promised Delivery Date")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Planned Delivery Date"; "Planned Delivery Date")
                  {
                      ApplicationArea = All;
                  }
                  field("Planned Shipment Date"; "Planned Shipment Date")
                  {
                      ApplicationArea = All;
                  }
                  field("Shipment Date"; "Shipment Date")
                  {
                      ApplicationArea = All;
                  }
                  field("Shipping Agent Code"; "Shipping Agent Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Shipping Time"; "Shipping Time")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Job No."; "Job No.")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Appl.-to Job Entry"; "Appl.-to Job Entry")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Apply and Close (Job)"; "Apply and Close (Job)")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Blanket Order No."; "Blanket Order No.")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Blanket Order Line No."; "Blanket Order Line No.")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("FA Posting Date"; "FA Posting Date")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Depr. until FA Posting Date"; "Depr. until FA Posting Date")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Depreciation Book Code"; "Depreciation Book Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Use Duplication List"; "Use Duplication List")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Appl.-from Item Entry"; "Appl.-from Item Entry")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }*/
            }
        }
    }

    actions
    {
    }


    procedure ShowDimensions()
    begin
        ShowDimensions;
    end;
}

