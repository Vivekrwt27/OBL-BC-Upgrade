table 90001 State_date
{
    //LookupPageID = 13789;//16225 PAGE N/F

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "State Code for eTDS"; Code[2])
        {
            Numeric = true;
        }
        field(50000; Dimension; Code[20])
        {

            trigger OnLookup()
            begin
                //mo tri1.0 Customization no.64 start
                GLSetUp.GET;
                DimValue.SETFILTER("Dimension Code", GLSetUp."State Dimension Code");
                IF DimValue.FIND('-') THEN
                    IF PAGE.RUNMODAL(PAGE::"Dimension Value List", DimValue) = ACTION::LookupOK THEN;
                /*
                  "Location Dimension" := DimValue.Code;
                */
                //mo tri1.0 Customization no.64 end

            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //mo tri1.0 Customization no.64 start
        GLSetUp.GET;
        IF DimValue.GET(GLSetUp."State Dimension Code", Code) THEN BEGIN
            DimValue.DELETE;
        END;
        //mo tri1.0 Customization no.64 end
    end;

    trigger OnInsert()
    begin
        /*//mo tri1.0 Customization no.64 start
        //To add the generated customer no. as dimension value.
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."State Dimension Code");
        IF NOT DimValue.GET(GLSetUp."State Dimension Code",Code) THEN BEGIN
          DimValue.INIT;
          DimValue.VALIDATE("Dimension Code",GLSetUp."State Dimension Code");
          DimValue.VALIDATE(Code,Code);
          DimValue.VALIDATE(Name,Code);
          DimValue.INSERT;
          Dimension := DimValue.Code;
        END;
        //mo tri1.0 Customization no.64 end
         */

    end;

    trigger OnRename()
    begin
        //mo tri1.0 Customization no.64 start
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."State Dimension Code");
        IF DimValue.GET(GLSetUp."State Dimension Code", xRec.Code) THEN
            DimValue.DELETE;
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetUp."State Dimension Code");
        DimValue.VALIDATE(Code, Code);
        DimValue.VALIDATE(Name, Code);
        DimValue.INSERT;
        Dimension := DimValue.Code;
        //mo tri1.0 Customization no.64 end
    end;

    var
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
}

