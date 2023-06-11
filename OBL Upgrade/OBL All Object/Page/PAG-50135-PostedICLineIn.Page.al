page 50135 "Posted IC Line - In"
{
    AutoSplitKey = true;
    PageType = ListPart;//16225 Card Replace Listpart
    SourceTable = "IC In Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                Editable = false;
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("From Company"; Rec."From Company")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Company"; Rec."To Company")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
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

    var
        UserLocation: Record "User Location";
}

