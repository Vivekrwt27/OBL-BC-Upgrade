pageextension 50251 pageextension50251 extends "Item Units of Measure"
{

    trigger OnOpenPage()//16225 Add Block Code//
    begin
        //UPDATE - TCPL - 7632
        IF (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'IT003') THEN
            CurrPage.EDITABLE(FALSE);
        //UPDATE - TCPL - 7632
    end;
}

