page 50096 "Comment Line Header"
{
    PageType = Card;
    SourceTable = "Comment Line";
    SourceTableView = SORTING("Table Name", "No.", "Line No.")
                      WHERE("Table Name" = FILTER('Indent Header'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Creater ID"; Rec."Creater ID")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

