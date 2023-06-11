pageextension 50444 pageextension50444 extends "Dimension Value List"
{
    layout
    {
        addafter("Consolidation Code")
        {
            field("Dimension Code"; Rec."Dimension Code")
            {
                Editable = dimeditable;
                ApplicationArea = All;
            }
            field("Plant Code"; Rec."Plant Code")
            {
                ApplicationArea = All;
            }
            field("Cover Under Daily MIS"; Rec."Cover Under Daily MIS")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        dimeditable: Boolean;

    trigger OnOpenPage()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        IF (UPPERCASE(USERID) = 'IT003') AND (UPPERCASE(USERID) = 'FA017') THEN
            dimeditable := TRUE
        ELSE
            dimeditable := FALSE;

    end;

    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    CurrPage.LOOKUPMODE := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLSetup.GET;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GLSetup.GET;
    IF (UPPERCASE(USERID) = 'IT003') AND (UPPERCASE(USERID) = 'FA017') THEN
    dimeditable := TRUE
    ELSE
    dimeditable := FALSE;
    */
    //end;
}

