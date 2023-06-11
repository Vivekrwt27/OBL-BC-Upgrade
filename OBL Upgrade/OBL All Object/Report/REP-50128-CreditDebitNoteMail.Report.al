report 50128 "Credit Debit Note Mail"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry"; 17)
        {
            RequestFilterFields = "Document No.", "Posting Date", "G/L Account No.", "Source No.";

            trigger OnAfterGetRecord()
            begin
                IF SendCN2 = TRUE THEN
                    GenerateTDSCreditNote;

                IF SendCN = TRUE THEN
                    GenerateSecurityCreditNote;

                IF SendDN = TRUE THEN
                    GeneratedDebitNote;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Select Option")
                {
                    field("Want to send Credit Note?"; SendCN)
                    {
                        ApplicationArea = All;
                    }
                    field("Want to send Debit Note?"; SendDN)
                    {
                        ApplicationArea = All;
                    }
                    field("Want to send TDS Credit Note?"; SendCN2)
                    {
                        ApplicationArea = All;
                    }
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

        IF (USERID <> UPPERCASE('FA015')) AND (USERID <> UPPERCASE('ADMIN')) THEN
            ERROR('You are NOT Allowed TO Execute this REPORT');
    end;

    var
        Fltr: Text[30];
        GLEntry: Record "G/L Entry";
        // R50084: Report 50084;
        txtfile: Text[50];
        FltrDate: Text[30];
        FltrDate1: Date;
        //  SMTPMailSetup: Record 409;
        // SMTPMail: Codeunit 400;
        RecCustomer: Record Customer;
        SendCN: Boolean;
        SendDN: Boolean;
        R50294: Report "sales Debit Note (Bulk)";
        SendCN2: Boolean;
        DocNo: Code[20];
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        R50207: Report "Credit Memo";
        Filepath: Text[200];
        DocNo1: Code[20];
        GLEntry2: Record "G/L Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DocNo2: Code[20];

    procedure GenerateSecurityCreditNote()
    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::"Credit Memo");
        GLEntry.SETRANGE("Entry No.", "G/L Entry"."Entry No.");
        IF GLEntry.FINDFIRST THEN BEGIN
            IF DocNo1 <> GLEntry."Document No." THEN BEGIN
                DocNo1 := GLEntry."Document No.";
                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", GLEntry."Document No.");
                IF GLEntry2.FINDFIRST THEN BEGIN
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETCURRENTKEY("No.");
                    SalesCrMemoHeader.SETRANGE("No.", GLEntry2."Document No.");
                    IF NOT SalesCrMemoHeader.FINDFIRST THEN BEGIN
                        //MESSAGE('%1', GLEntry2."Document No.");
                        //   CLEAR(R50084);
                        //   R50084.SETTABLEVIEW(GLEntry);
                        txtfile := 'C:\CNDNMail\CreditNote\' + FORMAT(GLEntry2."Entry No.") + '.pdf';
                        //   R50084.SAVEASPDF(txtfile);

                        RecCustomer.RESET;
                        IF RecCustomer.GET(GLEntry."Source No.") THEN;
                        IF RecCustomer."E-Mail" <> '' THEN BEGIN
                            /*   SMTPMailSetup.GET;
                               SMTPMailSetup.TESTFIELD("Sender Email");
                               CLEAR(SMTPMail);
                               SMTPMail.CreateMessage('Orient Bell Tiles', SMTPMailSetup."Sender Email", RecCustomer."E-Mail", 'Security Credit Notes', '', TRUE);
                               //SMTPMail.CreateMessage('OrientBell Tiles',SMTPMailSetup."User ID",RecCustomer."PCH E-Maill ID",'Credit Notes','',TRUE);
                               //SMTPMail.CreateMessage('OrientBell Tiles',SMTPMailSetup."User ID",'kulbhushan.sharma@orientbell.com','Credit Notes','',TRUE);
                               SMTPMail.AddCC(RecCustomer."PCH E-Maill ID");
                               RecCustomer.CALCFIELDS("SP E-Maill ID");
                               SMTPMail.AddCC(RecCustomer."SP E-Maill ID");
                               SMTPMail.AddCC('saurabh.saxena@orientbell.com');
                               //SMTPMail.AddCC('kulbhushan.sharma@orientbell.com');
                               SMTPMail.AppendBody('Dear ' + RecCustomer.Name);
                               SMTPMail.AppendBody('<br><br>');
                               SMTPMail.AppendBody('Please find the enclosed computer generated credit note');
                               SMTPMail.AppendBody('<br>');
                               SMTPMail.AppendBody('This is for your record');
                               SMTPMail.AppendBody('<br><br>');
                               SMTPMail.AppendBody('Regards,');
                               SMTPMail.AppendBody('<br>');
                               SMTPMail.AppendBody('Orient Bell Limited');
                               SMTPMail.AppendBody('<br>');
                               SMTPMail.AppendBody('Iris House, 16 Business Center, Nangal Raya');
                               SMTPMail.AppendBody('<br>');
                               SMTPMail.AppendBody('New Delhi 110046, India');
                               SMTPMail.AppendBody('<br>');
                               SMTPMail.AppendBody('Fax. +91 11 2852 1273');
                               SMTPMail.AppendBody('<br>');

                               IF EXISTS(txtfile) THEN BEGIN
                                   SMTPMail.AddAttachment(txtfile, txtfile);
                                   //MESSAGE('SENT');
                                   SMTPMail.Send;
                               END;*/
                        END;
                    END;
                END;
            END;
        END;
    end;

    procedure GenerateTDSCreditNote()
    begin
        IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::"Credit Memo" THEN BEGIN
            IF DocNo <> "G/L Entry"."Document No." THEN BEGIN
                DocNo := "G/L Entry"."Document No.";
                SalesCrMemoHeader.RESET;
                SalesCrMemoHeader.SETCURRENTKEY("No.");
                SalesCrMemoHeader.SETRANGE("No.", "G/L Entry"."Document No.");
                IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                    //MESSAGE('%1', "G/L Entry"."Document No.");
                    CLEAR(R50207);
                    R50207.SETTABLEVIEW(SalesCrMemoHeader);
                    txtfile := 'C:\CNDNMail\TDSCreditNote\' + FORMAT("G/L Entry"."Entry No.") + '.pdf';
                    // R50207.SAVEASPDF(txtfile);

                    RecCustomer.RESET;
                    IF RecCustomer.GET("G/L Entry"."Source No.") THEN;
                    IF RecCustomer."E-Mail" <> '' THEN BEGIN
                        /*     SMTPMailSetup.GET;
                             SMTPMailSetup.TESTFIELD("Sender Email");
                             CLEAR(SMTPMail);
                             SMTPMail.CreateMessage('Orient Bell Tiles', SMTPMailSetup."Sender Email", RecCustomer."E-Mail", 'TDS Credit Notes', '', TRUE);
                             //SMTPMail.CreateMessage('OrientBell Tiles',SMTPMailSetup."User ID",RecCustomer."PCH E-Maill ID",'Credit Notes','',TRUE);
                             //SMTPMail.CreateMessage('OrientBell Tiles',SMTPMailSetup."User ID",'kulbhushan.sharma@orientbell.com','Credit Notes','',TRUE);
                             SMTPMail.AddCC(RecCustomer."PCH E-Maill ID");
                             RecCustomer.CALCFIELDS("SP E-Maill ID");
                             SMTPMail.AddCC(RecCustomer."SP E-Maill ID");
                             SMTPMail.AddCC('saurabh.saxena@orientbell.com');
                             SMTPMail.AppendBody('Dear ' + RecCustomer.Name);
                             SMTPMail.AppendBody('<br><br>');
                             SMTPMail.AppendBody('Please find the enclosed computer generated credit note');
                             SMTPMail.AppendBody('<br>');
                             SMTPMail.AppendBody('This is for your record');
                             SMTPMail.AppendBody('<br><br>');
                             SMTPMail.AppendBody('Regards,');
                             SMTPMail.AppendBody('<br>');
                             SMTPMail.AppendBody('Orient Bell Limited');
                             SMTPMail.AppendBody('<br>');
                             SMTPMail.AppendBody('Iris House, 16 Business Center, Nangal Raya');
                             SMTPMail.AppendBody('<br>');
                             SMTPMail.AppendBody('New Delhi 110046, India');
                             SMTPMail.AppendBody('<br>');
                             SMTPMail.AppendBody('Fax. +91 11 2852 1273');
                             SMTPMail.AppendBody('<br>');

                             IF EXISTS(txtfile) THEN BEGIN
                                 SMTPMail.AddAttachment(txtfile, txtfile);
                                 //MESSAGE('SENT');
                                 SMTPMail.Send;
                             END;*/
                    END;

                END;
            END;
        END;
    end;

    procedure GeneratedDebitNote()
    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("Entry No.", "G/L Entry"."Entry No.");
        IF GLEntry.FINDFIRST THEN BEGIN
            IF DocNo2 <> GLEntry."Document No." THEN BEGIN
                DocNo2 := GLEntry."Document No.";
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETCURRENTKEY("No.");
                SalesInvoiceHeader.SETRANGE("No.", GLEntry."Document No.");
                IF NOT SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    CLEAR(R50294);
                    R50294.SETTABLEVIEW(GLEntry);
                    txtfile := 'C:\CNDNMail\DebitNote\' + FORMAT(GLEntry."Entry No.") + '.pdf';
                    // R50294.SAVEASPDF(txtfile);

                    RecCustomer.RESET;
                    IF RecCustomer.GET(GLEntry."Source No.") THEN;
                    IF RecCustomer."E-Mail" <> '' THEN BEGIN
                        /*   SMTPMailSetup.GET;
                           SMTPMailSetup.TESTFIELD("Sender Email");
                           CLEAR(SMTPMail);
                           SMTPMail.CreateMessage('Orient Bell Tiles', SMTPMailSetup."Sender Email", RecCustomer."E-Mail", 'Debit Notes', '', TRUE);
                           //SMTPMail.CreateMessage('OrientBell Tiles',SMTPMailSetup."User ID",'kulbhushan.sharma@orientbell.com','Debit Notes','',TRUE);
                           SMTPMail.AddCC(RecCustomer."PCH E-Maill ID");
                           RecCustomer.CALCFIELDS("SP E-Maill ID");
                           SMTPMail.AddCC(RecCustomer."SP E-Maill ID");
                           SMTPMail.AddCC('saurabh.saxena@orientbell.com');
                           SMTPMail.AppendBody('Dear ' + RecCustomer.Name);
                           SMTPMail.AppendBody('<br><br>');
                           SMTPMail.AppendBody('Please find the enclosed computer generated debit note');
                           SMTPMail.AppendBody('<br>');
                           SMTPMail.AppendBody('This is for your record');
                           SMTPMail.AppendBody('<br><br>');
                           SMTPMail.AppendBody('Regards,');
                           SMTPMail.AppendBody('<br>');
                           SMTPMail.AppendBody('Orient Bell Limited');
                           SMTPMail.AppendBody('<br>');
                           SMTPMail.AppendBody('Iris House, 16 Business Center, Nangal Raya');
                           SMTPMail.AppendBody('<br>');
                           SMTPMail.AppendBody('New Delhi 110046, India');
                           SMTPMail.AppendBody('<br>');
                           SMTPMail.AppendBody('Fax. +91 11 2852 1273');
                           SMTPMail.AppendBody('<br>');

                           IF EXISTS(txtfile) THEN BEGIN
                               SMTPMail.AddAttachment(txtfile, txtfile);
                               //MESSAGE('SENT');
                               SMTPMail.Send;
                           END;*/
                    END;
                END;
            END;
        END;
    end;
}

