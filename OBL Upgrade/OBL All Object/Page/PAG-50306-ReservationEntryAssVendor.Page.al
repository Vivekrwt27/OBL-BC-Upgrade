page 50306 "Reservation Entry Ass. Vendor"
{
    PageType = List;
    Permissions = TableData "Reservation Entry" = rimd;
    SourceTable = "Reservation Entry";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemUnitofMeasure.RESET;
                        ItemUnitofMeasure.SETFILTER(Code, '%1', 'CRT');
                        ItemUnitofMeasure.SETRANGE("Item No.", Rec."Item No.");
                        IF ItemUnitofMeasure.FINDFIRST THEN BEGIN
                            Rec.Conversion := ItemUnitofMeasure."Qty. per Unit of Measure";
                            Rec.VALIDATE("Source Type", 32);

                            IF itemdesc.GET(Rec."Item No.") THEN
                                ItemDescription := itemdesc.Description;
                            ItemDescription2 := itemdesc."Description 2";

                            //  MODIFY;
                        END;
                    end;
                }
                field("Qty In Crt"; Rec."Qty In Crt")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Quantity (Base)" := Rec."Qty In Crt" * Rec.Conversion;
                        Rec.Positive := TRUE;
                        Rec."Creation Date" := TODAY;
                    end;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Positive; Rec.Positive)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Morbi Batch No."; Rec."Morbi Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; ItemDescription)
                {
                    ApplicationArea = All;
                }
                field("Item Description 2"; ItemDescription2)
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
        IF itemdesc.GET(Rec."Item No.") THEN
            ItemDescription := itemdesc.Description;
        ItemDescription2 := itemdesc."Description 2";
    end;

    trigger OnOpenPage()
    begin
        IF COMPANYNAME <> 'Associate Vendors-Morbi' THEN
            ERROR('You Can Not Run this objects');
    end;

    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        itemdesc: Record Item;
        ItemDescription: Text[35];
        ItemDescription2: Text[30];
}

