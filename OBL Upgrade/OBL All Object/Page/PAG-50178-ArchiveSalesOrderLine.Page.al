page 50178 "Archive Sales Order Line"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Sales Line Archive";
    SourceTableView = WHERE("Item Category Code" = CONST('M001|T001|H001|D001'),
                            "Document Type" = CONST(Order));

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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Release Date"; rec."Release Date")
                {
                    ApplicationArea = All;
                }
                field("Release Time"; rec."Release Time")
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
                field("Quantity Disc. Code"; Rec."Quantity Disc. Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
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
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
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
                field("Quantity Disc. %"; Rec."Quantity Disc. %")
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
                field("Price Group Code"; Rec."Price Group Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Quantity Disc."; Rec."Allow Quantity Disc.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Cust./Item Disc. %"; Rec."Cust./Item Disc. %")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Order Line No."; Rec."Purch. Order Line No.")
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
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field(Area1; Rec.Area) //16630 Field Name Area change in Area1
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
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
                field("Shipped Not Invoiced (LCY)"; Rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
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
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
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
                field(Planned; Rec.Planned)
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
                field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invd. (Base)"; Rec."Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
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
                field("Out-of-Stock Substitution"; Rec."Out-of-Stock Substitution")
                {
                    ApplicationArea = All;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = All;
                }
                field("Originally Ordered No."; Rec."Originally Ordered No.")
                {
                    ApplicationArea = All;
                }
                field("Originally Ordered Var. Code"; Rec."Originally Ordered Var. Code")
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
                /*   field("Product Group Code"; Rec."Product Group Code")
                   {
                   }*/
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = All;
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    ApplicationArea = All;
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Receive"; Rec."Return Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Receive (Base)"; Rec."Return Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Rcd. Not Invd."; Rec."Return Qty. Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)"; Rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Amt. Rcd. Not Invd."; Rec."Return Amt. Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Ret. Amt. Rcd. Not Invd. (LCY)"; Rec."Ret. Amt. Rcd. Not Invd. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Received"; Rec."Return Qty. Received")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Received (Base)"; Rec."Return Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Service Contract No."; Rec."Service Contract No.")
                {
                    ApplicationArea = All;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Service Entry"; Rec."Appl.-to Service Entry")
                {
                    ApplicationArea = All;
                }
                field("Service Item Line No."; Rec."Service Item Line No.")
                {
                    ApplicationArea = All;
                }
                field("Serv. Price Adjmt. Gr. Code"; Rec."Serv. Price Adjmt. Gr. Code")
                {
                    ApplicationArea = All;
                }
                field("BOM Item No."; Rec."BOM Item No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No."; Rec."Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt Line No."; Rec."Return Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                /*   field("Tax Amount"; "Tax Amount")
                   {
                   }
                   field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                   {
                   }
                   field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                   {
                   }
                   field("Excise Amount"; "Excise Amount")
                   {
                   }
                   field("Amount Including Excise"; "Amount Including Excise")
                   {
                   }
                   field("Excise Base Amount"; "Excise Base Amount")
                   {
                   }
                   field("Excise Accounting Type"; "Excise Accounting Type")
                   {
                   }
                   field("Excise Base Quantity"; "Excise Base Quantity")
                   {
                   }
                   field("Tax %"; "Tax %")
                   {
                   }
                   field("Amount Including Tax"; "Amount Including Tax")
                   {
                   }
                   field("Amount Added to Excise Base"; "Amount Added to Excise Base")
                   {
                   }
                   field("Amount Added to Tax Base"; "Amount Added to Tax Base")
                   {
                   }
                   field("Tax Base Amount"; "Tax Base Amount")
                   {
                   }
                   field("Surcharge %"; "Surcharge %")
                   {
                   }
                   field("Surcharge Amount"; "Surcharge Amount")
                   {
                   }
                   field("Concessional Code"; "Concessional Code")
                   {
                   }
                   field("Assessee Code"; "Assessee Code")
                   {
                   }
                   field("TDS %"; "TDS %")
                   {
                   }
                   field("Bal. TDS Including SHE CESS"; "Bal. TDS Including SHE CESS")
                   {
                   }
                   field("Claim Deferred Excise"; "Claim Deferred Excise")
                   {
                   }
                   field("Capital Item"; "Capital Item")
                   {
                   }
                   field("BED Amount"; "BED Amount")
                   {
                   }
                   field("AED(GSI) Amount"; "AED(GSI) Amount")
                   {
                   }
                   field("SED Amount"; "SED Amount")
                   {
                   }
                   field("SAED Amount"; "SAED Amount")
                   {
                   }
                   field("CESS Amount"; "CESS Amount")
                   {
                   }
                   field("NCCD Amount"; "NCCD Amount")
                   {
                   }
                   field("eCess Amount"; "eCess Amount")
                   {
                   }
                   field("Form Code"; "Form Code")
                   {
                   }
                   field("Form No."; "Form No.")
                   {
                   }
                   field(State; State)
                   {
                   }
                   field("TDS Amount"; "TDS Amount")
                   {
                   }
                   field("Amount To Customer"; "Amount To Customer")
                   {
                   }
                   field("Charges To Customer"; "Charges To Customer")
                   {
                   }
                   field("TDS Base Amount"; "TDS Base Amount")
                   {
                   }
                   field("Surcharge Base Amount"; "Surcharge Base Amount")
                   {
                   }
                   field("Temp TDS Base"; "Temp TDS Base")
                   {
                   }
                   field("Service Tax Group"; "Service Tax Group")
                   {
                   }
                   field("Service Tax Base"; "Service Tax Base")
                   {
                   }
                   field("Service Tax Amount"; "Service Tax Amount")
                   {
                   }
                   field("Service Tax Registration No."; "Service Tax Registration No.")
                   {
                   }
                   field("eCESS % on TDS"; "eCESS % on TDS")
                   {
                   }
                   field("eCESS on TDS Amount"; "eCESS on TDS Amount")
                   {
                   }
                   field("Total TDS Including SHE CESS"; "Total TDS Including SHE CESS")
                   {
                   }
                   field("Per Contract"; "Per Contract")
                   {
                   }
                   field("Service Tax eCess Amount"; "Service Tax eCess Amount")
                   {
                   }
                   field("ADET Amount"; "ADET Amount")
                   {
                   }
                   field("AED(TTA) Amount"; "AED(TTA) Amount")
                   {
                   }
                   field("Free Supply"; "Free Supply")
                   {
                   }
                   field("ADE Amount"; "ADE Amount")
                   {
                   }
                   field("Assessable Value"; "Assessable Value")
                   {
                   }
                   field("SHE Cess Amount"; "SHE Cess Amount")
                   {
                   }
                   field("Service Tax SHE Cess Amount"; "Service Tax SHE Cess Amount")
                   {
                   }
                   field("Direct Debit To PLA / RG"; "Direct Debit To PLA / RG")
                   {
                   }
                   field(Supplementary; Supplementary)
                   {
                   }
                   field("Source Document Type"; "Source Document Type")
                   {
                   }
                   field("Source Document No."; "Source Document No.")
                   {
                   }
                   field("Process Carried Out"; "Process Carried Out")
                   {
                   }
                   field("Identification Mark"; "Identification Mark")
                   {
                   }
                   field("Re-Dispatch"; "Re-Dispatch")
                   {
                   }
                   field("Return Rcpt line No."; "Return Rcpt line No.")
                   {
                   }
                   field("Qty. to be Re-Dispatched"; "Qty. to be Re-Dispatched")
                   {
                   }
                   field("Return Re-Dispatch Rcpt. No."; "Return Re-Dispatch Rcpt. No.")
                   {
                   }
                   field("SHE Cess % on TDS/TCS"; "SHE Cess % on TDS/TCS")
                   {
                   }
                   field("SHE Cess on TDS/TCS Amount"; "SHE Cess on TDS/TCS Amount")
                   {
                   }
                   field("MRP Price"; "MRP Price")
                   {
                   }
                   field(MRP; MRP)
                   {
                   }
                   field("Abatement %"; "Abatement %")
                   {
                   }
                   field("PIT Structure"; "PIT Structure")
                   {
                   }
                   field("Price Inclusive of Tax"; "Price Inclusive of Tax")
                   {
                   }*/
                field("Unit Price Incl. of Tax"; rec."Unit Price Incl. of Tax")
                {
                    ApplicationArea = All;
                }
                /*    field("Amount To Customer UPIT"; "Amount To Customer UPIT")
                    {
                    }
                    field("UPIT Rounding Inserted"; "UPIT Rounding Inserted")
                    {
                    }
                    field("Excise Effective Rate"; "Excise Effective Rate")
                    {
                    }
                    field("Service Tax SBC %"; "Service Tax SBC %")
                    {
                    }
                    field("Service Tax SBC Amount"; "Service Tax SBC Amount")
                    {
                    }
                    field("Service Tax SBC Amount (Intm)"; "Service Tax SBC Amount (Intm)")
                    {
                    }
                    field("KK Cess%"; "KK Cess%")
                    {
                    }
                    field("KK Cess Amount"; "KK Cess Amount")
                    {
                    }*/
                field("GST Place of Supply"; Rec."GST Place of Supply")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                }
                /*    field("GST Base Amount"; "GST Base Amount")
                    {
                    }
                    field("GST %"; "GST %")
                    {
                    }
                    field("Total GST Amount"; "Total GST Amount")
                    {
                    }*/
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("Invoice Type"; rec."Invoice Type")
                {
                    ApplicationArea = All;
                }
                field(Exempted; rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("Quantity in Cartons"; rec."Quantity in Cartons")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; Rec."Type Code")
                {
                    ApplicationArea = All;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Schemes; Rec.Schemes)
                {
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Code"; Rec."Packing Code")
                {
                    ApplicationArea = All;
                }
                field("Quality Code"; Rec."Quality Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt."; Rec."Quantity in Sq. Mt.")
                {
                    ApplicationArea = All;
                }
                field("Main Location"; Rec."Main Location")
                {
                    ApplicationArea = All;
                }
                field("Buyer's Price"; Rec."Buyer's Price")
                {
                    ApplicationArea = All;
                }
                field("Discount Per Unit"; Rec."Discount Per Unit")
                {
                    ApplicationArea = All;
                }
                field("Related Location code"; Rec."Related Location code")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (FCY)"; Rec."Unit Price (FCY)")
                {
                    ApplicationArea = All;
                }
                field("Amount (FCY)"; Rec."Amount (FCY)")
                {
                    ApplicationArea = All;
                }
                field("Carton No. From"; Rec."Carton No. From")
                {
                    ApplicationArea = All;
                }
                field("Carton No. To"; Rec."Carton No. To")
                {
                    ApplicationArea = All;
                }
                field("Pallet No. From"; Rec."Pallet No. From")
                {
                    ApplicationArea = All;
                }
                field("Pallet No. To"; Rec."Pallet No. To")
                {
                    ApplicationArea = All;
                }
                field("Total Pallets"; Rec."Total Pallets")
                {
                    ApplicationArea = All;
                }
                field("Total Cartons"; Rec."Total Cartons")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; Rec."Type Catogery Code")
                {
                    ApplicationArea = All;
                }
                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                }
                field("Remaining Inventory"; Rec."Remaining Inventory")
                {
                    ApplicationArea = All;
                }
                field("Total Reserved Quantity"; Rec."Total Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt.(Ship)"; Rec."Quantity in Sq. Mt.(Ship)")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Cartons(Ship)"; Rec."Quantity in Cartons(Ship)")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Hand"; Rec."Quantity in Hand")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Gross Weight (Ship)"; Rec."Gross Weight (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Net Weight (Ship)"; Rec."Net Weight (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Arch Date"; Rec."Arch Date")
                {
                    ApplicationArea = All;
                }
                field("Arch Time"; Rec."Arch Time")
                {
                    ApplicationArea = All;
                }
                /* field("Buyer Price / Sq.mt"; Rec.buyprice)
                 {
                 }*/
                field("Cust Type"; Rec."Cust Type")
                {
                    ApplicationArea = All;
                }
                field("reason code"; Rec."reason code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF saleshead.GET(rec."Document Type", rec."Document No.") THEN
            makeorderdate := saleshead."Order Date";
        custtype := saleshead."Customer Type";
        resson := saleshead."Reason Code";
        IF rec."Buyer's Price" <> 0 THEN
            buyprice := ROUND(rec."Buyer's Price" / xRec."Qty. per Unit of Measure", 2);
    end;

    var
        saleshead: Record "Sales Header Archive";
        makeorderdate: Date;
        custtype: Code[10];
        resson: Code[10];
        buyprice: Decimal;
}

