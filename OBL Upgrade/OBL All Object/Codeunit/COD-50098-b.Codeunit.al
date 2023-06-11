codeunit 50098 b
{

    trigger OnRun()
    begin
        Window.OPEN('SalesInvoice  #1#################');
        i := 0;
        SalesInvoice.RESET;
        SalesInvoice.SETFILTER(SalesInvoice.Type, '%1', SalesInvoice.Type::Item);
        IF SalesInvoice.FIND('-') THEN
            REPEAT
                Item.GET(SalesInvoice."No.");
                IF SalesInvoice."Size Code" = '' THEN
                    SalesInvoice."Size Code" := Item."Size Code";
                IF SalesInvoice."Type Code" = '' THEN
                    SalesInvoice."Type Code" := Item."Type Code";
                IF SalesInvoice."Plant Code" = '' THEN
                    SalesInvoice."Plant Code" := Item."Plant Code";
                IF SalesInvoice."Color Code" = '' THEN
                    SalesInvoice."Color Code" := Item."Color Code";
                IF SalesInvoice."Design Code" = '' THEN
                    SalesInvoice."Design Code" := Item."Design Code";
                IF SalesInvoice."Packing Code" = '' THEN
                    SalesInvoice."Packing Code" := Item."Packing Code";
                IF SalesInvoice."Quality Code" = '' THEN
                    SalesInvoice."Quality Code" := Item."Quality Code";
                SalesInvoice.MODIFY;
                i += 1;
                Window.UPDATE(1, i);
            UNTIL SalesInvoice.NEXT = 0;
        Window.CLOSE;
    end;

    var
        TransShip: Record "Transfer Shipment Line";
        TransferRcpt: Record "Transfer Receipt Line";
        SalesInvoice: Record "Sales Invoice Line";
        SalesShip: Record "Sales Shipment Line";
        Item: Record Item;
        Window: Dialog;
        i: Integer;
        ILE: Record "Item Ledger Entry";
        TransRcptH: Record "Transfer Receipt Header";
}

