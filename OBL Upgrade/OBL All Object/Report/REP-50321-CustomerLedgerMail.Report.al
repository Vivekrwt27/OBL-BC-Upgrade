report 50321 "Customer Ledger Mail"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("No." = FILTER(<> ''),
                                      "Customer Type" = FILTER('<>LEGAL' & '<>MISC.' & '<>EXIM' & '<>COCO'),
                                      Balance = FILTER(> 0));

            trigger OnAfterGetRecord()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                CustomerLedgerCCTeam: Report "Customer Ledger CCTeam";
                emaiMsg: Codeunit "Email Message";

            begin
                Clear(EmailAddressList);
                Clear(EmailCCList);
                Clear(EmailBccList);

                IF Customer."Customer Status" = Customer."Customer Status"::Closed THEN CurrReport.SKIP;
                //GeneratePDFs(Customer);
                //>>>>>>-------Generate
                CustLedgEntry.RESET;
                CustLedgEntry.SETFILTER("Customer No.", Customer."No.");
                //  CustLedgEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    CLEAR(CustomerLedgerCCTeam);
                    CustomerLedgerCCTeam.SETTABLEVIEW(CustLedgEntry);
                    TextFile := 'C:\MailPDF\' + CustLedgEntry."Customer No." + '.pdf';
                    // CustomerLedgerCCTeam.SAVEASPDF(TextFile);
                    //<<<<<<<-------Generate

                    //>>>>>>------Send
                    SalespersonPurchaser.RESET;
                    IF SalespersonPurchaser.GET(GetSalespersonPurchaserCode()) THEN;
                    IF SalespersonPurchaser."E-Mail" <> '' THEN BEGIN

                        //   SMTPMailSetup.GET;
                        //   CLEAR(SMTPMail);
                        //SMTPMail.CreateMessage('Orient Bell Tiles','kulbhushan.sharma@orientbell.com','kulbhushan.sharma@orientbell.com','Customer Ledger for '+Customer.Name+', '+Customer.City,'',TRUE);
                        emaiMsg.Create('Orient Bell Tiles' + ',' + 'creditcontrol@orientbell.com' + ',' + SalespersonPurchaser."E-Mail" + ',' + 'Customer Ledger for ' + Customer.Name + ', ' + Customer.City, '', BodyText, TRUE);//RB
                        //SMTPMail.AddCC('kulbhushan.sharma@orientbell.com');
                        //SMTPMail.AddCC('ithelpdesk@orientbell.com');
                        EmailAddressList.Add('creditcontrol@orientbell.com');
                        SalespersonPurchaser.RESET;
                        IF SalespersonPurchaser.GET(Customer."CC Team") THEN
                            IF SalespersonPurchaser."E-Mail" <> '' THEN
                                EmailCCList.add(SalespersonPurchaser."E-Mail");

                        /*IF CCPCH THEN BEGIN
                          IF SalespersonPurchaser.GET(Customer."PCH Code") THEN
                          IF SalespersonPurchaser."E-Mail"<>'' THEN
                          SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
                         // SMTPMail.AddCC('kulbhushan.sharma@orientbell.com');
                        END;

                        IF CCZH THEN BEGIN
                          IF SalespersonPurchaser.GET(Customer."Zonal Head") THEN
                          IF SalespersonPurchaser."E-Mail"<>'' THEN
                          SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
                        END;

                        IF CCZM THEN BEGIN
                          IF SalespersonPurchaser.GET(Customer."Zonal Manager") THEN
                          IF SalespersonPurchaser."E-Mail"<>'' THEN
                          SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
                        END;*/

                        //SMTPMail.AppendBody('Dear '+ SalespersonPurchaser.Name);
                        BodyText := 'Dear Sir/Madam';
                        BodyText += '<br><br>';
                        BodyText += 'Please find the enclosed customer Ledger for ' + Customer.Name + ', ' + Customer.City + ' For the period of ' + FORMAT(FromDate) + ' to ' + FORMAT(ToDate);
                        BodyText += '<br>';
                        BodyText += 'This is for your record';
                        BodyText += '<br><br>';
                        BodyText += 'Regards,';
                        BodyText += '<br>';
                        BodyText += 'Orient Bell Limited';
                        BodyText += '<br>';
                        BodyText += 'Iris House, 16 Business Center, Nangal Raya';
                        BodyText += '<br>';
                        BodyText += 'New Delhi 110046, India';
                        BodyText += '<br>';
                        BodyText += 'Fax. +91 11 2852 1273';
                        BodyText += '<br>';
                        /* if File.Exists(TextFile) then begin
                            FileMgmt.BLOBExportToServerFile(TempBlobCU, TextFile);
                            if TempBlobCU.HasValue() then begin
                                TempBlobCU.CreateInStream(InstreamVar);
                                EmailMsg.Create(EmailAddressList, 'Customer Ledger for ' + Customer.Name + ', ' + Customer.City, BodyText, true, EmailBccList, EmailCCList);
                                if File.Exists(TextFile) THEN
                                    EmailMsg.AddAttachment(TextFile, 'application/pdf', InstreamVar);
                                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                            END;
                        end; */
                        /* SMTPMail.AddAttachment(TextFile, Customer."No." + '.pdf');

                         IF SMTPMail.TrySend THEN BEGIN
                             //  MESSAGE('SENT');
                         END;*/ // 16225
                    END;
                END;
                //<<<<<<------
                /*
                IF CCPCH THEN BEGIN
                  IF SalespersonPurchaser.GET(Customer."PCH Code") THEN
                  IF SalespersonPurchaser."E-Mail"<>'' THEN
                  SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
                  SMTPMail.AddCC('rajiv.saini@mindshell.info');
                END;
                
                IF CCZH THEN BEGIN
                  IF SalespersonPurchaser.GET(Customer."Zonal Head") THEN
                  IF SalespersonPurchaser."E-Mail"<>'' THEN
                  SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
                END;
                
                IF CCZM THEN BEGIN
                  IF SalespersonPurchaser.GET(Customer."Zonal Manager") THEN
                  IF SalespersonPurchaser."E-Mail"<>'' THEN
                  SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CASE FFType OF
                    FFType::"Sales Person":
                        SETRANGE(Customer."Salesperson Code", FieldForceCode);
                    FFType::PCH:
                        SETRANGE(Customer."PCH Code", FieldForceCode);
                    FFType::"Zonal Manager":
                        SETRANGE(Customer."Zonal Manager", FieldForceCode);
                    FFType::ZH:
                        SETRANGE(Customer."Zonal Head", FieldForceCode);
                END;
                SETRANGE("Customer Status", Customer."Customer Status"::Active);
                SETRANGE(Customer.Blocked, 0);
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
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; ToDate)
                {
                    ApplicationArea = All;
                }
                field("Field Force"; FFType)
                {
                    ApplicationArea = All;
                }
                field("Sales Force Code"; FieldForceCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field("Mark CC TO PCH"; CCPCH)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Mark CC TO ZM"; CCZM)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Mark CC TO ZH"; CCZH)
                {
                    Visible = false;
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
        IF (UPPERCASE(USERID) <> 'FA015') AND (UPPERCASE(USERID) <> 'FA017') AND (UPPERCASE(USERID) <> 'FA012') AND (UPPERCASE(USERID) <> 'FA014') AND (UPPERCASE(USERID) <> 'FA032') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
            ERROR('You are not Allowed');
    end;

    trigger OnPreReport()
    begin
        /*
        CLEAR(FromDate);
        CLEAR(ToDate);
        CLEAR(FFType);
        CLEAR(FieldForceCode);
        */
        IF (FromDate = 0D) OR (ToDate = 0D) OR (FFType = FFType::" ") OR (FieldForceCode = '')
          THEN
            ERROR('Please select the Proper Filters');

        IF FFType = FFType::" " THEN
            ERROR(BlankFFType);

    end;

    var
        CompanyInformation: Record "Company Information";
        FromDate: Date;
        ToDate: Date;
        FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH;
        FieldForceCode: Code[10];
        CCPCH: Boolean;
        CCZM: Boolean;
        CCZH: Boolean;
        //  SMTPMailSetup: Record 409;
        //  SMTPMail: Codeunit 400;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TextCons001: Label '<nbsp>';
        TextCons002: Label '<br>';
        TextCons003: Label '</Table>';
        TextCons004: Label '</HTML>';
        TextCons005: Label '<TR>';
        TextCons006: Label '<table border="1" width="25%" align="right">';
        TextCons007: Label '</TR>';
        InCorrectMail: Boolean;
        TextFile: Text[250];
        EmailAddress: Text[250];
        fileName: Text[250];
        i: Integer;
        NoOfAtSigns: Integer;
        BlankFFType: Label 'FF Type must have a value!!';
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        FileMgmt: Codeunit "File Management";
        EmailBccList: list of [Text];
        TempBlobCU: Codeunit "Temp Blob";
        InstreamVar: InStream;
        OutstreamVar: OutStream;


    local procedure GeneratePDFs(RecCust: Record 18)
    var
        CLE: Record 21;
        CustomerLedgerCCTeam: Report 50284;
        TextFile: Text[250];
    begin

        CLE.RESET;
        CLE.SETFILTER("Customer No.", RecCust."No.");
        CLE.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
        IF CLE.FINDFIRST THEN BEGIN
            CLEAR(CustomerLedgerCCTeam);
            CustomerLedgerCCTeam.SETTABLEVIEW(CLE);
            TextFile := 'C:\\MailPDF\' + CLE."Customer No." + '.pdf';
            // 16630 CustomerLedgerCCTeam.SAVEASPDF(TextFile); Onprem Error
        END;
    end;

    local procedure SendEmail()
    begin
    end;

    local procedure GetSalespersonPurchaserCode(): Code[20]
    begin
        CASE FFType OF
            FFType::"Sales Person":
                EXIT(Customer."Salesperson Code");
            FFType::PCH:
                EXIT(Customer."PCH Code");
            FFType::"Zonal Manager":
                EXIT(Customer."Zonal Manager");
            FFType::ZH:
                EXIT(Customer."Zonal Head");
        END;
    end;
}

