page 50154 "Physical Journal Store List"
{
    CardPageID = "Physical Journal -Store";
    Editable = false;
    PageType = List;
    SourceTable = "Physical Journal Header";
    SourceTableView = WHERE("Voucher Type" = CONST("Store Voucher"));
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
                field("PICC Key"; Rec."PICC Key")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
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

