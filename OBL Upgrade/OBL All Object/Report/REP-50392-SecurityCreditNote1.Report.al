report 50392 "Security Credit Note1"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SecurityCreditNote1.rdl';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date")
                                WHERE("Document Type" = CONST("Credit Memo"),
                                      "Source Type" = CONST(Customer),
                                      "System-Created Entry" = FILTER(false));
            RequestFilterFields = "Document No.", "Posting Date", "G/L Account No.", "Bal. Account No.", "Bal. Account Type";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(DocumentDate; FORMAT("G/L Entry"."Document Date"))
            {
            }
            column(CustName; Cust.Name)
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
            column(Amount_GLEntry; ABS("G/L Entry".Amount))
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(text1; Text1[1])
            {
            }
            column(text2; Text1[2])
            {
            }
            column(Amt; ABS(Amt))
            {
            }
            column(CustSecurityAmount; Cust."Security Amount")
            {
            }
            column(CustSecurityDate; FORMAT(Cust."Security Date"))
            {
            }
            column(GrossAmt; ABS("G/L Entry".Amount) + ABS(Amt))
            {
            }

            trigger OnAfterGetRecord()
            begin

                TSDEntry.SETRANGE(TSDEntry."Account Type", TSDEntry."Account Type"::"G/L Account");
                TSDEntry.SETRANGE(TSDEntry."Account No.", "G/L Entry"."G/L Account No.");
                TSDEntry.SETRANGE(TSDEntry."Document Type", TSDEntry."Document Type"::"Credit Memo");
                TSDEntry.SETRANGE(TSDEntry."Document No.", "G/L Entry"."Document No.");
                IF TSDEntry.FIND('-') THEN
                    Amt := TSDEntry."TDS Amount";
                IF Cust.GET("G/L Entry"."Source No.") THEN;

                Chk.InitTextVariable;
                Chk.FormatNoText(Text1, ABS(Amount), '')
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
        //                    RepAuditMgt.CreateAudit(50392)
    end;

    trigger OnPreReport()
    begin

        CompanyInfo.GET;
        /* IF TDSGroup.FIND('-') THEN //16225 table n/f
           "G/L Entry".SETRANGE("G/L Entry"."G/L Account No.",TDSGroup."TDS Account");*/
    end;

    var
        //16225  TDSGroup: Record "13731";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Chk: Report "Check Report";
        TSDEntry: Record "TDS Entry";
        Amt: Decimal;
        Text1: array[2] of Text[80];
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

