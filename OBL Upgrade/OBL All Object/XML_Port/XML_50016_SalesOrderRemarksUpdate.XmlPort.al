xmlport 50016 "Sales Order Remarks Update"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("customer set")
        {
            XmlName = 'Venderupdate';
            tableelement(Table2000000026; 2000000026)
            {
                AutoSave = false;
                XmlName = 'CustomerCardUpdate';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(VendorNo)
                {
                }
                textelement(remarks)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    VendRec: Record "Sales Header";
                begin
                    VendRec.SETRANGE("Document Type", VendRec."Document Type"::Order);
                    VendRec.SETRANGE("No.", VendorNo);
                    IF VendRec.FINDFIRST THEN BEGIN

                        VendRec.VALIDATE("Despatch Remarks", remarks);

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
}

