xmlport 50076 "Pinaki Sir Report"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("Sales Jpurnal Data"; 50077)
            {
                XmlName = 'Salesjournal';
                fieldelement(a; "Sales Jpurnal Data"."Entry No.")
                {
                }
                fieldelement(b; "Sales Jpurnal Data"."Item Code")
                {
                }
                fieldelement(c; "Sales Jpurnal Data"."State Description")
                {
                }
                fieldelement(d; "Sales Jpurnal Data"."Invoice No.")
                {
                }
                fieldelement(e; "Sales Jpurnal Data"."Posting Date")
                {
                }
                fieldelement(f; "Sales Jpurnal Data"."Customer Name")
                {
                }
                fieldelement(h; "Sales Jpurnal Data"."Item Description")
                {
                }
                fieldelement(i; "Sales Jpurnal Data"."ERP Size")
                {
                }
                fieldelement(j; "Sales Jpurnal Data"."Type Code Description")
                {
                }
                fieldelement(k; "Sales Jpurnal Data"."Type Category Code")
                {
                }
                fieldelement(l; "Sales Jpurnal Data".CRT)
                {
                }
                fieldelement(m; "Sales Jpurnal Data"."Unit of Measure")
                {
                }
                fieldelement(n; "Sales Jpurnal Data"."Sq. Mt.")
                {
                }
                fieldelement(o; "Sales Jpurnal Data"."Basic Amount")
                {
                }
                fieldelement(p; "Sales Jpurnal Data"."Excise Duty")
                {
                }
                fieldelement(q; "Sales Jpurnal Data"."Excise Amount")
                {
                }
                fieldelement(r; "Sales Jpurnal Data".AD1)
                {
                }
                fieldelement(s; "Sales Jpurnal Data".AD2)
                {
                }
                fieldelement(t; "Sales Jpurnal Data".AD3)
                {
                }
                fieldelement(u; "Sales Jpurnal Data".AD4)
                {
                }
                fieldelement(v; "Sales Jpurnal Data".AD5)
                {
                }
                fieldelement(w; "Sales Jpurnal Data".AD6)
                {
                }
                fieldelement(x; "Sales Jpurnal Data".AD7)
                {
                }
                fieldelement(y; "Sales Jpurnal Data"."Total AD")
                {
                }
                fieldelement(z; "Sales Jpurnal Data".QD)
                {
                }
                fieldelement(aa; "Sales Jpurnal Data".AQD)
                {
                }
                fieldelement(ab; "Sales Jpurnal Data".Value)
                {
                }
                fieldelement(ac; "Sales Jpurnal Data"."Cash Discount")
                {
                }
                fieldelement(ad; "Sales Jpurnal Data"."Sales Value")
                {
                }
                fieldelement(ae; "Sales Jpurnal Data".Frieght)
                {
                }
                fieldelement(af; "Sales Jpurnal Data"."Insurance Charge")
                {
                }
                fieldelement(ag; "Sales Jpurnal Data"."Entry Tax")
                {
                }
                fieldelement(ah; "Sales Jpurnal Data".VAT)
                {
                }
                fieldelement(ai; "Sales Jpurnal Data"."VAT Cess")
                {
                }
                fieldelement(aj; "Sales Jpurnal Data"."GST%")
                {
                }
                fieldelement(ak; "Sales Jpurnal Data"."Total GST")
                {
                }
                fieldelement(al; "Sales Jpurnal Data"."Total Tax")
                {
                }
                fieldelement(am; "Sales Jpurnal Data"."Net Value")
                {
                }
                fieldelement(an; "Sales Jpurnal Data"."Item Classification")
                {
                }
                fieldelement(ao; "Sales Jpurnal Data"."Item Category Code")
                {
                }
                fieldelement(ap; "Sales Jpurnal Data"."Group Code")
                {
                }
                fieldelement(aq; "Sales Jpurnal Data"."Quality Code")
                {
                }
                fieldelement(ar; "Sales Jpurnal Data"."Location Code")
                {
                }
                fieldelement(as; "Sales Jpurnal Data".Pay)
                {
                }
                fieldelement(at; "Sales Jpurnal Data"."Customer Code")
                {
                }
                fieldelement(au; "Sales Jpurnal Data"."Customer Name")
                {
                }
                fieldelement(av; "Sales Jpurnal Data"."Customer City")
                {
                }
                fieldelement(aw; "Sales Jpurnal Data"."Customer Type")
                {
                }
                fieldelement(ay; "Sales Jpurnal Data"."Sales Line Sales Type")
                {
                }
                fieldelement(az; "Sales Jpurnal Data"."Dealer Code")
                {
                }
                fieldelement(ba; "Sales Jpurnal Data"."S/O No.")
                {
                }
                fieldelement(bb; "Sales Jpurnal Data"."Make SO Date")
                {
                }
                fieldelement(bc; "Sales Jpurnal Data"."Releasing Date")
                {
                }
                fieldelement(bd; "Sales Jpurnal Data"."MRP /BOX")
                {
                }
                fieldelement(ne; "Sales Jpurnal Data"."MRP /Sqm")
                {
                }
                fieldelement(bf; "Sales Jpurnal Data"."AD1/Sqm")
                {
                }
                textelement("sales jpurnal data::ad2/sqm")
                {
                    XmlName = 'bz';
                }
                fieldelement(a1; "Sales Jpurnal Data"."AD3/Sqm")
                {
                }
                fieldelement(a2; "Sales Jpurnal Data"."AD4/Sqm")
                {
                }
                fieldelement(a3; "Sales Jpurnal Data"."AD5/Sqm")
                {
                }
                fieldelement(a4; "Sales Jpurnal Data"."AD6/Sqm")
                {
                }
                fieldelement(a5; "Sales Jpurnal Data"."AD7/Sqm")
                {
                }
                fieldelement(a6; "Sales Jpurnal Data"."Total AD/Sqm")
                {
                }
                fieldelement(a7; "Sales Jpurnal Data"."Billing Rate/Sqm")
                {
                }
                fieldelement(a8; "Sales Jpurnal Data"."Buyer Rate/Sqm")
                {
                }
                fieldelement(a9; "Sales Jpurnal Data"."Offer Code")
                {
                }
                fieldelement(a10; "Sales Jpurnal Data"."External Doc. No.")
                {
                }
                fieldelement(a11; "Sales Jpurnal Data"."Form Code")
                {
                }
                fieldelement(a12; "Sales Jpurnal Data"."Transport Method")
                {
                }
                fieldelement(a13; "Sales Jpurnal Data"."Cust. Price Group")
                {
                }
                fieldelement(a14; "Sales Jpurnal Data"."GR No.")
                {
                }
                fieldelement(a15; "Sales Jpurnal Data"."GR Date")
                {
                }
                fieldelement(a16; "Sales Jpurnal Data"."Sales Line Remark")
                {
                }
                fieldelement(a17; "Sales Jpurnal Data"."GR Value")
                {
                }
                fieldelement(a18; "Sales Jpurnal Data"."Variable Cost")
                {
                }
                fieldelement(a19; "Sales Jpurnal Data"."Truck No.")
                {
                }
                fieldelement(a20; "Sales Jpurnal Data"."LR No.")
                {
                }
                fieldelement(a21; "Sales Jpurnal Data"."Transported Name")
                {
                }
                fieldelement(a22; "Sales Jpurnal Data"."PCH Name")
                {
                }
                fieldelement(a23; "Sales Jpurnal Data"."Govt. SP. Resp.")
                {
                }
                fieldelement(a24; "Sales Jpurnal Data"."Private SP .Resp.")
                {
                }
                fieldelement(a25; "Sales Jpurnal Data"."Branch Code")
                {
                }
                fieldelement(a26; "Sales Jpurnal Data"."ORC Terms")
                {
                }
                fieldelement(a27; "Sales Jpurnal Data"."Sales Line Sales Type")
                {
                }
                fieldelement(a28; "Sales Jpurnal Data"."Ship-to City")
                {
                }
                fieldelement(a29; "Sales Jpurnal Data"."Trf/Pur Price")
                {
                }
                fieldelement(a30; "Sales Jpurnal Data"."GST No")
                {
                }
                fieldelement(a31; "Sales Jpurnal Data"."Trade Discount")
                {
                }
                fieldelement(a32; "Sales Jpurnal Data"."Other Claim")
                {
                }
                fieldelement(a33; "Sales Jpurnal Data"."Insurance Claim")
                {
                }
                fieldelement(a34; "Sales Jpurnal Data"."AD Remarks")
                {
                }
                fieldelement(a35; "Sales Jpurnal Data"."Order Processed Date")
                {
                }
                fieldelement(a36; "Sales Jpurnal Data"."Promise Delivery Date")
                {
                }
                fieldelement(a37; "Sales Jpurnal Data"."Business Development")
                {
                }
                fieldelement(a38; "Sales Jpurnal Data"."Govt. Project Sales")
                {
                }
                fieldelement(a39; "Sales Jpurnal Data"."Orient Bell Boutique")
                {
                }
                fieldelement(a40; "Sales Jpurnal Data".CKA)
                {
                }
                fieldelement(a41; "Sales Jpurnal Data".Retail)
                {
                }
                fieldelement(a42; "Sales Jpurnal Data"."Ref Code")
                {
                }
                fieldelement(a43; "Sales Jpurnal Data"."Tableau Product Code")
                {
                }
                fieldelement(a44; "Sales Jpurnal Data".Zone)
                {
                }
                fieldelement(a45; "Sales Jpurnal Data"."PMT Code")
                {
                }
                fieldelement(a46; "Sales Jpurnal Data"."Cust. Price Group")
                {
                }
                fieldelement(a47; "Sales Jpurnal Data"."Order Received Date")
                {
                }
                fieldelement(a48; "Sales Jpurnal Data"."Gross Weight")
                {
                }
                fieldelement(a49; "Sales Jpurnal Data"."Net Weight")
                {
                }
                fieldelement(a50; "Sales Jpurnal Data".Week)
                {
                }
                fieldelement(a51; "Sales Jpurnal Data".Month)
                {
                }
                fieldelement(a52; "Sales Jpurnal Data"."Month No")
                {
                }
                fieldelement(a53; "Sales Jpurnal Data".Quarter)
                {
                }
                fieldelement(a54; "Sales Jpurnal Data"."Financial Year")
                {
                }
                fieldelement(a55; "Sales Jpurnal Data".Zone)
                {
                }
                fieldelement(a56; "Sales Jpurnal Data"."Cust Parent Code")
                {
                }
                fieldelement(a57; "Sales Jpurnal Data"."Sales Person Code")
                {
                }
                fieldelement(a58; "Sales Jpurnal Data"."Sales Person Name")
                {
                }
                fieldelement(a59; "Sales Jpurnal Data".Day)
                {
                }
                fieldelement(a60; "Sales Jpurnal Data"."SKU Cat.")
                {
                }
                fieldelement(a61; "Sales Jpurnal Data"."Sale Type")
                {
                }
                fieldelement(a62; "Sales Jpurnal Data".Enterprises)
                {
                }
                fieldelement(a63; "Sales Jpurnal Data"."Get Type")
                {
                }
                fieldelement(a64; "Sales Jpurnal Data".Territory)
                {
                }
                fieldelement(a65; "Sales Jpurnal Data"."Customer Type2")
                {
                }
                fieldelement(a66; "Sales Jpurnal Data"."NPD Type")
                {
                }
                fieldelement(a67; "Sales Jpurnal Data".Ashwamedha)
                {
                }
                fieldelement(a68; "Sales Jpurnal Data".OBTB)
                {
                }
                fieldelement(a69; "Sales Jpurnal Data"."OBTB New/Existing")
                {
                }
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
}

