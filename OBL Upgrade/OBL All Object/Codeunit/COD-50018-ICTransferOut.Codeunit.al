codeunit 50018 "IC Transfer - Out"
{

    trigger OnRun()
    begin
    end;

    var
        Text50000: Label 'From Location and To Location Cannot be Same';
        Text50001: Label 'Do you want to Transfer';
        ICHeader: Record "IC Header";
        ICLine: Record "IC Line";
        Text50002: Label 'Document No. %1 Posted';
        Text50003: Label 'Do you want to Receive';
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        CompInfo: Record "Company Information";


    procedure InsertOut(ICHeader: Record "IC Header")
    begin
        IF CONFIRM(Text50001) THEN BEGIN
            InsertICOutHeader(ICHeader);
            DeleteItemJournalLine;
            ICLine.RESET;
            ICLine.SETRANGE(ICLine."Document No.", ICHeader."No.");
            IF ICLine.FINDFIRST THEN BEGIN
                REPEAT
                    InsertICOutLine(ICLine);
                    InsertItemJournalLine(ICLine);
                UNTIL ICLine.NEXT = 0;
            END;

            PostItemJournal;
            CreateInHeader(ICHeader);

            ICLine.RESET;
            ICLine.SETRANGE(ICLine."Document No.", ICHeader."No.");
            IF ICLine.FINDSET THEN
                REPEAT
                    ICLine.DELETE(TRUE);
                UNTIL ICLine.NEXT = 0;
            ICHeader.DELETE(TRUE);
        END;

        MESSAGE(Text50002, ICHeader."No.");
    end;


    procedure InsertICOutHeader(ICHeader: Record "IC Header")
    var
        ICOutHeader: Record "IC Out Header";
    begin
        ICOutHeader.INIT;
        ICOutHeader.TRANSFERFIELDS(ICHeader);
        ICOutHeader.INSERT(TRUE);
    end;


    procedure InsertICOutLine(ICLine: Record "IC Line")
    var
        ICOutLine: Record "IC Out Line";
        ICHeader: Record "IC Header";
    begin

        ICHeader.RESET;
        ICHeader.SETRANGE("No.", ICLine."Document No.");
        IF ICHeader.FINDFIRST THEN BEGIN
            ICOutLine.INIT;
            ICOutLine."Document Type" := ICHeader."Document Type";
            ICOutLine."Document No." := ICLine."Document No.";
            ICOutLine."Line No." := ICLine."Line No.";
            ICOutLine."Item No." := ICLine."Item No.";
            ICOutLine."Variant Code" := ICLine."Variant Code";
            ICOutLine.Description := ICLine.Description;
            ICOutLine."Description 2" := ICLine."Description 2";
            IF NOT CheckInventory(ICLine."Item No.", ICHeader."From Location", ICLine.Quantity) THEN
                ERROR('Not in Inventory %1', ICLine."Item No.");
            ICOutLine.Quantity := ICLine.Quantity;
            ICOutLine."From Company" := ICHeader."From Company";
            ICOutLine."To Company" := ICHeader."To Company";
            ICOutLine."From Location" := ICHeader."From Location";
            ICOutLine."To Location" := ICHeader."To Location";
            ICOutLine."Posting Date" := ICHeader."Posting Date";
            ICOutLine."Shortcut Dimension 1 Code" := ICHeader."Shortcut Dimension 1 Code";
            ICOutLine."Shortcut Dimension 2 Code" := ICHeader."Shortcut Dimension 2 Code";
            ICOutLine."Transfer Type" := ICHeader."Transfer Type";
            ICOutLine."IC Gen. Bus. Posting Group" := ICHeader."IC Gen. Bus. Posting Group";//MSBS.Rao Dt. 05-09-12
            ICOutLine.UOM := ICLine.UOM;
            ICOutLine."Item Category Code" := ICLine."Item Category Code";
            ICOutLine.INSERT(TRUE);
        END;
    end;


    procedure InsertItemJournalLine(ICLine: Record "IC Line")
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.INIT;
        ItemJournalLine.VALIDATE("Journal Template Name", 'ICT');
        ItemJournalLine.VALIDATE("Journal Batch Name", 'ICT');
        ItemJournalLine.VALIDATE("Source Code", 'ITEMJNL');
        ItemJournalLine.VALIDATE("Line No.", GetLineNo);
        ItemJournalLine.VALIDATE("Document Line No.", ICLine."Line No.");
        ItemJournalLine.VALIDATE("Item No.", ICLine."Item No.");
        ItemJournalLine.VALIDATE("Variant Code", ICLine."Variant Code");
        ItemJournalLine.VALIDATE("Posting Date", ICLine."Posting Date");
        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
        ItemJournalLine.VALIDATE("Document No.", ICLine."Document No.");
        ItemJournalLine.VALIDATE("Location Code", ICLine."To Location");
        ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", ICLine."Shortcut Dimension 1 Code");
        ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", ICLine."Shortcut Dimension 2 Code");
        ItemJournalLine.VALIDATE(Quantity, ICLine.Quantity);
        ItemJournalLine.VALIDATE("Inter Company", TRUE);
        ItemJournalLine."IC Line No." := ICLine."Line No."; //MSKS
        CompInfo.GET;//MSBS.Rao
        CompInfo.TESTFIELD("IC Gen. Bus. Posting Group");//MSBS.Rao
        ItemJournalLine.VALIDATE("Gen. Bus. Posting Group", CompInfo."IC Gen. Bus. Posting Group");//MSBS.Rao
        ItemJournalLine.INSERT(TRUE);
    end;


    procedure PostItemJournal()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", 'ICT');
        ItemJournalLine.SETRANGE("Journal Batch Name", 'ICT');
        ItemJournalLine.SETRANGE("Source Code", 'ITEMJNL');
        IF ItemJournalLine.FINDSET THEN
            ItemJnlPostBatch.RUN(ItemJournalLine);
    end;


    procedure CreateInHeader(ICHeader1: Record "IC Header")
    var
        ICHeaderOther: Record "IC Header";
        ICLineOther: Record "IC Line";
        ICLine1: Record "IC Line";
    begin

        ICHeaderOther.RESET;
        ICHeaderOther.CHANGECOMPANY(ICHeader1."To Company");
        ICHeaderOther.INIT;
        ICHeaderOther."Transfer Type" := ICHeader1."Transfer Type"::"Transfer In";
        ICHeaderOther."Document Type" := ICHeader1."Document Type";
        ICHeaderOther."No." := ICHeader1."No.";
        ICHeaderOther."From Company" := ICHeader1."From Company";
        ICHeaderOther."To Company" := ICHeader1."To Company";
        ICHeaderOther."From Location" := ICHeader1."From Location";
        ICHeaderOther."To Location" := ICHeader1."To Location";
        ICHeaderOther."Posting Date" := ICHeader1."Posting Date";
        ICHeaderOther."Shortcut Dimension 1 Code" := ICHeader1."Shortcut Dimension 1 Code";
        ICHeaderOther."Shortcut Dimension 2 Code" := ICHeader1."Shortcut Dimension 2 Code";
        ICHeaderOther."IC Gen. Bus. Posting Group" := ICHeader1."IC Gen. Bus. Posting Group";//MSBS.Rao Dt. 05-09-12
        ICHeaderOther.INSERT(TRUE);


        ICLineOther.RESET;
        ICLineOther.CHANGECOMPANY(ICHeader1."To Company");
        ICLine1.RESET;
        ICLine1.SETRANGE("Document No.", ICHeader1."No.");
        IF ICLine1.FINDFIRST THEN BEGIN
            REPEAT
                ICLineOther."Transfer Type" := ICLine1."Transfer Type"::"Transfer In";
                ICLineOther."Document Type" := ICLine1."Document Type";
                ICLineOther."Document No." := ICLine1."Document No.";
                ICLineOther."Line No." := ICLine1."Line No.";
                ICLineOther."Item No." := ICLine1."Item No.";
                ICLineOther.Description := ICLine1.Description;
                ICLineOther.Quantity := ICLine1.Quantity;
                ICLineOther.UOM := ICLine1.UOM;
                ICLineOther."From Company" := ICLine1."From Company";
                ICLineOther."To Company" := ICLine1."To Company";
                ICLineOther."From Location" := ICLine1."From Location";
                ICLineOther."To Location" := ICLine1."To Location";
                ICLineOther."Posting Date" := ICLine1."Posting Date";
                ICLineOther."Shortcut Dimension 1 Code" := ICLine1."Shortcut Dimension 1 Code";
                ICLineOther."Shortcut Dimension 2 Code" := ICLine1."Shortcut Dimension 2 Code";
                ICLineOther."IC Gen. Bus. Posting Group" := ICLine1."IC Gen. Bus. Posting Group";//MSBS.Rao Dt. 05-09-12
                ICLineOther."Item Category Code" := ICLine1."Item Category Code"; //MSKS
                ICLineOther.INSERT(TRUE);
            UNTIL ICLine1.NEXT = 0;
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


    procedure CheckInventory(ItemCode: Code[20]; LocationCode: Code[20]; Qty: Decimal): Boolean
    var
        RecItem: Record Item;
    begin
        RecItem.RESET;
        RecItem.SETRANGE("No.", ItemCode);
        RecItem.SETRANGE("Location Filter", LocationCode);
        IF RecItem.FINDFIRST THEN BEGIN
            RecItem.CALCFIELDS(Inventory);
            IF RecItem.Inventory < Qty THEN
                EXIT(FALSE) ELSE
                EXIT(TRUE);
        END;
    end;
}

