codeunit 50002 "Report Mail Utility"
{
    Permissions = TableData "Sales Invoice Header" = rm;

    trigger OnRun()
    begin
        //Num:=0;

        CLEAR(CdReportMail);
        CdReportMail.GEneratePDFsGST;
        SLEEP(100);

        SendMail();
        //REPORT.RUN(50181,FALSE,FALSE)create
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        SalesInvHeader1: Record "Sales Invoice Header";
        PDF: Codeunit "Report Mail Utility";
        Text50000: Label 'Dear      ';
        Text50001: Label 'Please find the enclosed below information from computer generated invoice.';
        Text50002: Label ' Against the order placed for below customer. <br/> <br/> ';
        Text50003: Label 'This is for your records. Kindly acknowledge the receipt.<br/> <br/> ';
        Text50004: Label 'Regards, <br/> <br/> ';
        Text50005: Label 'Orient Bell Limited <br/> <br/> ';
        Text50006: Label 'Iris House, 16 Business Center, Nangal Raya <br/> <br/> ';
        Text50007: Label 'New Delhi 110046, India<br/> <br/> ';
        Text50008: Label 'Tel:   +91 11 4711 9100<br/> <br/> ';
        Text50009: Label 'Fax:  +91 11 2852 1273<br/> <br/> ';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Customer Code :-  ';
        Text50012: Label 'Customer Name :-  ';
        Text50013: Label 'Amount to Customer :-  ';
        Text50014: Label 'Invoice Date :-  ';
        Text50015: Label 'Invoice No :-  ';
        Text50016: Label 'Quantity in Carton :-  ';
        Text50017: Label 'Transporter Name.:-  ';
        Text50018: Label 'Truck No :-  ';
        Text50019: Label 'Order Date :-  ';
        Text50020: Label 'Order No. :-  ';
        Text50021: Label 'System have not PCH e-Mail ID, So Informaiton can not sent to PCH Head';
        Text50022: Label 'You are going to print Depot Tax Invoice. Please check your Stationary.';
        Text50023: Label 'You are going to print Trading Invoice. Please check your Stationary.';
        Text50024: Label 'You are going to print Exciseable Invoice. Please check your Stationary.';
        Text50025: Label 'You are going to print Scrap Bill. Please check your Stationary.';
        Text50026: Label 'You are going to print Sales Invoice Orient. Please check your Stationary.';

        Text50027: Label ' Please find the enclosed  computer generated invoice :';
        Text50028: Label ' against the order placed by you. <br/> <br/> ';
        Text50029: Label 'This is for your records.<br/> <br/> ';
        SalesInvNo: Code[20];
        "-----": Integer;
        txtDefaultPrinter: Text[100];
        SalesInvHdr: Record "Sales Invoice Header";
        MPDFDetail: Record "Auto Mail Detailed";
        ReSIH: Record "Sales Invoice Header";
        DocumentNo: Code[20];
        SaleInv: Record "Sales Invoice Header";
        MPDFDetail1: Record "Auto Mail Detailed";
        RecSalesInv: Record "Sales Invoice Header";
        EmailAddress: Text[250];
        NoOfAtSigns: Integer;
        InCorrectMail: Boolean;
        Window: Dialog;
        WindowIsOpen: Boolean;
        Num: Integer;
        CustName: Text[50];
        CustEmail: Text[70];
        txtFile: Text[50];
        // FileDir: Automation;
        DocNoNew: Code[30];
        "--msvrn--": Integer;
        recCust: Record Customer;
        recCustType: Record "Customer Type";
        CdReportMail: Codeunit "Report Mail Utility";


    procedure SendMail()
    var
        ReSIH: Record "Sales Invoice Header";
        SalesInvHeader: Record "Sales Invoice Header";
        //  SMTPMailCodeUnit: Codeunit 400;
        mycust: Record Customer;
        txtFile: Text[30];
        Leng: Integer;
        i: Integer;
        Flag: Integer;
        //    SMTPSetup: Record 409;
        PCHEmail: Text[100];
        SPEmail: Text[100];
        FileName: Text;
        Text50091: Label '<bgcolor="#ADFF2F"> ';
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
        //MPDFDetail.CHANGECOMPANY(ChangeComp);
        MPDFDetail.RESET;
        MPDFDetail.SETRANGE("PDF Mailed", FALSE);
        IF MPDFDetail.FINDFIRST THEN BEGIN
            REPEAT
                // CLEAR(SMTPMailCodeUnit);
                //RecSalesInv.CHANGECOMPANY(ChangeComp);
                //MESSAGE(MPDFDetail."Sales Invoice No.");
                RecSalesInv.RESET;
                RecSalesInv.SETRANGE("No.", MPDFDetail."Sales Invoice No.");
                IF RecSalesInv.FINDFIRST THEN
                    //mycust.CHANGECOMPANY(ChangeComp);
                    IF mycust.GET(RecSalesInv."Sell-to Customer No.") THEN BEGIN
                        //       MESSAGE('%1..%2',RecSalesInv."Sell-to Customer No.", mycust."E-Mail");
                        //IF mycust."E-Mail" <>'' THEN BEGIN  //kulbhushan

                        //Validate E-Mail ID BEGIN
                        //  IF mycust."E-Mail"='' THEN
                        //   EXIT;
                        EmailAddress := mycust."E-Mail";
                        InCorrectMail := FALSE;//MSKS020313
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
                            END

                        END;
                        IF mycust."Stop Mail Comunication PCH SP" THEN
                            InCorrectMail := TRUE;

                        IF InCorrectMail = FALSE THEN BEGIN
                            // 15578  RecSalesInv.CALCFIELDS(RecSalesInv."Amount to Customer", RecSalesInv."Qty In carton");

                            IF (STRPOS(mycust."E-Mail", ' ') = 0) AND (mycust."E-Mail" <> '') THEN BEGIN
                                //    SMTPSetup.GET();
                                //    SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                //  mycust."E-Mail", 'Sales Invoice' + ' - ' + MPDFDetail."Sales Invoice No." + ' - ' + MPDFDetail.CustName, '', TRUE);
                            END ELSE BEGIN
                                //    SMTPSetup.GET();
                                //    SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                //'donotreply@orientbell.com', 'Sales Invoice' + ' - ' + MPDFDetail."Sales Invoice No." + ' - ' + MPDFDetail.CustName, '', TRUE);
                            END;
                            IF NOT mycust."Stop Mail Comunication PCH SP" THEN BEGIN // msks12072018 start
                                IF STRPOS(MPDFDetail.SalesPersonEmail, ' ') = 0 THEN
                                    EmailCCList.Add(MPDFDetail.SalesPersonEmail);
                                IF STRPOS(MPDFDetail.PCHemail, ' ') = 0 THEN
                                    EmailCCList.Add(MPDFDetail.PCHemail);
                            END; // msks12072018 stop
                            EmailCCList.Add(('donotreply@orientbell.com'));
                            IF mycust.Name <> '' THEN
                                BodyText := 'Dear  ' + mycust.Name
                            ELSE
                                BodyText := 'Dear  ';
                            BodyText := '<br><br>';
                            BodyText := 'Please find the enclosed computer generated invoice. Against the order placed by you.';
                            BodyText := '<br><br>';
                            BodyText := Text50091 + 'New Wall and Floor Ranges Launched by Orientbell.' + Text50091;
                            BodyText := '<br><br>';
                            BodyText := 'For Details, check attached image or visit https://www.orientbell.com/new-tile-designs';
                            BodyText := '<br><br>';
                            BodyText := 'This is for your records';
                            BodyText := '<br><br>';
                            BodyText := 'Regards, <br>';
                            BodyText := 'Orient Bell Limited <br>';
                            BodyText := 'Iris House, 16 Business Center, Nangal Raya <br>';
                            BodyText := 'New Delhi 110046, India <br>';
                            BodyText := 'Tel. +91 11 4711 9100 <br>';
                            BodyText := 'Fax. +91 11 2852 1273 <br>';
                            SalesInvNo := '';// SalesInvHeader."No.";
                            FileName := '';
                            FileName := MPDFDetail."Document No." + '.pdf';
                            // if File.Exists('C:\MailPDF\' + MPDFDetail."Document No." + '.pdf') then begin
                            // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\MailPDF\' + MPDFDetail."Document No." + '.pdf');
                            if TempBlobCU.HasValue() then begin
                                TempBlobCU.CreateInStream(InstreamVar);
                                EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailBccList, EmailCCList);
                                // if File.Exists('C:\Broucher\' + 'OrientBellNewLaunches.jpg') THEN
                                EmailMsg.AddAttachment('C:\Broucher\' + 'OrientBellNewLaunches.jpg', 'application/pdf', InstreamVar);//JD
                                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                                // END;
                                // MPDFDetail."DateTime Mail Sent" := CURRENTDATETIME;
                                //END; //kulbhushan
                            END;
                            MPDFDetail."PDF Mailed" := TRUE;
                            MPDFDetail."Customer Email Id" := mycust."E-Mail";
                            MPDFDetail.MODIFY;
                            COMMIT;
                        END;
                    end;
            UNTIL MPDFDetail.NEXT = 0;

            IF GUIALLOWED THEN
                MESSAGE('Done');
        END;

    end;
    //MPDFDetail.CHANGECOMPANY(ChangeComp);

    procedure GEneratePDFs()
    var
        Text000: Label 'Generating';
        Text005: Label 'Report';
        /*  Report50000: Report 50000;
          Report50377: Report 50377;
          Report50314: Report 50360;
          Report50316: Report 50383;*/
        Report50278: Report "GST Sales Invoice -Scrap";
        RecSP: Record "Salesperson/Purchaser";
        DirectProj: Boolean;
    begin
        //SendMail();
        /*IF ISCLEAR(FileDir) THEN
          CREATE(FileDir,FALSE,TRUE);
        
        IF NOT FileDir.FolderExists('C:\MailPDF') THEN
          FileDir.CreateFolder('C:\MailPDF');*/

        SalesInvHeader.RESET;
        SalesInvHeader1.RESET;
        /*
        IF COMPANYNAME <>'Orient Tiles Live Set Up' THEN BEGIN
        CLEAR(SalesInvHeader);
        CLEAR(SalesInvHeader1);
         SalesInvHeader.CHANGECOMPANY(ChangeComp);
         SalesInvHeader1.CHANGECOMPANY(ChangeComp);
         Num:=1;
         END;
           */
        IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
            CLEAR(SalesInvHeader);
            CLEAR(SalesInvHeader1);

            ////SalesInvHeader.RESET;
            //sash
            //SalesInvHeader.SETCURRENTKEY("Date Sent","Invoiced Mailed");
            //sash
            //SalesInvHeader.SETRANGE("Date Sent",TODAY);
            SalesInvHeader.SETCURRENTKEY("Posting Date");


            //SalesInvHeader.SETFILTER("Posting Date",'>%1',010413D);
            //SalesInvHeader.SETRANGE("Posting Date",010413D,WORKDATE);
            ////SalesInvHeader.SETRANGE("Posting Date",010113D,050113D);
            SalesInvHeader.SETRANGE("Posting Date", WORKDATE - 5, WORKDATE);
            ////MESSAGE('%1',FORMAT(WORKDATE-2));

            SalesInvHeader.SETRANGE("Invoiced Mailed", FALSE);
            IF SalesInvHeader.FINDFIRST THEN BEGIN
                REPEAT
                BEGIN
                    DocNoNew := SalesInvHeader."No.";
                    CLEAR(PDF);
                    CLEAR(Customer);
                    IF Customer.GET(SalesInvHeader."Sell-to Customer No.") THEN BEGIN

                        WindowIsOpen := FALSE;

                        Window.OPEN(
                          Text000 +
                          '#1########################\\' +
                          SalesInvHeader."No.");
                        WindowIsOpen := TRUE;


                        IF ((SalesInvHeader."Location Code" <> 'SKD-PLANT') AND
                          (SalesInvHeader."Location Code" <> 'DRA-PLANT') AND (SalesInvHeader."Location Code" <> 'HSK-PLANT')) THEN BEGIN
                            SalesInvHeader1.RESET;
                            SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                            IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50377);
                                //COMMIT;
                                // 15578 CLEAR(Report50377);
                                // 15578 Report50377.SETTABLEVIEW(SalesInvHeader1);
                                txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                // 15578 Report50377.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                            END;
                        END ELSE BEGIN
                            CASE SalesInvHeader."Group Code" OF
                                '01':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50314);
                                            // 15578    CLEAR(Report50314);
                                            // 15578     Report50314.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578      Report50314.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '02':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50316);
                                            // 15578    CLEAR(Report50316);
                                            // 15578    Report50316.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578    Report50316.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '03':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50314);
                                            // 15578    CLEAR(Report50314);
                                            // 15578   Report50314.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578    Report50314.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '04':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50314);
                                            // 15578    CLEAR(Report50314);
                                            // 15578   Report50314.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578    Report50314.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '05':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50314);
                                            // 15578   CLEAR(Report50314);
                                            // 15578   Report50314.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578    Report50314.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '06':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50314);
                                            // 15578    CLEAR(Report50314);
                                            // 15578    Report50314.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578   Report50314.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '07':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50316);
                                            // 15578    CLEAR(Report50316);
                                            // 15578    Report50316.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578    Report50316.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');

                                            //COMMIT;
                                        END;
                                    END;
                                '08':
                                    BEGIN
                                        SalesInvHeader1.RESET;
                                        SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                        IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                            //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50314);
                                            // 15578    CLEAR(Report50314);
                                            // 15578    Report50314.SETTABLEVIEW(SalesInvHeader1);
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                            txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                            // 15578    Report50314.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                            //COMMIT;
                                        END;
                                    END;
                                ELSE BEGIN
                                    SalesInvHeader1.RESET;
                                    SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                                    IF SalesInvHeader1.FINDFIRST THEN BEGIN
                                        //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50278);
                                        CLEAR(Report50278);
                                        Report50278.SETTABLEVIEW(SalesInvHeader1);
                                        txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                        txtFile := CONVERTSTR(SalesInvHeader1."No.", '\', '_');
                                        // Report50278.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                        //COMMIT;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
                SaleInv.RESET;
                SaleInv.SETRANGE("No.", SalesInvHeader."No.");
                IF SaleInv.FINDFIRST THEN BEGIN
                    SaleInv."Invoiced Mailed" := TRUE;
                    SaleInv.MODIFY;


                    //sash
                    ////IF Num=1 THEN
                    ////MPDFDetail1.CHANGECOMPANY(ChangeComp);
                    IF NOT Customer.GET(SaleInv."Sell-to Customer No.") THEN BEGIN
                        CustName := '';
                        CustEmail := '';
                    END
                    ELSE BEGIN
                        //      IF Customer."Customer Type" = 'DIRECTPROJ' THEN Kulbhushan
                        //        DirectProj := TRUE;
                        CustName := Customer.Name;
                        //Kulbhushan if Customer Mail ID Blank Start
                        IF Customer."E-Mail" = '' THEN
                            CustEmail := 'donotreply@orientbell.com'
                        ELSE
                            //Kulbhushan if Customer Mail ID Blank Stop
                            CustEmail := Customer."E-Mail";
                    END;

                    MPDFDetail1.INIT;
                    MPDFDetail1."Document No." := txtFile;
                    MPDFDetail1."PDF Created" := TRUE;
                    MPDFDetail1."PDF Mailed" := FALSE;
                    MPDFDetail1."DateTime PDF Creation" := CURRENTDATETIME;
                    MPDFDetail1."Sales Invoice No." := DocNoNew;
                    MPDFDetail1.CustName := CustName;
                    MPDFDetail1."Customer Email Id" := CustEmail;
                    IF RecSP.GET(SaleInv."Salesperson Code") THEN;
                    MPDFDetail1.SalesPersonEmail := RecSP."E-Mail";
                    MPDFDetail1.PCHemail := Customer."PCH E-Maill ID";

                    /*IF DirectProj THEN BEGIN       //New condition 6700 Kulbhushan
                      MPDFDetail1.SalesPersonEmail := 'jitender.aggarwal@Orientbell.com';
                      MPDFDetail1.PCHemail := '';
                    END ELSE BEGIN
                      MPDFDetail1.SalesPersonEmail := RecSP."E-Mail";
                      MPDFDetail1.PCHemail := Customer."PCH E-Maill ID";
                    END;*/
                    MPDFDetail1.INSERT;
                    //Num:=Num+1;
                END;
                UNTIL SalesInvHeader.NEXT = 0;
            END;
            ////sash////
        END;
        //-------------------------------Orient Bell Limited - Bell---------------------
        /*
         Num:=0;
      CLEAR(SalesInvHeader);
      CLEAR(SalesInvHeader);
      CLEAR(SalesInvHeader1);
      SalesInvHeader1.RESET;
      SalesInvHeader.RESET;

      IF COMPANYNAME <> 'Orient Bell Limited - Bell' THEN BEGIN
       SalesInvHeader.CHANGECOMPANY(ChangeComp);
       SalesInvHeader1.CHANGECOMPANY(ChangeComp);
       Num:=1;
       //SalesInvHeader1.CHANGECOMPANY(ChangeComp);
       END;
       */
        //MSNK START
        /*
       IF COMPANYNAME = 'Orient Bell Limited - Bell' THEN BEGIN
       CLEAR(SalesInvHeader);
       CLEAR(SalesInvHeader1);

       //SalesInvHeader.CHANGECOMPANY('Orient Bell Limited - Bell');
       //SalesInvHeader1.CHANGECOMPANY('Orient Bell Limited - Bell');

       //sash
       SalesInvHeader.RESET;
       //SalesInvHeader.SETCURRENTKEY("Date Sent","Invoiced Mailed");
       //SalesInvHeader.SETRANGE("Date Sent",TODAY);


       SalesInvHeader.SETCURRENTKEY("Posting Date");


       //SalesInvHeader.SETFILTER("Posting Date",'>%1',010413D);
        ////SalesInvHeader.SETRANGE("Posting Date",010113D,050113D);
        SalesInvHeader.SETRANGE("Posting Date",WORKDATE-5,WORKDATE);
       SalesInvHeader.SETRANGE("Invoiced Mailed",FALSE);
       IF SalesInvHeader.FINDFIRST THEN BEGIN

        REPEAT BEGIN

        CLEAR(PDF);
          //MESSAGE(SalesInvHeader."No.");
       WindowIsOpen:=FALSE;

       Window.OPEN(
         Text000 +
         '#1########################\\' +
         SalesInvHeader."No.");
       WindowIsOpen := TRUE;

       IF((SalesInvHeader."Location Code"<>'SKD-PLANT') AND
          (SalesInvHeader."Location Code"<>'DRA-PLANT') AND (SalesInvHeader."Location Code"<>'HSK-PLANT')) THEN
         BEGIN
          // SalesInvHeader1.RESET;
           SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
           IF SalesInvHeader1.FINDFIRST THEN BEGIN
             //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50377);
             Report50377.SETTABLEVIEW(SalesInvHeader1);
             txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
             txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
             Report50377.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');

             //COMMIT;
           END;
         END ELSE BEGIN
           CASE SalesInvHeader."Group Code" OF
             '01':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50344);
                   Report50344.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50344.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');

                 //COMMIT;
             END;
             '02':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50316);
                   Report50316.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50316.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');

                 //COMMIT;
             END;
             '03':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50344);
                   Report50344.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50344.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');

                 //COMMIT;
             END;
             '04':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50344);
                   Report50344.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50344.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');
                 //COMMIT;
             END;
             '05':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50344);
                   Report50344.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50344.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');
                 //COMMIT;
             END;
             '06':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50344);
                   Report50344.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50344.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');

                 //COMMIT;
             END;
             '07':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50316);
                   Report50316.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50316.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');
                 //COMMIT;
             END;
             '08':
             BEGIN
               SalesInvHeader1.RESET;
               SalesInvHeader1.SETRANGE("No.",SalesInvHeader."No.");
               IF SalesInvHeader1.FINDFIRST THEN
                 //GeneratePDF_Invoice(SalesInvHeader1."No.",'C:\MailPDF',SalesInvHeader1,50344);
                   Report50344.SETTABLEVIEW(SalesInvHeader1);
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_');
                   txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'\','_');
                   Report50344.SAVEASPDF('C:\MailPDF\'+txtFile+'.pdf');
                 //COMMIT;
             END;
           END;
        END;
       END;

       UNTIL SalesInvHeader.NEXT=0;
         END;
       END;    //sash// ;
       */  //MSNK 230315
        IF WindowIsOpen THEN
            Window.CLOSE;

    end;


    procedure GeneratePDF_Invoice(txtFile: Text[100]; txtPath: Text[100]; var lrecSIH: Record "Sales Invoice Header"; intReportID: Integer)
    var
        RecSP: Record "Salesperson/Purchaser";
        RecPCH: Record "Salesperson/Purchaser";
    begin
        ReSIH.RESET;
        SaleInv.RESET;
        /*
         IF Num=1 THEN BEGIN
       MPDFDetail1.CHANGECOMPANY(ChangeComp);
       ReSIH.CHANGECOMPANY(ChangeComp);
       SaleInv.CHANGECOMPANY(ChangeComp);
       lrecSIH.CHANGECOMPANY(ChangeComp);
         END;
         */

        ReSIH.SETRANGE("No.", txtFile);
        ReSIH.SETRANGE("Invoiced Mailed", FALSE);
        IF ReSIH.FINDFIRST THEN BEGIN

            InitalizePDF;
            DocumentNo := '';
            DocumentNo := txtFile;
            txtFile := CONVERTSTR(txtFile, '/', '_');
            txtFile := CONVERTSTR(txtFile, '\', '_');
            /*clsPDFCreator.cClearCache();
            clsPDFCreatorOptions.AutosaveDirectory := txtPath;
            clsPDFCreatorOptions.AutosaveFilename := txtFile;
            clsPDFCreator.cOptions := clsPDFCreatorOptions;
            clsPDFCreator.cSaveOptions(clsPDFCreatorOptions);
            clsPDFCreator.cClearCache();
            clsPDFCreator.cDefaultPrinter := 'PDFCreator';
            clsPDFCreator.cPrinterStop := FALSE;
            REPORT.RUNMODAL(intReportID, FALSE, FALSE, lrecSIH);
            clsPDFCreatorOptions.SaveFilename(txtFile);
            SLEEP(6000);
             */
            ////SaleInv.RESET;
            SaleInv.SETRANGE("No.", DocumentNo);
            IF SaleInv.FINDFIRST THEN BEGIN
                SaleInv."Invoiced Mailed" := TRUE;
                SaleInv.MODIFY;

            END;
            //sash
            ////IF Num=1 THEN
            ////MPDFDetail1.CHANGECOMPANY(ChangeComp);
            IF NOT Customer.GET(SaleInv."Sell-to Customer No.") THEN BEGIN
                CustName := '';
                CustEmail := '';
            END
            ELSE BEGIN
                CustName := Customer.Name;
                CustEmail := Customer."E-Mail";
            END;

            MPDFDetail1.INIT;
            MPDFDetail1."Document No." := txtFile;
            MPDFDetail1."PDF Created" := TRUE;
            MPDFDetail1."PDF Mailed" := FALSE;
            MPDFDetail1."DateTime PDF Creation" := CURRENTDATETIME;
            MPDFDetail1."Sales Invoice No." := DocumentNo;
            MPDFDetail1.CustName := CustName;
            MPDFDetail1."Customer Email Id" := CustEmail;
            IF RecSP.GET(SaleInv."Salesperson Code") THEN;
            MPDFDetail1.SalesPersonEmail := RecSP."E-Mail";
            MPDFDetail1.PCHemail := Customer."PCH E-Maill ID";
            MPDFDetail1.INSERT;
            //Num:=Num+1;
        END;

    end;


    procedure InitalizePDF()
    begin
        /*
        IF ISCLEAR(clsPDFCreator) THEN
        BEGIN
          CREATE(clsPDFCreator);
          clsPDFCreator.cStart();
        END;
        IF ISCLEAR(clsPDFCreatorError) THEN
            CREATE(clsPDFCreatorError);
        clsPDFCreatorError := clsPDFCreator.cError;
        
        clsPDFCreatorOptions := clsPDFCreator.cOptions;
        
        clsPDFCreatorOptions.UseAutosave := 1;
        clsPDFCreatorOptions.UseAutosaveDirectory := 1;
        clsPDFCreatorOptions.AutosaveFormat := 0;
        clsPDFCreatorOptions.AutosaveFilename := '';
        txtDefaultPrinter := clsPDFCreator.cDefaultPrinter;
         */

    end;


    procedure ChangeComp(): Text[50]
    begin
        IF COMPANYNAME = 'Orient Bell Limited' THEN
            EXIT('Orient Bell Limited')
    end;


    procedure SendMail2()
    var
        ReSIH: Record "Sales Invoice Header";
        SalesInvHeader: Record "Sales Invoice Header";
        // SMTPMailCodeUnit: Codeunit 400;
        mycust: Record Customer;
        txtFile: Text[30];
        Leng: Integer;
        i: Integer;
        Flag: Integer;
        //SMTPSetup: Record 409;

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

        //  SMTPSetup.GET();
        //  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
        //          'donotreply@orientbell.com', 'Sales Invoice', '', TRUE);

        //SMTPMailCodeUnit.AddCC('erp@orientbell.com');
        //SMTPMailCodeUnit.AddCC('vineet.saxena@orientbell.com');
        //SMTPMailCodeUnit.AppendBody('Dear  joy');
        //SMTPMailCodeUnit.AppendBody(mycust.Name);
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);
        EmailAddressList.Add('donotreply@orientbell.com');

        BodyText := 'Please find the enclosed computer generated invoice. Against the order placed by you.';
        BodyText += '<br><br>';
        BodyText += 'This is for your records';
        BodyText += '<br><br>';
        BodyText += '<form action="http://google.com"><input type="submit" value="Go to Google" /></form>' + '  ' +
                                    '<form action="http://facebook.com"><input type="submit" value="Go to Facebook" /></form>';
        BodyText += '<br><br>';
        BodyText += 'Regards, ' + 'testName' + '<br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9100 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';



        SalesInvNo := '';// SalesInvHeader."No.";
                         // if File.Exists('C:\MailPDF\' + MPDFDetail."Document No." + '.pdf') then begin
                         // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\MailPDF\' + MPDFDetail."Document No." + '.pdf');
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);
            EmailMsg.AddAttachment(MPDFDetail."Document No." + '.pdf', 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
        // end;

    end;// 15578TEXT
        /* SalesInvNo := '';// SalesInvHeader."No.";
                 IF (EXISTS('C:\MailPDF\'+MPDFDetail."Document No."+'.pdf')) THEN BEGIN
                   SMTPMailCodeUnit.AddAttachment('C:\MailPDF\'+MPDFDetail."Document No."+'.pdf',MPDFDetail."Document No."+'.pdf');

                 END;
                 SMTPMailCodeUnit.Send();*/ // 15578

    procedure GEneratePDFsGST()
    var
        Text000: Label 'Generating';
        Text005: Label 'Report';
        //  Report50000: Report 50000;
        //  Report50377: Report 50377;
        //   Report50314: Report 50360;
        //   Report50316: Report 50383;
        Report50278: Report "GST Sales Invoice -Scrap";
        RecSP: Record "Salesperson/Purchaser";
        DirectProj: Boolean;
        Report50393: Report "GST Sales Invoice MAIN";
        Report50012: Report "GST Sales Invoice Mod 2";
        Report50156: Report "Sales Debit Note";
        Report50198: Report "GST Sales Invoice Export Nepal";
        Report50319: Report "GST Sales Invoice Nepal";
    begin
        SalesInvHeader.RESET;
        SalesInvHeader1.RESET;
        SalesInvHeader.SETCURRENTKEY("Posting Date");
        SalesInvHeader.SETRANGE("Posting Date", WORKDATE - 5, WORKDATE);
        SalesInvHeader.SETRANGE("Invoiced Mailed", FALSE);
        IF SalesInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                DocNoNew := SalesInvHeader."No.";
                CLEAR(PDF);
                CLEAR(Customer);
                IF Customer.GET(SalesInvHeader."Sell-to Customer No.") THEN BEGIN
                    WindowIsOpen := FALSE;
                    Window.OPEN(Text000 + '#1########################\\' + SalesInvHeader."No.");
                    WindowIsOpen := TRUE;
                    SalesInvHeader1.RESET;
                    SalesInvHeader1.SETRANGE("No.", SalesInvHeader."No.");
                    IF SalesInvHeader1.FINDFIRST THEN BEGIN
                        IF recCust.GET(SalesInvHeader1."Sell-to Customer No.") THEN;
                        recCustType.RESET;
                        recCustType.SETRANGE(Code, recCust."Customer Type");
                        IF recCustType.FINDFIRST THEN BEGIN
                            //         IF recCustType."Hide Discount" = TRUE OR (recCust."State Code" = '19') THEN BEGIN Discount Hide
                            IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" = '') THEN BEGIN
                                IF SalesInvHeader1."Order No." = '' THEN BEGIN
                                    CLEAR(Report50319);
                                    Report50319.SETTABLEVIEW(SalesInvHeader1);
                                    txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                    // Report50319.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                END ELSE BEGIN
                                    IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" = '') THEN BEGIN
                                        CLEAR(Report50319);
                                        Report50319.SETTABLEVIEW(SalesInvHeader1);
                                        txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                        //txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_'); //Kulbhushan
                                        // Report50319.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                    END;
                                    IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" <> '') THEN BEGIN
                                        CLEAR(Report50319);
                                        Report50319.SETTABLEVIEW(SalesInvHeader1);
                                        txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                        //txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_'); //Kulbhushan
                                        // Report50319.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                    END ELSE BEGIN
                                        CLEAR(Report50393);
                                        Report50393.SETTABLEVIEW(SalesInvHeader1);
                                        txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                        //txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_'); //Kulbhushan
                                        // Report50393.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                    END;
                                END;
                            END ELSE BEGIN
                                IF SalesInvHeader1."Order No." = '' THEN BEGIN
                                    CLEAR(Report50156);
                                    Report50156.SETTABLEVIEW(SalesInvHeader1);
                                    txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                    // Report50156.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                END ELSE BEGIN
                                    CLEAR(Report50393);
                                    IF NOT SalesInvHeader1.ISEMPTY THEN BEGIN
                                        Report50393.SETTABLEVIEW(SalesInvHeader1);
                                        txtFile := CONVERTSTR(SalesInvHeader1."No.", '/', '_');
                                        //txtFile :=  CONVERTSTR(SalesInvHeader1."No.",'/','_'); //Kulbhushan
                                        // Report50393.SAVEASPDF('C:\MailPDF\' + txtFile + '.pdf');
                                    END;
                                END;
                            END;
                        END;
                        SaleInv.RESET;
                        SaleInv.SETRANGE("No.", SalesInvHeader."No.");
                        IF SaleInv.FINDFIRST THEN BEGIN
                            SaleInv."Invoiced Mailed" := TRUE;
                            SaleInv.MODIFY;
                        END;
                    END;
                END;
                IF NOT Customer.GET(SaleInv."Sell-to Customer No.") THEN BEGIN
                    CustName := '';
                    CustEmail := '';
                END ELSE BEGIN
                    CustName := Customer.Name;
                    IF Customer."E-Mail" = '' THEN
                        CustEmail := 'donotreply@orientbell.com'
                    ELSE
                        CustEmail := Customer."E-Mail";
                END;
                MPDFDetail1.INIT;
                MPDFDetail1."Document No." := txtFile;
                MPDFDetail1."PDF Created" := TRUE;
                MPDFDetail1."PDF Mailed" := FALSE;
                MPDFDetail1."DateTime PDF Creation" := CURRENTDATETIME;
                MPDFDetail1."Sales Invoice No." := DocNoNew;
                MPDFDetail1.CustName := CustName;
                MPDFDetail1."Customer Email Id" := CustEmail;
                IF RecSP.GET(SaleInv."Salesperson Code") THEN;
                MPDFDetail1.SalesPersonEmail := RecSP."E-Mail";
                MPDFDetail1.PCHemail := Customer."PCH E-Maill ID";
                MPDFDetail1.INSERT;
            UNTIL SalesInvHeader.NEXT = 0;
        END;
        IF WindowIsOpen THEN
            Window.CLOSE;
    end;
}

