page 50176 "Issue Slip Subform"
{
    AutoSplitKey = true;
    Caption = 'Transfer Order Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = CardPart;
    SourceTable = "Transfer Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Capex No."; rec."Capex No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Ship Date"; rec."Ship Date")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Qty. to Receive (Base)"; rec."Qty. to Receive (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shelf No."; rec."Shelf No.")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issue to Machine"; rec."Issue to Machine")
                {
                    ApplicationArea = All;
                }
                field(Inventory; rec.Inventory)
                {
                    Caption = 'Inventory';
                    ApplicationArea = All;
                }
                field("End Use Item"; rec."End Use Item")
                {
                    Caption = 'Auto Consumption';
                    Editable = false;
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
                field(Quantity; rec.Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CheckQty;//MSBS.Rao 290914
                    end;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF rec."End Use Item" THEN //MSBS.Rao 290914
                            rec.TESTFIELD(Rec."Qty. to Ship", rec.Quantity);//MSBS.Rao 290914
                    end;
                }
                field("Reserved Quantity Outbnd."; rec."Reserved Quantity Outbnd.")
                {
                    BlankZero = true;
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        TransShptLine: Record "Transfer Shipment Line";
                    begin
                        rec.TESTFIELD("Document No.");
                        rec.TESTFIELD("Item No.");
                        TransShptLine.SETCURRENTKEY("Transfer Order No.", "Item No.", "Shipment Date");
                        TransShptLine.SETRANGE("Transfer Order No.", rec."Document No.");
                        TransShptLine.SETRANGE("Item No.", rec."Item No.");
                        PAGE.RUNMODAL(0, TransShptLine);
                    end;
                }
                field("Quantity Received"; rec."Quantity Received")
                {
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
                        //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.FORM.*/
                        _ItemAvailability(0);

                    end;
                }
                action(Variant)
                {
                    Caption = 'Variant';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.FORM.*/
                        _ItemAvailability(1);

                    end;
                }
                action(Location)
                {
                    Caption = 'Location';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.FORM.*/
                        _ItemAvailability(2);

                    end;
                }
            }

            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                    /*CurrPage.TransferLines.FORM.*/
                    _ShowDimensions;

                end;
            }
            group("Item &Tracking Lines")
            {
                Caption = 'Item &Tracking Lines';
                action(Shipment)
                {
                    Caption = 'Shipment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.FORM.*/
                        _OpenItemTrackingLines(0);

                    end;
                }
                action(Receipt)
                {
                    Caption = 'Receipt';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.FORM.*/
                        _OpenItemTrackingLines(1);

                    end;
                }
            }
            action("Str&ucture Details")
            {
                Caption = 'Str&ucture Details';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                    /*CurrPage.TransferLines.FORM.*/
                    ShowStrDetailsForm;

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
                        //This functionality was copied from page #50175. Unsupported part was commented. Please check it.
                        /*CurrPage.TransferLines.FORM.*/
                        _ShowReservation;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //ShowShortcutDimCode(ShortcutDimCode);
        //MSBS.Rao Start-0713
        IF RecItem.GET(Rec."Item No.") THEN
            ItemClasification := RecItem."Item Classification";
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveTransferLine: Codeunit "Transfer Line-Reserve";
    begin
        COMMIT;
        IF NOT ReserveTransferLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveTransferLine.DeleteLine(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        // CustAttach: Record "Orient Attachments1";
        RecItem: Record Item;
        ItemClasification: Code[20];
        tl: Record "Transfer Line";
        ile: Record "Item Ledger Entry";
        ttqty: Decimal;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location)
    begin
        //Rec.ItemAvailability(AvailabilityType); //code blocked for upgrade
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location)
    begin
        //Rec.ItemAvailability(AvailabilityType);  //code blocked for upgrade
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


    procedure _OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
        OpenItemTrackingLines(Direction);
    end;


    procedure OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
        OpenItemTrackingLines(Direction);
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure ShowStrDetailsForm()
    var
    //16225 StrOrderLineDetails: Record 13795;
    //16225 StrOrderLineDetailsForm: Page 16306;
    begin
        /*  StrOrderLineDetails.RESET;
          StrOrderLineDetails.SETCURRENTKEY("Document Type","Document No.",Type);
          StrOrderLineDetails.SETRANGE("Document No.","Document No.");
          StrOrderLineDetails.SETRANGE(Type,StrOrderLineDetails.Type::Transfer);
          StrOrderLineDetails.SETRANGE("Item No.","Item No.");
          StrOrderLineDetails.SETRANGE("Line No.","Line No.");
          StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
          StrOrderLineDetailsForm.RUNMODAL;*/
    end;

    /*   procedure CustAttachments()
      begin
          CustAttach.RESET;
          CustAttach.SETRANGE("Table ID", DATABASE::"Transfer Header");
          CustAttach.SETRANGE("Document No.", Rec."Document No.");
          //CustAttach.SETRANGE("Document Type","Document Type");
          PAGE.RUN(PAGE::"Orient Attachments", CustAttach);
      end;
   */
    procedure GetShortageLine()
    var
        TransRcptLine: Record "Transfer Receipt Line";
        TransHeader: Record "Transfer Header";
        GetShortage: Page "Get Shortage Line";
    begin
        TransHeader.GET(Rec."Document No.");
        TransHeader.TESTFIELD(Status, TransHeader.Status::Open);

        TransRcptLine.SETCURRENTKEY("Transfer-to Code");
        TransRcptLine.FILTERGROUP(2);
        TransRcptLine.SETRANGE("Transfer-to Code", TransHeader."Transfer-from Code");
        TransRcptLine.SETFILTER("Short Quantity", '<>0');
        TransRcptLine.SETRANGE("Shoratge Quantity Shipped", FALSE);
        TransRcptLine.FILTERGROUP(0);
        GetShortage.SETTABLEVIEW(TransRcptLine);
        GetShortage.LOOKUPMODE := TRUE;
        GetShortage.SetTransHeader(TransHeader);
        GetShortage.RUNMODAL;
    end;

    procedure "--MSBS.Rao---"()
    begin
    end;

    procedure CheckQty()
    var
        MSErro001: Label 'Quanity Can''t be more than Inventory !!!';
    begin
        Rec.CALCFIELDS(Inventory);
        IF Rec."End Use Item" THEN;

        IF Rec.Inventory < Rec.Quantity THEN
            ERROR(MSErro001)

    end;

}

