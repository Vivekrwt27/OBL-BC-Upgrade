tableextension 50155 tableextension50155 extends "Reminder Header"
{
    fields
    {
        /* modify("Fin. Charge Terms Code")
         {
             TableRelation = Indent;
         }*/ // 15578
    }

    //Unsupported feature: Variable Insertion (Variable: TotalAmountInclVAT) (VariableCollection) on "ReminderRounding(PROCEDURE 7)".


    //Unsupported feature: Code Modification on "ReminderRounding(PROCEDURE 7)".

    //procedure ReminderRounding();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReminderRoundingAmount := ReminderHeader.GetInvoiceRoundingAmount;

    IF ReminderRoundingAmount <> 0 THEN BEGIN
      CustPostingGr.GET(ReminderHeader."Customer Posting Group");
      CustPostingGr.TESTFIELD("Invoice Rounding Account");
    #6..19
        INSERT;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetCurrency(ReminderHeader);
    IF Currency."Invoice Rounding Precision" = 0 THEN
      EXIT;

    ReminderHeader.CALCFIELDS(
      "Remaining Amount","Interest Amount","Additional Fee","VAT Amount","Add. Fee per Line");

    TotalAmountInclVAT := ReminderHeader."Remaining Amount" +
      ReminderHeader."Interest Amount" +
      ReminderHeader."Additional Fee" +
      ReminderHeader."Add. Fee per Line" +
      ReminderHeader."VAT Amount";
    ReminderRoundingAmount :=
      -ROUND(
        TotalAmountInclVAT -
        ROUND(
          TotalAmountInclVAT,
          Currency."Invoice Rounding Precision",
          Currency.InvoiceRoundingDirection),
        Currency."Amount Rounding Precision");
    #3..22
    */
    //end;
}

