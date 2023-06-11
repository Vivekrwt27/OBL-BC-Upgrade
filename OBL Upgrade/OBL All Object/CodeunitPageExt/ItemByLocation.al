codeunit 50208 ItemByLocation
{
    [EventSubscriber(ObjectType::Page, Page::"Items by Location", 'OnAfterSetTempMatrixLocationFilters', '', false, false)]
    local procedure OnAfterSetTempMatrixLocationFilters(var Sender: Page "Items by Location"; var TempMatrixLocation: Record Location);
    var
        LocationFilter: Code[30];
        MatrixRecord: Record Location;
    begin
        IF LocationFilter <> '' THEN
            MatrixRecord.SETFILTER(Code, LocationFilter);
    end;

}