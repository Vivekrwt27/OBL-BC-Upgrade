xmlport 50004 "Min Max Inventory Update"
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
                textelement(gwt)
                {
                    XmlName = 'gwt';
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record Item;
                begin
                    IF ItemRec.GET(ItemNo) THEN BEGIN
                        //  EVALUATE(MaxInv,gwt);
                        //  ItemRec."Maximum Inventory" := MaxInv;
                        //  EVALUATE(MinInv,nwt);
                        //  ItemRec."Minimum Inventory" := MinInv;
                        //  ItemRec."Type Code" := ty;
                        //    ItemRec."Net Weight" := MinInv;
                        //    ItemRec."Gross Weight" := MaxInv;
                        //ItemRec."Old Code" := KBS;
                        //      ItemRec.Description := KBS;
                        //      ItemRec."Description 2" := kbs1;
                        EVALUATE(MaxInv, gwt);
                        ItemRec."V. Cost" := MaxInv;

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
        MaxInv: Decimal;
        MinInv: Decimal;
}

