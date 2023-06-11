page 50108 "Posted Sortage Transfer Rcpt"
{
    Caption = 'Posted Transfer Receipts';
    Editable = false;
    PageType = Card;
    SourceTable = "Transfer Receipt Header";
    SourceTableView = WHERE("Transfer-to Code" = FILTER('SHORTAGE'),
                            "Post Credit Memo" = FILTER(FALSE));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Receipt")
            {
                Caption = '&Receipt';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Posted Transfer Receipt";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Transfer Receipt Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Inventory Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Transfer Receipt"),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //RunObject = Page 547;//16225 Page N/F
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(TransRcptHeader);
                    TransRcptHeader.PrintRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        TransRcptHeader: Record "Transfer Receipt Header";
        TransRcptLine: Record "Transfer Receipt Line";
        NextLineNo: Integer;
        PurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        SalesPrice: Record "Sales Price";

    procedure SetPurchHeader(var PurchHeader2: Record "Purchase Header")
    begin
        PurchHeader.GET(PurchHeader2."Document Type", PurchHeader2."No.");
        PurchHeader.TESTFIELD("Document Type", PurchHeader."Document Type"::"Credit Memo");
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        TransRcptHeader := Rec;
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchaseLine.FINDFIRST THEN
            PurchaseLine.DELETEALL;
        NextLineNo := 10000;
        WITH Rec DO BEGIN
            REPEAT
                TransRcptLine.RESET;
                TransRcptLine.SETRANGE("Document No.", Rec."No.");
                IF TransRcptLine.FIND('-') THEN
                    REPEAT

                        PurchaseLine.INIT;
                        PurchaseLine.VALIDATE("Document Type", PurchaseLine."Document Type"::"Credit Memo");
                        PurchaseLine.VALIDATE("Document No.", PurchHeader."No.");
                        PurchaseLine."Line No." := NextLineNo;
                        PurchaseLine.VALIDATE(Type, PurchaseLine.Type::Item);
                        PurchaseLine.VALIDATE("No.", TransRcptLine."Item No.");
                        PurchaseLine.VALIDATE(Quantity, TransRcptLine.Quantity);
                        PurchaseLine.VALIDATE("Unit of Measure", TransRcptLine."Unit of Measure");
                        PurchaseLine.VALIDATE(Description, TransRcptLine.Description);
                        PurchaseLine.VALIDATE("Qty. per Unit of Measure", TransRcptLine."Qty. per Unit of Measure");
                        PurchaseLine.VALIDATE("Unit of Measure Code", TransRcptLine."Unit of Measure Code");
                        PurchaseLine.VALIDATE("Gross Weight", TransRcptLine."Gross Weight");
                        PurchaseLine.VALIDATE("Net Weight", TransRcptLine."Net Weight");
                        PurchaseLine.VALIDATE("Location Code", TransRcptLine."Transfer-to Code");
                        PurchaseLine.VALIDATE("Gen. Bus. Posting Group", 'SHORTAGE');
                        SalesPrice.RESET;
                        SalesPrice.SETCURRENTKEY("Sales Type", "Sales Code", "Item No.", "Starting Date", "Currency Code",
                                                 "Variant Code", "Unit of Measure Code", "Minimum Quantity");
                        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                        SalesPrice.SETRANGE("Sales Code", TransRcptLine."Customer Price Group");
                        SalesPrice.SETRANGE("Item No.", TransRcptLine."Item No.");
                        SalesPrice.SETRANGE("Unit of Measure Code", TransRcptLine."Unit of Measure Code");
                        IF SalesPrice.FINDLAST THEN
                            PurchaseLine.VALIDATE("Direct Unit Cost", SalesPrice."Unit Price");
                        PurchaseLine.VALIDATE(Amount, TransRcptLine.Amount);
                        PurchaseLine."Receipt No." := TransRcptLine."Document No.";
                        PurchaseLine."Receipt Line No." := NextLineNo;
                        PurchaseLine.VALIDATE("Qty. to Invoice", TransRcptLine.Quantity);
                        PurchaseLine."Shortage CRN" := TRUE;
                        PurchaseLine.INSERT;
                        NextLineNo += 10000;
                    UNTIL TransRcptLine.NEXT = 0;
            UNTIL Rec.NEXT = 0;
        END;
        CurrPage.CLOSE;
    end;
}

