page 50101 "Import Order Subform"
{
    AutoSplitKey = true;
    Caption = 'Purchase Order Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                //16225 field N/F 
                /*    field("Tax %"; "Tax %")
                    {
                    }
                    field("Form Code"; "Form Code")
                    {
                    }*/
                field("Indent No."; rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Line No."; rec."Indent Line No.")
                {
                    ApplicationArea = All;
                }
                //16225 Field N./F 
                /*   field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                   {
                   }*/
                /*   field("Cross-Reference No."; Rec."Cross-Reference No.")
                  {
                      Visible = false;
                      ApplicationArea = All;

                      trigger OnLookup(var Text: Text): Boolean
                      begin
                          //16630  CrossReferenceNoLookUp;
                          InsertExtendedText(FALSE);
                      end;

                      trigger OnValidate()
                      begin
                          //CrossReferenceNoOnAfterValidate;
                          CrossReferenceNoOnAfterValidat
                      end;
                  }
   */
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
                //16225
                /*   field("CWIP G/L Type"; "CWIP G/L Type")
                   {
                       Visible = false;
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
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                //16225
                /*  field("Service Tax Registration No."; "Service Tax Registration No.")
                  {
                      Visible = false;
                  }
                  field("Service Tax Group"; "Service Tax Group")
                  {
                      Visible = false;
                  }*/
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
                field("Rejection Reason Code"; rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Shortage Reason Code"; rec."Shortage Reason Code")
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
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
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
                        Rec.VALIDATE("Qty. to Invoice", Rec."Actual Quantity");
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
                //16225 Field N/F Start
                /*   field("Non ITC Claimable Usage %"; "Non ITC Claimable Usage %")
                   {
                       Visible = false;
                   }
                   field("Amount Loaded on Inventory"; "Amount Loaded on Inventory")
                   {
                       Visible = false;
                   }
                   field("Excise Loading on Inventory"; "Excise Loading on Inventory")
                   {
                       Visible = false;
                   }
                   field("Input Tax Credit Amount"; "Input Tax Credit Amount")
                   {
                       Visible = false;
                   }
                   field("VAT able Purchase Tax Amount"; "VAT able Purchase Tax Amount")
                   {
                       Visible = false;
                   }
                   field("Tax Group Code"; Rec."Tax Group Code")
                   {
                       Visible = false;
                   }
                   field("Assessable Value"; "Assessable Value")
                   {
                       Visible = false;
                   }
                   field("CIF Amount"; "CIF Amount")
                   {
                       Visible = false;
                   }
                   field("BCD Amount"; "BCD Amount")
                   {
                       Visible = false;
                   }
                   field("BED Amount"; "BED Amount")
                   {
                       Visible = false;
                   }
                   field("AED(GSI) Amount"; "AED(GSI) Amount")
                   {
                       Visible = false;
                   }
                   field("SED Amount"; "SED Amount")
                   {
                       Visible = false;
                   }
                   field("SAED Amount"; "SAED Amount")
                   {
                       Visible = false;
                   }
                   field("CESS Amount"; "CESS Amount")
                   {
                       Visible = false;
                   }
                   field("ADET Amount"; "ADET Amount")
                   {
                       Visible = false;
                   }
                   field("AED(TTA) Amount"; "AED(TTA) Amount")
                   {
                       Visible = false;
                   }
                   field("ADE Amount"; "ADE Amount")
                   {
                       Visible = false;
                   }
                   field("NCCD Amount"; "NCCD Amount")
                   {
                       Visible = false;
                   }
                   field("Custom eCess Amount"; "Custom eCess Amount")
                   {
                       Visible = false;
                   }
                   field("Custom SHECess Amount"; "Custom SHECess Amount")
                   {
                       Visible = false;
                   }
                   field("eCess Amount"; "eCess Amount")
                   {
                       Visible = false;
                   }
                   field("SHE Cess Amount"; "SHE Cess Amount")
                   {
                       Visible = false;
                   }
                   field("ADC VAT Amount"; "ADC VAT Amount")
                   {
                       Visible = false;
                   }
                   field("Excise Refund"; "Excise Refund")
                   {
                       Visible = false;
                   }
                   field("Assessee Code"; "Assessee Code")
                   {
                       Visible = false;
                   }
                   field("TDS Nature of Deduction"; "TDS Nature of Deduction")
                   {
                   }*/ //16225 Field N/F end
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    ApplicationArea = All;
                }
                //16225 Field N/F
                /*  field("Work Tax Base Amount"; "Work Tax Base Amount")
                  {
                      Visible = false;
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
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
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
                //16225 field N/F
                /*  field("Reason Code"; "Reason Code")
                  {
                      Visible = false;
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
                field("GST Credit"; Rec."GST Credit")
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
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                //16225 field N/F
                /*    field("GST Base Amount"; "GST Base Amount")
                    {
                    }
                    field("GST %"; "GST %")
                    {
                    }
                    field("Total GST Amount"; "Total GST Amount")
                    {
                    }*/
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
                field(Control91; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcAvailability(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control92; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control93; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
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
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                            //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                            //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowStrDetailsForm;

                    end;
                }
                action("E&xcise Detail")
                {
                    Caption = 'E&xcise Detail';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowDetailedTaxEntryBuffer;

                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Sales&Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            OpenSalesOrderForm;

                        end;
                    }
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
                            //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50100. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowTracking;

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
            action("Ite&m Card")
            {
                Caption = 'Ite&m Card';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630 PurchInfoPaneMgt.LookupItem(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    /*  trigger OnDeleteRecord(): Boolean
      var
          ReservePurchLine: Codeunit "Purch. Line-Reserve";
      begin
          IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
              COMMIT;
              IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                  EXIT(FALSE);
              ReservePurchLine.DeleteLine(Rec);
          END;
      end;*/ // 16225

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
        IF Rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page 42;
    begin
        Rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
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
        Rec.FIND;
        Rec.ShowReservation;
    end;

    procedure ShowReservation()
    begin
        Rec.FIND;
        Rec.ShowReservation;
    end;

    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType);
        //code blocked for upgrade
        //not available
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType);
    end;

    procedure _ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page 99000822;
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowDimensions()
    begin
        ShowDimensions;
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
        SalesHeader: Record "Sales Header";
        SalesOrder: Page 42;
    begin
        Rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
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

    procedure _ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;

    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;

    procedure ShowStrDetailsForm()
    var
    //16225     StrOrderLineDetails: Record 13795;
    //16225    StrOrderLineDetailsForm: Page 16306;
    begin
        //16225 Table N/F start
        /*  StrOrderLineDetails.RESET;
          StrOrderLineDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
          StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
          StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
          StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
          StrOrderLineDetails.SETRANGE("Item No.", "No.");
          StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
          StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
          StrOrderLineDetailsForm.RUNMODAL;*/
    end;

    procedure ShowSubOrderDetailsForm()
    var
        PurchaseLine: Record "Purchase Line";
    //16225  SubOrderDetails: Page 16324;
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", Rec."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", Rec."Document No.");
        PurchaseLine.SETRANGE("No.", Rec."No.");
        PurchaseLine.SETRANGE("Line No.", Rec."Line No.");
        //16225  SubOrderDetails.SETTABLEVIEW(PurchaseLine);
        //16225   SubOrderDetails.RUNMODAL;
    end;

    procedure ShowExcisePostingSetup()
    begin
        //16225 Funcation N/F  Rec.GetExcisePostingSetup;
    end;

    procedure ShowDetailedTaxEntryBuffer()
    var
    //16225  DetailedTaxEntryBuffer: Record 16480;
    begin
        //16225 Table N/F Start
        /*   DetailedTaxEntryBuffer.RESET;
           DetailedTaxEntryBuffer.SETCURRENTKEY(Rec."Transaction Type", Rec."Document Type", Rec."Document No.", Rec."Line No.");
           DetailedTaxEntryBuffer.SETRANGE(Rec."Transaction Type", DetailedTaxEntryBuffer."Transaction Type"::Purchase);
           DetailedTaxEntryBuffer.SETRANGE(Rec."Document Type", Rec."Document Type");
           DetailedTaxEntryBuffer.SETRANGE(Rec."Document No.", Rec."Document No.");
           DetailedTaxEntryBuffer.SETRANGE(Rec."Line No.", Rec."Line No.");
           PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax", DetailedTaxEntryBuffer);*///16225 Table N/F End
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;
}

