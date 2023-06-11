page 50103 "Depot Sample Orod. Order Subfo"
{
    AutoSplitKey = true;
    Caption = 'Released Prod. Order Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = CardPart;
    SourceTable = "Prod. Order Line";
    SourceTableView = WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field("Item No."; Rec."Item No.")
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
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Item Availability by")
            {
                Caption = 'Item Availability by';
                action(Period)
                {
                    Caption = 'Period';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                        /*CurrPage.ProdOrderLines.FORM.*/
                        _ItemAvailability(0);

                    end;
                }
                action(Variant)
                {
                    Caption = 'Variant';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                        /*CurrPage.ProdOrderLines.FORM.*/
                        _ItemAvailability(1);

                    end;
                }
                action(Location)
                {
                    Caption = 'Location';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                        /*CurrPage.ProdOrderLines.FORM.*/
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
                    //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdOrderLines.FORM.*/
                    _ShowReservationEntries;

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
                    //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdOrderLines.FORM.*/
                    _ShowDimensions;

                end;
            }
            action("Ro&uting")
            {
                Caption = 'Ro&uting';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdOrderLines.FORM.*/
                    ShowRouting;

                end;
            }
            action(Components)
            {
                Caption = 'Components';
                Image = Components;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdOrderLines.FORM.*/
                    ShowComponents;

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
                    //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdOrderLines.FORM.*/
                    _OpenItemTrackingLines;

                end;
            }
            action("&Production Journal")
            {
                Caption = '&Production Journal';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdOrderLines.FORM.*/
                    ShowProductionJournal;

                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Reserve")
                {
                    Caption = '&Reserve';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                        /*CurrPage.ProdOrderLines.FORM.*/
                        _ShowReservation;

                    end;
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50102. Unsupported part was commented. Please check it.
                        /*CurrPage.ProdOrderLines.FORM.*/
                        ShowTracking;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DescriptionIndent := 0;
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        DescriptionOnFormat;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
    begin
        COMMIT;
        IF NOT ReserveProdOrderLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        DescriptionIndent: Integer;

    procedure ShowComponents()
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SETRANGE(Status, Rec.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderComp.SETRANGE("Prod. Order Line No.", Rec."Line No.");

        PAGE.RUN(PAGE::"Prod. Order Components", ProdOrderComp);
    end;

    procedure ShowRouting()
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRtngLine.SETRANGE(Status, Rec.Status);
        ProdOrderRtngLine.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderRtngLine.SETRANGE("Routing Reference No.", Rec."Routing Reference No.");
        ProdOrderRtngLine.SETRANGE("Routing No.", Rec."Routing No.");

        PAGE.RUN(PAGE::"Prod. Order Routing", ProdOrderRtngLine);
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page 99000822;
    begin
        TrackingForm.SetProdOrderLine(Rec);
        TrackingForm.RUNMODAL;
    end;

    procedure _ShowReservation()
    begin
        CurrPage.SAVERECORD;
        ShowReservation;
    end;

    procedure ShowReservation()
    begin
        CurrPage.SAVERECORD;
        ShowReservation;
    end;

    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        ItemAvailability(AvailabilityType);
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        ItemAvailability(AvailabilityType);
    end;

    procedure _ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowProductionJournal()
    var
        ProdOrder: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
    begin
        CurrPage.SAVERECORD;

        ProdOrder.GET(Rec.Status, Rec."Prod. Order No.");

        CLEAR(ProductionJrnlMgt);
        ProductionJrnlMgt.Handling(ProdOrder, Rec."Line No.");
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure DescriptionOnFormat()
    begin
        DescriptionIndent := Rec."Planning Level Code";
    end;
}

