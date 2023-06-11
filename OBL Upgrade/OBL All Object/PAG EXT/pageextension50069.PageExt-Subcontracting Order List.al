pageextension 50069 pageextension50069 extends "Subcontracting Order List"
{
    actions
    {
        modify(Card)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                CASE rec."Document Type" OF
                    rec."Document Type"::Quote:
                        PAGE.RUN(PAGE::"Purchase Quote", Rec);
                    rec."Document Type"::"Blanket Order":
                        PAGE.RUN(PAGE::"Blanket Purchase Order", Rec);
                    rec."Document Type"::Order:
                        BEGIN
                            IF NOT rec.Subcontracting THEN
                                PAGE.RUN(PAGE::"Purchase Order Subform", Rec) // code added in upgrade
                            ELSE
                                PAGE.RUN(PAGE::"Subcontracting Order", Rec);
                        END;
                    rec."Document Type"::Invoice:
                        PAGE.RUN(PAGE::"Purchase Invoice", Rec);
                    rec."Document Type"::"Return Order":
                        PAGE.RUN(PAGE::"Purchase Return Order", Rec);
                    rec."Document Type"::"Credit Memo":
                        PAGE.RUN(PAGE::"Purchase Credit Memo", Rec);
                END;

            end;
        }

    }

}

