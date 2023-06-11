xmlport 50012 "Update Item Category Code"
{
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
                textelement(itemclass)
                {
                    XmlName = 'itemclass';
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record Item;
                begin
                    IF ItemRec.GET(ItemNo) THEN BEGIN
                        ItemRec."Item Classification" := itemclass;
                        //ItemRec."Item Category Code" := itemclass;
                        //ItemRec.VALIDATE("Item Category Code");
                        //ItemRec."Product Group Code" := itemclass1;
                        //EVALUATE(ret, itemclass);
                        //ItemRec."HSN/SAC Code":= hsn;
                        //ItemRec."Shelf Location Dra" := selfdra;
                        //ItemRec.VALIDATE("Shelf Location Dra");
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
        ret: Boolean;
}

