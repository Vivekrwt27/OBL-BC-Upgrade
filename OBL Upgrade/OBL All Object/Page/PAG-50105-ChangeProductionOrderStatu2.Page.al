page 50105 "Change Production Order Statu2"
{
    Caption = 'Change Production Order Status';
    PageType = Card;
    SourceTable = "Production Order";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ProdOrderStatus; ProdOrderStatus)
                {
                    Caption = 'Status Filter';
                    Enabled = false;
                    OptionCaption = 'Simulated,Planned,Firm Planned,Released';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ProdOrderStatusOnAfterValidate;
                    end;
                }
                field(StartingDate; StartingDate)
                {
                    Caption = 'Must Start Before';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        StartingDateOnAfterValidate;
                    end;
                }
                field(EndingDate; EndingDate)
                {
                    Caption = 'Ends Before';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        EndingDateOnAfterValidate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("No."; Rec."No.")
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
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
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
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Branch Code';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Visible = false;
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        ShortCutKey = 'Ctrl+F7';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ItemLedgEntry: Record "Item Ledger Entry";
                        begin
                            IF Rec.Status <> Rec.Status::Released THEN
                                EXIT;

                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETCURRENTKEY("Order No.");
                            ItemLedgEntry.SETRANGE("Order No.", Rec."No.");
                            PAGE.RUNMODAL(0, ItemLedgEntry);
                        end;
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            CapLedgEntry: Record "Capacity Ledger Entry";
                        begin
                            IF Rec.Status <> Rec.Status::Released THEN
                                EXIT;

                            CapLedgEntry.RESET;
                            CapLedgEntry.SETCURRENTKEY("Prod. Order No.");
                            CapLedgEntry.SETRANGE("Prod. Order No.", Rec."No.");
                            PAGE.RUNMODAL(0, CapLedgEntry);
                        end;
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ValueEntry: Record "Value Entry";
                        begin
                            IF Rec.Status <> Rec.Status::Released THEN
                                EXIT;

                            ValueEntry.RESET;
                            ValueEntry.SETCURRENTKEY("Order No.");
                            ValueEntry.SETRANGE("Order No.", Rec."No.");
                            PAGE.RUNMODAL(0, ValueEntry);
                        end;
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
                separator(Control)
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
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Change &Status")
                {
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
                        Window: Dialog;
                        NewStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
                        NewPostingDate: Date;
                        NewUpdateUnitCost: Boolean;
                        NoOfRecords: Integer;
                        POCount: Integer;
                        LocalText000: Label 'Simulated,Planned,Firm Planned,Released,Finished';
                        ChangeStatusForm: Page "Change Status on Prod. Order";
                    begin
                        ChangeStatusForm.Set(Rec);

                        IF ChangeStatusForm.RUNMODAL <> ACTION::Yes THEN
                            EXIT;

                        ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);

                        NoOfRecords := Rec.COUNT;

                        Window.OPEN(
                          STRSUBSTNO(Text000, SELECTSTR(NewStatus + 1, LocalText000)) +
                          Text001);

                        POCount := 0;

                        IF Rec.FIND('-') THEN
                            REPEAT
                                POCount := POCount + 1;
                                Window.UPDATE(1, Rec."No.");
                                Window.UPDATE(2, ROUND(POCount / NoOfRecords * 10000, 1));
                                ProdOrderStatusMgt.ChangeProdOrderStatus(
                                  Rec, NewStatus, NewPostingDate, NewUpdateUnitCost);
                                COMMIT;
                            UNTIL Rec.NEXT = 0;
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
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ProdOrderStatus := ProdOrderStatus::Released;
        BuildForm;
    end;

    var
        Text000: Label 'Changing status to %1...\\';
        Text001: Label 'Prod. Order #1###### @2@@@@@@@@@@@@@';
        ProdOrderStatus: Option Simulated,Planned,"Firm Planned",Released;
        StartingDate: Date;
        EndingDate: Date;

    procedure BuildForm()
    begin
        Rec.SETRANGE(Status, ProdOrderStatus);

        IF StartingDate <> 0D THEN
            Rec.SETFILTER("Starting Date", '..%1', StartingDate)
        ELSE
            Rec.SETRANGE("Starting Date");

        IF EndingDate <> 0D THEN
            Rec.SETFILTER("Ending Date", '..%1', EndingDate)
        ELSE
            Rec.SETRANGE("Ending Date");

        CurrPage.UPDATE(FALSE);
    end;

    local procedure ProdOrderStatusOnAfterValidate()
    begin
        BuildForm;
    end;

    local procedure StartingDateOnAfterValidate()
    begin
        BuildForm;
    end;

    local procedure EndingDateOnAfterValidate()
    begin
        BuildForm;
    end;
}

