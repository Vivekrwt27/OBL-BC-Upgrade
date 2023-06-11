page 50030 "Indent Line Subform"
{
    // TRI S.S.J DATE 220909

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = CardPart;
    SourceTable = "Indent Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //MSAK.BEGIN 240215
                        IF rec.Type = rec.Type::" " THEN
                            "No.Editable" := FALSE
                        ELSE
                            "No.Editable" := TRUE;
                        //MSAK.END 240215
                        TypeOnAfterValidate;
                        DescriptionOnActivate; //MSAK
                    end;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    Editable = "No.Editable";
                    StyleExpr = SetStyle;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        rec."Orginal Entry" := TRUE;//MSBS.Rao 12-12-14
                        IF (rec."No." <> '') AND (rec."Location Code" <> '') THEN BEGIN
                            ILE.RESET;
                            ILE.SETRANGE("Item No.", Rec."No.");
                            ILE.SETRANGE("Location Code", Rec."Location Code");
                            ILE.CALCSUMS("Remaining Quantity");
                            CurrentStock := ILE."Remaining Quantity"
                        END;
                        COMMIT;
                    end;
                }
                field("Parent Line No"; rec."Parent Line No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PendQty; PendQty)
                {
                    Caption = 'Pending Qty';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capex No."; rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                field("New Item"; rec."New Item")
                {
                    Editable = "New ItemEditable";
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    Editable = "Location CodeEditable";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."No." <> '') AND (Rec."Location Code" <> '') THEN BEGIN
                            ILE.RESET;
                            ILE.SETRANGE("Item No.", Rec."No.");
                            ILE.SETRANGE("Location Code", Rec."Location Code");
                            ILE.CALCSUMS("Remaining Quantity");
                            CurrentStock := ILE."Remaining Quantity"
                        END;
                    end;
                }
                field("Stock at your Location"; CurrentStock)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measurement"; rec."Unit of Measurement")
                {
                    Editable = "Unit of MeasurementEditable";
                    ApplicationArea = All;
                }
                field("PO Qty"; rec."PO Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(NOE; rec.NOE)
                {
                    ApplicationArea = All;
                }
                field(Deleted; rec.Deleted)
                {
                    ApplicationArea = All;
                }
                field("Short Closed"; rec."Short Closed")
                {
                    ApplicationArea = All;
                }
                field("Received Qty"; rec."Received Qty")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    //StyleExpr = SetStyle; //16225
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = "Description 2Editable";
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = "Item Category CodeEditable";
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = "Product Group CodeEditable";
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = QuantityEditable;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF rec."No." = '' THEN
                            IF rec.Quantity <> 0 THEN
                                ERROR('Please Select The Item First')
                    end;
                }
                field(Rate; rec.Rate)
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        IF item.GET(rec."No.") THEN;
                        /* IF (Type IN [1]) AND (NOT item."Inventory Value Zero") AND (Rate<>0) THEN BEGIN
                            ERROR('Change of Rate Not Allowed for This Item');
                           END;
                        */

                    end;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = "Due DateEditable";
                    ApplicationArea = All;
                }
                field("Last Order No."; Rec."Last Order No.")
                {
                    ApplicationArea = All;
                }
                field("Last Order Date"; Rec."Last Order Date")
                {
                    ApplicationArea = All;
                }
                field("Ref Code"; Rec."Ref Code")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Orders)
                    {
                        Caption = 'Orders';
                        Image = Document;
                        RunObject = Page "Purchase Orders";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        ApplicationArea = All;

                        RunPageView = SORTING("Document Type", Type, "No.");
                        ShortCutKey = 'Ctrl+O';
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /* 
        IF Rec.Status = Rec.Status::Authorized THEN
            PendQty := Rec.GetTotalPOQty(Rec."Document No.", Rec."No.", Rec.Quantity, Rec."Line No.", TRUE, Rec."Orginal Entry")//MSBS.Rao 181214
        ELSE
            PendQty := 0; */
        PendQty := Rec.Quantity - Rec."PO Qty";
        CLEAR(CurrentStock);
        IF (Rec."No." <> '') AND (Rec."Location Code" <> '') THEN BEGIN
            ILE.RESET;
            ILE.SETRANGE("Item No.", Rec."No.");
            ILE.SETRANGE("Location Code", Rec."Location Code");
            ILE.CALCSUMS("Remaining Quantity");
            CurrentStock := ILE."Remaining Quantity"
        END;
        //MSAK.BEGIN 240215
        IF Rec.Type = Rec.Type::" " THEN
            "No.Editable" := FALSE
        ELSE
            "No.Editable" := TRUE;
        //MSAK.END 240215
        OnAfterGetCurrRecord;
        TypeOnFormat;
        NoOnFormat;
        LocationCodeOnFormat;
        UnitofMeasurementOnFormat;
        DescriptionOnFormat;
        Description2OnFormat;
        ItemCategoryCodeOnFormat;
        ProductGroupCodeOnFormat;
        QuantityOnFormat;
        RateOnFormat;
        OrderLineNoOnFormat;
        VendorNoOnFormat;
        AmountOnFormat;
        DueDateOnFormat;
        CLEAR(SetStyle);
        IF Rec.Deleted THEN
            SetStyle := 'Attention';
    end;

    trigger OnInit()
    begin
        "Due DateEditable" := TRUE;
        RateEditable := TRUE;
        QuantityEditable := TRUE;
        "Location CodeEditable" := TRUE;
        "New ItemEditable" := TRUE;
        "Product Group CodeEditable" := TRUE;
        "Item Category CodeEditable" := TRUE;
        "Description 2Editable" := TRUE;
        DescriptionEditable := TRUE;
        "No.Editable" := TRUE;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //CurrForm.Type.UPDATEFORECOLOR(255);
        IF RecIndent.Status <> RecIndent.Status::Open THEN
            IF NOT CheckAuthorized THEN//MSBS.Rao 121114
                ERROR(MSError001); //MSBS.Rao 121114
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        OnActivateForm;
    end;

    var
        RecIndent: Record "Indent Header";
        MSError001: Label 'You are not Authorized to Modify the Indent Line';
        PendQty: Decimal;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        DescriptionEditable: Boolean;
        [InDataSet]
        "Unit of MeasurementEditable": Boolean;
        [InDataSet]
        "Description 2Editable": Boolean;
        [InDataSet]
        "Item Category CodeEditable": Boolean;
        [InDataSet]
        "Product Group CodeEditable": Boolean;
        [InDataSet]
        "New ItemEditable": Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        QuantityEditable: Boolean;
        [InDataSet]
        RateEditable: Boolean;
        [InDataSet]
        "Due DateEditable": Boolean;
        CurrentStock: Decimal;
        ILE: Record "Item Ledger Entry";
        SetStyle: Text[20];
        item: Record Item;

    procedure TrackControls(Checkmark: Boolean)
    begin
        IF RecIndent.GET(Rec."Document No.") THEN;
        //CurrForm.Type.EDITABLE(Checkmark);
        "No.Editable" := Checkmark;
        "New ItemEditable" := Checkmark;
        "Location CodeEditable" := Checkmark;
        "Unit of MeasurementEditable" := Checkmark;
        DescriptionEditable := Checkmark;
        "Description 2Editable" := Checkmark;
        "Item Category CodeEditable" := Checkmark;
        "Product Group CodeEditable" := Checkmark;

        //TRI DG Add Start
        //IF (LOWERCASE(USERID)=LOWERCASE(RecIndent."Authorization 1")) OR (LOWERCASE(USERID)=LOWERCASE(RecIndent."Authorization 3")) THEN
        IF RecIndent.Status <> RecIndent.Status::Authorized THEN//MSBS.Rao Dt. 18.04.13


            QuantityEditable := TRUE
        ELSE//TRI DG Add Start
            QuantityEditable := Checkmark;

        // IF item.GET("No.") THEN   //kbs
        //   IF item."Inventory Value Zero" <> TRUE THEN

        /*//Kulbhushan Sharma
          IF item.GET("No.") THEN BEGIN
          IF (Type IN [1]) AND (NOT item."Inventory Value Zero") AND (Rate<>0) THEN
             RateEditable := FALSE
          ELSE
              RateEditable := Checkmark;
              "Due DateEditable" := Checkmark;
          END;
        //CurrForm.UPDATECONTROLS;
        */


    end;

    procedure CheckAuthorized(): Boolean
    var
        RecIndentHeader: Record "Indent Header";
    begin
        RecIndentHeader.GET(Rec."Document No.");
        CASE RecIndentHeader.Status OF
            RecIndentHeader.Status::Authorization1:
                BEGIN
                    IF (UPPERCASE(USERID) = UPPERCASE(RecIndentHeader."Authorization 1")) THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
            RecIndentHeader.Status::Authorization2:
                BEGIN
                    IF (UPPERCASE(USERID) = UPPERCASE(RecIndentHeader."Authorization 2")) THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
            RecIndentHeader.Status::Authorization3:
                BEGIN
                    IF (UPPERCASE(USERID) = UPPERCASE(RecIndentHeader."Authorization 3")) THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
        END;
    end;

    local procedure TypeOnAfterValidate()
    begin
        //MSAK.BEGIN 240215
        IF Rec.Type = Rec.Type::" " THEN
            "No.Editable" := FALSE
        ELSE
            "No.Editable" := TRUE;
        //MSAK.END 240215
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        /*
        // TRI S.S.J DATE 220909  START
        IF "Document No."<>'' THEN BEGIN
        RecIndent.SETFILTER("No.","Document No.");
        IF RecIndent.FINDFIRST THEN BEGIN
         IF RecIndent.Status=Status::Authorized THEN
          CurrForm.EDITABLE(FALSE)
         ELSE
            CurrForm.EDITABLE(TRUE);
        END;
        END;
        // TRI S.S.J DATE 220909 END
        */
        //MSAK.BEGIN 240215
        IF Rec.Type = Rec.Type::" " THEN
            "No.Editable" := FALSE
        ELSE
            "No.Editable" := TRUE;
        //MSAK.END 240215

    end;

    local procedure TypeOnActivate()
    begin
        //MSAK.BEGIN 240215
        IF Rec.Type = Rec.Type::" " THEN
            "No.Editable" := FALSE
        ELSE
            "No.Editable" := TRUE;
        //MSAK.END 240215
    end;

    local procedure DescriptionOnActivate()
    begin
        IF Rec.Type = Rec.Type::Item THEN
            DescriptionEditable := FALSE;
        "Unit of MeasurementEditable" := FALSE;
    end;

    local procedure Description2OnActivate()
    begin
        //  IF Type = Type::Item THEN
        //     CurrForm."Description 2".EDITABLE(FALSE);

        //    IF USERID = 'BDRAPROD08' THEN
        //       "Description 2Editable" := TRUE;
    end;

    local procedure OnActivateForm()
    begin
        //MSAK.BEGIN 240215
        IF Rec.Type = Rec.Type::" " THEN
            "No.Editable" := FALSE
        ELSE
            "No.Editable" := TRUE;
        //MSAK.END 240215
    end;

    local procedure UnitofMeasurementOnBeforeInput()
    begin
        IF Rec.Type = Rec.Type::Item THEN
            "Unit of MeasurementEditable" := FALSE; //Kulbhushan
    end;

    local procedure DescriptionOnBeforeInput()
    begin
        //Vipul Tri1.0 Start
        IF Rec."No." <> '' THEN
            DescriptionEditable := TRUE
        ELSE
            DescriptionEditable := TRUE;
        //Vipul Tri1.0 End
    end;

    local procedure Description2OnBeforeInput()
    begin
        //Vipul Tri1.0 Start
        IF Rec."No." <> '' THEN
            "Description 2Editable" := TRUE
        ELSE
            "Description 2Editable" := TRUE;


        //Vipul Tri1.0 End
    end;

    local procedure NoOnInputChange(var Text: Text[1024])
    begin
        Rec."Orginal Entry" := TRUE;//MSBS.Rao 12-12-14
    end;

    local procedure TypeOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure NoOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
        //TRI S.R
        IF Rec.Status > Rec.Status::Open THEN
            TrackControls(FALSE)
        ELSE
            TrackControls(TRUE);
        //TRI S.R
    end;

    local procedure LocationCodeOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure UnitofMeasurementOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure DescriptionOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure Description2OnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure ItemCategoryCodeOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;


        IF (Rec.Type = Rec.Type::Item) OR (Rec.Type = Rec.Type::"Non Stock Item") THEN
            "Item Category CodeEditable" := FALSE;
        IF Rec.Type = Rec.Type::" " THEN BEGIN
            "Item Category CodeEditable" := TRUE;
        END;
    end;

    local procedure ProductGroupCodeOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;


        IF (Rec.Type = Rec.Type::Item) OR (Rec.Type = Rec.Type::"Non Stock Item") THEN
            "Product Group CodeEditable" := FALSE;
        IF Rec.Type = Rec.Type::" " THEN
            "Product Group CodeEditable" := TRUE;
    end;

    local procedure QuantityOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure RateOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure OrderLineNoOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure VendorNoOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure AmountOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;

    local procedure DueDateOnFormat()
    begin
        IF Rec.Deleted = TRUE THEN;
    end;
}

