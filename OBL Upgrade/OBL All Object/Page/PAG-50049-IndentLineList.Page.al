page 50049 "Indent Line List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Indent Line";
    SourceTableView = WHERE("Job Indent" = FILTER(true),
                            "RGP Made" = FILTER(false),
                            Status = FILTER('Authorization1 | Authorization2 | Authorization3 | Authorization1 | Authorized'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measurement"; Rec."Unit of Measurement")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Job Indent"; Rec."Job Indent")
                {
                    ApplicationArea = All;
                }
                field("RGP No."; Rec."RGP No.")
                {
                    ApplicationArea = All;
                }
                field("RGP Made"; Rec."RGP Made")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        IF Sourceno <> '' THEN
            Createline;
    end;

    var
        Lineno: Integer;
        Sourceno: Code[20];

    procedure Createline()
    var
        recIndentLn: Record "Indent Line";
        recRGPLine: Record "RGP Line";
    begin
        IF CONFIRM('Do you want to get Indent(s) on RGP?', FALSE) THEN BEGIN
            Lineno := 0;
            recIndentLn.COPY(Rec);
            CurrPage.SETSELECTIONFILTER(recIndentLn);
            Lineno += 10000;
            IF recIndentLn.FINDFIRST THEN
                REPEAT
                    recRGPLine.SETRANGE("RGP No.", Sourceno);
                    IF recRGPLine.FINDLAST THEN
                        recRGPLine.INIT;
                    recRGPLine."Line No." := Lineno + recRGPLine."Line No.";
                    recRGPLine."RGP No." := Sourceno;
                    IF recIndentLn.Type = recIndentLn.Type::Item THEN
                        recRGPLine.VALIDATE(Type, recRGPLine.Type::Item)
                    ELSE
                        recRGPLine.VALIDATE(Type, recIndentLn.Type);
                    recRGPLine.VALIDATE(Type);
                    recRGPLine."No." := recIndentLn."No.";
                    recRGPLine.Description := recIndentLn.Description;
                    recRGPLine."Description 2" := recIndentLn."Description 2";
                    recRGPLine.Quantity := recIndentLn.Quantity;
                    recRGPLine.VALIDATE("Unit of Measure", recIndentLn."Unit of Measurement");
                    recRGPLine.Location := recIndentLn."Location Code";
                    recRGPLine."Indent No." := recIndentLn."Document No.";
                    recRGPLine."Indent Line No." := recIndentLn."Line No.";
                    recRGPLine.INSERT;
                    recIndentLn."RGP Made" := TRUE;
                    recIndentLn."RGP No." := recRGPLine."RGP No.";
                    recIndentLn.MODIFY;
                UNTIL recIndentLn.NEXT = 0;
        END;
    end;

    procedure Getsourceno(Sourcedoc: Code[20])
    begin
        Sourceno := Sourcedoc;
    end;
}

