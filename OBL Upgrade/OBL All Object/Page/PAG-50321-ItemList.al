page 50321 "Item List Page"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = Item;

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
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }

                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group Id"; Rec."Gen. Prod. Posting Group Id")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Packing Code"; Rec."Packing Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Code Desc."; Rec."Packing Code Desc.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

