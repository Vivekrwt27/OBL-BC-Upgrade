pageextension 50455 pageextension50455 extends "Purchase Order Subform"
{
    layout
    {
        addafter("Act Applicable")
        {
            /*  field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
             {
                 ApplicationArea = all;
             } */
        }
        modify("Line Discount Amount")
        {
            Editable = "Reason CodeEditable";
        }
        modify("Prepayment %")
        {
            Editable = "Prepayment %Editable";
        }
        modify("Line Discount %")
        {
            Editable = "Line Discount %Editable";
        }

        modify(ShortcutDimCode3)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
            end;

        }
        modify(ShortcutDimCode4)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
            end;
        }
        modify(ShortcutDimCode5)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
            end;
        }
        modify(ShortcutDimCode6)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
            end;
        }
        modify(ShortcutDimCode7)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
            end;
        }
        modify(ShortcutDimCode8)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
            end;
        }
        moveafter(Description; "Description 2")
        modify("Description 2")
        {
            Visible = true;
        }


        addafter(Quantity)
        {


            field("Accepted Quantity"; Rec."Accepted Quantity")
            {
                ApplicationArea = All;
            }
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = all;
            }
            field("Capex No."; Rec."Capex No.")
            {
                ApplicationArea = all;
            }
            field("Shortage Quantity"; Rec."Shortage Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Rejected Quantity"; Rec."Rejected Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = all;
            }


            field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
            {
            }
            field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
            {
            }
            field("State Code"; rec."State Code")
            {
                Editable = "State CodeEditable";
            }
            field("Quantity (Base)"; rec."Quantity (Base)")
            {
                Editable = false;
            }
            field("Morbi Inventory(SQM)"; MorbiInventory)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Morbi Inventory(CRT)"; MorbiInventoryCRT)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
            {
                Editable = false;
            }

            field("Ref. Rate"; rec."Ref. Rate")
            {
            }
            field("Possible Cenvat"; rec."Possible Cenvat")
            {
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
            field("Currency Code"; rec."Currency Code")
            {
            }
            field("Challan Quantity"; rec."Challan Quantity")
            {

                trigger OnValidate()
                begin
                    //Vipul 04.02.2006 Change Request Add Start
                    rec.VALIDATE("Qty. to Receive", 0);
                    rec.VALIDATE("Qty. to Invoice", 0);
                    //Vipul 04.02.2006 Change Request Add Stop
                    rec.VALIDATE("Actual Quantity", rec."Challan Quantity");
                    rec.VALIDATE("Accepted Quantity", rec."Challan Quantity");
                end;
            }
            field("Actual Quantity"; rec."Actual Quantity")
            {

                trigger OnValidate()
                begin
                    //Vipul 04.02.2006 Change Request Add Start
                    rec.VALIDATE("Qty. to Receive", rec."Challan Quantity");
                    //VALIDATE("Qty. to Invoice","Actual Quantity");
                    //Vipul 04.02.2006 Change Request Add Stop
                end;
            }






        }

    }
    actions
    {
        addafter("Sales &Order")
        {
            action(Orders)
            {
                Caption = 'Orders';
                Image = Document;
                RunObject = Page 56;
                RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                RunPageView = SORTING("Document Type", Type, "No.");
                ShortCutKey = 'Ctrl+O';
            }
        }
    }
    var
        NewIndentLine: Record "Indent Line";
        IndentLine: Record "Indent Line";
        "Direct Unit CostEditable": Boolean;
        "Unit of Measure CodeEditable": Boolean;
        "Capex No.Editable": Boolean;
        "Tax Area CodeEditable": Boolean;
        "Line No.Editable": Boolean;
        "Tax Group CodeEditable": Boolean;
        "Starting DateEditable": Boolean;
        "Qty. to Invoice (Base)Editable": Boolean;
        "Qty. to Receive (Base)Editable": Boolean;
        "Ending DateEditable": Boolean;
        QuantityEditable: Boolean;
        "Description 2Editable": Boolean;
        DescriptionEditable: Boolean;
        "CIF AmountEditable": Boolean;
        "Rejection Reason CodeEditable": Boolean;
        "Shortage Reason CodeEditable": Boolean;
        "Location CodeEditable": Boolean;
        "Line AmountEditable": Boolean;
        "Requested Receipt DateEditable": Boolean;
        "Promised Receipt DateEditable": Boolean;
        "Planned Receipt DateEditable": Boolean;
        "Expected Receipt DateEditable": Boolean;
        "Order DateEditable": Boolean;
        TDSNatureofDeductionEditable: Boolean;
        WorkTaxNatureOfDeductionEditab: Boolean;
        "Line Discount %Editable": Boolean;
        "Line Discount AmountEditable": Boolean;
        "Cross-Reference No.Editable": Boolean;
        "IC Partner CodeEditable": Boolean;
        "IC Partner Ref. TypeEditable": Boolean;
        "CWIP G/L TypeEditable": Boolean;
        "IC Partner ReferenceEditable": Boolean;
        "Variant CodeEditable": Boolean;
        ServiceTaxRegistrationNoEditab: Boolean;
        "Service Tax GroupEditable": Boolean;
        VATProdPostingGroupEditable: Boolean;
        "Return Reason CodeEditable": Boolean;
        "Bin CodeEditable": Boolean;
        "Unit of MeasureEditable": Boolean;
        "Indirect Cost %Editable": Boolean;
        "NonITCClaimableUsage%Editable": Boolean;
        "Assessable ValueEditable": Boolean;
        "BCD AmountEditable": Boolean;
        "BED AmountEditable": Boolean;
        "AED(GSI) AmountEditable": Boolean;
        "SED AmountEditable": Boolean;
        "SAED AmountEditable": Boolean;
        "CESS AmountEditable": Boolean;
        "ADET AmountEditable": Boolean;
        "AED(TTA) AmountEditable": Boolean;
        "ADE AmountEditable ": Boolean;
        "NCCD AmountEditable": Boolean;
        "Custom eCess AmountEditable": Boolean;
        "Custom SHECess AmountEditable": Boolean;
        "eCess AmountEditable ": Boolean;
        "SHE Cess AmountEditable": Boolean;
        "ADC VAT AmountEditable ": Boolean;
        "Work Tax Base AmountEditable": Boolean;
        "Prepayment %Editable": Boolean;
        "Source Document TypeEditable": Boolean;
        "Source Document No.Editable": Boolean;
        "Job No.Editable": Boolean;
        "Job Task No.Editable": Boolean;
        "Job Line TypeEditable": Boolean;
        "Job Unit PriceEditable": Boolean;
        "Job Line AmountEditable": Boolean;
        JobLineDiscountAmountEditable: Boolean;
        "Job Line Discount %Editable": Boolean;
        "Lead Time CalculationEditable": Boolean;
        "Planning FlexibilityEditable": Boolean;
        "Prod. Order No.Editable": Boolean;
        "Prod. Order Line No.Editable": Boolean;
        "Operation No.Editable": Boolean;
        "Work Center No.Editable": Boolean;
        FinishedEditable: Boolean;
        InboundWhseHandlingTimeEditabl: Boolean;
        "Blanket Order No.Editable": Boolean;
        "Blanket Order Line No.Editable": Boolean;
        "Appl.-to Item EntryEditable": Boolean;
        "Reason CodeEditable": Boolean;
        ShortcutDimension1CodeEditable: Boolean;
        ShortcutDimension2CodeEditable: Boolean;

        MorbiInventory: Decimal;
        MorbiInventoryCRT: Decimal;
        MorbiReserveStock: Decimal;
        "Capex No. Editable": Boolean;
        "ADE AmountEditable": Boolean;
        TypeEditable: Boolean;



        "State CodeEditable": Boolean;
        "No.Editable": Boolean;
        GenBusPostingGroupEditable: Boolean;
        GenProdPostingGroupEditable: Boolean;

        "eCess AmountEditable": Boolean;

        "ADC VAT AmountEditable": Boolean;////


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetMorbiInventory;
    end;

    trigger OnDeleteRecord(): Boolean
    begin

        //MSBS.Rao Begin Dt. 05-06-12
        IF rec."Receipt No." = '' THEN
            rec.TESTFIELD("Qty. Rcd. Not Invoiced", 0);
        IF rec."Return Shipment No." = '' THEN
            rec.TESTFIELD("Return Qty. Shipped Not Invd.", 0);
        //MSBS.Rao End Dt. 05-06-12

        //MSAK.BEGIN 020315
        IF rec."Indent No." <> '' THEN BEGIN
            IndentLine.RESET;
            IndentLine.SETFILTER(IndentLine."Document No.", rec."Indent No.");
            IndentLine.SETRANGE(IndentLine."Line No.", rec."Indent Line No.");
            IF IndentLine.FIND('-') THEN BEGIN
                IndentLine.VALIDATE(IndentLine."Order No.", '');
                IndentLine.VALIDATE(IndentLine."Order Line No.", 0);
                IndentLine.VALIDATE(IndentLine."Order Date", 0D);
                IndentLine.VALIDATE(IndentLine.Status, IndentLine.Status::Authorized);
                //IndentLine.VALIDATE(Quantity,TotalNetQty("Indent No.","No.","Line No."));//MSBS.Rao 12-12-14
                IndentLine.MODIFY(TRUE);
            END;
            NewIndentLine.SETRANGE("Document No.", rec."Indent No.");
            NewIndentLine.SETFILTER("No.", '%1', rec."No.");
            NewIndentLine.SETFILTER("Line No.", '>%1', rec."Indent Line No.");
            IF NewIndentLine.FINDFIRST THEN BEGIN
                REPEAT
                    NewIndentLine.CALCFIELDS("PO Qty");
                    IF (NewIndentLine."PO Qty" = 0) THEN
                        NewIndentLine.DELETE;
                UNTIL NewIndentLine.NEXT = 0;
            END;
        END;
        //MSAK.BEGIN 020315


    end;

    trigger OnAfterGetCurrRecord()
    begin
        GetMorbiInventory;
    end;

    LOCAL procedure NoOnInputChange(VAR Text: Text[1024])
    begin
        //MSBS.Rao Begin Dt. 20-08-12
        CurrPage.UPDATE;
        //MSBS.Rao End Dt. 20-08-12
    end;

    trigger OnAfterGetRecord()
    var
        decIndQty: Decimal;
        rIndentLine: Record 50017;
        rPurchaseLine: Record 39;
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
        //Upgrade(+)
        //MSAK..
        IF rec."Quantity Received" <> 0 THEN
            "Direct Unit CostEditable" := FALSE
        ELSE
            "Direct Unit CostEditable" := TRUE;
        //MSBS.Rao Begin Dt. 20-08-12
        IF rec.Type = Type::Item THEN
            "Unit of Measure CodeEditable" := FALSE
        ELSE
            "Unit of Measure CodeEditable" := TRUE;
        //MSBS.Rao End Dt. 20-08-12
        SetEditable;
        //Upgrade(-)
        GetMorbiInventory;
    end;

    trigger OnOpenPage()
    begin

    end;



    procedure SetEditable()
    var
        RecPH: Record 38;
    begin
        IF RecPH.GET(rec."Document Type", rec."Document No.") THEN
            IF (RecPH.Status = RecPH.Status::Released) AND (RecPH.Status = RecPH.Status::"Short Close") THEN BEGIN
                TypeEditable := FALSE;
                "State CodeEditable" := FALSE;
                "No.Editable" := FALSE;
                GenBusPostingGroupEditable := FALSE;
                GenProdPostingGroupEditable := FALSE;
                "Capex No.Editable" := FALSE;
                "Tax Area CodeEditable" := FALSE;
                "Line No.Editable" := FALSE;
                "Tax Group CodeEditable" := FALSE;
                "Starting DateEditable" := FALSE;
                "Qty. to Invoice (Base)Editable" := FALSE;
                "Qty. to Receive (Base)Editable" := FALSE;
                "Ending DateEditable" := FALSE;
                QuantityEditable := FALSE;
                "Tax Area CodeEditable" := FALSE;
                "Description 2Editable" := FALSE;
                DescriptionEditable := FALSE;
                "CIF AmountEditable" := FALSE;
                "Rejection Reason CodeEditable" := FALSE;
                "Shortage Reason CodeEditable" := FALSE;
                "Location CodeEditable" := FALSE;
                "Unit of Measure CodeEditable" := FALSE;
                "Line AmountEditable" := FALSE;
                "Direct Unit CostEditable" := FALSE;
                "Requested Receipt DateEditable" := FALSE;
                "Promised Receipt DateEditable" := FALSE;
                "Planned Receipt DateEditable" := FALSE;
                "Expected Receipt DateEditable" := FALSE;
                "Order DateEditable" := FALSE;
                //CurrForm."Unit Price (LCY)".EDITABLE(FALSE);
                TDSNatureofDeductionEditable := FALSE;
                WorkTaxNatureOfDeductionEditab := FALSE;
                "Line Discount %Editable" := FALSE;
                "Capex No.Editable" := FALSE;
                "Line Discount AmountEditable" := FALSE;
                "Cross-Reference No.Editable" := FALSE;
                "IC Partner CodeEditable" := FALSE;
                "IC Partner Ref. TypeEditable" := FALSE;
                "CWIP G/L TypeEditable" := FALSE;
                "IC Partner ReferenceEditable" := FALSE;
                "Variant CodeEditable" := FALSE;
                ServiceTaxRegistrationNoEditab := FALSE;
                "Service Tax GroupEditable" := FALSE;
                VATProdPostingGroupEditable := FALSE;
                "Return Reason CodeEditable" := FALSE;
                "Bin CodeEditable" := FALSE;
                "Unit of MeasureEditable" := FALSE;
                "Indirect Cost %Editable" := FALSE;
                //CurrForm."Unit Cost (LCY)".EDITABLE(FALSE);
                "NonITCClaimableUsage%Editable" := FALSE;
                "Assessable ValueEditable" := FALSE;
                "BCD AmountEditable" := FALSE;
                "BED AmountEditable" := FALSE;
                "AED(GSI) AmountEditable" := FALSE;
                "SED AmountEditable" := FALSE;
                "SAED AmountEditable" := FALSE;
                "CESS AmountEditable" := FALSE;
                "ADET AmountEditable" := FALSE;
                "AED(TTA) AmountEditable" := FALSE;
                "ADE AmountEditable" := FALSE;
                "NCCD AmountEditable" := FALSE;
                "Custom eCess AmountEditable" := FALSE;
                "Custom SHECess AmountEditable" := FALSE;
                "eCess AmountEditable" := FALSE;
                "SHE Cess AmountEditable" := FALSE;
                "ADC VAT AmountEditable" := FALSE;
                "Work Tax Base AmountEditable" := FALSE;
                "Prepayment %Editable" := FALSE;
                "Source Document TypeEditable" := FALSE;
                "Source Document No.Editable" := FALSE;
                "Job No.Editable" := FALSE;
                "Job Task No.Editable" := FALSE;
                "Job Line TypeEditable" := FALSE;
                "Job Unit PriceEditable" := FALSE;
                "Job Line AmountEditable" := FALSE;
                JobLineDiscountAmountEditable := FALSE;
                "Job Line Discount %Editable" := FALSE;
                "Lead Time CalculationEditable" := FALSE;
                "Planning FlexibilityEditable" := FALSE;
                "Prod. Order No.Editable" := FALSE;
                "Prod. Order Line No.Editable" := FALSE;
                "Operation No.Editable" := FALSE;
                "Work Center No.Editable" := FALSE;
                FinishedEditable := FALSE;
                InboundWhseHandlingTimeEditabl := FALSE;
                "Blanket Order No.Editable" := FALSE;
                "Blanket Order Line No.Editable" := FALSE;
                "Appl.-to Item EntryEditable" := FALSE;
                "Reason CodeEditable" := FALSE;
                ShortcutDimension1CodeEditable := TRUE;
                ShortcutDimension2CodeEditable := TRUE;
            END ELSE BEGIN
                //CurrForm.EDITABLE(TRUE);
                TypeEditable := TRUE;
                "State CodeEditable" := TRUE;
                "No.Editable" := TRUE;
                GenBusPostingGroupEditable := TRUE;
                "Tax Area CodeEditable" := TRUE;
                "Line No.Editable" := TRUE;
                "Tax Group CodeEditable" := TRUE;
                "Starting DateEditable" := TRUE;
                "Qty. to Invoice (Base)Editable" := TRUE;
                "Qty. to Receive (Base)Editable" := TRUE;
                "Ending DateEditable" := TRUE;
                QuantityEditable := TRUE;
                "Tax Area CodeEditable" := TRUE;
                "Description 2Editable" := TRUE;
                DescriptionEditable := TRUE;
                "CIF AmountEditable" := TRUE;
                "Rejection Reason CodeEditable" := TRUE;
                "Shortage Reason CodeEditable" := TRUE;
                "Location CodeEditable" := TRUE;
                //CurrForm."Unit of Measure Code".EDITABLE(TRUE);
                "Line AmountEditable" := TRUE;
                "Direct Unit CostEditable" := TRUE;
                "Requested Receipt DateEditable" := TRUE;
                "Promised Receipt DateEditable" := TRUE;
                "Planned Receipt DateEditable" := TRUE;
                "Expected Receipt DateEditable" := TRUE;
                "Order DateEditable" := TRUE;
                //CurrForm."Unit Price (LCY)".EDITABLE(TRUE);
                TDSNatureofDeductionEditable := TRUE;
                WorkTaxNatureOfDeductionEditab := TRUE;
                "Line Discount %Editable" := TRUE;
                "Line Discount AmountEditable" := TRUE;
                "Cross-Reference No.Editable" := TRUE;
                "IC Partner CodeEditable" := TRUE;
                "IC Partner Ref. TypeEditable" := TRUE;
                "CWIP G/L TypeEditable" := TRUE;
                "IC Partner ReferenceEditable" := TRUE;
                "Variant CodeEditable" := TRUE;
                ServiceTaxRegistrationNoEditab := TRUE;
                "Service Tax GroupEditable" := TRUE;
                VATProdPostingGroupEditable := TRUE;
                "Return Reason CodeEditable" := TRUE;
                "Bin CodeEditable" := TRUE;
                "Unit of MeasureEditable" := TRUE;
                "Indirect Cost %Editable" := TRUE;
                //CurrForm."Unit Cost (LCY)".EDITABLE(TRUE);
                "NonITCClaimableUsage%Editable" := TRUE;
                "Assessable ValueEditable" := TRUE;
                "BCD AmountEditable" := TRUE;
                "BED AmountEditable" := TRUE;
                "AED(GSI) AmountEditable" := TRUE;
                "SED AmountEditable" := TRUE;
                "SAED AmountEditable" := TRUE;
                "CESS AmountEditable" := TRUE;
                "ADET AmountEditable" := TRUE;
                "AED(TTA) AmountEditable" := TRUE;
                "ADE AmountEditable" := TRUE;
                "NCCD AmountEditable" := TRUE;
                "Custom eCess AmountEditable" := TRUE;
                "Custom SHECess AmountEditable" := TRUE;
                "eCess AmountEditable" := TRUE;
                "SHE Cess AmountEditable" := TRUE;
                "ADC VAT AmountEditable" := TRUE;
                "Work Tax Base AmountEditable" := TRUE;
                "Prepayment %Editable" := TRUE;
                "Source Document TypeEditable" := TRUE;
                "Source Document No.Editable" := TRUE;
                "Job No.Editable" := TRUE;
                "Job Task No.Editable" := TRUE;
                "Job Line TypeEditable" := TRUE;
                "Job Unit PriceEditable" := TRUE;
                "Job Line AmountEditable" := TRUE;
                JobLineDiscountAmountEditable := TRUE;
                "Job Line Discount %Editable" := TRUE;
                "Lead Time CalculationEditable" := TRUE;
                "Planning FlexibilityEditable" := TRUE;
                "Prod. Order No.Editable" := TRUE;
                "Prod. Order Line No.Editable" := TRUE;
                "Operation No.Editable" := TRUE;
                "Work Center No.Editable" := TRUE;
                FinishedEditable := TRUE;
                InboundWhseHandlingTimeEditabl := TRUE;
                "Blanket Order No.Editable" := TRUE;
                "Blanket Order Line No.Editable" := TRUE;
                "Appl.-to Item EntryEditable" := TRUE;
                "Reason CodeEditable" := TRUE;
                ShortcutDimension1CodeEditable := TRUE;
                ShortcutDimension2CodeEditable := TRUE;
            END;
    end;

    procedure GetMorbiInventory()
    var

        Vendor: Record 23;
        SalesLine: Record 37;
        MorbiSalesLine: Page "Morbi Sales Line";

        MorbiReserveStock: Decimal;
    begin
        MorbiInventory := 0;
        IF rec."No." = '' THEN EXIT;
        IF rec."Buy-from Vendor No." = '' THEN EXIT;
        IF Vendor.GET(rec."Buy-from Vendor No.") THEN;
        IF Vendor."Morbi Location Code" = '' THEN EXIT;
        MorbiInventory := SalesLine.GetAssociateVendorInventory(rec."No.", Vendor."Morbi Location Code");
        MorbiInventoryCRT := 0;
        MorbiInventoryCRT := MorbiSalesLine.CalculateCarton(rec."No.", '', MorbiInventory);

        MorbiReserveStock := 0;
        MorbiReserveStock := SalesLine.GetAssociateVendorReserveInventory(rec."No.", Vendor."Morbi Location Code");

    end;






}
