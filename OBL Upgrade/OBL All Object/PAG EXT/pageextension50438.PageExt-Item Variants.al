pageextension 50438 pageextension50438 extends "Item Variants"
{
    layout
    {
        addafter(Code)
        {
            field("Varient Codes"; Rec."Varient Codes")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF Rec.Code = '' THEN
                        Rec.Code := Rec."Varient Codes";
                    IF vardesc.GET(Rec.Code) THEN
                        Rec.Description := vardesc.Description;
                end;
            }
        }
        addafter("Description 2")
        {
            field("Batch Code"; Rec."Batch Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Translations)
        {
            action("Update Item")
            {
                Caption = 'Update Item';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TRI S.R 230310 - New code Add Start
                    UpdateForm.SetParameter(Rec.Code);
                    UpdateForm.RUN;
                    //TRI S.R 230310 - New code Add Stop
                end;
            }
        }
    }

    var
        UpdateForm: Page "Update Variant Code";
        vardesc: Record "Reason Code";
}

