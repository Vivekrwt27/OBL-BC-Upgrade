xmlport 50059 "update Sales Person"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("salesperson set")
        {
            XmlName = 'Salesperson';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'Salesperson';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(salecode)
                {
                    XmlName = 'Salecode';
                }
                textelement(dsi)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    sprec: Record "Salesperson/Purchaser";
                begin
                    IF sprec.GET(Salecode) THEN BEGIN
                        //   sprec."HQ Town" := hq;
                        //EVALUATE(jd,hq);
                        //sprec."Joining Date" := jd;
                        EVALUATE(dso, dsi);
                        sprec."Last Year DSO" := dso;
                        //   EVALUATE(acp,asp);
                        //   sprec."Last Year ASP" := acp;
                        //EVALUATE(spt,sptype);
                        //sprec."Employee Type":=spt;
                        //EVALUATE(lyrt,vlyrt);
                        //sprec."Last Year Range Target":=lyrt;

                        sprec.MODIFY;
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
        SPrec: Record "Salesperson/Purchaser";
    begin
    end;

    var
        jd: Date;
        acp: Decimal;
        dso: Decimal;
        spt: Option;
        lyrt: Decimal;
}

