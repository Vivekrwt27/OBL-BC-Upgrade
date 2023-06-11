page 50172 "Posted Customer Disc details"
{
    PageType = Card;
    SourceTable = "Freight Master IBOT";

    layout
    {
        //16225 Table field N/F Start
        /*area(content)
        {
            repeater(group)
            {
                Editable = false;
                field(CustId; CustId)
                {
                    ApplicationArea = All;
                }
                field("Cust Name"; "Cust Name")
                {
                    ApplicationArea = All;
                }
                field(RefRecID; RefRecID)
                {
                    Caption = 'Reference ID';
                    ApplicationArea = All;
                }
                field("Doc No."; "Doc No.")
                {
                    ApplicationArea = All;
                }
                field("Inv Amount paid"; "Inv Amount paid")
                {
                    ApplicationArea = All;
                }
                field("Inv Posting Date"; "Inv Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }*///16225 Table field N/F End
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF NOT ((USERID = 'fa007') OR (USERID = 'fa015') OR (USERID = 'administrator') OR (USERID = 'it004')) THEN
            ERROR('no permission');
    end;
}

