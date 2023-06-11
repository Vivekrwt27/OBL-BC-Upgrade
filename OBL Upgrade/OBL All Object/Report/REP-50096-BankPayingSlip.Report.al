report 50096 "Bank Paying Slip"
{
    //  TRI A.S 29.08.07 PartyName Text Length changed to 200 from 100.
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\BankPayingSlip.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Bank Account Ledger Entry"; 271)
        {
            DataItemTableView = SORTING("Document No.", "Posting Date")
                                ORDER(Ascending)
                                WHERE(Amount = FILTER(> 0),
                                      "Document Type" = FILTER('Payment'));
            RequestFilterFields = "Bank Account No.", "Posting Date"; // 16630 "Location Code";
            column(CompName1; CompanyInformation.Name)
            {
            }
            column(CompName2; CompanyInformation."Name 2")
            {
            }
            column(LocationAddress1; LocationAddress[1])
            {
            }
            column(LocationAddress2; LocationAddress[2])
            {
            }
            column(LocationAddress3; LocationAddress[3])
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(Sno; Sno)
            {
            }
            column(ChequeNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Cheque No.")
            {
            }
            column(ChequeDate_BankAccountLedgerEntry; FORMAT("Bank Account Ledger Entry"."Cheque Date"))
            {
            }
            column(IssuingBank_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Issuing Bank")
            {
            }
            column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
            {
            }
            column(PartyName; PartyName)
            {
            }
            column(CityName; CityName)
            {
            }
            column(AmtinText1; AmtinText[1])
            {
            }
            column(AmtinText2; AmtinText[2])
            {
            }
            column(Amt; Amt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sno += 1;
                PartyName := '';
                CityName := '';
                CASE "Bal. Account Type" OF

                    "Bal. Account Type"::Customer:
                        BEGIN
                            GLEntry.RESET;
                            GLEntry.SETRANGE(GLEntry."Document Type", "Document Type");
                            GLEntry.SETFILTER(GLEntry."Document No.", '%1', "Document No.");
                            GLEntry.SETRANGE(GLEntry."Source Type", GLEntry."Source Type"::Customer);
                            IF GLEntry.FIND('-') THEN BEGIN
                                IF Customer.GET(GLEntry."Source No.") THEN BEGIN
                                    PartyName := Customer.Name;
                                    CityName := Customer.City;
                                END;
                            END;
                        END;

                    "Bal. Account Type"::Vendor:
                        BEGIN
                            GLEntry.RESET;
                            GLEntry.SETRANGE(GLEntry."Document Type", "Document Type");
                            GLEntry.SETFILTER(GLEntry."Document No.", '%1', "Document No.");
                            GLEntry.SETRANGE(GLEntry."Source Type", GLEntry."Source Type"::Vendor);
                            IF GLEntry.FIND('-') THEN BEGIN
                                IF Vendor.GET(GLEntry."Source No.") THEN BEGIN
                                    PartyName := Vendor.Name;
                                    CityName := Customer.City;
                                END;
                            END;
                        END;
                /*

                "Bal. Account Type"::"G/L Account" :
              //    PartyName := Description2;
              //TRISC
                "Bal. Account Type"::"Bank Account" :
                    //PartyName := Description2;
                    //TRISC

                "Bal. Account Type"::"Fixed Asset" :
                    //PartyName := Description2;
                    */
                END;

                /*
                Check.InitTextVariable;
                Check.FormatNoText(AmtinText,Amount,'');
                 */
                BankAccountLedgerEntry1.COPYFILTERS("Bank Account Ledger Entry");
                BankAccountLedgerEntry1.CALCSUMS(Amount);
                Amt := BankAccountLedgerEntry1.Amount;
                Check.InitTextVariable;
                Check.FormatNoText(AmtinText, Amt, '');

            end;

            trigger OnPreDataItem()
            begin
                //
                CompanyInformation.GET;
                GeneralLedgerSetup.GET;
                BankAccountLedgerEntry.COPYFILTERS("Bank Account Ledger Entry");
                BankAccountLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date");
                BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry.Amount, '>%1', 0);
                BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry."Document Type", '%1', BankAccountLedgerEntry."Document Type"::Payment);
                IF BankAccountLedgerEntry.FIND('-') THEN BEGIN
                    LedgerEntryDimension.SETRANGE("Dimension Set ID", BankAccountLedgerEntry."Dimension Set ID");
                    LedgerEntryDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Location Dimension Code");
                    IF LedgerEntryDimension.FIND('-') THEN BEGIN
                        IF Location.GET(LedgerEntryDimension."Dimension Value Code") THEN BEGIN
                            State.GET(Location."State Code");
                            LocationAddress[1] := Location.Address;
                            LocationAddress[2] := Location."Address 2";
                            LocationAddress[3] := Location.City + '(' + State.Description + ')';
                        END;
                    END;  //TMC::6823
                END;
                COMPRESSARRAY(LocationAddress);


                //


                IF BankAccount.GET(GETFILTER("Bank Account No.")) THEN BEGIN
                    BankName := BankAccount.Name;
                    BranchName := BankAccount.Address + ' ' + BankAccount."Address 2" + ' ' + BankAccount.City;
                    BankAccountNo := BankAccount."Bank Account No.";
                END;
                PostingDate := GETFILTER("Posting Date");
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
        //RepAuditMgt.CreateAudit(50096)
    end;

    trigger OnPreReport()
    begin
        /*  CompanyInformation.GET;
        GeneralLedgerSetup.GET;
        BankAccountLedgerEntry.COPYFILTERS("Bank Account Ledger Entry");
        BankAccountLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
        BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry.Amount, '>%1', 0);
        BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry."Document Type", '%1', BankAccountLedgerEntry."Document Type"::Payment);
        IF BankAccountLedgerEntry.FIND('-') THEN BEGIN
          LedgerEntryDimension.SETRANGE("Dimension Set ID",BankAccountLedgerEntry."Dimension Set ID");
          LedgerEntryDimension.SETRANGE("Dimension Code",GeneralLedgerSetup."Location Dimension Code");
          IF LedgerEntryDimension.FIND('-') THEN BEGIN
            IF Location.GET(LedgerEntryDimension."Dimension Value Code") THEN BEGIN
              State.GET(Location."State Code");
              LocationAddress[1] := Location.Address ;
              LocationAddress[2] := Location."Address 2";
              LocationAddress[3] := Location.City + '(' + State.Description + ')';
            END;
          END;  //TMC::6823
        END;
        COMPRESSARRAY(LocationAddress);
         */

    end;

    var
        CompanyInformation: Record "Company Information";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Vendor: Record Vendor;
        BankAcc: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location: Record Location;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        State: Record State;
        Check: Report "Check Report";
        Sno: Integer;
        AmtinText: array[2] of Text[80];
        BankName: Text[100];
        BranchName: Text[100];
        PartyName: Text[200];
        CityName: Text[100];
        PostingDate: Text[250];
        LocationAddress: array[4] of Text[250];
        BankAccountNo: Code[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        BankAccountLedgerEntry1: Record "Bank Account Ledger Entry";
        Amt: Decimal;
        LedgerEntryDimension: Record "Dimension Set Entry";
}

