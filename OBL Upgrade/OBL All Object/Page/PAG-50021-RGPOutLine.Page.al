page 50021 "RGP Out Line"
{
    // Customization No. 63

    Editable = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "RGP Line";
    SourceTableView = WHERE("Document Type" = CONST(Out));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DescriptionOnAfterValidate;
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Description2OnAfterValidate;
                    end;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Quantity to Receive" := Rec.Quantity;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = "Unit PriceEditable";
                    ApplicationArea = All;
                }
                field("Approximate Price"; Rec."Approximate Price")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("HSN Code"; Rec."HSN Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        //MSVRN 310518 >>
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", Rec."Indent No.");
        IndentLine.SETRANGE("Line No.", Rec."Indent Line No.");
        IF IndentLine.FINDFIRST THEN
            REPEAT
                IndentLine."RGP No." := '';
                IndentLine."RGP Made" := FALSE;
                IndentLine.MODIFY;
                IF IndentHeader.GET(IndentLine."Document No.") THEN BEGIN
                    IndentHeader."RGP Made" := FALSE;
                    IndentHeader.MODIFY;
                END;

                CommentLine.RESET;
                CommentLine.SETFILTER("Table Name", 'RGP Header');
                CommentLine.SETRANGE("No.", Rec."RGP No.");
                CommentLine.SETRANGE("Line No.", Rec."Line No.");
                IF CommentLine.FINDFIRST THEN
                    CommentLine.DELETE;

            UNTIL IndentLine.NEXT = 0;
        //END;
        //MSVRN 310518 <<
        CurrPage.UPDATE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ApproximatePriceOnBeforeInput();
    end;

    var
        [InDataSet]
        "Unit of MeasureEditable": Boolean;
        [InDataSet]
        "Unit PriceEditable": Boolean;
        [InDataSet]
        "Approximate PriceEditable": Boolean;
        IndentLine: Record "Indent Line";
        IndentHeader: Record "Indent Header";
        CommentLine: Record "Comment Line";

    local procedure TypeOnAfterValidate()
    begin
        //CurrPage.UPDATE;
    end;

    local procedure NoOnAfterValidate()
    begin
        //CurrPage.UPDATE;
    end;

    local procedure DescriptionOnAfterValidate()
    begin
        //CurrPage.UPDATE;
    end;

    local procedure Description2OnAfterValidate()
    begin
        //CurrPage.UPDATE;
    end;

    local procedure UnitofMeasureOnBeforeInput()
    begin
        IF Rec.Type = Rec.Type::" " THEN
            "Unit of MeasureEditable" := TRUE
        ELSE
            "Unit of MeasureEditable" := FALSE;
    end;

    local procedure UnitPriceOnBeforeInput()
    begin
        IF Rec.Type = Rec.Type::" " THEN
            "Unit PriceEditable" := TRUE
        ELSE
            "Unit PriceEditable" := FALSE;
    end;

    local procedure ApproximatePriceOnBeforeInput()
    begin
        IF Rec.Type = Rec.Type::" " THEN
            "Approximate PriceEditable" := TRUE
        ELSE
            "Approximate PriceEditable" := FALSE;
    end;
}

