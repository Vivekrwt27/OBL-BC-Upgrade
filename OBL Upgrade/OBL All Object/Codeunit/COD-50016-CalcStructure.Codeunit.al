codeunit 50016 "Calc Structure"
{

    trigger OnRun()
    begin
    end;

    var
        SalesLine: Record "Sales Line";


    /*  procedure CalcStruct(SOrder: Record 36)
      var
          SL: Record 37;
      begin
          SOrder.CALCFIELDS(SOrder."Price Inclusive of Taxes");
          IF SOrder."Price Inclusive of Taxes" THEN BEGIN
              SalesLine.InitStrOrdDetail(SOrder);
              SalesLine.GetSalesPriceExclusiveTaxes(SOrder);
              SalesLine.UpdateSalesLinesPIT(SOrder);
          END;
          SalesLine.CalculateStructures(SOrder);
          SalesLine.AdjustStructureAmounts(SOrder);
          SalesLine.UpdateSalesLines(SOrder);
      end;*/
}

