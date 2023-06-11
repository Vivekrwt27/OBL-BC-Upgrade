codeunit 50019 "IC Transfer - In"
{
    TableNo = "IC Header";

    trigger OnRun()
    begin
    end;

    var
        Text50000: Label 'From Location and To Location Cannot be Same';
        Text50001: Label 'Do you want to Receive';
        ICHeader: Record "IC Header";
        ICLine: Record "IC Line";
        Text50002: Label 'Document No. %1 Posted';
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        CompInfo: Record "Company Information";


    procedure InsertReceipt(ICHeader: Record "IC Header")
    begin
        IF CONFIRM(Text50001) THEN BEGIN
            InsertICInHeader(ICHeader);
            ICLine.RESET;
            ICLine.SETRANGE(ICLine."Document No.", ICHeader."No.");
            IF ICLine.FINDFIRST THEN
                REPEAT
                    InsertICInLine(ICLine);
                UNTIL ICLine.NEXT = 0;
        END;
        DeleteItemJournalLine;
        InsertItemJournalLine(ICHeader);

        ICLine.RESET;
        ICLine.SETRANGE(ICLine."Document No.", ICHeader."No.");
        IF ICLine.FINDSET THEN
            REPEAT
                ICLine.DELETE(TRUE);
            UNTIL ICLine.NEXT = 0;



        ICHeader.DELETE(TRUE);

        MESSAGE(Text50002, ICHeader."No.");
    end;


    procedure InsertICInHeader(ICHeader: Record "IC Header")
    var
        ICInHeader: Record "IC In Header";
    begin
        ICInHeader.INIT;
        ICInHeader.TRANSFERFIELDS(ICHeader);
        ICInHeader.INSERT(TRUE);
    end;


    procedure InsertICInLine(ICLine: Record "IC Line")
    var
        ICInLine: Record "IC In Line";
    begin
        /*ICInLine.INIT;
        ICInLine.TRANSFERFIELDS(ICLine);
        ICInLine.INSERT(TRUE);
        */

        ICHeader.RESET;
        ICHeader.SETRANGE("No.", ICLine."Document No.");
        IF ICHeader.FINDFIRST THEN BEGIN
            ICInLine.INIT;
            ICInLine."Document Type" := ICHeader."Document Type";
            ICInLine."Document No." := ICLine."Document No.";
            ICInLine."Line No." := ICLine."Line No.";
            ICInLine."Item No." := ICLine."Item No.";
            ICInLine."Variant Code" := ICLine."Variant Code";
            ICInLine.Description := ICLine.Description;
            ICInLine."Description 2" := ICLine."Description 2";
            ICInLine.Quantity := ICLine.Quantity;
            ICInLine."From Company" := ICLine."From Company";
            ICInLine."To Company" := ICLine."To Company";
            ICInLine."From Location" := ICLine."From Location";
            ICInLine."To Location" := ICLine."To Location";
            ICInLine."Posting Date" := ICLine."Posting Date";
            ICInLine."Shortcut Dimesion 1 Code" := ICLine."Shortcut Dimension 1 Code";
            ICInLine."Shortcut Dimesion 2 Code" := ICLine."Shortcut Dimension 2 Code";
            ICInLine."Transfer Type" := ICHeader."Transfer Type";
            ICInLine."IC Gen. Bus. Posting Group" := ICLine."IC Gen. Bus. Posting Group";//MSBS.Rao Dt. 05-09-12
            ICInLine.UOM := ICLine.UOM;
            ICInLine."From Item No." := ICLine."To Item No."; //MSKS1212
            ICInLine."Item Category Code" := ICLine."Item Category Code"; //MSKS1212

            ICInLine.INSERT(TRUE);
        END;

    end;


    procedure InsertItemJournalLine(ICHeader: Record "IC Header")
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        //ItemJournalLine.CHANGECOMPANY(ICLine."To Company");
        ICLine.RESET;
        ICLine.SETRANGE(ICLine."Document No.", ICHeader."No.");
        IF ICLine.FINDFIRST THEN
            REPEAT
                ItemJournalLine.INIT;
                ItemJournalLine.VALIDATE("Journal Template Name", 'ICT');
                ItemJournalLine.VALIDATE("Journal Batch Name", 'ICT');
                ItemJournalLine.VALIDATE("Source Code", 'ITEMJNL');
                ItemJournalLine.VALIDATE("Line No.", GetLineNo);
                ItemJournalLine.VALIDATE("Document Line No.", ICLine."Line No.");
                ItemJournalLine.VALIDATE("Item No.", ICLine."Item No.");
                ItemJournalLine.VALIDATE("Variant Code", ICLine."Variant Code");
                ItemJournalLine.VALIDATE("Posting Date", ICLine."Posting Date");
                ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                ItemJournalLine.VALIDATE("Document No.", ICLine."Document No.");
                ItemJournalLine.VALIDATE("Location Code", ICLine."To Location");
                ItemJournalLine.VALIDATE(Quantity, ICLine.Quantity);
                ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", ICLine."Shortcut Dimension 1 Code");
                ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", ICLine."Shortcut Dimension 2 Code");
                ItemJournalLine.VALIDATE("Inter Company", TRUE); //MSKS
                ItemJournalLine."IC Line No." := ICLine."Line No."; //MSKS
                CompInfo.GET;//MSBS.Rao
                CompInfo.TESTFIELD("IC Gen. Bus. Posting Group");//MSBS.Rao
                ItemJournalLine.VALIDATE("Gen. Bus. Posting Group", CompInfo."IC Gen. Bus. Posting Group");//MSBS.Rao
                ItemJournalLine.INSERT(TRUE);
            UNTIL ICLine.NEXT = 0;
        //ItemJournalLine.DELETE(TRUE);
        //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItemJournalLine);
        //InsertItemJournalLine(ItemJournalLine)

        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);
    end;


    procedure GetLineNo() lintNextNo: Integer
    var
        recItemJnlLn2: Record "Item Journal Line";
    begin
        recItemJnlLn2.RESET;
        recItemJnlLn2.SETFILTER("Journal Template Name", 'ICT');
        recItemJnlLn2.SETFILTER("Journal Batch Name", 'ICT');
        recItemJnlLn2.SETRANGE("Source Code", 'ITEMJNL');

        IF recItemJnlLn2.FIND('+') THEN BEGIN
            lintNextNo := recItemJnlLn2."Line No." + 10000;
            EXIT(lintNextNo);
        END
        ELSE BEGIN
            lintNextNo := 10000;
            EXIT(lintNextNo);
        END;
    end;


    procedure DeleteItemJournalLine()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", 'ICT');
        ItemJournalLine.SETRANGE("Journal Batch Name", 'ICT');
        ItemJournalLine.SETRANGE("Source Code", 'ITEMJNL');
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETEALL;
    end;
}

