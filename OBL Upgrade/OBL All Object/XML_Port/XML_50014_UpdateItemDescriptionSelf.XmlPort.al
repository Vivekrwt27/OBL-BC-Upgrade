xmlport 50014 "Update Item Description & Self"
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
                textelement(cd)
                {
                    XmlName = 'cd';
                }
                textelement(cd1)
                {
                    XmlName = 'cd1';
                }
                textelement(cd2)
                {
                    XmlName = 'cd2';
                }
                textelement(qty)
                {
                    XmlName = 'qty';
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record Item;
                begin
                    IF ItemRec.GET(ItemNo) THEN BEGIN

                        //ItemRec."Shelf Location HSK" := selfd;
                        ItemRec."Complete Description" := cd;
                        ItemRec.Description := cd1;
                        ItemRec."Description 2" := cd2;
                        ItemRec."Quality Code" := qty;
                        ItemRec.VALIDATE("Quality Code");
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
}

