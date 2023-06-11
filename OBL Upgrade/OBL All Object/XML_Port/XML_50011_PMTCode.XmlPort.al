xmlport 50011 "PMT Code"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;
    Permissions = TableData "Sales Invoice Header" = m;

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
                textelement(EWAY)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record "Sales Invoice Header";
                begin
                    IF ItemRec.GET(ItemNo) THEN BEGIN
                        ItemRec."PMT Code" := EWAY;
                        //ItemRec."Ship to Pin" := EWAY;
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

