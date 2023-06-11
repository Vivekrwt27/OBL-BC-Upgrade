report 50137 "Certificate of Origin"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CertificateofOrigin.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(InvNo; "No.")
            {
            }
            column(InvDate; "Posting Date")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(CompName; RecCompany.Name)
            {
            }
            column(LocName; RecLocation.Name)
            {
            }
            column(LocAdd1; RecLocation.Address)
            {
            }
            column(LocAdd2; RecLocation."Address 2")
            {
            }
            column(LocCity; RecLocation.City)
            {
            }
            column(LocPostCode; RecLocation."Post Code")
            {
            }
            column(ExportImporterCode; RecLocation.IEC)
            {
            }
            column(LocPAN; RecCompany."P.A.N. No.")
            {
            }
            column(LocCountry; RecCompany.County)
            {
            }
            column(LocImporterCode; RecCompany."Importer Code No.")
            {
            }
            column(CustName; RecCustomer.Name)
            {
            }
            column(CustAdd; RecCustomer.Address)
            {
            }
            column(CustAdd2; RecCustomer."Address 2")
            {
            }
            column(CustCity; RecCustomer.City)
            {
            }
            column(CustPostCode; RecCustomer."Post Code")
            {
            }
            column(CustPAN; RecCustomer."P.A.N. No.")
            {
            }
            column(EximCode; RecCustomer."TAN No.") // 16630 replace here "E.C.C. No."
            {
            }
            column(CustCountry; CustCountry)
            {
            }
            column(CustPhone; RecCustomer."Phone No.")
            {
            }
            column(FinalHSN; FinalHSN)
            {
            }
            column(FinalTotDesc; FinalTotDesc)
            {
            }
            column(Bank; Bank)
            {
            }
            column(IssueDate; IssueDate)
            {
            }
            column(ImpExpCode; RecLocation.IEC)
            {
            }
            column(ILCNo; ILCNo)
            {
            }
            column(ILCDate; ILCDate)
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = filter(<> 0));
                column(DocumentNo; "Document No.")
                {
                }
                column(Line_No_; "Line No.")
                {

                }
                column(PostingDate; "Posting Date")
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(HSNSACCode; "HSN/SAC Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(AmountToCustomer; TotalAmtToCust)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    TotalAmtToCust := GetAmttoCustomerPostedLine("Document No.", "Line No.");
                end;

            }

            trigger OnAfterGetRecord()
            begin
                RecLocation.RESET;
                IF "Sales Invoice Header"."Location Code" <> '' THEN
                    IF RecLocation.GET("Sales Invoice Header"."Location Code") THEN;

                RecCustomer.RESET;
                IF RecCustomer.GET("Sales Invoice Header"."Sell-to Customer No.") THEN;

                Customer1.RESET;
                IF Customer1.GET("Sales Invoice Header"."Sell-to Customer No.") THEN BEGIN
                    IF Customer1."Country/Region Code" <> '' THEN
                        IF CountryRegion1.GET(Customer1."Country/Region Code") THEN
                            CustCountry := CountryRegion1.Name;
                END;


                VarHSN := '';
                recSIL.RESET;
                recSIL.SETCURRENTKEY("HSN/SAC Code");
                recSIL.SETASCENDING("HSN/SAC Code", TRUE);
                recSIL.SETRANGE("Document No.", "No.");

                IF recSIL.FINDFIRST THEN
                    REPEAT
                        IF recSIL."HSN/SAC Code" <> VarHSN THEN BEGIN
                            VarHSN := recSIL."HSN/SAC Code";
                            TotHSN += VarHSN + ', ';
                        END;
                    UNTIL recSIL.NEXT = 0;

                HSNTotString := STRLEN(TotHSN);
                If HSNTotString <> 0 then
                    FinalHSN := COPYSTR(TotHSN, 1, HSNTotString - 2);


                VarDesc := '';
                recSIL.RESET;
                recSIL.SETCURRENTKEY("Item Category Code");
                recSIL.SETASCENDING("Item Category Code", TRUE);
                recSIL.SETRANGE("Document No.", "No.");
                IF recSIL.FINDFIRST THEN
                    REPEAT
                        IF recSIL."Item Category Code" <> VarDesc THEN BEGIN
                            IF RecItemCategory.GET(recSIL."Item Category Code") THEN;
                            VarDesc := recSIL."Item Category Code";
                            TotDesc += RecItemCategory.Description + '/';
                        END;
                    UNTIL recSIL.NEXT = 0;
                TotStringDesc := STRLEN(TotDesc);
                FinalTotDesc := COPYSTR(TotDesc, 1, TotStringDesc - 1);

                CLEAR(EximCode);
                CLEAR(IssueDate);
                CLEAR(ILCNo);
                CLEAR(ILCDate);
                CLEAR(Bank);
                LCDetailforExport.RESET;
                LCDetailforExport.SETCURRENTKEY("LC No.");
                LCDetailforExport.SETRANGE("Customer Code", "Sales Invoice Header"."Sell-to Customer No.");
                // 16630  LCDetailforExport.SETRANGE("LC No.", "Sales Invoice Header"."LC No.");
                IF LCDetailforExport.FINDFIRST THEN BEGIN
                    EximCode := LCDetailforExport."Customer Exim Code";
                    IssueDate := LCDetailforExport."Issueing Date";
                    ILCNo := LCDetailforExport."LC No.";
                    ILCDate := LCDetailforExport."LC Date";
                    Bank := LCDetailforExport."LC Issuing Bank";
                END;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        RecCompany.GET();
        RecCompany.CALCFIELDS(Picture);
    end;

    var
        RecCompany: Record "Company Information";
        TotalAmtToCust: Decimal;
        RecCustomer: Record Customer;
        RecLocation: Record Location;
        recSIL: Record "Sales Invoice Line";
        VarHSN: Text;
        TotHSN: Text;
        HSNTotString: Integer;
        FinalHSN: Text;
        RecItemCategory: Record "Item Category";
        VarDesc: Text;
        TotDesc: Text;
        TotHSNVar: Integer;
        TotStringDesc: Integer;
        FinalTotDesc: Text;
        Bank: Text;
        IssueDate: Date;
        EximCode: Text;
        ILCNo: Text;
        ILCDate: Date;
        LCDetailforExport: Record "LC Detail for Export";
        CountryRegion1: Record "Country/Region";
        Customer1: Record Customer;
        CustCountry: Text[100];
        RecDGLE: Record "Detailed GST Ledger Entry";

    procedure GetAmttoCustomerPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdSalesInv: Record 113;
        PstdSalesCrMemoLine: Record 115;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                IGSTAmt += abs(DetGstLedEntry."GST Amount");
            Until DetGstLedEntry.Next() = 0;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                SGSTAmt += abs(DetGstLedEntry."GST Amount");
            Until DetGstLedEntry.Next() = 0;

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                CGSTAmt += abs(DetGstLedEntry."GST Amount");
            Until DetGstLedEntry.Next() = 0;

        Clear(TotalAmt);
        TotalAmt += (IGSTAmt + SGSTAmt + CGSTAmt);
        EXIT(ABS(TotalAmt));
    end;
}

