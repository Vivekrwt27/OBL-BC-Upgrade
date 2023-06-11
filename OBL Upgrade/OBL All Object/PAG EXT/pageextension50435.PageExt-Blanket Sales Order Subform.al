pageextension 50435 pageextension50435 extends "Blanket Sales Order Subform"
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                IF item1.GET(Rec."No.") THEN
                    tableautype := item1."Tableau Product Group";

                IF Rec.Type = Rec.Type::Item THEN BEGIN
                    hvpnon.SETFILTER("Item No.", '%1', Rec."No.");
                    hvpnon.SETFILTER("Starting Date", '%1..', 20180104D);//040118D
                    IF hvpnon.FINDLAST THEN
                        hvp := hvpnon."HVP/Discontinued";
                END;

            end;
        }


        addafter(LineDiscExists)
        {

            field(D2; Rec.D2)
            {
                Caption = 'D2 (ZM)';
                Editable = false;
                ApplicationArea = All;
            }
            field(D3; Rec.D3)
            {
                Caption = 'D3 (PSM)';
                Editable = false;
                ApplicationArea = All;
            }
            field(D4; Rec.D4)
            {
                Caption = 'D4 (PAC)';
                Editable = false;
                Enabled = true;
                Visible = false;
                ApplicationArea = All;
            }
            field(S1; Rec.S1)
            {
                Caption = 'D5 (FRT)';
                Editable = true;
                ApplicationArea = All;
            }
            field(D6; Rec.D6)
            {
                Caption = '(ORC)';
                ApplicationArea = All;
            }
            field("Requested Discount"; Rec.D7)
            {
                Caption = 'Requested Discount';
                Importance = Promoted;
                Style = Unfavorable;
                StyleExpr = TRUE;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF (Rec."AD Remarks" = '') AND (Rec.D7 >= 50) THEN
                        ERROR('Please select AD Reason for Higher Discount');


                    /*if ("AD Remarks" = '') and ("Approval Required" = True) then
                      ERROR('AD Reason Cannot Be Blank if the Approval is required');
                    
                    if ("AD Remarks" <> '') and (Remarks = '') then
                      ERROR('Pleasee Mention the Remarks');
                     */

                end;
            }
        }
        addafter("Shipment Date")
        {
            field("<AD Reason>"; Rec."AD Remarks")
            {
                Caption = 'AD Reason';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF reas.GET(Rec."AD Remarks") THEN
                        Rec."AD Remarks" := reas.Description;
                end;
            }
        }
        addafter("GST Group Code")
        {
            field("Outstanding Amount"; Rec."Outstanding Amount")
            {
                ApplicationArea = All;
            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
            }
        }
        addafter("GST Group Type")
        {
            field("Type Category Code"; tableautype)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Hiigh Value Product"; hvp)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter(Quantity; "Quantity Invoiced")
        addafter("ShortcutDimCode[8]")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
            {
                ApplicationArea = All;
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
            field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            {
                ApplicationArea = all;
            }
            field("Order Qty (CRT)"; Rec."Order Qty (CRT)")
            {
                ApplicationArea = all;
            }
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                Editable = "Line No.Editable";
                ApplicationArea = All;
            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
            {
                ApplicationArea = All;
            }
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field(control91; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcAvailability(Rec)))
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(control92; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfSubstitutions(Rec)))
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(control93; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfSalesPrices(Rec)))
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(control94; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfSalesLineDisc(Rec)))
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
        moveafter("Line No."; "Description 2", "Gross Weight", "Net Weight", "Tax Area Code", "Tax Group Code")
        modify("Description 2")
        {
            Editable = false;

        }
        modify("Gross Weight")
        {
            Editable = false;
        }
        modify("Net Weight")
        {
            Editable = false;
        }
        modify("Tax Area Code")
        {
            Editable = true;
        }
        modify("Tax Group Code")
        {
            Editable = true;
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action("Sales Line &Discounts")
            {
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225  ShowLineDisc;
                    CurrPage.UPDATE;
                end;
            }
            action("&Sales Prices")
            {
                Caption = '&Sales Prices';
                Image = SalesPrices;
                //16225 Promoted = true;
                //16225 PromotedCategory = Process;
                ApplicationArea = All;
                Visible = false; //16225 

                trigger OnAction()
                begin
                    //16225   ShowPrices;
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
                    // ShowItemSub;
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
                    //ItemAvailability(0);    //Code Commented for upgrade
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
                    SalesInfoPaneMgt.LookupItem(Rec);
                end;
            }
        }
    }

    var
        manufstrategy: Option;
        ItemClasification: Code[20];

    var
        HighValueProd: Boolean;

    var
        kbSetStyle: Code[20];

    var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        [InDataSet]
        "Customer Price GroupEditable": Boolean;
        [InDataSet]
        TypeEditable: Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Line No.Editable": Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        ExciseBusPostingGroupEditable: Boolean;
        [InDataSet]
        ExciseProdPostingGroupEditable: Boolean;
        [InDataSet]
        QuantityEditable: Boolean;
        [InDataSet]
        "Qty. to ShipEditable": Boolean;
        [InDataSet]
        "Tax Area CodeEditable": Boolean;
        [InDataSet]
        "Tax Group CodeEditable": Boolean;
        [InDataSet]
        "Quality CodeEditable": Boolean;
        [InDataSet]
        "Assessable ValueEditable": Boolean;
        [InDataSet]
        "Unit of Measure CodeEditable": Boolean;
        RecItem: Record Item;
        [InDataSet]
        "Unit of MeasureEditable": Boolean;
        [InDataSet]
        "Shipment DateEditable": Boolean;
        [InDataSet]
        ShortcutDimension1CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        UnitPriceInclofTaxEditable: Boolean;
        [InDataSet]
        "Excise Base AmountEditable": Boolean;
        [InDataSet]
        "Excise AmountEditable": Boolean;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        D1Editable: Boolean;
        [InDataSet]
        D2Editable: Boolean;
        [InDataSet]
        D3Editable: Boolean;
        S1Editable: Boolean;
        reas: Record "Reason Code";
        item1: Record Item;
        tableautype: Text[50];
        hvpnon: Record "HVP/Discontinued Items";
        hvp: Boolean;

    trigger OnAfterGetRecord()
    begin
        IF item1.GET(Rec."No.") THEN
            tableautype := item1."Tableau Product Group";

        IF Rec.Type = Rec.Type::Item THEN BEGIN
            hvpnon.SETFILTER("Item No.", '%1', Rec."No.");
            hvpnon.SETFILTER("Starting Date", '%1..', 20180104D);//040118D
            IF hvpnon.FINDLAST THEN
                hvp := hvpnon."HVP/Discontinued";
        END;

        IF Rec.Type = Rec.Type::Item THEN
            IF RecItem.GET(Rec."No.") THEN BEGIN
                CLEAR(kbSetStyle);
                IF RecItem.GET(Rec."No.") THEN;
                HighValueProd := ((RecItem."Manuf. Strategy" = RecItem."Manuf. Strategy"::"Non Retained ") OR (RecItem."Quality Code" = '2'));
                IF HighValueProd THEN
                    kbSetStyle := 'Unfavorable'
                ELSE
                    kbSetStyle := 'Normal';
                ItemClasification := RecItem."Item Classification";
                manufstrategy := RecItem."Manuf. Strategy";
            END;

    end;


    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;

    procedure "----------------tri--------"()
    begin
    end;

    procedure Refreshline()
    begin
        //TRI
        Rec.CALCFIELDS("Remaining Inventory", "Total Reserved Quantity", "Quantity in Blanket Order");
        Rec."Quantity in Hand SQM" := (Rec."Remaining Inventory" - (Rec."Total Reserved Quantity"));
        Rec."Quantity in Hand CRT" := ((Rec."Remaining Inventory" / Rec."Qty. per Unit of Measure") -
        (Rec."Total Reserved Quantity" / Rec."Qty. per Unit of Measure"));
        //TRI
    end;

    procedure Refreshcolour(salesline: Record "Sales Line")
    begin
        //TRI
        salesline.CALCFIELDS("Remaining Inventory", "Total Reserved Quantity", "Quantity in Blanket Order");
        salesline."Quantity in Hand SQM" := (salesline."Remaining Inventory" -
                                        (salesline."Total Reserved Quantity"));
        salesline."Quantity in Hand SQM" := ((salesline."Remaining Inventory" / salesline."Qty. per Unit of Measure") -
                                        (salesline."Total Reserved Quantity" / salesline."Qty. per Unit of Measure"));

        salesline.MODIFY;
        "No.Emphasize" := TRUE;
        //TRI
    end;

    procedure RecCurformUpdate()
    begin
        TypeEditable := FALSE;
        "No.Editable" := FALSE;
        "Line No.Editable" := FALSE;
        "Location CodeEditable" := FALSE;
        ExciseBusPostingGroupEditable := FALSE;
        ExciseProdPostingGroupEditable := FALSE;
        QuantityEditable := FALSE;
        "Qty. to ShipEditable" := TRUE;
        "Tax Area CodeEditable" := FALSE;
        "Tax Group CodeEditable" := FALSE;
        "Quality CodeEditable" := FALSE;
        "Assessable ValueEditable" := FALSE;
        "Unit of Measure CodeEditable" := FALSE;
        "Unit of MeasureEditable" := FALSE;
        //CurrForm."Line Amount".EDITABLE(FALSE);
        "Shipment DateEditable" := FALSE;
        ShortcutDimension1CodeEditable := FALSE;
        ShortcutDimension2CodeEditable := FALSE;
        UnitPriceInclofTaxEditable := FALSE;
        "Excise Base AmountEditable" := FALSE;
        "Excise AmountEditable" := FALSE;

        //CurrForm.UPDATECONTROLS;
    end;

    procedure recnoneditable()
    begin
        TypeEditable := TRUE;
        "No.Editable" := TRUE;
        "Line No.Editable" := TRUE;
        "Location CodeEditable" := TRUE;
        ExciseBusPostingGroupEditable := TRUE;
        ExciseProdPostingGroupEditable := TRUE;
        QuantityEditable := TRUE;
        "Qty. to ShipEditable" := TRUE;
        "Tax Area CodeEditable" := TRUE;
        "Tax Group CodeEditable" := TRUE;
        "Quality CodeEditable" := TRUE;
        "Assessable ValueEditable" := TRUE;
        "Unit of Measure CodeEditable" := TRUE;
        "Unit of MeasureEditable" := TRUE;
        //CurrForm."Line Amount".EDITABLE(TRUE);
        "Shipment DateEditable" := TRUE;
        ShortcutDimension1CodeEditable := TRUE;
        ShortcutDimension2CodeEditable := TRUE;
        UnitPriceInclofTaxEditable := TRUE;
        "Excise Base AmountEditable" := TRUE;
        //CurrForm."Excise Amount".EDITABLE(TRUE);
    end;

    local procedure OnAfterGetCurrRecord1()
    begin
        xRec := Rec;
        IF (UPPERCASE(USERID) <> 'MA028') AND (Rec.Status <> Rec.Status::Open) THEN
            "Customer Price GroupEditable" := FALSE
        ELSE
            "Customer Price GroupEditable" := TRUE;
        /*
        //MSAK.BEGIN
        IF Status=Status::Released THEN
        CurrForm.Type.EDITABLE(FALSE);
        CurrForm."No.".EDITABLE(FALSE);
        CurrForm."Customer Price Group".EDITABLE(FALSE);
        CurrForm.COCO.EDITABLE(FALSE);
        CurrForm."Qty. to Invoice (Base)".EDITABLE(FALSE);
        CurrForm."Quantity (Base)".EDITABLE(FALSE);
        CurrForm."Line No.".EDITABLE(FALSE);
        CurrForm."Location Code".EDITABLE(FALSE);
        CurrForm."Excise Bus. Posting Group".EDITABLE(FALSE);
        CurrForm."Excise Prod. Posting Group".EDITABLE(FALSE);
        CurrForm.Description.EDITABLE(FALSE);
        CurrForm."Description 2".EDITABLE(FALSE);
        CurrForm."Unit Price".EDITABLE(FALSE);
        CurrForm."Buyer's Price".EDITABLE(FALSE);
        CurrForm."MRP Price".EDITABLE(FALSE);
        CurrForm."Discount Per Unit".EDITABLE(FALSE);
        CurrForm."Line Discount %".EDITABLE(FALSE);
        CurrForm."Discount Per SQ.MT".EDITABLE(FALSE);
        CurrForm."Variant Code".EDITABLE(FALSE);
        CurrForm.Quantity.EDITABLE(FALSE);
        CurrForm."Quantity in Sq. Mt.".EDITABLE(FALSE);
        CurrForm."Quantity in Hand SQM".EDITABLE(FALSE);
        CurrForm."Quantity in Hand CRT".EDITABLE(FALSE);
        CurrForm."Qty. to Ship".EDITABLE(TRUE);
        CurrForm."Order Qty".EDITABLE(FALSE);
        CurrForm."Quantity Shipped".EDITABLE(FALSE);
        CurrForm."Quantity Invoiced".EDITABLE(FALSE);
        CurrForm."Gross Weight".EDITABLE(FALSE);
        CurrForm."Net Weight".EDITABLE(FALSE);
        CurrForm."Gross Weight (Ship)".EDITABLE(FALSE);
        CurrForm."Net Weight (Ship)".EDITABLE(FALSE);
        CurrForm."Order Qty (CRT)".EDITABLE(FALSE);
        CurrForm."Group Code".EDITABLE(FALSE);
        CurrForm."Tax Area Code".EDITABLE(FALSE);
        CurrForm."BED Amount".EDITABLE(FALSE);
        CurrForm."Excise Amount".EDITABLE(FALSE);
        CurrForm."Excise Base Amount".EDITABLE(FALSE);
        CurrForm."Tax Group Code".EDITABLE(FALSE);
         CurrForm."Quality Code".EDITABLE(FALSE);
         CurrForm."Assessable Value".EDITABLE(FALSE);
         CurrForm."Quantity in Sq. Mt.(Ship)".EDITABLE(FALSE);
         CurrForm."Total Reserved Quantity".EDITABLE(FALSE);
         CurrForm."Quantity in Blanket Order".EDITABLE(FALSE);
         CurrForm."Remaining Inventory".EDITABLE(FALSE);
         CurrForm.MRP.EDITABLE(FALSE);
         CurrForm."Abatement %".EDITABLE(FALSE);
         CurrForm."PIT Structure".EDITABLE(FALSE);
         CurrForm."Price Inclusive of Tax".EDITABLE(FALSE);
         CurrForm."Unit Price Incl. of Tax".EDITABLE(FALSE);
         CurrForm."Work Type Code".EDITABLE(FALSE);
         CurrForm."Unit of Measure Code".EDITABLE(FALSE);
         CurrForm."Unit of Measure".EDITABLE(FALSE);
         CurrForm."Unit Cost (LCY)".EDITABLE(FALSE);
         CurrForm."Line Amount".EDITABLE(FALSE);
         CurrForm.MRP.EDITABLE(FALSE);
         CurrForm."Remaining Inventory".EDITABLE(FALSE);
         CurrForm."Total Reserved Quantity".EDITABLE(FALSE);
         CurrForm."Quantity in Blanket Order".EDITABLE(FALSE);
         CurrForm."Allow Invoice Disc.".EDITABLE(FALSE);
         CurrForm."Line Discount Amount".EDITABLE(FALSE);
         CurrForm."Shipment Date".EDITABLE(FALSE);
         CurrForm."Shortcut Dimension 1 Code".EDITABLE(FALSE);
         CurrForm."Shortcut Dimension 2 Code".EDITABLE(FALSE);
         CurrForm.Remarks.EDITABLE(FALSE);
        //MSAK.END
         */

    end;
}

