report 50018 "Generate MRN To Purch. Invo"
{
    // >>MSVRN 211117 modified V1.1<< //Vendor Invoice No. and Date
    // >>MSVRN 221117 modified V1.2<< //Posting No. Series
    // >>MSVRN 050118 modified V1.3<< //Purch. Rec. Ref No. To Purch. Inv

    Permissions = TableData "Purch. Rcpt. Line" = rimd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Purch. Rcpt. Line"; 121)
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                WHERE("Qty. Rcd. Not Invoiced" = FILTER(<> 0),
                                      "Invoice Created" = FILTER(false));
            RequestFilterFields = "Document No.", "Location Code", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                IF DocNo <> "Document No." THEN BEGIN
                    recPurchRecHdr.RESET;
                    recPurchRecHdr.SETRANGE("No.", "Document No.");
                    IF recPurchRecHdr.FINDFIRST THEN BEGIN
                        PurchHeader.RESET;
                        PurchHeader.INIT;
                        PurchHeader.VALIDATE("Document Type", PurchHeader."Document Type"::Invoice);
                        //PurchHeader.VALIDATE("Posting Date",TODAY);
                        PurchHeader.VALIDATE("No. Series", NoSeries);
                        PurchHeader."No." := NoseriesMgt.GetNextNo(NoSeries, TODAY, TRUE);
                        PurchHeader."Buy-from Vendor No." := recPurchRecHdr."Buy-from Vendor No.";
                        PurchHeader."Vendor Invoice No." := recPurchRecHdr."Vendor Invoice No.";
                        PurchHeader."Vendor Invoice Date" := recPurchRecHdr."Vendor Invoice Date";
                        PurchHeader.INSERT(TRUE);

                        PurchHeader.VALIDATE("Buy-from Vendor No.", "Buy-from Vendor No.");

                        /* 16630 IF recPurchRecHdr.Structure <> '' THEN
                             PurchHeader.VALIDATE(Structure, recPurchRecHdr.Structure);*/
                        //PurchHeader.VALIDATE("Posting No. Series", PostingNoSeries); //MSVRN 221117
                        PurchHeader.VALIDATE("Location Code", recPurchRecHdr."Location Code");
                        PurchHeader.VALIDATE("Posting No. Series", PostingNoSeries); //MSVRN 221117
                        PurchHeader.MODIFY;
                        LineNo := 0;
                        NoofDocuments += 1;
                        COMMIT;
                        DocNo := "Document No.";
                    END;
                END;

                LineNo += 10000;
                PurchLine.INIT;
                PurchLine.VALIDATE("Document Type", PurchHeader."Document Type");
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := LineNo;
                PurchLine.VALIDATE(Type, Type);
                PurchLine.VALIDATE("No.", "No.");
                PurchLine.VALIDATE(Quantity, "Qty. Rcd. Not Invoiced");
                PurchLine."Posting Date" := PurchHeader."Posting Date";
                PurchLine.VALIDATE("Direct Unit Cost", "Direct Unit Cost");
                PurchLine."GST Group Code" := "GST Group Code";
                PurchLine."HSN/SAC Code" := "HSN/SAC Code";
                PurchLine."Receipt No." := "Document No."; //MSVRN 050118 /Ref. No.
                PurchLine."Source Order No." := "Order No."; //MSVRN 050118
                PurchLine."Receipt Line No." := "Line No."; //MSVRN 050118
                PurchLine.INSERT;
                //MESSAGE("Document No.");
                "Invoice Created" := TRUE;
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                IF "Purch. Rcpt. Line".GETFILTER("Location Code") = '' THEN
                    ERROR('Please select the Location Code');
                IF Location = 0 THEN
                    ERROR('Please select the No.Series');
                NoSeries := FORMAT(Location);
                LineNo := 0
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
                field("Posting No. Series"; PostingNoSeries)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        NoSeriesRelation.RESET;
                        NoSeriesRelation.SETRANGE(Code, 'PI');
                        IF NoSeriesRelation.FINDFIRST THEN
                            IF PAGE.RUNMODAL(PAGE::"No. Series Relationships", NoSeriesRelation) = ACTION::LookupOK THEN BEGIN
                                PostingNoSeries := NoSeriesRelation."Series Code";
                            END;
                    end;

                    trigger OnValidate()
                    begin
                        /*
                        IF PurchHeader."Posting No. Series" <> '' THEN BEGIN
                          PurchSetup.GET;
                          TestNoSeries;
                          NoSeriesMgt.TestSeries(GetPostingNoSeriesCode,"Posting No. Series");
                        END;
                         */

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
        MESSAGE('Total %1 No. of Invoices Generated, Please Check and post', NoofDocuments);
    end;

    var
        PurchHeader: Record "Purchase Header";
        PurchHeader1: Record "Purchase Header";
        VendorCode: Code[20];
        VendorInv: Code[20];
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
        NoSeries: Code[10];
        Location: Option " ","P-INV",PIFR,PIPURDRA,PIPURHSK,PIPURSKD;
        NoofDocuments: Integer;
        NoseriesMgt: Codeunit NoSeriesManagement;
        recPurchRecLn: Record "Purch. Rcpt. Line";
        DocNo: Code[20];
        recPurchRecHdr: Record "Purch. Rcpt. Header";
        PostingNoSeries: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
        TestNoSeries: Code[20];
        series: Record "Purchases & Payables Setup";
        NoSeriesRelation: Record "No. Series Relationship";
}

