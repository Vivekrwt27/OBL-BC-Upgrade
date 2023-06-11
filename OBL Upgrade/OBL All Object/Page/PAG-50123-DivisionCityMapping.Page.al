page 50123 "Division City Mapping"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Matrix Master";
    SourceTableView = SORTING("Mapping Type", "Type 1", "Type 2")
                      WHERE("Mapping Type" = CONST(Division));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mapping Type"; Rec."Mapping Type")
                {
                    Visible = "Mapping TypeVisible";
                    ApplicationArea = All;
                }
                field("Type 1"; Rec."Type 1")
                {
                    CaptionClass = '1,5,,' + MyCap;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::Division:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(Division);
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", SalesSetup.Division);
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionvalue);
                                        FormDimensionvalue.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionvalue.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionvalue.GETRECORD(DimensionValue);
                                            Rec."Type 1" := DimensionValue.Code;
                                            Rec.VALIDATE("Description 2", DimensionValue.Name);
                                            //"Description 2":=DimensionValue.Name;
                                        END;
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::Division:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(Division);
                                    IF DimensionValue.GET(SalesSetup.Division, Rec."Type 1") THEN
                                        Rec.VALIDATE("Description 2", DimensionValue.Name);
                                END;
                        END;
                        // VALIDATE("Description 2",DimensionValue.Name);  //MIPL
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Type 2"; Rec."Type 2")
                {
                    CaptionClass = '1,5,,' + MyCap1;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::Division:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(City);
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", SalesSetup.City);
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionvalue);
                                        FormDimensionvalue.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionvalue.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionvalue.GETRECORD(DimensionValue);
                                            Rec."Type 2" := DimensionValue.Code;
                                            Rec.Description := DimensionValue.Name;
                                        END;
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        SalesPersonMatrix.RESET;
                        SalesPersonMatrix.SETRANGE("Type 2", Rec."Type 2");
                        IF SalesPersonMatrix.FINDFIRST THEN
                            ERROR('It is all ready Exit');
                        Type2OnAfterValidate;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Mapping TypeVisible" := TRUE;
        //MS-AN BEGIN

        MyCap := 'Divisions';
        MyCap1 := 'Cities';

        //MS-AN END
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Mapping Type" := Rec."Mapping Type"::Division;
    end;

    trigger OnOpenPage()
    begin
        //MS-AN BEGIN

        IF CurrPage.LOOKUPMODE THEN BEGIN
            CurrPage.CAPTION := UPPERCASE('List of Cities in ' + Rec."Type 1");
            CurrPage.EDITABLE := FALSE;
            "Mapping TypeVisible" := FALSE;
        END;

        //MS-AN END
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        DimensionValue: Record "Dimension Value";
        SalesPersonMatrix: Record "Matrix Master";
        MyCap: Text[30];
        MyCap1: Text[30];
        [InDataSet]
        "Mapping TypeVisible": Boolean;
        FormDimensionvalue: Page "Dimension Value List";

    local procedure Type2OnAfterValidate()
    begin
        CASE Rec."Mapping Type" OF
            Rec."Mapping Type"::Division:
                BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD(City);
                    IF DimensionValue.GET(SalesSetup.City, Rec."Type 2") THEN
                        Rec.VALIDATE(Description, DimensionValue.Name);
                END;
        END;
    end;
}

