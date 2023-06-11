page 50156 "Physical Journal Store SubPage"
{
    PageType = ListPart;
    SourceTable = "Physical Journal Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = highlight;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("System Inventory"; Rec."System Inventory")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Physical Inventory"; Rec."Physical Inventory")
                {
                    ApplicationArea = All;
                }
                field("Short/Excess"; Rec."Short/Excess")
                {
                    ApplicationArea = All;
                }
                field("Transfer Inventory"; Rec."Transfer Inventory")
                {
                    ApplicationArea = All;
                }
                field("Pend. for Allocation"; Rec."Pend. for Allocation")
                {
                    ApplicationArea = All;
                }
                field("Reservation Qty"; Rec."Reservation Qty")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Entries")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.ShowoutputEntries;
                end;
            }
            action("Location Wise Details")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+L';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.GenerateLocationData;
                    Rec.ShowlocationWiseInventory;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        HighLightLine;
    end;

    trigger OnAfterGetRecord()
    begin
        HighLightLine;
    end;

    trigger OnOpenPage()
    begin
        Rec.CALCFIELDS("Pend. for Allocation");
    end;

    var
        [InDataSet]
        HighLight: Boolean;
        itemno: Record Item;

    procedure HighLightLine()
    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
    begin
        IF Rec."Voucher Type" = Rec."Voucher Type"::"Store Voucher" THEN
            HighLight := TRUE
        ELSE BEGIN
            HighLight := FALSE;
            PhysicalJournalOutputEntrie.RESET;
            PhysicalJournalOutputEntrie.SETRANGE("Document No.", Rec."Document No.");
            PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", Rec."Line No.");
            IF PhysicalJournalOutputEntrie.FINDFIRST THEN
                HighLight := TRUE;
        END;
    end;
}

