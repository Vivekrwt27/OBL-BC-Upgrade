tableextension 50169 tableextension50169 extends "Tax Detail"
{
    fields
    {

        //Unsupported feature: Property Modification (DecimalPlaces) on ""Tax Below Maximum"(Field 5)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Tax Above Maximum"(Field 6)".

    }
    keys
    {
        /* key(Key2; "Tax Jurisdiction Code", "Tax Group Code", "Form Code", "Effective Date")
         {
         }*/
        key(Key3; "Tax Jurisdiction Code", "Tax Group Code", "Effective Date")
        {
            SumIndexFields = "Tax Below Maximum";
        }
    }
}

