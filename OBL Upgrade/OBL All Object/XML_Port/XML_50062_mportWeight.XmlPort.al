xmlport 50062 "Import Weight"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("LC Detail for Export"; 50103)
            {
                XmlName = 'Weight';
                /*  fieldelement(ItemNo; "Weighted Avg."."LC No.")
                  {
                  }
                  fieldelement(LocCode; "Weighted Avg."."Place of Discharge")
                  {
                  }
                  fieldelement(VarCode; "Weighted Avg."."Ecc No.")
                  {
                  }
                  fieldelement(PostDate; "Weighted Avg.".Tolerance)
                  {
                  }
                  fieldelement(Doc; "Weighted Avg."."Discription of Goods")
                  {
                  }
                  fieldelement(Qty; "Weighted Avg."."Proforma Invoice Date")
                  {
                  }
                  fieldelement(RQty; "Weighted Avg.".Field30)
                  {
                  }
                  fieldelement(CostActial; "Weighted Avg.".Field35)
                  {
                  }
                  fieldelement(CostExpected; "Weighted Avg.".Field40)
                  {
                  }
                  fieldelement(Entryno; "Weighted Avg.".Field45)
                  {
                  }*///16767
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

