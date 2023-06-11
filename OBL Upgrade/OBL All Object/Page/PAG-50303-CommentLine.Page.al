page 50303 "Comment Line"
{
    Editable = false;
    PageType = List;
    SourceTable = "Comment Line";
    SourceTableView = WHERE("Table Name" = FILTER(Item),
                            IPG = FILTER(<> 'MANUF'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting roup"; Rec.IPG)
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Description)
                {
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
        IF Recitem.GET(Rec."No.") THEN
            Description := Recitem.Description + ' ' + Recitem."Description 2";
    end;

    var
        Description: Text[200];
        Recitem: Record Item;
}

