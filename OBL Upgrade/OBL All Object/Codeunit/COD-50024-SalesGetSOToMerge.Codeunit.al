codeunit 50024 "Sales-Get SO To Merge"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        /*
        IF "Location Code" <> 'DP-MORBI' THEN
          TESTFIELD(Status,SalesHeader.Status::Released)
        ELSE
          IF NOT (Status in [Status::Released,Status::"Price Approved"]) THEN
            ERROR('Status Must Be Price Approved or Release');
            */
        Rec.TESTFIELD("Customer Type", 'DEALER');
        FromSalesHeader.FILTERGROUP(2);
        FromSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.", "No.");
        FromSalesHeader.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
        FromSalesHeader.SETFILTER("No.", '<>%1', Rec."No.");
        FromSalesHeader.SETRANGE("Currency Code", Rec."Currency Code");
        FromSalesHeader.SETRANGE("Group Code", Rec."Group Code");
        //15578 FromSalesHeader.SETRANGE("Form Code", "Form Code");
        FromSalesHeader.SETFILTER("Requested Delivery Date", '..%1', Rec."Requested Delivery Date");
        FromSalesHeader.SETRANGE("Payment Terms", Rec."Payment Terms");
        FromSalesHeader.SETRANGE("Bill-to City", Rec."Bill-to City");
        FromSalesHeader.SETRANGE("Bill-to Post Code", Rec."Bill-to Post Code");
        FromSalesHeader.SETRANGE("Ship-to City", Rec."Ship-to City");
        FromSalesHeader.SETRANGE("Ship-to Post Code", Rec."Ship-to Post Code");
        FromSalesHeader.SETRANGE("Ship to Pin", Rec."Ship to Pin");
        FromSalesHeader.SETRANGE("GST Ship-to State Code", Rec."GST Ship-to State Code");
        FromSalesHeader.SETRANGE("Discount Charges %", Rec."Discount Charges %");
        FromSalesHeader.SETRANGE("Sales Type", Rec."Sales Type");
        FromSalesHeader.SETRANGE("PMT Code", Rec."PMT Code");
        FromSalesHeader.SETRANGE("Location Code", Rec."Location Code");
        FromSalesHeader.SETRANGE("Payment Terms Code", Rec."Payment Terms Code");
        FromSalesHeader.SETRANGE("Ship-to Name", Rec."Ship-to Name");
        FromSalesHeader.SETRANGE("Ship-to Address", Rec."Ship-to Address");
        FromSalesHeader.SETRANGE("Ship-to Address 2", Rec."Ship-to Address 2");
        IF Rec."Location Code" = 'DP-MORBI' THEN
            FromSalesHeader.SETFILTER(Status, '%1|%2', Rec.Status::Released, Rec.Status::Approved)
        ELSE
            FromSalesHeader.SETRANGE(Status, Rec.Status::Released);


        IF FromSalesHeader.FINDFIRST THEN BEGIN
            //MESSAGE('1');
            ///  CLEAR(GetSO);
            ///   GetSO.SETTABLEVIEW(FromSalesHeader);
            //GetSO.SetSalesHeader(Rec);
            ///  GetSO.LOOKUPMODE := TRUE;
            FromSalesHeader.FILTERGROUP(0);
            //IF GetSO.RUNMODAL = ACTION::OK THEN
            /*  IF GetSO.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  //MESSAGE('2');
                  FSalesHeader.RESET;
                  FSalesHeader.SETRANGE(Selection1, TRUE);
                  IF FSalesHeader.FINDSET THEN
                      REPEAT
                          //MESSAGE('3');
                          CreateInvLines(FSalesHeader, Rec);
                          CloseSalesHEader(FSalesHeader);
                      UNTIL FSalesHeader.NEXT = 0;
              END*/ // 15578
        END;

        FSalesHeader.RESET;
        FSalesHeader.SETRANGE(Selection1, TRUE);
        IF FSalesHeader.FINDFIRST THEN
            FSalesHeader.MODIFYALL(Selection1, FALSE);

    end;

    var
        Text001: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        FromSalesHeader: Record "Sales Header";
        SalesLine3: Record "Sales Line";
        // GetSO: Page "Get SO to Merge";
        Text002: Label 'Creating Sales Order Lines\';
        Text003: Label 'Inserted lines             #1######';
        FromSalesLine2: Record "Sales Line";
        FSalesHeader: Record "Sales Header";
        ArchiveManagement: Codeunit ArchiveManagement;
        countlines: Integer;
        Text0001: Label 'Already Invoiced!!!';
        Text0007: Label 'Test';
        Text0002: Label 'Qty not be shipped!!!';


    procedure CreateInvLines(var FromSalesHeader: Record "Sales Header"; ToSalesHeader: Record "Sales Header")
    var
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        LineCount: Integer;
        TransferLine: Boolean;
        SLine: Record "Sales Line";
    begin

        FromSalesLine2.RESET;
        FromSalesLine2.SETRANGE("Document Type", FromSalesHeader."Document Type");
        FromSalesLine2.SETRANGE("Document No.", FromSalesHeader."No.");
        IF FromSalesLine2.FINDFIRST THEN BEGIN
            REPEAT
                Window.OPEN(Text002 + Text003);
                LineCount := LineCount + 1;
                Window.UPDATE(1, LineCount);
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("Document Type", ToSalesHeader."Document Type");
                    SalesHeader.SETRANGE("No.", ToSalesHeader."No.");
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        SalesLine3 := FromSalesLine2;
                        SalesLine3."Document Type" := ToSalesHeader."Document Type";
                        SalesLine3."Document No." := ToSalesHeader."No.";
                        SLine.RESET;
                        SLine.SETRANGE("Document Type", ToSalesHeader."Document Type");
                        SLine.SETRANGE("Document No.", ToSalesHeader."No.");
                        IF SLine.FINDLAST THEN
                            SalesLine3."Line No." := SLine."Line No." + 10000;

                        //SalesLine3.InsertInvLineFromShptLine(SalesLine3,TempFromLineDim);
                        SalesLine3.INSERT;
                        // IF FromSalesLine2.Reserve = FromSalesLine2.Reserve::Always THEN
                        //   SalesLine3.AutoReserve;
                        //    SalesLine3.MODIFY;
                        //        DimMgt.MoveTempFromDimToTempToDim(TempFromLineDim,TempToLineDim);
                        CopyFromSalesDocDimToLine(SalesLine3, FromSalesLine2);
                    END;
                END;
            UNTIL FromSalesLine2.NEXT = 0;
            //    DimMgt.TransferTempToDimToDocDim(TempToLineDim);
            Window.CLOSE;
        END;
    end;


    procedure SetSalesHeader(var SalesHeader2: Record "Sales Header")
    begin
        SalesHeader.GET(SalesHeader2."Document Type", SalesHeader2."No.");
    end;


    procedure CloseSalesHEader(SalesHead: Record "Sales Header")
    var
        Cnt: Integer;
    begin
        SalesHead."Reason Code" := 'REASON11';
        SalesHead."Canceller ID" := USERID;
        SalesHead."Cancellation Time" := TIME;

        SalesLine.RESET;
        SalesLine.SETRANGE(salesline."Document Type", SalesHead."Document Type");
        SalesLine.SETRANGE(SalesLine."Document No.", SalesHead."No.");
        IF SalesLine.FIND('-') THEN
            REPEAT
                IF ((SalesLine."Quantity Shipped" = 0) AND (SalesLine."Quantity Invoiced" = 0)) THEN
                    Cnt := Cnt + 1;
                IF (SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced") THEN
                    ERROR(Text0001);
                IF (SalesLine."Quantity Shipped" <> 0) THEN
                    ERROR(Text0002);
            UNTIL SalesLine.NEXT = 0;

        SalesHead."New Status" := SalesHead."New Status"::"Short Close";
        SalesHead.MODIFY;
        ArchiveManagement.StoreSalesDocument(SalesHead, FALSE);
        SalesHead.DELETE(TRUE);
    end;

    local procedure CopyFromSalesDocDimToLine(var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line")
    begin
        /*DocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
        DocDim.SETRANGE("Document Type",ToSalesLine."Document Type");
        DocDim.SETRANGE("Document No.",ToSalesLine."Document No.");
        DocDim.SETRANGE("Line No.",ToSalesLine."Line No.");
        DocDim.DELETEALL;
        ToSalesLine."Shortcut Dimension 1 Code" := FromSalesLine."Shortcut Dimension 1 Code";
        ToSalesLine."Shortcut Dimension 2 Code" := FromSalesLine."Shortcut Dimension 2 Code";
        FromDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
        FromDocDim.SETRANGE("Document Type",FromSalesLine."Document Type");
        FromDocDim.SETRANGE("Document No.",FromSalesLine."Document No.");
        FromDocDim.SETRANGE("Line No.",FromSalesLine."Line No.");
        IF FromDocDim.FIND('-') THEN BEGIN
          REPEAT
            DocDim.INIT;
            DocDim."Table ID" := DATABASE::"Sales Line";
            DocDim."Document Type" := ToSalesLine."Document Type";
            DocDim."Document No." := ToSalesLine."Document No.";
            DocDim."Line No." := ToSalesLine."Line No.";
            DocDim."Dimension Code" := FromDocDim."Dimension Code";
            DocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
            DocDim.INSERT;
          UNTIL FromDocDim.NEXT = 0;
        END;
         */

    end;
}

