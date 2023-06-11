xmlport 50003 "Customer Card Update"
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

                        // EVALUATE(mpa,tgt);
                        //VendRec."Minmum Amt pur value" := mpa;
                        //EVALUATE(qt,cgt);
                        //VendRec."Qtr Target" := qt;
                        //EVALUATE(msp,ms);
                        //VendRec."Month Sales Plan" := msp;
                        //EVALUATE(mcp,mc);
                        //VendRec."Month Collection Plan" := mcp;
                        //EVALUATE(dt,DATE);
                        //VendRec."Creation Date" := dt;
                        //VendRec."Mother Account Name" := cka1;
                        // VendRec."Area Code" := st;
                        //  VendRec.VALIDATE("Area Code");
                        VendRec."Salesperson Code" := sp;
                        VendRec.VALIDATE("Salesperson Code");
                        //VendRec."Virtual ID" := sp;
                        // VendRec."Govt. SP Resp." := sp;
                        //   VendRec.VALIDATE("Govt. SP Resp.");
                        // VendRec."PCH Code" := bh;
                        //  VendRec.VALIDATE("PCH Code");
                        //  VendRec."Zonal Manager" :=zm;
                        //   VendRec.VALIDATE("Zonal Manager");
                        //     VendRec."Zonal Head" := zh;
                        //     VendRec.VALIDATE("Zonal Head");
                        //EVALUATE(cusstate,cs);
                        //VendRec."Customer Status" := custstatus;
                        //  VendRec."Global Dimension 1 Code" := sp;
                        // VendRec.VALIDATE("Global Dimension 1 Code");
                        //  VendRec."Tableau Zone" := tz;
                        //  VendRec.Zone := z;
                        //
                        //  VendRec."Customer Type" := cka;
                        //EVALUATE(cdp,grp);
                        //VendRec."Discount Group" := cdp;
                        //VendRec.Contact := cont;
                        //VendRec."Mobile No." := pho;
                        //VendRec."E-Mail" := email;
                        // EVALUATE(block,blk);
                        //  VendRec.Blocked := block;
                        // VendRec."Area Code" := trt;
                        //VendRec.VALIDATE("Area Code");
                        //EVALUATE(cr,credit);
                        //VendRec."Credit Limit (LCY)" := cr;
                        //EVALUATE(disc,dg);
                        //VendRec."Discount Group" := disc;
                        //EVALUATE(mpa,a);
                        //VendRec."Minmum Amt pur value" := mpa;
                        //EVALUATE(qt,b);
                        //VendRec."Qtr Target" := qt;
                        //EVALUATE(msp,c);
                        //endRec."Month Sales Plan" := msp;
                        //EVALUATE(mcp,c);
                        //VendRec."Month Collection Plan" := mcp;}
                        //    VendRec."Customer Price Group" := cpg;
                        //    EVALUATE(dt,date);
                        //    VendRec."Last Credit Rating Process" := dt;
                        //  EVALUATE(ccx,cx);
                        // VendRec."CXO Tie Up" := ccx;
                        //  EVALUATE(msp,tgt);
                        //  VendRec."CXO Target" := msp;
                        // EVALUATE(mpa,sps);
                        // VendRec."ACP (Previous Year)" := acp;
                        ////  VendRec."ACD (Previous Year)" := acp1;
                        //   VendRec."ACP (Current Year)" :=acp2;
                        //   VendRec."ACPD (Current Year)" := acp3;

                        //EVALUATE(lati,lt);
                        //VendRec.Latitude := lati;
                        //EVALUATE(long,lg);
                        //VendRec.Longitude :=long;
                        //EVALUATE(pcx,cx);
                        //VendRec."PCH Tie Up" := pcx;
                        //VendRec."Pin Code" := bh;
                        //EVALUATE(secamt,SECA);
                        //VendRec."Security Amount" := secamt;
                        //EVALUATE(secdate,SECD);
                        //VendRec."Security Date" := secdate;
                        // VendRec."CC Team" := sp;
                        //  VendRec.VALIDATE("CC Team");
                        //EVALUATE(dt,st);
                        //  VendRec."Balance Conf Recd Date":=dt ;
                        //  EVALUATE(COCO,bc);
                        //   VendRec."Balance Confirmation" := COCO;
                        // VendRec.Outbreaks := out;
                        //EVALUATE(dt,date);
                        // VendRec."Revival Date":= dt;

                        //VendRec."Pop Tag" := pop;
                        //VendRec.Population := pop;
                        // VendRec."P.A.N. No." := pan;
                        //VendRec."Telex Answer Back" := tlx;
                        // VendRec."Sold By" := sb;
                        //VendRec."Virtual ID" := vi;
                        //  EVALUATE(COCO,note);
                        //  VendRec."Not Required" := COCO;
                        // EVALUATE(year21,fy21);
                        //  VendRec."Billing FY21" := year21;
                        //   EVALUATE(year22,fy22);
                        // VendRec."Billing FY22" := year22;

                        //VendRec."Created By" := cb;

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
        year21: Decimal;
        year22: Decimal;
}

