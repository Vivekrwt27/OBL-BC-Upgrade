report 50134 "Custmer Balances Confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CustmerBalancesConfirmation.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = WHERE("Stop Mail Comunication PCH SP" = FILTER(false));
            column(CustName; Customer.Name)
            {
            }
            column(CustNo; Customer."No.")
            {
            }
            column(decOutstndAmt; decCustOutstndAmt)
            {
            }
            column(CustAdd; Customer.Address)
            {
            }
            column(CustContct; Customer.Contact)
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(CustPh; Customer."Phone No.")
            {
            }
            column(CustPostCd; Customer."Pin Code")
            {

            }
            column(CustStateCd; Customer."State Code")
            {
            }
            column(CustStateDesc; Customer."State Desc.")
            {
            }
            column(CompPAN; CompanyInformation."P.A.N. No.")
            {
            }
            column(dtason; FORMAT(dtAsOn))
            {
            }
            column(intcnt; intcnt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                decCustOutstndAmt := 0;
                rCLE.RESET;
                rCLE.SETRANGE("Customer No.", Customer."No.");
                rCLE.SETRANGE("Posting Date", 0D, dtAsOn);
                IF rCLE.FIND('-') THEN BEGIN
                    REPEAT
                        rCLE.CALCFIELDS(Amount);
                        decCustOutstndAmt += rCLE.Amount;
                    UNTIL rCLE.NEXT = 0;
                END;
                IF GlbSerialInt <> 0 THEN
                    intCOunt := GlbSerialInt
                ELSE
                    intCOunt := intCOunt + 1;
                IF STRLEN(FORMAT(intCOunt)) = 1 THEN BEGIN
                    intcnt := '000' + FORMAT(intCOunt);
                END ELSE
                    IF STRLEN(FORMAT(intCOunt)) = 2 THEN BEGIN
                        intcnt := '00' + FORMAT(intCOunt);
                    END ELSE
                        IF STRLEN(FORMAT(intCOunt)) = 3 THEN BEGIN
                            intcnt := '0' + FORMAT(intCOunt);
                        END ELSE
                            IF STRLEN(FORMAT(intCOunt)) = 4 THEN BEGIN
                                intcnt := FORMAT(intCOunt);
                            END;


                // Customer.CALCFIELDS(Balance);
                // decCustOutstndAmt:=Customer.Balance;

                // txtFileName:=TEMPORARYPATH+'Balance_Confirmation.docx';
                // rCustomer.RESET;
                // rCustomer.SETRANGE("No.",Customer."No.");
                // rCustomer.FIND('-');
                // IF i=0 THEN BEGIN
                //  i+=1;
                //  REPORT.SAVEASWORD(50134,txtFileName,rCustomer);
                // END;

                // SMTPMail.AddAttachment();
                // SMTPMail.Send;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                intCOunt := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("As On Date"; dtAsOn)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; decOutstndAmt)
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

    trigger OnInitReport()
    begin
        /* IF (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
            ERROR('You are not allowed'); */
    end;

    var
        dtAsOn: Date;
        decCustOutstndAmt: Decimal;
        // 16630 SMTPMail: Codeunit 400;
        // 16630 recSMTPMailSetup: Record 409;
        TextCons001: Label '<nbsp>';
        TextCons002: Label '<br>';
        CompanyInformation: Record "Company Information";
        TextCons003: Label '</Table>';
        TextCons004: Label '</HTML>';
        TextCons005: Label '<TR>';
        TextCons006: Label '<table border="1" width="25%" align="right">';
        TextCons007: Label '</TR>';
        txtFileName: Text;
        decOutstndAmt: Decimal;
        rCustomer: Record Customer;
        i: Integer;
        rCLE: Record "Cust. Ledger Entry";
        intcnt: Text;
        intCOunt: Integer;
        GlbSerialInt: Integer;

    procedure SetDate(var AsOnDate: Date; var GlbInt: Integer)
    begin
        dtAsOn := AsOnDate;
        GlbSerialInt := GlbInt;
    end;

    procedure SetSerialNumber(var GlbInt: Integer)
    begin
        GlbSerialInt := GlbInt;
    end;
}

