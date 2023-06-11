xmlport 50066 "Varient Block"
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
                textelement(item)
                {
                }
                textelement(varcode)
                {
                    XmlName = 'varcode';
                }
                textelement(blocked)
                {
                    XmlName = 'Blocked';
                }

                trigger OnBeforeInsertRecord()
                var
                    VarRec: Record "Item Variant";
                begin
                    IF VarRec.GET(item, varcode) THEN BEGIN
                        EVALUATE(Block, Blocked);
                        VarRec.Blocked := Block;
                        VarRec.MODIFY;
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
}

