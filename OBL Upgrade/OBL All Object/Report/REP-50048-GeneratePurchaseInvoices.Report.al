report 50048 "Generate Purchase Invoices"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Invoice Upload"; 50083)
        {
            DataItemTableView = SORTING("Location Code", "Vendor Invoice No.")
                                WHERE(Processed = CONST(false));

            trigger OnAfterGetRecord()
            begin
                IF "Purchase Invoice Upload"."Document Type" = "Purchase Invoice Upload"."Document Type"::Invoice THEN BEGIN
                    IF (VendorCode <> "Purchase Invoice Upload"."Vendor No.") OR (VendorInv <> "Purchase Invoice Upload"."Vendor Invoice No.") THEN BEGIN
                        VendorCode := "Purchase Invoice Upload"."Vendor No.";
                        VendorInv := "Purchase Invoice Upload"."Vendor Invoice No.";
                        CLEAR(NoseriesMgt);
                        PurchHeader.INIT;
                        //PurchHeader."Document Type":= PurchHeader."Document Type"::Invoice;
                        PurchHeader.VALIDATE("Document Type", PurchHeader."Document Type"::Invoice);
                        //PurchHeader.VALIDATE("Posting Date",TODAY);
                        PurchHeader.VALIDATE("No. Series", NoSeries);
                        PurchHeader."No." := NoseriesMgt.GetNextNo(NoSeries, WORKDATE, TRUE);
                        //PurchHeader.VALIDATE("Buy-from Vendor No.", "Purchase Invoice Upload"."Vendor No.");
                        PurchHeader."Vendor Invoice No." := VendorInv;
                        PurchHeader."Vendor Invoice Date" := "Purchase Invoice Upload"."Vendor Invoice Date";
                        PurchHeader.INSERT(TRUE);
                        //MESSAGE('After %1',"Purchase Invoice Upload"."Vendor No.");
                        PurchHeader.VALIDATE("Buy-from Vendor No.", "Purchase Invoice Upload"."Vendor No.");
                        PurchHeader.VALIDATE("Location Code", "Purchase Invoice Upload"."Location Code");
                        PurchHeader.VALIDATE("Posting Description", "Purchase Invoice Upload"."Posting Desc");
                        PurchHeader.VALIDATE("Shortcut Dimension 2 Code", "Purchase Invoice Upload"."Shortcut Dimension 2 Code");

                        IF Structure <> '' THEN
                            // 16630      PurchHeader.VALIDATE(Structure, "Purchase Invoice Upload".Structure);
                            PurchHeader.MODIFY;
                        LineNo := 0;
                        NoofDocuments += 1;
                        COMMIT;
                    END;


                    LineNo += 10000;
                    PurchLine.INIT;
                    PurchLine."Document Type" := PurchHeader."Document Type";
                    PurchLine.VALIDATE("Document No.", PurchHeader."No.");
                    PurchLine."Line No." := LineNo;
                    PurchLine."Posting Date" := PurchHeader."Posting Date";
                    PurchLine.VALIDATE(Type, "Purchase Invoice Upload".Type);
                    PurchLine.VALIDATE("No.", "Purchase Invoice Upload"."No.");
                    PurchLine.VALIDATE(Quantity, "Purchase Invoice Upload".Quantity);
                    PurchLine.VALIDATE("Direct Unit Cost", "Purchase Invoice Upload".Rate);
                    PurchLine.VALIDATE("GST Group Type", "Purchase Invoice Upload"."GST Group Type");
                    PurchLine.VALIDATE("Gen. Prod. Posting Group", "Purchase Invoice Upload"."Gen. Prod. Posting Grp.");
                    PurchLine."GST Group Code" := "Purchase Invoice Upload"."GST Group";
                    PurchLine."HSN/SAC Code" := "Purchase Invoice Upload"."HSN No.";
                    PurchLine.VALIDATE("ITC Type", "Purchase Invoice Upload"."ITC Type");
                    PurchLine.VALIDATE(NOE, "Purchase Invoice Upload".NOE);
                    PurchLine.INSERT;

                    PurchLine.Description := PurchHeader."Posting Description";
                    PurchLine.MODIFY;

                    "Purchase Invoice Upload"."Purchase Invoice No." := PurchLine."Document No.";
                    "Purchase Invoice Upload".Processed := TRUE;
                    MODIFY;
                END ELSE
                    IF "Purchase Invoice Upload"."Document Type" = "Purchase Invoice Upload"."Document Type"::"Credit Memo" THEN BEGIN
                        IF (VendorCode <> "Purchase Invoice Upload"."Vendor No.") OR (VendorInv <> "Purchase Invoice Upload"."Vendor Invoice No.") THEN BEGIN
                            VendorCode := "Purchase Invoice Upload"."Vendor No.";
                            VendorInv := "Purchase Invoice Upload"."Vendor Invoice No.";
                            CLEAR(NoseriesMgt);
                            PurchHeader.INIT;
                            //PurchHeader."Document Type":= PurchHeader."Document Type"::Invoice;
                            PurchHeader.VALIDATE("Document Type", PurchHeader."Document Type"::"Credit Memo");
                            //PurchHeader.VALIDATE("Posting Date",TODAY);
                            PurchHeader.VALIDATE("No. Series", NoSeries);
                            PurchHeader."No." := NoseriesMgt.GetNextNo(NoSeries, WORKDATE, TRUE);
                            //PurchHeader.VALIDATE("Buy-from Vendor No.", "Purchase Invoice Upload"."Vendor No.");
                            PurchHeader."Vendor Invoice No." := VendorInv;
                            PurchHeader."Vendor Invoice Date" := "Purchase Invoice Upload"."Vendor Invoice Date";
                            PurchHeader.INSERT(TRUE);
                            //MESSAGE('After %1',"Purchase Invoice Upload"."Vendor No.");
                            PurchHeader.VALIDATE("Buy-from Vendor No.", "Purchase Invoice Upload"."Vendor No.");
                            PurchHeader.VALIDATE("Location Code", "Purchase Invoice Upload"."Location Code");
                            PurchHeader.VALIDATE("Posting Description", "Purchase Invoice Upload"."Posting Desc");
                            PurchLine.VALIDATE("GST Group Type", "Purchase Invoice Upload"."GST Group Type");
                            PurchHeader.VALIDATE("Vendor Cr. Memo No.", "Vendor Invoice No.");
                            PurchHeader.VALIDATE("GST Reason Type", 7);
                            PurchHeader.VALIDATE("Shortcut Dimension 2 Code", "Purchase Invoice Upload"."Shortcut Dimension 2 Code");

                            IF Structure <> '' THEN
                                // 16630     PurchHeader.VALIDATE(Structure, "Purchase Invoice Upload".Structure);
                                PurchHeader.MODIFY;
                            LineNo := 0;
                            NoofDocuments += 1;
                            COMMIT;
                        END;


                        LineNo += 10000;
                        PurchLine.INIT;
                        PurchLine."Document Type" := PurchHeader."Document Type";
                        PurchLine.VALIDATE("Document No.", PurchHeader."No.");
                        PurchLine."Line No." := LineNo;
                        PurchLine."Posting Date" := PurchHeader."Posting Date";
                        PurchLine.VALIDATE(Type, "Purchase Invoice Upload".Type);
                        PurchLine.VALIDATE("No.", "Purchase Invoice Upload"."No.");
                        PurchLine.VALIDATE(Quantity, "Purchase Invoice Upload".Quantity);
                        PurchLine.VALIDATE("Direct Unit Cost", "Purchase Invoice Upload".Rate);
                        PurchLine.VALIDATE("GST Group Type", "Purchase Invoice Upload"."GST Group Type");
                        PurchLine.VALIDATE("Gen. Prod. Posting Group", "Purchase Invoice Upload"."Gen. Prod. Posting Grp.");
                        PurchLine."GST Group Code" := "Purchase Invoice Upload"."GST Group";
                        PurchLine."HSN/SAC Code" := "Purchase Invoice Upload"."HSN No.";
                        PurchLine.VALIDATE("ITC Type", "Purchase Invoice Upload"."ITC Type");
                        PurchLine.VALIDATE(NOE, "Purchase Invoice Upload".NOE);
                        PurchLine.INSERT;

                        PurchLine.Description := PurchHeader."Posting Description";
                        PurchLine.MODIFY;

                        "Purchase Invoice Upload"."Purchase Invoice No." := PurchLine."Document No.";
                        "Purchase Invoice Upload".Processed := TRUE;
                        MODIFY;
                    END;
            end;

            trigger OnPreDataItem()
            begin
                IF Location = 0 THEN
                    ERROR('Please select the No. Series!');
                NoofDocuments := 0;
                NoSeries := FORMAT(Location);
                //MESSAGE(NoSeries);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("No. Series"; Location)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoSeries := FORMAT(Location);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Total %1 invoice(s) generated!', NoofDocuments);
    end;

    var
        PurchHeader: Record "Purchase Header";
        VendorCode: Code[20];
        VendorInv: Code[20];
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
        NoSeries: Code[10];
        Location: Option " ",PIPURDRA,PIPURHSK,PIPURSKD,PRDNSKD;
        NoofDocuments: Integer;
        NoseriesMgt: Codeunit NoSeriesManagement;
}

