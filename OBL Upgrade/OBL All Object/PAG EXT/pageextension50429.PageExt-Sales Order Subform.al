pageextension 50429 pageextension50429 extends "Sales Order Subform"
{
    layout
    {
        //modify("TCS Nature of Collection")

        addafter("Bin Code")
        {
            field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
            {
                ApplicationArea = all;
            }
        }
        addbefore("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                RecSalesHeader: Record "Sales Header";
            begin
                IF Rec."Itemr Change Remarks" = '' THEN
                    Rec."Itemr Change Remarks" := 'ICR00001';
                IF reas1.GET(Rec."Itemr Change Remarks") THEN
                    Rec."Itemr Change Remarks" := reas1.Description;

                CurrPage.UPDATE(TRUE);
            end;

            trigger OnAfterAfterLookup(Selected: RecordRef)
            var
                RecSalesHeader: Record "Sales Header";
            begin
                //MSBS.Rao Start 261114
                //TEAM 14763 IF Rec.Type = Rec.Type::Item THEN
                //TEAM 14763 LookupLocationWiseInventory;
                //MSBS.Rao Stop 261114


                //TEAM 14763
                RecSalesHeader.Reset;
                RecSalesHeader.SetRange(RecSalesHeader."No.", Rec."Document No.");
                RecSalesHeader.SetFilter(RecSalesHeader."Location Code", '<>%1', '');
                if RecSalesHeader.FindFirst then begin
                    Rec."Location Code" := RecSalesHeader."Location Code";
                end;
                //TEAM 14763
            end;
        }

        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                //Upgrade(+)

                //LocationCodeOnAfterValidate;

                //MSNK START 130415
                UserSetup.GET(USERID);
                //RecLocation.RESET;
                //RecLocation.SETRANGE(Code,"Location Code");
                //RecLocation.SETRANGE("AD Applicable",TRUE);
                //IF RecLocation.FINDFIRST THEN BEGIN
                IF UserSetup."Allow Addtional Disc" THEN BEGIN
                    "Line Discount %Editable" := FALSE;
                    "Line Discount AmountEditable" := FALSE;
                    "Discount Per UnitEditable" := FALSE;
                    "Discount Per SQ.MTEditable" := FALSE;
                    D1Editable := TRUE;
                    D2Editable := TRUE;
                    D3Editable := TRUE;
                    //CurrForm.D4.EDITABLE(TRUE);
                END ELSE BEGIN
                    "Discount Per UnitEditable" := FALSE;
                    "Discount Per SQ.MTEditable" := FALSE;
                    "Line Discount %Editable" := FALSE;
                    "Line Discount AmountEditable" := FALSE;
                    D1Editable := FALSE;
                    D2Editable := FALSE;
                    D3Editable := FALSE;
                    //CurrForm.D4.EDITABLE(FALSE);
                END;

            end;
        }
        modify(ShortcutDimCode5)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }
        modify(ShortcutDimCode6)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }
        modify(ShortcutDimCode7)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }
        modify(ShortcutDimCode8)
        {
            trigger OnAfterValidate()
            begin
                ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }


        addafter("No.")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        moveafter(Description; Quantity)
        modify(Quantity)
        {
            BlankZero = true;
            Editable = QuantityEditable;

        }
        moveafter(Quantity; "Unit of Measure Code")
        addafter("Unit of Measure")
        {
            field("Item Clasification"; ItemClasification)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Discount Per SQ.MT"; Rec."Discount Per SQ.MT")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Discount Per Unit"; Rec."Discount Per Unit")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }
            field("Unit Price Excl. VAT/Sq.Mt"; Rec."Unit Price Excl. VAT/Sq.Mt")
            {
                ApplicationArea = all;
            }
        }
        modify("Unit of Measure Code")
        {
            Editable = "Unit of Measure CodeEditable";
        }
        addbefore("GST Place Of Supply")
        {
            field(D1; Rec.D1)
            {
                Caption = 'D1(BH)';
                Editable = false;
            }
        }
        addafter("GST Jurisdiction Type")
        {
            field(D2; Rec.D2)
            {
                Caption = 'D2 (ZM)';
                Editable = false;
            }
            field(D3; Rec.D3)
            {
                Caption = 'D3 (PSM)';
                Editable = false;

            }
            field(D4; Rec.D4)
            {
                Caption = 'D4 (PAC)';
                Editable = false;
                Visible = false;
            }
            field(S1; Rec.S1)
            {
                Caption = 'D5 (FRT)';
            }
            field(D6; Rec.D6)
            {
                Caption = '(ORC)';
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Morbi Remarks"; Rec."Itemr Change Remarks")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF reas1.GET(Rec."Itemr Change Remarks") THEN
                        Rec."Itemr Change Remarks" := reas1.Description;
                end;
            }
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
            field("Buyer's Price"; Rec."Buyer's Price")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Buyer's Price /Sq.Mt"; Rec."Buyer's Price /Sq.Mt")
            {
                Editable = false;
                StyleExpr = SetStyle;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF Rec."Buyer's Price /Sq.Mt" < 100 THEN
                        SetStyle := 'Unfavorable'
                    ELSE
                        SetStyle := 'Strong'
                end;
            }

            field("Price Inclusive of Tax"; Rec."Price Inclusive of Tax")
            {
                Editable = "Price Inclusive of TaxEditable";
                Visible = false;
                ApplicationArea = All;
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter("Buyer's Price /Sq.Mt"; "Line Discount %", "GST Place Of Supply", "GST Group Type", "GST Group Code"
        , "GST Jurisdiction Type", "Qty. to Ship", "Reserved Quantity", "Unit Price Incl. of Tax", "Tax Area Code", "Drop Shipment", "Tax Group Code")

        modify("Line Discount %")
        {
            BlankZero = true;
            Editable = "Line Discount %Editable";
        }

        modify("GST Group Code")
        {
            Editable = true;
        }
        addafter("GST Group Code")
        {
            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = all;
            }
        }
        modify("Qty. to Ship")
        {
            BlankZero = true;
            StyleExpr = 'kbSetStyle';
        }
        modify("Reserved Quantity")
        {
            BlankZero = true;
            // DecimalPlaces = '0 : 5';
        }
        modify("Unit Price Incl. of Tax")
        {
            Editable = UnitPriceInclofTaxEditable;
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Editable = "Tax Area CodeEditable";
        }
        modify("Drop Shipment")
        {
            Visible = false;
        }

        modify("Description 2")
        {
            Editable = false;
            StyleExpr = 'kbsetstyle';
        }
        modify("Unit Price")
        {
            BlankZero = true;
            Editable = false;
            trigger OnAfterValidate()
            begin
                Rec.TESTFIELD("Price Inclusive of Tax", FALSE);
            end;
        }
        addafter("Customer Price Group")
        {
            field("Charge Item"; Rec."Charge Item")
            {
                // ApplicationArea = all;
                trigger OnValidate()
                begin

                end;
            }
        }

        addbefore(Quantity)
        {
            field("Complete Description"; Rec."Complete Description")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Line No."; "Gross Weight", "Net Weight", "Deferral Code", Exempted)

        modify("Gross Weight")
        {
            Editable = false;
        }
        modify("Net Weight")
        {
            Editable = false;
        }
        modify(Exempted)
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
        addafter("Line No.")
        {
            field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
            {
                ApplicationArea = All;
            }
            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
            field("Approval Required"; Rec."Approval Required")
            {
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
                    //IF  ("AD Remarks" = '') AND (D7 >= 50) THEN

                    /*IF ("Approval Required") THEN
                         IF  "AD Remarks" = '' THEN
                        ERROR('Please select AD Reason for Higher Discount');
                        */

                    /*if ("AD Remarks" = '') and ("Approval Required" = True) then
                      ERROR('AD Reason Cannot Be Blank if the Approval is required');
                    
                    if ("AD Remarks" <> '') and (Remarks = '') then
                      ERROR('Pleasee Mention the Remarks');
                     */
                end;
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Vendor Name"; vname)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Trade Discount Amount"; Rec."Trade Discount Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Structure Discount Amount"; Rec."Structure Discount Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Line Discount Amount 1"; Rec."Line Discount Amount 1")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = all;
                Editable = true;
            }

            /* trigger OnValidate()//16225 Table Field N/F
                begin
             vname := '';
             Vendor.SETFILTER("Morbi Location Code", '%1&<>%2', "Vendor Code", '');
             IF Vendor.FINDFIRST THEN
                 vname := Vendor.Name;
         end;*/

        }


    }

    actions
    {
        addafter("Reservation Entries")
        {
            action("Reservation AGainst Other")
            {
                Caption = 'Reservation AGainst Other';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.ShowOtherReservation;
                end;
            }


            action("Wharehouse Inv System")
            {
                Caption = 'Wharehouse Inv System';
                ApplicationArea = all;
                RunObject = page 50255;
                RunPageLink = "item Code" = FIELD("No."),
                                                      Location = FIELD("Location Code");
            }
        }
    }

    var
        Check: Boolean;
        UserSetup: Record "User Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        RecItem: Record Item;
        ItemClasification: Code[20];
        RecLocation: Record Location;
        [InDataSet]
        "Line Discount %Editable": Boolean;
        [InDataSet]
        "Line Discount AmountEditable": Boolean;
        [InDataSet]
        "Discount Per UnitEditable": Boolean;
        [InDataSet]
        "Discount Per SQ.MTEditable": Boolean;
        [InDataSet]
        D1Editable: Boolean;
        [InDataSet]
        D2Editable: Boolean;
        [InDataSet]
        D3Editable: Boolean;
        S1Editable: Boolean;

        QuantityEditable: Boolean;
        [InDataSet]
        "Customer Price GroupEditable": Boolean;
        [InDataSet]
        "Assessable ValueEditable": Boolean;
        [InDataSet]
        COCOEditable: Boolean;
        [InDataSet]
        ReserveEditable: Boolean;
        [InDataSet]
        "Unit of Measure CodeEditable": Boolean;
        [InDataSet]
        "Variant CodeEditable": Boolean;
        [InDataSet]
        UnitPriceInclofTaxEditable: Boolean;
        [InDataSet]
        "MRP PriceEditable": Boolean;
        [InDataSet]
        "PIT StructureEditable": Boolean;
        [InDataSet]
        RemarksEditable: Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        TypeEditable: Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        "Sales TypeEditable": Boolean;
        [InDataSet]
        "Tax Area CodeEditable": Boolean;
        [InDataSet]
        "Tax Group CodeEditable": Boolean;
        [InDataSet]
        "Price Inclusive of TaxEditable": Boolean;
        [InDataSet]
        QuantityDiscountAmountVisible: Boolean;
        D4Editable: Boolean;
        SetStyle: Code[20];
        PreApproveDiscount: Decimal;
        reas: Record "Reason Code";
        SalesHeader: Record "Sales Header";
        manufstrategy: Option;
        reas1: Record "Reason Code";
        kbSetStyle: Code[20];
        HighValueProd: Boolean;
        SalesPrice: Record "Sales Price";
        Bansar: Decimal;
        Vendor: Record Vendor;
        vname: Text[100];
        kbSetStyle1: Code[20];
        HighValueProd1: Boolean;
        DocumentTotals: Codeunit "Document Totals";
        "Process Carried OutVisible": Boolean;


    trigger OnAfterGetRecord()
    begin
        //Amit
        IF Rec."Buyer's Price /Sq.Mt" < 100 THEN
            SetStyle := 'Unfavorable'
        ELSE
            SetStyle := 'Strong';

        IF Rec.Type = Rec.Type::Item THEN
            IF RecItem.GET(Rec."No.") THEN BEGIN
                CLEAR(kbSetStyle);
                IF RecItem.GET(Rec."No.") THEN;
                HighValueProd := ((RecItem."Manuf. Strategy" = RecItem."Manuf. Strategy"::"Non Retained ") OR (RecItem."Quality Code" = '2'));
                IF HighValueProd THEN
                    kbSetStyle := 'Unfavorable'
                ELSE
                    kbSetStyle := 'Normal';
                IF RecItem."No. 2" = '1' THEN
                    kbSetStyle := 'StrongAccent';
                ItemClasification := RecItem."Item Classification";
                manufstrategy := RecItem."Manuf. Strategy";
            END;


        /*
        IF Type = Type::Item THEN
                    IF RecItem.GET("No.") THEN BEGIN
                        CLEAR(kbSetStyle1);
                        IF RecItem.GET("No.") THEN;
                        HighValueProd1 := RecItem."No. 2" = '1';
                        IF HighValueProd1 THEN
                            kbSetStyle1 := 'StrongAccent'
                        ELSE
                            kbSetStyle1 := 'Normal';
                    END;
         */

        //MSNK START 130415
        UserSetup.GET(USERID);
        //RecLocation.RESET;
        //RecLocation.SETRANGE(Code,"Location Code");
        //RecLocation.SETRANGE("AD Applicable",TRUE);
        //IF RecLocation.FINDFIRST THEN BEGIN
        IF UserSetup."Allow Addtional Disc" THEN BEGIN
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            D1Editable := TRUE;
            D2Editable := TRUE;
            D3Editable := TRUE;
            //CurrForm.D4.EDITABLE(TRUE);
        END ELSE BEGIN
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            //CurrForm.D4.EDITABLE(FALSE);
        END;
        //MSNK STOP 130415

        //SHAKTI
        IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;
        //IF Status=Status::Released THEN BEGIN
        IF SalesHeader.Status <> SalesHeader.Status::Open THEN BEGIN //MsKs
            QuantityEditable := FALSE;
            "Customer Price GroupEditable" := FALSE;
            "Assessable ValueEditable" := FALSE;
            COCOEditable := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            QuantityEditable := FALSE;
            "Customer Price GroupEditable" := FALSE;
            ReserveEditable := FALSE;
            "Unit of Measure CodeEditable" := FALSE;
            "Variant CodeEditable" := FALSE;
            UnitPriceInclofTaxEditable := FALSE;
            "MRP PriceEditable" := FALSE;
            "PIT StructureEditable" := FALSE;
            RemarksEditable := TRUE;
            "No.Editable" := FALSE;
            TypeEditable := FALSE;
            "Location CodeEditable" := FALSE;
            "Sales TypeEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            D4Editable := FALSE;
            S1Editable := FALSE;
            "Tax Area CodeEditable" := FALSE;
            "Tax Group CodeEditable" := FALSE;
            "Variant CodeEditable" := FALSE;
            "Price Inclusive of TaxEditable" := FALSE;
            MakeQuantityEditable; //MSKS2304

        END ELSE BEGIN
            //MSKS1704  IF (UPPERCASE(USERID) = 'MA028') OR (UPPERCASE(USERID) = 'FA028') OR (UPPERCASE(USERID) = 'MA015')THEN
            //  CurrForm."Customer Price Group".EDITABLE(FALSE)
            //ELSE
            "Customer Price GroupEditable" := TRUE;

            //  CurrForm."Customer Price Group".EDITABLE(TRUE);
            "Assessable ValueEditable" := FALSE;
            COCOEditable := TRUE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            QuantityEditable := TRUE;
            //CurrForm."Customer Price Group".EDITABLE(TRUE);
            ReserveEditable := TRUE;
            "Unit of Measure CodeEditable" := TRUE;
            "Variant CodeEditable" := TRUE;
            UnitPriceInclofTaxEditable := TRUE;
            "MRP PriceEditable" := FALSE;

            "PIT StructureEditable" := TRUE;
            RemarksEditable := TRUE;
        END;
        OnAfterGetCurrRecord1;
        PreApproveDiscount := 0;
        PreApproveDiscount := Rec.GetAdditionDiscount(Rec."Sell-to Customer No.", Rec."No.");

        CLEAR(DocumentTotals);


        Bansar := 0;
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        SalesPrice.RESET;
        SalesPrice.SETFILTER(SalesPrice."Item No.", Rec."No.");
        SalesPrice.SETFILTER("Sales Type", '%1|%2', SalesPrice."Sales Type"::"Customer Price Group"
        , SalesPrice."Sales Type"::Customer);
        SalesPrice.SETFILTER(SalesPrice."Sales Code", '%1|%2', Rec."Customer Price Group", Rec."Sell-to Customer No.");
        SalesPrice.SETFILTER(SalesPrice."Starting Date", '..%1', SalesHeader."Order Date");
        SalesPrice.SETFILTER(SalesPrice."Ending Date", '%1|%2..', 0D, SalesHeader."Posting Date");
        SalesPrice.SETFILTER(SalesPrice."Unit of Measure Code", Rec."Unit of Measure Code");
        IF SalesPrice.FINDLAST THEN BEGIN
            //VALIDATE("MRP Price",ROUND(SalesPrice."MRP Price",1));
            //MRP := TRUE;
            //VALIDATE("Unit Price" , ROUND(SalesPrice."Unit Price",0.01));   //TRI DG 020810
            Bansar := (ROUND(SalesPrice."Nepal Price", 0.01));   //TRI DG 020810
                                                                 /*END ELSE BEGIN
                                                                   VALIDATE("Unit Price",0);
                                                                   MRP := FALSE;*/
        END;

        vname := '';
        Vendor.SETFILTER("Morbi Location Code", '%1&<>%2', Rec."Vendor Code", '');
        IF Vendor.FINDFIRST THEN
            vname := Vendor.Name;
    end;

    trigger OnOpenPage()
    begin
        //16225 Oninit//
        IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;
        //Upgrade(+)
        "Process Carried OutVisible" := TRUE;
        QuantityDiscountAmountVisible := TRUE;
        "Price Inclusive of TaxEditable" := TRUE;
        "Tax Group CodeEditable" := TRUE;
        "Sales TypeEditable" := TRUE;
        "Location CodeEditable" := TRUE;
        TypeEditable := TRUE;
        "No.Editable" := TRUE;
        RemarksEditable := TRUE;
        "PIT StructureEditable" := TRUE;
        "MRP PriceEditable" := TRUE;
        UnitPriceInclofTaxEditable := TRUE;
        "Variant CodeEditable" := TRUE;
        "Unit of Measure CodeEditable" := TRUE;
        COCOEditable := TRUE;
        "Customer Price GroupEditable" := TRUE;
        QuantityEditable := TRUE;
        D3Editable := TRUE;
        D2Editable := TRUE;
        D1Editable := TRUE;
        "Discount Per SQ.MTEditable" := TRUE;
        "Discount Per UnitEditable" := TRUE;
        IF SalesHeader.Status <> SalesHeader.Status::Open THEN
            MakeQuantityEditable; //MSKS2304
                                  //upgrade(-)

        //16225 On OpenPage//
        //upgrade(+)
        SalesSetup.GET;
        IF SalesSetup."QD Applicable" THEN BEGIN
            QuantityDiscountAmountVisible := TRUE;
            //CurrForm."Accrued Discount".VISIBLE(True);
        END
        ELSE BEGIN
            QuantityDiscountAmountVisible := FALSE;
            //CurrForm."Accrued Discount".VISIBLE(False);

        END;
        //upgrade(-)
        IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;
        UserSetup.GET(USERID);
        //RecLocation.RESET;
        //RecLocation.SETRANGE(Code,"Location Code");
        //RecLocation.SETRANGE("AD Applicable",TRUE);
        //IF RecLocation.FINDFIRST THEN BEGIN
        IF UserSetup."Allow Addtional Disc" THEN BEGIN
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            D1Editable := TRUE;
            D2Editable := TRUE;
            D3Editable := TRUE;
            D4Editable := TRUE;
            S1Editable := TRUE;
            //CurrForm.D4.EDITABLE(TRUE);
        END ELSE BEGIN
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            D4Editable := FALSE;
            S1Editable := FALSE;
            //CurrForm.D4.EDITABLE(FALSE);
        END;
        IF SalesHeader.Status <> SalesHeader.Status::Open THEN
            MakeQuantityEditable; //MSKS2304

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord1;
    end;


    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;

        SaveAndAutoAsmToOrder;

        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            IF (Rec."Outstanding Qty. (Base)" <> 0) AND (Rec."No." <> xRec."No.") THEN BEGIN
                Rec.AutoReserve;
                CurrPage.UPDATE(FALSE);
                //Upgrade (+)

                //MSNK START 130415
                UserSetup.GET(USERID);
                //RecLocation.RESET;
                //RecLocation.SETRANGE(Code,"Location Code");
                //RecLocation.SETRANGE("AD Applicable",TRUE);
                //IF RecLocation.FINDFIRST THEN BEGIN
                IF UserSetup."Allow Addtional Disc" THEN BEGIN
                    "Line Discount %Editable" := FALSE;
                    "Line Discount AmountEditable" := FALSE;
                    "Discount Per UnitEditable" := FALSE;
                    "Discount Per SQ.MTEditable" := FALSE;
                    D1Editable := TRUE;
                    D2Editable := TRUE;
                    D3Editable := TRUE;
                    //CurrForm.D4.EDITABLE(TRUE);
                END ELSE BEGIN
                    "Discount Per UnitEditable" := FALSE;
                    "Discount Per SQ.MTEditable" := FALSE;
                    "Line Discount %Editable" := FALSE;
                    "Line Discount AmountEditable" := FALSE;
                    D1Editable := FALSE;
                    D2Editable := FALSE;
                    D3Editable := FALSE;
                    //CurrForm.D4.EDITABLE(FALSE);
                END;
                //MSNK STOP 130415

                //Upgrade(-)
            END;
        END;
    end;


    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;

    procedure "--MSBS.Rao261114--"()
    begin
    end;

    procedure LookupLocationWiseInventory()
    var
        RecItem: Record Item;
        RecSalesHeader: Record "Sales Header";
        ItemList: Page "Item List";
    begin
        CLEAR(ItemList);
        IF RecSalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN
            IF NOT ((RecSalesHeader."Location Code" = 'SKD-WH-MFG') OR (RecSalesHeader."Location Code" = 'HSK-WH-MFG') OR
                  (RecSalesHeader."Location Code" = 'DRA-WH-MFG')) THEN
                ItemList.SetLocationFilter(RecSalesHeader."Location Code");
        IF RecItem.GET(Rec."No.") THEN;
        ItemList.SETTABLEVIEW(RecItem);
        ItemList.SETRECORD(RecItem);
        IF ItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ItemList.GETRECORD(RecItem);
            Rec.VALIDATE(Rec."No.", RecItem."No.");
        END;
    end;

    local procedure ReserveC50OnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure OnAfterGetCurrRecord1()
    var
        SalesHeader: Record "Sales Header";
    begin
        xRec := Rec;
        //MSNK START 130415
        UserSetup.GET(USERID);
        //RecLocation.RESET;
        //RecLocation.SETRANGE(Code,"Location Code");
        //RecLocation.SETRANGE("AD Applicable",TRUE);
        //IF RecLocation.FINDFIRST THEN BEGIN
        IF UserSetup."Allow Addtional Disc" THEN BEGIN
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            D1Editable := TRUE;
            D2Editable := TRUE;
            D3Editable := TRUE;
            //CurrForm.D4.EDITABLE(TRUE);
        END ELSE BEGIN
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            //CurrForm.D4.EDITABLE(FALSE);
        END;
        //MSNK STOP 130415


        //Kulbhushan
        SalesHeader.RESET;
        IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;
        IF SalesHeader.Status IN [SalesHeader.Status::Released, SalesHeader.Status::"Price Approved", SalesHeader.Status::"Pending Approval"] THEN BEGIN
            QuantityEditable := FALSE;
            IF SalesHeader.Status <> SalesHeader.Status::Open THEN
                MakeQuantityEditable; //MSKS2304

            "Customer Price GroupEditable" := FALSE;
            "Assessable ValueEditable" := FALSE;
            COCOEditable := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            "Customer Price GroupEditable" := FALSE;
            ReserveEditable := FALSE;
            "Unit of Measure CodeEditable" := FALSE;
            "Variant CodeEditable" := FALSE;
            UnitPriceInclofTaxEditable := FALSE;
            "MRP PriceEditable" := FALSE;
            "PIT StructureEditable" := FALSE;
            RemarksEditable := TRUE;
            "No.Editable" := FALSE;
            TypeEditable := FALSE;
            "Location CodeEditable" := FALSE;
            "Sales TypeEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            D4Editable := FALSE;
            S1Editable := FALSE;

            "Tax Area CodeEditable" := FALSE;
            "Tax Group CodeEditable" := FALSE;
            "Variant CodeEditable" := FALSE;
            "Price Inclusive of TaxEditable" := FALSE;

        END ELSE BEGIN
            QuantityEditable := TRUE;
        END;
        //Kulbhushan
    end;

    local procedure NoOnInputChange(var Text: Text[1024])
    begin
        //MSNK START 130415
        UserSetup.GET(USERID);
        //RecLocation.RESET;
        //RecLocation.SETRANGE(Code,"Location Code");
        //RecLocation.SETRANGE("AD Applicable",TRUE);
        //IF RecLocation.FINDFIRST THEN BEGIN
        IF UserSetup."Allow Addtional Disc" THEN BEGIN
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            D1Editable := TRUE;
            D2Editable := TRUE;
            D3Editable := TRUE;
            //CurrForm.D4.EDITABLE(TRUE);
        END ELSE BEGIN
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            //CurrForm.D4.EDITABLE(FALSE);
        END;
        //MSNK STOP 130415
    end;

    local procedure LocationCodeOnInputChange(var Text: Text[1024])
    begin
        //MSNK START 130415
        UserSetup.GET(USERID);
        //RecLocation.RESET;
        //RecLocation.SETRANGE(Code,"Location Code");
        //RecLocation.SETRANGE("AD Applicable",TRUE);
        //IF RecLocation.FINDFIRST THEN BEGIN
        IF UserSetup."Allow Addtional Disc" THEN BEGIN
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            D1Editable := TRUE;
            D2Editable := TRUE;
            D3Editable := TRUE;
            //CurrForm.D4.EDITABLE(TRUE);
        END ELSE BEGIN
            "Discount Per UnitEditable" := FALSE;
            "Discount Per SQ.MTEditable" := FALSE;
            "Line Discount %Editable" := FALSE;
            "Line Discount AmountEditable" := FALSE;
            D1Editable := FALSE;
            D2Editable := FALSE;
            D3Editable := FALSE;
            //CurrForm.D4.EDITABLE(FALSE);
        END;
        //MSNK STOP 130415
    end;

    procedure MakeEditable(): Boolean
    var
        SalesHEader: Record "Sales Header";
    begin
        //IF SalesHEader.GET("Document Type","Document No.") THEN BEGIN
        //  EXIT(SalesHEader.Status=SalesHEader.Status::Open);
        //END;

        QuantityEditable := FALSE;
        IF Rec.Status <> Rec.Status::Open THEN
            MakeQuantityEditable; //MSKS2304

        "Customer Price GroupEditable" := FALSE;
        "Assessable ValueEditable" := FALSE;
        COCOEditable := FALSE;
        "Discount Per UnitEditable" := FALSE;
        "Discount Per SQ.MTEditable" := FALSE;
        "Customer Price GroupEditable" := FALSE;
        ReserveEditable := FALSE;
        "Unit of Measure CodeEditable" := FALSE;
        "Variant CodeEditable" := FALSE;
        UnitPriceInclofTaxEditable := FALSE;
        "MRP PriceEditable" := FALSE;
        "PIT StructureEditable" := FALSE;
        RemarksEditable := TRUE;
        "No.Editable" := FALSE;
        TypeEditable := FALSE;
        "Location CodeEditable" := FALSE;
        "Sales TypeEditable" := FALSE;
        D1Editable := FALSE;
        D2Editable := FALSE;
        D3Editable := FALSE;
        D4Editable := FALSE;
        S1Editable := FALSE;

        "Tax Area CodeEditable" := FALSE;
        "Tax Group CodeEditable" := FALSE;
        "Variant CodeEditable" := FALSE;
        "Price Inclusive of TaxEditable" := FALSE;
    end;

    local procedure MakeQuantityEditable()
    var

    begin
        IF Rec.Status = Rec.Status::Released THEN
            EXIT;
        IF UPPERCASE(USERID) IN ['FA028', 'DE002', 'DE012', 'DE011', 'DE014', 'DE018', 'DE018', 'DE016'] THEN
            QuantityEditable := TRUE;
    end;
}

