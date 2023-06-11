page 50130 "IC Line - In"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;//16225 Page Type Change Card To Listpart
    SourceTable = "IC Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = true;
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Item No."; Rec."To Item No.")
                {
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
                field(UOM; Rec.UOM)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
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

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        UserLocation.CHANGECOMPANY(Rec."To Company");
                        IF PAGE.RUNMODAL(Page::"User Locations", UserLocation) = ACTION::LookupOK THEN
                            Rec.VALIDATE("From Location", UserLocation."Location Code");
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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

