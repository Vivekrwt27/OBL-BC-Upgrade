xmlport 50010 "Balance Confirmation"
{
    Direction = Import;
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
                textelement(st)
                {
                }
                textelement(bc)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    VendRec: Record Customer;
                begin
                    IF VendRec.GET(VendorNo) THEN BEGIN
                        EVALUATE(dt, st);
                        VendRec."Balance Conf Recd Date" := dt;
                        EVALUATE(COCO, bc);
                        VendRec."Balance Confirmation" := COCO;
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

    trigger OnInitXmlPort()
    begin
        //IF USERID <> 'FA015' THEN
        //   ERROR('Please Contact to Saurabh Saxena');
    end;

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

