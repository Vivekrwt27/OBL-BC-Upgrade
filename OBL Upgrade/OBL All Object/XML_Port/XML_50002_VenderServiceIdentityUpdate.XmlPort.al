xmlport 50002 "Vender Service Identity Update"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("vender set")
        {
            XmlName = 'Venderupdate';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'VendoerIdendity';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(VendorNo)
                {
                }
                textelement(blocked)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    VendRec: Record Vendor;
                begin
                    IF VendRec.GET(VendorNo) THEN BEGIN
                        //  EVALUATE(gsttype,ServiceT);
                        //  VendRec."GST Vendor Type" := gsttype;
                        //    EVALUATE(aggre,agr);
                        //    VendRec."Aggregate Turnover" := aggre;
                        //      VendRec."Bank A/c" := ba;
                        //    EVALUATE(blk,block);
                        //    VendRec.Blocked := blk;
                        //    VendRec.Name:= na;
                        //    VendRec."Contact Mail ID" := kbs;
                        EVALUATE(blk, blocked);
                        VendRec.Blocked := blk;
                        //    VendRec."GST No." := gst;
                        //    VendRec."GST Registration No." := rgst;
                        //    VendRec.VALIDATE("GST Registration No.");
                        //VendRec."GST No." := ph;
                        //      EVALUATE(note,kbs);
                        //      VendRec."Not Required" := note;
                        //VendRec."Phone No." := ph;
                        //VendRec.VALIDATE("Phone No.");
                        //    VendRec."Landline No." := land;
                        //      VendRec."Morbi Location Code" := kbs;
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
    var
        ITEM: Record Item;
    begin
    end;

    var
        gsttype: Option;
        blk: Option;
        aggre: Option;
        note: Boolean;
}

