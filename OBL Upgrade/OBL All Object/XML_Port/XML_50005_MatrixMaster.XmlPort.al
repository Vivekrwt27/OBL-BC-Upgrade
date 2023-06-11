xmlport 50005 "Matrix Master"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("matrix master set")
        {
            XmlName = 'Venderupdate';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'CustomerCardUpdate';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(Salesterr)
                {
                }
                textelement(rets)
                {
                }
                textelement(sal1)
                {
                }
                textelement(sal2)
                {
                }
                textelement(sal3)
                {
                }
                textelement(sal4)
                {
                }
                textelement(sal5)
                {
                }
                textelement(co1)
                {
                }
                textelement(co2)
                {
                }
                textelement(co3)
                {
                }
                textelement(co4)
                {
                }
                textelement(co5)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    Salesterritory: Record "Matrix Master";
                begin
                    //IF Salesterritory.GET(Salesterr) THEN BEGIN
                    Salesterritory.RESET;
                    Salesterritory.SETRANGE("Type 1", Salesterr);
                    IF Salesterritory.FINDFIRST THEN BEGIN
                        MESSAGE(Salesterr);

                        EVALUATE(rst, rets);
                        //Salesterritory."Annual Target" := aultgt;
                        //Salesterritory."Q1 Tgt" := qt:
                        Salesterritory."Retail Sales Tgt" := rst;
                        //Salesterritory."Enterprise Tgt";
                        EVALUATE(s1, sal1);
                        Salesterritory."Sales Tgt Phasing 1-7" := s1;
                        EVALUATE(s2, sal2);
                        Salesterritory."Sales Tgt Phasing 8-14" := s2;
                        EVALUATE(s3, sal3);
                        Salesterritory."Sales Tgt Phasing 15-21" := s3;
                        EVALUATE(s4, sal4);
                        Salesterritory."Sales Tgt Phasing 22-27" := s4;
                        EVALUATE(s5, sal5);
                        Salesterritory."Sales Tgt Phasing 28-30" := s5;
                        EVALUATE(c1, co1);
                        Salesterritory."Collection Phasing 1-7" := c1;
                        EVALUATE(c2, co2);
                        Salesterritory."Collection Phasing 8-14" := c2;
                        EVALUATE(c3, co3);
                        Salesterritory."Collection Phasing 15-21" := c3;
                        EVALUATE(c4, co4);
                        Salesterritory."Collection Phasing 22-27" := c4;
                        EVALUATE(c5, co5);
                        Salesterritory."Collection Phasing 28-30" := c5;
                        //Salesterritory."Enterprise SP Tgt Direct"
                        //Salesterritory."Enterprise SP Tgt Indirect"
                        //Salesterritory."Collection Plan For Month"
                        //Salesterritory."Tgt CP"
                        //Salesterritory."Tgt CP Q1"
                        //Salesterritory."Tgt CP Month"

                        Salesterritory.MODIFY;

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
        rst: Decimal;
        s1: Decimal;
        s2: Decimal;
        s3: Decimal;
        s4: Decimal;
        s5: Decimal;
        c1: Decimal;
        c2: Decimal;
        c3: Decimal;
        c4: Decimal;
        c5: Decimal;
}

