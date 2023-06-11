pageextension 50116 pageextension50116 extends "Inward Gate Entry SubForm"
{
    layout
    {
        addfirst(content)
        {
            field("Entry Type"; rec."Entry Type")
            {
                ApplicationArea = All;
            }
            field("Gate Entry No."; rec."Gate Entry No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Source Name")
        {
            field("Item No"; rec."Item No")
            {
                ApplicationArea = All;
            }
            field("Item Description"; rec."Item Description")
            {
                ApplicationArea = All;
            }
            field("Order Qty"; rec."Order Qty")
            {
                ApplicationArea = All;
            }
            field("Gate Pass Qty"; rec."Gate Pass Qty")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Gate Pass Qty"; Description)
        modify(Description)
        {
            Caption = 'Remarks';
        }
    }

    var
        //  PurchLineList: Page 50057;
        PurchLine: Record "Purchase Line";
        LineNo1: Integer;
        GateEntryLine: Record "Gate Entry Line";
        GateEntryHeader: Record "Gate Entry Header";
}

