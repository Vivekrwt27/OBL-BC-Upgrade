xmlport 50073 "CD Entry"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("CD Entry"; 50066)
            {
                XmlName = 'Salesprice';
                fieldelement(a; "CD Entry"."Cust. Entry No.")
                {
                }
                fieldelement(b; "CD Entry"."CD Document Type")
                {
                }
                fieldelement(c; "CD Entry".Amount)
                {
                }
                fieldelement(d; "CD Entry"."Cust. No.")
                {
                }
                fieldelement(e; "CD Entry"."Posting Date")
                {
                }
                fieldelement(f; "CD Entry"."Invoice Amount")
                {
                }
                fieldelement(g; "CD Entry"."Payment Amount")
                {
                }
                fieldelement(h; "CD Entry"."CD Days")
                {
                }
                fieldelement(i; "CD Entry"."CD % age")
                {
                }
                fieldelement(j; "CD Entry"."CD Base Amount")
                {
                }
                fieldelement(k; "CD Entry"."CD Amount")
                {
                }
                fieldelement(l; "CD Entry"."State Code")
                {
                }
                fieldelement(m; "CD Entry"."Invoice No.")
                {
                }
                fieldelement(n; "CD Entry"."Due Date")
                {
                }
                fieldelement(o; "CD Entry"."Reciept Date")
                {
                }
                fieldelement(p; "CD Entry"."Insurance Amount")
                {
                }
                fieldelement(q; "CD Entry"."Sales Order No.")
                {
                }
                fieldelement(r; "CD Entry".Posted)
                {
                }
                fieldelement(s; "CD Entry"."Holidays Grace")
                {
                }
                fieldelement(t; "CD Entry"."Customer Type")
                {
                }
                fieldelement(u; "CD Entry"."Next Slab Date")
                {
                }
                fieldelement(v; "CD Entry"."Order No.")
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

