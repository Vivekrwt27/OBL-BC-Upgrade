table 50004 "Tour Header"
{
    Description = 'Customization No. 2.9';

    fields
    {
        field(1; "Tour No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Tour No." <> xRec."Tour No." THEN BEGIN
                    GLSetup.GET;
                    NoSeriesMgt.TestManual(GLSetup."Tour Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Purpose; Text[100])
        {
        }
        field(3; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                IF Purpose = '' THEN
                    ERROR(Text0001);
            end;
        }
        field(4; "End Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Start Date" > "End Date" THEN
                    ERROR('StartDate cannot be greater than the EndDate');
            end;
        }
        field(5; comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("IC Partner"),
                                                      "No." = FIELD("Tour No.")));
            FieldClass = FlowField;
        }
        field(6; "No. Series"; Code[10])
        {
        }
        field(7; "Tour Over"; Boolean)
        {
        }
        field(8; Release; Boolean)
        {
        }
        field(9; "Advance Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tour No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        //To generate the Tour No. Automatically by using the No. Series
        IF "Tour No." = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Tour Nos.");
            NoSeriesMgt.InitSeries(GLSetup."Tour Nos.", xRec."No. Series", 0D, "Tour No.", "No. Series");
        END;

        //To add the generated tour no. as dimension value.
        GLSetup.TESTFIELD("Tour Dimension Code");
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetup."Tour Dimension Code");
        DimValue.VALIDATE(Code, "Tour No.");
        DimValue.VALIDATE(Name, "Tour No.");
        DimValue.INSERT;
    end;

    trigger OnRename()
    begin


        //mo tri1.0 Customization no.64 start
        //To add the generated customer no. as dimension value.
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Tour Dimension Code");
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetup."Tour Dimension Code");
        DimValue.VALIDATE(Code, "Tour No.");
        DimValue.VALIDATE(Name, "Tour No.");
        DimValue.INSERT;
        //mo tri1.0 Customization no.64 end
    end;

    var
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TourHeader: Record "Tour Header";
        DimValue: Record "Dimension Value";
        Text0001: Label 'Purpose Field can''t be left blank.';

    procedure AssistEdit(OldTourHeader: Record "Tour Header"): Boolean
    begin
        WITH TourHeader DO BEGIN
            TourHeader := Rec;
            GLSetup.GET;
            GLSetup.TESTFIELD("Tour Nos.");
            IF NoSeriesMgt.SelectSeries(GLSetup."Tour Nos.", OldTourHeader."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Tour No.");
                Rec := TourHeader;
                EXIT(TRUE);
            END;
        END;
    end;
}

