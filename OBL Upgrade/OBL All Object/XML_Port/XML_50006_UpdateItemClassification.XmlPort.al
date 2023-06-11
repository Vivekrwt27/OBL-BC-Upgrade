xmlport 50006 "Update Item Classification"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("item set")
        {
            XmlName = 'MinMaxInventory';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'MinMaxInventory';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(itemno)
                {
                    XmlName = 'ItemNo';
                }
                textelement(gs)
                {
                    XmlName = 'gs';
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record Item;
                begin
                    IF ItemRec.GET(ItemNo) THEN BEGIN
                        //ItemRec."Item Classification" := itemclass;
                        //  ItemRec.VALIDATE("Item Classification");
                        //ItemRec."Old Code" := itemclass;
                        // EVALUATE(MinInv,nw);
                        //   ItemRec."Net Weight" := MinInv;
                        //  EVALUATE(MaxInv,gw);
                        // ItemRec."Gross Weight" := MaxInv;
                        //ItemRec."Scheme Group" := sch;
                        //EVALUATE(DISGROUP,DGRP);
                        //ItemRec."Scheme Group" := DISGROUP;

                        /*
                              EVALUATE(msta,mst);
                              ItemRec."Manuf. Strategy" := msta;

                              EVALUATE(ret, itemclass);
                              ItemRec.Retained:= ret;
                              EVALUATE(liqq,vcost);
                              ItemRec.Liquidaton := liqq;
                         */
                        /*
                             EVALUATE(gwt,WT);
                             ItemRec."Gross Weight" := gwt;
                             EVALUATE(nwt,NWEIGHT);
                             ItemRec."Net Weight" := nwt;*/
                        //  EVALUATE(ret,rt);
                        //   ItemRec.Retained := ret;
                        //EVALUATE(msta,ms);
                        // ItemRec."Manuf. Strategy" := msta;
                        // ItemRec.NPD := npd;
                        // ItemRec."NPD Sub" := npk;
                        //  ItemRec."NPD Sub" := npk;
                        //    EVALUATE(Blocked,blk);
                        //    ItemRec."Not Required" := Blocked;
                        // ItemRec.Blocked := Blocked;
                        // EVALUATE(blocked1,blk1);
                        // ItemRec.Blocked2 := blocked1;
                        //ItemRec.Tariff := DGRP;
                        //ItemRec."GST Group Code" := gst;
                        //ItemRec."HSN/SAC Code" := hsn;
                        //ItemRec."Scheme Group" := sch;
                        //ItemRec.Originator := org;
                        //ItemRec.Description := desc;
                        //ItemRec."Description 2":= desc1;
                        //EVALUATE(Blocked,blk);
                        //itemRec."End Use Item" := Blocked;
                        //  EVALUATE(cost,vcost);
                        // ItemRec."V. Cost" := cost;
                        //ItemRec."Shelf Location HSK" := self;
                        //ItemRec."Old Code" := ref;
                        //ItemRec."Group Code" := grp;
                        // ItemRec."Discount Comments" := disc;
                        //EVALUATE(premimum,prem);
                        //ItemRec.Premium := premimum;
                        //ItemRec.Commercial := Comm;
                        //ItemRec."Default Prod. Plant Code" := DEF;
                        //    ItemRec."Sample Code" := sc;
                        //ItemRec."Design Code" := dsgn;
                        //ItemRec.VALIDATE("Design Code");
                        // ItemRec."Sample Group":=sg;
                        //ItemRec."Sample Code" := sg;
                        //ItemRec."Non Focused Product" := sg;
                        //EVALUATE(ret, itemclass);
                        //ItemRec."Inactive Items":= ret;
                        //ItemRec."Production BOM No." := bom;
                        //ItemRec."Prod. Consumption Item" := pc;
                        //ItemRec."Type Group Code" := tg; //For Ceo Report
                        //  ItemRec."Production Group" := tg; //For Production Planing Dashboard
                        //  ItemRec."Tableau Product Group" := tpc;
                        // ItemRec."OBTB Focused Product" := fd;
                        ItemRec."Goal Sheet Focused Product" := gs;
                        //ItemRec."NPD Sub" := WT;
                        // EVALUATE(lyer1,lyer);
                        // ItemRec.Layer := lyer1;
                        //ItemRec."Manufacturer Name" := mfg;
                        // EVALUATE(Blocked,hi);
                        // ItemRec."Hide Items" := Blocked;
                        // EVALUATE(lyer1,uc);
                        //  ItemRec."Unit Cost" := lyer1;
                        // EVALUATE(lc1,last);
                        // ItemRec."Last Direct Cost" := lc1;
                        //   ItemRec."Non Focused Product" := non;

                        /*     EVALUATE(lpp,layer1);
                             ItemRec."Layer Per Pallate" := lpp;
                             EVALUATE(bpl,box);
                             ItemRec."Box Per Layer" := bpl;
                         */
                        ItemRec.MODIFY;
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
        MaxInv: Decimal;
        MinInv: Decimal;
        ret: Boolean;
        DISGROUP: Code[10];
        msta: Option;
        Blocked: Boolean;
        blocked1: Boolean;
        gwt: Decimal;
        nwt: Decimal;
        cost: Decimal;
        liqq: Boolean;
        premimum: Boolean;
        ucost: Decimal;
        lyer1: Decimal;
        uc1: Decimal;
        lc1: Decimal;
        lpp: Decimal;
        bpl: Decimal;
}

