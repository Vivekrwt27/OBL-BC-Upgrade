codeunit 99403 "Auto-Transfer Post CU"
{

    trigger OnRun()
    begin
        /*
        {
        tempTransShpH1.RESET;
        tempTransShpH1.SETCURRENTKEY("Posting Date");
        tempTransShpH1.SETRANGE("External Transfer",TRUE);
        IF tempTransShpH1.FIND('-') THEN
            REPEAT
            IF TransH.GET(tempTransShpH1."Transfer Order No.") AND (TransH."Transfer-from Code" <> TransH."Transfer-to Code")
            AND (tempTransShpH1."Transfer-from Code" <> tempTransShpH1."Transfer-to Code") AND (TransH.Problem = FALSE) THEN
               BEGIN                              //trans head
                 tempTransShpH.RESET;
                 tempTransShpH.SETCURRENTKEY("Transfer Order No.");
                 tempTransShpH.SETRANGE("Transfer Order No.",TransH."No.");
                 IF tempTransShpH.FIND('-') THEN
                    REPEAT                            //temp trans ship head
                    IF (tempTransShpH."Transfer-from Code" <> tempTransShpH."Transfer-to Code")
                       AND (NOT TransShpH.GET(tempTransShpH."No.")) THEN BEGIN
                      Win.OPEN('Posting Transfer Shipment #1#######################');
                      Win.UPDATE(1,tempTransShpH."No.");
                      TransH."Shipment No. Series" := tempTransShpH."No. Series";
                      TransH.VALIDATE("Posting Date",tempTransShpH."Posting Date");
                      TransH.VALIDATE("Shipping No.",tempTransShpH."No.");
                      TransH.MODIFY;
                      tempTransShpL.RESET;
                      tempTransShpL.SETRANGE(tempTransShpL."Document No.",tempTransShpH."No.");
                      IF tempTransShpL.FIND('-') THEN
                         REPEAT                         //temp trans ship line
                              TransL.GET(tempTransShpL."Transfer Order No.",tempTransShpL."Line No.");
                              IF TransL."Quantity Shipped" = 0 THEN BEGIN
                                 TransL.VALIDATE("Item No.");
                                 TransL.VALIDATE("Unit of Measure Code",tempTransShpL."Unit of Measure Code");
                                 TransL.VALIDATE(Quantity);
                                 IF (TransL.Quantity - TransL."Quantity Shipped") < TransL."Qty. to Ship" THEN
                                    TransL.VALIDATE(Quantity,TransL.Quantity + tempTransShpL.Quantity);
                              END;
                              TransL.VALIDATE("Transfer-from Code",tempTransShpL."Transfer-from Code");
                              TransL.VALIDATE("Transfer-to Code",tempTransShpL."Transfer-to Code");
                              TransL."Shipment Date" := tempTransShpH."Shipment Date";
                              TransL.VALIDATE(MRP,TRUE);
                              TransL.VALIDATE("MRP Price",tempTransShpL.MRP);
                              TransL.VALIDATE("Transfer Price",tempTransShpL."Unit Price");
                              TransL.VALIDATE("Assessable Value",tempTransShpL."Assessable Value");
                              TransL.VALIDATE("External Transfer",tempTransShpL."External Transfer");
                              TransL.VALIDATE("Variant Code",tempTransShpL."Variant Code");
                              TransL.VALIDATE("Unit Price",tempTransShpL."Unit Price");
                              TransL.VALIDATE("Qty. to Ship",tempTransShpL.Quantity);
                              TransL.MODIFY;
        
                              //lot
                              Item.GET(TransL."Item No.");
                              IF Item."Item Tracking Code" <> '' THEN
                              BEGIN
                                ResvEntry.RESET;
                                IF ResvEntry.FINDLAST THEN
                                   mLine := ResvEntry."Entry No." + 1
                                ELSE
                                   mLine := 1;
        
                                ResvEntry.INIT;
                                ResvEntry."Entry No." := mLine;
                                ResvEntry.Positive := FALSE;
                                ResvEntry.VALIDATE("Item No.",tempTransShpL."Item No.");
                                ResvEntry.VALIDATE("Qty. per Unit of Measure",TransL."Qty. per Unit of Measure");
                                ResvEntry.VALIDATE("Quantity (Base)",-1* TransL."Qty. to Ship (Base)");
                                ResvEntry.VALIDATE("Location Code",TransL."Transfer-from Code");
                                ResvEntry.VALIDATE("Reservation Status",ResvEntry."Reservation Status"::Surplus);
                                ResvEntry.VALIDATE("Creation Date",TransL."Shipment Date");
                                ResvEntry.VALIDATE("Source Type",5741);
                                ResvEntry.VALIDATE("Source Subtype",0);
                                ResvEntry.VALIDATE("Source ID",TransL."Document No.");
                                ResvEntry.VALIDATE("Source Ref. No.",TransL."Line No.");
                                ResvEntry.VALIDATE("Shipment Date",TransL."Shipment Date");
                                ResvEntry.VALIDATE("Variant Code",TransL."Variant Code");
                                ResvEntry.VALIDATE("Lot No.",'FGOPST01042010');
                                ResvEntry.VALIDATE("Item Tracking",ResvEntry."Item Tracking"::"Lot No.");
                                ResvEntry.INSERT;
        
                                mLine := mLine + 1;
        
                                ResvEntry.INIT;
                                ResvEntry."Entry No." := mLine;
                                ResvEntry.Positive := TRUE;
                                ResvEntry.VALIDATE("Item No.",tempTransShpL."Item No.");
                                ResvEntry.VALIDATE("Qty. per Unit of Measure",TransL."Qty. per Unit of Measure");
                                ResvEntry.VALIDATE("Quantity (Base)",TransL."Qty. to Ship (Base)");
                                ResvEntry.VALIDATE("Location Code",TransL."Transfer-to Code");
                                ResvEntry.VALIDATE("Reservation Status",ResvEntry."Reservation Status"::Surplus);
                                ResvEntry.VALIDATE("Creation Date",TransL."Shipment Date");
                                ResvEntry.VALIDATE("Source Type",5741);
                                ResvEntry.VALIDATE("Source Subtype",1);
                                ResvEntry.VALIDATE("Source ID",TransL."Document No.");
                                ResvEntry.VALIDATE("Source Ref. No.",TransL."Line No.");
                                ResvEntry.VALIDATE("Expected Receipt Date",TransL."Shipment Date");
                                ResvEntry.VALIDATE("Variant Code",TransL."Variant Code");
                                ResvEntry.VALIDATE("Lot No.",'FGOPST01042010');
                                ResvEntry.VALIDATE("Item Tracking",ResvEntry."Item Tracking"::"Lot No.");
                                ResvEntry.INSERT;
        
        
                              END;
                              //lot
        
                              TransL.CalculateStructures(TransH);
                              TransL.AdjustStructureAmounts(TransH);
                              TransL.UpdateTransLines(TransH);
        
                         UNTIL tempTransShpL.NEXT = 0;  //temp trans ship line
                    TransferPostShipment.RUN(TransH);
                    Win.CLOSE;
                    END;
                    UNTIL tempTransShpH.NEXT = 0;     //temp trans ship head
        
                    //post receive
                 tempTransRcvH.RESET;
                 tempTransRcvH.SETCURRENTKEY("Transfer Order No.");
                 tempTransRcvH.SETRANGE("Transfer Order No.",TransH."No.");
                 IF tempTransRcvH.FIND('-') THEN
                    REPEAT     //temp trans ship head
                    IF (tempTransRcvH."Transfer-from Code" <> tempTransRcvH."Transfer-to Code")
                    AND (NOT TransRcvH.GET(tempTransRcvH."No.")) THEN BEGIN
                      Win.OPEN('Posting Transfer Receipt #1#######################');
                      Win.UPDATE(1,tempTransRcvH."No.");
        
                      TransH.VALIDATE("Posting Date",tempTransRcvH."Posting Date");
                      TransH.VALIDATE("Receiving No.",tempTransRcvH."No.");
                      TransH.MODIFY;
                      tempTransRcvL.RESET;
                      tempTransRcvL.SETRANGE(tempTransRcvL."Document No.",tempTransRcvH."No.");
                      IF tempTransRcvL.FIND('-') THEN
                         REPEAT                         //temp trans ship line
                              TransL.GET(tempTransRcvL."Transfer Order No.",tempTransRcvL."Line No.");
                              TransL."Receipt Date" := tempTransRcvH."Receipt Date";
                              //TransL.VALIDATE(MRP,TRUE);
                              //TransL.VALIDATE("MRP Price",tempTransRcvL.MRP);
                              //TransL.VALIDATE("Transfer Price",tempTransRcvL."Unit Price");
                              //TransL.VALIDATE("Assessable Value",tempTransRcvL."Assessable Value");
                              //TransL.VALIDATE("External Transfer",tempTransRcvL."External Transfer");
                              //TransL.VALIDATE("Unit Price",tempTransRcvL."Unit Price");
                              TransL.VALIDATE("Qty. to Receive",tempTransRcvL.Quantity);
                              TransL.MODIFY;
        
                              //TransL.CalculateStructures(TransH);
                              //TransL.AdjustStructureAmounts(TransH);
                              //TransL.UpdateTransLines(TransH);
                         UNTIL tempTransRcvL.NEXT = 0;  //temp trans ship line
        
                    TransferPostReceive.RUN(TransH);
                    Win.CLOSE;
                    END;
                    UNTIL tempTransRcvH.NEXT = 0;     //temp trans ship head
               END;              //trans head
        UNTIL tempTransShpH1.NEXT = 0;
        ResvEntry.RESET;
        ResvEntry.DELETEALL;
        }
         */

    end;

    var
        TransH: Record "Transfer Header";
        TransL: Record "Transfer Line";
        tempTransShpH: Record "Transfer Shipment Header Temp";
        tempTransShpL: Record "Transfer Shipment Line Temp";
        tempTransRcvH: Record "Transfer Receipt Header Temp";
        tempTransRcvL: Record "Transfer Receipt Line Temp";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        Win: Dialog;
        tempTransShpH1: Record "Transfer Shipment Header Temp";
        TransferPostReceive: Codeunit "TransferOrder-Post Receipt";
        ResvEntry: Record "Reservation Entry";
        mLine: Integer;
        TransShpH: Record "Transfer Shipment Header";
        TransRcvH: Record "Transfer Receipt Header";
        Item: Record Item;
}

