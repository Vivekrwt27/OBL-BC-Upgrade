codeunit 50001 ShortClose
{
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        PurchLine: Record "Purchase Line";
    begin
    end;

    var
        Text0001: Label 'Quantity Shippped is not equal to Quantity Invoiced.';
        Text0002: Label 'Quantity Shipped should be zero for cancellation. Please Short close the Sales Order.';
        ArchiveManagement: Codeunit ArchiveManagement;
        Text0003: Label 'Do you want to Short Close Purchase Order %1?';
        Text0004: Label 'Do you want to Cancel Purchase Order %1?';
        Answer: Boolean;
        Text0005: Label 'Do you want to Short Close Sales Order %1?';
        Text0006: Label 'Do you want to Cancel Sales Order %1?';
        Text0007: Label 'As Quantity Shipped = 0,Please Cancel Sales Order %1.';
        Text0008: Label 'As Quantity Received = 0, Please Cancel Purchase Order %1.';
        Text0009: Label 'Quantity Received is not equal to Quantity Invoiced.';
        Text0010: Label 'Quantity Received should be zero for cancellation. Please Short close the Purchase Order.';
        Text0011: Label 'Quantity Shipped should be zero for cancellation. Please Short close the Export Order.';
        Text0012: Label 'Do you want to Short Close Export Order %1?';
        Text0013: Label 'Do you want to Cancel Export Order %1?';
        Text0014: Label 'As Quantity Shipped = 0,Please Cancel Export Order %1.';
        Text0015: Label 'Do you want to Short Close Import Order %1?';
        Text0016: Label 'Do you want to Cancel Import Order %1?';
        Text0017: Label 'As Quantity Received = 0, Please Cancel Import Order %1.';
        Text0018: Label 'Quantity Received should be zero for cancellation. Please Short close the Import Order.';
        IssuedCreditMgt: Codeunit "Issued Credit Mgt";


    procedure Cancel(Rec: Record "Purchase Header"; CloseCancel: Integer)
    var
        PurchLine: Record "Purchase Line";
        cnt: Integer;
        countlines: Integer;
    begin
        //Pr Tri1.0 Customization No. 5.3.6 Start
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", Rec."Document Type");
        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
        IF PurchLine.FIND('-') THEN
            IF CloseCancel = 1 THEN BEGIN
                IF CONFIRM(STRSUBSTNO(Text0003, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF ((PurchLine."Quantity Received" = 0) AND (PurchLine."Quantity Invoiced" = 0)) THEN
                            cnt := cnt + 1;
                        //Kulbhushan Comment the code the order Short Close
                        /*IF (PurchLine."Quantity Received"<>PurchLine."Quantity Invoiced") THEN
                          ERROR(Text0009);*/
                        countlines := countlines + 1;
                    UNTIL PurchLine.NEXT = 0;
                    IF countlines = cnt THEN
                        ERROR(Text0008, Rec."No.");
                    Rec.Status := Rec.Status::"Short Close";
                    Rec.MODIFY;
                    ArchiveManagement.StorePurchDocument(Rec, FALSE);
                    MESSAGE('Purchase Order %1 is available as archived.', Rec."No.");
                    //Rec.DELETE(TRUE);
                    //ND        PurchLine.DELETEALL(TRUE);
                END;
            END ELSE BEGIN
                IF CONFIRM(STRSUBSTNO(Text0004, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF (PurchLine."Quantity Received" <> 0) THEN
                            ERROR(Text0010)
                        ELSE
                            IF (PurchLine."Quantity Received" <> PurchLine."Quantity Invoiced") THEN
                                ERROR(Text0009);
                    UNTIL PurchLine.NEXT = 0;
                    Rec."New Status" := Rec."New Status"::Cancel;
                    Rec.MODIFY;
                    ArchiveManagement.StorePurchDocument(Rec, FALSE);
                    MESSAGE('Purchase Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND     PurchLine.DELETEALL(TRUE);
                END;
            END;
        //ArchiveManagement.StorePurchDocument(Rec,FALSE);
        //MESSAGE('Purchase Order %1 is available as archived',Rec."No.");
        //Rec.DELETE;
        //PurchLine.DELETEALL;
        //Pr Tri1.0 Customization No. 5.3.6 Start

    end;


    procedure SaleCancel(Rec: Record "Sales Header"; CloseCancel: Integer)
    var
        SalesLine: Record "Sales Line";
        cnt: Integer;
        countlines: Integer;
    begin
        //Pr Tri1.0 Customization No. 5.3.6 Start
        Rec.TESTFIELD("Reason Code");
        Rec."Canceller ID" := USERID;
        Rec."Cancellation Time" := TIME;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE(SalesLine."Document No.", Rec."No.");
        IF SalesLine.FIND('-') THEN
            IF CloseCancel = 1 THEN BEGIN
                IF CONFIRM(STRSUBSTNO(Text0005, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF ((SalesLine."Quantity Shipped" = 0) AND (SalesLine."Quantity Invoiced" = 0)) THEN
                            cnt := cnt + 1;
                        IF (SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced") THEN
                            ERROR(Text0001);
                        countlines := countlines + 1;
                    UNTIL SalesLine.NEXT = 0;
                    //IF countlines = cnt THEN
                    //  ERROR(Text0007,Rec."No.");
                    //ELSE BEGIN
                    Rec."New Status" := Rec."New Status"::"Short Close";
                    Rec.MODIFY;
                    //new added 4 lines
                    ArchiveManagement.StoreSalesDocument(Rec, FALSE);
                    MESSAGE('Sales Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND      SalesLine.DELETEALL(TRUE);
                END;
            END ELSE BEGIN
                IF CONFIRM(STRSUBSTNO(Text0006, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF (SalesLine."Quantity Shipped" <> 0) THEN
                            ERROR(Text0002)
                        ELSE
                            IF (SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced") THEN
                                ERROR(Text0001);
                    UNTIL SalesLine.NEXT = 0;
                    Rec."New Status" := Rec."New Status"::Cancel;
                    Rec.MODIFY;
                    ArchiveManagement.StoreSalesDocument(Rec, FALSE);
                    MESSAGE('Sales Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND      SalesLine.DELETEALL(TRUE);
                END;
            END;
        CLEAR(IssuedCreditMgt);
        IssuedCreditMgt.ShortCloseandReleaseCredit(Rec);
        //END;
        //ArchiveManagement.StoreSalesDocument(Rec,FALSE);
        //MESSAGE('Sales Order %1 is available as archived',Rec."No.");
        //Rec.DELETE;
        //SalesLine.DELETEALL;
        //Pr Tri1.0 Customization No. 5.3.6 Start
        //END;
        //END;
    end;


    procedure ExpSCCancel(Rec: Record "Sales Header"; CloseCancel: Integer)
    var
        SalesLine: Record "Sales Line";
        cnt: Integer;
        countlines: Integer;
    begin
        //ravi Tri1.0 Start
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE(SalesLine."Document No.", Rec."No.");
        IF SalesLine.FIND('-') THEN
            IF CloseCancel = 1 THEN BEGIN
                IF CONFIRM(STRSUBSTNO(Text0012, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF ((SalesLine."Quantity Shipped" = 0) AND (SalesLine."Quantity Invoiced" = 0)) THEN
                            cnt := cnt + 1;
                        IF (SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced") THEN
                            ERROR(Text0001);
                        countlines := countlines + 1;
                    UNTIL SalesLine.NEXT = 0;
                    //IF countlines = cnt THEN comment because we need to close the SO if qty not shipped
                    //  ERROR(Text0014,Rec."No."); comment because we need to close the SO if qty not shipped
                    //ELSE BEGIN
                    Rec."New Status" := Rec."New Status"::"Short Close";
                    Rec.MODIFY;
                    //new added 4 lines
                    ArchiveManagement.StoreSalesDocument(Rec, FALSE);
                    MESSAGE('Export Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND      SalesLine.DELETEALL(TRUE);
                END;
            END ELSE BEGIN
                IF CONFIRM(STRSUBSTNO(Text0013, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF (SalesLine."Quantity Shipped" <> 0) THEN
                            ERROR(Text0011)
                        ELSE
                            IF (SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced") THEN
                                ERROR(Text0001);
                    UNTIL SalesLine.NEXT = 0;
                    Rec."New Status" := Rec."New Status"::Cancel;
                    Rec.MODIFY;
                    ArchiveManagement.StoreSalesDocument(Rec, FALSE);
                    MESSAGE('Export Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND      SalesLine.DELETEALL(TRUE);
                END;
            END;

        //ravi Tri1.0 End
    end;


    procedure ImpSCCancel(Rec: Record "Purchase Header"; CloseCancel: Integer)
    var
        PurchLine: Record "Purchase Line";
        cnt: Integer;
        countlines: Integer;
    begin
        //ravi Tri1.0 Start

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", Rec."Document Type");
        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
        IF PurchLine.FIND('-') THEN
            IF CloseCancel = 1 THEN BEGIN
                IF CONFIRM(STRSUBSTNO(Text0015, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF ((PurchLine."Quantity Received" = 0) AND (PurchLine."Quantity Invoiced" = 0)) THEN
                            cnt := cnt + 1;
                        IF (PurchLine."Quantity Received" <> PurchLine."Quantity Invoiced") THEN
                            ERROR(Text0009);
                        countlines := countlines + 1;
                    UNTIL PurchLine.NEXT = 0;
                    //IF countlines = cnt THEN
                    //  ERROR(Text0017,Rec."No.");
                    Rec."New Status" := Rec."New Status"::"Short Close";
                    Rec.MODIFY;
                    ArchiveManagement.StorePurchDocument(Rec, FALSE);
                    MESSAGE('Import Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND        PurchLine.DELETEALL(TRUE);
                END;
            END ELSE BEGIN
                IF CONFIRM(STRSUBSTNO(Text0016, Rec."No."), TRUE) THEN BEGIN
                    REPEAT
                        IF (PurchLine."Quantity Received" <> 0) THEN
                            ERROR(Text0018)
                        ELSE
                            IF (PurchLine."Quantity Received" <> PurchLine."Quantity Invoiced") THEN
                                ERROR(Text0009);
                    UNTIL PurchLine.NEXT = 0;
                    Rec."New Status" := Rec."New Status"::Cancel;
                    Rec.MODIFY;
                    ArchiveManagement.StorePurchDocument(Rec, FALSE);
                    MESSAGE('Import Order %1 is available as archived.', Rec."No.");
                    Rec.DELETE(TRUE);
                    //ND     PurchLine.DELETEALL(TRUE);
                END;
            END;
        //ArchiveManagement.StorePurchDocument(Rec,FALSE);
        //MESSAGE('Purchase Order %1 is available as archived',Rec."No.");
        //Rec.DELETE;
        //PurchLine.DELETEALL;

        //ravi Tri1.0 End
    end;


    procedure ShortClosePurchaseOrder(PurchHeader: Record "Purchase Header")
    var
        Text50000: Label 'Please select a Reason code for Purchase Order.';
        RecPL: Record "Purchase Line";
        IndentLine: Record "Indent Line";
        NewIndentLine: Record "Indent Line";
    begin
        IF PurchHeader."Reason Code" = '' THEN
            ERROR(Text50000);
        //PurchHeader.Status:=PurchHeader.Status::"Short Close";
        //PurchHeader.MODIFY;
        //MSBS.Rao Start 261114
        RecPL.SETRANGE("Document Type", PurchHeader."Document Type");
        RecPL.SETRANGE("Document No.", PurchHeader."No.");
        IF RecPL.FINDFIRST THEN
            REPEAT
                RecPL.Status := RecPL.Status::"Short Close";
                RecPL.MODIFY;
                //IF RecPL."Quantity Received" <> 0 THEN BEGIN
                //  RecPL.InsertPartialIndent(RecPL,RecPL."Outstanding Quantity",0);//MSBS.Rao 241114
                // END ELSE
                IF RecPL."Indent No." <> '' THEN BEGIN
                    IndentLine.RESET;
                    IndentLine.SETFILTER(IndentLine."Document No.", RecPL."Indent No.");
                    IndentLine.SETRANGE(IndentLine."Line No.", RecPL."Indent Line No.");
                    IF IndentLine.FIND('-') THEN BEGIN
                        IndentLine.VALIDATE("Order No.", '');
                        IndentLine.VALIDATE("Order Line No.", 0);
                        IndentLine.VALIDATE("Order Date", 0D);
                        IndentLine.VALIDATE(Status, IndentLine.Status::Authorized);
                        IndentLine.MODIFY(TRUE);
                    END;
                    NewIndentLine.SETRANGE("Document No.", RecPL."Indent No.");
                    NewIndentLine.SETFILTER("No.", '%1', RecPL."No.");
                    NewIndentLine.SETFILTER("Line No.", '>%1', RecPL."Indent Line No.");
                    IF NewIndentLine.FINDFIRST THEN BEGIN
                        REPEAT
                            NewIndentLine.CALCFIELDS("PO Qty");
                            IF (NewIndentLine."PO Qty" = 0) THEN
                                NewIndentLine.DELETE;
                        UNTIL NewIndentLine.NEXT = 0;
                    END;
                END;
            UNTIL RecPL.NEXT = 0;
        //MSBS.Rao Stop 261114
        PurchHeader.Status := PurchHeader.Status::"Short Close";
        PurchHeader.MODIFY;
    end;
}

