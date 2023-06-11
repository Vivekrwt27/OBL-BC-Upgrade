page 50171 "Posted Customer Disc Insurance"
{
    PageType = Card;
    SourceTable = "Additional discount Insurance";
    SourceTableView = WHERE(cFlag = FILTER('<> INITIAL'));

    layout
    {
        area(content)
        {
            repeater(group)
            {
                Editable = true;
                field(RecId; Rec.RecId)
                {
                    Caption = 'Record ID';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(cDate; Rec.cDate)
                {
                    Caption = 'Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(CustId; Rec.CustId)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        cCust.GET(Rec.CustId);
                        Rec."Cust Name" := cCust.Name;
                    end;
                }
                field("Cust Name"; Rec."Cust Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field(AmountToGive; Rec.AmountToGive)
                {
                    Caption = 'Approval Yes/No';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF USERID <> ('fa007') THEN
                            ERROR('No permission');
                    end;
                }
                field(cType; Rec.cType)
                {
                    Caption = 'Type';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(cAmount; Rec.cAmount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount paid"; Rec."Amount paid")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Details)
            {
                Caption = 'Details';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Customer Disc details";
                // RunPageLink = Field50013 = FIELD(RecId); //16225 field N/F
                // RunPageView = SORTING(Field50011);//16225 field N/F
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF NOT ((USERID = 'fa007') OR (USERID = 'fa015') OR (USERID = 'administrator') OR (USERID = 'it004')) THEN
            ERROR('no permission');
    end;

    var
        cCust: Record Customer;
}

