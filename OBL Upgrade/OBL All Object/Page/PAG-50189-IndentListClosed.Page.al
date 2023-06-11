page 50189 "Indent List-Closed"
{
    CardPageID = "Closed Indent Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Indent Header";
    SourceTableView = WHERE(Status = FILTER(Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field(Selection; rec.Selection)
                {
                    ApplicationArea = All;
                }
                field(Replied; rec.Replied)
                {
                    ApplicationArea = All;
                }
                field("Authorization 3"; rec."Authorization 3")
                {
                    ApplicationArea = All;
                }
                field(Commented; rec.Commented)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capex No."; rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; rec."Indent Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 2"; rec."Authorization 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 1"; rec."Authorization 1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Department Code"; rec."Department Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Plant Code"; rec."Plant Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 1 Date"; rec."Authorization 1 Date")
                {
                    ApplicationArea = All;
                }
                field("Authorization 1 Time"; rec."Authorization 1 Time")
                {
                    ApplicationArea = All;
                }
                field("Authorization 2 Date"; rec."Authorization 2 Date")
                {
                    ApplicationArea = All;
                }
                field("Authorization 2 Time"; rec."Authorization 2 Time")
                {
                    ApplicationArea = All;
                }
                field("Authorization Date"; rec."Authorization Date")
                {
                    ApplicationArea = All;
                }
                field("Authorization Time"; rec."Authorization Time")
                {
                    ApplicationArea = All;
                }
                field("Closed Date"; rec."Closed Date")
                {
                    ApplicationArea = All;
                }
                field("Closed Time"; rec."Closed Time")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action("Line&s")
                {
                    Caption = 'Line&s';
                    RunObject = Page "Indent Lines List";
                    RunPageLink = "Document No." = FIELD("No.");
                    ApplicationArea = All;

                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Indent Header";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}

