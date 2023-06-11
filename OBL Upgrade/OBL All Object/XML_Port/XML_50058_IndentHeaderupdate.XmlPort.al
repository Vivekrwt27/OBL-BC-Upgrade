xmlport 50058 "Indent Header update"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;


    schema
    {
        textelement(IndentHeader)
        {
            tableelement("Indent Header"; 50016)
            {
                XmlName = 'Indent';
                textelement(indentno)
                {
                }
                textelement(sta)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    Indent: Record "Indent Header";
                begin
                    IF indent.GET(indentno) THEN BEGIN
                        EVALUATE(kbs, sta);
                        "Indent Header".Status := kbs;
                        "Indent Header".VALIDATE(Status);
                        indent.MODIFY
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

    var
        kbs: Integer;
}

