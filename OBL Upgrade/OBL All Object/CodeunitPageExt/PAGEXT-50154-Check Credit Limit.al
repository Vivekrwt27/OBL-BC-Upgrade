codeunit 50154 Page
{/* 
    [EventSubscriber(ObjectType::Page, Page::"Check Credit Limit", 'OnBeforeSalesHeaderShowWarning', '', false, false)]
    local procedure OnBeforeSalesHeaderShowWarning(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean);
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" THEN
            Result := false

    end;


 */

}