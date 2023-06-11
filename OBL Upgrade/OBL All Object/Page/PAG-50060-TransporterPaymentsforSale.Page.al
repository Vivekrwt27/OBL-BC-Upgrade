page 50060 "Transporter Payments for Sale"
{
    // Customization No. 24 Vipul

    Caption = 'Transporter Payments';
    PageType = Card;
    SourceTable = "Transporter Payment Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


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
                field("Vendor No."; Rec."Vendor No.")
                {
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Vend.GET(Rec."Vendor No.") THEN BEGIN
                            Rec.VALIDATE("Post Code", Vend."Post Code");
                            Rec.VALIDATE(City, Vend.City);
                        END;
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                        IF TransporterPaymentLine.FIND('-') THEN
                            TransporterPaymentLine.DELETEALL;
                    end;
                }
                field("Post Code"; Rec."Post Code")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                        IF TransporterPaymentLine.FIND('-') THEN
                            TransporterPaymentLine.DELETEALL;
                        //CurrForm.SubForm.ACTIVATE;
                    end;
                }
                field("From Date"; Rec."From Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                        IF TransporterPaymentLine.FIND('-') THEN
                            TransporterPaymentLine.DELETEALL;
                        //CurrForm.SubForm.ACTIVATE            ;
                    end;
                }
                field("To Date"; Rec."To Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                        IF TransporterPaymentLine.FIND('-') THEN
                            TransporterPaymentLine.DELETEALL;
                        //CurrForm.SubForm.ACTIVATE            ;
                    end;
                }
                field("Charge Item"; Rec."Charge Item")
                {
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                        IF TransporterPaymentLine.FIND('-') THEN
                            TransporterPaymentLine.DELETEALL;
                        //CurrForm.SubForm.ACTIVATE            ;
                    end;
                }
                field("Rate/Kg"; Rec."Rate/Kg")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Total Amount");
                    end;
                }
            }
            part(SubForm; "Transporter Pymnt Sale Subform")
            {
                SubPageLink = "Trans. Payment No." = FIELD("No.");
                ApplicationArea = All;
            }
            field(TotalWeight; TotalWeight)
            {
                Caption = 'Total Weight (MT)';
                DecimalPlaces = 3 : 3;
                Editable = false;
                ApplicationArea = All;
            }
            field("Total Amount"; Rec."Total Amount")
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
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        "PurchHeaderNo.": Code[20];
                        "PurchLineNo.": Integer;
                        noseriesmgt: Codeunit NoSeriesManagement;
                        purchsetup: Record "Purchases & Payables Setup";
                        linenos: Integer;
                        Lno: Integer;
                        ICAPQty: Decimal;
                        ICAPQtyTotal: Decimal;
                    begin
                        IF CONFIRM('Do you want to post Invoice for Transporter Payment') THEN BEGIN
                            Rec.TESTFIELD("Vendor No.");
                            Rec.TESTFIELD("Post Code");
                            Rec.TESTFIELD("From Date");
                            Rec.TESTFIELD("To Date");
                            Rec.TESTFIELD("Charge Item");
                            Rec.CALCFIELDS("Total Amount");
                            TransporterPaymentLine.RESET;
                            TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                            IF NOT TransporterPaymentLine.FIND('-') THEN
                                ERROR('There is nothing to Post');
                            IF TransporterPaymentLine.FIND('-') THEN
                                REPEAT
                                    IF TransporterPaymentLine.Amount = 0 THEN
                                        ERROR('Amount must not be 0 in any line');
                                UNTIL TransporterPaymentLine.NEXT = 0;

                            PurchHeader.INIT;
                            purchsetup.GET;
                            "PurchHeaderNo." := noseriesmgt.GetNextNo(purchsetup."Invoice Nos.", WORKDATE, TRUE);
                            PurchHeader."No." := "PurchHeaderNo.";
                            PurchHeader.VALIDATE(PurchHeader."Document Type", PurchHeader."Document Type"::Invoice);
                            PurchHeader.VALIDATE(PurchHeader."Buy-from Vendor No.", Rec."Vendor No.");
                            PurchHeader.VALIDATE(PurchHeader."Document Date", WORKDATE);
                            PurchHeader.INSERT(TRUE);
                            PurchLine.INIT;
                            PurchLine.VALIDATE(PurchLine."Document Type", PurchLine."Document Type"::Invoice);
                            PurchLine.VALIDATE(PurchLine."Document No.", "PurchHeaderNo.");
                            linenos := linenos + 10000;
                            PurchLine.VALIDATE(PurchLine."Line No.", linenos);
                            PurchLine.VALIDATE(PurchLine.Type, PurchLine.Type::"Charge (Item)");
                            PurchLine.VALIDATE(PurchLine."No.", Rec."Charge Item");
                            PurchLine.VALIDATE(PurchLine.Quantity, 100);
                            PurchLine.VALIDATE(PurchLine."Direct Unit Cost", Rec."Total Amount" / 100);
                            PurchLine.INSERT(TRUE);
                            TransporterPaymentLine.RESET;
                            TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");

                            IF TransporterPaymentLine.FIND('-') THEN RecCount := TransporterPaymentLine.COUNT;
                            Window.OPEN('Posting Lines          #1##########\                       @2@@@@@@@@@@');

                            IF TransporterPaymentLine.FIND('-') THEN
                                REPEAT
                                    ItemChargeAssignPurch.INIT;
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Document Type", ItemChargeAssignPurch."Document Type"::Invoice);
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Document No.", "PurchHeaderNo.");
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Document Line No.", linenos);
                                    Lno := Lno + 10000;
                                    ItemChargeAssignPurch."Line No." := Lno;
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Item Charge No.", Rec."Charge Item");
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Item No.", TransporterPaymentLine.Item);
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Applies-to Doc. No.", TransporterPaymentLine."MRN No.");
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Applies-to Doc. Line No.", TransporterPaymentLine."Line No.");
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Qty. to Assign",
                                                                   TransporterPaymentLine.Amount * 100 / Rec."Total Amount");
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Unit Cost", Rec."Total Amount" / 100);
                                    IF TransporterPaymentLine.Transfer <> TRUE THEN
                                        ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Applies-to Doc. Type",
                                                                       ItemChargeAssignPurch."Applies-to Doc. Type"::"Sales Shipment")
                                    ELSE
                                        ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Applies-to Doc. Type",
                                                                       ItemChargeAssignPurch."Applies-to Doc. Type"::"Transfer Receipt");

                                    i += 1;
                                    Window.UPDATE(1, i);
                                    Window.UPDATE(2, ROUND(i * 10000 / RecCount, 1, '>'));

                                    ItemChargeAssignPurch.INSERT(TRUE);
                                    PurchLine.VALIDATE(PurchLine."Direct Unit Cost", Rec."Total Amount" / 100);
                                    PurchLine.MODIFY(TRUE);
                                UNTIL TransporterPaymentLine.NEXT = 0;
                            Rec.DELETE;
                            TransporterPaymentLine.DELETEALL;
                            Window.CLOSE;
                            MESSAGE('Purchase invoice %1 has been generated.', "PurchHeaderNo.");
                        END;

                        //Vipul Rounding Start
                        ItemChargeAssignPurch.RESET;
                        ItemChargeAssignPurch.SETFILTER(ItemChargeAssignPurch."Document Type", '%1', ItemChargeAssignPurch."Document Type"::Invoice);
                        ItemChargeAssignPurch.SETFILTER(ItemChargeAssignPurch."Document No.", "PurchHeaderNo.");
                        ItemChargeAssignPurch.SETFILTER(ItemChargeAssignPurch."Document Line No.", '%1', linenos);
                        IF ItemChargeAssignPurch.FIND('-') THEN
                            REPEAT
                                ICAPQty := ROUND(ItemChargeAssignPurch."Qty. to Assign", 0.01, '=');
                                ICAPQtyTotal += ICAPQty;
                                ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Qty. to Assign", ICAPQty);
                                ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Unit Cost", Rec."Total Amount" / 100);
                                ItemChargeAssignPurch.MODIFY;
                            UNTIL ItemChargeAssignPurch.NEXT = 0;

                        IF ICAPQtyTotal <> 100 THEN
                            ICAPQty := ItemChargeAssignPurch."Qty. to Assign";
                        ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Qty. to Assign", ICAPQty + (100 - ICAPQtyTotal));
                        ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Unit Cost", Rec."Total Amount" / 100);
                        ItemChargeAssignPurch.MODIFY;
                        //Vipul Rounding End
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
        OnActivateForm;
    end;

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        SalesShpHeader: Record "Sales Shipment Header";
        SalesShpLine: Record "Sales Shipment Line";
        TransporterPaymentLine: Record "Transporter Payment Line";
        Vend: Record Vendor;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        ItemChargeAssignPurch: Record "Item Charge Assignment (Purch)";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        TransferRcptHeader: Record "Transfer Receipt Header";
        TransferRcptLine: Record "Transfer Receipt Line";
        TransferShptHeader: Record "Transfer Shipment Header";
        "Total Amount": Decimal;
        Allow: Boolean;
        SalesInvoiceNo: Code[20];
        TransferShptNo: Code[20];
        Window: Dialog;
        i: Integer;
        RecCount: Integer;
        TotalWeight: Decimal;


    procedure SuggestLinesForPayment()
    begin
        Rec.TESTFIELD("Vendor No.");
        Rec.TESTFIELD("Post Code");
        Rec.TESTFIELD("From Date");
        Rec.TESTFIELD("To Date");
        Rec.TESTFIELD("Charge Item");

        TransporterPaymentLine.RESET;
        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
        IF TransporterPaymentLine.FIND('-') THEN
            TransporterPaymentLine.DELETEALL;

        SalesShpHeader.RESET;
        SalesShpHeader.SETRANGE(SalesShpHeader."Posting Date", Rec."From Date", Rec."To Date");
        SalesShpHeader.SETFILTER(SalesShpHeader."Ship-to Post Code", '%1', Rec."Post Code");
        IF SalesShpHeader.FIND('-') THEN
            REPEAT
                // Getting Sales Invoice No. Start
                SalesInvoiceNo := '';
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Source Type", "Source No.", "Entry Type", "Item No.", "Variant Code", "Posting Date");  //vipul Tri1.0
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Source Type", '%1', ItemLedgerEntry."Source Type"::Customer);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Source No.", SalesShpHeader."Sell-to Customer No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry Type", '%1', ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Posting Date", '%1', SalesShpHeader."Posting Date");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document No.", SalesShpHeader."No.");
                IF ItemLedgerEntry.FIND('-') THEN BEGIN
                    ValueEntry.RESET;
                    ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");      //vipul Tri1.0
                    ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                    IF ValueEntry.FIND('-') THEN
                        SalesInvoiceNo := ValueEntry."Document No.";
                END;
                // Getting Sales Invoice No. End
                SalesShpLine.RESET;
                SalesShpLine.SETFILTER(SalesShpLine."Document No.", SalesShpHeader."No.");
                SalesShpLine.SETFILTER(SalesShpLine.Type, '%1', SalesShpLine.Type::Item); //ND
                SalesShpLine.SETFILTER(SalesShpLine.Quantity, '<>%1', 0); //Vipul
                IF SalesShpLine.FIND('-') THEN
                    REPEAT
                        Allow := TRUE;
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date", "Item No."); //Vipul Tri1.0
                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document No.", SalesShpLine."Document No.");
                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Item No.", SalesShpLine."No.");

                        IF ItemLedgerEntry.FIND('-') THEN
                            REPEAT
                                ValueEntry.RESET;
                                ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");    //Vipul tri1.0
                                ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                IF ValueEntry.FIND('-') THEN
                                    REPEAT
                                        IF Rec."Charge Item" = ValueEntry."Item Charge No." THEN Allow := FALSE;
                                    UNTIL ValueEntry.NEXT = 0;
                            UNTIL ItemLedgerEntry.NEXT = 0;

                        IF Allow THEN BEGIN
                            TransporterPaymentLine.INIT;
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN No.", SalesShpLine."Document No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Line No.", SalesShpLine."Line No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN Date", SalesShpHeader."Posting Date");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Invoice No.", SalesInvoiceNo);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Customer No.", SalesShpLine."Sell-to Customer No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.City, SalesShpHeader."Ship-to City");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Posting Date", WORKDATE);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Item, SalesShpLine."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Quantity, SalesShpLine.Quantity);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.UOM, SalesShpLine."Unit of Measure Code");
                            ItemUnitofMeasure.RESET;
                            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", TransporterPaymentLine.Item);
                            ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, TransporterPaymentLine.UOM);
                            IF ItemUnitofMeasure.FIND('-') THEN
                                TransporterPaymentLine.VALIDATE(TransporterPaymentLine."K.G.", ItemUnitofMeasure.Weight * TransporterPaymentLine.Quantity);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Amount, TransporterPaymentLine."K.G." * Rec."Rate/Kg");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."GR No.", SalesShpHeader."GR No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."GR Date", SalesShpHeader."GR Date");
                            TransporterPaymentLine.INSERT(TRUE);
                        END;
                    UNTIL SalesShpLine.NEXT = 0;
            UNTIL SalesShpHeader.NEXT = 0;


        SalesInvoiceNo := '';

        //inserting Transfer Receipt lines

        TransferRcptHeader.RESET;
        TransferRcptHeader.SETRANGE(TransferRcptHeader."Posting Date", Rec."From Date", Rec."To Date");
        TransferRcptHeader.SETFILTER(TransferRcptHeader."Transfer-to Post Code", Rec."Post Code");
        IF TransferRcptHeader.FIND('-') THEN
            REPEAT
                //Getting Transfer Shipment No. Start
                TransferShptNo := '';
                TransferShptHeader.RESET;
                TransferShptHeader.SETFILTER(TransferShptHeader."Transfer Order No.", TransferRcptHeader."Transfer Order No.");
                IF TransferShptHeader.FIND('-') THEN
                    TransferShptNo := TransferShptHeader."No.";
                //Getting Transfer Shipment No. End

                TransferRcptLine.RESET;
                TransferRcptLine.SETFILTER(TransferRcptLine."Document No.", TransferRcptHeader."No.");
                IF TransferRcptLine.FIND('-') THEN
                    REPEAT
                        Allow := TRUE;
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date", "Item No."); //Vipul Tri1.0
                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document No.", TransferRcptLine."Document No.");
                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Item No.", TransferRcptLine."Item No.");
                        IF ItemLedgerEntry.FIND('-') THEN
                            REPEAT
                                ValueEntry.RESET;
                                ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");  //vipul tri1.0
                                ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                IF ValueEntry.FIND('-') THEN
                                    REPEAT
                                        IF Rec."Charge Item" = ValueEntry."Item Charge No." THEN Allow := FALSE;
                                    UNTIL ValueEntry.NEXT = 0;
                            UNTIL ItemLedgerEntry.NEXT = 0;
                        IF Allow THEN BEGIN
                            TransporterPaymentLine.INIT;
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Trans. Payment No.", Rec."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN No.", TransferRcptLine."Document No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Line No.", TransferRcptLine."Line No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN Date", TransferRcptHeader."Posting Date");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Invoice No.", TransferShptNo);
                            TransporterPaymentLine.Transfer := TRUE;
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Customer No.", TransferRcptLine."Transfer-to Code");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.City, TransferRcptHeader."Transfer-to City");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Posting Date", WORKDATE);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Item, TransferRcptLine."Item No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Quantity, TransferRcptLine.Quantity);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.UOM, TransferRcptLine."Unit of Measure Code");
                            ItemUnitofMeasure.RESET;
                            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", TransporterPaymentLine.Item);
                            ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, TransporterPaymentLine.UOM);
                            IF ItemUnitofMeasure.FIND('-') THEN
                                TransporterPaymentLine.VALIDATE(TransporterPaymentLine."K.G.", ItemUnitofMeasure.Weight * TransporterPaymentLine.Quantity);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Amount, TransporterPaymentLine."K.G." * Rec."Rate/Kg");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."GR No.", TransferRcptHeader."GR No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."GR Date", TransferRcptHeader."GR Date");
                            TransporterPaymentLine.INSERT(TRUE);
                        END;
                    UNTIL TransferRcptLine.NEXT = 0;
            UNTIL TransferRcptHeader.NEXT = 0;

        Rec.CALCFIELDS("Total Weight");
        TotalWeight := Rec."Total Weight" / 1000;
        CurrPage.UPDATE;
    end;

    local procedure OnActivateForm()
    begin
        Rec.CALCFIELDS("Total Weight");
        TotalWeight := Rec."Total Weight" / 1000;
        CurrPage.UPDATE;
    end;
}

