report 50294 "sales Debit Note (Bulk)"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\salesDebitNoteBulk.rdl';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date")
                                WHERE("Document Type" = CONST(Invoice),
                                      "Source Type" = CONST(Customer),
                                      "System-Created Entry" = FILTER(false));
            RequestFilterFields = "Document No.", "Posting Date", "G/L Account No.", "Bal. Account No.", "Bal. Account Type";
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompName2; CompanyInfo."Name 2")
            {
            }
            column(CompAddress; CompanyInfo.Address)
            {
            }
            column(CompPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompFax; FORMAT(CompanyInfo."Fax No."))
            {
            }
            column(DocumentDate_GLEntry; FORMAT("G/L Entry"."Document Date"))
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(ExternalDocumentNo_GLEntry; "G/L Entry"."External Document No.")
            {
            }
            column(CustNo; Cust."No.")
            {
            }
            column(CustName; Cust.Name)
            {
            }
            column(gstn; Cust."GST Registration No.")
            {
            }
            column(CustAddress; Cust.Address)
            {
            }
            column(CustCity; Cust.City)
            {
            }
            column(CustStateDesc; Cust."State Desc.")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(Amount_GLEntry; ABS("G/L Entry".Amount))
            {
            }
            column(Today; FORMAT(TODAY, 0, 4))
            {
            }
            column(text1; Text1[1])
            {
            }
            column(saleter; Cust."Area Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                TSDEntry.SETRANGE(TSDEntry."Account Type", TSDEntry."Account Type"::"G/L Account");
                TSDEntry.SETRANGE(TSDEntry."Account No.", "G/L Account No.");
                TSDEntry.SETRANGE(TSDEntry."Document Type", TSDEntry."Document Type"::Invoice);
                TSDEntry.SETRANGE(TSDEntry."Document No.", "Document No.");
                IF TSDEntry.FIND('-') THEN
                    Amt := TSDEntry."TDS Amount";


                IF Cust.GET("Source No.") THEN;



                Chk.InitTextVariable;
                Chk.FormatNoText(Text1, ABS(Amount), '');


                //Section(+)
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoText, ROUND(("G/L Entry".Amount), 1, '>'), '');
                //Section(-)
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

    trigger OnPostReport()
    begin
        //                   RepAuditMgt.CreateAudit(50294)
    end;

    trigger OnPreReport()
    begin

        CompanyInfo.GET;
        /*IF TDSGroup.FIND('-') THEN //16225 Table N/F
            "G/L Entry".SETRANGE("G/L Entry"."G/L Account No.", TDSGroup."TDS Account");*/
    end;

    var
        //  TDSGroup: Record 13731; //16225 
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Chk: Report "Check Report";
        TSDEntry: Record "TDS Entry";
        Amt: Decimal;
        Text1: array[2] of Text[80];
        CheckReport: Report "Check Report";
        NoText: array[2] of Text[80];
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

