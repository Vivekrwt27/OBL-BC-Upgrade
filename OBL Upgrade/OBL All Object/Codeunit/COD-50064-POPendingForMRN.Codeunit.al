codeunit 50064 "PO Pending For MRN"
{

    trigger OnRun()
    begin
        GenerateFile;
        SendMail;
    end;

    var
        Text001: Label 'PO Pending for MRN Reports as on  ';
        Text002: Label 'PO Pending for MRN Report';
        Text003: Label 'Please find the attached PO Pending for MRN Report.';
        Text004: Label 'PO Pending for MRN Report';
        Text005: Label 'Dear Sir/Madam,';
        Text006: Label 'Regards';
        Text007: Label 'Mail sent!';


    procedure GenerateFile()
    var
        Subject: Text;
        PurchaseHeader: Record "Purchase Header";
        UserSetup: Record "User Setup";
        Report50184: Report "PO Pending for MRN";
        Vendor: Record Vendor;
        LastVendorCode: Code[20];
        InnerPurchaseHeader: Record "Purchase Header";

    begin

        UserSetup.RESET;
        UserSetup.SETFILTER("E-Mail", '<>%1', '');
        IF UserSetup.FINDFIRST THEN BEGIN
            REPEAT
                PurchaseHeader.RESET;
                PurchaseHeader.SETCURRENTKEY("User Id", "Buy-from Vendor No.");
                PurchaseHeader.SETFILTER("User Id", '%1', UserSetup."User ID");
                PurchaseHeader.SETFILTER("Document Type", '%1', PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SETFILTER(Status, '%1', PurchaseHeader.Status::Released);
                PurchaseHeader.SETFILTER("Delivary Date", '<>%1', 0D);
                IF PurchaseHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        IF LastVendorCode <> PurchaseHeader."Buy-from Vendor No." THEN BEGIN
                            CLEAR(Report50184);
                            InnerPurchaseHeader.RESET;
                            InnerPurchaseHeader.SETCURRENTKEY("User Id", "Buy-from Vendor No.");
                            InnerPurchaseHeader.SETFILTER("User Id", '%1', UserSetup."User ID");
                            InnerPurchaseHeader.SETFILTER("Buy-from Vendor No.", '%1', PurchaseHeader."Buy-from Vendor No.");
                            InnerPurchaseHeader.SETFILTER("Document Type", '%1', PurchaseHeader."Document Type"::Order);
                            InnerPurchaseHeader.SETFILTER(Status, '%1', PurchaseHeader.Status::Released);
                            InnerPurchaseHeader.SETFILTER("Delivary Date", '<>%1', 0D);
                            IF InnerPurchaseHeader.FINDFIRST THEN BEGIN
                                Report50184.SETTABLEVIEW(InnerPurchaseHeader);
                                //Subject := CONVERTSTR('MRN_'+PurchaseHeader."User Id"+'-'+UserSetup."User ID",'\','_');
                                Subject := CONVERTSTR('MRN_' + PurchaseHeader."User Id" + '-' + PurchaseHeader."Buy-from Vendor No.", '\', '_');
                                // Subject := CONVERTSTR('MRN_'+PurchaseHeader."User Id"+' - '+PurchaseHeader."Buy-from Vendor Name",'\','_');
                                // Report50184.SAVEASEXCEL('C:\MRNExcel\' + Subject + '.xlsx');
                                LastVendorCode := PurchaseHeader."Buy-from Vendor No.";
                            END;
                        END;
                    UNTIL PurchaseHeader.NEXT = 0;
                END;
            UNTIL UserSetup.NEXT = 0;
        END;
    end;


    procedure SendMail()
    var
        PurchaseHeader: Record "Purchase Header";
        Subject: Text;
        UserSetup: Record "User Setup";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        // SMTPSetup: Record 409;
        // SMTPMailCodeUnit: Codeunit 400;
        LastVendorCode: Code[20];
        InstreamVar: InStream;
        OutstreamVar: OutStream;
        TempBlobCU: Codeunit "Temp Blob";
        FileMgmt: Codeunit "File Management";
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        EmailBccList: list of [Text];

    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        UserSetup.RESET;
        //UserSetup.SETFILTER("User ID",'%1','BHKPUC001');
        UserSetup.SETFILTER("E-Mail", '<>%1', '');
        IF UserSetup.FINDFIRST THEN
            REPEAT
                PurchaseHeader.RESET;
                PurchaseHeader.SETCURRENTKEY("User Id", "Buy-from Vendor No.");
                PurchaseHeader.SETFILTER("User Id", '%1', UserSetup."User ID");
                IF PurchaseHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        IF PurchaseHeader."Buy-from Vendor No." <> LastVendorCode THEN BEGIN
                            EmailAddress := UserSetup."E-Mail";
                            //MESSAGE(EmailAddress);  //RK0403
                            InCorrectMail := FALSE;
                            NoOfAtSigns := 0;
                            FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                                IF EmailAddress[i] = '@' THEN
                                    NoOfAtSigns := NoOfAtSigns + 1;
                                IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR
                                  ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                                  ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR
                                  (EmailAddress[i] IN ['@', '.', '-', '_']))
                                THEN BEGIN
                                END ELSE BEGIN
                                    InCorrectMail := TRUE;
                                END;
                            END;

                            IF InCorrectMail = FALSE THEN BEGIN

                                IF (STRPOS(UserSetup."E-Mail", ' ') = 0) AND (UserSetup."E-Mail" <> '') THEN BEGIN
                                    //  SMTPSetup.GET();

                                    /*  SMTPMailCodeUnit.CreateMessage('COO Office - OBL', 'donotreply@orientbell.com',
                                                                    UserSetup."E-Mail", 'Pending Receipt' + PurchaseHeader."Buy-from Vendor No.", '', TRUE);*/ // 15578
                                    EmailAddressList.Add('donotreply@orientbell.com');
                                    EmailMsg.Create(EmailAddressList, 'Pending Receipt' + PurchaseHeader."Buy-from Vendor No.", BodyText, true, EmailBccList, EmailCCList);                                                                                                                         //'kulbhushan.sharma@orientbell.com','PO Pending for MRN - '+PurchaseHeader."Buy-from Vendor Name",'',TRUE);
                                END ELSE BEGIN
                                    /*  SMTPSetup.GET();
                                      SMTPMailCodeUnit.CreateMessage('COO Office - OBL', 'donotreply@orientbell.com',
                                                                    SMTPSetup."User ID", 'Pending Receipt - ' + PurchaseHeader."Buy-from Vendor No.", '', TRUE);*/ //
                                                                                                                                                                   //'kulbhushan.sharma@orientbell.com','PO Pending for MRN - '+PurchaseHeader."Buy-from Vendor Name",'',TRUE);
                                    EmailAddressList.Add('donotreply@orientbell.com');
                                    EmailMsg.Create(EmailAddressList, 'Pending Receipt' + PurchaseHeader."Buy-from Vendor No.", BodyText, true, EmailBccList, EmailCCList);                                                                                                                         //'kulbhushan.sharma@orientbell.com','PO Pending for MRN - '+PurchaseHeader."Buy-from Vendor Name",'',TRUE);

                                END;
                                //MESSAGE('hi');
                                EmailCCList.add('donotreply@orientbell.com');
                                IF UserSetup."User Name" <> '' THEN
                                    BodyText := 'Dear  ' + PurchaseHeader."Buy-from Vendor Name"
                                //SMTPMailCodeUnit.AppendBody('Dear  '  + UserSetup."User Name")
                                ELSE
                                    BodyText += 'Dear  ';
                                BodyText += '<br><br>';
                                BodyText += 'We find from our system that the attached list of items are pending for execution.';
                                BodyText += '<br><br>';
                                BodyText += 'Would be obliged if you could provide us the tentative schedule for its despatch.';
                                BodyText += '<br><br>';
                                BodyText += 'If you have already executed these items, kindly provide us the despatch particulars.';
                                BodyText += '<br><br>';
                                BodyText += 'Kindly acknowledge.';
                                BodyText += '<br><br>';
                                BodyText += 'Regards, <br>';
                                BodyText += 'Orient Bell Limited <br>';
                                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                                BodyText += 'New Delhi 110046, India <br>';
                                BodyText += 'Tel. +91 11 4711 9100 <br>';
                                BodyText += 'Fax. +91 11 2852 1273 <br>';
                                Subject := CONVERTSTR('MRN_' + PurchaseHeader."User Id" + '-' + PurchaseHeader."Buy-from Vendor No.", '\', '_');
                                // if File.Exists('C:\MRNExcel\' + Subject + '.xlsx') THEN BEGIN
                                // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\MRNExcel\' + Subject + '.xlsx');
                                if TempBlobCU.HasValue() then begin
                                    TempBlobCU.CreateInStream(InstreamVar);
                                    EmailMsg.Create(EmailAddressList, 'Pending Receipt' + PurchaseHeader."Buy-from Vendor No.", BodyText, true, EmailBccList, EmailCCList);
                                    // if File.Exists('C:\MRNExcel\' + Subject + '.xlsx') THEN
                                    EmailMsg.AddAttachment('C:\MRNExcel\' + Subject + '.xlsx', 'application/pdf', InstreamVar);
                                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                                END;
                                /*  IF (EXISTS('C:\MRNExcel\' + Subject + '.xlsx')) THEN BEGIN
                                     SMTPMailCodeUnit.AddAttachment('C:\MRNExcel\' + Subject + '.xlsx', Subject + '.xlsx');
                                     SMTPMailCodeUnit.Send();
                                 END;*/
                                // END;
                                LastVendorCode := PurchaseHeader."Buy-from Vendor No.";
                            END;
                        end;
                    UNTIL PurchaseHeader.NEXT = 0;
                END;
            UNTIL UserSetup.NEXT = 0;
    end;
}

