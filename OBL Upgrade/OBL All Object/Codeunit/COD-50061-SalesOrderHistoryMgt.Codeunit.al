codeunit 50061 "Sales Order History Mgt"
{
    // DISPRES13


    trigger OnRun()
    var
        IncDecQty: Decimal;
        SalesHeader: Record "Sales Header";
        InnerSalesOrderLedgerEntry: Record "Sales Order Ledger Entry";
    begin

        LastEntryNo := GetLastEntryNo;
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER(Status, '%1|%2|%3', SalesHeader.Status::Open, SalesHeader.Status::"Pending Approval", SalesHeader.Status::"Price Approved");
        SalesHeader.SETRANGE(Deleted, FALSE);
        SalesHeader.SETFILTER(Commitment, '%1', 'No Material');
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                SalesLine.RESET;
                SalesLine.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
                SalesLine.SETFILTER("Document No.", '%1', SalesHeader."No.");
                SalesLine.SETFILTER(Quantity, '<>%1', 0);
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        OrgOrder := FALSE;
                        OrgOrder := (SalesLine."Quantity (Base)" = SalesLine."Outstanding Qty. (Base)");
                        IncDecQty := CompareSalesLine(SalesLine."Document No.", SalesLine."Line No.", SalesLine."Outstanding Qty. (Base)");
                        IF IncDecQty <> 0 THEN BEGIN
                            CreateSOLedgerEntryFromSL(SalesHeader, SalesLine, IncDecQty, TRUE);
                        END;
                    UNTIL SalesLine.NEXT = 0;
                END;
            UNTIL SalesHeader.NEXT = 0;
        COMMIT;

        SalesOrderLedgerEntry.RESET;
        //SalesOrderLedgerEntry.SETFILTER("Sales Order No.",'%1','SOGM/2021/004836');
        //SalesOrderLedgerEntry.SETFILTER("Outstanding Qty.",'>%1',0);
        IF SalesOrderLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                InnerSalesOrderLedgerEntry.RESET;
                InnerSalesOrderLedgerEntry.SETFILTER("Sales Order No.", '%1', SalesOrderLedgerEntry."Sales Order No.");
                InnerSalesOrderLedgerEntry.SETFILTER("Sales Order Line No.", '%1', SalesOrderLedgerEntry."Sales Order Line No.");
                IF InnerSalesOrderLedgerEntry.FINDLAST THEN
                    IF InnerSalesOrderLedgerEntry."Entry No." = SalesOrderLedgerEntry."Entry No." THEN BEGIN
                        IncDecQty := 0;
                        IncDecQty := CompareSalesOrderHistoryLine(SalesOrderLedgerEntry."Sales Order No.", SalesOrderLedgerEntry."Sales Order Line No.", SalesOrderLedgerEntry."Outstanding Qty.");
                        //IF (IncDecQty<>SalesOrderLedgerEntry."Outstanding Qty.") AND (IncDecQty<0) THEN BEGIN
                        IF (IncDecQty < 0) THEN BEGIN
                            CreateSOLedgerEntryFromSOE(SalesOrderLedgerEntry, IncDecQty, TRUE);
                        END;
                    END;
            UNTIL SalesOrderLedgerEntry.NEXT = 0;
        END;

        //updateSOLedgerEntries;
        UpdateSalesOrderLine;
        //IF GUIALLOWED THEN
        //MESSAGE('%1','Done');
    end;

    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        Customer: Record Customer;
        SalesOrderLedgerEntry: Record "Sales Order Ledger Entry";
        LastEntryNo: Integer;
        OrgOrder: Boolean;
        LineClosed: Boolean;

    local procedure CompareSalesLine(SONo: Code[20]; SOLineNo: Integer; OutQty: Decimal): Decimal
    var
        SalesOrderLedgerEntry1: Record "Sales Order Ledger Entry";
        SalesHeader: Record "Sales Header";
    begin
        IF SalesLine.GET(SalesLine."Document Type"::Order, SONo, SOLineNo) THEN BEGIN
            SalesOrderLedgerEntry1.RESET;
            SalesOrderLedgerEntry1.SETCURRENTKEY("Sales Order No.", "Sales Order Line No.");
            SalesOrderLedgerEntry1.SETFILTER("Sales Order No.", '%1', SONo);
            SalesOrderLedgerEntry1.SETFILTER("Sales Order Line No.", '%1', SOLineNo);
            IF SalesOrderLedgerEntry1.FINDLAST THEN BEGIN
                IF SalesOrderLedgerEntry1."Outstanding Qty." <> OutQty THEN
                    EXIT(0) // to be consider in next step
                ELSE
                    EXIT(0);
            END ELSE BEGIN
                EXIT(OutQty); //If not Exist Create SOL
            END;
        END;
    end;

    local procedure CompareSalesOrderHistoryLine(SONo: Code[20]; SOLineNo: Integer; OutQty: Decimal): Decimal
    var
        SalesOrderLedgerEntry1: Record "Sales Order Ledger Entry";
        SalesHeader: Record "Sales Header";
        SoLineQty: Decimal;
    begin
        IF SOLineNo = 0 THEN EXIT;
        IF SONo = '' THEN EXIT;
        IF OutQty <= 0 THEN EXIT;
        /*
        IF SalesHeader.GET(SalesHeader."Document Type"::Order,SONo) THEN
          IF SalesHeader.Commitment  <> 'No Material' THEN
            EXIT(-1*OutQty);
            */

        SoLineQty := 0;
        SalesOrderLedgerEntry1.RESET;
        SalesOrderLedgerEntry1.SETCURRENTKEY("Sales Order No.", "Sales Order Line No.");
        SalesOrderLedgerEntry1.SETFILTER("Sales Order No.", '%1', SONo);
        SalesOrderLedgerEntry1.SETFILTER("Sales Order Line No.", '%1', SOLineNo);
        IF SalesOrderLedgerEntry1.FINDLAST THEN BEGIN
            SoLineQty := SalesOrderLedgerEntry1."Outstanding Qty.";
            IF NOT SalesLine.GET(SalesLine."Document Type"::Order, SONo, SOLineNo) THEN
                EXIT(-1 * OutQty);
            IF OutQty < SoLineQty THEN
                EXIT(-1 * (SoLineQty - OutQty));
        END;

    end;

    local procedure CreateSOLedgerEntryFromSL(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; Qty: Decimal; BulkProcessing: Boolean)
    var
        SalesOrderLedgerEntry: Record "Sales Order Ledger Entry";
        Item: Record Item;
        Location: Record Location;
    begin
        IF NOT BulkProcessing THEN
            LastEntryNo := GetLastEntryNo;
        SalesOrderLedgerEntry.INIT;
        SalesOrderLedgerEntry."Entry No." := LastEntryNo;
        SalesOrderLedgerEntry."Sales Order No." := SalesLine."Document No.";
        SalesOrderLedgerEntry."Sales Order Line No." := SalesLine."Line No.";
        SalesOrderLedgerEntry.Type := SalesLine.Type;
        SalesOrderLedgerEntry."No." := SalesLine."No.";
        SalesOrderLedgerEntry.Quantity := Qty;
        SalesOrderLedgerEntry."Outstanding Qty." := SalesLine."Outstanding Qty. (Base)";
        IF OrgOrder THEN
            SalesOrderLedgerEntry."Posting Date" := SalesHeader."Order Date"
        ELSE
            SalesOrderLedgerEntry."Posting Date" := TODAY;
        SalesOrderLedgerEntry."Despatch Remark" := SalesHeader.Commitment;
        SalesOrderLedgerEntry."Original SO Qty" := SalesLine."Quantity (Base)";
        SalesOrderLedgerEntry."Customer No." := SalesLine."Sell-to Customer No.";
        SalesOrderLedgerEntry."Location Code" := SalesLine."Location Code";
        SalesOrderLedgerEntry."Buyer Price" := SalesLine."Buyer's Price";
        //SalesOrderLedgerEntry."Basic Value" := (((SalesLine."Line Amount" - SalesLine."Line Discount Amount") * SalesLine."Outstanding Qty. (Base)")/ SalesLine.Quantity) ;
        SalesOrderLedgerEntry."Basic Value" := SalesOrderLedgerEntry."Buyer Price" * Qty;
        //IF Location.GET(SalesHeader."Location Code") THEN
        SalesOrderLedgerEntry."Order Plant" := COPYSTR(SalesHeader."Location Code", 1, 3);
        SalesOrderLedgerEntry."Sales Person Code" := SalesLine."Salesperson Code";
        SalesOrderLedgerEntry."Order Date" := SalesHeader."Order Date";

        IF Item.GET(SalesLine."No.") THEN BEGIN
            SalesOrderLedgerEntry."Size Code" := Item."Size Code";
            SalesOrderLedgerEntry."Size Description" := Item."Size Code Desc.";
            SalesOrderLedgerEntry."Mfg Plant" := Item."Item Category Code";
            SalesOrderLedgerEntry."Default Prod. Line Code" := GetPlantCode(Item."Default Prod. Plant Code");
        END;
        SalesOrderLedgerEntry."PMT ID" := SalesHeader."PMT Code";
        SalesOrderLedgerEntry.INSERT;
        LastEntryNo += 1;
    end;

    local procedure GetLastEntryNo(): Integer
    var
        SalesOrderLedgerEntry: Record "Sales Order Ledger Entry";
    begin
        SalesOrderLedgerEntry.RESET;
        IF SalesOrderLedgerEntry.FINDLAST THEN
            EXIT(SalesOrderLedgerEntry."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    local procedure CreateSOLedgerEntryFromSOE(SOLedgerEntry: Record "Sales Order Ledger Entry"; Qty: Decimal; BulkProcessing: Boolean)
    var
        SalesOrderLedgerEntry: Record "Sales Order Ledger Entry";
        Location: Record Location;
    begin
        IF NOT BulkProcessing THEN
            LastEntryNo := GetLastEntryNo;
        SalesOrderLedgerEntry.INIT;
        SalesOrderLedgerEntry."Entry No." := LastEntryNo;
        SalesOrderLedgerEntry."Sales Order No." := SOLedgerEntry."Sales Order No.";
        SalesOrderLedgerEntry."Sales Order Line No." := SOLedgerEntry."Sales Order Line No.";
        SalesOrderLedgerEntry.Type := SOLedgerEntry.Type;
        SalesOrderLedgerEntry."No." := SOLedgerEntry."No.";
        SalesOrderLedgerEntry.Quantity := Qty;
        SalesOrderLedgerEntry."Outstanding Qty." := SOLedgerEntry."Outstanding Qty." + Qty;
        IF OrgOrder THEN
            SalesOrderLedgerEntry."Posting Date" := SOLedgerEntry."Order Date"
        ELSE
            SalesOrderLedgerEntry."Posting Date" := TODAY;
        //SalesOrderLedgerEntry."Basic Value" := (((SOLedgerEntry."Basic Value") * (SOLedgerEntry.Quantity - SalesOrderLedgerEntry."Outstanding Qty."))/ SOLedgerEntry.Quantity) ;
        SalesOrderLedgerEntry."Buyer Price" := SOLedgerEntry."Buyer Price";
        SalesOrderLedgerEntry."Basic Value" := SOLedgerEntry."Buyer Price" * Qty;
        IF Location.GET(SalesOrderLedgerEntry."Location Code") THEN;
        SalesOrderLedgerEntry."Order Plant" := SOLedgerEntry."Order Plant";
        SalesOrderLedgerEntry."Despatch Remark" := SOLedgerEntry."Despatch Remark";
        SalesOrderLedgerEntry."Original SO Qty" := SOLedgerEntry."Original SO Qty";
        SalesOrderLedgerEntry."Order Date" := SOLedgerEntry."Order Date";
        SalesOrderLedgerEntry."Location Code" := SOLedgerEntry."Location Code";
        SalesOrderLedgerEntry."Order Plant" := SOLedgerEntry."Order Plant";
        SalesOrderLedgerEntry."Sales Person Code" := SOLedgerEntry."Sales Person Code";
        SalesOrderLedgerEntry."Mfg Plant" := SOLedgerEntry."Mfg Plant";
        SalesOrderLedgerEntry."Customer No." := SOLedgerEntry."Customer No.";
        IF Item.GET(SOLedgerEntry."No.") THEN BEGIN
            SalesOrderLedgerEntry."Size Code" := Item."Size Code";
            SalesOrderLedgerEntry."Size Description" := Item."Size Code Desc.";
            SalesOrderLedgerEntry."Default Prod. Line Code" := GetPlantCode(Item."Default Prod. Plant Code");
            //  SalesOrderLedgerEntry."Mfg Plant" := Item."Plant Code";
        END;
        SalesOrderLedgerEntry."PMT ID" := SalesOrderLedgerEntry."PMT ID";
        SalesOrderLedgerEntry.INSERT;
        LastEntryNo += 1;
    end;


    procedure GenerateNoMaterialLines(SalesHeader: Record "Sales Header")
    var
        IncDecQty: Decimal;
    begin
        IF SalesHeader.Commitment IN ['No Material'] THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
            SalesLine.SETFILTER("Document No.", '%1', SalesHeader."No.");
            IF SalesLine.FINDFIRST THEN BEGIN
                REPEAT
                    IncDecQty := CompareSalesLine(SalesLine."Document No.", SalesLine."Line No.", SalesLine."Outstanding Qty. (Base)");
                    IF IncDecQty <> 0 THEN BEGIN
                        CreateSOLedgerEntryFromSL(SalesHeader, SalesLine, IncDecQty, TRUE);
                    END;
                UNTIL SalesLine.NEXT = 0;
            END;
        END;
    end;

    local procedure updateSOLedgerEntries()
    begin
        SalesOrderLedgerEntry.RESET;
        IF SalesOrderLedgerEntry.FINDFIRST THEN
            REPEAT
                IF Item.GET(SalesOrderLedgerEntry."No.") THEN BEGIN
                    SalesOrderLedgerEntry."Size Code" := Item."Size Code";
                    SalesOrderLedgerEntry."Size Description" := Item."Size Code Desc.";
                    SalesOrderLedgerEntry."Mfg Plant" := Item."Item Category Code";
                END;
                SalesOrderLedgerEntry.MODIFY;
            UNTIL SalesOrderLedgerEntry.NEXT = 0;
    end;

    local procedure UpdateSalesOrderLine()
    var
        SalesOrderLedgerEntry1: Record "Sales Order Ledger Entry";
        SalesHeader: Record "Sales Header";
    begin
        SalesOrderLedgerEntry.RESET;
        IF SalesOrderLedgerEntry.FINDFIRST THEN
            REPEAT
                IF SalesLine.GET(SalesLine."Document Type"::Order, SalesOrderLedgerEntry."Sales Order No.", SalesOrderLedgerEntry."Sales Order Line No.") THEN BEGIN
                    SalesOrderLedgerEntry.Closed := FALSE;
                END ELSE
                    SalesOrderLedgerEntry.Closed := TRUE;
                SalesOrderLedgerEntry.MODIFY;
                IF SalesHeader.GET(SalesHeader."Document Type"::Order, SalesOrderLedgerEntry."Sales Order No.") THEN BEGIN
                    IF SalesHeader.Commitment <> SalesOrderLedgerEntry."Despatch Remark" THEN BEGIN
                        IF SalesHeader.Commitment <> 'No Material' THEN
                            SalesOrderLedgerEntry.DELETE;
                    END;
                END;
            UNTIL SalesOrderLedgerEntry.NEXT = 0;
    end;

    local procedure GetPlantCode(LocCode: Code[10]): Code[10]
    begin
        CASE LocCode OF
            'SKD-MF 1', 'SKD-MF 2', 'SKD-MF 3', 'SKD-MF 4':
                EXIT('MF');
            'SKD-MP 1', 'SKD-MP 2', 'SKD-MP 4':
                EXIT('MP');
            'DRA-PROD':
                EXIT('DRA-PROD');
            'HSK-PROD':
                EXIT('HSK-PROD');


        END;
    end;
}

