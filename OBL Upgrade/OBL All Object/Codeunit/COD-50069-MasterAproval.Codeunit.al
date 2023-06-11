codeunit 50069 "Master Aproval"
{

    trigger OnRun()
    begin
    end;

    var
        recVendor: Record Vendor;
        TxtGUID: Text;
        TxtComment: Text;
        DocNo: Code[20];
        TableID: Integer;
        //  SMTPMailCodeUnit: Codeunit 400;
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


    procedure AppEntryVendor(recVendorIns: Record Vendor)
    var
        ApprovalEntry: Record "Approval Entry";
        recUserSetup: Record "User Setup";
        recAppUser: Record "User Setup";
    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        IF recUserSetup.GET(USERID) THEN;
        IF recAppUser.GET(recUserSetup."Vendor Approver") THEN;

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 23);
        ApprovalEntry.SETRANGE("Document No.", recVendorIns."No.");
        IF NOT ApprovalEntry.FINDFIRST THEN BEGIN
            ApprovalEntry.INIT;
            ApprovalEntry."Table ID" := 23;
            ApprovalEntry."Document No." := recVendorIns."No.";
            ApprovalEntry."Approval Code" := 'VENDOR';
            ApprovalEntry."Sender ID" := USERID;
            ApprovalEntry."Approval Type" := ApprovalEntry."Approval Type"::Approver;
            IF recUserSetup."Vendor Approver" <> '' THEN BEGIN
                ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Open);

                recVendorIns."Approver ID" := recUserSetup."Vendor Approver";
                recVendorIns.MODIFY;
            END
            ELSE BEGIN
                ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
                recVendorIns.Approved := TRUE;
                recVendorIns.MODIFY;

            END;
            //IF ApprovalEntry."Sequence No." = 0 THEN BEGIN
            //ApprovalEntry."Approver Code" := recUserSetup."Vendor Approver"; //'FA006')
            ApprovalEntry."Approver ID" := recUserSetup."Vendor Approver";
            ApprovalEntry."Sequence No." := 1;
            //ApprovalEntry.EmailID := recAppUser."E-Mail";

            ApprovalEntry.INSERT;
            MESSAGE('Sent approval for %1.', recVendorIns."No.");

            //----->>
            /*  SMTPMailCodeUnit.CreateMessage('TEst Vendor: ' + recVendorIns.Name, 'donotreply@orientbell.com',
                'virendra.kumar@mindshell.info', 'Vendor' + recVendorIns.Name, '', TRUE);*/ // 15578
            EmailAddressList.Add('donotreply@orientbell.com');

            BodyText := getApprovalLink(23, ApprovalEntry."Document No.", 4);
            //-----<<


        END ELSE
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                IF recUserSetup."Vendor Approver" <> '' THEN BEGIN
                    ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Open);

                    recVendorIns."Approver ID" := recUserSetup."Vendor Approver";
                    recVendorIns.MODIFY;
                END
                ELSE BEGIN
                    ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
                    recVendorIns.Approved := TRUE;
                    recVendorIns.MODIFY;
                END;

                ApprovalEntry."Sequence No." += 1;
                //ApprovalEntry."Approver Code" := recUserSetup."Vendor Approver";
                ApprovalEntry."Approver ID" := recUserSetup."Vendor Approver";
                //ApprovalEntry.EmailID := recAppUser."E-Mail";
                MESSAGE('Vendor approved for: %1.', recVendorIns."No.");
                ApprovalEntry.MODIFY;
            END;
    end;


    procedure ApprovedEntryVendor(ApprovalEntry: Record "Approval Entry")
    var
        recUserSetup: Record "User Setup";
        recAppUser: Record "User Setup";
        recVendor1: Record Vendor;
    begin
        IF recUserSetup.GET(USERID) THEN;
        IF recAppUser.GET(recUserSetup."Vendor Approver") THEN;

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 23);
        ApprovalEntry.SETRANGE("Document No.", ApprovalEntry."Document No.");
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            //ApprovalEntry."Sender ID" := USERID;
            IF recUserSetup."Vendor Approver" = '' THEN BEGIN
                IF recVendor.GET(ApprovalEntry."Document No.") THEN;
                ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
                recVendor.Approved := TRUE;
                recVendor.MODIFY;
            END
            ELSE BEGIN
                ApprovalEntry."Approver ID" := recUserSetup."Vendor Approver";
                ApprovalEntry."Sequence No." += 1;

                CLEAR(recVendor);
                IF recVendor.GET(ApprovalEntry."Document No.") THEN;
                recVendor."Approver ID" := recUserSetup."Vendor Approver";
                recVendor.MODIFY;
            END;

            ApprovalEntry.MODIFY;
            MESSAGE('Approved entry for: %1.', ApprovalEntry."Document No.");
        END;
    end;


    procedure RejectEntryVendor(ApprovalEntry: Record "Approval Entry")
    var
        recUserSetup: Record "User Setup";
        recAppUser: Record "User Setup";
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
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

        IF recUserSetup.GET(USERID) THEN;
        IF recAppUser.GET(recUserSetup."Vendor Approver") THEN;
        IF recVendor.GET(ApprovalEntry."Document No.") THEN;
        //----------------
        /* SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
             'virendra.kumar@mindshell.info', 'Rejection Mail' + ApprovalEntry."Document No.", '', TRUE);*/// 15578

        BodyText := 'Dear Sir, ';
        BodyText += Text50010;
        BodyText += FORMAT(ApprovalEntry."Document No.") + 'has been Rejected.';
        BodyText += Text50010;
        BodyText += Text50010;
        BodyText += Text50000;
        BodyText += Text50010;
        BodyText += Text50011;
        BodyText += recVendor.Name;
        BodyText += Text50010;
        BodyText += Text50012;
        BodyText += ApprovalEntry."Comment Text";
        BodyText += getApprovalLink(23, ApprovalEntry."Document No.", 4); //Link

        //IF EmailCC<>'' THEN
        //SMTPMailCodeUnit.AddCC(EmailCC);
        EmailMsg.Create(EmailAddressList, 'Rejection Mail' + ApprovalEntry."Document No.", BodyText, true, EmailBccList, EmailCCList);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        MESSAGE('Mail Sent For Rejection %1', ApprovalEntry."Document No.");

        //--------------

        /*
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 23);
        ApprovalEntry.SETRANGE("Document No.", ApprovalEntry."Document No.");
        IF ApprovalEntry.FINDFIRST THEN BEGIN
          ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
          ApprovalEntry.MODIFY;
          MESSAGE('Rejected entry for: %1.', ApprovalEntry."Document No.");
        END;
        */

        //TxtComment := getApprovalLink(23,ApprovalEntry."Document No.", 1);

    end;


    procedure getApprovalLink(TblID: Integer; DocNo: Code[20]; TypeInt: Integer): Text
    var
        AppEntry: Record "Approval Entry";
        GUIDTXT: Text[100];
        TxtLink: Text[250];
    begin
        AppEntry.RESET;
        AppEntry.SETRANGE("Table ID", 23);
        AppEntry.SETRANGE("Document No.", DocNo);
        IF AppEntry.FINDFIRST THEN BEGIN
            GUIDTXT := AppEntry."GUID Key";
        END;

        //TxtLink := '<button onclick="window.open('+'http://14.140.109.180/mailapproval/?ref='+GUIDTXT+')">Click me</button>';
        //TxtLink := TextButtonStart+GUIDTXT+TextButtonEnd;
        //TxtLink := 'http://182.73.118.183/mailapproval/?ref='+GUIDTXT; //live server
        //TxtLink := 'http://14.140.109.181/mailapproval/?ref='+GUIDTXT; //live server
        TxtLink := 'http://erp.orientapps.com/mailapproval/?ref=' + GUIDTXT; //live server
        EXIT(TxtLink);
    end;
}

