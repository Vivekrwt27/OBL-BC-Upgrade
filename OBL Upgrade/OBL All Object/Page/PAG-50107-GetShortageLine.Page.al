page 50107 "Get Shortage Line"
{
    PageType = Card;
    SourceTable = "Transfer Receipt Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Short Quantity"; Rec."Short Quantity")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        GetReceipts: Codeunit "Purch.-Get Receipt";
        TransHeader: Record "Transfer Header";
        TransReceLine2: Record "Transfer Receipt Line";
        TransferLine: Record "Transfer Line";
        NextLineNo: Integer;
        TransfRHeader: Record "Transfer Receipt Header";
        Location: Record Location;

    procedure SetTransHeader(var TransHeader2: Record "Transfer Header")
    begin
        TransHeader.GET(TransHeader2."No.");
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        TransReceLine2 := Rec;
        TransferLine.RESET;
        TransferLine.SETRANGE("Document No.", TransHeader."No.");
        IF TransferLine.FINDFIRST THEN
            TransferLine.DELETEALL;
        NextLineNo := 10000;
        WITH Rec DO BEGIN
            IF Rec.FINDSET THEN
                REPEAT
                    IF TransfRHeader.GET(Rec."Document No.") THEN BEGIN
                        TransHeader.VALIDATE("Transporter's Name", TransfRHeader."Transporter's Name");
                        TransHeader."GR No." := TransfRHeader."GR No.";
                        TransHeader."GR Date" := TransfRHeader."GR Date";
                        TransHeader."Truck No." := TransfRHeader."Truck No.";
                        TransHeader.MODIFY;
                    END;
                    TransferLine.INIT;
                    TransferLine.VALIDATE("Document No.", TransHeader."No.");
                    TransferLine."Line No." := NextLineNo;
                    TransferLine.VALIDATE("Item No.", Rec."Item No.");
                    TransferLine.VALIDATE(Quantity, Rec."Short Quantity");
                    TransferLine.VALIDATE("Unit of Measure", Rec."Unit of Measure");
                    TransferLine.VALIDATE(Description, Rec.Description);
                    TransferLine.VALIDATE("Qty. per Unit of Measure", Rec."Qty. per Unit of Measure");
                    TransferLine.VALIDATE("Unit of Measure Code", Rec."Unit of Measure Code");
                    TransferLine.VALIDATE("Gross Weight", Rec."Gross Weight");
                    TransferLine.VALIDATE("Net Weight", Rec."Net Weight");
                    TransferLine.VALIDATE("Unit Price", Rec."Unit Price");
                    TransferLine.VALIDATE(Amount, Rec.Amount);
                    TransferLine."Shoratge Transfer Rcpt No." := Rec."Document No.";
                    TransferLine.VALIDATE("Qty. to Ship", Rec."Short Quantity");
                    Location.GET(Rec."Transfer-to Code");
                    TransferLine.VALIDATE("Customer Price Group", Location."Customer Price Group");
                    TransferLine.INSERT;
                    NextLineNo += 10000;
                UNTIL Rec.NEXT = 0;
        END;
        CurrPage.CLOSE;
    end;
}

