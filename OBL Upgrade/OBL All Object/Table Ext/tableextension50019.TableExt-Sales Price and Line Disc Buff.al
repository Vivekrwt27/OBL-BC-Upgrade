tableextension 50019 tableextension50019 extends "Sales Price and Line Disc Buff"
{

    //Unsupported feature: Code Modification on "CustHasLines(PROCEDURE 25)".

    //procedure CustHasLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;

    "Loaded Customer No." := Cust."No.";
    #4..9
    CLEAR(SalesLineDiscount);

    SetFiltersForSalesPriceForAllCustomers(SalesPrice);
    IF SalesPrice.COUNT > 0 THEN
      EXIT(TRUE);
    CLEAR(SalesPrice);

    #17..19
    CLEAR(SalesLineDiscount);

    SetFiltersForSalesPriceForCustPriceGr(SalesPrice);
    IF SalesPrice.COUNT > 0 THEN
      EXIT(TRUE);
    CLEAR(SalesPrice);

    #27..29
    CLEAR(SalesLineDiscount);

    SetFiltersForSalesPriceForCustomer(SalesPrice);
    IF SalesPrice.COUNT > 0 THEN
      EXIT(TRUE);

    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    IF SalesPrice.count > 0 THEN
    #14..22
    IF SalesPrice.count > 0 THEN
    #24..32
    IF SalesPrice.count > 0 THEN
    #34..36
    */
    //end;
}

