page 50019 "SMS - Mobile No. Selection"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "SMS - Mobile No.";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field(Selected; rec.Selected)
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; rec."Mobile No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
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
            action(cmdCheckAll)
            {
                Caption = 'Check All';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF rec.FINDFIRST THEN BEGIN
                        REPEAT
                            rec.Selected := TRUE;
                            rec.MODIFY;
                        UNTIL rec.NEXT = 0;
                    END;
                end;
            }
            action(cmdUNCheckAll)
            {
                Caption = 'Un Check All';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF rec.FINDFIRST THEN BEGIN
                        REPEAT
                            rec.Selected := FALSE;
                            rec.MODIFY;
                        UNTIL rec.NEXT = 0;
                    END;
                end;
            }
        }
    }
}

