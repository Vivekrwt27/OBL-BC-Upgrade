tableextension 50199 tableextension50199 extends Contact
{
    fields
    {

        modify(Name)
        {
            trigger OnBeforeValidate()
            begin
                IF NOT (CurrFieldNo IN [FIELDNO("First Name"), FIELDNO("Middle Name"), FIELDNO(Surname)]) THEN
                    UpdateSearchName;

                IF Type = Type::Company THEN
                    "Company Name" := Name;

                IF Type = Type::Person THEN BEGIN
                    ContBusRel.RESET;
                    ContBusRel.SETCURRENTKEY("Link to Table", "Contact No.");
                    ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                    ContBusRel.SETRANGE("Contact No.", "Company No.");
                    IF ContBusRel.FIND('-') THEN
                        IF Cust.GET(ContBusRel."No.") THEN
                            IF Cust."Primary Contact No." = "No." THEN BEGIN
                                Cust.Contact := Name;
                                Cust.MODIFY;
                            END;

                    ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Vendor);
                    IF ContBusRel.FIND('-') THEN
                        IF Vend.GET(ContBusRel."No.") THEN
                            IF Vend."Primary Contact No." = "No." THEN BEGIN
                                Vend.Contact := Name;
                                Vend.MODIFY;
                            END;
                END;

            end;
        }


        modify("First Name")// 15578
        {
            trigger OnBeforeValidate()
            begin
                VALIDATE(Name, CalculatedName);
            end;
        }

        modify("Middle Name")// 15578
        {
            trigger OnBeforeValidate()
            begin
                VALIDATE(Name, CalculatedName);
            end;
        }
        modify(Surname)// 15578
        {
            trigger OnBeforeValidate()
            begin
                VALIDATE(Name, CalculatedName);

            end;
        }
    }



    //Unsupported feature: Variable Insertion (Variable: NewName250) (VariableCollection) on "CalculatedName(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "CalculatedName(PROCEDURE 14)".

    //procedure CalculatedName();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "First Name" <> '' THEN
      NewName92 := "First Name";
    IF "Middle Name" <> '' THEN
      NewName92 := NewName92 + ' ' + "Middle Name";
    IF Surname <> '' THEN
      NewName92 := NewName92 + ' ' + Surname;

    NewName92 := DELCHR(NewName92,'<',' ');

    IF STRLEN(NewName92) > MAXSTRLEN(Name) THEN
      ERROR(Text029,STRLEN(NewName92) - MAXSTRLEN(Name));

    NewName := COPYSTR(NewName92,1,STRLEN(NewName92));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "First Name" <> '' THEN
      NewName250 := "First Name";
    IF "Middle Name" <> '' THEN
      NewName250 := NewName250 + ' ' + "Middle Name";
    IF Surname <> '' THEN
      NewName250 := NewName250 + ' ' + Surname;

    NewName250 := DELCHR(NewName250,'<',' ');

    IF STRLEN(NewName250) > MAXSTRLEN(Name) THEN
      ERROR(Text029,STRLEN(NewName250) - MAXSTRLEN(Name));

    NewName := NewName250;
    */
    //end;

    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
        Vend: Record Vendor;
}

