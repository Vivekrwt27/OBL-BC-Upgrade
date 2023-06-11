page 50110 "Rejection Note Subform"
{
    // 1. TRI V.D 30.10.10 - New Form created.

    AutoSplitKey = true;
    Caption = 'Purchase Order Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Rejection Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                Editable = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Orient MRP"; Rec."Orient MRP")
                {
                    ApplicationArea = All;
                }
                field("Tax %"; Rec."Tax %")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
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
                field("Ending Date"; Rec."Ending Date")
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
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Line No."; Rec."Indent Line No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("CWIP G/L Type"; Rec."CWIP G/L Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Tax Registration No."; Rec."Service Tax Registration No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Tax Group"; Rec."Service Tax Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Shortage Reason Code"; Rec."Shortage Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Challan Quantity"; Rec."Challan Quantity")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Vipul 04.02.2006 Change Request Add Start
                        Rec.VALIDATE("Qty. to Receive", 0);
                        Rec.VALIDATE("Qty. to Invoice", 0);
                        //Vipul 04.02.2006 Change Request Add Stop
                    end;
                }
                field("Actual Quantity"; Rec."Actual Quantity")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Vipul 04.02.2006 Change Request Add Start
                        Rec.VALIDATE("Qty. to Receive", Rec."Actual Quantity");
                        //VALIDATE("Qty. to Invoice","Actual Quantity");
                        //Vipul 04.02.2006 Change Request Add Stop
                    end;
                }
                field("Accepted Quantity"; Rec."Accepted Quantity")
                {
                    NotBlank = false;
                    ApplicationArea = All;
                }
                field("Shortage Quantity"; Rec."Shortage Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rejected Quantity"; Rec."Rejected Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Non ITC Claimable Usage %"; Rec."Non ITC Claimable Usage %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Amount Loaded on Inventory"; Rec."Amount Loaded on Inventory")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Excise Loading on Inventory"; Rec."Excise Loading on Inventory")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Input Tax Credit Amount"; Rec."Input Tax Credit Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT able Purchase Tax Amount"; Rec."VAT able Purchase Tax Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assessable Value"; Rec."Assessable Value")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("CIF Amount"; Rec."CIF Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("BCD Amount"; Rec."BCD Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("BED Amount"; Rec."BED Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("AED(GSI) Amount"; Rec."AED(GSI) Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("SED Amount"; Rec."SED Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("SAED Amount"; Rec."SAED Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("CESS Amount"; Rec."CESS Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ADET Amount"; Rec."ADET Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("AED(TTA) Amount"; Rec."AED(TTA) Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ADE Amount"; Rec."ADE Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("NCCD Amount"; Rec."NCCD Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Custom eCess Amount"; Rec."Custom eCess Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Custom SHECess Amount"; Rec."Custom SHECess Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("eCess Amount"; Rec."eCess Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("SHE Cess Amount"; Rec."SHE Cess Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ADC VAT Amount"; Rec."ADC VAT Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Excise Refund"; Rec."Excise Refund")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assessee Code"; Rec."Assessee Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
                {
                    ApplicationArea = All;
                }
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    ApplicationArea = All;
                }
                field("Work Tax Base Amount"; Rec."Work Tax Base Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                    end;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit 378;
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        PurchInfoPaneMgt: Codeunit 7181;
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit 7010;
        Text001: Label 'You can not use the Explode BOM function because a prepayment of the purchase order has been invoiced.';


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;
}

