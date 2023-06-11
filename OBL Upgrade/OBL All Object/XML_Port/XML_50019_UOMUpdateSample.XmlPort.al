xmlport 50019 "UOM Update Sample"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("item set")
        {
            XmlName = 'MinMaxInventory';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'MinMaxInventory';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(itemno)
                {
                    XmlName = 'ItemNo';
                }
                textelement(qty)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record "Item Unit of Measure";
                begin
                    IF ItemRec.GET(ItemNo, 'SQ.MT') THEN BEGIN
                        EVALUATE(quantity, qty);
                        ItemRec."Qty. per Unit of Measure" := quantity;
                        ItemRec.MODIFY;
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    var
        ItemREC: Record Item;
    begin
    end;

    var
        quantity: Decimal;
}

