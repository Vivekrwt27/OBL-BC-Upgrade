page 50213 "Transfer Order Lines CC Team"
{
    PageType = List;
    SourceTable = "Transfer Line";
    SourceTableView = WHERE("External Transfer" = CONST(true),
                            "Item Category Code" = CONST('D001|T001|H001|M001'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
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
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
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
                field("Qty. to Ship (Base)"; rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped (Base)"; rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive (Base)"; rec."Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Received (Base)"; rec."Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
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
                field("Unit Volume"; rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; rec."Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. in Transit"; rec."Qty. in Transit")
                {
                    ApplicationArea = All;
                }
                field("Qty. in Transit (Base)"; rec."Qty. in Transit (Base)")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Derived From Line No."; rec."Derived From Line No.")
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
                field("Reserved Quantity Inbnd."; rec."Reserved Quantity Inbnd.")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity Outbnd."; rec."Reserved Quantity Outbnd.")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. Inbnd. (Base)"; rec."Reserved Qty. Inbnd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. Outbnd. (Base)"; rec."Reserved Qty. Outbnd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity Shipped"; rec."Reserved Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. Shipped (Base)"; rec."Reserved Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                /*  field("Product Group Code"; rec."Product Group Code")
                  {
                      ApplicationArea = All;
                  }*/
                field("Whse. Inbnd. Otsdg. Qty (Base)"; rec."Whse. Inbnd. Otsdg. Qty (Base)")
                {
                    ApplicationArea = All;
                }
                field("Whse Outbnd. Otsdg. Qty (Base)"; rec."Whse Outbnd. Otsdg. Qty (Base)")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Completely Received"; rec."Completely Received")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Bin Code"; rec."Transfer-from Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-To Bin Code"; rec."Transfer-To Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer Price"; rec."Transfer Price")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                /*  field("BED Amount"; rec."BED Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("AED(GSI) Amount"; rec."AED(GSI) Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("SED Amount"; rec."SED Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("SAED Amount"; rec."SAED Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("CESS Amount"; rec."CESS Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("NCCD Amount"; rec."NCCD Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("eCess Amount"; rec."eCess Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Amount"; rec."Excise Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Amount Including Excise"; rec."Amount Including Excise")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Accounting Type"; rec."Excise Accounting Type")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
                  {
                      ApplicationArea = All;
                  }
                  field("Capital Item"; rec."Capital Item")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Base Quantity"; rec."Excise Base Quantity")
                  {
                      ApplicationArea = All;
                  }
                  field("Excise Base Amount"; rec."Excise Base Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("Amount Added to Excise Base"; rec."Amount Added to Excise Base")
                  {
                      ApplicationArea = All;
                  }*/
                field("Amount Added to Inventory"; rec."Amount Added to Inventory")
                {
                    ApplicationArea = All;
                }
                field("Charges to Transfer"; rec."Charges to Transfer")
                {
                    ApplicationArea = All;
                }
                /* field("Total Amount to Transfer"; rec."Total Amount to Transfer")
                 {
                     ApplicationArea = All;
                 }
                 field("Claim Deferred Excise"; rec."Claim Deferred Excise")
                 {
                     ApplicationArea = All;
                 }
                 field("ADET Amount"; rec."ADET Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("AED(TTA) Amount"; rec."AED(TTA) Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("ADE Amount"; rec."ADE Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Assessable Value"; rec."Assessable Value")
                 {
                     ApplicationArea = All;
                 }
                 field("SHE Cess Amount"; rec."SHE Cess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("ADC VAT Amount"; rec."ADC VAT Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("CIF Amount"; rec."CIF Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("BCD Amount"; rec."BCD Amount")
                 {
                     ApplicationArea = All;
                 }
                 field(CVD; rec.CVD)
                 {
                     ApplicationArea = All;
                 }
                 field("Excise Loading on Inventory"; rec."Excise Loading on Inventory")
                 {
                     ApplicationArea = All;
                 }
                 field("Captive Consumption %"; rec."Captive Consumption %")
                 {
                     ApplicationArea = All;
                 }
                 field("Admin. Cost %"; rec."Admin. Cost %")
                 {
                     ApplicationArea = All;
                 }
                 field("MRP Price"; rec."MRP Price")
                 {
                     ApplicationArea = All;
                 }
                 field(MRP; rec.MRP)
                 {
                     ApplicationArea = All;
                 }
                 field("Abatement %"; rec."Abatement %")
                 {
                     ApplicationArea = All;
                 }
                 field("Applies-to Entry (RG 23 D)"; rec."Applies-to Entry (RG 23 D)")
                 {
                     ApplicationArea = All;
                 }
                 field("Cost of Production"; rec."Cost of Production")
                 {
                     ApplicationArea = All;
                 }
                 field("Cost Of Prod. Incl. Admin Cost"; rec."Cost Of Prod. Incl. Admin Cost")
                 {
                     ApplicationArea = All;
                 }
                 field("Custom eCess Amount"; rec."Custom eCess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Custom SHECess Amount"; rec."Custom SHECess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Excise Effective Rate"; rec."Excise Effective Rate")
                 {
                     ApplicationArea = All;
                 }
                 field("Applies-to Entry (Ship)"; rec."Applies-to Entry (Ship)")
                 {
                     ApplicationArea = All;
                 }
                 field("GST Base Amount"; rec."GST Base Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("GST %"; rec."GST %")
                 {
                     ApplicationArea = All;
                 }
                 field("Total GST Amount"; rec."Total GST Amount")
                 {
                     ApplicationArea = All;
                 }*/
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("GST Credit"; rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("From Main Location"; rec."From Main Location")
                {
                    ApplicationArea = All;
                }
                field("To Main Location"; rec."To Main Location")
                {
                    ApplicationArea = All;
                }
                field("Plant Code"; rec."Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; rec."Type Code")
                {
                    ApplicationArea = All;
                }
                field("Size Code"; rec."Size Code")
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
                field("Qty in Sq. Mt."; rec."Qty in Sq. Mt.")
                {
                    ApplicationArea = All;
                }
                field("Qty in Carton."; rec."Qty in Carton.")
                {
                    ApplicationArea = All;
                }
                field("External Transfer"; rec."External Transfer")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to State"; rec."Transfer-to State")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; rec."Type Catogery Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Price Type"; rec."Price Type")
                {
                    ApplicationArea = All;
                }
                field("Short Quantity"; rec."Short Quantity")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field(ReProcess; rec.ReProcess)
                {
                    ApplicationArea = All;
                }
                field("Shoratge Transfer Rcpt No."; rec."Shoratge Transfer Rcpt No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("End Use Item"; rec."End Use Item")
                {
                    ApplicationArea = All;
                }
                field("Issue to Machine"; rec."Issue to Machine")
                {
                    ApplicationArea = All;
                }
                field("Shelf No."; rec."Shelf No.")
                {
                    ApplicationArea = All;
                }
                field(Inventory; rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Capex No."; rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; rec."Planning Flexibility")
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

