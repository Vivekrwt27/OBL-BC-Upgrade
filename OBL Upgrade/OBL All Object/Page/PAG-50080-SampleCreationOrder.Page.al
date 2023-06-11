page 50080 "Sample Creation Order"
{
    PageType = ConfirmationDialog;
    SourceTable = Integer;
    SourceTableView = SORTING(Number)
                      WHERE(Number = CONST(1));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            field("Item Category"; GlbItemCat)
            {
                TableRelation = "Item Category".Code;
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    GetData(GlbItemCat, GlbItemFilter, DefaultQty);
                end;
            }
            field("Sample Group Filter"; GlbItemFilter)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    GetData(GlbItemCat, GlbItemFilter, DefaultQty);
                end;
            }
            field("Default Quantity"; DefaultQty)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        GlbItemCat := 'SAMPLE';
    end;

    var
        GlbItemCat: Text;
        GlbItemFilter: Text;
        DefaultQty: Decimal;

    procedure GetData(var ItemCat: Text; var ItemFilter: Text; var Qty: Decimal)
    begin
        ItemCat := GlbItemCat;
        ItemFilter := GlbItemFilter;
        Qty := DefaultQty;
    end;

    procedure SetData(var ItemCat: Text; var ItemFilter: Text; var Qty: Decimal)
    begin
        GlbItemCat := ItemCat;
        GlbItemFilter := ItemFilter;
        DefaultQty := Qty;
    end;
}

