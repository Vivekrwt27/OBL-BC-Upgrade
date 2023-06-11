page 50243 "Scan Document List"
{
    CardPageID = "Scan Document Cards";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase order Attachment";
    SourceTableView = WHERE(Posted = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = All;
                }
                field(Recieved; rec.Recieved)
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

