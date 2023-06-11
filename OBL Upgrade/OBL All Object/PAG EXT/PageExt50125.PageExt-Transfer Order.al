pageextension 50125 "Transfer Order" extends "Transfer Order"
{
    layout
    {
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                //ShipmentDateOnAfterValidate;
            end;
        }
        moveafter("Transfer-from Code"; "In-Transit Code")
        moveafter("Posting Date"; "Shipment Date")
        addafter("Transfer-from Code")
        {

            field("Requested By"; Rec."Requested By")
            {
                ApplicationArea = all;
            }
            field(Purpose; Rec.Purpose)
            {
                ApplicationArea = all;
            }
            field("Loading Inspector"; Rec."Loading Inspector")
            {
                ApplicationArea = all;
            }
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = all;
            }
            field("GR No."; Rec."GR No.")
            {
                ApplicationArea = all;
            }
            field("GR Date"; Rec."GR Date")
            {
                ApplicationArea = all;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = all;
            }
            field("Total Qty"; Rec."Total Qty")
            {
                ApplicationArea = all;
            }
            field("Group Code"; Rec."Group Code")
            {
                ApplicationArea = all;
            }
            field("OutPut Date"; Rec."OutPut Date")
            {
                ApplicationArea = all;
            }

        }
        addafter(Status)
        {
            field("Locked Order"; Rec."Locked Order")
            {
                ApplicationArea = all;
            }
            field("Qty in Sq Mtr"; Rec."Qty in Sq Mtr")
            {
                ApplicationArea = all;
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = all;
            }
            field("Qty. To Ship"; Rec."Qty. To Ship")
            {
                ApplicationArea = all;
            }
            field("Shipment No. Series"; Rec."Shipment No. Series")
            {
                ApplicationArea = all;
            }
        }
    }


    actions
    {
        addafter("Re&lease")
        {
            action("Transfer Order confirmation")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
                trigger OnAction()
                var
                begin
                    TransferHead.RESET;
                    TransferHead.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(50097, TRUE, TRUE, TransferHead);
                END;
            }
            action("Issue Slip")
            {
                trigger OnAction()
                var
                    TransferHeader: Record 5740;
                BEGIN
                    TransferHeader.RESET;
                    TransferHeader.SETFILTER("No.", '%1', rec."No.");
                    IF TransferHeader.FINDFIRST THEN
                        //IssueSlip.SETTABLEVIEW(Rec);
                        REPORT.RUN(50372, TRUE, TRUE, TransferHeader);
                END;
            }
        }


        modify("Re&lease")
        {
            trigger OnBeforeAction()
            var
                UserSetup: Record "User Setup";
                TransferLine, TransLine1 : Record "Transfer Line";
                Text50000: Label 'Quantity is not equal to Reserved Quantity Outbond\\You can not release the document.';
                Text50001: Label 'Reserve Quantity Should be Equal to Quantity for Line No. %1';
                Text50002: Label 'Transfer Order Quantity %1 &  Reserve Quantity %2.';
                DateFilter: Text[500];
                Item: Record Item;
                AvailableQuantity: Decimal;
                BinContent: Record "Bin Content";
                ReleaseTrasfer: Codeunit "Release Transfer Document";
            begin
                // UPDATE - TCPL - 7632
                //MSSS- Begin

                IF Rec."Transfer-to Code" IN ['SKD-SAMPLE', 'HSK-SAMPLE', 'DRA-SAMPLE'] THEN
                    EXIT
                ELSE
                    IF Rec."Transfer-from Code" IN ['SKD-WH-MFG', 'HSK-WH-MFG', 'DRA-WH-MFG'] THEN BEGIN
                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Allow TO Release" = FALSE THEN
                                ERROR('%1 has no permission to Release the Transfer Order, Please Cal On 8373914482', UserSetup."User ID");
                        END;
                    END;


                TransferLine.RESET;
                TransferLine.SETRANGE("Document No.", Rec."No.");
                TransferLine.SETRANGE("Transfer-from Code", '');
                IF TransferLine.FINDFIRST THEN
                    ERROR('You can not release with a blank line');

                IF Rec."Transfer-to Code" IN ['WH-HOSKOTE', 'WH-DORA'] THEN BEGIN
                    TransferLine.RESET;
                    TransferLine.SETRANGE("Document No.", Rec."No.");
                    TransferLine.SETFILTER(Quantity, '<>%1', 0);
                    IF TransferLine.FINDFIRST THEN BEGIN
                        REPEAT
                            TransferLine.CheckMfgBatchNo(TransferLine);
                            TransferLine.CALCFIELDS(TransferLine."Reserved Quantity Outbnd.");
                            MESSAGE(Text50002, TransferLine.Quantity, ABS(TransferLine."Reserved Quantity Outbnd."));
                            IF TransferLine.Quantity > ROUND(TransferLine."Reserved Quantity Outbnd.") THEN
                                ERROR(Text50001, TransferLine."Line No.");
                        UNTIL TransferLine.NEXT = 0;
                    END;
                END;

                //TRI
                //TESTFIELD("Transfer order Status","Transfer order Status"::Open);
                DateFilter := '..' + FORMAT(Rec."Posting Date");
                TransLine1.RESET;
                TransLine1.SETRANGE("Document No.", Rec."No.");
                TransLine1.SETFILTER(Quantity, '<>0');
                IF TransLine1.FIND('-') THEN
                    REPEAT
                        TransLine1.CALCFIELDS(TransLine1."Reserved Qty. Outbnd. (Base)");
                        Item.RESET;
                        Item.SETFILTER("No.", TransLine1."Item No.");
                        Item.SETFILTER("Date Filter", DateFilter);
                        Item.SETFILTER("Location Filter", TransLine1."Transfer-from Code");
                        Item.SETFILTER("Variant Filter", '%1', TransLine1."Variant Code");
                        IF Item.FIND('-') THEN BEGIN
                            Item.CALCFIELDS("Net Change", "Reserved Qty. on Inventory");
                            AvailableQuantity := (Item."Net Change") - (Item."Reserved Qty. on Inventory" - TransLine1."Reserved Qty. Outbnd. (Base)");
                        END;

                        //IF (TransLine1."Quantity (Base)" > AvailableQuantity) THEN
                        // ERROR(Text50001,TransLine1."Line No.");

                        IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                            BinContent.GET(TransLine1."Transfer-from Code", TransLine1."Transfer-from Bin Code", TransLine1."Item No.",
                            TransLine1."Variant Code", TransLine1."Unit of Measure Code");
                            BinContent.CALCFIELDS(BinContent.Quantity);
                            IF BinContent.Quantity < TransLine1.Quantity THEN
                                ERROR('Insufficient Bin Quantity for line no %1', TransLine1."Line No.");
                        END;
                    UNTIL TransLine1.NEXT = 0;

                Rec."Releasing Date" := WORKDATE;
                Rec."Releasing Time" := TIME;

                IF Rec."External Transfer" THEN
                    IF Rec."Customer Price Group" <> '' THEN BEGIN
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.", Rec."No.");
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                            //TEAM 14763 TransLine1.TESTFIELD(MRP);
                            UNTIL TransLine1.NEXT = 0;
                    END;

                Rec."Posting Date" := 0D;
                Rec."Transfer order Status" := Rec."Transfer order Status"::Released;
                Rec.MODIFY;
                ReleaseTrasfer.RUN(Rec);
            end;
        }
        modify("Reo&pen")
        {
            trigger OnBeforeAction()
            var
                ReleaseTransferDoc: Codeunit 5708;
                TransferLine: Record 5741;

            begin
                TransferLine.RESET;
                TransferLine.SETRANGE("Document No.", rec."No.");
                TransferLine.CALCSUMS("Quantity Shipped");
                IF TransferLine."Quantity Shipped" > 0 THEN
                    ERROR('Qty has already shipped');

            end;
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSet: Record 91;
    begin
        UserSet.GET(USERID);
        rec."Transfer-from Code" := UserSet.Location;
    end;

    trigger OnOpenPage()
    begin
        Clear(Rec);
    end;

    var
        TransferHead: Record "Transfer Header";
}