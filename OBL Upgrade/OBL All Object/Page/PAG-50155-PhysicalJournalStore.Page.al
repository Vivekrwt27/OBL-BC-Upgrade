page 50155 "Physical Journal -Store"
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Plant; Rec.Plant)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PICC Key"; Rec."PICC Key")
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
                begin
                    Rec.TESTFIELD(Plant);
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    IF CONFIRM('Do you want to update Inventory Data?', TRUE) THEN BEGIN
                        Rec.DeleteLines;
                        Rec.GetInventory(0D, TODAY, Rec.Plant);
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
                begin
                    //IF CONFIRM('Do you want to Release the Voucher',FALSE) THEN
                    /*
                    PhysicalJournalLine.RESET;
                    PhysicalJournalLine.SETRANGE("Document No.", "No.");
                    PhysicalJournalLine.SETFILTER("Item No.", '');
                    PhysicalJournalLine.SETRANGE("Line No.", 0);
                    IF PhysicalJournalLine.FINDFIRST THEN
                      ERROR(Text0001, PhysicalJournalLine."Item No.", PhysicalJournalLine."Line No.");
                      */

                    PhysicalJournalLine.RESET;
                    PhysicalJournalLine.SETRANGE("Document No.", Rec."No.");
                    IF NOT PhysicalJournalLine.FINDFIRST THEN
                        ERROR(Text0001)
                    ELSE BEGIN
                        PhysicalJournalLine.SETFILTER("Item No.", '');
                        PhysicalJournalLine.SETRANGE("Line No.", 0);
                        IF PhysicalJournalLine.FINDFIRST THEN
                            ERROR(Text0001, PhysicalJournalLine."Item No.", PhysicalJournalLine."Line No.");
                    END;
                    PhysicalJournalLine.RESET;
                    PhysicalJournalLine.SETRANGE("Document No.", Rec."No.");
                    PhysicalJournalLine.SETFILTER("Transfer Inventory", '>%1', 0);
                    IF PhysicalJournalLine.FINDFIRST THEN
                        REPEAT
                            PhysicalJournalLine.CALCFIELDS("Allocated Qty.");
                            IF PhysicalJournalLine."Allocated Qty." <> PhysicalJournalLine."Transfer Inventory" THEN
                                ERROR('Allocated Qty. Must be Equal to Transfer Inventory for Item No. %1', PhysicalJournalLine."Item No.");
                        UNTIL PhysicalJournalLine.NEXT = 0;
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CheckOpenDoc(Rec);
                    Rec.PostStoreVoucher(Rec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Voucher Type" := Rec."Voucher Type"::"Store Voucher";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*
        PhysicalJournalHeader.RESET;
        PhysicalJournalHeader.SETRANGE(Status, PhysicalJournalHeader.Status::Open);
        PhysicalJournalHeader.SETRANGE("Voucher Type", PhysicalJournalHeader."Voucher Type"::"Store Voucher");
        IF NOT PhysicalJournalHeader.FINDFIRST THEN
          ERROR(Text0002, PhysicalJournalHeader);
        */


        Rec."Voucher Type" := Rec."Voucher Type"::"Store Voucher";

    end;

    var
        PhysicalJournalLine: Record "Physical Journal Line";
        Text0001: Label 'There is nothing to release, Item No. %1, Line No. %2!';
        PhysicalJournalHeader: Record "Physical Journal Header";
        Text0002: Label 'No any Physical Journal - (Store) is Open!';
}

