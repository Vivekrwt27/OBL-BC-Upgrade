page 50140 "City-Area Mapping"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Matrix Master";
    SourceTableView = SORTING("Mapping Type", "Type 1", "Type 2")
                      WHERE("Mapping Type" = CONST(City));

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
                            Rec."Mapping Type"::City:
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
                                            Rec."Type 1" := DimensionValue.Code;
                                            Rec.VALIDATE("Description 2", DimensionValue.Name);
                                        END;
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::City:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(City);
                                    IF DimensionValue.GET(SalesSetup.City, Rec."Type 1") THEN
                                        Rec.VALIDATE("Description 2", DimensionValue.Name);
                                END;
                        END;
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
                            Rec."Mapping Type"::City:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(Area);
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", SalesSetup.Area);
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionvalue);
                                        FormDimensionvalue.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionvalue.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionvalue.GETRECORD(DimensionValue);
                                            Rec."Type 2" := DimensionValue.Code;
                                            Rec.VALIDATE(Description, DimensionValue.Name);
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

        MyCap := 'Cities';
        MyCap1 := 'Areas';

        //MS-AN END
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Mapping Type" := Rec."Mapping Type"::City;
    end;

    trigger OnOpenPage()
    begin
        //MS-AN BEGIN

        IF CurrPage.LOOKUPMODE THEN BEGIN
            CurrPage.CAPTION := UPPERCASE('List of Areas in ' + Rec."Type 1");
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
            Rec."Mapping Type"::City:
                BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD(Area);
                    IF DimensionValue.GET(SalesSetup.Area, Rec."Type 2") THEN
                        Rec.VALIDATE(Description, DimensionValue.Name);
                END;
        END;
    end;
}

