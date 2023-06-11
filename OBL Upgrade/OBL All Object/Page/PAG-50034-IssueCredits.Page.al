page 50034 "Issue Credits"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Issued Credit Details";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cust. No."; rec."Cust. No.")
                {
                    ApplicationArea = All;
                }
                field("Cust Name"; rec."Cust Name")
                {
                    ApplicationArea = All;
                }
                field("Item Charge No."; rec."Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Narration; rec.Narration)
                {
                    ApplicationArea = All;
                }
                field("External Doc. No."; rec."External Doc. No.")
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
            action("P&ost")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(ICMgt);
                    IF CONFIRM('Do you want to Post the Credit Voucher?', FALSE) THEN BEGIN
                        IF rec.FINDFIRST THEN BEGIN
                            REPEAT
                                rec.TESTFIELD("Item Charge No.");
                                rec.TESTFIELD("Cust. No.");
                                rec.TESTFIELD("Posting Date");
                                rec.TESTFIELD(Amount);
                                ICMgt.PostEntries(Rec);
                                Rec.DELETE;
                            UNTIL rec.NEXT = 0;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        IF (UPPERCASE(USERID) <> 'FA015') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
            ERROR('You are Not Allowed to Open this Page');
    end;

    var
        ICMgt: Codeunit "Issued Credit Mgt";
}

