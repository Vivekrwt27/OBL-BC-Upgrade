page 50146 "Sales Invoice Subform-IC"
{
    AutoSplitKey = true;
    Caption = 'Sales Invoice Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    OptionCaption = ' ,,Item';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShowShortcutDimCode(ShortcutDimCode);
                        // Supplementary := TRUE;   //TRI DG
                        NoOnAfterValidate;
                    end;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Schemes; Rec.Schemes)
                {
                    ApplicationArea = All;
                }
                /*   field("Cross-Reference No."; Rec."Cross-Reference No.")
                  {
                      Visible = false;
                      ApplicationArea = All;

                      trigger OnLookup(var Text: Text): Boolean
                      begin
                          //CrossReferenceNoLookUp;
                          InsertExtendedText(FALSE);
                      end;

                      trigger OnValidate()
                      begin
                          //CrossReferenceNoOnAfterValidate;
                          CrossReferenceNoOnAfterValidat
                      end;
                  } */
                /* field("Direct Debit To PLA / RG"; Rec."Direct Debit To PLA / RG")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                /* field("Claim Deferred Excise"; Rec."Claim Deferred Excise")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
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
                /* field("Service Tax Registration No."; Rec."Service Tax Registration No.")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
                field(Description; Rec.Description)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                /* field("MRP Price"; Rec."MRP Price")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field(MRP; Rec.MRP)
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Abatement %"; Rec."Abatement %")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("PIT Structure"; Rec."PIT Structure")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
                field("Price Inclusive of Tax"; Rec."Price Inclusive of Tax")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    Visible = false;
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
                field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //UnitofMeasureCodeOnAfterValidate;
                        UnitofMeasureCodeOnAfterValida
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PriceExists; Rec.PriceExists)
                {
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Price Inclusive of Tax", FALSE);
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Price Inclusive of Tax", FALSE);
                    end;
                }
                field(LineDiscExists; Rec.LineDiscExists)
                {
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
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
                /* field("Excise Amount"; Rec."Excise Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("CIF Amount"; "CIF Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("BCD Amount"; "BCD Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Assessable Value"; "Assessable Value")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("BED Amount"; "BED Amount")
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
                 field("ADC VAT Amount"; "ADC VAT Amount")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field(Supplementary; Supplementary)
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Source Document Type"; "Source Document Type")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Source Document No."; "Source Document No.")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
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
                        Rec.ShowItemChargeAssgnt;
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
                field("Job Contract Entry No."; Rec."Job Contract Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Type Code"; Rec."Work Type Code")
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
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*field("Process Carried Out"; "Process Carried Out")
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
                }*/
                field("Return Receipt Line No."; Rec."Return Receipt Line No.")
                {
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
            group(ItemPanel)
            {
                Caption = 'Item Information';
                Visible = ItemPanelVisible;
                field(Test001; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcAvailability(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control94; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfSubstitutions(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control96; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfSalesPrices(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control98; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfSalesLineDisc(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Visible = false;
                    action(Period)
                    {
                        Caption = 'Period';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.FORM.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.FORM.*/
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.FORM.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        _ShowLineComments;

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ItemChargeAssgnt;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        _OpenItemTrackingLines;

                    end;
                }
                action("Str&ucture Details")
                {
                    Caption = 'Str&ucture Details';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        // 15578ShowStrDetailsForm;

                    end;
                }
                action("Excise Detail")
                {
                    Caption = 'Excise Detail';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowExcisePostingSetup;

                    end;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        // 15578 ShowDetailedTaxEntryBuffer;

                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get &Price")
                {
                    Caption = 'Get &Price';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowPrices

                    end;
                }
                action("Get Li&ne Discount")
                {
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ShowLineDisc

                    end;
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
                action("Get &Shipment Lines")
                {
                    Caption = 'Get &Shipment Lines';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50145. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.FORM.*/
                        GetShipment;

                    end;
                }
            }
            action("Sales Line &Discounts")
            {
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowLineDisc;
                    CurrPage.UPDATE;
                end;
            }
            action("&Sales Prices")
            {
                Caption = '&Sales Prices';
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
            action("Substitutio&ns")
            {
                Caption = 'Substitutio&ns';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.ShowItemSub;
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
                    SalesInfoPaneMgt.LookupItem(Rec);
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
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReserveSalesLine.DeleteLine(Rec);
        END;
    end;

    trigger OnInit()
    begin
        ItemPanelVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        //  TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        [InDataSet]
        ItemPanelVisible: Boolean;


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure GetShipment()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Get Shipment", Rec);
    end;

    procedure _InsertExtendedText(Unconditionally: Boolean)
    begin
        /*   IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
               CurrPage.SAVERECORD;
               TransferExtendedText.InsertSalesExtText(Rec);
           END;
           IF TransferExtendedText.MakeUpdate THEN
               UpdateForm(TRUE);*/
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        /*   IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
               CurrPage.SAVERECORD;
               TransferExtendedText.InsertSalesExtText(Rec);
           END;
           IF TransferExtendedText.MakeUpdate THEN
               UpdateForm(TRUE);*/
    end;

    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); //code blocked for upgradation
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType);   //code blocked for upgradation
    end;


    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;




    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;




    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
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


    procedure _ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;




    /* procedure ShowStrDetailsForm()
     var
         StrOrderLineDetails: Record 13795;
         StrOrderLineDetailsForm: Page 16306;
     begin
         StrOrderLineDetails.RESET;
         StrOrderLineDetails.SETCURRENTKEY(Rec."Document Type", Rec."Document No.", Rec.Type);
         StrOrderLineDetails.SETRANGE("Document Type", Rec."Document Type");
         StrOrderLineDetails.SETRANGE("Document No.", Rec."Document No.");
         StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
         StrOrderLineDetails.SETRANGE("Item No.", Rec."No.");
         StrOrderLineDetails.SETRANGE("Line No.", Rec."Line No.");
         StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
         StrOrderLineDetailsForm.RUNMODAL;
     end;*/ // 15578


    procedure ShowStrOrderDetailsPITForm()
    begin
        // ShowStrOrderDetailsPIT;
    end;


    procedure ShowExcisePostingSetup()
    begin
        //  GetExcisePostingSetup;
    end;


    /*  procedure ShowDetailedTaxEntryBuffer()
      var
          DetailedTaxEntryBuffer: Record 16480;
      begin
          DetailedTaxEntryBuffer.RESET;
          DetailedTaxEntryBuffer.SETCURRENTKEY(Rec."Transaction Type", Rec."Document Type", Rec."Document No.", Rec."Line No.");
          DetailedTaxEntryBuffer.SETRANGE(Rec."Transaction Type", DetailedTaxEntryBuffer."Transaction Type"::Sale);
          DetailedTaxEntryBuffer.SETRANGE(Rec."Document Type", Rec."Document Type");
          DetailedTaxEntryBuffer.SETRANGE(Rec."Document No.", Rec."Document No.");
          DetailedTaxEntryBuffer.SETRANGE(Rec."Line No.", Rec."Line No.");
          PAGE.RUNMODAL(PAGE::"Sale Detailed Tax", DetailedTaxEntryBuffer);
      end;*/ // 15578

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := rec.Type = rec.Type::Item;
    end;

    local procedure NoOnAfterValidate()
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

    local procedure QuantityOnAfterValidate()
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
        END;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
        END;
    end;
}

