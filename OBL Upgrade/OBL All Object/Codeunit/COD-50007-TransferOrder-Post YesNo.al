codeunit 50007 TransferOrderPostYesNo
{
    procedure PostConsumption(TrsferLine: Record "Transfer Line")
    begin
        IF (TrsferLine."End Use Item") THEN BEGIN //and (TrsferLine."Qty. to Receive (Base)" <> 0) THEN BEGIN
            PostDirectConsumption(TrsferLine);
        END;
    end;

    procedure PostDirectConsumption(TrferLine: Record "Transfer Line")
    var
        RecLocation: Record Location;
        RecItemJournalLine, itemJnlLine2 : Record "Item Journal Line";
        RecTransferHeader: Record "Transfer Header";
    begin
        //MSAK.BEGIN 070515
        //IF (TrferLine."Transfer-from Code" = 'HSK-STORE') OR (TrferLine."Transfer-from Code" = 'DRA-STORE') THEN
        // EXIT;
        //MSAK.END 070515

        Clear(RecTransferHeader);
        RecTransferHeader.Get(TrferLine."Document No.");

        IF RecLocation.GET(TrferLine."Transfer-to Code") THEN BEGIN
            RecLocation.TESTFIELD(RecLocation."End Use Item Issue Batch");
            RecLocation.TESTFIELD("End Use Item Issue Template");
            itemJnlLine2.LOCKTABLE(TRUE, FALSE); //MSAK030215 Kulbhushan
            itemJnlLine2.INIT;
            // itemJnlLine2.TRANSFERFIELDS(ItemJournalLine);
            itemJnlLine2."Journal Template Name" := RecLocation."End Use Item Issue Template";
            itemJnlLine2."Journal Batch Name" := RecLocation."End Use Item Issue Batch";
            itemJnlLine2."Entry Type" := itemJnlLine2."Entry Type"::"Negative Adjmt.";
            itemJnlLine2."Document No." := TrferLine."Document No.";
            IF RecTransferHeader."Receipt Date" <> 0D THEN
                itemJnlLine2."Posting Date" := RecTransferHeader."Posting Date"
            ELSE
                itemJnlLine2."Posting Date" := WORKDATE;
            itemJnlLine2.VALIDATE("Item No.", TrferLine."Item No.");
            itemJnlLine2."Line No." := GetTranfLine(RecLocation."End Use Item Issue Template", RecLocation."End Use Item Issue Batch");

            //itemJnlLine2.VALIDATE(Quantity, TrferLine.Quantity); 

            //itemJnlLine2.VALIDATE(Quantity, TrferLine."Qty. to Receive"); //Code commented by TEAM 14763

            itemJnlLine2.VALIDATE(Quantity, TrferLine."Quantity Received"); //TEAM 14763

            itemJnlLine2.VALIDATE("Shortcut Dimension 1 Code", TrferLine."Shortcut Dimension 1 Code");
            itemJnlLine2.VALIDATE("Shortcut Dimension 2 Code", TrferLine."Shortcut Dimension 2 Code");
            itemJnlLine2.VALIDATE("End Use Item", TrferLine."End Use Item");
            itemJnlLine2."Capex No." := TrferLine."Capex No.";//MSBS.Rao 081114
            itemJnlLine2."Location Code" := TrferLine."Transfer-to Code";
            itemJnlLine2."External Document No." := TrferLine."Document No.";
            itemJnlLine2."Direct Consumption Entries" := TrferLine."End Use Item";
            itemJnlLine2."Gen. Bus. Posting Group" := 'CONSUMTION';//MSAK291014
            itemJnlLine2.INSERT();

            itemJnlLine2.VALIDATE("Item No.");
            //RecItem.get(itemJnlLine2."Item No.");
            //itemJnlLine2."Unit Cost" := RecItem."Last Direct Cost";//MSBS.Rao 121114
            itemJnlLine2.VALIDATE("Shortcut Dimension 1 Code", TrferLine."Shortcut Dimension 1 Code");
            itemJnlLine2.VALIDATE("Shortcut Dimension 2 Code", TrferLine."Shortcut Dimension 2 Code");//MSBS.Rao 081114
            itemJnlLine2.MODIFY;

            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", itemJnlLine2);//MSBS.Rao Code Commited on 290914 //Open by TEAM 14763
        END;
    end;

    procedure GetTranfLine(Template: Code[20]; Batch: Code[20]): Integer
    var
        ItemJrnlLine: Record "Item Journal Line";
    begin
        ItemJrnlLine.RESET;
        ItemJrnlLine.SETRANGE("Journal Template Name", Template);
        ItemJrnlLine.SETRANGE("Journal Batch Name", Batch);
        IF ItemJrnlLine.FINDLAST THEN
            EXIT(ItemJrnlLine."Line No." + 10000) ELSE
            EXIT(10000);
    end;
}