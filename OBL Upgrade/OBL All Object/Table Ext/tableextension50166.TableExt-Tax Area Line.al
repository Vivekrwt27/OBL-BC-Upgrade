tableextension 50166 tableextension50166 extends "Tax Area Line"
{
    fields
    {
        field(50000; "Tax %"; Decimal)
        {
            CalcFormula = Max("Tax Detail"."Tax Below Maximum" WHERE("Tax Jurisdiction Code" = FIELD("Tax Jurisdiction Code"),
                                                                      "Tax Group Code" = FILTER('TILES|TRADING')));
            // "Form Code" = FILTER('')));
            FieldClass = FlowField;
        }
        field(50001; "effiective Date"; Date)
        {
            CalcFormula = Max("Tax Detail"."Effective Date" WHERE("Tax Jurisdiction Code" = FIELD("Tax Jurisdiction Code"),
                                                                   "Tax Group Code" = FILTER('TILES|TRADING')));
            // "Form Code" = FILTER('')));
            FieldClass = FlowField;
        }
    }
}

