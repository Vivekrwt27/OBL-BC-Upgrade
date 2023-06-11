page 50043 "Transporter Payment"
{
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
                    Lookup = true;
                    LookupPageID = "Post Codes";
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PostalCode.RESET;
                        IF PAGE.RUNMODAL(PAGE::"Post Codes", PostalCode) = ACTION::LookupOK THEN BEGIN
                            Rec."Post Code" := PostalCode.Code;
                            Rec.City := PostalCode.City;
                        END;
                    end;
                }
                field(City; Rec.City)
                {
                    NotBlank = true;
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
            part(SubForm; "Transporter Payment Subform")
            {
                SubPageLink = "Trans. Payment No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Amount)
            {
                Caption = 'Amount';
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
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
                                        ERROR('Amount must not be 0');
                                UNTIL TransporterPaymentLine.NEXT = 0;

                            PurchHeader.INIT;
                            purchsetup.GET;
                            "PurchHeaderNo." := noseriesmgt.GetNextNo(purchsetup."Invoice Nos.", WORKDATE, TRUE);
                            PurchHeader."No." := "PurchHeaderNo.";
                            PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;
                            PurchHeader.Status := PurchHeader.Status::Open;
                            PurchHeader.INSERT(TRUE);
                            PurchHeader.VALIDATE(PurchHeader."Buy-from Vendor No.", Rec."Vendor No.");
                            PurchHeader.VALIDATE(PurchHeader."Document Date", WORKDATE);
                            //   PurchHeader.VALIDATE(PurchHeader.Structure, 'PGST');
                            PurchHeader.MODIFY(TRUE);
                            PurchLine.INIT;
                            PurchLine.VALIDATE(PurchLine."Document Type", PurchLine."Document Type"::Invoice);
                            PurchLine.VALIDATE(PurchLine."Document No.", "PurchHeaderNo.");
                            linenos := linenos + 10000;
                            PurchLine.VALIDATE(PurchLine."Line No.", linenos);
                            PurchLine.VALIDATE(PurchLine.Type, PurchLine.Type::"Charge (Item)");
                            PurchLine.VALIDATE(PurchLine."No.", Rec."Charge Item");
                            PurchLine.VALIDATE(PurchLine.Quantity, 100);
                            PurchLine.VALIDATE(PurchLine."Direct Unit Cost", Rec."Total Amount" / 100);
                            PurchLine.INSERT;
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
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Qty. to Assign", TransporterPaymentLine.Amount * 100 / Rec."Total Amount");
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Unit Cost", Rec."Total Amount" / 100);
                                    ItemChargeAssignPurch.VALIDATE(ItemChargeAssignPurch."Applies-to Doc. Type",
                                                                   ItemChargeAssignPurch."Applies-to Doc. Type"::Receipt);
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
                action("Freight Voucher")
                {
                    Caption = 'Freight Voucher';
                    RunObject = Report "Freight Voucher2";
                    ApplicationArea = All;
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
        PurchrcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        TransporterPaymentLine: Record "Transporter Payment Line";
        Vend: Record Vendor;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        ItemChargeAssignPurch: Record "Item Charge Assignment (Purch)";
        "Total Amount": Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Allow: Boolean;
        Window: Dialog;
        i: Integer;
        RecCount: Integer;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        TransfershipHeader: Record "Transfer Shipment Header";
        TransfershipLine: Record "Transfer Shipment Line";
        PostalCode: Record "Post Code";


    procedure SuggestLinesForPayment()
    var
        Item: Record Item;
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
        Window.OPEN('Processing.................');
        PurchrcptHeader.RESET;
        PurchrcptHeader.SETRANGE(PurchrcptHeader."Posting Date", Rec."From Date", Rec."To Date");
        PurchrcptHeader.SETFILTER(PurchrcptHeader."Buy-from Post Code", '%1', Rec."Post Code");
        //PurchrcptHeader.SETFILTER(PurchrcptHeader."Transporter's Code","Vendor No.");
        IF PurchrcptHeader.FIND('-') THEN
            REPEAT
                PurchRcptLine.RESET;
                PurchRcptLine.SETFILTER(PurchRcptLine."Document No.", PurchrcptHeader."No.");
                PurchRcptLine.SETFILTER(PurchRcptLine.Type, '%1', PurchRcptLine.Type::Item);
                PurchRcptLine.SETFILTER(PurchRcptLine.Quantity, '<>%1', 0);
                IF PurchRcptLine.FIND('-') THEN
                    REPEAT
                        Allow := TRUE;

                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", PurchRcptLine."Document No.");
                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", PurchRcptLine."No.");
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
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN No.", PurchRcptLine."Document No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Line No.", PurchRcptLine."Line No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN Date", PurchrcptHeader."Posting Date");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Vendor No.", PurchRcptLine."Buy-from Vendor No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Posting Date", WORKDATE);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Item, PurchRcptLine."No.");
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Quantity, PurchRcptLine.Quantity);
                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.UOM, PurchRcptLine."Unit of Measure Code");

                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine."K.G.",
                                                            Item.UomToWeight(TransporterPaymentLine.Item, TransporterPaymentLine.UOM,
                                                                             TransporterPaymentLine.Quantity
                                                                            )
                                                           );

                            TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Amount, TransporterPaymentLine."K.G." * Rec."Rate/Kg");
                        END;
                        IF TransporterPaymentLine.INSERT(TRUE) THEN;
                    UNTIL PurchRcptLine.NEXT = 0;
            UNTIL PurchrcptHeader.NEXT = 0;

        /*
        SalesInvHeader.RESET;
        SalesInvHeader.SETRANGE(SalesInvHeader."Posting Date","From Date","To Date");
        SalesInvHeader.SETFILTER(SalesInvHeader."Transporter's Name","Vendor No.");
        SalesInvHeader.SETRANGE(SalesInvHeader.Pay,SalesInvHeader.Pay::" To Be Billed");
        IF SalesInvHeader.FIND('-') THEN
        REPEAT
          SalesInvLine.RESET;
          SalesInvLine.SETFILTER(SalesInvLine."Document No.",SalesInvHeader."No.");
          SalesInvLine.SETFILTER(SalesInvLine.Type,'%1',SalesInvLine.Type::Item);
          SalesInvLine.SETFILTER(SalesInvLine.Quantity,'<>%1',0);
          IF SalesInvLine.FIND('-') THEN REPEAT
              TransporterPaymentLine.INIT;
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Trans. Payment No.","No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN No." , SalesInvLine."Document No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Line No." , SalesInvLine."Line No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN Date" , SalesInvHeader."Posting Date");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Vendor No." , SalesInvLine."Sell-to Customer No.");
             // TransporterPaymentLine.VALIDATE(TransporterPaymentLine.City , SalesInvHeader."Bill-to City");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Posting Date" , WORKDATE);
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Item , SalesInvLine."No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Quantity , SalesInvLine.Quantity);
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.UOM , SalesInvLine."Unit of Measure Code");
        
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."K.G.",
                                              Item.UomToWeight(TransporterPaymentLine.Item,TransporterPaymentLine.UOM,
                                                               TransporterPaymentLine.Quantity
                                                              )
                                             );
        
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Amount , TransporterPaymentLine."K.G."*"Rate/Kg");
              //IF TransporterPaymentLine.INSERT(TRUE) THEN;
               TransporterPaymentLine.INSERT(TRUE);
           // END;
           UNTIL SalesInvLine.NEXT = 0;
        UNTIL SalesInvHeader.NEXT =0;
        
        
        TransfershipHeader.RESET;
        TransfershipHeader.SETRANGE(TransfershipHeader."Posting Date","From Date","To Date");
        TransfershipHeader.SETFILTER(TransfershipHeader."Transporter's Name","Vendor No.");
        IF TransfershipHeader.FIND('-') THEN
        REPEAT
         TransfershipLine.RESET;
         TransfershipLine.SETFILTER(TransfershipLine."Document No.",TransfershipHeader."No.");
         TransfershipLine.SETFILTER(TransfershipLine.Quantity,'<>%1',0); //Vipul
          IF TransfershipLine.FIND('-') THEN REPEAT
              TransporterPaymentLine.INIT;
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Trans. Payment No.","No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN No." , TransfershipLine."Document No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Line No." , TransfershipLine."Line No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."MRN Date" , TransfershipHeader."Posting Date");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Vendor No." , TransfershipHeader."Transporter's Name");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.City ,TransfershipHeader."Transfer-from City" );
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Posting Date" , WORKDATE);
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Item , TransfershipLine."Item No.");
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Quantity , TransfershipLine.Quantity);
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.UOM , TransfershipLine."Unit of Measure Code");
        
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine."K.G.",
                                              Item.UomToWeight(TransporterPaymentLine.Item,TransporterPaymentLine.UOM,
                                                               TransporterPaymentLine.Quantity
                                                              )
                                             );
        
              TransporterPaymentLine.VALIDATE(TransporterPaymentLine.Amount , TransporterPaymentLine."K.G."*"Rate/Kg");
              IF   TransporterPaymentLine.INSERT(TRUE) THEN;
           UNTIL TransfershipLine.NEXT = 0;
        UNTIL TransfershipHeader.NEXT =0;
        */
        Window.CLOSE;

    end;
}

