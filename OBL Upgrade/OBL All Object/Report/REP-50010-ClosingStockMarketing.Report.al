report 50010 "Closing Stock Marketing"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ClosingStockMarketing.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("Item Category Code")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Item Category Code", "Date Filter", "Location Filter", "Size Code", "Quality Code", "Plant Code";
            column(Name_Comp; CompInfor.Name + ' ' + CompInfor."Name 2")
            {
            }
            column(ItemCategoryCode_Item; Item."Item Category Code")
            {
            }
            column(Desc_ItemCat; ItemCategory.Description)
            {
            }
            column(NetChange_Item; Item."Net Change")
            {
            }
            column(MorbiInv; MorbiInv)
            {
            }
            column(No_Item; Item."No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Item.Description)
            {
                IncludeCaption = true;
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(BaseUnitofMeasure_Item; Item."Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            column(Filters; Filters)
            {
            }
            column(ReservedQtyonInventory_Item; Item."Reserved Qty. on Inventory")
            {
            }
            column(QtyInCartons; QtyInCartons)
            {
            }
            column(Date; Date)
            {
            }
            column(manuf_strategy; Item."Manuf. Strategy")
            {
            }
            column(blnAdmin; blnAdmin)
            {
            }

            trigger OnAfterGetRecord()
            begin
                blnAdmin := FALSE;
                IF USERID = 'ADMIN' THEN
                    blnAdmin := TRUE;

                CLEAR(AssociateVendorMgt);
                MorbiInv := 0;
                IF IncludeMorbiStock THEN
                    MorbiInv := AssociateVendorMgt.CalculateInventoryBalance(Item."No.", '', '', TODAY, TRUE);

                IF NOT ((("Net Change" - "Reserved Qty. on Inventory" + MorbiInv) >= "Min Qty") AND ("Net Change" + MorbiInv <> 0)) THEN
                    CurrReport.SKIP;


                Item.CALCFIELDS("Net Change", "Reserved Qty. on Inventory");
                QtyInCartons := ROUND(UomToCart("No.", "Base Unit of Measure", "Net Change" -
                "Reserved Qty. on Inventory" + MorbiInv), 1, '=');

                IF ItemCategory.GET(Item."Item Category Code") THEN;
            end;

            trigger OnPreDataItem()
            begin
                IF (Item.GETFILTER("Location Filter") = 'SKD-PLANT') OR (Item.GETFILTER("Location Filter") = 'DRA-PLANT')
                    OR (Item.GETFILTER("Location Filter") = 'HSK-PLANT') THEN
                    SETFILTER("Location Filter", GetLocations(Item.GETFILTER("Location Filter")));

                LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Plant Code"; Plant)
                    {
                        ApplicationArea = All;
                    }
                    field("Minimum Quantity"; "Min Qty")
                    {
                        ApplicationArea = All;
                    }
                    field("WareHouse Location"; WhreLoc)
                    {
                        ApplicationArea = All;
                    }
                    field("Include Morbi Stock"; IncludeMorbiStock)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        IF Item.GETFILTER(Item."Date Filter") <> '' THEN BEGIN
            IF STRPOS(FORMAT(Item.GETFILTER(Item."Date Filter")), '.')
              <> STRLEN(FORMAT(Item.GETFILTER(Item."Date Filter"))) - 1 THEN
                Date := FORMAT(Item.GETRANGEMAX(Item."Date Filter"), 0, 4)
        END ELSE
            Date := FORMAT(TODAY, 0, 4);

        IF WhreLoc = TRUE THEN
            Filters := 'Warehouse Location : ' + FORMAT(WhreLoc)
        ELSE
            IF Plant <> '' THEN
                Filters := 'Plant Code : ' + Plant;

        IF "Min Qty" <> 0 THEN
            Filters := Filters + ' Min Qty : ' + FORMAT("Min Qty");

        Filters := Filters + ' ' + Item.GETFILTERS;
    end;

    var
        CompInfor: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        value: Decimal;
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        Date: Text[30];
        Filters: Text[500];
        ItemCategory: Record "Item Category";
        "Min Qty": Decimal;
        Plant: Code[10];
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        WhreLoc: Boolean;
        Loc: Record Location;
        LocationFilterString: Text[250];
        Quantity: Decimal;
        ResQty: Decimal;
        QtyInCartons: Decimal;
        QtyInWeight: Decimal;
        iTEMREC: Record Item;
        blnAdmin: Boolean;
        AssociateVendorMgt: Codeunit "Associate Vendor Mgt";
        MorbiInv: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        IncludeMorbiStock: Boolean;

    procedure GetLocations(LocationCode: Code[10]): Text[800]
    var
        Loc: Text[800];
        Location: Record Location;
    begin
        Location.RESET;
        Location.SETFILTER(Code, COPYSTR(LocationCode, 1, 3) + '*');
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := Location.Code
                ELSE
                    Loc := Loc + '|' + Location.Code;
            UNTIL Location.NEXT = 0;
        END;
        IF LocationCode = 'SKD-PLANT' THEN
            EXIT(Loc + '|' + 'O-INTRAN');
        IF LocationCode = 'HSK-PLANT' THEN
            EXIT(Loc + '|' + 'B-INTRAN');
        EXIT(Loc);
    end;
}

