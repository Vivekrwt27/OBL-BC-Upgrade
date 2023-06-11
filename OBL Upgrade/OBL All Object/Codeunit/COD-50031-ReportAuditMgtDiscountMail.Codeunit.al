codeunit 50031 "Report Audit Mgt/Discount Mail"
{

    trigger OnRun()
    begin
    end;

    var
        ReportAuditTrial1: Record "Vendor Requisition";
        TextButtonStart: Label '<a href="#" onclick="window.open(''http://14.140.109.181/mailapproval/?ref=';
        TextButtonEnd: Label ''')">Click me</a>';
        AppEntry: Record "Approval Entry";
        RecState: Record State;
        RecItem: Record Item;


    procedure CreateAudit(ReportID: Integer)
    var
        ReportAuditTrial: Record "Vendor Requisition";
        EntryNo: Integer;
    begin
        /*ReportAuditTrial1.RESET;
        ReportAuditTrial1.INIT;
        ReportAuditTrial1."Entry No." := GetLastEntry;
        ReportAuditTrial1."User ID"   := USERID;
        ReportAuditTrial1."Report ID" := ReportID;
        ReportAuditTrial1."Run Date"  := CURRENTDATETIME;
        ReportAuditTrial1.INSERT;
         */

    end;


    procedure GetLastEntry() EntryNo: Integer
    var
        ReportAuditTrial: Record "Vendor Requisition";
    begin
        /*ReportAuditTrial.RESET;
        IF ReportAuditTrial.FINDLAST THEN
          EntryNo := ReportAuditTrial."Entry No." +1
        ELSE
          EntryNo := 1;
         */

    end;


    procedure CreateMailForPO(SalesHeader: Record "Sales Header"; SPCode: Code[20])
    var
        Text50000: Label 'Dear      ';
        Text50001: Label 'Addition Discount Approval';
        Text50002: Label ' Against the order placed for below Vendor. <br/> <br/> ';
        Text50003: Label 'This is for your records. Kindly acknowledge the receipt.<br/> <br/> ';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Customer Code :-  ';
        Text50012: Label 'Customer Name :-  ';
        Text50013: Label 'Amount to Customer :-  ';
        Text50014: Label 'Order Date :-  ';
        Text50015: Label 'order No :-  ';
        Text50016: Label 'Quantity in Carton :-  ';
        Text50017: Label 'Transporter Name.:-  ';
        Text50018: Label 'Truck No :-  ';
        Text50019: Label 'Order Date :-  ';
        Text50020: Label 'Order No. :-  ';
        Text50021: Label 'System have not PCH e-Mail ID, So Informaiton can not sent to PCH Head';
        //   SMTPMail: Codeunit 400;
        "------------------------": Label 'MS-PB';
        Text59999: Label '<html>';
        Text60000: Label '<Table>';
        Text60001: Label '<TR Border=4>';
        Text60002: Label '<TD  width=200 Align=Left>';
        Text60003: Label '</TD>';
        Text60004: Label '</TR>';
        Text60005: Label '</Table>';
        Text60006: Label '</html>';
        SrNo: Integer;
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
        Text50027: Label '<table border="1" width="70%">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50033: Label 'Dear Sir,';
        RecCustomer: Record Customer;
        //     SMTPMailSetup: Record 409;
        CompInfo: Record "Company Information";
        Text50034: Label '" We have received the order for following products & the same is sent to you for Discount approvals details as given below:  "';
        Text50035: Label ' Branch vide Stock Transfer Note No. ';
        Text50036: Label ' Dated ';
        RecSalesLine: Record "Sales Line";
        Text50037: Label 'Customer No: ';
        Text50038: Label 'Name: ';
        Text50039: Label 'Regards,';
        Text50040: Label 'Orient Bells Limited';
        Text50041: Label '<TD  width=5 Align=Center>';
        SalesPersons: Record "Salesperson/Purchaser";
        RecUserSetup: Record "User Setup";
    begin
        SalesHeader.CALCFIELDS(SalesHeader."D1 Amount", SalesHeader."D2 Amount", SalesHeader."D3 Amount", SalesHeader."D4 Amount", SalesHeader."S1 Amount", "Qty in Sq. Mt.");
        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        IF SalesPersons.GET(SPCode) THEN
            SalesPersons.TESTFIELD("E-Mail");
        /* 15578  IF SalesPersons."E-Mail" <> '' THEN BEGIN
              SMTPMailSetup.GET;
              SMTPMailSetup.TESTFIELD("User ID");
              SrNo := 1;
              CLEAR(SMTPMail);
              //    SMTPMail.CreateMessage('Discount Approvals '+RecCustomer.Name+' - '+RecCustomer.City+' - '+RecCustomer."State Code",SMTPMailSetup."User ID",SalesPersons."E-Mail",Text50001,'',TRUE);
              SMTPMail.CreateMessage('Discount Approvals', SMTPMailSetup."User ID", 'virendra.kumar@mindshell.info', Text50001, '', TRUE);
              SMTPMail.AddCC('kulwant@mindshell.info');
              SMTPMail.AddCC('erp@orientbell.com');
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50033 + Text60003);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50034);

              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Customer Name : ' + RecCustomer.Name);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Customer City : ' + RecCustomer.City);
              SMTPMail.AppendBody(Text60011);
              IF RecState.GET(RecCustomer."State Code") THEN
                  SMTPMail.AppendBody('Customer State : ' + RecState.Description);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Payment Terms : ' + RecCustomer."Payment Terms Code");
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Order Qty.In Sq.Mt : ' + FORMAT(SalesHeader."Qty in Sq. Mt."));
              SMTPMail.AppendBody(Text60011);
              RecCustomer.CALCFIELDS(Balance);
              SMTPMail.AppendBody('Total Outstanding : ' + FORMAT(RecCustomer.Balance));
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Last Year Sale Amt. : ');



              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Remarks :-');
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60011);
              AppEntry.RESET;
              AppEntry.SETRANGE("Table ID", 36);
              AppEntry.SETRANGE("Document No.", SalesHeader."No.");
              AppEntry.SETRANGE(Status, AppEntry.Status::Approved);
              IF AppEntry.FINDFIRST THEN BEGIN
                  REPEAT
                      IF AppEntry."Comment Text" <> '' THEN BEGIN
                          IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                              SMTPMail.AppendBody(SalesPersons.Name + ' - ' + AppEntry."Comment Text");
                              SMTPMail.AppendBody(Text60011);
                          END;
                      END;
                  UNTIL AppEntry.NEXT = 0;
              END;

              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'Qty.' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'UOM' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'Qty. Sq. Mtr.' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'Buyer''s Price ' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'MRP Price ' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'Price Group' + Text60013 + Text60003);

              IF SalesHeader."D1 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'D-1' + Text60013 + Text60003);

              IF SalesHeader."D2 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'D-2' + Text60013 + Text60003);

              IF SalesHeader."D3 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'D-3' + Text60013 + Text60003);

              IF SalesHeader."D4 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'D-4' + Text60013 + Text60003);

              IF SalesHeader."S1 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'S-1' + Text60013 + Text60003);

              SMTPMail.AppendBody(Text60004);
              RecSalesLine.RESET;
              RecSalesLine.SETRANGE("Document No.", SalesHeader."No.");
              IF RecSalesLine.FINDFIRST THEN BEGIN
                  REPEAT
                      IF RecItem.GET(RecSalesLine."No.") THEN;
                      SMTPMail.AppendBody(Text50026 + Text50030 + FORMAT(RecSalesLine.Description) + Text60003);
                      SMTPMail.AppendBody(Text50031 + RecItem."Description 2" + Text60003);
                      SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.Quantity) + Text60003);
                      SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine."Unit of Measure") + Text60003);
                      SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine."Quantity in Sq. Mt.") + Text60003);
                      SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine."Buyer's Price") + Text60003);
                      // 15578    SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine."MRP Price") + Text60003);
                      SMTPMail.AppendBody(Text50041 + FORMAT(RecItem."Item Classification") + Text60003);
                      IF SalesHeader."D1 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D1) + Text60003);
                      IF SalesHeader."D2 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D2) + Text60003);
                      IF SalesHeader."D3 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D3) + Text60003);
                      IF SalesHeader."D4 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D4) + Text60003);
                      IF SalesHeader."S1 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.S1) + Text60003);

                      SMTPMail.AppendBody(Text60004);
                      SrNo += 1;
                  UNTIL RecSalesLine.NEXT = 0;
              END;
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50039 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60011);
              AppEntry.RESET;
              AppEntry.SETRANGE("Table ID", 36);
              AppEntry.SETRANGE("Document No.", SalesHeader."No.");
              //    AppEntry.SETRANGE(Status,AppEntry.Status::Approved);
              IF AppEntry.FINDFIRST THEN;
              IF RecUserSetup.GET(AppEntry."Sender ID") THEN
                  SMTPMail.AppendBody('[' + RecUserSetup."User ID" + ']');

              SMTPMail.AppendBody(Text60004);


              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50040 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);

              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text59999);
              SMTPMail.AppendBody(Text60000);
              SMTPMail.AppendBody(Text60001);
              SMTPMail.AppendBody(Text50024 + Text50025 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60011);

              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(getApprovalLink(SalesHeader."No.", 1));


              SMTPMail.Send;
              //MESSAGE(Text50022);
          END*/
        //END;

    end;


    procedure getApprovalLink(DocNo: Code[20]; TypeInt: Integer): Text
    var
        AppEntry: Record "Approval Entry";
        GUIDTXT: Text[100];
        TxtLink: Text[250];
    begin
        AppEntry.RESET;
        AppEntry.SETRANGE("Table ID", 36);
        AppEntry.SETRANGE("Document No.", DocNo);
        AppEntry.SETRANGE(Status, AppEntry.Status::Created);
        AppEntry.SETFILTER("GUID Key", '<>%1', '{00000000-0000-0000-0000-000000000000}');
        IF AppEntry.FINDFIRST THEN BEGIN
            GUIDTXT := AppEntry."GUID Key";
        END;

        TxtLink := 'http://14.140.109.190/mailapproval/?ref=' + GUIDTXT;
        EXIT(TxtLink);
    end;


    procedure CreateMailForPORejection(SalesHeader: Record "Sales Header"; SPCode: Code[20])
    var
        Text50000: Label 'Dear      ';
        Text50001: Label 'Addition Discount Approval';
        Text50002: Label ' Against the order placed for below Vendor. <br/> <br/> ';
        Text50003: Label 'This is for your records. Kindly acknowledge the receipt.<br/> <br/> ';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Customer Code :-  ';
        Text50012: Label 'Customer Name :-  ';
        Text50013: Label 'Amount to Customer :-  ';
        Text50014: Label 'Order Date :-  ';
        Text50015: Label 'order No :-  ';
        Text50016: Label 'Quantity in Carton :-  ';
        Text50017: Label 'Transporter Name.:-  ';
        Text50018: Label 'Truck No :-  ';
        Text50019: Label 'Order Date :-  ';
        Text50020: Label 'Order No. :-  ';
        Text50021: Label 'System have not PCH e-Mail ID, So Informaiton can not sent to PCH Head';
        //   SMTPMail: Codeunit 400;
        "------------------------": Label 'MS-PB';
        Text59999: Label '<html>';
        Text60000: Label '<Table>';
        Text60001: Label '<TR Border=4>';
        Text60002: Label '<TD  width=200 Align=Left>';
        Text60003: Label '</TD>';
        Text60004: Label '</TR>';
        Text60005: Label '</Table>';
        Text60006: Label '</html>';
        SrNo: Integer;
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
        Text50027: Label '<table border="1" width="70%">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50033: Label 'Dear Sir,';
        RecCustomer: Record Customer;
        //    SMTPMailSetup: Record 409;
        CompInfo: Record "Company Information";
        Text50034: Label '" We have received the order for following products & the same is sent to you for Discount approvals   "';
        Text50035: Label ' Branch vide Stock Transfer Note No. ';
        Text50036: Label ' Dated ';
        RecSalesLine: Record "Sales Line";
        Text50037: Label 'Customer No: ';
        Text50038: Label 'Name: ';
        Text50039: Label 'Regards,';
        Text50040: Label 'Orient Bells Limited';
        Text50041: Label '<TD  width=5 Align=Center>';
        SalesPersons: Record "Salesperson/Purchaser";
    begin
        SalesHeader.CALCFIELDS(SalesHeader."D1 Amount", SalesHeader."D2 Amount", SalesHeader."D3 Amount", SalesHeader."D4 Amount");
        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        IF SalesPersons.GET(SPCode) THEN
            SalesPersons.TESTFIELD("E-Mail");
        /* 15578  IF SalesPersons."E-Mail" <> '' THEN BEGIN
              SMTPMailSetup.GET;
              SMTPMailSetup.TESTFIELD("User ID");
              SrNo := 1;
              CLEAR(SMTPMail);
              SMTPMail.CreateMessage('Discount Approvals -Rejection', SMTPMailSetup."User ID", SalesPersons."E-Mail", Text50001, '', TRUE);
              //SMTPMail.AddCC('kulwant@mindshell.info');
              //SMTPMail.AddCC('erp@orientbell.com');
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50033 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50037 + RecCustomer."No." + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50038 + RecCustomer.Name + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text59999);
              SMTPMail.AppendBody(Text60000);
              SMTPMail.AppendBody(Text60001);
              SMTPMail.AppendBody(Text50024 + Text50034);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
              SMTPMail.AppendBody(Text50041 + Text60012 + 'Qty.' + Text60013 + Text60003);
              IF SalesHeader."D1 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'Discount-1' + Text60013 + Text60003);

              IF SalesHeader."D2 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'Discount-2' + Text60013 + Text60003);

              IF SalesHeader."D3 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'Discount-3' + Text60013 + Text60003);

              IF SalesHeader."D4 Amount" <> 0 THEN
                  SMTPMail.AppendBody(Text50041 + Text60012 + 'Discount-4' + Text60013 + Text60003);

              SMTPMail.AppendBody(Text60004);
              RecSalesLine.RESET;
              RecSalesLine.SETRANGE("Document No.", SalesHeader."No.");
              IF RecSalesLine.FINDFIRST THEN BEGIN
                  REPEAT
                      SMTPMail.AppendBody(Text50026 + Text50030 + FORMAT(RecSalesLine."No.") + Text60003);
                      SMTPMail.AppendBody(Text50031 + RecSalesLine.Description + Text60003);
                      SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.Quantity) + Text60003);
                      IF SalesHeader."D1 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D1) + Text60003);
                      IF SalesHeader."D2 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D2) + Text60003);
                      IF SalesHeader."D3 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D3) + Text60003);
                      IF SalesHeader."D4 Amount" <> 0 THEN
                          SMTPMail.AppendBody(Text50041 + FORMAT(RecSalesLine.D4) + Text60003);
                      SMTPMail.AppendBody(Text60004);
                      SrNo += 1;
                  UNTIL RecSalesLine.NEXT = 0;
              END;
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50039 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text50024 + Text50040 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);

              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text59999);
              SMTPMail.AppendBody(Text60000);
              SMTPMail.AppendBody(Text60001);
              SMTPMail.AppendBody(Text50024 + Text50025 + Text60003);
              SMTPMail.AppendBody(Text60004);
              SMTPMail.AppendBody(Text60005);
              SMTPMail.AppendBody(Text60006);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody(Text60011);
              SMTPMail.AppendBody('Remarks :-');
              SMTPMail.AppendBody(Text60011);
              AppEntry.RESET;
              AppEntry.SETRANGE("Table ID", 36);
              AppEntry.SETRANGE("Document No.", SalesHeader."No.");
              AppEntry.SETRANGE(Status, AppEntry.Status::Rejected);
              IF AppEntry.FINDFIRST THEN BEGIN
                  REPEAT
                      IF AppEntry."Comment Text" <> '' THEN BEGIN
                          IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                              SMTPMail.AppendBody(SalesPersons.Name + ' - ' + AppEntry."Comment Text");
                              SMTPMail.AppendBody(Text60011);
                          END;
                      END;
                  UNTIL AppEntry.NEXT = 0;
              END;

              SMTPMail.AppendBody(Text60011);
              //    SMTPMail.AppendBody(getApprovalLink(SalesHeader."No.",1));


              SMTPMail.Send;
              //MESSAGE(Text50022);
          END*/ // 15578
                //END;
    end;
}

