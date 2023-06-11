page 50102 "Depot Sample Production Order"
{
    Caption = 'Released Production Order';
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released),
                            "Depot. Prod Order" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Lookup = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    OptionCaption = 'Item';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF xRec."Source Type" <> Rec."Source Type" THEN
                            Rec."Source No." := '';
                    end;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RecItem.RESET;
                        //RecItem.SETRANGE(RecItem."Item Category Code",'SAMPLE');
                        RecItem.SETFILTER(RecItem."Item Category Code", '%1|%2', 'SAMPLE', 'BREAKAGE');
                        IF RecItem.FIND('-') THEN
                            IF PAGE.RUNMODAL(0, RecItem) = ACTION::LookupOK THEN
                                Rec.VALIDATE("Source No.", RecItem."No.");
                    end;

                    trigger OnValidate()
                    begin
                        IF Rec."Source No." <> '' THEN BEGIN
                            IF RecItem.GET(Rec."Source No.") THEN
                                IF RecItem."Design Code" <> '1459' THEN;
                            ERROR(Text003);
                        END;
                    end;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            part(ProdOrderLines; "Depot Sample Orod. Order Subfo")
            {
                SubPageLink = "Prod. Order No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Schedule)
            {
                Caption = 'Schedule';
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension1CodeOnAfterValidate;
                        ShortcutDimension1CodeOnAfterV
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension2CodeOnAfterValidate;
                        ShortcutDimension2CodeOnAfterV
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        ShortCutKey = 'Ctrl+F7';
                        ApplicationArea = All;
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        RunObject = Page "Capacity Ledger Entries";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Source Type" = FILTER('83|5406|5407'),
                                      "Source Subtype" = FILTER('3|4|5'),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                        Visible = false;
                        ApplicationArea = All;
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Item Availability by UOM";
                    ApplicationArea = All;
                }
                separator(Action005)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status),
                                  "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                separator(Action004)
                {
                }
                action("Put-away/Pick Lines")
                {
                    Caption = 'Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity Lines";
                    RunPageLink = "Source Type" = FILTER('5406|5407'),
                                  "Source Subtype" = CONST(3),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.", "Unit of Measure Code", "Action Type", "Breakbulk No.", "Original Breakbulk");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Registered P&ick Lines")
                {
                    Caption = 'Registered P&ick Lines';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Act.-Lines";
                    RunPageLink = "Source Type" = CONST(5407),
                                  "Source Subtype" = CONST(3),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                separator(Control)
                {
                }
                action("Plannin&g")
                {
                    Caption = 'Plannin&g';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderPlanning: Page "Order Planning";
                    begin
                        OrderPlanning.SetProdOrder(Rec);
                        OrderPlanning.RUNMODAL;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Dimensions1)
                {
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Re&fresh Production Order")
                {
                    Caption = 'Re&fresh Production Order';
                    Ellipsis = true;
                    Image = Refresh;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Refresh Production Order", TRUE, TRUE, ProdOrder);
                    end;
                }
                action("Re&plan")
                {
                    Caption = 'Re&plan';
                    Ellipsis = true;
                    Image = Replan;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Replan Production Order", TRUE, TRUE, ProdOrder);
                    end;
                }
                separator(Control2)
                {
                }
                action("Change &Status")
                {
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    RunObject = Codeunit "Prod. Order Status Management";
                    ApplicationArea = All;
                }
                action("&Update Unit Cost")
                {
                    Caption = '&Update Unit Cost';
                    Ellipsis = true;
                    Image = UpdateUnitCost;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."No.");

                        REPORT.RUNMODAL(REPORT::"Update Unit Cost", TRUE, TRUE, ProdOrder);
                    end;
                }
                separator(Control3)
                {
                }
                action("Production Sc&hedule")
                {
                    Caption = 'Production Sc&hedule';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //ProdSchedMgt.ScheduleOrder(Rec,TRUE);
                    end;
                }
                separator(Control4)
                {
                    Caption = '';
                }
                action("Create I&nbound Whse. Request")
                {
                    Caption = 'Create I&nbound Whse. Request';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
                    begin
                        IF WhseOutputProdRelease.CheckWhseRqst(Rec) THEN
                            MESSAGE(Text002)
                        ELSE BEGIN
                            CLEAR(WhseOutputProdRelease);
                            IF WhseOutputProdRelease.Release(Rec) THEN
                                MESSAGE(Text000)
                            ELSE
                                MESSAGE(Text001);
                        END;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Create Whse. Pick")
                {
                    Caption = 'Create Whse. Pick';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdOrderCompLine: Record "Prod. Order Component";
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                        WhseSourceType: Option " ",Receipt,Shipment,"Internal Put-away","Internal Pick",Production;
                    begin
                        ProdOrderCompLine.RESET;
                        ProdOrderCompLine.SETRANGE(Status, Rec.Status);
                        ProdOrderCompLine.SETRANGE("Prod. Order No.", Rec."No.");
                        IF ProdOrderCompLine.FIND('-') THEN
                            REPEAT
                            /* ItemTrackingMgt.InitItemTrkgForTempWkshLine(
                              WhseSourceType::Production, ProdOrderCompLine."Prod. Order No.",
                              ProdOrderCompLine."Prod. Order Line No.", DATABASE::"Prod. Order Component",
                              ProdOrderCompLine.Status, ProdOrderCompLine."Prod. Order No.",
                              ProdOrderCompLine."Prod. Order Line No.", ProdOrderCompLine."Line No.");
                      */
                            UNTIL ProdOrderCompLine.NEXT = 0;
                        COMMIT;
                        //CreatePick(Rec);
                    end;
                }
                separator(Control11)
                {
                }
                action("C&opy Prod. Order Document")
                {
                    Caption = 'C&opy Prod. Order Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyProdOrderDoc.SetProdOrder(Rec);
                        CopyProdOrderDoc.RUNMODAL;
                        CLEAR(CopyProdOrderDoc);
                    end;
                }
            }
            group(Lines)
            {
                Caption = 'Lines';
                action("Reservation Entries")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        // 16630        CurrPage.ProdOrderLines.PAGE.ShowReservationEntries;
                    end;
                }
                action("Ro&uting")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        // 16630        CurrPage.ProdOrderLines.PAGE.ShowRouting;
                    end;
                }
                action(Components)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        // 16630        CurrPage.ProdOrderLines.PAGE.ShowComponents;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // 16630        CurrPage.ProdOrderLines.PAGE.OpenItemTrackingLines;
                    end;
                }
                action("&Production Journal")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        // 16630        CurrPage.ProdOrderLines.PAGE.ShowProductionJournal;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Job Card")
                {
                    Caption = 'Job Card';
                    Ellipsis = true;
                    Image = "Report";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 0);
                    end;
                }
                action("Mat. &Requisition")
                {
                    Caption = 'Mat. &Requisition';
                    Ellipsis = true;
                    Image = "Report";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 1);
                    end;
                }
                action("Shortage List")
                {
                    Caption = 'Shortage List';
                    Ellipsis = true;
                    Image = "Report";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 2);
                    end;
                }
                action("Gantt Chart")
                {
                    Caption = 'Gantt Chart';
                    Ellipsis = true;
                    Image = "Report";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ManuPrintReport.PrintProductionOrder(Rec, 3);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Depot. Prod Order" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //TRI S.R
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Production Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //TRI S.R
    end;

    var
        CopyProdOrderDoc: Report "Copy Production Order Document";
        ManuPrintReport: Codeunit "Manu. Print Report";
        Text000: Label 'Inbound Whse. Requests are created.';
        Text001: Label 'No Inbound Whse. Request is created.';
        Text002: Label 'Inbound Whse. Requests have already been created.';
        LocationFilterString: Text[250];
        UserLocation: Record "User Location";
        RecItem: Record Item;
        Text003: Label 'Only Sample Items are allowed.';

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        // 16630      CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        // 16630       CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    end;
}

