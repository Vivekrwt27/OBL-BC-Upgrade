page 50144 "Tds Entry card"
{
    PageType = Card;
    SourceTable = "TDS Entry";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            field(Picture; rec.Picture)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Picture")
            {
                Caption = '&Picture';
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        tDSeNTRY.RESET;
                        tDSeNTRY.SETRANGE(tDSeNTRY."Entry No.", rec."Entry No.");
                        IF tDSeNTRY.FIND('-') THEN
                            REPEAT
                                ;
                            UNTIL tDSeNTRY.NEXT = 0;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.RESET;
        IF NOT rec.GET THEN BEGIN
            REPEAT
                rec.INIT;
                rec.INSERT;
            UNTIL rec.NEXT = 0;
        END;
    end;

    var
        PictureExists: Boolean;
        Text001: Label 'Do you want to replace the existing picture?';
        Text002: Label 'Do you want to delete the picture?';
        tDSeNTRY: Record "TDS Entry";
}

