page 50152 "Purch. Invoice Subform-IC"
{
    AutoSplitKey = true;
    Caption = 'Purch. Invoice Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                /*field("Assessable Value"; "Assessable Value")
                {
                    ApplicationArea = All;
                }
                field("Tax Amount"; "Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("TDS Category"; "TDS Category")
                {
                    ApplicationArea = All;
                }
                field("TDS Group"; "TDS Group")
                {
                    ApplicationArea = All;
                }*/
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Source Order No."; Rec."Source Order No.")
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
                /*  field("Assessee Code"; "Assessee Code")
                  {
                      ApplicationArea = All;
                  }
                  field("TDS Nature of Deduction"; "TDS Nature of Deduction")
                  {
                      ApplicationArea = All;
                  }*/
                field("Orient MRP"; Rec."Orient MRP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                /*  field("TDS Amount"; "TDS Amount")
                  {
                      ApplicationArea = All;
                  }
                  field("TDS %"; "TDS %")
                  {
                      Editable = true;
                      ApplicationArea = All;
                  }*/
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShowShortcutDimCode(ShortcutDimCode);
                        // NoOnAfterValidate;
                    end;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                /*    field("Cross-Reference No."; Rec."Cross-Reference No.")
                   {
                       Visible = false;
                       ApplicationArea = All;

                       trigger OnLookup(var Text: Text): Boolean
                       begin
                           //    CrossReferenceNoLookUp;
                           InsertExtendedText(FALSE);
                       end;

                       trigger OnValidate()
                       begin
                           //CrossReferenceNoOnAfterValidate;
                           // CrossReferenceNoOnAfterValidat
                       end;
                   }
                 */
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /* field("Service Tax Group"; "Service Tax Group")
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
                 field("Capital Item"; "Capital Item")
                 {
                     ApplicationArea = All;
                 }*/
                field("Excise Amount Per Unit"; Rec."Excise Amount Per Unit")
                {
                    ApplicationArea = All;
                }
                /*field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                {
                    ApplicationArea = All;
                }*/
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*  field("Form Code"; "Form Code")
                  {
                      ApplicationArea = All;
                  }
                  field("Form No."; "Form No.")
                  {
                      ApplicationArea = All;
                  }*/
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
                field(Nonstock; Rec.Nonstock)
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
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
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
                field(Quantity; Rec.Quantity)
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                /* field("Excise Loading on Inventory"; "Excise Loading on Inventory")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Non ITC Claimable Usage %"; "Non ITC Claimable Usage %")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("BCD Amount"; "BCD Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("CIF Amount"; "CIF Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    ApplicationArea = All;
                }
                /* field("Work Tax Base Amount"; "Work Tax Base Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Amount Loaded on Inventory"; "Amount Loaded on Inventory")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Input Tax Credit Amount"; "Input Tax Credit Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("VAT able Purchase Tax Amount"; "VAT able Purchase Tax Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
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
                /* field("BED Amount"; "BED Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("AED(GSI) Amount"; "AED(GSI) Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("AED(TTA) Amount"; "AED(TTA) Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("SED Amount"; "SED Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("SAED Amount"; "SAED Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("CESS Amount"; "CESS Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("NCCD Amount"; "NCCD Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Excise Refund"; "Excise Refund")
                 {
                     ApplicationArea = All;
                 }
                 field("eCess Amount"; "eCess Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("SHE Cess Amount"; "SHE Cess Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("ADET Amount"; "ADET Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("ADE Amount"; "ADE Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("ADC VAT Amount"; "ADC VAT Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Custom eCess Amount"; "Custom eCess Amount")
                 {
                     ApplicationArea = All;
                 }
                 field("Custom SHECess Amount"; "Custom SHECess Amount")
                 {
                     ApplicationArea = All;
                 }*/
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
                        //  ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
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
                        UpdateForm(FALSE);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
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
                field("Prod. Order No."; Rec."Prod. Order No.")
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
                field("Insurance No."; Rec."Insurance No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /* field("Reason Code";rec. "Reason Code")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
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
                /*field("CWIP G/L Type"; "CWIP G/L Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }*/
            }
            group(ItemPanel)
            {
                /*Caption = 'Item Information';
                 field(Control122; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcAvailability(Rec)))
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field(Control123; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field(Control124; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Purchase Line &Discounts")
            {
                Caption = 'Purchase Line &Discounts';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowLineDisc;
                    CurrPage.UPDATE;
                end;
            }
            action("Purcha&se Prices")
            {
                Caption = 'Purcha&se Prices';
                Image = SalesPrices;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowPrices;
                    CurrPage.UPDATE;
                end;
            }
            action("Availa&bility")
            {
                Caption = 'Availa&bility';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ItemAvailability(0);
                    CurrPage.UPDATE(TRUE);
                end;
            }
            action("Ite&m Card")
            {
                Caption = 'Ite&m Card';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //   PurchInfoPaneMgt.LookupItem(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

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


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;


    procedure GetReceipt()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Receipt", Rec);
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); Code blocked for upgrade
    end;


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;


    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END ELSE
            EXIT(TRUE);
    end;


    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;


    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;


    /*  procedure ShowStrDetailsForm()
      var
          StrOrderLineDetails: Record 13795;
          StrOrderLineDetailsForm: Page 16306;
      begin
          StrOrderLineDetails.RESET;
          StrOrderLineDetails.SETCURRENTKEY("Document Type","Document No.",Type);
          StrOrderLineDetails.SETRANGE("Document Type","Document Type");
          StrOrderLineDetails.SETRANGE("Document No.","Document No.");
          StrOrderLineDetails.SETRANGE(Type,StrOrderLineDetails.Type::Purchase);
          StrOrderLineDetails.SETRANGE("Item No.","No.");
          StrOrderLineDetails.SETRANGE("Line No.","Line No.");
          StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
          StrOrderLineDetailsForm.RUNMODAL;
      end;*/ // 15578


    procedure ShowExcisePostingSetup()
    begin
        //  GetExcisePostingSetup;
    end;
    /*procedure ShowDetailedTaxEntryBuffer()
     var
         DetailedTaxEntryBuffer: Record 16480;
     begin
         DetailedTaxEntryBuffer.RESET;
         DetailedTaxEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
         DetailedTaxEntryBuffer.SETRANGE("Transaction Type", DetailedTaxEntryBuffer."Transaction Type"::Purchase);
         DetailedTaxEntryBuffer.SETRANGE("Document Type", "Document Type");
         DetailedTaxEntryBuffer.SETRANGE("Document No.", "Document No.");
         DetailedTaxEntryBuffer.SETRANGE("Line No.", "Line No.");
         PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax", DetailedTaxEntryBuffer);
     end;
     */

    procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

}


