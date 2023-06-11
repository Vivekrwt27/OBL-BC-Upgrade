codeunit 50056 "Notify Management"
{

    trigger OnRun()
    var
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text59999: Label '<html>';
        Text60000: Label '<Table>';
        Text60001: Label '<TR Border=4>';
        Text60002: Label '<TD  width=200 Align=Left>';
        Text60003: Label '</TD>';
        Text60004: Label '</TR>';
        Text60005: Label '</Table>';
        Text60006: Label '</html>';
        Text60007: Label '<TD  width=500 Align=Left>';
        Text60008: Label '<TD  width=100 Align=Center>';
        Text60009: Label '<TD Align=Left>';
        Text60010: Label '<TD  width=800 Align=right>';
        Text60011: Label '<BR>';
        Text60012: Label '<B>';
        Text60013: Label '</B>';
        Text60014: Label '<TD  width=850 Align=right>';
        Text60015: Label '<font size="3"> ';
        Text60016: Label '</font>';
        Text50022: Label 'Mail Sent Successfully !!!!';
        Text50023: Label 'This is to advice that the following shipment is being despatched from our factory as follows.';
        Text50024: Label '<TD  width=1000 Align=Left>';
        Text50025: Label 'This e-Mail is auto generated from Microsoft Dynamics Navison ERP.';
        Text50026: Label '<TR>';
        Text50027: Label '<table border="1">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%" Align=Center>';
        Text50031: Label '<td width="65%" Align=Center>';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width="15%" Align=Center>';
        Text70000: Label '<TD  width="15%" Align=Center>';
        Text70001: Label '<TD  width="20%" Align=Center>';
        Text70002: Label '<TD  width="65%" Align=Center>';
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
        IF UserSetup.FINDFIRST THEN BEGIN
            REPEAT
                NotificationEntryTable.SETCURRENTKEY("Notify User", "Notification Code", Notify);
                NotificationEntryTable.SETFILTER("Notify User", UserSetup."User ID");
                NotificationEntryTable.SETFILTER(Notify, '%1', TRUE);
                NotificationEntryTable.SETFILTER("Notify Due Date Time", '..%1', CURRENTDATETIME);
                IF NotificationEntryTable.FINDFIRST THEN BEGIN
                    //      REPEAT
                    NotificationEntryTable.SETCURRENTKEY("Notify User");

                    //Check Correct Email Address
                    FOR i := 1 TO STRLEN(NotificationEntryTable."Email ID") DO BEGIN
                        IF NotificationEntryTable."Email ID"[i] = '@' THEN
                            NoOfAtSigns := NoOfAtSigns + 1;
                        IF (((NotificationEntryTable."Email ID"[i] >= 'a') AND (NotificationEntryTable."Email ID"[i] <= 'z')) OR
                          ((NotificationEntryTable."Email ID"[i] >= 'A') AND (NotificationEntryTable."Email ID"[i] <= 'Z')) OR
                          ((NotificationEntryTable."Email ID"[i] >= '0') AND (NotificationEntryTable."Email ID"[i] <= '9')) OR
                          (NotificationEntryTable."Email ID"[i] IN ['@', '.', '-', '_']))
                        THEN BEGIN

                        END ELSE BEGIN
                            ERROR('Incorrect E-mail Address : ' + NotificationEntryTable."Email ID")
                        END;
                    END;
                    //Check Correct Email Address
                    IF STRPOS(NotificationEntryTable."Email ID", ' ') = 0 THEN BEGIN
                        // cduSMTPMail.CreateMessage('Orient Bell Ltd.', 'donotreply@orientbell.com', NotificationEntryTable."Email ID", 'OBL Notification.',
                        //                            '', TRUE);

                        EmailAddressList.Add('donotreply@orientbell.com');
                        BodyText := 'Dear Sir / Madam,';
                        BodyText += '<br><br>';
                        BodyText += ' The details of GRN Items achieved more than or equals to 95% are listed below:';
                        BodyText += '<br>';
                        //Mail HTML Table
                        BodyText += Text60005;
                        BodyText += Text60006;

                        BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'Plant Code' + Text60013 + Text60003;
                        BodyText += Text50030 + Text60012 + 'PO No.' + Text60013 + Text60003;
                        BodyText += Text50031 + Text60012 + 'Message' + Text60013 + Text60003;
                        rNotiEntryTable.RESET;
                        rNotiEntryTable.SETRANGE("Notify User", NotificationEntryTable."Notify User");
                        rNotiEntryTable.SETRANGE(Notify, TRUE);
                        rNotiEntryTable.SETFILTER("Notify Due Date Time", '..%1', CURRENTDATETIME);
                        IF rNotiEntryTable.FIND('-') THEN BEGIN
                            REPEAT
                                BodyText := Text50026 + Text70000 + FORMAT(rNotiEntryTable."Location Code") + Text60003;
                                BodyText := Text70001 + FORMAT(rNotiEntryTable."Document No.") + Text60003;
                                BodyText := Text70002 + FORMAT(rNotiEntryTable."Notify Message" + rNotiEntryTable."Notify Message1" +
                                                        rNotiEntryTable."Notify Message2") + Text60003;

                                rNotiEntryTable.Notify := FALSE;
                                rNotiEntryTable."Notify On" := CURRENTDATETIME;
                                rNotiEntryTable.MODIFY;
                            UNTIL rNotiEntryTable.NEXT = 0;
                        END;
                        BodyText := Text60004;
                        BodyText := Text60005;
                        BodyText := Text60006;
                        BodyText := Text60011;
                        //Mail HTML Table
                        BodyText := '<br><br>';
                        BodyText := 'Regards';
                        BodyText := '<br>';
                        BodyText := 'Orient Bell Ltd.';
                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        //cduSMTPMail.Send;

                    END;
                    //      UNTIL rNotiEntryTable.next=0;
                END;
            UNTIL UserSetup.NEXT = 0;
        END;
    end;

    var
        NotificationUserMapping: Record "Notification - User Mapping";
        NotificationEntryTable: Record "Notification Entry Table";
        UserSetup: Record "User Setup";
        i: Integer;
        NoOfAtSigns: Integer;
        //  cduSMTPMail: Codeunit 400;
        rNotiEntryTable: Record "Notification Entry Table";
        tmTime: Time;
        xNotifyUser: Code[30];
        dtDate: Date;


    procedure CreateNotifyEntry("Code": Code[20]; RecIDToNotify: RecordID; TabID: Integer; DocType: Integer; DocNo: Code[20]; DocLineNo: Integer; Msg: Text; TimeRange: Integer; DateRange: Integer; Location: Code[20])
    var
        NotificationEntryTable: Record "Notification Entry Table";
        LastEntryNo: Integer;
    begin
        LastEntryNo := GetNextEntryNo;
        NotificationUserMapping.RESET;
        NotificationUserMapping.SETFILTER("Notification Code", Code);
        IF NotificationUserMapping.FINDFIRST THEN BEGIN
            REPEAT
                NotificationEntryTable.INIT;
                NotificationEntryTable."Entry No." := LastEntryNo;
                NotificationEntryTable."Record ID" := RecIDToNotify;
                NotificationEntryTable."Table ID" := TabID;
                NotificationEntryTable."Doc Type" := DocType;
                NotificationEntryTable."Document No." := DocNo;
                NotificationEntryTable."Document Line No." := DocLineNo;
                NotificationEntryTable."Creation Date & Time" := CURRENTDATETIME();
                NotificationEntryTable."Notify User" := NotificationUserMapping."User ID";
                NotificationEntryTable."Email ID" := NotificationUserMapping."E-Mail ID";

                IF STRLEN(Msg) > 250 THEN BEGIN
                    NotificationEntryTable."Notify Message" := COPYSTR(Msg, 1, 250);
                    NotificationEntryTable."Notify Message1" := COPYSTR(Msg, 251, 500);
                    NotificationEntryTable."Notify Message2" := COPYSTR(Msg, 501, 750);
                END ELSE BEGIN
                    NotificationEntryTable."Notify Message" := Msg;
                END;
                NotificationEntryTable.Notify := TRUE;
                NotificationEntryTable."Location Code" := Location;
                NotificationEntryTable."Notification Code" := Code;
                NotificationEntryTable."Notify Time Range" := TimeRange;
                tmTime := DT2TIME(CURRENTDATETIME);
                //    tmTime:=tmTime+((TimeRange*1000)*60);
                dtDate := DT2DATE(CURRENTDATETIME);
                dtDate := dtDate + DateRange;
                NotificationEntryTable."Notify Due Date Time" := CREATEDATETIME(dtDate, tmTime);
                NotificationEntryTable.INSERT(TRUE);
                LastEntryNo += 1;
            UNTIL NotificationUserMapping.NEXT = 0;
        END;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        NotificationEntryTable: Record "Notification Entry Table";
    begin
        NotificationEntryTable.RESET;
        IF NotificationEntryTable.FINDLAST THEN
            EXIT(NotificationEntryTable."Entry No." + 1) ELSE
            EXIT(1);
    end;


    procedure CreateNotifyEntryPOStatus("Code": Code[20]; RecIDToNotify: RecordID; TabID: Integer; DocType: Integer; DocNo: Code[20]; DocLineNo: Integer; Msg: Text; TimeRange: Integer; UserID: Code[50]; Email: Text)
    var
        NotificationEntryTable: Record "Notification Entry Table";
        LastEntryNo: Integer;
    begin
        LastEntryNo := GetNextEntryNo;
        NotificationUserMapping.RESET;
        NotificationUserMapping.SETFILTER("Notification Code", Code);
        IF NotificationUserMapping.FINDFIRST THEN BEGIN
            REPEAT
                NotificationEntryTable.INIT;
                NotificationEntryTable."Entry No." := LastEntryNo;
                NotificationEntryTable."Record ID" := RecIDToNotify;
                NotificationEntryTable."Table ID" := TabID;
                NotificationEntryTable."Doc Type" := DocType;
                NotificationEntryTable."Document No." := DocNo;
                NotificationEntryTable."Document Line No." := DocLineNo;
                NotificationEntryTable."Creation Date & Time" := CURRENTDATETIME();
                NotificationEntryTable."Notify User" := UserID;
                NotificationEntryTable."Email ID" := Email;
                NotificationEntryTable."Notify Message" := Msg;
                NotificationEntryTable.Notify := TRUE;

                NotificationEntryTable."Notification Code" := Code;
                NotificationEntryTable."Notify Time Range" := TimeRange;
                tmTime := DT2TIME(CURRENTDATETIME);
                tmTime := tmTime + ((TimeRange * 1000) * 60);
                NotificationEntryTable."Notify Due Date Time" := CREATEDATETIME(TODAY, tmTime);
                NotificationEntryTable.INSERT(TRUE);
                LastEntryNo += 1;
            UNTIL NotificationUserMapping.NEXT = 0;
        END;
    end;


    procedure CreateNotificationEntry("Code": Code[20]; RecIDToNotify: RecordID; TabID: Integer; DocType: Integer; DocNo: Code[20]; DocLineNo: Integer; Msg: Text; TimeRange: Integer; DateRange: Integer; Location: Code[20]; NotifyTo: Code[20]; Email: Text; Qty: Decimal)
    var
        NotificationEntryTable: Record "Notification Entry Table";
        LastEntryNo: Integer;
    begin
        LastEntryNo := GetNextEntryNo;
        NotificationEntryTable.INIT;
        NotificationEntryTable."Entry No." := LastEntryNo;
        NotificationEntryTable."Record ID" := RecIDToNotify;
        NotificationEntryTable."Notification Date" := TODAY;
        NotificationEntryTable."Table ID" := TabID;
        NotificationEntryTable."Doc Type" := DocType;
        NotificationEntryTable."Document No." := DocNo;
        NotificationEntryTable."Document Line No." := DocLineNo;
        NotificationEntryTable."Creation Date & Time" := CURRENTDATETIME();
        NotificationEntryTable."Notify User" := NotifyTo;
        NotificationEntryTable."Email ID" := Email;

        IF STRLEN(Msg) > 250 THEN BEGIN
            NotificationEntryTable."Notify Message" := COPYSTR(Msg, 1, 250);
            NotificationEntryTable."Notify Message1" := COPYSTR(Msg, 251, 500);
            NotificationEntryTable."Notify Message2" := COPYSTR(Msg, 501, 750);
        END ELSE BEGIN
            NotificationEntryTable."Notify Message" := Msg;
        END;
        NotificationEntryTable.Notify := FALSE;
        NotificationEntryTable."Location Code" := Location;
        NotificationEntryTable."Notification Code" := Code;
        NotificationEntryTable."Notify Time Range" := TimeRange;
        NotificationEntryTable."Available Inventory" := Qty;
        tmTime := DT2TIME(CURRENTDATETIME);
        //    tmTime:=tmTime+((TimeRange*1000)*60);
        dtDate := DT2DATE(CURRENTDATETIME);
        dtDate := dtDate + DateRange;
        NotificationEntryTable."Notify Due Date Time" := CREATEDATETIME(dtDate, tmTime);
        NotificationEntryTable.INSERT(TRUE);
    end;
}

