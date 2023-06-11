page 50045 "Indent Lines List"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Indent Line";
    SourceTableView = SORTING(Status, "Order No.", Deleted)
                      ORDER(Ascending)
                      WHERE(Date = FILTER('11/01/22..'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Selection; Rec.Selection)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PendQty; PendQty)
                {
                    Caption = 'Pending Qty.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PO Qty"; Rec."PO Qty")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measurement"; Rec."Unit of Measurement")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ref Code"; Rec."Ref Code")
                {
                    ApplicationArea = All;
                }
                field(HSN; Rec.HSN)
                {
                    ApplicationArea = All;
                }
                field("Authorization Date"; Rec."Authorization Date")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Item Code Service App"; Rec."Item Code Service App")
                {
                    ApplicationArea = All;
                }
                field("Capex Description"; Capdesc)
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

    trigger OnAfterGetRecord()
    begin
        //MSBS.Rao Start 181214
        /*PendQty := 0;
        IF "Orginal Entry" THEN
          PendQty := Quantity-GetTotalPOQty("Document No.","No.")
        ELSE
          PendQty := Quantity-"Linked Qty";
        */

        NewDate := 20110415D;//MSBS.Rao 160115
        IF Rec.Date >= NewDate THEN//MSBS.Rao 160115
            PendQty := Rec.GetTotalPOQty(Rec."Document No.", Rec."No.", Rec.Quantity, Rec."Line No.", TRUE, Rec."Orginal Entry")
        ELSE //MSBS.Rao 160115
            PendQty := Rec.Quantity;//MSBS.Rao 160115

        IF IndentHeader.GET(Rec."Document No.") THEN
            IF IndentHeader."Capex No." <> '' THEN BEGIN
                BudgetMaster.RESET;
                BudgetMaster.SETRANGE("No.", IndentHeader."Capex No.");
                IF BudgetMaster.FINDFIRST THEN
                    Capdesc := BudgetMaster.Description
                ELSE
                    Capdesc := '';
            END;

        //MSBS.Rao Stop 181214

    end;

    trigger OnOpenPage()
    var
        IndentLine: Record "Indent Line";
    begin
        IndentLine.RESET;
        IndentLine.SETRANGE(Selection, TRUE);
        IndentLine.MODIFYALL(Selection, FALSE);

        // CLEAR(cdCloseIndent);
        // cdCloseIndent.RUN;

        COMMIT;
        //MESSAGE('Done');
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        PurchaseLine2: Record "Purchase Line";
        Purchaseorder: Page "Purchase Order";
        PendQty: Decimal;
        RecIndentLine: Record "Indent Line";
        TotalPOQty: Decimal;
        NewDate: Date;
        cdCloseIndent: Codeunit "Update Indents";
        BudgetMaster: Record "Budget Master";
        Capdesc: Text[50];
        IndentHeader: Record "Indent Header";

    procedure Func()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
    end;

    procedure GetSelectionFilter(): Code[80]
    var
        IndentLine: Record "Indent Line";
        FirstIndentLine: Code[30];
        LastIndentLine: Code[30];
        SelectionFilter: Code[250];
        IndentLineCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(IndentLine);
        IndentLineCount := IndentLine.COUNT;
        IF IndentLineCount > 0 THEN BEGIN
            IndentLine.FIND('-');
            WHILE IndentLineCount > 0 DO BEGIN
                IndentLineCount := IndentLineCount - 1;
                IndentLine.MARKEDONLY(FALSE);
                FirstIndentLine := IndentLine."Document No.";
                LastIndentLine := FirstIndentLine;
                More := (IndentLineCount > 0);
                WHILE More DO
                    IF IndentLine.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT IndentLine.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastIndentLine := IndentLine."Document No.";
                            IndentLineCount := IndentLineCount - 1;
                            IF IndentLineCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstIndentLine = LastIndentLine THEN
                    SelectionFilter := SelectionFilter + FirstIndentLine
                ELSE
                    SelectionFilter := SelectionFilter + FirstIndentLine + '..' + LastIndentLine;
                IF IndentLineCount > 0 THEN BEGIN
                    IndentLine.MARKEDONLY(TRUE);
                    IndentLine.NEXT;
                END;
            END;
        END;
        MESSAGE('%1', SelectionFilter);
        EXIT(SelectionFilter);
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        CurrPage.SAVERECORD;
    end;
}

