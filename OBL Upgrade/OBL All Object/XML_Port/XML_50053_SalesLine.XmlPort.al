xmlport 50053 "Sales Line"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("salesline set")
        {
            XmlName = 'SalesLine';
            tableelement("Sales Line"; 37)
            {
                XmlName = 'Saleslineupdate';
                textelement(DN)
                {
                }
                textelement(ln)
                {
                }
                textelement(cust)
                {
                }
                textelement(ite)
                {
                }
                textelement(lc)
                {
                }
                textelement(qty)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    salline: Record "Sales Line";
                begin

                    "Sales Line"."Document Type" := "Sales Line"."Document Type"::Order;
                    "Sales Line"."Document No." := DN;
                    EVALUATE(line, ln);
                    "Sales Line"."Line No." := line;
                    "Sales Line"."Sell-to Customer No." := cust;
                    "Sales Line".VALIDATE("Sell-to Customer No.");
                    "Sales Line".Type := "Sales Line".Type::Item;
                    "Sales Line"."No." := ite;
                    "Sales Line".VALIDATE("No.");
                    "Sales Line"."Location Code" := lc;
                    "Sales Line".VALIDATE("Location Code");
                    "Sales Line"."Shortcut Dimension 1 Code" := lc;
                    EVALUATE(quan, qty);
                    "Sales Line".Quantity := quan;
                    "Sales Line".VALIDATE(Quantity);


                    //ItemRec.MODIFY;
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
    begin
        IF (UPPERCASE(USERID) <> 'FA028') AND (UPPERCASE(USERID) <> 'MA028') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
            ERROR('You are not Authorized');
    end;

    var
        doc: Option;
        line: Decimal;
        type: Option;
        quan: Decimal;
}

