/*pageextension 50123 pageextension50123 extends "Data Classification Worksheet"
//{

    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SETSELECTIONFILTER(DataSensitivity);
    FieldContentEnabled :=
      (("Field Type" = "Field Type"::Code) OR
       ("Field Type" = "Field Type"::Text)) AND
      (DataSensitivity.COUNT = 1);
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
CurrPage.SETSELECTIONFILTER(DataSensitivity);
FieldContentEnabled :=
  (("Field Type" = "Field Type"::"31489") OR
   ("Field Type" = "Field Type"::"31488")) AND
  (DataSensitivity.COUNT = 1);
*/
//end;
//}

