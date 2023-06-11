tableextension 50159 tableextension50159 extends "Finance Charge Memo Header"
{
    fields
    {
        /* modify("Fin. Charge Terms Code")
         {
             TableRelation = Indent;
         }*/
    }

    //Unsupported feature: Variable Insertion (Variable: TotalAmountInclVAT) (VariableCollection) on "FinanceChargeRounding(PROCEDURE 10)".


    //Unsupported feature: Code Modification on "FinanceChargeRounding(PROCEDURE 10)".

    //procedure FinanceChargeRounding();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FinanceChargeRoundingAmount := FinanceChargeHeader.GetInvoiceRoundingAmount;

    IF FinanceChargeRoundingAmount <> 0 THEN BEGIN
      CustPostingGr.GET(FinanceChargeHeader."Customer Posting Group");
      CustPostingGr.TESTFIELD("Invoice Rounding Account");
    #6..17
        INSERT;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetCurrency(FinanceChargeHeader);
    IF Currency."Invoice Rounding Precision" = 0 THEN
      EXIT;

    FinanceChargeHeader.CALCFIELDS(
      "Interest Amount","Additional Fee","VAT Amount");

    TotalAmountInclVAT := FinanceChargeHeader."Interest Amount" +
      FinanceChargeHeader."Additional Fee" +
      FinanceChargeHeader."VAT Amount";
    FinanceChargeRoundingAmount :=
      -ROUND(
        TotalAmountInclVAT -
        ROUND(
          TotalAmountInclVAT,
          Currency."Invoice Rounding Precision",
          Currency.InvoiceRoundingDirection),
        Currency."Amount Rounding Precision");
    #3..20
    */
    //end;
}

