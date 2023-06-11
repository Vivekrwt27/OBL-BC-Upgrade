page 50121 "Zone-State Mapping"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Matrix Master";
    SourceTableView = SORTING("Mapping Type", "Type 1", "Type 2")
                      WHERE("Mapping Type" = CONST(Zone));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Mapping Type"; Rec."Mapping Type")
                {
                    Visible = "Mapping TypeVisible";
                    ApplicationArea = All;
                }
                field("Type 1"; Rec."Type 1")
                {
                    CaptionClass = MyCap;
                    Visible = "Type 1Visible";
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::Zone:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(Zone);
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", SalesSetup.Zone);
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionvalue);
                                        FormDimensionvalue.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionvalue.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionvalue.GETRECORD(DimensionValue);
                                            Rec.VALIDATE("Type 1", DimensionValue.Code);
                                            Rec.VALIDATE("Description 2", DimensionValue.Name);
                                        END;
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::Zone:
                                BEGIN
                                    SalesSetup.GET;
                                    SalesSetup.TESTFIELD(Zone);
                                    IF DimensionValue.GET(SalesSetup.Zone, Rec."Type 1") THEN
                                        Rec.VALIDATE("Description 2", DimensionValue.Name);
                                END;
                        END;
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    Enabled = true;
                    Visible = "Description 2Visible";
                    ApplicationArea = All;
                }
                field("Type 2"; Rec."Type 2")
                {
                    CaptionClass = MyCap1;
                    Visible = "Type 2Visible";
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CASE Rec."Mapping Type" OF
                            Rec."Mapping Type"::Zone:
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
                                            Rec."Type 2" := DimensionValue.Code;
                                            Rec.VALIDATE(Description, DimensionValue.Name);
                                        END;
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        Type2OnAfterValidate;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Visible = DescriptionVisible;
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
        "Description 2Visible" := TRUE;
        DescriptionVisible := TRUE;
        "Type 2Visible" := TRUE;
        "Type 1Visible" := TRUE;
        "Mapping TypeVisible" := TRUE;
        //MS-AN BEGIN

        SalesSetup.GET;

        MyCap := 'Zones';
        MyCap1 := 'States';

        //MS-AN END
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Mapping Type" := Rec."Mapping Type"::Zone;
    end;

    trigger OnOpenPage()
    begin
        //MS-AN BEGIN

        IF NOT CurrPage.LOOKUPMODE THEN BEGIN
            "Mapping TypeVisible" := TRUE;
            "Type 1Visible" := TRUE;
            "Type 2Visible" := TRUE;
            DescriptionVisible := TRUE;
            "Description 2Visible" := TRUE;
        END;

        IF CurrPage.LOOKUPMODE THEN BEGIN
            IF SalesSetup.TempBoolean = TRUE THEN BEGIN
                CurrPage.CAPTION := UPPERCASE('List of Zones');
                CurrPage.EDITABLE := FALSE;
                "Type 2Visible" := FALSE;
                "Type 1Visible" := TRUE;
                DescriptionVisible := FALSE;
                "Description 2Visible" := TRUE;
            END
            ELSE
                IF SalesSetup.TempBoolean = FALSE THEN BEGIN
                    CurrPage.CAPTION := UPPERCASE('List of States in ' + Rec."Type 1" + ' Zone');
                    CurrPage.EDITABLE := FALSE;
                    "Mapping TypeVisible" := FALSE;
                    "Type 1Visible" := TRUE;
                    "Type 2Visible" := TRUE;
                    "Description 2Visible" := FALSE;
                    DescriptionVisible := TRUE;
                END
        END;

        IF CurrPage.LOOKUPMODE AND SalesSetup.TempBoolean = TRUE THEN BEGIN
            IF Rec.FINDSET THEN BEGIN
                Rec.MARK(TRUE);
                TempCode := Rec."Type 1";
                REPEAT
                    IF Rec."Type 1" <> TempCode THEN BEGIN
                        Rec.MARK(TRUE);
                        TempCode := Rec."Type 1";
                    END;
                UNTIL Rec.NEXT = 0;
            END;
            Rec.MARKEDONLY(TRUE);
        END;

        //MS-AN END
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        DimensionValue: Record "Dimension Value";
        SalesPersonMatrix: Record "Matrix Master";
        MyCap: Text[30];
        TempCode: Code[10];
        MyCap1: Text[30];
        [InDataSet]
        "Mapping TypeVisible": Boolean;
        [InDataSet]
        "Type 1Visible": Boolean;
        [InDataSet]
        "Type 2Visible": Boolean;
        [InDataSet]
        DescriptionVisible: Boolean;
        [InDataSet]
        "Description 2Visible": Boolean;
        FormDimensionvalue: Page "Dimension Value List";

    local procedure Type2OnAfterValidate()
    begin
        CASE Rec."Mapping Type" OF
            Rec."Mapping Type"::Zone:
                BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD(States);
                    IF DimensionValue.GET(SalesSetup.States, Rec."Type 2") THEN
                        Rec.VALIDATE(Description, DimensionValue.Name);
                END;
        END;
    end;
}

