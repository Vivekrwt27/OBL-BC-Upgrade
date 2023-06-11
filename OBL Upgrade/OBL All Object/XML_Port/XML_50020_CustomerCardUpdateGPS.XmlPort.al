xmlport 50020 "Customer Card Update GPS"
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
                textelement(sp)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    VendRec: Record Customer;
                begin
                    IF VendRec.GET(VendorNo) THEN BEGIN

                        //EVALUATE(mpa,tgt);
                        //VendRec."Minmum Amt pur value" := mpa;
                        //EVALUATE(qt,cgt);
                        //VendRec."Qtr Target" := qt;
                        //EVALUATE(msp,ms);
                        //VendRec."Month Sales Plan" := msp;
                        //EVALUATE(mcp,mc);
                        //VendRec."Month Collection Plan" := mcp;
                        //VendRec."Customer Type" := cka;
                        //EVALUATE(dt,DATE);
                        //VendRec."Creation Date" := dt;
                        //VendRec."Mother Account Name" := cka1;
                        //VendRec."Area Code" := st;
                        //VendRec.VALIDATE("Area Code");
                        VendRec."Salesperson Code" := sp;
                        VendRec.VALIDATE("Salesperson Code");
                        //VendRec."Govt. SP Resp." := sp;
                        //VendRec.VALIDATE("Govt. SP Resp.");
                        //VendRec."PCH Code" := pch;
                        //VendRec.VALIDATE("PCH Code");
                        //VendRec."Zonal Manager" :=zm;
                        //VendRec.VALIDATE("Zonal Manager");
                        //VendRec."Zonal Head" := zh;
                        //VendRec.VALIDATE("Zonal Head");
                        //EVALUATE(COCO,co);
                        //VendRec."Coco Customer" := COCO;}
                        //EVALUATE(cusstate,cs);
                        //VendRec."Customer Status" := custstatus;
                        //  VendRec."Global Dimension 1 Code" := sp;
                        // VendRec.VALIDATE("Global Dimension 1 Code");
                        //VendRec."Tableau Zone" := pch;
                        // VendRec."Area Code" := st;
                        //VendRec.VALIDATE("Area Code");
                        //EVALUATE(cdp,grp);
                        //VendRec."Discount Group" := cdp;
                        //VendRec.Contact := cont;
                        //VendRec."Mobile No." := pho;
                        //VendRec."E-Mail" := email;
                        //EVALUATE(block,sp);
                        //VendRec.Blocked := block;
                        //VendRec."Territory Code" := trt;
                        //VendRec.VALIDATE("Territory Code");
                        //EVALUATE(cr,credit);
                        //VendRec."Credit Limit (LCY)" := cr;
                        //EVALUATE(disc,dg);
                        //VendRec."Discount Group" := disc;
                        /*EVALUATE(mpa,a);
                        VendRec."Minmum Amt pur value" := mpa;
                        EVALUATE(qt,b);
                        VendRec."Qtr Target" := qt;
                        EVALUATE(msp,c);
                        VendRec."Month Sales Plan" := msp;
                        EVALUATE(mcp,c);
                        VendRec."Month Collection Plan" := mcp;*/
                        //    VendRec."Customer Price Group" := cpg;
                        //    EVALUATE(dt,date);
                        //    VendRec."Last Credit Rating Process" := dt;
                        //  EVALUATE(ccx,cx);
                        // VendRec."CXO Tie Up" := ccx;
                        //  EVALUATE(msp,tgt);
                        //  VendRec."CXO Target" := msp;
                        //EVALUATE(mpa,sp);
                        //VendRec."ACP (Last 12m)" := mpa;
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
}

