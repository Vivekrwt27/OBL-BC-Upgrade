report 50088 "TDS Payable Detail.1"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TDSPayableDetail1.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                WHERE(Reversed = CONST(false),
                                 "TDS Amount" = FILTER(<> 0)); //16767
            RequestFilterFields = "Posting Date", "Assessee Code", section, "Location Code";
            column(format; FORMAT(TODAY, 0, 4))
            {
            }
            column(pageno; CurrReport.PAGENO)
            {
            }
            column(Name; "Company Information".Name)
            {
            }
            column(NAme2; "Company Information"."Name 2")
            {
            }
            column(Filters; 'Filters : ' + "TDS Entry".GETFILTERS)
            {
            }
            column(DocumentNo1; "Document No.")
            {
            }
            column(Postdate1; FORMAT("Posting Date"))
            {
            }
            column(Perticulars1; Perticulars)
            {
            }
            column(adjustedamnt; "Adjusted TDS Doc No.")
            {
            }
            column(PostedPayDocumentNmbr; "Posted Pay TDS Document No.")
            {
            }
            column(TDSAmount; "TDS Amount")
            {
            }
            column(TDS; "TDS %")
            {
            }
            column(TDSbase; "TDS Base Amount")
            {
            }
            column(TotalTDS; "Total TDS Including SHE CESS")
            {
            }
            column(Pan; Pan)
            {
            }
            column(TDSSection; '') // 16630 replace here TDS Section
            {
            }

            trigger OnAfterGetRecord()
            begin


                Perticulars := '';
                Pan := '';
                IF "Party Type" = "Party Type"::Vendor THEN
                    IF Vendor.GET("Party Code") THEN BEGIN
                        Perticulars := Vendor.Name;
                        Pan := Vendor."P.A.N. No.";
                    END;

                IF "Party Type" = "Party Type"::Customer THEN
                    IF Customer.GET("Party Code") THEN BEGIN
                        Perticulars := Customer.Name;
                        Pan := Customer."P.A.N. No.";
                    END;

                IF "Party Type" = "Party Type"::Party THEN
                    IF TDSParty.GET("Party Code") THEN BEGIN
                        Perticulars := TDSParty.Name;
                        Pan := TDSParty."P.A.N. No.";
                    END;
            end;
        }
        dataitem(TDSEntry1; "TDS Entry")
        {
            DataItemTableView = SORTING("Pay TDS Document No.", "Posting Date", "Document No.")
                                ORDER(Ascending)
                                WHERE(Reversed = CONST(false));
            column(Pay1; 'TDS Pay ')
            {
            }
            column(PayTDSAmount; PayTDSAmount)
            {
            }
            column(PayTDSBaseAmount1; PayTDSBaseAmount)
            {
            }
            column(PayTDSIncludingeCESS1; PayTDSIncludingeCESS)
            {
            }
            column(POSTINGENTRY; "TDS Entry"."Posting Date")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF Adjusted = TRUE THEN BEGIN
                    PayTDSAmount := -("TDS Base Amount" * "Adjusted TDS %") / 100;
                    PayTDSIncludingeCESS := -"Total TDS Including SHE CESS";
                END ELSE BEGIN
                    PayTDSAmount := -"TDS Amount";
                    PayTDSBaseAmount := -"TDS Base Amount";
                    PayeCESSAmount := -"eCESS Amount";
                    PayTDSIncludingeCESS := -"Total TDS Including SHE CESS";

                    "PayTDS%" := -TDSEntry1."TDS %";
                END;
            end;

            trigger OnPreDataItem()
            begin

                COPYFILTERS("TDS Entry");
                SETFILTER("TDS Paid", '%1', TRUE);
                CurrReport.CREATETOTALS(PayTDSAmount, PayTDSBaseAmount, PayeCESSAmount, PayTDSIncludingeCESS);
            end;
        }
        dataitem(Integer; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = CONST(1));
            column(tdsentry; PayTDSAmount + "TDS Entry"."TDS Amount")
            {
            }
            column(tdbase; "TDS Entry"."TDS Base Amount" + PayTDSBaseAmount)
            {
            }
            column(tdinclu; "TDS Entry"."Total TDS Including SHE CESS" + PayTDSIncludingeCESS)
            {
            }
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

    var
        "Company Information": Record "Company Information";
        Perticulars: Text[60];
        Pan: Text[30];
        Vendor: Record Vendor;
        Customer: Record Customer;
        TDSParty: Record Party;
        Excelbuff: Record "Excel Buffer" temporary;
        PrinttoExcel: Boolean;
        PayTDSAmount: Decimal;
        PayTDSBaseAmount: Decimal;
        PayeCESSAmount: Decimal;
        PayTDSIncludingeCESS: Decimal;
        "PayTDS%": Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

