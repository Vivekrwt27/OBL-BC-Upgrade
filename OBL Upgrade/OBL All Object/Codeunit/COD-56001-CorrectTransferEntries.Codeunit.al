codeunit 56001 "Correct Transfer Entries"
{
    // //New Field In Transfer Shipment Table (5744)
    // //Field  50032 - Batch Executed (Boolean)
    // //Tri P.G This Field Identified that the batch for this shipment has been executed or not
    // 
    // //New Field In Transfer Shipment Table (5744)
    // //Field  50033 - Transfer Receipt No. (Code 20)
    // //Tri P.G This Field Capture the Identified Coresponding Receipt No.


    trigger OnRun()
    begin
        // -- delete Gen. Jou. Line
        /*recGenJournl.RESET;
        recGenJournl.SETFILTER("Journal Template Name",'GENERAL');
        recGenJournl.SETFILTER("Journal Batch Name",'CORREC2');
        IF recGenJournl.FIND('-') THEN recGenJournl.DELETEALL;
        */
        //-- delete Gen. Jou. Line


        //-- Uncomment Below Line To Execute The Batch
        //gStartDate := 010406D;
        //gEndDate   := 111106D;

        LINENO := 0;
        //LINENO := 886320000;
        Window.OPEN(Text001);


        recTranShpHead.RESET;
        recTranShpHead.SETCURRENTKEY("Posting Date");
        recTranShpHead.SETRANGE("Posting Date", gStartDate, gEndDate);
        recTranShpHead.SETRANGE("Batch Executed", FALSE);
        IF recTranShpHead.FIND('-') THEN BEGIN
            Window.UPDATE(2, recTranShpHead.COUNT);
            REPEAT
                varCtr := varCtr + 1;
                Window.UPDATE(1, varCtr);
                Window.UPDATE(3, ROUND((varCtr / recTranShpHead.COUNT) * 100, 1, '='));
                Window.UPDATE(4, recTranShpHead."No.");
                varFind := FALSE;
                recTranRecHead.RESET;
                recTranRecHead.SETCURRENTKEY("Transfer Order No.");
                recTranRecHead.SETFILTER("Transfer Order No.", recTranShpHead."Transfer Order No.");
                IF recTranRecHead.FIND('-') THEN BEGIN
                    REPEAT
                        IF varFind = FALSE THEN BEGIN
                            varYesCount := 0;
                            recTranShpLine.RESET;
                            recTranShpLine.SETCURRENTKEY("Document No.", "Line No.");
                            recTranShpLine.SETFILTER("Document No.", recTranShpHead."No.");
                            IF recTranShpLine.FIND('-') THEN BEGIN
                                REPEAT
                                    recTranRecLine.RESET;
                                    recTranRecLine.SETCURRENTKEY("Document No.", "Item No.");
                                    recTranRecLine.SETFILTER("Document No.", recTranRecHead."No.");
                                    recTranRecLine.SETFILTER("Item No.", recTranShpLine."Item No.");
                                    recTranRecLine.SETFILTER(Quantity, '=%1', recTranShpLine.Quantity);
                                    IF recTranRecLine.FIND('-') THEN BEGIN
                                        varYesCount := varYesCount + 1;
                                    END;
                                UNTIL recTranShpLine.NEXT = 0;
                                IF recTranShpLine.COUNT = varYesCount THEN BEGIN
                                    varFind := TRUE;
                                    //*****************************
                                    CreateGeneralJournal(recTranShpHead."No.", recTranRecHead."No."
                                                        , recTranShpHead."Transfer-from Code"
                                                        , recTranShpHead."Transfer-to Code");
                                    //*****************************
                                    varOk := varOk + 1;
                                    Window.UPDATE(5, varOk);
                                    Window.UPDATE(6, ROUND((varOk / recTranShpHead.COUNT) * 100, 1, '='));
                                    recTranShpHead."Batch Executed" := TRUE;
                                    recTranShpHead."Transfer Receipt No." := recTranRecHead."No.";
                                    recTranShpHead.MODIFY;
                                    //*******************
                                    //Explicit Commit Call
                                    COMMIT;
                                    //*******************
                                END;
                            END;
                        END;
                    UNTIL recTranRecHead.NEXT = 0;
                END;
            UNTIL recTranShpHead.NEXT = 0;
        END;
        MESSAGE('SHIPMENT VOUCHER ENTRIES CREATED');
        // 15578  Window.INPUT();
        Window.CLOSE;


        //--------------------------------------------------------------------------------------------
        //-- CORRECT TRANSFER RECEIPT ENTRIES
        //-- MAKE CORREC2 VOUCHER TO LOAD ALL AMOUNT IN "51030000 -- Goods Sent / Recd. on Consgn."
        //-- TO "61011000 -- Direct Cost Applied (Purchase)"
        //--------------------------------------------------------------------------------------------
        /*
        varCtr := 0;
        Window.OPEN(Text001);
        recTranRecHead.RESET;
        recTranRecHead.SETCURRENTKEY("Posting Date");
        recTranRecHead.SETRANGE("Posting Date",gStartDate,gEndDate);
        IF recTranRecHead.FIND('-') THEN
        BEGIN
            Window.UPDATE(2,recTranRecHead.COUNT);
            REPEAT
                varCtr := varCtr + 1;
                Window.UPDATE(1,varCtr);
                Window.UPDATE(3,ROUND((varCtr/recTranRecHead.COUNT) * 100,1,'='));
                Window.UPDATE(4,recTranRecHead."No.");
        
                recLedgerEntry.RESET;
                recLedgerEntry.SETCURRENTKEY("Document No.","G/L Account No.");
                recLedgerEntry.SETFILTER("Document No.",recTranRecHead."No.");
                recLedgerEntry.SETFILTER("G/L Account No.",'51030000');
                IF recLedgerEntry.FIND ('-') THEN
                BEGIN
                    REPEAT
                        LINENO := LINENO + 10000;
                        Window.UPDATE(7,LINENO/10000);
                        //-- INSERT JOURNAL LINE
                        recGenJournl.INIT;
                        recGenJournl.VALIDATE("Journal Template Name",'GENERAL');
                        recGenJournl.VALIDATE("Journal Batch Name",'CORREC2');
                        recGenJournl.VALIDATE("Line No.",LINENO);
                        recGenJournl.VALIDATE("Account Type",recGenJournl."Account Type"::"G/L Account");
                        recGenJournl.VALIDATE("Account No.",recLedgerEntry."G/L Account No.");
                        recGenJournl.VALIDATE("Posting Date",recLedgerEntry."Posting Date");
                        recGenJournl.VALIDATE("Document Type",recGenJournl."Document Type"::" ");
                        recGenJournl.VALIDATE("Document No.",recLedgerEntry."Document No.");
                        recGenJournl.VALIDATE(Amount,-1*recLedgerEntry.Amount);
                        recGenJournl.VALIDATE(Description,'Transfer CORREC2 - ' + recTranRecHead."No.");
                        recGenJournl.VALIDATE("Location Code",recTranRecHead."Transfer-to Code");
                        recGenJournl.INSERT;
        
                        recGenJournl.INIT;
                        recGenJournl.VALIDATE("Journal Template Name",'GENERAL');
                        recGenJournl.VALIDATE("Journal Batch Name",'CORREC2');
                        recGenJournl.VALIDATE("Line No.",LINENO + 10000);
                        recGenJournl.VALIDATE("Account Type",recGenJournl."Account Type"::"G/L Account");
                        recGenJournl.VALIDATE("Account No.",'61011000');
                        recGenJournl.VALIDATE("Posting Date",recLedgerEntry."Posting Date");
                        recGenJournl.VALIDATE("Document Type",recGenJournl."Document Type"::" ");
                        recGenJournl.VALIDATE("Document No.",recLedgerEntry."Document No.");
                        recGenJournl.VALIDATE(Amount,recLedgerEntry.Amount);
                        recGenJournl.VALIDATE(Description,'Transfer CORREC2 - ' + recTranRecHead."No.");
                        recGenJournl.VALIDATE("Location Code",recTranRecHead."Transfer-to Code");
                        recGenJournl.INSERT;
        
                        //-- INSERT JOURNAL LINE DIMENSION
                        recLedgerEntryDim.RESET;
                        recLedgerEntryDim.SETCURRENTKEY("Table ID","Entry No.","Dimension Code");
                        recLedgerEntryDim.SETRANGE("Table ID",17);
                        recLedgerEntryDim.SETRANGE("Entry No.",recLedgerEntry."Entry No.");
                        IF recLedgerEntryDim.FIND('-') THEN
                        BEGIN
                            REPEAT
                                recJournlDim.RESET;
                                recJournlDim.SETCURRENTKEY(
                             "Table ID","Journal Template Name","Journal Batch Name","Journal Line No.","Allocation Line No.","Dimension Cod
        e"
                                );
                                recJournlDim.SETRANGE("Table ID",81);
                                recJournlDim.SETFILTER("Journal Template Name",'GENERAL');
                                recJournlDim.SETFILTER("Journal Batch Name",'CORREC2');
                                recJournlDim.SETRANGE("Journal Line No.",LINENO);
                                recJournlDim.SETFILTER("Dimension Code",recLedgerEntryDim."Dimension Code");
                                IF recJournlDim.FIND('-') THEN recJournlDim.DELETEALL;
                                recJournlDim.INIT;
                                recJournlDim.VALIDATE("Table ID",81);
                                recJournlDim.VALIDATE("Journal Template Name",'GENERAL');
                                recJournlDim.VALIDATE("Journal Batch Name",'CORREC2');
                                recJournlDim.VALIDATE("Journal Line No.",LINENO);
                                recJournlDim.VALIDATE("Dimension Code",recLedgerEntryDim."Dimension Code");
                                recJournlDim.VALIDATE("Dimension Value Code",recLedgerEntryDim."Dimension Value Code");
                                recJournlDim.INSERT;
        
        
                                recJournlDim.RESET;
                                recJournlDim.SETCURRENTKEY(
                             "Table ID","Journal Template Name","Journal Batch Name","Journal Line No.","Allocation Line No.","Dimension Cod
        e"
                                );
        
                                recJournlDim.SETRANGE("Table ID",81);
                                recJournlDim.SETFILTER("Journal Template Name",'GENERAL');
                                recJournlDim.SETFILTER("Journal Batch Name",'CORREC2');
                                recJournlDim.SETRANGE("Journal Line No.",LINENO + 10000);
                                recJournlDim.SETFILTER("Dimension Code",recLedgerEntryDim."Dimension Code");
                                IF recJournlDim.FIND('-') THEN recJournlDim.DELETEALL;
                                recJournlDim.INIT;
                                recJournlDim.VALIDATE("Table ID",81);
                                recJournlDim.VALIDATE("Journal Template Name",'GENERAL');
                                recJournlDim.VALIDATE("Journal Batch Name",'CORREC2');
                                recJournlDim.VALIDATE("Journal Line No.",LINENO + 10000);
                                recJournlDim.VALIDATE("Dimension Code",recLedgerEntryDim."Dimension Code");
                                recJournlDim.VALIDATE("Dimension Value Code",recLedgerEntryDim."Dimension Value Code");
                                recJournlDim.INSERT;
                            UNTIL recLedgerEntryDim.NEXT = 0;
                        END;
                        LINENO := LINENO + 10000;
                        COMMIT;
                    UNTIL recLedgerEntry.NEXT = 0;
                END;
            UNTIL recTranRecHead.NEXT = 0;
        END;
        MESSAGE('RECEIPT VOUCHER ENTRIES CREATED');
         */

        //--------------------------------------------------------------------------------------------

    end;

    var
        recTranRecHead: Record "Transfer Receipt Header";
        recTranRecLine: Record "Transfer Receipt Line";
        recTranShpHead: Record "Transfer Shipment Header";
        recTranShpLine: Record "Transfer Shipment Line";
        recLedgerEntry: Record "G/L Entry";
        recGenJournl: Record "Gen. Journal Line";
        gStartDate: Date;
        gEndDate: Date;
        varFind: Boolean;
        varYesCount: Integer;
        Window: Dialog;
        Text001: Label 'Please Wait ...!\Current Rec  #1####################\Total        #2####################\Status %     #3####################\Ship No.     #4####################\Batch Ok     #5####################\Batch Ok %   #6####################\LINE NO      #7####################\';
        varCtr: Integer;
        varOk: Integer;
        LINENO: Integer;


    procedure CreateGeneralJournal("Shipment No.": Code[20]; "Receipt No.": Code[20]; "From Code": Code[10]; "To Code": Code[10])
    begin
        //recGenJournl.LOCKTABLE;
        //recJournlDim.LOCKTABLE;


        //-- REVERSE SHIPMENT ENTRY

        recLedgerEntry.RESET;
        recLedgerEntry.SETCURRENTKEY("Document No.", "G/L Account No.");
        recLedgerEntry.SETFILTER("Document No.", "Shipment No.");
        recLedgerEntry.SETFILTER("G/L Account No.", '%1|%2', '21226000', '51015000');
        IF recLedgerEntry.FIND('-') THEN BEGIN
            REPEAT
                LINENO := LINENO + 10000;
                Window.UPDATE(7, LINENO / 10000);
                //-- INSERT JOURNAL LINE
                recGenJournl.INIT;
                recGenJournl.VALIDATE("Journal Template Name", 'GENERAL');
                recGenJournl.VALIDATE("Journal Batch Name", 'CORREC2');
                recGenJournl.VALIDATE("Line No.", LINENO);
                recGenJournl.VALIDATE("Account Type", recGenJournl."Account Type"::"G/L Account");
                recGenJournl.VALIDATE("Account No.", recLedgerEntry."G/L Account No.");
                recGenJournl.VALIDATE("Posting Date", recLedgerEntry."Posting Date");
                recGenJournl.VALIDATE("Document Type", recGenJournl."Document Type"::" ");
                recGenJournl.VALIDATE("Document No.", "Shipment No.");
                recGenJournl.VALIDATE(Amount, -1 * recLedgerEntry.Amount);
                //   recGenJournl.VALIDATE(Narration, 'Transfer CORREC2 - ' + "Shipment No.");
                recGenJournl.VALIDATE("Location Code", "From Code");
                recGenJournl.INSERT;


            //-- INSERT JOURNAL LINE DIMENSION
            /*
            recLedgerEntryDim.RESET;
            recLedgerEntryDim.SETCURRENTKEY("Table ID","Entry No.","Dimension Code");
            recLedgerEntryDim.SETRANGE("Table ID",17);
            recLedgerEntryDim.SETRANGE("Entry No.",recLedgerEntry."Entry No.");
            IF recLedgerEntryDim.FIND('-') THEN
            BEGIN
                REPEAT
                    recJournlDim.RESET;
                            recJournlDim.SETCURRENTKEY(
                       "Table ID","Journal Template Name","Journal Batch Name","Journal Line No.","Allocation Line No.",
    "Dimension Code"
                            );

                    recJournlDim.SETRANGE("Table ID",81);
                    recJournlDim.SETFILTER("Journal Template Name",'GENERAL');
                    recJournlDim.SETFILTER("Journal Batch Name",'CORREC2');
                    recJournlDim.SETRANGE("Journal Line No.",LINENO);
                    recJournlDim.SETFILTER("Dimension Code",recLedgerEntryDim."Dimension Code");
                    IF recJournlDim.FIND('-') THEN recJournlDim.DELETEALL;

                    recJournlDim.INIT;
                    recJournlDim.VALIDATE("Table ID",81);
                    recJournlDim.VALIDATE("Journal Template Name",'GENERAL');
                    recJournlDim.VALIDATE("Journal Batch Name",'CORREC2');
                    recJournlDim.VALIDATE("Journal Line No.",LINENO);
                    recJournlDim.VALIDATE("Dimension Code",recLedgerEntryDim."Dimension Code");
                    recJournlDim.VALIDATE("Dimension Value Code",recLedgerEntryDim."Dimension Value Code");
                    recJournlDim.INSERT;
                UNTIL recLedgerEntryDim.NEXT = 0;
            END;  */ //code blocked for upgrade  //Table 356 not available
            UNTIL recLedgerEntry.NEXT = 0;
        END;



        // -- CREATE SHIPMENT ENTRY FROM RECEIPT ENTRY

        recLedgerEntry.RESET;
        recLedgerEntry.SETCURRENTKEY("Document No.", "G/L Account No.");
        recLedgerEntry.SETFILTER("Document No.", "Receipt No.");
        recLedgerEntry.SETFILTER("G/L Account No.", '%1|%2', '21226000', '51015000');
        IF recLedgerEntry.FIND('-') THEN BEGIN
            REPEAT
                LINENO := LINENO + 10000;
                Window.UPDATE(7, LINENO / 10000);
                //-- INSERT JOURNAL LINE
                recGenJournl.INIT;
                recGenJournl.VALIDATE("Journal Template Name", 'GENERAL');
                recGenJournl.VALIDATE("Journal Batch Name", 'CORREC2');
                recGenJournl.VALIDATE("Line No.", LINENO);
                recGenJournl.VALIDATE("Account Type", recGenJournl."Account Type"::"G/L Account");
                recGenJournl.VALIDATE("Account No.", recLedgerEntry."G/L Account No.");
                recGenJournl.VALIDATE("Posting Date", recLedgerEntry."Posting Date");
                recGenJournl.VALIDATE("Document Type", recGenJournl."Document Type"::" ");
                recGenJournl.VALIDATE("Document No.", "Shipment No.");
                recGenJournl.VALIDATE(Amount, -1 * recLedgerEntry.Amount);
                //    recGenJournl.VALIDATE(Narration, 'Transfer CORREC2 - ' + "Shipment No.");
                recGenJournl.VALIDATE("Location Code", "From Code");
                recGenJournl.INSERT;


            //-- INSERT JOURNAL LINE DIMENSION
            /*recLedgerEntryDim.RESET;
            recLedgerEntryDim.SETCURRENTKEY("Table ID","Entry No.","Dimension Code");
            recLedgerEntryDim.SETRANGE("Table ID",17);
            recLedgerEntryDim.SETRANGE("Entry No.",recLedgerEntry."Entry No.");
            IF recLedgerEntryDim.FIND('-') THEN
            BEGIN
                REPEAT
                    recJournlDim.RESET;
                            recJournlDim.SETCURRENTKEY(
                       "Table ID","Journal Template Name","Journal Batch Name","Journal Line No.","Allocation Line No.",
    "Dimension Code"
                            );
                    recJournlDim.SETRANGE("Table ID",81);
                    recJournlDim.SETFILTER("Journal Template Name",'GENERAL');
                    recJournlDim.SETFILTER("Journal Batch Name",'CORREC2');
                    recJournlDim.SETRANGE("Journal Line No.",LINENO);
                    recJournlDim.SETFILTER("Dimension Code",recLedgerEntryDim."Dimension Code");
                    IF recJournlDim.FIND('-') THEN recJournlDim.DELETEALL;

                    recJournlDim.INIT;
                    recJournlDim.VALIDATE("Table ID",81);
                    recJournlDim.VALIDATE("Journal Template Name",'GENERAL');
                    recJournlDim.VALIDATE("Journal Batch Name",'CORREC2');
                    recJournlDim.VALIDATE("Journal Line No.",LINENO);
                    recJournlDim.VALIDATE("Dimension Code",recLedgerEntryDim."Dimension Code");

                    IF (recLedgerEntry."G/L Account No." = '51015000')
                    AND(recLedgerEntryDim."Dimension Code" = 'BRANCH')
                    AND(recLedgerEntryDim."Dimension Value Code" = "To Code") THEN
                        recJournlDim.VALIDATE("Dimension Value Code","From Code")
                    ELSE
                        recJournlDim.VALIDATE("Dimension Value Code",recLedgerEntryDim."Dimension Value Code");

                    recJournlDim.INSERT;
                UNTIL recLedgerEntryDim.NEXT = 0;
            END;*///Code blocked for upgrade // table 356 not available

            UNTIL recLedgerEntry.NEXT = 0;
        END;

    end;
}

