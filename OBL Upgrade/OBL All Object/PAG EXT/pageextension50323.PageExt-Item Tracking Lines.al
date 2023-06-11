pageextension 50323 pageextension50323 extends "Item Tracking Lines"
{
    procedure TGAssignOutputLotNo()
    var
        QtyToCreate: Decimal;

    begin
        IF ZeroLineExists THEN
            Rec.DELETE;

        IF (SourceQuantityArray[1] * UndefinedQtyArray[1] <= 0) OR
           (ABS(SourceQuantityArray[1]) < ABS(UndefinedQtyArray[1]))
        THEN
            QtyToCreate := 0
        ELSE
            QtyToCreate := UndefinedQtyArray[1];

        GetItem(Rec."Item No.");

        Item.TESTFIELD("Lot Nos.");
        Rec.VALIDATE("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE, TRUE));
        Rec."Qty. per Unit of Measure" := QtyPerUOM;
        Rec.VALIDATE("Quantity (Base)", QtyToCreate);
        Rec."Entry No." := NextEntryNo;
        TestTempSpecificationExists;
        Rec.INSERT;
        TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
        TempItemTrackLineInsert.INSERT;
        //16225 ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
        CalculateSums;
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        if Item."No." <> ItemNo then begin
            Item.Get(ItemNo);
            Item.TestField("Item Tracking Code");
            if ItemTrackingCode.Code <> Item."Item Tracking Code" then
                ItemTrackingCode.Get(Item."Item Tracking Code");
        end;
    end;

    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

