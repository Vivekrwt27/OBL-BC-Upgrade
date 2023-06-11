codeunit 50323 ItemtrackingLine
{
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAssignLotNoOnAfterInsert', '', false, false)]
    local procedure OnAssignLotNoOnAfterInsert(var Sender: Page "Item Tracking Lines"; var TrackingSpecification: Record "Tracking Specification"; QtyToCreate: Decimal);
    var
        RecItemJournal: Record "Item Journal Line";
        Item: Record Item;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //Upgrade(+)
        //TRI S.R 250310 - New code Add Start
        IF RecItemJournal.GET(TrackingSpecification."Source ID", TrackingSpecification."Source Batch Name", TrackingSpecification."Source Ref. No.") THEN BEGIN
            IF RecItemJournal."Entry Type" = RecItemJournal."Entry Type"::Output THEN
                TrackingSpecification.VALIDATE(TrackingSpecification."Lot No.", RecItemJournal.TGLotNoChange(RecItemJournal))
            ELSE BEGIN
                Item.TESTFIELD(Item."Lot Nos.");
                TrackingSpecification.VALIDATE(TrackingSpecification."Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE, TRUE));
            END;
        END ELSE BEGIN
            //TRI S.R 250310 - New code Add Start
            Item.TESTFIELD("Lot Nos.");
            TrackingSpecification.VALIDATE(TrackingSpecification."Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE, TRUE));
        END;//TRI S.R 250310 - New code Add Start

        //Upgrade(-)

    end;


}