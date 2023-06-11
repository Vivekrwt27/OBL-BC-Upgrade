page 50026 "RFQ Nos. List"
{
    // cust 3 ravi

    Editable = false;
    PageType = Card;
    SourceTable = "RFQ No.";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'RFQ No.';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Generate &Quotation Comparison Statement")
                {
                    Caption = 'Generate &Quotation Comparison Statement';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchHeader: Record "Purchase Header";
                        PurchLine: Record "Purchase Line";
                        QuotComparisonBuffer: Record "Vendor Master Archive";
                        //    StrOrderLineDetails: Record 13795;
                        QCS: Report "Pending Intran";
                    begin
                        Rec.TESTFIELD("No.");

                        QuotComparisonBuffer.DELETEALL;
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."RFQ No.", Rec."No.");
                        IF PurchHeader.FIND('-') THEN
                            REPEAT
                                // Calculate Structures
                                /*   PurchLine.CalculateStructures(PurchHeader);
                                   PurchLine.AdjustStructureAmounts(PurchHeader);
                                   PurchLine.UpdatePurchLines(PurchHeader);*/

                                PurchLine.RESET;
                                PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Quote);
                                PurchLine.SETFILTER(Type, '%1|%2', PurchLine.Type::Item,
                                                     PurchLine.Type::"Fixed Asset");
                                PurchLine.SETRANGE("Document No.", PurchHeader."No.");

                                IF PurchLine.FIND('-') THEN
                                    REPEAT

                                        QuotComparisonBuffer.INIT;

                                        QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."No.", Rec."No.");
                                        QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer.Name, PurchHeader."No.");
                                        QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Territory Code", PurchHeader."Buy-from Vendor No.");
                                    /* IF PurchLine.Type = PurchLine.Type::Item THEN
                                         QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Search Name", QuotComparisonBuffer."Search Name"::"0")
                                     ELSE
                                         QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Search Name", QuotComparisonBuffer."Search Name"::"1");
                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Name 2", PurchLine."No.");
                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Global Dimension 2 Code", PurchLine.Description);
                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer.Address, PurchLine."Direct Unit Cost");
                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Address 2", PurchLine."Promised Receipt Date");
                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Phone No.", PurchLine.Quantity);
                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Our Account No.", PurchHeader."Payment Terms Code");

                                     StrOrderLineDetails.RESET;
                                     StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
                                     StrOrderLineDetails.SETRANGE("Document Type", StrOrderLineDetails."Document Type"::Quote);
                                     StrOrderLineDetails.SETRANGE("Document No.", PurchLine."Document No.");
                                     StrOrderLineDetails.SETRANGE("Item No.", PurchLine."No.");
                                     StrOrderLineDetails.SETRANGE("Line No.", PurchLine."Line No.");
                                     IF StrOrderLineDetails.FIND('-') THEN
                                         REPEAT
                                             CASE StrOrderLineDetails."Tax/Charge Type" OF
                                                 StrOrderLineDetails."Tax/Charge Type"::Charges:
                                                     CASE StrOrderLineDetails."Charge Type" OF
                                                         StrOrderLineDetails."Charge Type"::" ":
                                                             IF (StrOrderLineDetails."Tax/Charge Type" <> StrOrderLineDetails."Tax/Charge Type"::Excise) OR
                                                                (StrOrderLineDetails."Tax/Charge Type" <> StrOrderLineDetails."Tax/Charge Type"::"Sales Tax") OR
                                                                (StrOrderLineDetails."Tax/Charge Type" <> StrOrderLineDetails."Tax/Charge Type"::GST) OR
                                                                (StrOrderLineDetails."Tax/Charge Type" <> StrOrderLineDetails."Tax/Charge Type"::"Service Tax") THEN
                                                                 QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Other Charges",
                                                                    QuotComparisonBuffer."Other Charges" + StrOrderLineDetails.Amount);
                                                         StrOrderLineDetails."Charge Type"::Freight:
                                                             QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer.Freight,
                                                                QuotComparisonBuffer.Freight + StrOrderLineDetails.Amount);
                                                         StrOrderLineDetails."Charge Type"::Insurance:
                                                             QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Telex No.",
                                                                QuotComparisonBuffer."Telex No." + StrOrderLineDetails.Amount);
                                                         StrOrderLineDetails."Charge Type"::Commission:
                                                             QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Other Charges",
                                                                QuotComparisonBuffer."Other Charges" + StrOrderLineDetails.Amount);
                                                     END;
                                                 StrOrderLineDetails."Tax/Charge Type"::"Sales Tax":
                                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Sales Tax",
                                                        QuotComparisonBuffer."Sales Tax" + StrOrderLineDetails.Amount);
                                                 StrOrderLineDetails."Tax/Charge Type"::Excise:
                                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer.Contact,
                                                        QuotComparisonBuffer.Contact + StrOrderLineDetails.Amount);
                                                 StrOrderLineDetails."Tax/Charge Type"::"Other Taxes":
                                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Other Charges",
                                                        QuotComparisonBuffer."Other Charges" + StrOrderLineDetails.Amount);
                                                 StrOrderLineDetails."Tax/Charge Type"::GST:
                                                     QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer."Global Dimension 1 Code",
                                                        QuotComparisonBuffer."Global Dimension 1 Code" + StrOrderLineDetails.Amount);
                                             END;
                                         UNTIL StrOrderLineDetails.NEXT = 0;
                                     IF PurchLine."Excise Accounting Type" = PurchLine."Excise Accounting Type"::"Without CENVAT" THEN
                                         QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer.City, (QuotComparisonBuffer.Address * QuotComparisonBuffer."Phone No.")
                                            + QuotComparisonBuffer.Contact + QuotComparisonBuffer."Telex No." + QuotComparisonBuffer.Freight +
                                            QuotComparisonBuffer."Other Charges" + QuotComparisonBuffer."Sales Tax" + QuotComparisonBuffer."Global Dimension 1 Code")
                                     ELSE
                                         QuotComparisonBuffer.VALIDATE(QuotComparisonBuffer.City, (QuotComparisonBuffer.Address * QuotComparisonBuffer."Phone No.")
                                            + QuotComparisonBuffer."Telex No." + QuotComparisonBuffer.Freight +
                                            QuotComparisonBuffer."Other Charges" + QuotComparisonBuffer."Sales Tax" + QuotComparisonBuffer."Global Dimension 1 Code");

                                     IF QuotComparisonBuffer."Phone No." <> 0 THEN
                                         QuotComparisonBuffer."Unit Landed Cost" := QuotComparisonBuffer.City / QuotComparisonBuffer."Phone No.";

                                     QuotComparisonBuffer.INSERT;*///
                                    UNTIL PurchLine.NEXT = 0;
                            UNTIL PurchHeader.NEXT = 0;

                        QuotComparisonBuffer.SETFILTER(QuotComparisonBuffer."No.", Rec."No.");
                        QCS.SETTABLEVIEW(QuotComparisonBuffer);
                        QCS.RUN;
                    end;
                }
            }
        }
    }
}

