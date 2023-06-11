page 50092 "Non Editable Order Subform"
{
    AutoSplitKey = true;
    Caption = 'Sales Order Subform';
    DelayedInsert = true;
    DeleteAllowed = false;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER("Order"));
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
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; Rec."Type Catogery Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Schemes; Rec.Schemes)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*   field("Cross-Reference No."; Rec."Cross-Reference No.")
                  {
                      Editable = false;
                      Visible = false;
                      ApplicationArea = All;
                  } */
                field("Buyer's Price"; Rec."Buyer's Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225 field N/F
                /* field("Excise Amount"; "Excise Amount")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("eCESS % on TDS/TCS"; "eCESS % on TDS/TCS")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
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
                //16225 field N/F
                /*field(MRP; MRP)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assessable Value"; "Assessable Value")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Form Code"; "Form Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Form No."; "Form No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }*/
                field(Nonstock; Rec.Nonstock)
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
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Special Order"; Rec."Special Order")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
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
                field("Bin Code"; Rec."Bin Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //UnitofMeasureCodeOnAfterValidate;
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Quantity in Sq. Mt."; Rec."Quantity in Sq. Mt.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
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
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Carton No. From"; Rec."Carton No. From")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Carton No. To"; Rec."Carton No. To")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pallet No. From"; Rec."Pallet No. From")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pallet No. To"; Rec."Pallet No. To")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Pallets"; Rec."Total Pallets")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Cartons"; Rec."Total Cartons")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(SalesPriceExist; Rec.PriceExists)
                {
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price (FCY)"; Rec."Unit Price (FCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount (FCY)"; Rec."Amount (FCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //mo tri1.0 customization no. start
                        IF Rec.Type = Rec.Type::Item THEN
                            ERROR('You cannot specify unit price of the item here');
                        //mo tri1.0 customization no. end
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Discount Per Unit"; Rec."Discount Per Unit")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(SalesLineDiscExists; Rec.LineDiscExists)
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
                //16225 field N/F
                /*field("Tax %"; "Tax %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tax Amount"; "Tax Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
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
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //TRI
                        Rec.CALCFIELDS("Total Reserved Quantity");
                        IF (Rec."Total Reserved Quantity") < Rec."Qty. to Ship" THEN
                            ERROR('Qty to ship %2 should not be more than Qty in Hand %1', Rec."Total Reserved Quantity"
                           , Rec."Qty. to Ship");
                        //TRI
                    end;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    BlankZero = true;
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225 field N/F
                /* field("Claim Deferred Excise"; "Claim Deferred Excise")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
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
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
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
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
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
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
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
        SalesHeader: Record "Sales Header";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit 378;
        ShortcutDimCode: array[8] of Code[20];
        "-NAVIN-": Integer;
        Check: Boolean;
        UserSetup: Record "User Setup";

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

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SETRANGE("No.", Rec."Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;

    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SETRANGE("No.", Rec."Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure ShowReservation()
    begin
        rec.FIND;
        Rec.ShowReservation;
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType);
    end;

    procedure ShowReservationEntries()
    begin
        //Rec.ShowReservationEntries(TRUE);
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowItemSub()
    begin
        Rec.ShowItemSub;
    end;


    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;


    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure ShowTracking()
    var
    // 16225 TrackingForm: Page 99000822;
    begin
        // 16225 TrackingForm.SetSalesLine(Rec);
        // 16225  TrackingForm.RUNMODAL;
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
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure "---NAVIN---"()
    begin
    end;

    procedure ShowStrDetailsForm()
    var
    //  StrOrderLineDetails: Record "13795";//16225 Table N/F
    // StrOrderLineDetailsForm: Page "16306";//16225 Table N/F
    begin
        //16225 Table N/F
        /* StrOrderLineDetails.RESET;
         StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
         StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
         StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
         StrOrderLineDetails.SETRANGE("Item No.", "No.");
         StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
         StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
         StrOrderLineDetailsForm.RUNMODAL;*/
    end;


    /*  procedure CustAttachments()
     var
         CustAttach: Record "Orient Attachments1";
     begin
         CustAttach.RESET;
         CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
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

    local procedure ReserveOnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;
}

