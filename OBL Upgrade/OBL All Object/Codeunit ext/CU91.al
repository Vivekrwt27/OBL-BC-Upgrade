codeunit 50113 CU91
{
    trigger OnRun()
    begin


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun(var PurchaseHeader: Record "Purchase Header");
    begin
        CheckMorbiInventory(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 91, 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure OnBeforeSelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        Selection: Integer;
        ReceiveInvoiceQst: Label '&Receive,&Invoice';
        gg: Codeunit 91;
    begin
        IsHandled := true;
        with PurchaseHeader do begin
            Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
            if Selection = 0 then begin
                Result := false;
                exit;
            end;
            Receive := Selection in [1];
            Invoice := Selection in [2];
        end;

        Result := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeSelectPostReturnOrderOption', '', false, false)]
    local procedure OnBeforeSelectPostReturnOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean);
    var
        ShipInvoiceQst: Label '&Ship';
        ShipInvoiceQst1: Label '&Invoice';
        Selection: Integer;
        PurchLine: Record "Purchase Line";
    begin

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type"::"Return Order");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        if PurchLine.FindFirst() then;



        //if PurchaseHeader."Auto Create Return Order" then begin
        if PurchLine."Return Qty. Shipped" = 0 then begin
            IsHandled := true;
            with PurchaseHeader do begin
                Selection := 1;
                // Selection := StrMenu(ShipInvoiceQst1, DefaultOption);
                if Selection = 0 then begin
                    Result := false;
                    exit;
                end;
                Ship := Selection in [1];
                Invoice := false;
            end;
            Result := true;
        end;


        //end;
    end;

    PROCEDURE CheckMorbiInventory(VAR PurchHeader2: Record 38);
    VAR
        Vendor: Record 23;
        Item: Record 27;
        PurchaseLine: Record 39;
        AssociateVendorMgt: Codeunit 50054;
        AvailableQty: Decimal;
        ReqQty: Decimal;
        MorbiLocation: Record 14;
    BEGIN
        IF PurchHeader2."Document Type" <> PurchHeader2."Document Type"::Order THEN
            EXIT;
        IF Vendor.GET(PurchHeader2."Buy-from Vendor No.") THEN BEGIN
            IF Vendor."Vendor Posting Group" = 'TRD' THEN Vendor.TESTFIELD("Morbi Location Code");
            ;

            IF Vendor."Morbi Location Code" <> '' THEN BEGIN
                MorbiLocation.CHANGECOMPANY('Associate Vendors-Morbi');
                MorbiLocation.GET(Vendor."Morbi Location Code");
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", PurchHeader2."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchHeader2."No.");
                PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                IF PurchaseLine.FINDFIRST THEN
                    REPEAT
                        IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                            IF Item.GET(PurchaseLine."No.") THEN
                                IF Item."Item Category Code" = 'T001' THEN BEGIN
                                    CLEAR(AssociateVendorMgt);
                                    PurchaseLine.TESTFIELD("Batch No.");
                                    AvailableQty := 0;

                                    AvailableQty := AssociateVendorMgt.CalculateInventoryBalance(PurchaseLine."No.", Vendor."Morbi Location Code", '', TODAY, TRUE);
                                    AvailableQty := Item.UomToCart(Item."No.", 'SQ.MT', AvailableQty);
                                    //ReqQty := Item.UomToCart(Item."No.",'SQ.MT',PurchaseLine."Qty. to Receive");
                                    ReqQty := Item.UomToCart(Item."No.", 'CRT', PurchaseLine."Qty. to Receive");
                                    IF ReqQty > AvailableQty THEN
                                        ERROR('Insufficient Inventory of Item [%1 ] at Vendor Location Requested Qty [%3] and Available [%2]', PurchaseLine."No.", AvailableQty, ReqQty);
                                    //  AssociateVendorMgt.CheckInventoryBatch(PurchaseLine."No.",Vendor."Morbi Location Code",PurchaseLine."Batch No.",TODAY);
                                END;
                        END;
                    UNTIL PurchaseLine.NEXT = 0;
            END;
        END;
    END;

    [EventSubscriber(ObjectType::Table, 77, 'OnBeforeGetEmailAddress', '', false, false)]
    local procedure OnBeforeGetEmailAddress(ReportUsage: Option; RecordVariant: Variant; var TempBodyReportSelections: Record "Report Selections" temporary; var EmailAddress: Text[250]; var IsHandled: Boolean; CustNo: Code[20])
    var
        SalesPersonCode: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        if Customer.get(CustNo) then begin
            if SalesPersonCode.Get(Customer."Salesperson Code") then begin
                EmailAddress := SalesPersonCode."E-Mail";
                IsHandled := true;
            end;

        end;
    end;



    var
        myInt: Codeunit 91;
}