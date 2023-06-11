xmlport 50013 "Update Item Block"
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
                textelement(Blocked)
                {
                }
                textelement(indblocked)
                {
                }
                textelement(PurBlocked)
                {
                }
                textelement(ToBlocked)
                {
                }
                textelement(Blocked2)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record Item;
                begin
                    IF ItemRec.GET(ItemNo) THEN BEGIN
                        EVALUATE(Block, Blocked);
                        ItemRec.Blocked := Block;
                        EVALUATE(iNDENT, indblocked);
                        ItemRec."Indent Blocked" := iNDENT;
                        EVALUATE(PO, PurBlocked);
                        ItemRec."Purchase Blocked" := PO;
                        EVALUATE(trf, ToBlocked);
                        ItemRec."Transfer Order Blocked" := trf;
                        EVALUATE(Blocke, Blocked2);
                        ItemRec.Blocked2 := Blocke;
                        // EVALUATE(retained,ret);
                        // ItemRec.Retained := retained;
                        //EVALUATE(liq,liqu);
                        //  ItemRec.Liquidaton := liq;
                        //EVALUATE(msta,ms);
                        //  ItemRec."Manuf. Strategy" := msta;
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
        Block: Boolean;
        Blocke: Boolean;
        PO: Boolean;
        trf: Boolean;
        iNDENT: Boolean;
        retained: Boolean;
        msta: Option;
        liq: Boolean;
}

