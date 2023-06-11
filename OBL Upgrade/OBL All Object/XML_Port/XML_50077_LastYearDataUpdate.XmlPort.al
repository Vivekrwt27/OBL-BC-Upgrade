xmlport 50077 "Last Year Data Update"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("sales head")
        {
            XmlName = 'SalesHeader';
            tableelement("Last Year Sales Data"; 50076)
            {
                AutoSave = false;
                XmlName = 'SalesHeader';
                textelement(orderno)
                {
                    XmlName = 'OrderNo';
                }
                textelement(itc)
                {
                    XmlName = 'itc';
                }

                trigger OnAfterGetRecord()
                begin
                    /*LastYearSalesData.RESET;
                    LastYearSalesData.SETRANGE("Document No.",OrderNo);
                    IF LastYearSalesData.FINDFIRST THEN BEGIN
                    //  LastYearSalesData.SPCode := spc1;
                    //  LastYearSalesData.PCHCode := bhc;
                    //  LastYearSalesData.Zonal_Manager := zmc;
                    //  LastYearSalesData.Zonal_Head := zhc;
                       LastYearSalesData."Area Code" := area;
                       LastYearSalesData.Tableau_Zone := tablea;
                    
                      LastYearSalesData.MODIFY;
                    END;*/

                end;

                trigger OnBeforeInsertRecord()
                var
                    Saleshead: Record "Last Year Sales Data" temporary;
                begin
                    LastYearSalesData.RESET;
                    LastYearSalesData.SETRANGE("Document No.", OrderNo);
                    IF LastYearSalesData.FINDFIRST THEN BEGIN
                        REPEAT
                            //  LastYearSalesData.SPCode := spc1;
                            //  LastYearSalesData.PCHCode := bhc;
                            //  LastYearSalesData.Zonal_Manager := zmc;
                            //  LastYearSalesData.Zonal_Head := zhc;
                            //   LastYearSalesData."Area Code" := area;
                            //   LastYearSalesData.Tableau_Zone := tablea;
                            LastYearSalesData.ItemCatCode := itc;

                            LastYearSalesData.MODIFY;
                        UNTIL LastYearSalesData.NEXT = 0;
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
        ItemREC: Record "Last Year Sales Data";
    begin
    end;

    var
        spc: Code[20];
        LastYearSalesData: Record "Last Year Sales Data";
}

