page 50231 "Forcast List"
{
    CardPageID = "Forcast Card";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase order Attachment";

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                //16225 table field N/f
                /*field("Total Prod. Qty."; "Total Prod. Qty.")
                {
                }*/
                field("Posted UserID"; Rec."Posted UserID")
                {
                    ApplicationArea = All;
                }
                field(Recieved; Rec.Recieved)
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

