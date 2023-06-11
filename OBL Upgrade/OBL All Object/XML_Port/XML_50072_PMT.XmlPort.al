xmlport 50072 PMT
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("PMT Discount Master"; 50022)
            {
                XmlName = 'Salesprice';
                fieldelement(a; "PMT Discount Master"."PMT ID")
                {
                }
                fieldelement(b; "PMT Discount Master"."Lead ID")
                {
                }
                fieldelement(c; "PMT Discount Master"."Item No.")
                {
                }
                fieldelement(d; "PMT Discount Master"."Price Validaty")
                {
                }
                fieldelement(e; "PMT Discount Master"."Discount Amount")
                {
                }
                fieldelement(f; "PMT Discount Master".Location)
                {
                }
                fieldelement(g; "PMT Discount Master"."Customer No.")
                {
                }
                fieldelement(h; "PMT Discount Master"."Creation Date & Time")
                {
                }
                fieldelement(i; "PMT Discount Master"."Created By")
                {
                }
                fieldelement(j; "PMT Discount Master"."PMT Qty.")
                {
                }
                fieldelement(k; "PMT Discount Master"."Order Qty.")
                {
                }
                fieldelement(l; "PMT Discount Master"."Despatch Qty.")
                {
                }
                fieldelement(m; "PMT Discount Master"."Remaining Qty.")
                {
                }
                fieldelement(n; "PMT Discount Master".Closed)
                {
                }
                fieldelement(o; "PMT Discount Master"."Cash Discount")
                {
                }
                fieldelement(p; "PMT Discount Master"."Project Name")
                {
                }
                fieldelement(q; "PMT Discount Master".Tolerance)
                {
                }
                fieldelement(r; "PMT Discount Master"."First Inv Date")
                {
                }
                fieldelement(s; "PMT Discount Master"."Last Inv Date")
                {
                }
                fieldelement(t; "PMT Discount Master"."Total AD")
                {
                }
                fieldelement(u; "PMT Discount Master"."Actual AD")
                {
                }
                fieldelement(v; "PMT Discount Master"."Sales Return")
                {
                }
                fieldelement(w; "PMT Discount Master"."Ship To Address")
                {
                }
                fieldelement(x; "PMT Discount Master"."Ship To Pin")
                {
                }
                fieldelement(y; "PMT Discount Master"."PMT Creation Date")
                {
                }
                fieldelement(z; "PMT Discount Master"."Ship To Address 2")
                {
                }
                fieldelement(aa; "PMT Discount Master"."Order Qty upto 310322")
                {
                }
                fieldelement(ab; "PMT Discount Master"."Despatch Qty. 310322")
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

