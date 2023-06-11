page 50169 "Sales Line Detail"
{
    Editable = true;
    PageType = List;
    Permissions =;
    SourceTable = "Sales Line";
    UsageCategory = Lists;
    ApplicationArea = ALL;



    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; rec."Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; rec."Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; rec."Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; rec."Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Purch. Order Line No."; rec."Purch. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Clause Code"; rec."VAT Clause Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount (LCY)"; rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced (LCY)"; rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field(Reserve; rec.Reserve)
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount"; rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference"; rec."VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Inv. Disc. Amount to Invoice"; rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier"; rec."VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; rec."Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; rec."Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Incl. VAT"; rec."Prepmt. Amt. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Amount"; rec."Prepayment Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Base Amt."; rec."Prepmt. VAT Base Amt.")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT %"; rec."Prepayment VAT %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Calc. Type"; rec."Prepmt. VAT Calc. Type")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Identifier"; rec."Prepayment VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Area Code"; rec."Prepayment Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Liable"; rec."Prepayment Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Group Code"; rec."Prepayment Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt to Deduct"; rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt Deducted"; rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Line"; rec."Prepayment Line")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. Incl. VAT"; rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. (LCY)"; rec."Prepmt. Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Amount Inv. (LCY)"; rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Difference"; rec."Prepayment VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. to Deduct"; rec."Prepmt VAT Diff. to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. Deducted"; rec."Prepmt VAT Diff. Deducted")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Assemble to Order"; rec."Qty. to Assemble to Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Asm. to Order (Base)"; rec."Qty. to Asm. to Order (Base)")
                {
                    ApplicationArea = All;
                }
                field("ATO Whse. Outstanding Qty."; rec."ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                }
                field("ATO Whse. Outstd. Qty. (Base)"; rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Contract Entry No."; rec."Job Contract Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Planned; rec.Planned)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice (Base)"; rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship (Base)"; rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invd. (Base)"; rec."Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped (Base)"; rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; rec."FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                }
                field("Use Duplication List"; rec."Use Duplication List")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Out-of-Stock Substitution"; rec."Out-of-Stock Substitution")
                {
                    ApplicationArea = All;
                }
                field("Substitution Available"; rec."Substitution Available")
                {
                    ApplicationArea = All;
                }
                field("Originally Ordered No."; rec."Originally Ordered No.")
                {
                    ApplicationArea = All;
                }
                field("Originally Ordered Var. Code"; rec."Originally Ordered Var. Code")
                {
                    ApplicationArea = All;
                }
              /*   field("Cross-Reference No."; rec."Cross-Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure (Cross Ref.)"; rec."Unit of Measure (Cross Ref.)")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type"; rec."Cross-Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type No."; rec."Cross-Reference Type No.")
                {
                    ApplicationArea = All;
                }
               */  field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; rec."Purchasing Code")
                {
                    ApplicationArea = All;
                }
                /* field("Product Group Code"; rec."Product Group Code")
                 {
                     ApplicationArea = All;
                 }*/
                field("Special Order"; rec."Special Order")
                {
                    ApplicationArea = All;
                }
                field("Special Order Purchase No."; rec."Special Order Purchase No.")
                {
                    ApplicationArea = All;
                }
                field("Special Order Purch. Line No."; rec."Special Order Purch. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty."; rec."Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                }
                field("Qty. Assigned"; rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Receive"; rec."Return Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Receive (Base)"; rec."Return Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Rcd. Not Invd."; rec."Return Qty. Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)"; rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Rcd. Not Invd."; rec."Return Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Return Rcd. Not Invd. (LCY)"; rec."Return Rcd. Not Invd. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Received"; rec."Return Qty. Received")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Received (Base)"; rec."Return Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; rec."Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                }
                field("BOM Item No."; rec."BOM Item No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No."; rec."Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt Line No."; rec."Return Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                /*  field("Tax Amount"; rec."Tax Amount")
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
                  field("Excise Amount"; "Excise Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Amount Including Excise"; "Amount Including Excise")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Base Amount"; "Excise Base Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Accounting Type"; "Excise Accounting Type")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Base Quantity"; "Excise Base Quantity")
                  {
                      ApplicationArea = All;
                  }
                  field("Tax %"; "Tax %")
                  {
                      ApplicationArea = All;
                  }
                  field("Amount Including Tax"; "Amount Including Tax")
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
                  field("Tax Base Amount"; "Tax Base Amount")
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
                  }*/
                field("Assessee Code"; rec."Assessee Code")
                {
                    ApplicationArea = All;
                }
                /*  field("TDS/TCS %"; "TDS/TCS %")
                  {
                      ApplicationArea = All;
                  }
                  field("Bal. TDS/TCS Including SHECESS"; "Bal. TDS/TCS Including SHECESS")
                  {
                      ApplicationArea = All;
                  }
                  field("Claim Deferred Excise"; "Claim Deferred Excise")
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
                  field("Form Code"; "Form Code")
                  {
                      ApplicationArea = All;
                  }
                  field("Form No."; "Form No.")
                  {
                      ApplicationArea = All;
                  }
                  field(State; State)
                  {
                      ApplicationArea = All;
                  }
                  field("TDS/TCS Amount"; "TDS/TCS Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Amount To Customer"; "Amount To Customer")
                  {
                      ApplicationArea = All;
                  }
                  field("Charges To Customer"; "Charges To Customer")
                  {
                      ApplicationArea = All;
                  }
                  field("TDS/TCS Base Amount"; "TDS/TCS Base Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Surcharge Base Amount"; "Surcharge Base Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Temp TDS/TCS Base"; "Temp TDS/TCS Base")
                  {
                      ApplicationArea = All;
                  }
                  field("Service Tax Group"; "Service Tax Group")
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
                  field("eCESS % on TDS/TCS"; "eCESS % on TDS/TCS")
                  {
                      ApplicationArea = All;
                  }
                  field("eCESS on TDS/TCS Amount"; "eCESS on TDS/TCS Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Total TDS/TCS Incl. SHE CESS"; "Total TDS/TCS Incl. SHE CESS")
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
                  field("Free Supply"; "Free Supply")
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
                  field("Direct Debit To PLA / RG"; "Direct Debit To PLA / RG")
                  {
                      ApplicationArea = All;
                  }*/
                field("TCS Nature of Collection"; rec."TCS Nature of Collection")
                {
                    ApplicationArea = All;
                }
                /* field("TCS Type"; "TCS Type")
                 {
                     ApplicationArea = All;
                 }
                 field("Standard Deduction %"; "Standard Deduction %")
                 {
                     ApplicationArea = All;
                 }
                 field("Standard Deduction Amount"; "Standard Deduction Amount")
                 {
                     ApplicationArea = All;
                 }
                 field(Supplementary; Supplementary)
                 {
                     ApplicationArea = All;
                 }
                 field("Source Document Type"; "Source Document Type")
                 {
                     ApplicationArea = All;
                 }
                 field("Source Document No."; "Source Document No.")
                 {
                     ApplicationArea = All;
                 }
                 field("ADC VAT Amount"; "ADC VAT Amount")
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
                 field(CVD; CVD)
                 {
                     ApplicationArea = All;
                 }
                 field("Process Carried Out"; "Process Carried Out")
                 {
                     ApplicationArea = All;
                 }
                 field("Identification Mark"; "Identification Mark")
                 {
                     ApplicationArea = All;
                 }
                 field("Re-Dispatch"; "Re-Dispatch")
                 {
                     ApplicationArea = All;
                 }
                 field("Return Rcpt Line No."; "Return Rcpt Line No.")
                 {
                     ApplicationArea = All;
                 }
                 field("Qty. to be Re-Dispatched"; "Qty. to be Re-Dispatched")
                 {
                     ApplicationArea = All;
                 }
                 field("Return Re-Dispatch Rcpt. No."; "Return Re-Dispatch Rcpt. No.")
                 {
                     ApplicationArea = All;
                 }
                 field("SHE Cess % on TDS/TCS"; "SHE Cess % on TDS/TCS")
                 {
                     ApplicationArea = All;
                 }
                 field("SHE Cess on TDS/TCS Amount"; "SHE Cess on TDS/TCS Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("MRP Price"; "MRP Price")
                 {
                     ApplicationArea = All;
                 }
                 field(MRP; MRP)
                 {
                     ApplicationArea = All;
                 }
                 field("Abatement %"; "Abatement %")
                 {
                     ApplicationArea = All;
                 }
                 field("PIT Structure"; "PIT Structure")
                 {
                     ApplicationArea = All;
                 }*/
                field("Price Inclusive of Tax"; rec."Price Inclusive of Tax")
                {
                    ApplicationArea = All;
                }
                field("Unit Price Incl. of Tax"; rec."Unit Price Incl. of Tax")
                {
                    ApplicationArea = All;
                }
                /*field("Excise Base Variable";rec. "Excise Base Variable")
                {
                    ApplicationArea = All;
                }
                field("Tax Base Variable";rec. "Tax Base Variable")
                {
                    ApplicationArea = All;
                }
                field("Amount To Customer UPIT";rec. "Amount To Customer UPIT")
                {
                    ApplicationArea = All;
                }
                field("UPIT Rounding Inserted"; rec."UPIT Rounding Inserted")
                {
                    ApplicationArea = All;
                }*/
                field("Total UPIT Amount"; rec."Total UPIT Amount")
                {
                    ApplicationArea = All;
                }
                /* field("Inv Discount Fixed";rec. "Inv Discount Fixed")
                 {
                     ApplicationArea = All;
                 }
                 field("Inv Discount Variable";Rec. "Inv Discount Variable")
                 {
                     ApplicationArea = All;
                 }
                 field("Custom eCess Amount";Rec. "Custom eCess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Custom SHECess Amount";Rec. "Custom SHECess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Excise Effective Rate";Rec. "Excise Effective Rate")
                 {
                     ApplicationArea = All;
                 }
                 field("Item Charge Entry";Rec. "Item Charge Entry")
                 {
                     ApplicationArea = All;
                 }
                 field("Tot. Serv Tax Amount (Intm)";Rec. "Tot. Serv Tax Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("S. Tax Base Amount (Intm)";Rec. "S. Tax Base Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("S. Tax Amount (Intm)";Rec. "S. Tax Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("S. Tax eCess Amount (Intm)";Rec. "S. Tax eCess Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("S. Tax SHE Cess Amount (Intm)";Rec. "S. Tax SHE Cess Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("Amt. Incl. Service Tax (Intm)";Rec. "Amt. Incl. Service Tax (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("Service Tax SBC %";Rec. "Service Tax SBC %")
                 {
                     ApplicationArea = All;
                 }
                 field("Service Tax SBC Amount"; rec."Service Tax SBC Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Service Tax SBC Amount (Intm)"; rec."Service Tax SBC Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }
                 field("KK Cess%";rec. "KK Cess%")
                 {
                     ApplicationArea = All;
                 }
                 field("KK Cess Amount"; rec."KK Cess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("KK Cess Amount (Intm)"; rec."KK Cess Amount (Intm)")
                 {
                     ApplicationArea = All;
                 }*/
                field("Quantity in Cartons"; rec."Quantity in Cartons")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; rec."Type Code")
                {
                    ApplicationArea = All;
                }
                field("Plant Code"; rec."Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Size Code"; rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date1"; rec."Posting Date1")
                {
                    ApplicationArea = All;
                }
                field(Schemes; rec.Schemes)
                {
                    ApplicationArea = All;
                }
                field("Color Code"; rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Design Code"; rec."Design Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Code"; rec."Packing Code")
                {
                    ApplicationArea = All;
                }
                field("Quality Code"; rec."Quality Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt."; rec."Quantity in Sq. Mt.")
                {
                    ApplicationArea = All;
                }
                field("Main Location"; rec."Main Location")
                {
                    ApplicationArea = All;
                }
                field("Buyer's Price"; rec."Buyer's Price")
                {
                    ApplicationArea = All;
                }
                field("Discount Per Unit"; rec."Discount Per Unit")
                {
                    ApplicationArea = All;
                }
                field("Related Location code"; rec."Related Location code")
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
                field("Carton No. From"; rec."Carton No. From")
                {
                    ApplicationArea = All;
                }
                field("Carton No. To"; rec."Carton No. To")
                {
                    ApplicationArea = All;
                }
                field("Pallet No. From"; rec."Pallet No. From")
                {
                    ApplicationArea = All;
                }
                field("Pallet No. To"; rec."Pallet No. To")
                {
                    ApplicationArea = All;
                }
                field("Total Pallets"; rec."Total Pallets")
                {
                    ApplicationArea = All;
                }
                field("Total Cartons"; rec."Total Cartons")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Type"; rec."Item Type")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; rec."Type Catogery Code")
                {
                    ApplicationArea = All;
                }
                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                }
                field("Remaining Inventory"; rec."Remaining Inventory")
                {
                    ApplicationArea = All;
                }
                field("Total Reserved Quantity"; rec."Total Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt.(Ship)"; rec."Quantity in Sq. Mt.(Ship)")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Cartons(Ship)"; rec."Quantity in Cartons(Ship)")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Hand SQM"; rec."Quantity in Hand SQM")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Blanket Order"; rec."Quantity in Blanket Order")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Gross Weight (Ship)"; rec."Gross Weight (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Net Weight (Ship)"; rec."Net Weight (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Discount Per SQ.MT"; rec."Discount Per SQ.MT")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Hand CRT"; rec."Quantity in Hand CRT")
                {
                    ApplicationArea = All;
                }
                field("Order Qty (CRT)"; rec."Order Qty (CRT)")
                {
                    ApplicationArea = All;
                }
                field("Default Prod. Plant Code"; rec."Default Prod. Plant Code")
                {
                    ApplicationArea = All;
                }
                field(COCO; rec.COCO)
                {
                    ApplicationArea = All;
                }
                field("Sales Type"; rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field("TDS Nature of Deduction"; rec."TDS Nature of Deduction")
                {
                    ApplicationArea = All;
                }
                field("TDS Group"; rec."TDS Group")
                {
                    ApplicationArea = All;
                }
                field("TDS Amount Including Surcharge"; rec."TDS Amount Including Surcharge")
                {
                    ApplicationArea = All;
                }
                field("Balance Surcharge Amount"; rec."Balance Surcharge Amount")
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Releasing Date"; rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field(City; rec.City)
                {
                    ApplicationArea = All;
                }
                /*     field("State Name"; rec."State Name")
                    {
                        ApplicationArea = All;
                    }
                */
                field("Offer Code"; rec."Offer Code")
                {
                    ApplicationArea = All;
                }
                field(Slab; rec.Slab)
                {
                    ApplicationArea = All;
                }
                field("Quantity Discount %"; rec."Quantity Discount %")
                {
                    ApplicationArea = All;
                }
                field("Quantity Discount Amount"; rec."Quantity Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Accrued Quantity"; rec."Accrued Quantity")
                {
                    ApplicationArea = All;
                }
                field("Calculate Line Discount"; rec."Calculate Line Discount")
                {
                    ApplicationArea = All;
                }
                field("Accrued Discount"; rec."Accrued Discount")
                {
                    ApplicationArea = All;
                }
                field("Structure Calculated"; rec."Structure Calculated")
                {
                    ApplicationArea = All;
                }
                field("Scheme Group Code"; rec."Scheme Group Code")
                {
                    ApplicationArea = All;
                }
                field(D1; rec.D1)
                {
                    ApplicationArea = All;
                }
                field(D2; rec.D2)
                {
                    ApplicationArea = All;
                }
                field(D3; rec.D3)
                {
                    ApplicationArea = All;
                }
                field(D4; rec.D4)
                {
                    ApplicationArea = All;
                }
                field(ORC; rec.D6)
                {
                    Caption = 'ORC';
                    ApplicationArea = All;
                }
                field(Freight; rec.S1)
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 1"; rec."Discount Amt 1")
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 2"; rec."Discount Amt 2")
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 3"; rec."Discount Amt 3")
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 4"; rec."Discount Amt 4")
                {
                    ApplicationArea = All;
                }
                field("System Discount Amount"; rec."System Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Price Excl. VAT/Sq.Mt"; rec."Unit Price Excl. VAT/Sq.Mt")
                {
                    ApplicationArea = All;
                }
                field("Buyer's Price /Sq.Mt"; rec."Buyer's Price /Sq.Mt")
                {
                    ApplicationArea = All;
                }
                field("Ship To City"; shiptocity)
                {
                    Caption = 'Ship To City';
                    ApplicationArea = All;
                }
                field(Pay; pay)
                {
                    Caption = 'Pay';
                    OptionCaption = 'To Pay, To Be Billed';
                    ApplicationArea = All;
                }
                field(sp_name; sp_name)
                {
                    Caption = 'sp_name';
                    ApplicationArea = All;
                }
                field("AD Remarks"; rec."AD Remarks")
                {
                    ApplicationArea = All;
                }
                field("Manuf. Strategy"; manufstrategy)
                {
                    Caption = 'Manuf. Strategy';
                    Editable = false;
                    OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO';
                    ApplicationArea = All;
                }
                /*field("Make Order Date"; "Make Order Date")
                {
                    ApplicationArea = All;
                }
                field("Status Updated"; "Status Updated")
                {
                    ApplicationArea = All;
                }*/
                field("Sent Time Approval"; SentTime)
                {
                    ApplicationArea = All;
                }
                field("PCH Approval Time"; PCHTime)
                {
                    ApplicationArea = All;
                }
                field("ZM Approval Time"; ZMTime)
                {
                    ApplicationArea = All;
                }
                field("Hiigh Value Product"; hvp)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PSM Approval Time"; PSMTime)
                {
                    ApplicationArea = All;
                }
                field("PAC Approval Time"; PACTime)
                {
                    ApplicationArea = All;
                }
                field("Type Category"; tableautype)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pch Name'"; pchname)
                {
                    ApplicationArea = All;
                }
                field("Order Value"; Ordeval)
                {
                    ApplicationArea = All;
                }
                field("Invoice Value"; Invval)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Value"; outval)
                {
                    ApplicationArea = All;
                }
                field("ORC Code"; orccode)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ORC Terms"; orcterm)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PO No."; PONo)
                {
                    ApplicationArea = All;
                }
                /* field(ASP; S1 + D6 + "Buyer's Price /Sq.Mt")
                 {
                     ApplicationArea = All;
                 }*/
                field("Document Date"; DocumentDt)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Type"; custtype)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    AccessByPermission = TableData "Sales Line" = M;
                    ApplicationArea = All;
                }
                field("Despatch Remarks"; Despatchremarks)
                {
                    ApplicationArea = All;
                }
                field("Itemr Change Remarks"; rec."Itemr Change Remarks")
                {
                    ApplicationArea = All;
                }
                field("Reason To Hold"; Reasontohold)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Process Date"; orderprocessdt)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Size Description"; sizedesc)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*   field("Outstanding Weight"; outgrossweight * "Outstanding Qty. (Base)")
                   {
                       Editable = false;
                       ApplicationArea = All;
                   }*/
                field(Zone; salterr)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tableau Product Group"; TBC)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Credit Appoval"; CreditApp)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Price Approval"; PriceApp)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inventory Available"; InvApp)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Wharehouse Inv System")
            {
                Caption = 'Wharehouse Inv System';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category10;
                RunObject = Page 50255;
                RunPageLink = "item Code" = FIELD("No."),
                              Location = FIELD("Location Code");
                RunPageView = SORTING("item Code")
                              ORDER(Ascending);
                ShortCutKey = 'Ctrl+K';
            }
        }



    }

    trigger OnAfterGetRecord()
    begin
        /*IF USERID = 'MA009' THEN BEGIN
          SETFILTER("Document Type", 'Blanket Order');
         // SETFILTER("Document Type", '<>%1','Credit Memo');
        END;
        */
        Despatchremarks := '';
        Reasontohold := '';
        Ordeval := Rec."Buyer's Price /Sq.Mt" * rec."Quantity (Base)";
        Invval := rec."Buyer's Price /Sq.Mt" * rec."Qty. Invoiced (Base)";
        outval := rec."Buyer's Price /Sq.Mt" * rec."Outstanding Qty. (Base)";

        IF saleshead.GET(rec."Document Type", rec."Document No.") THEN
            shiptocity := saleshead."Ship-to City";
        pay := saleshead.Pay;
        orccode := saleshead."Dealer Code";
        orcterm := saleshead."ORC Terms";
        PONo := saleshead."PO No.";
        Despatchremarks := saleshead."Despatch Remarks";
        Reasontohold := saleshead.Commitment;
        CreditApp := saleshead."Credit Approved";
        PriceApp := saleshead."Price Approved";
        InvApp := saleshead."Inventory Approved";
        Bypass := saleshead."Bypass Auto Order Process";

        // makeorderdate := saleshead."Make Order Date";

        IF saleshead.GET(rec."Document Type", rec."Document No.") THEN
            makeorderdate := saleshead."Make Order Date";
        DocumentDt := saleshead."Document Date";
        orderprocessdt := saleshead."Payment Date 3";

        IF RecItem.GET(rec."No.") THEN
            TBC := RecItem."Tableau Product Group";



        //MSAK
        /*
        IF spname.GET("Salesperson Code") THEN
           sp_name := spname.Name;
        */
        RecCust.RESET;
        IF RecCust.GET(rec."Sell-to Customer No.") THEN
            sp_name := RecCust."Salesperson Description";
        salterr := RecCust."Tableau Zone";
        //Custype := Custype::RecCust."Customer Type";
        //MSAK

        IF rec.Type = Type::Item THEN
            IF RecItem.GET(Rec."No.") THEN
                manufstrategy := RecItem."Manuf. Strategy";

        //
        CLEAR(SentTime);
        CLEAR(PACTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                    PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;

        CLEAR(Count1);
        CLEAR(PCHTime);
        CLEAR(ZMTime);
        CLEAR(PSMTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                Count1 += 1;
                IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;
        //MSAK

        IF item1.GET(rec."No.") THEN
            tableautype := item1."Tableau Product Group";
        pchname := RecCust."PCH Name";
        sizedesc := item1."Size Code Desc.";
        outgrossweight := item1."Gross Weight";

        IF rec.Type = Type::Item THEN BEGIN
            hvpnon.SETFILTER("Item No.", '%1', rec."No.");
            hvpnon.SETFILTER("Starting Date", '%1..', 20180104D);
            IF hvpnon.FINDLAST THEN
                hvp := hvpnon."HVP/Discontinued";
        END;

        IF RecCust.GET(rec."Sell-to Customer No.") THEN;
        custtype := RecCust."Customer Type";


    end;

    var
        saleshead: Record "Sales Header";
        makeorderdate: DateTime;
        shiptocity: Text[50];
        pay: Option;
        pay1: Option;
        spname: Record "Salesperson/Purchaser";
        sp_name: Text[50];
        manufstrategy: Option;
        RecItem: Record Item;
        ArchiveApprovalEntryREC: Record "Archive Approval Entry";
        SentTime: DateTime;
        PACTime: DateTime;
        Count1: Integer;
        PCHTime: DateTime;
        ZMTime: DateTime;
        PSMTime: DateTime;
        RecCust: Record Customer;
        hvp: Boolean;
        hvpnon: Record "HVP/Discontinued Items";
        item1: Record Item;
        tableautype: Text[20];
        custtype: Text[20];
        pchname: Text[35];
        Ordeval: Decimal;
        Invval: Decimal;
        outval: Decimal;
        orccode: Code[10];
        orcterm: Text[50];
        PONo: Text[20];
        DocumentDt: Date;
        Custype: Option;
        Despatchremarks: Text[50];
        Reasontohold: Text[50];
        orderprocessdt: Date;
        sizedesc: Text[10];
        outgrossweight: Decimal;
        salterr: Text[30];
        TBC: Text[20];
        CreditApp: Boolean;
        PriceApp: Boolean;
        InvApp: Boolean;
        Bypass: Boolean;
}

