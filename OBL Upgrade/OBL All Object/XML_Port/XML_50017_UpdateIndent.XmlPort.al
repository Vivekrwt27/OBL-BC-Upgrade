xmlport 50017 "Update Indent"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("indent header set")
        {
            XmlName = 'MinMaxInventory';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'MinMaxInventory';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(indhead)
                {
                    XmlName = 'indhead';
                }
                textelement(stat)
                {
                    XmlName = 'stat';
                }

                trigger OnBeforeInsertRecord()
                var
                    indentrec: Record "Indent Header";
                begin
                    IF indentrec.GET(indhead) THEN BEGIN
                        EVALUATE(status, stat);
                        indentrec.Status := status;
                        indentrec.MODIFY;
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
        indentrec: Record "Indent Header";
    begin
    end;

    var
        status: Option;
}

