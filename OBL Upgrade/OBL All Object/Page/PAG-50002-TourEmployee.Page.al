page 50002 "Tour Employee"
{
    Description = '2.9';
    PageType = Card;
    SourceTable = "Production Planing";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimValue: Record "Dimension Value";
                        GLSetUp: Record "General Ledger Setup";
                    begin
                        GLSetUp.GET;
                        GLSetUp.TESTFIELD(GLSetUp."Employee Dimension Code");
                        DimValue.SETRANGE("Dimension Code", GLSetUp."Employee Dimension Code");
                        IF PAGE.RUNMODAL(PAGE::"Dimension Value List", DimValue) = ACTION::LookupOK THEN
                            rec."Item No" := DimValue.Code;

                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EmployeeNoOnFormat;
    end;

    var
        dimension: Record "Dimension Value";
        GlSetup: Record "General Ledger Setup";
        Name: Text[30];


    procedure CalledFrom(Release: Boolean)
    begin
        //mo tri1.0 Customization no.2.9 start
        IF Release = TRUE THEN BEGIN
            CurrPage.EDITABLE := FALSE;
        END ELSE BEGIN
            CurrPage.EDITABLE := TRUE;
        END;
        //mo tri1.0 Customization no.2.9 end
    end;

    local procedure EmployeeNoOnFormat()
    begin
        IF Rec."Item No" <> '' THEN BEGIN
            GlSetup.GET;
            GlSetup.TESTFIELD(GlSetup."Employee Dimension Code");
            dimension.GET(GlSetup."Employee Dimension Code", Rec."Item No");
            Name := dimension.Name;
        END
        ELSE
            Name := '';
    end;
}

