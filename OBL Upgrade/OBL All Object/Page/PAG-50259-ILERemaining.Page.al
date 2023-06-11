page 50259 "ILE Remaining"
{
    PageType = List;
    SourceTable = "Budget Master Archive";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                //16225 Table Field N/F
                /*  field("Item No."; "Item No.")
                  {
                  }
                  field("Posting Date"; "Posting Date")
                  {
                  }
                  field("Entry Type"; "Entry Type")
                  {
                  }*/
                field("Capex Request"; Rec."Capex Request")
                {
                    ApplicationArea = All;
                }
                /*field("Document No."; "Document No.")//16225 Table Field N/F
                {
                }*/
                field("Archive No."; Rec."Archive No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                //16225 Table Filed N/F Start
                /* field(Quantity; Quantity)
                 {
                 }
                 field("Remaining Quantity"; "Remaining Quantity")
                 {
                 }
                 field("Invoiced Quantity"; "Invoiced Quantity")
                 {
                 }
                 field("Applies-to Entry"; "Applies-to Entry")
                 {
                 }
                 field(Open; Open)
                 {
                 }
                 field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                 {
                 }
                 field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                 {
                 }
                 field(Positive; Positive)
                 {
                 }
                 field("Source Type"; "Source Type")
                 {
                 }
                 field("Drop Shipment"; "Drop Shipment")
                 {
                 }*///16225 Table Filed N/F End
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                //16225 Table Filed N/F Start
                /*field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Entry/Exit Point"; "Entry/Exit Point")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field(Area1; Area)
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }*///16225 Table Filed N/F End
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                //16225 Table Filed N/F 
                /*field("Document Type"; "Document Type")
                {
                }*/
                field("Created Date & Time"; Rec."Created Date & Time")
                {
                    ApplicationArea = All;
                }
                field("UnPosted Amount"; Rec."UnPosted Amount")
                {
                    ApplicationArea = All;
                }
                //16225 Table Filed N/F Start
                /*field("Order No."; "Order No.")
                {
                }
                field("Order Line No."; "Order Line No.")
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                }
                field("Assemble to Order"; "Assemble to Order")
                {
                }*///16225 Table Filed N/F End
                field("Archive By"; Rec."Archive By")
                {
                    ApplicationArea = All;
                }
                //16225 Table Filed N/F Start
                /*field("Job Task No."; "Job Task No.")s
                {
                }
                field("Job Purchase"; "Job Purchase")
                {
                }
                field("Variant Code"; "Variant Code")
                {
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Derived from Blanket Order"; "Derived from Blanket Order")
                {
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                }
                field("Originally Ordered No."; "Originally Ordered No.")
                {
                }
                field("Originally Ordered Var. Code"; "Originally Ordered Var. Code")
                {
                }
                field("Out-of-Stock Substitution"; "Out-of-Stock Substitution")
                {
                }
                field("Item Category Code"; "Item Category Code")
                {
                }
                field(Nonstock; Nonstock)
                {
                }
                field("Purchasing Code"; "Purchasing Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Completely Invoiced"; "Completely Invoiced")
                {
                }
                field("Last Invoice Date"; "Last Invoice Date")
                {
                }
                field("Applied Entry to Adjust"; "Applied Entry to Adjust")
                {
                }
                field("Cost Amount (Expected)"; "Cost Amount (Expected)")
                {
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                }
                field("Cost Amount (Non-Invtbl.)"; "Cost Amount (Non-Invtbl.)")
                {
                }
                field("Cost Amount (Expected) (ACY)"; "Cost Amount (Expected) (ACY)")
                {
                }
                field("Cost Amount (Actual) (ACY)"; "Cost Amount (Actual) (ACY)")
                {
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; "Cost Amount (Non-Invtbl.)(ACY)")
                {
                }
                field("Purchase Amount (Expected)"; "Purchase Amount (Expected)")
                {
                }
                field("Purchase Amount (Actual)"; "Purchase Amount (Actual)")
                {
                }
                field("Sales Amount (Expected)"; "Sales Amount (Expected)")
                {
                }
                field("Sales Amount (Actual)"; "Sales Amount (Actual)")
                {
                }
                field(Correction; Correction)
                {
                }
                field("Shipped Qty. Not Returned"; "Shipped Qty. Not Returned")
                {
                }
                field("Prod. Order Comp. Line No."; "Prod. Order Comp. Line No.")
                {
                }
                field("Serial No."; "Serial No.")
                {
                }
                field("Lot No."; "Lot No.")
                {
                }
                field("Warranty Date"; "Warranty Date")
                {
                }
                field("Expiration Date"; "Expiration Date")
                {
                }
                field("Item Tracking"; "Item Tracking")
                {
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                }
                field("DSA Entry No."; "DSA Entry No.")
                {
                }
                field("BED %"; "BED %")
                {
                }
                field("BED Amount"; "BED Amount")
                {
                }
                field("Other Duties %"; "Other Duties %")
                {
                }
                field("Other Duties Amount"; "Other Duties Amount")
                {
                }
                field("Laboratory Test"; "Laboratory Test")
                {
                }
                field("Other Usage"; "Other Usage")
                {
                }
                field("Nature of Disposal"; "Nature of Disposal")
                {
                }
                field("Type of Disposal"; "Type of Disposal")
                {
                }
                field("Reason Code"; "Reason Code")
                {
                }
                field("Captive Consumption"; "Captive Consumption")
                {
                }
                field("Re-Dispatch"; "Re-Dispatch")
                {
                }
                field("Assessable Value"; "Assessable Value")
                {
                }
                field("Subcon Order No."; "Subcon Order No.")
                {
                }
                field("Type Code"; "Type Code")
                {
                }
                field("Size Code"; "Size Code")
                {
                }
                field("Design Code"; "Design Code")
                {
                }
                field("Color Code"; "Color Code")
                {
                }
                field("Packing Code"; "Packing Code")
                {
                }
                field("Quality Code"; "Quality Code")
                {
                }
                field("Plant Code"; "Plant Code")
                {
                }
                field("Main Location"; "Main Location")
                {
                }
                field(InTransit; InTransit)
                {
                }
                field("Relational Location Code"; "Relational Location Code")
                {
                }
                field("External Transfer"; "External Transfer")
                {
                }
                field("Qty in Sq.Mt."; "Qty in Sq.Mt.")
                {
                }
                field("Qty In Carton"; "Qty In Carton")
                {
                }
                field("Category Code"; "Category Code")
                {
                }
                field(OK; OK)
                {
                }
                field("Production Plant Code"; "Production Plant Code")
                {
                }
                field(caa; caa)
                {
                }
                field("Output Date"; "Output Date")
                {
                }
                field("Group Code"; "Group Code")
                {
                }
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Net Weight"; "Net Weight")
                {
                }
                field("ILE Entry No. 3.7"; "ILE Entry No. 3.7")
                {
                }
                field("Old Variant Code"; "Old Variant Code")
                {
                }
                field("Capex No."; "Capex No.")
                {
                }
                field("Inter Company"; "Inter Company")
                {
                }
                field("IC Line No."; Rec."IC Line No.")
                {
                }
                field("Purch Excise"; Rec."Purch Excise")
                {
                }
                field("Amt to Vend"; Rec."Amt to Vend")
                {
                }
                field("Vendor Inv No."; Rec."Vendor Inv No.")
                {
                }
                field("Vendor Inv Date"; Rec."Vendor Inv Date")
                {
                }
                field("Stk Transfer Inv No."; Rec."Stk Transfer Inv No.")
                {
                }
                field("Trf from Location"; Rec."Trf from Location")
                {
                }
                field("Trf To Location"; Rec."Trf To Location")
                {
                }
                field("Trf Excise Amount"; Rec."Trf Excise Amount")
                {
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                }
                field("Qty in PCS."; Rec."Qty in PCS.")
                {
                }
                field("Direct Consumption Entries"; Rec."Direct Consumption Entries")
                {
                }
                field("Depot. Prod Order"; Rec."Depot. Prod Order")
                {
                }
                field(ReProcess; Rec.ReProcess)
                {
                }
                field("Re Process Production Order"; Rec."Re Process Production Order")
                {
                }
                field("Work Shift Code"; Rec."Work Shift Code")
                {
                }
                field("Original Prod. No"; Rec."Original Prod. No")
                {
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                }
                field("General Prod. Posting Group"; Rec."General Prod. Posting Group")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Item Description 2"; Rec."Item Description 2")
                {
                }
                field("Import Document"; Rec."Import Document")
                {
                }
                field("Item Base Unit of Measure"; Rec."Item Base Unit of Measure")
                {
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                }
                field("Machine Code"; Rec."Machine Code")
                {
                }
                field("End Use Item"; Rec."End Use Item")
                {
                }
                field("Ref Code"; Rec."Ref Code")
                {
                }
                field("Cost Amount - Remaining"; Rec."Cost Amount - Remaining")
                {
                }*///16225 Table Filed N/F End
            }
        }
    }

    actions
    {
    }
}

