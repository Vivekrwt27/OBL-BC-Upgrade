page 50245 "Recieve Scan Document List"
{
    CardPageID = "Receive Scan Document Cards";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase order Attachment";
    SourceTableView = WHERE(Posted = CONST(true),
                            Recieved = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = ALL;


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
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field(Recieved; Rec.Recieved)
                {
                    ApplicationArea = All;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
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

