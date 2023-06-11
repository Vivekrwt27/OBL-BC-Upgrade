page 50006 "Update Credit Note Desc."
{
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
    }

    actions
    {
        area(processing)
        {
            action("Change Descip in CL")
            {
                Caption = 'Change Descip in CL';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF SalesCrMemoHeader.FIND('-') THEN
                        REPEAT
                            SalesCrMemoLine.RESET;
                            SalesCrMemoLine.SETCURRENTKEY("Document No.", "Line No.");
                            SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                            SalesCrMemoLine.SETRANGE("Line No.", 10000);
                            IF SalesCrMemoLine.FIND('-') THEN BEGIN
                                CustLedgEntry.RESET;
                                CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                                CustLedgEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
                                IF CustLedgEntry.FIND('-') THEN BEGIN
                                    CustLedgEntry.Description := SalesCrMemoLine.Description + ' ' + SalesCrMemoLine."Description 2";
                                    CustLedgEntry.MODIFY;
                                END;
                            END;
                        UNTIL SalesCrMemoHeader.NEXT = 0;
                    MESSAGE('Finished');
                end;
            }
            action("Change Descip in VL")
            {
                Caption = 'Change Descip in VL';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF PurchCrMemoHeader.FIND('-') THEN
                        REPEAT
                            PurchCrMemoLine.RESET;
                            PurchCrMemoLine.SETCURRENTKEY("Document No.", "Line No.");
                            PurchCrMemoLine.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                            PurchCrMemoLine.SETRANGE("Line No.", 10000);
                            IF PurchCrMemoLine.FIND('-') THEN BEGIN
                                VendLedgEntry.RESET;
                                VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                                VendLedgEntry.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                                IF VendLedgEntry.FIND('-') THEN BEGIN
                                    VendLedgEntry.Description := PurchCrMemoLine.Description + ' ' + PurchCrMemoLine."Description 2";
                                    VendLedgEntry.MODIFY;
                                END;
                            END;
                        UNTIL PurchCrMemoHeader.NEXT = 0;
                    MESSAGE('Finished');
                end;
            }
            action("Transfer Descrip VL to GL")
            {
                Caption = 'Transfer Descrip VL to GL';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF PurchCrMemoHeader.FIND('-') THEN
                        REPEAT
                            PurchCrMemoLine.RESET;
                            PurchCrMemoLine.SETCURRENTKEY("Document No.", "Line No.");
                            PurchCrMemoLine.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                            PurchCrMemoLine.SETRANGE("Line No.", 10000);
                            IF PurchCrMemoLine.FIND('-') THEN BEGIN
                                GLEntry.RESET;
                                GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                                GLEntry.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                GLEntry.SETRANGE("Posting Date", PurchCrMemoHeader."Posting Date");
                                IF GLEntry.FIND('-') THEN
                                    REPEAT
                                        GLEntry.Description := PurchCrMemoLine.Description + ' ' + PurchCrMemoLine."Description 2";
                                        GLEntry.MODIFY;
                                    UNTIL GLEntry.NEXT = 0;
                            END;
                        UNTIL PurchCrMemoHeader.NEXT = 0;
                    MESSAGE('Finished');
                end;
            }
            action("Transfer Descrip CL to GL")
            {
                Caption = 'Transfer Descrip CL to GL';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesCrMemoHeader.SETRANGE("No.",'0507HOCN000001');
                    IF SalesCrMemoHeader.FIND('-') THEN
                        REPEAT
                            SalesCrMemoLine.RESET;
                            SalesCrMemoLine.SETCURRENTKEY("Document No.", "Line No.");
                            SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                            SalesCrMemoLine.SETRANGE("Line No.", 10000);
                            IF SalesCrMemoLine.FIND('-') THEN BEGIN
                                GLEntry.RESET;
                                GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                                GLEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                GLEntry.SETRANGE("Posting Date", SalesCrMemoHeader."Posting Date");
                                IF GLEntry.FIND('-') THEN
                                    REPEAT
                                        GLEntry.Description := SalesCrMemoLine.Description + ' ' + SalesCrMemoLine."Description 2";
                                        GLEntry.MODIFY;
                                    UNTIL GLEntry.NEXT = 0;
                            END;
                        UNTIL SalesCrMemoHeader.NEXT = 0;
                    MESSAGE('Finished');
                end;
            }
        }
    }

    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLEntry: Record "G/L Entry";
}

