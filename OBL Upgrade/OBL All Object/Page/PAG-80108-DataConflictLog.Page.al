page 80108 "Data Conflict Log"
{
    // Data Transfer Wizard 4.0 (Navision) Eduard Sanosian, The Netherlands, 08-2006

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    //16630 SourceTable = 80110;

    layout
    {
        area(content)
        {
            //16630
            /*   repeater(Group)
               {
                   field(Conflict; Rec.Conflict)
                   {
                   }
                   field("Table No."; Rec."Table No.")
                   {
                   }
                   field("Table Name"; Rec."Table Name")
                   {
                   }
                   field("Field No."; Rec."Field No.")
                   {
                   }
                   field("Field Name"; Rec."Field Name")
                   {
                   }
               }*/
        }
    }

    actions
    {
        area(processing)
        {
            action(Clear)
            {
                Caption = 'Clear';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630
                    /* IF NOT ISEMPTY THEN
                         IF CONFIRM(ConfirmText, TRUE) THEN
                             DELETEALL;*/
                end;
            }
        }
    }

    var
        ConfirmText: Label 'Wilt u logbestand van vorige importactie leegmaken?';
}

