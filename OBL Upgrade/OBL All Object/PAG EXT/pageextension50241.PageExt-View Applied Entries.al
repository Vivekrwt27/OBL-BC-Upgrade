pageextension 50241 pageextension50241 extends "View Applied Entries"
{
    actions
    {
        addafter(RemoveAppButton)
        {
            action(Update)
            {
                Caption = 'Update';
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    RecIle.GET(Rec."Entry No.");
                    RecIle."Applied Entry to Adjust" := TRUE;
                    RecIle.MODIFY;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        RecIle: Record "Item Ledger Entry";



}

