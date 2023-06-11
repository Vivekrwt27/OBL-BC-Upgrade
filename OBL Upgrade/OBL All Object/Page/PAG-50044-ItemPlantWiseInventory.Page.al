page 50044 "Item Plant Wise Inventory"
{
    Caption = 'Items by Location';
    LinksAllowed = false;
    PageType = Card;
    SaveValues = true;
    //  SourceTable = "Plant Variant Wise Inventory";
    //SourceTableView = SORTING("Item No.", "Variant Code", "Plant Code");
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
    }

    actions
    {
    }

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        MatrixHeader: Text[250];
        ShowColumnName: Boolean;
        ShowInTransit: Boolean;
        LocationFilter: Code[250];
        UserLocation: Record "User Location";
        ShowInSubLocations: Boolean;

    local procedure InventoryDrillDown()
    begin
    end;

    local procedure UpdateMatrix()
    begin
    end;
}

