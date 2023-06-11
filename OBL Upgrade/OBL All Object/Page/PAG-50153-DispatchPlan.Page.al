page 50153 "Dispatch Plan"
{
    DeleteAllowed = false;
    PageType = List;
    Permissions = TableData "Vendor Requisition" = rimd;
    SourceTable = "Vendor Requisition";

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field(Transporter; Rec.Transporter)
                {
                    ApplicationArea = All;
                }
                /* field("Truck No."; "Truck No.")//16225 table Field N/F
                 {
                 }
                 field(Remarks; Remarks)
                 {
                 }*/
                field("Our Account No."; Rec."Our Account No.")
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

