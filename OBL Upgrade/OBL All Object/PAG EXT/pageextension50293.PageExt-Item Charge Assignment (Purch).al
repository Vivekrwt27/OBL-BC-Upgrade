pageextension 50293 pageextension50293 extends "Item Charge Assignment (Purch)"
{
    layout
    {
        addafter("Item No.")
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
            field("Document Line No."; Rec."Document Line No.")
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SuggestItemChargeAssignment)
        {
            action("Update Vendor Invoice No.")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PostedPurchRcpt: Record "Purch. Rcpt. Header";
                    PurchInvHead: Record "Purchase Header";
                begin
                    IF PostedPurchRcpt.GET(Rec."Applies-to Doc. No.") THEN
                        IF PurchInvHead.GET(PurchInvHead."Document Type"::Invoice, Rec."Document No.") THEN BEGIN
                            PurchInvHead."Vendor Invoice No." := PostedPurchRcpt."Vendor Invoice No.";
                            PurchInvHead.MODIFY;
                        END;
                end;
            }
        }
    }
}

