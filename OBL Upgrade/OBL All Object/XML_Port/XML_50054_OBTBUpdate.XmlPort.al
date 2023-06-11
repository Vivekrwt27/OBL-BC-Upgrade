xmlport 50054 "OBTB Update"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("customer set")
        {
            XmlName = 'Venderupdate';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'CustomerCardUpdate';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(VendorNo)
                {
                }
                textelement(jd)
                {
                }
                textelement(cd)
                {
                }
                textelement(qj)
                {
                }
                textelement(co)
                {
                }
                textelement(ts)
                {
                }
                textelement(te)
                {
                }
                textelement(ft)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    VendRec: Record Customer;
                begin
                    IF VendRec.GET(VendorNo) THEN BEGIN

                        EVALUATE(joinin, jd);
                        VendRec."OBTB Joining Date" := joinin;
                        EVALUATE(Closing, cd);
                        VendRec."OBTB Closing Date" := Closing;
                        EVALUATE(qjoining, qj);
                        VendRec."QL Joining Date" := qjoining;
                        EVALUATE(COCO, co);
                        VendRec."Coco Customer" := COCO;
                        EVALUATE(tstart, ts);
                        VendRec."OBTB Target Start Date" := tstart;
                        EVALUATE(tend, te);
                        VendRec."OBTB Target End Date" := tend;
                        EVALUATE(first, ft);
                        VendRec."OBTB Target First year" := first;
                        VendRec.MODIFY;

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
        cfd: Date;
        value: Decimal;
        custstatus: Option;
        custcat: Option;
        block: Option;
        dt: Date;
        COCO: Boolean;
        cusstate: Option;
        cdp: Option;
        cr: Decimal;
        disc: Option;
        mpa: Decimal;
        qt: Decimal;
        msp: Decimal;
        mcp: Decimal;
        ccx: Boolean;
        joinin: Date;
        lati: Decimal;
        long: Decimal;
        first: Decimal;
        second: Decimal;
        third: Decimal;
        pcx: Boolean;
        secamt: Decimal;
        secdate: Date;
        Closing: Date;
        qjoining: Date;
        tstart: Date;
        tend: Date;
}

