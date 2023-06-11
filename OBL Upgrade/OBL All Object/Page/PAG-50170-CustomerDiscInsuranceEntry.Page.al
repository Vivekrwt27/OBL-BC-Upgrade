page 50170 "Customer Disc Insurance Entry"
{
    PageType = Card;
    SourceTable = "Additional discount Insurance";
    SourceTableView = WHERE("cFlag" = CONST('INITIAL'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(cDate; Rec.cDate)
                {
                    ApplicationArea = All;
                }
                field(CustId; Rec.CustId)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        cCust.GET(Rec.CustId);
                        Rec."Cust Name" := cCust.Name;
                    end;
                }
                field("Cust Name"; Rec."Cust Name")
                {
                    ApplicationArea = All;
                }
                field(cType; Rec.cType)
                {
                    ApplicationArea = All;
                }
                field(cAmount; Rec.cAmount)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Remaining Amount" := Rec.cAmount;
                    end;
                }
                field(cDescription; Rec.cDescription)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.SETRANGE(cFlag, '%1', 'No');
                    IF NOT Rec.FIND('-') THEN
                        ERROR('Nothing to Save')
                    ELSE BEGIN
                        Rec.FINDFIRST;
                        REPEAT
                            Rec.TESTFIELD(CustId);

                            IF Rec.cAmount <= 0 THEN
                                ERROR('Amount should be greater than zero');
                            Rec.cFlag := 'SAVED';
                            Rec.MODIFY;
                        UNTIL Rec.NEXT = 0;
                    END;
                end;
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

