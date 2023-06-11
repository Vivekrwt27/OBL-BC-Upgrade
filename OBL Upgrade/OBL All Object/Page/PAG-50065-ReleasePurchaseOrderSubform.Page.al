page 50065 "Release Purchase Order Subform"
{
    AutoSplitKey = true;
    Caption = 'Purchase Order Subform';
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    LinksAllowed = false;
    ModifyAllowed = true;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // rec.ShowShortcutDimCode(ShortcutDimCode);
                        // NoOnAfterValidate;
                    end;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("Possible Cenvat"; Rec."Possible Cenvat")
                {
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field("Tax %"; "Tax %")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
                field("Starting Date"; Rec."Starting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent Line No."; Rec."Indent Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*  field("CWIP G/L Type"; "CWIP G/L Type")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }*/
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*field("Service Tax Registration No."; Rec."Service Tax Registration No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Tax Group"; "Service Tax Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }*/
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortage Reason Code"; Rec."Shortage Reason Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
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
                        Rec.VALIDATE("Qty. to Receive", Rec."Challan Quantity");
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
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
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
                    Editable = false;
                    ApplicationArea = All;
                }
                /*  field("Non ITC Claimable Usage %"; "Non ITC Claimable Usage %")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Amount Loaded on Inventory"; "Amount Loaded on Inventory")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Excise Loading on Inventory"; "Excise Loading on Inventory")
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
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*  field("Assessable Value";rec. "Assessable Value")
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
                  field("ADET Amount"; "ADET Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("AED(TTA) Amount"; "AED(TTA) Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("ADE Amount"; "ADE Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("NCCD Amount"; Rec."NCCD Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Custom eCess Amount"; "Custom eCess Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Custom SHECess Amount"; "Custom SHECess Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("eCess Amount"; "eCess Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("SHE Cess Amount";rec. "SHE Cess Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("ADC VAT Amount"; "ADC VAT Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Excise Refund"; "Excise Refund")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Assessee Code"; "Assessee Code")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("TDS Nature of Deduction"; "TDS Nature of Deduction")
                  {
                      ApplicationArea = All;
                  }

                  field("Work Tax Base Amount"; "Work Tax Base Amount")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }*/
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
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
                    Editable = false;
                    Enabled = true;
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
                        // UpdateForm(FALSE);
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
                        //  UpdateForm(FALSE);
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
                /* field("Reason Code"; "Reason Code")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }*/
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
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowReservationEntries;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _OpenItemTrackingLines;

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowLineComments;

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ItemChargeAssgnt;

                    end;
                }
                action("Str&ucture Details")
                {
                    Caption = 'Str&ucture Details';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        // ShowStrDetailsForm;

                    end;
                }
                action("E&xcise Detail")
                {
                    Caption = 'E&xcise Detail';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowExcisePostingSetup;

                    end;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        //ShowDetailedTaxEntryBuffer;

                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                group("Dr&op Shipment")
                {

                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            OpenSpecOrderSalesOrderForm;

                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
                action("&Reserve")
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowReservation;

                    end;
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        // ShowTracking;

                    end;
                }
            }
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
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        IF (rec.Quantity <> 0) AND rec.ItemExists(rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;


    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
        PurchHeader: Record 38;
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        Text001: Label 'You can not use the Explode BOM function because a prepayment of the purchase order has been invoiced.';


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
        IF rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record 36;
        SalesOrder: Page "Sales Order";
    begin
        rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;


    procedure _InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
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


    procedure _ShowReservation()
    begin
        rec.FIND;
        Rec.ShowReservation;
    end;


    procedure ShowReservation()
    begin
        rec.FIND;
        Rec.ShowReservation;
    end;


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); //code blocked for upgrade //item availability is missing from standard
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); //code blocked for upgrade //item availability is missing from standard
    end;


    procedure _ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;


    /*procedure ShowTracking()
    var
        TrackingForm : pa;
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;*/


    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record 36;
        SalesOrder: Page "Sales Order";
    begin
        rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
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
        PurchHeader.GET(rec."Document Type", rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        PurchHeader.GET(rec."Document Type", rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;


    procedure _ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;


    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;


    /* procedure ShowStrDetailsForm()
     var
         StrOrderLineDetails: Record 3795;
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
     end;*/


    procedure ShowSubOrderDetailsForm()
    var
        PurchaseLine: Record 39;
    // SubOrderDetails: Page 16324;
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", rec."Document No.");
        PurchaseLine.SETRANGE("No.", rec."No.");
        PurchaseLine.SETRANGE("Line No.", rec."Line No.");
        // SubOrderDetails.SETTABLEVIEW(PurchaseLine);
        // SubOrderDetails.RUNMODAL;
    end;


    procedure ShowExcisePostingSetup()
    begin
        // GetExcisePostingSetup;
    end;


    /* procedure ShowDetailedTaxEntryBuffer()
     var
         DetailedTaxEntryBuffer: Record 16480;
     begin
         DetailedTaxEntryBuffer.RESET;
         DetailedTaxEntryBuffer.SETCURRENTKEY("Transaction Type","Document Type","Document No.","Line No.");
         DetailedTaxEntryBuffer.SETRANGE("Transaction Type",DetailedTaxEntryBuffer."Transaction Type"::Purchase);
         DetailedTaxEntryBuffer.SETRANGE("Document Type","Document Type");
         DetailedTaxEntryBuffer.SETRANGE("Document No.","Document No.");
         DetailedTaxEntryBuffer.SETRANGE("Line No.","Line No.");
         PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax",DetailedTaxEntryBuffer);
     end;*/

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (rec.Type = Type::"Charge (Item)") AND (rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;
}

