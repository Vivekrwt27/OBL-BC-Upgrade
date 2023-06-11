page 50070 "Purchase Order ArchiveSubform1"
{
    Caption = 'Purchase Order Archive Subform';
    PageType = Card;
    SourceTable = "Matrix Master";
    SourceTableView = WHERE("Mapping Type" = CONST(Zone));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                /*   field("No."; Rec."No.")
                   {
                       ApplicationArea = All;
                   }
                   field("Cross-Reference No."; Rec."Cross-Reference No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Variant Code"; Rec."Variant Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field(Nonstock; Rec.Nonstock)
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }*/
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                //16225 field N/F Table start
                /*   field("Drop Shipment"; "Drop Shipment")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Return Reason Code"; "Return Reason Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Rejection Reason Code"; "Rejection Reason Code")
                   {
                       Editable = false;
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Shortage Reason Code"; "Shortage Reason Code")
                   {
                       Editable = false;
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Location Code"; "Location Code")
                   {
                       ApplicationArea = All;
                   }
                   field(Quantity; Quantity)
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Challan Quantity"; "Challan Quantity")
                   {
                       Editable = false;
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Actual Quantity"; "Actual Quantity")
                   {
                       Editable = false;
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Accepted Quantity"; "Accepted Quantity")
                   {
                       Editable = false;
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Shortage Quantity"; "Shortage Quantity")
                   {
                       Editable = false;
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Rejected Quantity"; "Rejected Quantity")
                   {
                       Editable = false;
                       Visible = false;
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
                   field("Direct Unit Cost"; "Direct Unit Cost")
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Indirect Cost %"; "Indirect Cost %")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Unit Price (LCY)"; "Unit Price (LCY)")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Line Amount"; "Line Amount")
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Line Discount %"; "Line Discount %")
                   {
                       BlankZero = true;
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
                   field("Qty. to Receive"; "Qty. to Receive")
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Quantity Received"; "Quantity Received")
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Qty. to Invoice"; "Qty. to Invoice")
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Quantity Invoiced"; "Quantity Invoiced")
                   {
                       BlankZero = true;
                       ApplicationArea = All;
                   }
                   field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Requested Receipt Date"; "Requested Receipt Date")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Promised Receipt Date"; "Promised Receipt Date")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Planned Receipt Date"; "Planned Receipt Date")
                   {
                       ApplicationArea = All;
                   }
                   field("Expected Receipt Date"; "Expected Receipt Date")
                   {
                       ApplicationArea = All;
                   }
                   field("Order Date"; "Order Date")
                   {
                       ApplicationArea = All;
                   }
                   field("Lead Time Calculation"; "Lead Time Calculation")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Job No."; "Job No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Planning Flexibility"; "Planning Flexibility")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Prod. Order Line No."; "Prod. Order Line No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Prod. Order No."; "Prod. Order No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Operation No."; "Operation No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Work Center No."; "Work Center No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field(Finished; Finished)
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Inbound Whse. Handling Time"; "Inbound Whse. Handling Time")
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
                   }*/ //16225 field N/F Table End
            }
        }
    }

    actions
    {
    }
    procedure ShowDimensions()
    begin
        //16225  Rec.ShowDimensions;
    end;
}

