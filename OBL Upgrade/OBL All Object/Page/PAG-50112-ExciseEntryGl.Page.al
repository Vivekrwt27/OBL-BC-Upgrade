/*page 50112 "Excise Entry - Gl"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Excise Entry";
    SourceTableView = SORTING(Type, "Document Type", "Document No.", "Posting Date", "Item No.")
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Purchase));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("BED %"; Rec."BED %")
                {
                }
                field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
                {
                }
                field("Excise Prod. Posting Group"; Rec."Excise Prod. Posting Group")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Base; Rec.Base)
                {
                }
                field("Sell-to/Buy-from No."; Rec."Sell-to/Buy-from No.")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("BED Amount"; Rec."BED Amount")
                {
                }
                field("eCess Amount"; "eCess Amount")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("E.C.C. No."; Rec."E.C.C. No.")
                {
                }
                field("SHE Cess Amount"; Rec."SHE Cess Amount")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        VendName := '';
        IF RecVendor.GET("Sell-to/Buy-from No.") THEN
            VendName := RecVendor.Name;
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        RecVendor: Record Vendor;
        VendName: Text[100];

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        VendName := '';
        IF RecVendor.GET("Sell-to/Buy-from No.") THEN
            VendName := RecVendor.Name;
    end;
}*/

