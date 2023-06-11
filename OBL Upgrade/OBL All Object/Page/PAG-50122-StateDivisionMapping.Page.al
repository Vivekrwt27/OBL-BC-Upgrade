page 50122 "State-Division Mapping"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Matrix Master";
    SourceTableView = SORTING("Mapping Type", "Type 1", "Type 2")
                      WHERE("Mapping Type" = CONST(States));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Mapping Type"; rec."Mapping Type")
                {
                    Visible = "Mapping TypeVisible";
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Type 1"; rec."Type 1")
                {
                    CaptionClass = '1,5,,' + MyCap;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::States:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(States);
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", SalesSetup.States);
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
                        Type1OnAfterValidate;
                    end;
                }
                field("Type 2"; Rec."Type 2")
                {
                    CaptionClass = '1,5,,' + MyCap1;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::States:
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
                                            Rec."Type 2" := DimensionValue.Code;
                                            Rec.Description := DimensionValue.Name;
                                        END;
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        /*SalesPersonMatrix.RESET;
                        SalesPersonMatrix.SETRANGE("Type 2","Type 2");
                        IF SalesPersonMatrix.FINDFIRST THEN
                          ERROR('It is all ready Exit');
                             */
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::States:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(Division);
                                    IF DimensionValue.GET(SalesSetup.Division, Rec."Type 2") THEN
                                        Rec.VALIDATE(Description, DimensionValue.Name);
                                END;
                        END;

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

        MyCap := 'States';
        MyCap1 := 'Divisions';

        //MS-AN END
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Mapping Type" := Rec."Mapping Type"::States;
    end;

    trigger OnOpenPage()
    begin
        //MS-AN BEGIN

        IF CurrPage.LOOKUPMODE THEN BEGIN
            CurrPage.CAPTION := UPPERCASE('List of Divisions in ' + Rec."Type 1");
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

    local procedure Type1OnAfterValidate()
    begin
        CASE Rec."Mapping Type" OF
            Rec."Mapping Type"::States:
                BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD(States);
                    IF DimensionValue.GET(SalesSetup.States, Rec."Type 1") THEN
                        Rec.VALIDATE("Description 2", DimensionValue.Name);
                END;
        END;
    end;
}

