page 50270 "Purchase Line"
{
    PageType = List;
    Permissions = TableData "Purchase Line" = rimd;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }



                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Area field.';
                }

                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = all;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = all;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = all;
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ApplicationArea = all;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Incl. VAT"; Rec."Prepmt. Amt. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Amount"; Rec."Prepayment Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Base Amt."; Rec."Prepmt. VAT Base Amt.")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT %"; Rec."Prepayment VAT %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Calc. Type"; Rec."Prepmt. VAT Calc. Type")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Identifier"; Rec."Prepayment VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Area Code"; Rec."Prepayment Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Liable"; Rec."Prepayment Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Group Code"; Rec."Prepayment Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. Incl. VAT"; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. (LCY)"; Rec."Prepmt. Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Amount Inv. (LCY)"; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Difference"; Rec."Prepayment VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. to Deduct"; Rec."Prepmt VAT Diff. to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. Deducted"; Rec."Prepmt VAT Diff. Deducted")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amt. Ex. VAT (LCY)"; Rec."Outstanding Amt. Ex. VAT (LCY)")
                {
                    ApplicationArea = All;
                }
                field("A. Rcd. Not Inv. Ex. VAT (LCY)"; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ApplicationArea = All;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Currency Factor"; Rec."Job Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Job Currency Code"; Rec."Job Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = All;
                }
                field("Job Remaining Qty."; Rec."Job Remaining Qty.")
                {
                    ApplicationArea = All;
                }
                field("Job Remaining Qty. (Base)"; Rec."Job Remaining Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                }
                field("Returns Deferral Start Date"; Rec."Returns Deferral Start Date")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive (Base)"; Rec."Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced (Base)"; Rec."Qty. Rcd. Not Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Received (Base)"; Rec."Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Salvage Value"; Rec."Salvage Value")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Code"; Rec."Maintenance Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                /*     field("Cross-Reference No."; Rec."Cross-Reference No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
                    {
                        ApplicationArea = All;
                    }
                    field("Cross-Reference Type"; Rec."Cross-Reference Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                    {
                        ApplicationArea = All;
                    }
                 */
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                }
                //16225 Table Field N/F
                /*  field("Product Group Code"; "Product Group Code")
                  {
                      ApplicationArea = All;
                  }*/
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = All;
                }
                field("Special Order Sales No."; Rec."Special Order Sales No.")
                {
                    ApplicationArea = All;
                }
                field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Completely Received"; Rec."Completely Received")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Ship"; Rec."Return Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Ship (Base)"; Rec."Return Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Shipped Not Invd."; Rec."Return Qty. Shipped Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Ret. Qty. Shpd Not Invd.(Base)"; Rec."Ret. Qty. Shpd Not Invd.(Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Shpd. Not Invd."; Rec."Return Shpd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Return Shpd. Not Invd. (LCY)"; Rec."Return Shpd. Not Invd. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Shipped"; Rec."Return Qty. Shipped")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Shipped (Base)"; Rec."Return Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Shipment No."; Rec."Return Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Return Shipment Line No."; Rec."Return Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Copied From Posted Doc."; Rec."Copied From Posted Doc.")
                {
                    ApplicationArea = All;
                }
                //16225 Table N/F
                /*field("Tax %"; "Tax %")
                {
                    ApplicationArea = All;
                }
                field("Amount Including Tax"; "Amount Including Tax")
                {
                    ApplicationArea = All;
                }
                field("Form Code"; "Form Code")
                {
                    ApplicationArea = All;
                }
                field("Form No."; "Form No.")
                {
                    ApplicationArea = All;
                }*/
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                //16225 Table N/F
                /*field("Tax Base Amount"; "Tax Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Amount Including Excise"; "Amount Including Excise")
                {
                    ApplicationArea = All;
                }
                field("Excise Amount"; "Excise Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Base Quantity"; "Excise Base Quantity")
                {
                    ApplicationArea = All;
                }
                field("Tax Amount"; "Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Accounting Type"; "Excise Accounting Type")
                {
                    ApplicationArea = All;
                }
                field("Work Tax Base Amount"; "Work Tax Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Work Tax %"; "Work Tax %")
                {
                    ApplicationArea = All;
                }
                field("Work Tax Amount"; "Work Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("TDS Category"; "TDS Category")
                {
                    ApplicationArea = All;
                }
                field("Surcharge %"; "Surcharge %")
                {
                    ApplicationArea = All;
                }
                field("Surcharge Amount"; "Surcharge Amount")
                {
                    ApplicationArea = All;
                }
                field("Concessional Code"; "Concessional Code")
                {
                    ApplicationArea = All;
                }
                field("Excise Base Amount"; "Excise Base Amount")
                {
                    ApplicationArea = All;
                }
                field("TDS Amount"; "TDS Amount")
                {
                    ApplicationArea = All;
                }
                field("TDS Nature of Deduction"; "TDS Nature of Deduction")
                {
                    ApplicationArea = All;
                }
                field("Assessee Code"; "Assessee Code")
                {
                    ApplicationArea = All;
                }
                field("TDS %"; "TDS %")
                {
                    ApplicationArea = All;
                }
                field("TDS Amount Including Surcharge"; "TDS Amount Including Surcharge")
                {
                    ApplicationArea = All;
                }
                field("Bal. TDS Including SHE CESS"; "Bal. TDS Including SHE CESS")
                {
                    ApplicationArea = All;
                }*/
                field("Nature of Remittance"; Rec."Nature of Remittance")
                {
                    ApplicationArea = All;
                }
                field("Act Applicable"; Rec."Act Applicable")
                {
                    ApplicationArea = All;
                }
                //16225 table Field N/F
                /*field("Country Code"; "Country Code")
                {
                    ApplicationArea = All;
                }
                field("Capital Item"; "Capital Item")
                {
                    ApplicationArea = All;
                }
                field("BED Amount"; "BED Amount")
                {
                    ApplicationArea = All;
                }
                field("AED(GSI) Amount"; "AED(GSI) Amount")
                {
                    ApplicationArea = All;
                }
                field("SED Amount"; "SED Amount")
                {
                    ApplicationArea = All;
                }
                field("SAED Amount"; "SAED Amount")
                {
                    ApplicationArea = All;
                }
                field("CESS Amount"; "CESS Amount")
                {
                    ApplicationArea = All;
                }
                field("NCCD Amount"; "NCCD Amount")
                {
                    ApplicationArea = All;
                }
                field("eCess Amount"; "eCess Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount Added to Excise Base"; "Amount Added to Excise Base")
                {
                    ApplicationArea = All;
                }
                field("Amount Added to Tax Base"; "Amount Added to Tax Base")
                {
                    ApplicationArea = All;
                }
                field("Amount Added to Inventory"; "Amount Added to Inventory")
                {
                    ApplicationArea = All;
                }
                field("Excise Credit Reversal"; "Excise Credit Reversal")
                {
                    ApplicationArea = All;
                }
                field("Amount To Vendor"; "Amount To Vendor")
                {
                    ApplicationArea = All;
                }
                field("Charges To Vendor"; "Charges To Vendor")
                {
                    ApplicationArea = All;
                }
                field("TDS Base Amount"; "TDS Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Surcharge Base Amount"; "Surcharge Base Amount")
                {
                    ApplicationArea = All;
                }
                field("TDS Group"; "TDS Group")
                {
                    ApplicationArea = All;
                }*/
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    ApplicationArea = All;
                }
                //16225 Table field N/F
                /* field("Work Tax Group"; "Work Tax Group")
                 {
                     ApplicationArea = All;
                 }
                 field("Temp TDS Base"; "Temp TDS Base")
                 {
                     ApplicationArea = All;
                 }
                 field("SetOff Available"; "SetOff Available")
                 {
                     ApplicationArea = All;
                 }*/
                field(Subcontracting; Rec.Subcontracting)
                {
                    ApplicationArea = All;
                }
                field(SubConSend; Rec.SubConSend)
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan Posted"; Rec."Delivery Challan Posted")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Reject (Rework)"; Rec."Qty. to Reject (Rework)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rejected (Rework)"; Rec."Qty. Rejected (Rework)")
                {
                    ApplicationArea = All;
                }
                field(SendForRework; Rec.SendForRework)
                {
                    ApplicationArea = All;
                }
                field("Qty. to Reject (C.E.)"; Rec."Qty. to Reject (C.E.)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Reject (V.E.)"; Rec."Qty. to Reject (V.E.)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rejected (C.E.)"; Rec."Qty. Rejected (C.E.)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rejected (V.E.)"; Rec."Qty. Rejected (V.E.)")
                {
                    ApplicationArea = All;
                }
                field("Deliver Comp. For"; Rec."Deliver Comp. For")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Released Production Order"; Rec."Released Production Order")
                {
                    ApplicationArea = All;
                }
                field(SubConReceive; Rec.SubConReceive)
                {
                    ApplicationArea = All;
                }
                field("Component Item No."; Rec."Component Item No.")
                {
                    ApplicationArea = All;
                }
                //16225 Table Field N/F
                /*field("Service Tax Group"; "Service Tax Group")
                {
                    ApplicationArea = All;
                }
                field("Service Tax Base"; "Service Tax Base")
                {
                    ApplicationArea = All;
                }
                field("Service Tax Amount"; "Service Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Service Tax Registration No."; "Service Tax Registration No.")
                {
                    ApplicationArea = All;
                }
                field("eCESS % on TDS"; "eCESS % on TDS")
                {
                    ApplicationArea = All;
                }
                field("eCESS on TDS Amount"; "eCESS on TDS Amount")
                {
                    ApplicationArea = All;
                }
                field("Total TDS Including SHE CESS"; "Total TDS Including SHE CESS")
                {
                    ApplicationArea = All;
                }
                field("Per Contract"; "Per Contract")
                {
                    ApplicationArea = All;
                }
                field("Service Tax eCess Amount"; "Service Tax eCess Amount")
                {
                    ApplicationArea = All;
                }
                field("ADET Amount"; "ADET Amount")
                {
                    ApplicationArea = All;
                }
                field("AED(TTA) Amount"; "AED(TTA) Amount")
                {
                    ApplicationArea = All;
                }
                field("ADE Amount"; "ADE Amount")
                {
                    ApplicationArea = All;
                }
                field("Assessable Value"; "Assessable Value")
                {
                    ApplicationArea = All;
                }
                field("VAT Type"; "VAT Type")
                {
                    ApplicationArea = All;
                }
                field("SHE Cess Amount"; "SHE Cess Amount")
                {
                    ApplicationArea = All;
                }
                field("Service Tax SHE Cess Amount"; "Service Tax SHE Cess Amount")
                {
                    ApplicationArea = All;
                }
                field("Non ITC Claimable Usage %"; "Non ITC Claimable Usage %")
                {
                    ApplicationArea = All;
                }
                field("Amount Loaded on Inventory"; "Amount Loaded on Inventory")
                {
                    ApplicationArea = All;
                }
                field("Input Tax Credit Amount"; "Input Tax Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT able Purchase Tax Amount"; "VAT able Purchase Tax Amount")
                {
                    ApplicationArea = All;
                }*/
                field(Supplementary; Rec.Supplementary)
                {
                    ApplicationArea = All;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                }
                //16225 Table Field N/F
                /*field("ADC VAT Amount"; "ADC VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("CIF Amount"; "CIF Amount")
                {
                    ApplicationArea = All;
                }
                field("BCD Amount"; "BCD Amount")
                {
                    ApplicationArea = All;
                }
                field(CVD; Rec.CVD)
                {
                    ApplicationArea = All;
                }
                field("Notification Sl. No."; "Notification Sl. No.")
                {
                    ApplicationArea = All;
                }
                field("Notification No."; "Notification No.")
                {
                    ApplicationArea = All;
                }
                field("CTSH No."; Rec."CTSH No.")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("SHE Cess % On TDS"; "SHE Cess % On TDS")
                {
                    ApplicationArea = All;
                }
                field("SHE Cess on TDS Amount"; "SHE Cess on TDS Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Loading on Inventory"; "Excise Loading on Inventory")
                {
                    ApplicationArea = All;
                }
                field("Custom eCess Amount"; "Custom eCess Amount")
                {
                    ApplicationArea = All;
                }
                field("Custom SHECess Amount"; "Custom SHECess Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Refund"; "Excise Refund")
                {
                    ApplicationArea = All;
                }
                field("CWIP G/L Type"; "CWIP G/L Type")
                {
                    ApplicationArea = All;
                }*/
                field("Applies-to ID (Delivery)"; Rec."Applies-to ID (Delivery)")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID (Receipt)"; Rec."Applies-to ID (Receipt)")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan Date"; Rec."Delivery Challan Date")
                {
                    ApplicationArea = All;
                }
                //16225 Table Field N/F
                /*field("Item Charge Entry"; "Item Charge Entry")
                {
                    ApplicationArea = All;
                }
                field("Tot. Serv Tax Amount (Intm)"; "Tot. Serv Tax Amount (Intm)")
                {
                    ApplicationArea = All;
                }
                field("S. Tax Base Amount (Intm)"; "S. Tax Base Amount (Intm)")
                {
                    ApplicationArea = All;
                }
                field("S. Tax Amount (Intm)"; "S. Tax Amount (Intm)")
                {
                    ApplicationArea = All;
                }
                field("S. Tax eCess Amount (Intm)"; "S. Tax eCess Amount (Intm)")
                {
                    ApplicationArea = All;
                }
                field("S. Tax SHE Cess Amount (Intm)"; "S. Tax SHE Cess Amount (Intm)")
                {
                    ApplicationArea = All;
                }
                field("Amt. Incl. Service Tax (Intm)"; "Amt. Incl. Service Tax (Intm)")
                {
                    ApplicationArea = All;
                }
                field("Service Tax SBC %"; "Service Tax SBC %")
                {
                    ApplicationArea = All;
                }
                field("Service Tax SBC Amount"; "Service Tax SBC Amount")
                {
                    ApplicationArea = All;
                }
                field("Service Tax SBC Amount (Intm)"; "Service Tax SBC Amount (Intm)")
                {
                    ApplicationArea = All;
                }
                field("KK Cess%"; "KK Cess%")
                {
                    ApplicationArea = All;
                }
                field("KK Cess Amount"; "KK Cess Amount")
                {
                    ApplicationArea = All;
                }
                field("KK Cess Amount (Intm)"; "KK Cess Amount (Intm)")
                {
                    ApplicationArea = All;
                }*/
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Group Type"; rec."GST Group Type")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                //16225 table field N/F
                /* field("GST Base Amount"; "GST Base Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("GST %"; "GST %")
                 {
                     ApplicationArea = All;
                 }
                 field("Total GST Amount"; "Total GST Amount")
                 {
                     ApplicationArea = All;
                 }*/
                field(Exempted; rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("Custom Duty Amount"; rec."Custom Duty Amount")
                {
                    ApplicationArea = All;
                }
                field("GST Reverse Charge"; rec."GST Reverse Charge")
                {
                    ApplicationArea = All;
                }
                field("GST Assessable Value"; rec."GST Assessable Value")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-From GST Registration No"; rec."Buy-From GST Registration No")
                {
                    ApplicationArea = All;
                }
                field("GST Rounding Line"; rec."GST Rounding Line")
                {
                    ApplicationArea = All;
                }
                field("Bill to-Location(POS)"; rec."Bill to-Location(POS)")
                {
                    ApplicationArea = All;
                }
                field("Non-GST Line"; rec."Non-GST Line")
                {
                    ApplicationArea = All;
                }
                field("Rejection Reason Code"; rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Shortage Reason Code"; rec."Shortage Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Challan Quantity"; rec."Challan Quantity")
                {
                    ApplicationArea = All;
                }
                field("Actual Quantity"; rec."Actual Quantity")
                {
                    ApplicationArea = All;
                }
                field("Accepted Quantity"; rec."Accepted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shortage Quantity"; rec."Shortage Quantity")
                {
                    ApplicationArea = All;
                }
                field("Rejected Quantity"; rec."Rejected Quantity")
                {
                    ApplicationArea = All;
                }
                field("Indent No."; rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Indent Line No."; rec."Indent Line No.")
                {
                    ApplicationArea = All;
                }
                field(Make; rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Main Location"; rec."Main Location")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Excise Amount Per Unit"; rec."Excise Amount Per Unit")
                {
                    ApplicationArea = All;
                }
                field("Posting Date 1"; rec."Posting Date 1")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (FCY)"; rec."Unit Price (FCY)")
                {
                    ApplicationArea = All;
                }
                field("Amount (FCY)"; rec."Amount (FCY)")
                {
                    ApplicationArea = All;
                }
                field(Currency1; rec.Currency1)
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Source Order No."; rec."Source Order No.")
                {
                    ApplicationArea = All;
                }
                field("Selection."; rec."Selection.")
                {
                    ApplicationArea = All;
                }
                field("Shortage CRN"; rec."Shortage CRN")
                {
                    ApplicationArea = All;
                }
                field("Orient MRP"; rec."Orient MRP")
                {
                    ApplicationArea = All;
                }
                field("Capex No."; rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                field("Ref. Rate"; rec."Ref. Rate")
                {
                    ApplicationArea = All;
                }
                field("Possible Cenvat"; rec."Possible Cenvat")
                {
                    ApplicationArea = All;
                }
                field("Old Pending Qty"; rec."Old Pending Qty")
                {
                    ApplicationArea = All;
                }
                field("Diff Qty."; rec."Diff Qty.")
                {
                    ApplicationArea = All;
                }
                field("Ref Code"; rec."Ref Code")
                {
                    ApplicationArea = All;
                }
                field("Batch No."; rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("ITC Type"; rec."ITC Type")
                {
                    ApplicationArea = All;
                }
                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Header Status"; Rec."Purchase Header Status")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Indent Original Quantity"; Rec."Indent Original Quantity")
                {
                    ApplicationArea = All;
                }
                field("Original PO Qty"; Rec."Original PO Qty")
                {
                    ApplicationArea = All;
                }
                field(NOE; Rec.NOE)
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                }
                field("MPS Order"; Rec."MPS Order")
                {
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
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

