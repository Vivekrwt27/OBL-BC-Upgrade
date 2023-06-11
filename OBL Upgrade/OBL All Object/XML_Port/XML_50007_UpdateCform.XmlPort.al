xmlport 50007 "Update C-form"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("no. set")
        {
            XmlName = 'Cformupdate';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'MinMaxInventory';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(invno)
                {
                    XmlName = 'InvNo';
                }
                textelement(cform)
                {
                    XmlName = 'Cform';
                }
                textelement(cformdate)
                {
                    XmlName = 'Cformdate';
                }

                trigger OnBeforeInsertRecord()
                var
                    cformrec: Record "C-form";
                begin
                    IF cformrec.GET(InvNo) THEN BEGIN
                        cformrec."C Form No." := Cform;
                        EVALUATE(Cfd, Cformdate);
                        cformrec."C Form Recd Date" := Cfd;
                        cformrec.MODIFY
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
        Cfd: Date;
}

