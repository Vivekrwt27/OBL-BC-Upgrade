page 50157 "Phy. Journal Output Entries"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Physical Journal Output Entrie";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("RM Code"; Rec."RM Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Prod. Quantity"; Rec."Total Prod. Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allocate Quantity"; Rec."Allocate Quantity")
                {
                    ApplicationArea = All;
                }
                field("Transfer Allocated Qty."; Rec."Transfer Allocated Qty.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inventory At Location"; Rec."Inventory At Location")
                {
                    ApplicationArea = All;
                }
                field("Manually Changed"; Rec."Manually Changed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Re-Allocate")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PhysicalJournalLine: Record "Physical Journal Line";
                begin
                    IF Rec.FINDFIRST THEN
                        PhysicalJournalLine.GET(Rec."Document No.", Rec."Document Line No.");
                    Rec.ReAllocateQty(PhysicalJournalLine, FALSE);
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        Rec.CheckShortExcess(Rec."Document No.", Rec."Line No.");
        PhysicalJournalLine.GET(Rec."Document No.", Rec."Document Line No.");
        Rec.ReAllocateQty(PhysicalJournalLine, FALSE);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PhysicalJournalLine: Record "Physical Journal Line";
    begin
        PhysicalJournalLine.GET(Rec."Document No.", Rec."Document Line No.");
        Rec.ReAllocateQty(PhysicalJournalLine, FALSE);
    end;

    var
        PhysicalJournalLine: Record "Physical Journal Line";
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
        ShortExcess: Decimal;
        Text0001: Label 'Allocated Qty. Should be equal to %1!';
}

