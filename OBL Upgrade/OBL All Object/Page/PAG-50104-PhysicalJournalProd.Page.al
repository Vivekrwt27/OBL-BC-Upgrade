page 50104 "Physical Journal -Prod."
{
    PageType = Card;
    SourceTable = "Physical Journal Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("PICC Key"; Rec."PICC Key")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(Plant; Rec.Plant)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Lines; "Physical Journal Store SubPage")
            {
                Caption = 'Lines';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;


            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Inventory")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PhysicalJournalLine: Record "Physical Journal Line";
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    PhysicalJournalHeader.RESET;
                    PhysicalJournalHeader.SETRANGE("PICC Key", Rec."PICC Key");
                    PhysicalJournalHeader.SETRANGE("Voucher Type", PhysicalJournalHeader."Voucher Type"::"Store Voucher");
                    PhysicalJournalHeader.SETRANGE(Status, PhysicalJournalHeader.Status::Open);
                    IF PhysicalJournalHeader.FINDFIRST THEN
                        ERROR(Text0001);


                    Rec.TESTFIELD(Plant);
                    IF CONFIRM('Do you want to update Inventory Data?', TRUE) THEN BEGIN
                        Rec.DeleteLines;
                        Rec.GetInventory(0D, TODAY, Rec.Plant);
                        PhysicalJournalLine.RESET;
                        PhysicalJournalLine.SETRANGE("Document No.", Rec."No.");
                        IF PhysicalJournalLine.FINDFIRST THEN
                            REPEAT
                                PhysicalJournalOutputEntrie.ReAllocateQty(PhysicalJournalLine, TRUE);
                            UNTIL PhysicalJournalLine.NEXT = 0;
                    END;
                end;
            }
            action(Release)
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PhysicalJournalLine: Record "Physical Journal Line";
                begin
                    PhysicalJournalLine.RESET;
                    PhysicalJournalLine.SETRANGE("Document No.", Rec."No.");
                    IF PhysicalJournalLine.FINDFIRST THEN
                        REPEAT
                            CLEAR(PhysicalJournalOutputEntrie);
                            PhysicalJournalOutputEntrie.ReAllocateQty(PhysicalJournalLine, FALSE);
                        UNTIL PhysicalJournalLine.NEXT = 0;

                    IF CONFIRM('Do you want to Release the Voucher', FALSE) THEN
                        Rec.ChangeStatusRelease(Rec);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.ChangeStatusOpen(Rec);
                end;
            }
            action(Post)
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PhysicalJournalLine: Record "Physical Journal Line";
                begin
                    PhysicalJournalLine.RESET;
                    PhysicalJournalLine.SETRANGE("Document No.", Rec."No.");
                    IF PhysicalJournalLine.FINDFIRST THEN
                        REPEAT
                            CLEAR(PhysicalJournalOutputEntrie);
                            PhysicalJournalOutputEntrie.ReAllocateQty(PhysicalJournalLine, FALSE);
                        UNTIL PhysicalJournalLine.NEXT = 0;

                    Rec.PostProductionVoucher(Rec);

                    Rec.BlockDimVal('PICC', Rec."PICC Key");
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Voucher Type" := Rec."Voucher Type"::"Production Voucher";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Voucher Type" := Rec."Voucher Type"::"Production Voucher";
    end;

    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
        PhysicalJournalHeader: Record "Physical Journal Header";
        Text0001: Label 'Status must not be Open!';
        DimensionValue: Record "Dimension Value";
}

