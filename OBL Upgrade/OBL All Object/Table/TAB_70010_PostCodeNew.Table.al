table 70010 "Post Code New"
{
    Caption = 'Post Code';
    LookupPageID = "Post Codes";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.SETCURRENTKEY("Search City");
                PostCode.SETRANGE("Search City", "Search City");
                PostCode.SETRANGE(PostCode.Code, Code);
                IF PostCode.FIND('-') THEN
                    ERROR(Text000, FIELDCAPTION(Code), Code);
            end;
        }
        field(2; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                TESTFIELD(Code);
                "Search City" := City;
                IF xRec."Search City" <> "Search City" THEN BEGIN
                    PostCode.SETCURRENTKEY("Search City");
                    PostCode.SETRANGE("Search City", "Search City");
                    PostCode.SETRANGE(PostCode.Code, Code);
                    IF PostCode.FIND('-') THEN
                        ERROR(Text000, FIELDCAPTION(City), City);
                END;
            end;
        }
        field(3; "Search City"; Code[30])
        {
            Caption = 'Search City';
        }
    }

    keys
    {
        key(Key1; "Code", City)
        {
            Clustered = true;
        }
        key(Key2; City, "Code")
        {
        }
        key(Key3; "Search City")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '%1 %2 already exists.';

    procedure ValidateCity(var City: Text[30]; var PostCode: Code[10])
    var
        PostCodeRec: Record "Post Code";
        PostCodeRec2: Record "Post Code";
        SearchCity: Code[30];
    begin
        IF NOT GUIALLOWED THEN
            EXIT;
        IF City <> '' THEN BEGIN
            SearchCity := City;
            PostCodeRec.SETCURRENTKEY("Search City");
            PostCodeRec.SETFILTER("Search City", SearchCity);
            IF NOT PostCodeRec.FIND('-') THEN
                EXIT;
            PostCodeRec2.COPY(PostCodeRec);
            IF PostCodeRec2.NEXT = 1 THEN
                IF PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) <> ACTION::LookupOK THEN
                    EXIT;
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
        END;
    end;

    procedure ValidatePostCode(var City: Text[30]; var PostCode: Code[10])
    var
        PostCodeRec: Record "Post Code";
        PostCodeRec2: Record "Post Code";
    begin
        IF NOT GUIALLOWED THEN
            EXIT;
        IF PostCode <> '' THEN BEGIN
            PostCodeRec.SETRANGE(PostCodeRec.Code, PostCode);
            IF NOT PostCodeRec.FIND('-') THEN
                EXIT;
            PostCodeRec2.COPY(PostCodeRec);
            IF PostCodeRec2.NEXT = 1 THEN
                IF PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) <> ACTION::LookupOK THEN
                    EXIT;
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
        END;
    end;


    procedure LookUpCity(var City: Text[30]; var PostCode: Code[10]; ReturnValues: Boolean)
    var
        PostCodeRec: Record "Post Code";
    begin
        IF NOT GUIALLOWED THEN
            EXIT;
        PostCodeRec.SETCURRENTKEY(City, PostCodeRec.Code);
        PostCodeRec.Code := PostCode;
        PostCodeRec.City := City;
        IF (PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.City) = ACTION::LookupOK) AND ReturnValues THEN BEGIN
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
        END;
    end;

    procedure LookUpPostCode(var City: Text[30]; var PostCode: Code[10]; ReturnValues: Boolean)
    var
        PostCodeRec: Record "Post Code";
    begin
        IF NOT GUIALLOWED THEN
            EXIT;
        PostCodeRec.SETCURRENTKEY(PostCodeRec.Code, City);
        PostCodeRec.Code := PostCode;
        PostCodeRec.City := City;
        IF (PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) = ACTION::LookupOK) AND ReturnValues THEN BEGIN
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
        END;
    end;
}

