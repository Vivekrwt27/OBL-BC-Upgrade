pageextension 50461 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
    }
    actions
    {
        addbefore("&Bank Acc.")
        {
            action("Create For Bell")
            {
                Caption = 'Create For Bell';

                trigger OnAction()
                begin
                    rec.CreateForBell(Rec, rec."No.");
                end;
            }
            action("Create For Orient")
            {
                Caption = 'Create For Orient';

                trigger OnAction()
                begin
                    rec.CreateForOrient(Rec, rec."No.");
                end;
            }
            action("Create For Both")
            {
                Caption = 'Create For Both';

                trigger OnAction()
                begin
                    rec.CreateForAll(Rec, rec."No.");
                end;
            }
            action("Generate File for Payment")
            {
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BankAccountLedgerEntry: Record 271;
                    //15578 GenerateAxisBankFile: Report 50085;
                    AxisBankIntegration: Codeunit 50063;
                    CompanyInformation: Record 79;
                    FileName: Text;
                    IDFCBankFileGeneration: Report 50067;
                begin
                    IF NOT (UPPERCASE(USERID) IN ['IN002', 'FA004', 'N', 'C', 'E']) THEN
                        //(UPPERCASE(USERID) <> 'IN002')  OR  (UPPERCASE(USERID) <> 'FA004') THEN
                        // ERROR('You are not allowed for this function');
                        /*
                        CLEAR(GenerateAxisBankFile);
                        BankAccountLedgerEntry.RESET;
                        BankAccountLedgerEntry.SETCURRENTKEY("Bank Account No.","Posting Date");
                        BankAccountLedgerEntry.SETFILTER("Bank Account No.",'%1',"No.");
                        BankAccountLedgerEntry.SETFILTER("Posting Date",'>%1',130921D);
                        BankAccountLedgerEntry.SETFILTER("Online Bank Transfer",'%1',TRUE);
                        BankAccountLedgerEntry.SETFILTER("File Name",'%1','');
                        IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
                          //GenerateAxisBankFile.SETTABLEVIEW(BankAccountLedgerEntry);
                          //GenerateAxisBankFile.RUN;
                          CLEAR(AxisBankIntegration);
                          AxisBankIntegration.CreatePaymentRequestFile(BankAccountLedgerEntry);
                        END;*/

                    rec.TESTFIELD("Integration Bank");
                    CASE rec."Integration Bank" OF
                        rec."Integration Bank"::"Axis Bank":
                            BEGIN
                                //15578 CLEAR(GenerateAxisBankFile);
                                BankAccountLedgerEntry.RESET;
                                BankAccountLedgerEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                                BankAccountLedgerEntry.SETFILTER("Bank Account No.", '%1', rec."No.");
                                BankAccountLedgerEntry.SETFILTER("Posting Date", '>%1', 20210913D);//091321D
                                BankAccountLedgerEntry.SETFILTER("Online Bank Transfer", '%1', TRUE);
                                BankAccountLedgerEntry.SETFILTER("File Name", '%1', '');
                                IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
                                    //GenerateAxisBankFile.SETTABLEVIEW(BankAccountLedgerEntry);
                                    //GenerateAxisBankFile.RUN;
                                    CLEAR(AxisBankIntegration);
                                    AxisBankIntegration.CreatePaymentRequestFile(BankAccountLedgerEntry);
                                END;
                            END;
                        rec."Integration Bank"::"IDFC Bank":
                            BEGIN
                                BankAccountLedgerEntry.RESET;
                                BankAccountLedgerEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                                BankAccountLedgerEntry.SETFILTER("Bank Account No.", '%1', rec."No.");
                                BankAccountLedgerEntry.SETFILTER("Posting Date", '>%1', 20210913D);
                                BankAccountLedgerEntry.SETFILTER("Online Bank Transfer", '%1', TRUE);
                                BankAccountLedgerEntry.SETFILTER("File Name", '%1', '');
                                IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
                                    CompanyInformation.GET;
                                    CompanyInformation.TESTFIELD("IDFC Bank In Folder");
                                    FileName := CompanyInformation."IDFC Bank In Folder" + 'ORIENTBELL_' + CONVERTSTR(FORMAT(CURRENTDATETIME, 0,
                                                                '<Year4>-<Month,2>-<Day,2> <Hours24,2>-<Minutes,2>-<Seconds,2>'), '.:\/ ', '_____') + '.xlsx';
                                    MESSAGE('%1', BankAccountLedgerEntry.COUNT);
                                    CLEAR(IDFCBankFileGeneration);
                                    IDFCBankFileGeneration.GetFileName(FileName);
                                    IDFCBankFileGeneration.SETTABLEVIEW(BankAccountLedgerEntry);
                                    // IDFCBankFileGeneration.SAVEASEXCEL(FileName);
                                END;
                            END;
                    END;

                end;
            }
            action("Process Reverse Feed")
            {
                Image = ImportFile;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AxisBankIntegration: Codeunit 50063;
                    BankAccountLedgerEntry: Record 271;
                begin
                    CLEAR(AxisBankIntegration);
                    AxisBankIntegration.RUN(Rec);
                end;
            }
        }
    }



    trigger OnModifyRecord(): Boolean
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Allow Bank account change" = FALSE THEN
                ERROR('%1 has no permission to Change the Bank Card', UserSetup."User ID");
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Allow Bank account change" = FALSE THEN
                ERROR('%1 has no permission to Change the Bank Card', UserSetup."User ID");
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Allow Bank account change" = FALSE THEN
                ERROR('%1 has no permission to Change the Bank Card', UserSetup."User ID");
        END;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Allow Bank account change" = FALSE THEN
                ERROR('%1 has no permission to Change the Bank Card', UserSetup."User ID");
        END;
    end;




    var
        UserSetup: Record 91;
}