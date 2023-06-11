page 50098 "Physical Journal Prod. List"
{
    CardPageID = "Physical Journal -Prod.";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Physical Journal Header";
    SourceTableView = SORTING("No.")
                      WHERE("Voucher Type" = CONST("Production Voucher"));
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field(Plant; Rec.Plant)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Voucher Type"; Rec."Voucher Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

