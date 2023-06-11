page 50095 "Purchase Order Subform depot"
{
    AutoSplitKey = true;
    Caption = 'Purchase Order Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
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
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225 feild N/F
                /*field("Excise Bus. Posting Group";"Excise Bus. Posting Group")
                {
                    Editable = false;
                }*/
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Excise Amount Per Unit"; Rec."Excise Amount Per Unit")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent Line No."; Rec."Indent Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
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
                //16225 field N/F
                /*field("Service Tax Registration No.";"Service Tax Registration No.")
                {
                    Editable = false;
                }*/
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                //16225 field N/F
                /* field("Service Tax Group";"Service Tax Group")
                 {
                     Editable = "Service Tax GroupEditable";
                     Visible = false;
                 }*/
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    Visible = true;
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
                    Editable = true;
                    ApplicationArea = All;
                }
                //16225 Field N/F
                /*field("Form Code";"Form Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Form No.";"Form No.")
                {
                    Editable = false;
                    Visible = false;
                }*/
                field("Bin Code"; Rec."Bin Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Challan Quantity"; Rec."Challan Quantity")
                {
                    Editable = true;
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
                    Editable = true;
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
                    Editable = true;
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
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                //16225 field N/F
                /*field("Tax %";"Tax %")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tax Amount";"Tax Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Excise Amount";"Excise Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Excise Prod. Posting Group";"Excise Prod. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Assessee Code";"Assessee Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("TDS Nature of Deduction";"TDS Nature of Deduction")
                {
                    Editable = false;
                    Visible = false;
                }
                field("TDS %";"TDS %")
                {
                    Editable = false;
                    Visible = false;
                }
                field("TDS Amount";"TDS Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Surcharge %";"Surcharge %")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Surcharge Amount";"Surcharge Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("TDS Amount Including Surcharge";"TDS Amount Including Surcharge")
                {
                    Editable = false;
                    Visible = false;
                }
                field("eCESS % on TDS";"eCESS % on TDS")
                {
                    Editable = false;
                    Visible = false;
                }
                field("eCESS on TDS Amount";"eCESS on TDS Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Total TDS Including SHE CESS";"Total TDS Including SHE CESS")
                {
                    Editable = false;
                    Visible = false;
                }*/
                field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                //16225 field N/F
                /*field("Work Tax Base Amount";"Work Tax Base Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Work Tax %";"Work Tax %")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Work Tax Amount";"Work Tax Amount")
                {
                    Editable = false;
                    Visible = false;
                }*/
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*//Tri vipul Delete Start 31.01.06 Change Request
                        
                        IF "Qty. to Receive" > "Accepted Quantity" THEN    //ravi Tri
                           ERROR('Qty. to Receive cannot be more than Accepted Quantity');  //ravi Tri
                        
                        *///Tri vipul Delete Stop 31.01.06 Change Request


                        //Tri vipul Add Start 31.01.06 Change Request

                        IF Rec."Qty. to Receive" > Rec."Actual Quantity" THEN
                            ERROR('Qty. to Receive cannot be more than Actual Quantity');

                        //Tri vipul Add Stop 31.01.06 Change Request

                    end;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    BlankZero = true;
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
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
                            //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
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
                            //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
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
                            //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowReservationEntries;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ItemChargeAssgnt;

                    end;
                }
                action("Structure Details")
                {
                    Caption = 'Structure Details';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowStrDetailsForm;  // NAVIN

                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Sales &Orderr")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            OpenSpecOrderSalesOrderForm;

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
                            //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.FORM.*/
                            OpenSpecOrderSalesOrderForm;

                        end;
                    }
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ApproveCalcInvDisc;

                    end;
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
                action("Get &Phase/Task/Step")
                {
                    Caption = 'Get &Phase/Task/Step';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        GetPhaseTaskStep;

                    end;
                }
                action("&Reserve")
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
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
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        ShowTracking;

                    end;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50094. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.FORM.*/
                        // CustAttachments;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit 378;
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        "Service Tax GroupEditable": Boolean;


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

    procedure GetPhaseTaskStep()
    begin
        //CODEUNIT.RUN(CODEUNIT::75,Rec);//16225 Codeunit N/F
    end;


    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page 42;
    begin
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
        //Rec.ItemAvailability(AvailabilityType); //Code blocked for upgrade// item availability not available
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); ////Code blocked for upgrade// item availability not available
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
        SalesHeader: Record "Sales Header";
        SalesOrder: Page 42;
    begin
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure "---NAVIN---"()
    begin
    end;

    procedure ShowStrDetailsForm()
    var
    // StrOrderLineDetails: Record "13795";//16225 Table N/F
    // StrOrderLineDetailsForm: Page "16306"; //16225 Table N/F
    begin
        //16225 Table N/F
        /*  StrOrderLineDetails.RESET;
          StrOrderLineDetails.SETRANGE(Type,StrOrderLineDetails.Type::Purchase);
          StrOrderLineDetails.SETRANGE("Document Type","Document Type");
          StrOrderLineDetails.SETRANGE("Document No.","Document No.");
          StrOrderLineDetails.SETRANGE("Item No.","No.");
          StrOrderLineDetails.SETRANGE("Line No.","Line No.");
          StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
          StrOrderLineDetailsForm.RUNMODAL;*/
    end;

    procedure "--SubCon--"()
    begin
    end;

    procedure ShowSubOrderDetailsForm()
    var
        PurchaseLine: Record "Purchase Line";
    //SubOrderDetails: Page 16324;//16225 page N/F
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", Rec."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", Rec."Document No.");
        PurchaseLine.SETRANGE("No.", Rec."No.");
        PurchaseLine.SETRANGE("Line No.", Rec."Line No.");
        //SubOrderDetails.SETTABLEVIEW(PurchaseLine);//16225 page N/F
        //SubOrderDetails.RUNMODAL;//16225 page N/F
    end;

    /*  procedure CustAttachments()
     var
         CustAttach: Record "Orient Attachments1";
     begin
         CustAttach.RESET;
         CustAttach.SETRANGE("Table ID", DATABASE::"Purchase Header");
         CustAttach.SETRANGE("Document No.", Rec."Document No.");
         CustAttach.SETRANGE("Document Type", Rec."Document Type");

         PAGE.RUN(PAGE::"Orient Attachments", CustAttach);
     end;
  */
    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure ServiceTaxGroupOnBeforeInput()
    begin
        IF Rec.Type = Rec.Type::"Charge (Item)" THEN
            "Service Tax GroupEditable" := TRUE
        ELSE
            "Service Tax GroupEditable" := FALSE;
    end;
}

