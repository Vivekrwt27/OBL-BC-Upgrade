xmlport 50027 "Sales Data"
{
    Direction = Both;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("Last Year Sales Data"; 50076)
            {
                XmlName = 'Salesprice';
                fieldelement(a; "Last Year Sales Data".DocumentType)
                {
                }
                fieldelement(b; "Last Year Sales Data"."Document No.")
                {
                }
                fieldelement(c; "Last Year Sales Data"."Line No.")
                {
                }
                fieldelement(d; "Last Year Sales Data".CustomerNo)
                {
                }
                fieldelement(e; "Last Year Sales Data".CustomerName)
                {
                }
                fieldelement(f; "Last Year Sales Data".SellToCity)
                {
                }
                fieldelement(g; "Last Year Sales Data".State)
                {
                }
                fieldelement(h; "Last Year Sales Data".CustomerType)
                {
                }
                fieldelement(i; "Last Year Sales Data".InvoiceNo)
                {
                }
                fieldelement(j; "Last Year Sales Data".PostingDate)
                {
                }
                fieldelement(k; "Last Year Sales Data".LocationCode)
                {
                }
                fieldelement(l; "Last Year Sales Data".PMTCode)
                {
                }
                fieldelement(m; "Last Year Sales Data".Order_Date)
                {
                }
                fieldelement(n; "Last Year Sales Data".Order_No)
                {
                }
                fieldelement(o; "Last Year Sales Data".ItemNo)
                {
                }
                fieldelement(p; "Last Year Sales Data".Quantity)
                {
                }
                fieldelement(q; "Last Year Sales Data".UOM)
                {
                }
                fieldelement(r; "Last Year Sales Data".Quantity_Base)
                {
                }
                fieldelement(s; "Last Year Sales Data".LineAmount)
                {
                }
                fieldelement(t; "Last Year Sales Data".AmountToCustomer)
                {
                }
                fieldelement(u; "Last Year Sales Data".Quantity_in_Sq_Mt)
                {
                }
                fieldelement(v; "Last Year Sales Data".SizeCodeDesc)
                {
                }
                fieldelement(w; "Last Year Sales Data".TabProdGrp)
                {
                }
                fieldelement(z; "Last Year Sales Data".SPCode)
                {
                }
                fieldelement(y; "Last Year Sales Data".PCHCode)
                {
                }
                fieldelement(z; "Last Year Sales Data".Tableau_Zone)
                {
                }
                fieldelement(aa; "Last Year Sales Data".Zonal_Manager)
                {
                }
                fieldelement(ab; "Last Year Sales Data".Zonal_Head)
                {
                }
                fieldelement(ac; "Last Year Sales Data".Cust_Code)
                {
                }
                fieldelement(ad; "Last Year Sales Data".Revival_Date)
                {
                }
                fieldelement(ae; "Last Year Sales Data".OBTB_Joining_Date)
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

