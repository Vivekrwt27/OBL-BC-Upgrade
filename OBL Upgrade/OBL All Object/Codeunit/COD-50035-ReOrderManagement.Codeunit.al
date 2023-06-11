codeunit 50035 "Re-Order Management"
{

    trigger OnRun()
    begin
        ProcessReOrderLevel;
        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        TempIndentCalculation: Record "Location-Item Wise Reorder Lvl" temporary;
        TempLocCode: Code[20];
        LineNo: Integer;
        RecItem: Record Item;


    procedure ProcessReOrderLevel()
    var
        LocItemReorderLevel: Record "Location-Item Wise Reorder Lvl";
        IndentNo: Code[20];
    begin
        LocItemReorderLevel.RESET;
        IF LocItemReorderLevel.FINDFIRST THEN BEGIN
            REPEAT
                LocItemReorderLevel.CALCFIELDS("Qty. on Purchase Order", LocItemReorderLevel."Qty. on Indent Lines", LocItemReorderLevel.Inventory);
                IF LocItemReorderLevel."Min. Qty." >= (LocItemReorderLevel."Qty. on Purchase Order" + LocItemReorderLevel."Qty. on Indent Lines" + LocItemReorderLevel.Inventory) THEN BEGIN

                    TempIndentCalculation.INIT;
                    TempIndentCalculation.TRANSFERFIELDS(LocItemReorderLevel);
                    TempIndentCalculation."Max. Reorder Level" := (LocItemReorderLevel."Max. Reorder Level" -
                    (LocItemReorderLevel."Qty. on Purchase Order" + LocItemReorderLevel."Qty. on Indent Lines" + LocItemReorderLevel.Inventory));

                    IF RecItem.GET(TempIndentCalculation."Item No.") THEN
                        IF (RecItem.Blocked = FALSE) THEN
                            TempIndentCalculation.INSERT;
                END;
            UNTIL LocItemReorderLevel.NEXT = 0;
        END;
        TempIndentCalculation.RESET;
        TempIndentCalculation.SETFILTER(TempIndentCalculation."Max. Reorder Level", '>%1', 0);
        IF TempIndentCalculation.FINDFIRST THEN BEGIN
            REPEAT
                IF TempLocCode <> TempIndentCalculation."Location Code" THEN BEGIN
                    CreateIndentHeader(TempIndentCalculation."Location Code", IndentNo);
                    TempLocCode := TempIndentCalculation."Location Code";
                    LineNo := 10000;
                END;

                CreateIndentLine(IndentNo, TempIndentCalculation."Location Code", TempIndentCalculation."Item No.", TempIndentCalculation."Max. Reorder Level");
                LineNo += 10000;
            UNTIL TempIndentCalculation.NEXT = 0;
        END;
    end;


    procedure CreateIndentHeader(LocCode: Code[20]; var IndentNo: Code[20])
    var
        IndentHeader: Record "Indent Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchPayable: Record "Purchases & Payables Setup";
        RecLocation: Record Location;
    begin
        IndentHeader.INIT;
        PurchPayable.GET;
        PurchPayable.TESTFIELD(PurchPayable."Auto Indent No. Series");

        NoSeriesMgt.InitSeries(PurchPayable."Auto Indent No. Series", IndentHeader."No. Series", TODAY, IndentHeader."No.", IndentHeader."No. Series");
        IndentHeader."Indent Date" := TODAY;
        IndentHeader.VALIDATE("Location Code", LocCode);
        IndentHeader.VALIDATE("Indent Date", WORKDATE);
        IndentHeader."Auto Indent" := TRUE;
        RecLocation.GET(LocCode);
        RecLocation.TESTFIELD("Auto Indent Creation ID");

        /*
          CASE LocCode OF
          'SKD-STORE':
            IndentHeader.VALIDATE("User ID",'PU003');
          'DRA-STORE':
            IndentHeader.VALIDATE("User ID",'BDRAPU001');
          'HSK-STORE':
            IndentHeader.VALIDATE("User ID",'BHKPUC008');
            ELSE
            IndentHeader.VALIDATE("User ID",USERID);
          END;
          */
        IndentHeader.VALIDATE("User ID", RecLocation."Auto Indent Creation ID");
        IndentHeader.Description := 'Auto Indent';
        IndentHeader.VALIDATE(Status, IndentHeader.Status::Open);

        IndentHeader.INSERT;
        IndentNo := IndentHeader."No.";

    end;


    procedure CreateIndentLine(var IndentNo: Code[20]; LocCode: Code[20]; ItemNo: Code[20]; Qty: Decimal)
    var
        IndentLine: Record "Indent Line";
    begin
        IndentLine.INIT;
        IndentLine."Document No." := IndentNo;
        IndentLine."Line No." := LineNo;
        IndentLine.Type := IndentLine.Type::Item;
        IndentLine.VALIDATE("No.", ItemNo);
        IndentLine.VALIDATE(Quantity, Qty);
        IndentLine.VALIDATE("Location Code", LocCode);
        IndentLine.INSERT(TRUE);
    end;
}

