report 50276 "Dunning Letter"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DunningLetter.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Balance (LCY)";
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CustNo; Customer."No.")
            {
            }
            column(Caption1; 'Ref-OBL/HO/ACS/............ ')
            {
            }
            column(Caption2; 'To,')
            {
            }
            column(CustomerName; FORMAT('M/s ') + Customer.Name)
            {
            }
            column(CustAdd; Customer.Address)
            {
            }
            column(CustAdd2; Customer."Address 2")
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(StateName; StateName)
            {
            }
            column(CustPin; 'Pin No. ' + Customer."Pin Code")
            {
            }
            column(CustPhoneNp; 'Contact No. ' + FORMAT(Customer."Phone No."))
            {
            }
            column(CustBalLcy; FORMAT(Customer."Balance (LCY)"))
            {
            }
            column(Amt; FORMAT(Amt))
            {
            }
            column(CustPCHName; FORMAT(Customer."PCH Name"))
            {
            }
            column(CustStateDes; FORMAT(Customer."State Desc."))
            {
            }
            column(Mobile; FORMAT(mobile))
            {
            }
            column(CompanyName; FORMAT('For ') + RecCompany.Name)
            {
            }
            column(DateWorkDate; 'Date ' + FORMAT(WORKDATE))
            {
            }
            column(brand; brand)
            {
            }
            column(head; head)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Remaining Amount";
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Document No.")
                                    ORDER(Ascending);
                column(DocNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(PostingDate; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DueDate; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(RemAmt; ROUND("Cust. Ledger Entry"."Remaining Amount", 1))
                {
                }
                column(CustLedRemAmt; FORMAT("Cust. Ledger Entry"."Remaining Amount"))
                {
                }
                column(CNO; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(OriginalAmt; "Cust. Ledger Entry"."Amount (LCY)")
                {
                }
                column(LateDays; TODAY - "Cust. Ledger Entry"."Due Date")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CALCFIELDS("Remaining Amount");
                    IF "Due Date" <= AsonDate THEN
                        DueAmount := "Cust. Ledger Entry"."Remaining Amount";
                end;

                trigger OnPreDataItem()
                begin

                    SETRANGE("Due Date", 0D, Date);
                    //Sash end


                    //SETRANGE("Document Type",RecCusLedgerEntry."Document Type"::Invoice);
                    SETRANGE("Document Type", "Document Type"::Invoice);
                    CALCFIELDS("Remaining Amount");
                    SETFILTER("Remaining Amount", '<>%1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin


                Display := FALSE;
                Amt := 0;
                Date := CALCDATE(Perid, AsonDate);
                RecState.RESET;
                RecState.SETRANGE(RecState.Code, Customer."State Code");
                IF RecState.FINDFIRST THEN
                    StateName := RecState.Description
                ELSE
                    StateName := '';

                IF SalesPur1.GET("PCH Code") THEN
                    mobile := SalesPur1."Phone No.";

                IF Customer.Zone = 'NORTH' THEN
                    head := 'Shekhar Sati - Sales Head (North & Central)';
                IF Customer.Zone = 'NORTH1' THEN
                    head := 'Shekhar Sati - Sales Head (North & Central)';
                IF Customer.Zone = 'NORTH2' THEN
                    head := 'Shekhar Sati - Sales Head (North & Central)';
                IF Customer.Zone = 'CENTRAL' THEN
                    head := 'Shekhar Sati - Sales Head (North & Central)';
                IF Customer.Zone = 'SOUTH' THEN
                    head := 'Sasindran Nair - Sales Head (South)';


                //Customer.SETRANGE("Date Filter",0D,AsonDate);
                //Customer.CALCFIELDS("Outstanding Amount");
                RecCusLedgerEntry.RESET;
                RecCusLedgerEntry.SETCURRENTKEY(RecCusLedgerEntry."Customer No.");
                RecCusLedgerEntry.SETRANGE(RecCusLedgerEntry."Customer No.", "No.");
                //Sash
                //RecCusLedgerEntry.SETRANGE("Posting Date",0D,Date);
                RecCusLedgerEntry.SETRANGE(RecCusLedgerEntry."Due Date", 0D, Date);
                //sash end
                RecCusLedgerEntry.SETRANGE(RecCusLedgerEntry."Document Type", RecCusLedgerEntry."Document Type"::Invoice);
                IF RecCusLedgerEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        RecCusLedgerEntry.CALCFIELDS(RecCusLedgerEntry."Remaining Amount");
                        Amt += RecCusLedgerEntry."Remaining Amount";
                    UNTIL RecCusLedgerEntry.NEXT = 0;
                END;

                IF Amt > Dueamt THEN
                    Display := TRUE
                ELSE
                    Display := FALSE;
            end;

            trigger OnPreDataItem()
            begin

                Display := FALSE;
                DueAmount := 0;
                CALCFIELDS(Balance);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Current Date"; AsonDate)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; DueAmount)
                {
                    ApplicationArea = All;
                }
                field(Period; Perid)
                {
                    ApplicationArea = All;
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
        //RepAuditMgt.CreateAudit(50276)
    end;

    trigger OnPreReport()
    begin

        RecCompany.GET();
        IF COMPANYNAME = 'Orient Bell Limited' THEN
            brand := 'Orient Bell Limited';
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Dueamt: Decimal;
        RecCusLedgerEntry: Record "Cust. Ledger Entry";
        Amt: Decimal;
        Groupamt: Decimal;
        Total: Decimal;
        AsonDate: Date;
        Display: Boolean;
        DueDays: Integer;
        RecCompany: Record "Company Information";
        Date: Date;
        Perid: DateFormula;
        StateName: Text[30];
        RecState: Record State;
        brand: Text[30];
        SalesPur1: Record "Salesperson/Purchaser";
        mobile: Text[30];
        head: Text[50];
        DueAmount: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";

    procedure SetAsonDate(LocalAsonDate: Date)
    begin
        AsonDate := LocalAsonDate;
    end;
}

