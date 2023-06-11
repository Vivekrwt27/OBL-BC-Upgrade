page 50161 "Due Date"
{
    PageType = Card;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Ship To Name"; Rec."Ship To Name")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address"; Rec."Ship To Address")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address2"; Rec."Ship To Address2")
                {
                    ApplicationArea = All;
                }
                field("Ship To City"; Rec."Ship To City")
                {
                    ApplicationArea = All;
                }
                field("Cust Type"; Rec."Cust Type")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Caption = 'New Date';
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(OldDate; OldDate)
                {
                    Caption = 'Old Date';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //MSBS.Rao Start 0613
        IF SIH.GET(Rec."Document No.") THEN
            OldDate := SIH."Due Date"
        ELSE
            OldDate := 0D;
        //SETFILTER("Due Date",'<>%1',OldDate);
        //MSBS.Rao Stop 0613
    end;

    var
        SIH: Record "Sales Invoice Header";
        OldDate: Date;
}

