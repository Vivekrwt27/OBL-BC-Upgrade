codeunit 99305 "Auto Update SO From SS"
{

    trigger OnRun()
    begin
        recSH.LOCKTABLE;
        recSL.LOCKTABLE;

        Win.OPEN('Posted Sales Shipment #1#######################');

        /*
        recTempSSH.RESET;
        IF recTempSSH.FINDFIRST THEN
        BEGIN
          REPEAT
            Win.UPDATE(1,recTempSSH."No.");
            IF recSH.GET(recSH."Document Type"::Order,recTempSSH."Order No.") THEN
            BEGIN
                IF recSH."Old Order for Post" THEN
                BEGIN
                  IF recCustomer.GET(recSH."Sell-to Customer No.") THEN
                  BEGIN
                    //recSH.INIT;
                    //recSH.TRANSFERFIELDS(recTempSSH);
                    //recSH."Document Type" := recSH."Document Type"::Order;
                    //recSH."No." := recTempSSH."Order No.";
                    recSH.VALIDATE("Location Code",recTempSSH."Location Code");
                    recSH.VALIDATE(Structure,'');
                    recSH.VALIDATE("Shortcut Dimension 1 Code",recTempSSH."Location Code");
                    recSH.VALIDATE("Posting Date",recTempSSH."Posting Date");
                    //recSH.VALIDATE(
                    //recSH."Shipping No." := recTempSSH."No.";
                    recSH."Old Order for Post" := TRUE;
                    recSH."Group Code Check" := TRUE;
                    //IF NOT recSH.INSERT THEN
                    recSH.MODIFY;
                  END;
                END;
            END;
          UNTIL recTempSSH.NEXT = 0;
        END;
        COMMIT;
        */
        recTempSSH.RESET;
        //recTempSSH.SETRANGE("Order No.",'SOAH\1011\00001');
        IF recTempSSH.FINDFIRST THEN BEGIN
            REPEAT
                Win.UPDATE(1, recTempSSH."No.");
                IF recSH.GET(recSH."Document Type"::Order, recTempSSH."Order No.") THEN BEGIN
                    IF recSH."Old Order for Post" THEN BEGIN
                        IF recCustomer.GET(recSH."Sell-to Customer No.") THEN BEGIN
                            recTempSSL.RESET;
                            recTempSSL.SETRANGE(recTempSSL."Document No.", recTempSSH."No.");
                            IF recTempSSL.FIND('-') THEN
                                REPEAT
                                    //recSL.INIT;
                                    //recSL.TRANSFERFIELDS(recTempSSL);
                                    //recSL."Document Type" := recSH."Document Type"::Order;
                                    //recSL."Document No." := recSH."No.";
                                    //IF recSL."Gen. Prod. Posting Group" = 'MANUF.' THEN
                                    //recSL."Gen. Prod. Posting Group" := 'MANUF';
                                    //IF NOT recSL.INSERT THEN recSL.MODIFY;
                                    IF recSL.GET(recSH."Document Type"::Order, recSH."No.", recTempSSL."Line No.") THEN BEGIN
                                        IF RecItem.GET(recSL."No.") THEN BEGIN
                                            recSL.VALIDATE("No.");
                                            recSL.VALIDATE(Reserve, recSL.Reserve::Always);
                                            recSL.VALIDATE("Unit Price", recTempSSL."Unit Price");
                                            //    recSL.VALIDATE("MRP Price", recTempSSL.MRP);
                                            //    recSL.VALIDATE(MRP, TRUE);
                                            recSL.VALIDATE("Discount Per Unit", recTempSSL."Discount Per Unit");
                                            recSL.VALIDATE(Quantity);
                                            IF recSL."Outstanding Quantity" >= recTempSSL.Quantity THEN BEGIN
                                                recSL.VALIDATE("Qty. to Ship", recTempSSL.Quantity);
                                                recSL.VALIDATE("Qty. to Invoice", recTempSSL.Quantity);
                                            END;
                                            recSL.MODIFY;
                                        END;
                                    END;
                                UNTIL recTempSSL.NEXT = 0;
                        END;
                    END;
                END;
            UNTIL recTempSSH.NEXT = 0;
        END;


        Win.CLOSE;

    end;

    var
        recSH: Record "Sales Header";
        recTempSSH: Record "Sales Shipment Header Temp";
        Win: Dialog;
        recCustomer: Record Customer;
        recSL: Record "Sales Line";
        recTempSSL: Record "Sales Shipment Line temp";
        RecItem: Record Item;
}

