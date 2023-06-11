xmlport 50024 "Update Sales Header"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("sales head")
        {
            XmlName = 'SalesHeader';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'SalesHeader';
                textelement(orderno)
                {
                    XmlName = 'OrderNo';
                }
                textelement(custno)
                {
                    XmlName = 'custno';
                }

                trigger OnBeforeInsertRecord()
                var
                    Saleshead: Record "Sales Header" temporary;
                begin
                    IF Saleshead.GET(OrderNo) THEN BEGIN
                        Saleshead."Sell-to Customer No." := custno;
                        //   Saleshead.VALIDATE("Sell-to Customer No.");
                        /*   Saleshead."Group Code" := gc;
                           Saleshead."Payment Terms Code" := pt;
                           Saleshead."External Document No." := ed;
                           Saleshead."Location Code" := loc;
                           Saleshead."Shortcut Dimension 1 Code" := bc;
                           Saleshead."Posting No. Series" := ps;
                           Saleshead."No. Series" := ns;*/

                        Saleshead.MODIFY;
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
}

