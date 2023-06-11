pageextension 50162 pageextension50162 extends "Item Ledger Entries"
{
    layout
    {

        addafter("Job No.")
        {
            field("Capex No."; rec."Capex No.")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Category Code"; rec."Category Code")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field(Rate; Rate)
            {
                Caption = 'Rate';
                ApplicationArea = All;
            }
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field(Positive; rec.Positive)
            {
                ApplicationArea = All;
            }
            field("Output Date"; rec."Output Date")
            {
                ApplicationArea = All;
            }
            field("Plant Code"; rec."Plant Code")
            {
                ApplicationArea = All;
            }
            field("External Transfer"; rec."External Transfer")
            {
                ApplicationArea = All;
            }
            field("Document Date"; rec."Document Date")
            {
                ApplicationArea = All;
            }
            field("Direct Consumption Entries"; rec."Direct Consumption Entries")
            {
                ApplicationArea = All;
            }
            field("Work Shift Code"; rec."Work Shift Code")
            {
                ApplicationArea = All;
            }
            field(ReProcess; rec.ReProcess)
            {
                ApplicationArea = All;
            }
            field("Type Code"; rec."Type Code")
            {
                ApplicationArea = All;
            }
            field("Size Code"; rec."Size Code")
            {
                ApplicationArea = All;
            }
            field("Original Prod. No"; rec."Original Prod. No")
            {
                ApplicationArea = All;
            }
            field("Re Process Production Order"; rec."Re Process Production Order")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Item Base Unit of Measure"; rec."Item Base Unit of Measure")
            {
                ApplicationArea = All;
            }
            field("Item Category Code"; rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field("Inventory Posting Group"; rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
            field("Quality Code"; rec."Quality Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("General Prod. Posting Group"; rec."General Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Qty In Carton"; rec."Qty In Carton")
            {
                ApplicationArea = All;
            }
            field("Qty in Sq.Mt."; rec."Qty in Sq.Mt.")
            {
                ApplicationArea = All;
            }
            field("Qty in PCS."; rec."Qty in PCS.")
            {
                ApplicationArea = All;
            }
            field("Invoice No."; rec."Invoice No.")
            {
                ApplicationArea = All;
            }
            /*   field("Source No."; rec."Source No.")
              {
                  Editable = false;
                  Enabled = true;
                  ApplicationArea = All;
              } */
            field("Production Plant Code"; rec."Production Plant Code")
            {
                ApplicationArea = All;
            }
            field("Morbi Batch No."; rec."Morbi Batch No.")
            {
                ApplicationArea = All;
            }
            field("Item Classification"; Itemclass)
            {
                ApplicationArea = All;
            }
            field("Item Description"; Desc1)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Item Description 2"; Desc2)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Purchase Order No."; pono)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Mfg. Batch No."; rec."Mfg. Batch No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Posting Datetime"; rec."Posting Datetime")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(InTransit; rec.InTransit)
            {
                ApplicationArea = All;
            }
        }
    }

    var
        Rate: Decimal;
        ritem: Record Item;
        Itemclass: Text[10];
        purchrect: Record "Purch. Rcpt. Header";
        pono: Code[20];
        Desc1: Text[50];
        Desc2: Text[50];

    trigger OnAfterGetRecord()
    begin
        //Upgrade(+)
        Rate := 0;
        rec.CALCFIELDS("Cost Amount (Actual)");
        IF rec.Quantity <> 0 THEN
            Rate := rec."Cost Amount (Actual)" / rec.Quantity;
        rec."Capex No." := rec."Capex No.";
        OnAfterGetCurrRecord;

        //Upgarde

        IF ritem.GET(rec."Item No.") THEN
            Itemclass := ritem."Item Classification";
        Desc1 := ritem.Description;
        Desc2 := ritem."Description 2";


        IF purchrect.GET(rec."Document No.") THEN
            pono := purchrect."Order No.";

    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Rate := 0;
        rec.CALCFIELDS("Cost Amount (Actual)");
        IF rec.Quantity <> 0 THEN
            Rate := rec."Cost Amount (Actual)" / rec.Quantity;
        rec."Capex No." := rec."Capex No.";
    end;
}

