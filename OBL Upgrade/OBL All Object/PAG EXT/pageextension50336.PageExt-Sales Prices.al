pageextension 50336 pageextension50336 extends "Sales Prices"
{
    layout
    {
        addafter("Sales Type")
        {
            field("Price Update By"; Rec."Created ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Updation Date"; Rec.Modifydate)
            {
                Editable = false;
                ApplicationArea = All;
            }


        }
        addafter("Ending Date")
        {
            field(MRP; Rec.MRP)
            {
                ApplicationArea = all;
            }
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }
        }
    }

    var
        usersetup: Record "User Setup";

    trigger OnOpenPage()
    begin
        IF usersetup.GET(USERID) THEN
            IF usersetup."Price Update" = TRUE THEN
                CurrPage.EDITABLE(TRUE)
            ELSE
                CurrPage.EDITABLE(FALSE);

    end;

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetRecFilters;
    SetRecFilters;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    IF usersetup.GET(USERID) THEN
      IF usersetup."Price Update" = TRUE THEN
        CurrPage.EDITABLE(TRUE)
      ELSE
        CurrPage.EDITABLE(FALSE);

    GetRecFilters;
    SetRecFilters;
    */
    //end;
}

