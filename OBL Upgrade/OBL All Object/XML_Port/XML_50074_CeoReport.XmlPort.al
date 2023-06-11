xmlport 50074 "Ceo Report"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("EYAIM_ERP 108DFs Report"; 50096)
            {
                XmlName = 'Salesprice';
                /*fieldelement(a; "Inventory Report Ageing Data".SuggestedResponse)
                {
                }
                fieldelement(b; "Inventory Report Ageing Data"."TaxPeriod-GSTR 3B")
                {
                }
                fieldelement(c; "Inventory Report Ageing Data".MatchReason)
                {
                }
                fieldelement(d; "Inventory Report Ageing Data"."TaxPeriod(2A)")
                {
                }
                fieldelement(e; "Inventory Report Ageing Data"."DocumentNumber(PR)")
                {
                }
                fieldelement(f; "Inventory Report Ageing Data"."TaxableValue(2A)")
                {
                }
                fieldelement(g; "Inventory Report Ageing Data"."CGST(PR)")
                {
                }
                fieldelement(h; "Inventory Report Ageing Data"."GSTR3B-FilingStatus")
                {
                }
                fieldelement(i; "Inventory Report Ageing Data"."BillOfEntry(PR)")
                {
                }
                fieldelement(j; "Inventory Report Ageing Data"."SupplyType(PR)")
                {
                }
                fieldelement(k; "Inventory Report Ageing Data".SourceIdentifier)
                {
                }
                fieldelement(l; "Inventory Report Ageing Data".VendorRiskCategory)
                {
                }
                fieldelement(m; "Inventory Report Ageing Data".KeyDescription)
                {
                }
                fieldelement(n; "Inventory Report Ageing Data"."Recon Generated Date")
                {
                }
                fieldelement(o; "Inventory Report Ageing Data"."Reverse Integrated Date")
                {
                }*/// 16767
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

