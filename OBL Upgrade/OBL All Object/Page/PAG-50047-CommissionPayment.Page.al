page 50047 "Commission Payment"
{
    // Customization No. 26 Vipul

    PageType = Card;
    SourceTable = "Transporter Payment Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Charge Item"; Rec."Charge Item")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Commission Type"; Rec."Commission Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Total Commission");
                        //CurrPage.SubForm.PAGE.UPDATECONTROLS;    Not working in previous versions
                    end;
                }
                field("Calculation Value"; Rec."Calculation Value")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Total Commission");
                        //CurrPage.SubForm.PAGE.UPDATECONTROLS;
                    end;
                }
            }
            part(SubForm; "Commission Payment Subform")
            {
                SubPageLink = "Trans. Payment No." = FIELD("No.");
                ApplicationArea = All;
            }
            field("Total Commission"; Rec."Total Commission")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("S&uggest Lines")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SuggestLinesForPayment;
                    CurrPage.UPDATE;
                end;
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost Credit Memo")
                {
                    Caption = 'P&ost Credit Memo';
                    Ellipsis = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        noseriesmgt: Codeunit NoSeriesManagement;
                        salessetup: Record "Sales & Receivables Setup";
                        linenos: Integer;
                        Lno: Integer;
                        "SalesHeaderNo.": Code[20];
                        "SalesLineNo.": Integer;
                        ICAPQty: Decimal;
                        ICAPQtyTotal: Decimal;
                    begin
                        IF CONFIRM('Do you want to post Credit Memo for Commission Payment') THEN BEGIN
                            IF Rec."Sales Person Code" = '' THEN
                                ERROR(Text000, 'Sales Person Code');
                            IF Rec."From Date" = 0D THEN
                                ERROR(Text000, 'From Date');
                            IF Rec."To Date" = 0D THEN
                                ERROR(Text000, 'To Date');
                            IF Rec."Charge Item" = '' THEN
                                ERROR(Text000, 'Charge Item');

                            Rec.TESTFIELD("To Date");
                            Rec.TESTFIELD("Charge Item");

                            Rec.CALCFIELDS("Total Commission");
                            TransporterPaymentLine.RESET;
                            TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                            IF NOT TransporterPaymentLine.FIND('-') THEN
                                ERROR('There is nothing to Post');
                            IF TransporterPaymentLine.FIND('-') THEN
                                REPEAT
                                    IF TransporterPaymentLine."Calculated Commission" = 0 THEN
                                        ERROR('Commission must not be 0');
                                UNTIL TransporterPaymentLine.NEXT = 0;
                            SalesHeader.INIT;
                            salessetup.GET;
                            SalesHeader.VALIDATE(SalesHeader."Document Type", SalesHeader."Document Type"::"Credit Memo");
                            //  "SalesHeaderNo." := noseriesmgt.GetNextNo(salessetup."Credit Memo Nos.",WORKDATE,TRUE);
                            SalesHeader.VALIDATE(SalesHeader."No.");
                            Salesperson.RESET;
                            Salesperson.GET(Rec."Sales Person Code");
                            SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.", Salesperson."Customer No.");
                            SalesHeader.VALIDATE(SalesHeader."Document Date", WORKDATE);
                            SalesHeader.INSERT(TRUE);
                            "SalesHeaderNo." := SalesHeader."No.";

                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", SalesLine."Document Type"::"Credit Memo");
                            SalesLine.VALIDATE(SalesLine."Document No.", "SalesHeaderNo.");
                            linenos := linenos + 10000;
                            SalesLine.VALIDATE(SalesLine."Line No.", linenos);
                            SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::"Charge (Item)");
                            SalesLine.VALIDATE(SalesLine."No.", Rec."Charge Item");
                            SalesLine.VALIDATE(SalesLine.Quantity, 100);
                            SalesLine.VALIDATE(SalesLine."Unit Price", Rec."Total Commission" / 100);
                            SalesLine.INSERT;

                            TransporterPaymentLine.RESET;
                            TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                            IF TransporterPaymentLine.FIND('-') THEN
                                REPEAT
                                    ItemChargeAssignSale.INIT;
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Document Type", ItemChargeAssignSale."Document Type"::"Credit Memo");
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Document No.", "SalesHeaderNo.");
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Document Line No.", linenos);
                                    Lno := Lno + 10000;
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Line No.", Lno);
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Item Charge No.", Rec."Charge Item");
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Item No.", TransporterPaymentLine.Item);
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Applies-to Doc. No.", TransporterPaymentLine."MRN No.");
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Applies-to Doc. Line No.", TransporterPaymentLine."Line No.");
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Qty. to Assign",
                                                                  TransporterPaymentLine."Calculated Commission" * 100 / Rec."Total Commission");
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Unit Cost", Rec."Total Commission" / 100);
                                    ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Applies-to Doc. Type",
                                                                  ItemChargeAssignSale."Applies-to Doc. Type"::Shipment);
                                    ItemChargeAssignSale.INSERT(TRUE);

                                    SalesLine.VALIDATE(SalesLine."Unit Price", Rec."Total Commission" / 100);
                                    SalesLine.MODIFY(TRUE);
                                UNTIL TransporterPaymentLine.NEXT = 0;
                            Rec.DELETE;
                            TransporterPaymentLine.DELETEALL;
                            MESSAGE('Credit Memo %1 has been generated.', "SalesHeaderNo.");
                        END;

                        //Vipul Added Start
                        ItemChargeAssignSale.RESET;
                        ItemChargeAssignSale.SETFILTER(ItemChargeAssignSale."Document Type", '%1', ItemChargeAssignSale."Document Type"::"Credit Memo");
                        ItemChargeAssignSale.SETFILTER(ItemChargeAssignSale."Document No.", "SalesHeaderNo.");
                        ItemChargeAssignSale.SETFILTER(ItemChargeAssignSale."Document Line No.", '%1', linenos);
                        IF ItemChargeAssignSale.FIND('-') THEN
                            REPEAT
                                ICAPQty := ROUND(ItemChargeAssignSale."Qty. to Assign", 0.01, '=');
                                ICAPQtyTotal += ICAPQty;
                                ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Qty. to Assign", ICAPQty);
                                ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Unit Cost", Rec."Total Amount" / 100);
                                ItemChargeAssignSale.MODIFY;
                            UNTIL ItemChargeAssignSale.NEXT = 0;

                        IF ICAPQtyTotal <> 100 THEN
                            ICAPQty := ItemChargeAssignSale."Qty. to Assign";
                        ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Qty. to Assign", ICAPQty + (100 - ICAPQtyTotal));
                        ItemChargeAssignSale.VALIDATE(ItemChargeAssignSale."Unit Cost", Rec."Total Amount" / 100);
                        ItemChargeAssignSale.MODIFY;
                        //Vipul Added End
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        TransporterPaymentLine.RESET;
        TransporterPaymentLine.DELETEALL;
        Rec.DELETEALL;
    end;

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        TransporterPaymentLine: Record "Transporter Payment Line";
        ItemChargeAssignSale: Record "Item Charge Assignment (Sales)";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        SalesShpHeader: Record "Sales Shipment Header";
        SalesShpLine: Record "Sales Shipment Line";
        SalesLineArchive: Record "Sales Line Archive";
        LineNo: Integer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Salesperson: Record "Salesperson/Purchaser";
        SalesInvLine: Record "Sales Invoice Line";
        Text000: Label 'You must specify %1 in Commission Payment Header';
        Allow: Boolean;

    procedure SuggestLinesForPayment()
    var
        AmtBeforeExcise: Decimal;
        AmtAfterExcise: Integer;
        VE: Record "Value Entry";
    begin
        LineNo := 10000;
        TransporterPaymentLine.RESET;
        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
        IF TransporterPaymentLine.FIND('-') THEN
            TransporterPaymentLine.DELETEALL;

        SalesShpHeader.RESET;
        SalesShpHeader.SETFILTER(SalesShpHeader."Salesperson Code", Rec."Sales Person Code");
        SalesShpHeader.SETRANGE(SalesShpHeader."Posting Date", Rec."From Date", Rec."To Date");
        IF SalesShpHeader.FIND('-') THEN
            REPEAT
                SalesShpLine.RESET;
                SalesShpLine.SETFILTER(SalesShpLine."Document No.", SalesShpHeader."No.");
                IF SalesShpLine.FIND('-') THEN
                    REPEAT
                        //  IF SalesShpLine."Line Discount %" = 0 THEN BEGIN
                        Allow := TRUE;
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document No.", SalesShpLine."Document No.");
                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Item No.", SalesShpLine."No.");
                        IF ItemLedgerEntry.FIND('-') THEN
                            REPEAT
                                ValueEntry.RESET;
                                ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                IF ValueEntry.FIND('-') THEN
                                    REPEAT
                                        IF Rec."Charge Item" = ValueEntry."Item Charge No." THEN Allow := FALSE;
                                    UNTIL ValueEntry.NEXT = 0;
                            UNTIL ItemLedgerEntry.NEXT = 0;

                        IF Allow THEN BEGIN
                            TransporterPaymentLine.INIT;
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN No.", SalesShpHeader."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Line No.", SalesShpLine."Line No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN Date", SalesShpHeader."Posting Date");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Posting Date", WORKDATE);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Item, SalesShpLine."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Quantity, SalesShpLine.Quantity);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.UOM, SalesShpLine."Unit of Measure Code");
                            VE.RESET;
                            VE.SETFILTER(VE."Item Ledger Entry No.", '%1', SalesShpLine."Item Shpt. Entry No.");
                            IF VE.FIND('-') THEN BEGIN
                                SalesInvLine.RESET;
                                SalesInvLine.SETFILTER(SalesInvLine."Document No.", VE."Document No.");
                                IF SalesInvLine.FIND('-') THEN BEGIN
                                    TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Amount Before Excise", SalesInvLine."Amount Including VAT");
                                    //16630  TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Amount After Excise", SalesInvLine."Amount Including Excise");
                                END
                            END;
                            ItemUnitofMeasure.RESET;
                            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", TransporterPaymentLine.Item);
                            ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, TransporterPaymentLine.UOM);
                            TransporterPaymentLine.INSERT(TRUE);
                            LineNo := LineNo + 10000;
                        END;
                    //  END;
                    UNTIL SalesShpLine.NEXT = 0;
            UNTIL SalesShpHeader.NEXT = 0;
    end;
}

