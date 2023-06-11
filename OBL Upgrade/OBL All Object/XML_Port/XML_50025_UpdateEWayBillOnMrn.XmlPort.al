xmlport 50025 "Update E-Way Bill On Mrn"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;
    FormatEvaluate = Legacy;
    Permissions = TableData "Purch. Rcpt. Header" = m;
    //16767 UseDefaultNamespace = false;

    schema
    {
        textelement("purch.recpt set")
        {
            XmlName = 'PurchRecpt';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'PostedPurchaseReceipt';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(PurchH)
                {
                }
                textelement(WayBill)
                {
                }

                trigger OnAfterInsertRecord()
                var
                    PurchRec: Record "Purch. Rcpt. Header";
                begin
                    IF PurchRec.GET(PurchH) THEN BEGIN
                        PurchRec."E-Way Bill No." := WayBill;
                        PurchRec.MODIFY;

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
}

