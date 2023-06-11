pageextension 50459 ItemCard extends "Item Card"
{
    layout
    {
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        addafter(Type)
        {
            field("Base Unit Of Measure New"; Rec."Base Unit Of Measure New")
            {
                ApplicationArea = all;
            }
            field("Reserved Qty. on Inventory"; Rec."Reserved Qty. on Inventory")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addbefore("Unit of Measure")
        {
            action(UpdateBase)
            {
                ApplicationArea = All;
                Visible = false;
                Promoted = true;
                trigger OnAction()
                var
                    RecItem: Record Item;
                    Counter: Integer;
                begin
                    Clear(Counter);
                    RecItem.SetRange("Base Unit Of Measure New", '');
                    if RecItem.FindSet() then
                        repeat
                            Counter += 1;
                            RecItem."Base Unit Of Measure New" := 'SQ.MT';
                            RecItem.Modify();
                        until RecItem.next() = 0;
                    Message('Tota record Modify %1', Counter);
                end;
            }
            action("Group Price")
            {
                Caption = 'Group Price';
                RunObject = Page 50007;
                Promoted = true;
                PromotedCategory = Process;
                RunPageLink = "Item Classification No." = FIELD("Item Classification");
                ApplicationArea = all;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Created Date" := Today;
        rec."Created ID" := UserId;
    end;

    var
        myInt: Integer;
}