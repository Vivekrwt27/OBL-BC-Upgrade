codeunit 50176 salesHeader
{
    /*     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs', '', false, false)]// Field Sell to customer no
        local procedure OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean);
        begin
            SalesHeader.UpdateSalesPerson;//MSAK
        end;

        [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitInsertOnBeforeInitRecord', '', false, false)]// Function InitInsert
        local procedure OnInitInsertOnBeforeInitRecord(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header");
        var
            NoSeries: Record "No. Series";
        begin
            //TRI START
            NoSeries.RESET;
            IF NoSeries.GET(SalesHeader."No. Series") THEN BEGIN
                IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" THEN
                    NoSeries.TESTFIELD("Sales Order No. Series");
                SalesHeader."Sales Order No." := NoSeries."Sales Order No. Series";
                //TRI DG Start
                IF NoSeries."Posted Invoice No. Series" <> '' THEN
                    SalesHeader."Posting No. Series" := NoSeries."Posted Invoice No. Series";
                //TRI DG End
                //MSBS.Rao Start 300914
                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                    SalesHeader."Group Code" := NoSeries."Group Code";
                //MSBS.Rao Stop 300914
            END;

        end;

     */
}