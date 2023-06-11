page 99997 PostedsalesInvoice
{
    PageType = List;
    SourceTable = 113;
    Permissions = tabledata 113 = rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;


                }
                field("Quantity in Sq. Mt."; Rec."Quantity in Sq. Mt.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}