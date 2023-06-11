codeunit 50008 "QD Test, PDF Creation & Email"
{
    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Approval Entry" = rimd;

    trigger OnRun()
    begin
        //IF SalesInvHdr.FIND('-') THEN
        //IF SalesInvHdr.FINDFIRST THEN
        //MESSAGE(FORMAT(SalesInvHdr.COUNT));
    end;

    var
        CompanyInfo: Record "Company Information";
        DiscPradeep: Record "QD Buffer Table";
        "-MS-AN- Variables for PDF": Integer;
        txtDefaultPrinter: Text[100];
        SalesInvHdr: Record "Sales Invoice Header";
        Text50000: Label 'Dear      ';
        Text50001: Label 'Enclosed please find the below information from computer generated invoice.';
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

        Text50027: Label 'Enclosed please find the computer generated invoice :';
        Text50028: Label ' against the order placed by you. <br/> <br/> ';
        Text50029: Label 'This is for your records.<br/> <br/> ';
        Text50030: Label ' / ';
        Text50031: Label 'Quantity in Sq.Mt :-  ';
        AppEntry: Record "Approval Entry";
        RecState: Record State;
        RecItem: Record Item;
        ApprovalEntry: Record "Approval Entry";
        PurchaseHeader: Record "Purchase Header";
        MailMgt: Codeunit "QD Test, PDF Creation & Email";
        SalesHeader: Record "Sales Header";
        ApprovalEntryPAC: Record "Approval Entry";
        RecUserSetup: Record "User Setup";
        SMSMgt: Codeunit "SMS Sender - Due Date";
        IndentRelease: Codeunit 50006;
        EmailN: Text[100];
        buyprice: Decimal;
        Costv: Decimal;
        Saleeval: Decimal;
        margin: Decimal;
        Vmargin: Decimal;
        tVmargin: Decimal;
        Tmargin: Decimal;
        TSaleeval: Decimal;
        TotalCostVal: Decimal;
        PurchaseLine: Integer;
    //    SMTPMailCodeUnit: Codeunit 400;


    procedure TestQD(SalesHdr: Record "Sales Header"; SalesLine: Record "Sales Line"): Code[20]
    var
        TmpDiscPradeep: Record "QD Buffer Table" temporary;
        CustGroup: Record "Customer Group";
        BlnInsert: Boolean;
        DiscLine: Record "Discount Line";
        EntryNo: Integer;
        PostDate: Date;
        DiscHdr: Record "Discount Header";
        OfferCode: Code[20];
        CustPt: Integer;
        ItemPt: Integer;
        FinalOffer: Code[20];
        DiscHdr1: Record "Discount Header";
    begin
        //Create HEader
        CompanyInfo.GET;

        IF SalesHdr."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SalesHdr."Posting Date";


        EntryNo := 1;
        CLEAR(TmpDiscPradeep);
        WITH SalesHdr DO BEGIN
            //MS-PB BEGIN
            // IF CompanyInfo."QD Testing" THEN BEGIN
            //  DiscPradeep.RESET;
            //  DiscPradeep.SETRANGE("Document Type","Document Type");
            // DiscPradeep.SETRANGE("Document No.","No.");
            //TmpDiscPradeep.SETFILTER("Document Line No.",'%1',0);
            //IF DiscPradeep.FINDFIRST THEN
            // DiscPradeep.DELETEALL;
            //  END;
            TmpDiscPradeep.INIT;
            CustGroup.RESET;
            CustGroup.SETCURRENTKEY(Status, "Valid From", "Valid To", All);
            CustGroup.SETRANGE(Status, CustGroup.Status::Enable);
            CustGroup.SETFILTER("Valid From", '<=%1', PostDate);
            CustGroup.SETFILTER("Valid To", '>=%1', PostDate);
            CustGroup.SETFILTER(All, '%1', TRUE);
            //CustGroup.SETRANGE("Include/Exclude",CustGroup."Include/Exclude"::Include);
            IF CustGroup.FINDFIRST THEN BEGIN
                REPEAT
                    BlnInsert := FALSE;
                    IF (CustGroup."Include/Exclude" = CustGroup."Include/Exclude"::Exclude) THEN
                        BlnInsert := TRUE;

                    //   GetEntryNo;
                    TmpDiscPradeep."Offer Code" := CustGroup."No.";
                    TmpDiscPradeep.Type := TmpDiscPradeep.Type::Sales;
                    TmpDiscPradeep."Document Type" := "Document Type";
                    TmpDiscPradeep."Document No." := "No.";
                    TmpDiscPradeep."Document Line No." := 0;
                    TmpDiscPradeep."Customer Entry" := TRUE;
                    TmpDiscPradeep."Entry No" := EntryNo;
                    TmpDiscPradeep."Group Code" := FORMAT(CustGroup.Code);
                    CASE CustGroup."Group Type" OF
                        CustGroup."Group Type"::State:
                            BEGIN
                                TmpDiscPradeep."Group Type" := 5;
                                IF CustGroup.All THEN
                                    TmpDiscPradeep."Group Code" := State;

                                IF (TmpDiscPradeep."Group Code" = State) THEN
                                    TmpDiscPradeep.Marks := GiveCustomerMarks(CustGroup, State)
                                ELSE
                                    TmpDiscPradeep.Marks := 0;
                            END;
                        CustGroup."Group Type"::"Customer Type":
                            BEGIN
                                TmpDiscPradeep."Group Type" := 6;
                                IF CustGroup.All THEN
                                    TmpDiscPradeep."Group Code" := "Customer Type";
                                IF (TmpDiscPradeep."Group Code" = "Customer Type") THEN
                                    TmpDiscPradeep.Marks := GiveCustomerMarks(CustGroup, "Customer Type")
                                ELSE
                                    TmpDiscPradeep.Marks := 0;
                            END;
                        CustGroup."Group Type"::Customer:
                            BEGIN
                                TmpDiscPradeep."Group Type" := 7;
                                IF CustGroup.All THEN
                                    TmpDiscPradeep."Group Code" := "Sell-to Customer No.";
                                IF (TmpDiscPradeep."Group Code" = "Sell-to Customer No.") THEN
                                    TmpDiscPradeep.Marks := GiveCustomerMarks(CustGroup, "Sell-to Customer No.")
                                ELSE
                                    TmpDiscPradeep.Marks := 0;
                            END;
                    END;

                    EntryNo += 1;
                    //IF TmpDiscPradeep.Marks<>0 THEN
                    TmpDiscPradeep.INSERT;
                UNTIL CustGroup.NEXT = 0;
            END;
        END;

        //Create Applicable Offer Line
        WITH SalesLine DO BEGIN

            //TmpDiscPradeep.INIT;
            //TmpDiscPradeep.RESET;
            //CLEAR(TmpDiscPradeep);
            DiscLine.RESET;
            DiscLine.SETCURRENTKEY(Status, All, "Valid From", "Valid To");
            DiscLine.SETRANGE(Status, DiscLine.Status::Enable);
            DiscLine.SETFILTER("Valid From", '<=%1', PostDate);
            DiscLine.SETFILTER("Valid To", '>=%1', PostDate);
            DiscLine.SETFILTER(All, '%1', TRUE);
            //DiscLine.SETRANGE("Include/Exclude",DiscLine."Include/Exclude"::Include);
            IF DiscLine.FINDFIRST THEN BEGIN
                REPEAT
                    BlnInsert := FALSE;
                    IF (DiscLine."Include/Exclude" = DiscLine."Include/Exclude"::Exclude) THEN
                        BlnInsert := TRUE;

                    TmpDiscPradeep."Offer Code" := DiscLine."Document No.";
                    TmpDiscPradeep.Type := TmpDiscPradeep.Type::Sales;
                    TmpDiscPradeep."Document Type" := "Document Type";
                    TmpDiscPradeep."Document No." := "Document No.";
                    TmpDiscPradeep."Document Line No." := "Line No.";
                    TmpDiscPradeep."Customer Entry" := FALSE;
                    TmpDiscPradeep."Entry No" := EntryNo;
                    TmpDiscPradeep."Group Code" := FORMAT(DiscLine.Code);
                    TmpDiscPradeep.All := DiscLine.All;
                    CASE DiscLine."Group Type" OF
                        DiscLine."Group Type"::"Item Type":
                            BEGIN
                                TmpDiscPradeep."Group Type" := 1;
                                IF DiscLine.All THEN
                                    TmpDiscPradeep."Group Code" := "Item Type";
                                IF TmpDiscPradeep."Group Code" = "Item Type" THEN
                                    TmpDiscPradeep.Marks := GiveItemMarks(DiscLine, "Item Type")
                                ELSE
                                    TmpDiscPradeep.Marks := 0;
                            END;
                        DiscLine."Group Type"::Size:
                            BEGIN
                                TmpDiscPradeep."Group Type" := 2;
                                IF DiscLine.All THEN
                                    TmpDiscPradeep."Group Code" := "Size Code";
                                IF TmpDiscPradeep."Group Code" = "Size Code" THEN
                                    TmpDiscPradeep.Marks := GiveItemMarks(DiscLine, "Size Code")
                                ELSE
                                    TmpDiscPradeep.Marks := 0;

                            END;
                        DiscLine."Group Type"::"Tile Group":
                            BEGIN
                                TmpDiscPradeep."Group Type" := 3;
                                IF DiscLine.All THEN
                                    //TmpDiscPradeep."Group Code" := ""Group Code"";//OLD
                                    TmpDiscPradeep."Group Code" := "Type Catogery Code"; //NEW MSBS.Rao
                                                                                         //IF TmpDiscPradeep."Group Code" = "Group Code" THEN //OLD
                                IF TmpDiscPradeep."Group Code" = "Type Catogery Code" THEN   //NEW MSBS.Rao
                                                                                             //TmpDiscPradeep.Marks:=GiveItemMarks(DiscLine,"Group Code")
                                    TmpDiscPradeep.Marks := GiveItemMarks(DiscLine, "Type Catogery Code")
                                ELSE
                                    TmpDiscPradeep.Marks := 0;
                            END;

                        DiscLine."Group Type"::Item:
                            BEGIN
                                TmpDiscPradeep."Group Type" := 4;
                                IF DiscLine.All THEN
                                    TmpDiscPradeep."Group Code" := "No.";
                                IF TmpDiscPradeep."Group Code" = "No." THEN
                                    TmpDiscPradeep.Marks := GiveItemMarks(DiscLine, "No.")
                                ELSE
                                    TmpDiscPradeep.Marks := 0;
                            END;
                    END;
                    /*
                    IF BlnInsert THEN
                      TmpDiscPradeep.Marks:=-1;
                      */
                    //Pradeep Comment
                    EntryNo += 1;
                    // IF TmpDiscPradeep.Marks<>0 THEN
                    TmpDiscPradeep.INSERT;

                UNTIL DiscLine.NEXT = 0;
            END;

            DiscHdr.RESET;
            DiscHdr.SETRANGE(Status, CustGroup.Status::Enable);
            DiscHdr.SETFILTER("Valid From", '<=%1', PostDate);
            DiscHdr.SETFILTER("Valid To", '>=%1', PostDate);

            IF DiscHdr.FINDFIRST THEN BEGIN
                REPEAT
                    TmpDiscPradeep.RESET;
                    TmpDiscPradeep.SETCURRENTKEY(Type, "Document Type", "Document No.", "Document Line No.", "Offer Code");
                    TmpDiscPradeep.SETRANGE(Type, TmpDiscPradeep.Type::Sales);
                    TmpDiscPradeep.SETRANGE("Document Type", "Document Type");
                    TmpDiscPradeep.SETRANGE("Document No.", "Document No.");
                    TmpDiscPradeep.SETRANGE("Offer Code", DiscHdr."No.");
                    TmpDiscPradeep.SETRANGE("Customer Entry", TRUE);
                    IF TmpDiscPradeep.FINDFIRST THEN BEGIN
                        TmpDiscPradeep.CALCSUMS(Marks);
                        IF TmpDiscPradeep.Marks <> 3 THEN
                            TmpDiscPradeep.RESET;
                        TmpDiscPradeep.SETRANGE("Offer Code", DiscHdr."No.");
                        TmpDiscPradeep.SETRANGE("Document No.", "Document No.");
                        TmpDiscPradeep.SETRANGE("Document Line No.", "Line No.");
                        TmpDiscPradeep.SETRANGE("Customer Entry", TRUE);
                        TmpDiscPradeep.CALCSUMS(Marks);
                        TmpDiscPradeep.SETFILTER(Marks, '<>%1', 3);
                        IF TmpDiscPradeep.FINDFIRST THEN
                            //Pradeep Comment
                            TmpDiscPradeep.DELETEALL;
                    END;
                UNTIL DiscHdr.NEXT = 0;
            END;
            /*
  DiscHdr.RESET;
  IF DiscHdr.FINDFIRST THEN BEGIN
    REPEAT
      TmpDiscPradeep.RESET;
      TmpDiscPradeep.SETCURRENTKEY(Type,"Document Type","Document No.","Document Line No.","Offer Code");
      TmpDiscPradeep.SETRANGE(Type,TmpDiscPradeep.Type::Sales);
      TmpDiscPradeep.SETRANGE("Document Type", "Document Type");
      TmpDiscPradeep.SETRANGE("Document No.","Document No.");
      TmpDiscPradeep.SETRANGE("Document Line No.","Line No.");
      TmpDiscPradeep.SETRANGE("Offer Code",DiscHdr."No.");
      TmpDiscPradeep.SETRANGE("Customer Entry",FALSE);
      IF TmpDiscPradeep.FINDFIRST THEN BEGIN
       TmpDiscPradeep.CALCSUMS(Marks);
       IF TmpDiscPradeep.Marks <> 4 THEN BEGIN
         TmpDiscPradeep.RESET;
         TmpDiscPradeep.SETRANGE("Offer Code",DiscHdr."No.");
         TmpDiscPradeep.SETRANGE("Document No.","Document No.");
         TmpDiscPradeep.SETRANGE("Document Line No.","Line No.");
         TmpDiscPradeep.SETRANGE("Customer Entry",FALSE);
         IF TmpDiscPradeep.FINDFIRST THEN
           //Pradeep Comment
           TmpDiscPradeep.DELETEALL;
       END;
      END;
    UNTIL DiscHdr.NEXT=0;
  END;
             */

            // IF CompanyInfo."QD Testing" THEN BEGIN
            //  TmpDiscPradeep.RESET;
            // IF TmpDiscPradeep.FINDFIRST THEN BEGIN
            // REPEAT
            //DiscPradeep.INIT;
            //DiscPradeep.TRANSFERFIELDS(TmpDiscPradeep);
            //DiscPradeep.INSERT;
            //UNTIL TmpDiscPradeep.NEXT=0;
            //END;
            // END;

            //CustPt:=0;
            //ItemPt:=0;


            TmpDiscPradeep.RESET;
            TmpDiscPradeep.SETCURRENTKEY(Type, "Document Type", "Document No.", "Offer Code");
            TmpDiscPradeep.SETRANGE("Document No.", "Document No.");
            TmpDiscPradeep.SETFILTER("Document Line No.", '%1|%2', 0, "Line No.");
            TmpDiscPradeep.SETFILTER(Marks, '<>%1', 0);
            IF TmpDiscPradeep.FINDFIRST THEN BEGIN
                REPEAT
                    IF OfferCode = '' THEN
                        OfferCode := TmpDiscPradeep."Offer Code";

                    IF OfferCode = TmpDiscPradeep."Offer Code" THEN BEGIN
                        IF TmpDiscPradeep."Customer Entry" THEN
                            CustPt += TmpDiscPradeep.Marks
                        ELSE
                            ItemPt += TmpDiscPradeep.Marks;
                    END ELSE BEGIN
                        OfferCode := TmpDiscPradeep."Offer Code";
                        IF TmpDiscPradeep."Customer Entry" THEN
                            CustPt := 1
                        ELSE
                            ItemPt := 1;
                        IF TmpDiscPradeep."Group Type" = TmpDiscPradeep."Group Type" THEN
                            ItemPt := 0;
                    END;
                    //      MESSAGE('c%1=i%2=off%3=fmoff%4=gt%5=gc%6',CustPt,ItemPt,FinalOffer,TmpDiscPradeep."Offer Code",TmpDiscPradeep."Group Type",
                    //     TmpDiscPradeep."Group Code");
                    IF (CustPt + ItemPt) > 6 THEN
                        FinalOffer := TmpDiscPradeep."Offer Code"
                    ELSE
                        FinalOffer := '';
                    IF DiscHdr1.GET(FinalOffer) THEN
                        IF DiscHdr1.Status = DiscHdr1.Status::Disable THEN
                            FinalOffer := ''
                        ELSE
                            FinalOffer := FinalOffer;
                UNTIL (FinalOffer <> '') OR (TmpDiscPradeep.NEXT = 0);
            END;
        END;
        //MESSAGE(FinalOffer);
        EXIT(FinalOffer);

    end;


    procedure GiveCustomerMarks(CustGroup1: Record "Customer Group"; CusCode: Code[20]) Abc: Decimal
    var
        CG: Record "Customer Group";
    begin
        CG.RESET;
        CG.SETRANGE("No.", CustGroup1."No.");
        CG.SETRANGE("Group Type", CustGroup1."Group Type");
        CG.SETFILTER(Code, '%1', CusCode);
        CG.SETRANGE(All, FALSE);
        IF CG.FINDFIRST THEN BEGIN
            IF CG."Include/Exclude" = CG."Include/Exclude"::Exclude THEN
                Abc := 0;
            IF CG."Include/Exclude" = CG."Include/Exclude"::Include THEN
                Abc := 1;
            //IF CG."Group Type"=CustGroup1."Group Type"::"Customer Type" THEN
            //MESSAGE('%1-%2',CG."No.",CusCode);
        END ELSE BEGIN
            // IF CustGroup1."Group Type"=CustGroup1."Group Type"::"Customer Type" THEN
            // MESSAGE('hi %1-%2-%3',CustGroup1."Line No.",CustGroup1."Include/Exclude",CustGroup1."No.");

            IF CustGroup1."Include/Exclude" = CustGroup1."Include/Exclude"::Exclude THEN
                Abc := 0;
            IF CustGroup1."Include/Exclude" = CustGroup1."Include/Exclude"::Include THEN
                Abc := 1;

        END;
        EXIT(Abc);
    end;


    procedure GiveItemMarks(ItemGroup1: Record "Discount Line"; "Code": Code[20]) Abc: Decimal
    var
        IG: Record "Discount Line";
    begin

        IG.RESET;
        IG.SETRANGE("Document No.", ItemGroup1."Document No.");
        IG.SETRANGE("Group Type", ItemGroup1."Group Type");
        IG.SETFILTER(Code, '%1', Code);
        IG.SETRANGE(All, FALSE);
        IF IG.FINDFIRST THEN BEGIN
            IF IG."Include/Exclude" = IG."Include/Exclude"::Exclude THEN
                Abc := 0;
            IF IG."Include/Exclude" = IG."Include/Exclude"::Include THEN
                Abc := 1;
        END ELSE BEGIN
            IF ItemGroup1."Include/Exclude" = ItemGroup1."Include/Exclude"::Exclude THEN
                Abc := 0;
            IF ItemGroup1."Include/Exclude" = ItemGroup1."Include/Exclude"::Include THEN
                Abc := 1;

        END;
        EXIT(Abc);
    end;


    procedure "--MS-AN--"()
    begin
    end;


    procedure GeneratePDF_Invoice(txtFile: Text[100]; txtPath: Text[100]; var lrecSIH: Record "Sales Invoice Header"; intReportID: Integer)
    begin
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
         */
        SLEEP(10000);

    end;


    procedure InitalizePDF()
    begin
        /*IF ISCLEAR(clsPDFCreator) THEN
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


    procedure SetDefaultPrinter()
    begin
        /*clsPDFCreator.cDefaultPrinter := txtDefaultPrinter;
        clsPDFCreator.cClearCache();
        clsPDFCreator.cPrinterStop := FALSE;
        
        CLEAR(clsPDFCreator);
        CLEAR(clsPDFCreatorError);
         */

    end;


    procedure SendMail(SalesInvHeader: Record "Sales Invoice Header")
    var
        ReSIH: Record "Sales Invoice Header";
        //  SMTPMailCodeUnit: Codeunit 400;
        RecCustomer: Record Customer;
        PCHMailed: Boolean;
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

        //MS-AN BEGIN 18/01/13

        // CLEAR(SMTPMailCodeUnit);
        /*
        ReSIH.RESET;
        ReSIH.SETRANGE("No.",SalesInvHeader."No.");
        ReSIH.SETRANGE("PCH Mailed",FALSE);
        ReSIH.SETFILTER("Posting Date",'>=%1',170113D);
        IF ReSIH.FINDFIRST THEN
        BEGIN
          IF RecCustomer.GET(SalesInvHeader."Sell-to Customer No.") THEN
          BEGIN
            SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',
              RecCustomer."E-Mail",'Sales Invoice','',TRUE);
            SMTPMailCodeUnit.AppendBody(Text50000);
            SMTPMailCodeUnit.AppendBody(RecCustomer.Name);
            SMTPMailCodeUnit.AppendBody(Text50010);
            SMTPMailCodeUnit.AppendBody(Text50027);
            SMTPMailCodeUnit.AppendBody(SalesInvHeader."No.");
            SMTPMailCodeUnit.AppendBody(Text50028);
            SMTPMailCodeUnit.AppendBody(Text50029);
            SMTPMailCodeUnit.AppendBody(Text50004);
            SMTPMailCodeUnit.AppendBody(Text50005);
            SMTPMailCodeUnit.AppendBody(Text50006);
            SMTPMailCodeUnit.AppendBody(Text50007);
            SMTPMailCodeUnit.AppendBody(Text50008);
            SMTPMailCodeUnit.AppendBody(Text50009);
            SMTPMailCodeUnit.AddAttachment('C:\PDF\'+CONVERTSTR(SalesInvHeader."No.",'\/','__')+'.pdf');
            SMTPMailCodeUnit.Send();
          END;
        END ELSE
        BEGIN
        //  IF SalesInvHeader."Posting Date" >= 170113D THEN
        //    MESSAGE('Already sent the mail to Customer');
        END;
        */
        PCHMailed := FALSE;
        //  CLEAR(SMTPMailCodeUnit);
        ReSIH.RESET;
        ReSIH.SETRANGE("No.", SalesInvHeader."No.");
        ReSIH.SETRANGE("PCH Mailed", FALSE);
        ReSIH.SETFILTER("Posting Date", '>=%1', 20130228D);
        IF ReSIH.FINDFIRST THEN BEGIN
            IF RecCustomer.GET(SalesInvHeader."Sell-to Customer No.") THEN BEGIN
                //  SalesInvHeader.CALCFIELDS("Amount to Customer", "Qty In carton", "Sq. Meter");
                //  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                //  RecCustomer."PCH E-Maill ID", 'Sales Invocie', '', TRUE);//15578
                EmailAddressList.Add('donotreply@orientbell.com');
                BodyText := Text50000;
                BodyText += RecCustomer."PCH Name";
                BodyText += Text50010;
                BodyText += Text50010;
                BodyText += Text50001;
                BodyText += Text50002;
                BodyText += Text50011;
                BodyText += SalesInvHeader."Sell-to Customer No.";
                BodyText += Text50010;
                BodyText += Text50012;
                BodyText += SalesInvHeader."Bill-to Name";
                BodyText += Text50010;
                BodyText += Text50013;
                //  BodyText += FORMAT(SalesInvHeader."Amount to Customer");
                BodyText += Text50010;
                BodyText += Text50019;
                BodyText += FORMAT(SalesInvHeader."Order Date");
                BodyText += Text50010;
                BodyText += Text50020;
                BodyText += SalesInvHeader."Order No.";
                BodyText += Text50010;
                BodyText += Text50014;
                BodyText += FORMAT(SalesInvHeader."Posting Date");
                BodyText += Text50010;
                BodyText += Text50015;
                BodyText += SalesInvHeader."No.";
                BodyText += Text50010;
                BodyText += Text50016;
                BodyText += FORMAT(SalesInvHeader."Qty In carton");
                BodyText += Text50010;
                BodyText += Text50031;
                BodyText += FORMAT(SalesInvHeader."Sq. Meter");
                BodyText += Text50010;
                BodyText += Text50017;
                BodyText += SalesInvHeader."Transporter Name";
                BodyText += Text50010;
                BodyText += Text50018;
                BodyText += SalesInvHeader."Truck No.";
                BodyText += Text50010;
                BodyText += Text50010;
                BodyText += Text50004;
                BodyText += Text50005;
                BodyText += Text50006;
                BodyText += Text50007;
                BodyText += Text50008;
                BodyText += Text50009;
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
                MESSAGE('Mail Sent');
                PCHMailed := TRUE;

            END;
        END ELSE BEGIN
            IF SalesInvHeader."Posting Date" <= 20210101D THEN;
            MESSAGE('Already sent the mail to PCH Head');
        END;

        ReSIH.RESET;
        ReSIH.SETRANGE("No.", SalesInvHeader."No.");
        IF ReSIH.FINDFIRST THEN BEGIN
            ReSIH."PCH Mailed" := PCHMailed;
            //   ReSIH."Invoiced Mailed":=PCHMailed;
            ReSIH.MODIFY;
        END;

        //MS-AN END 18/01/13

    end;


    procedure CreateMailForPO(SalesHeader: Record "Sales Header"; SPCode: Code[20])
    var
        Text50000: Label 'Dear      ';
        Text50001: Label 'ADA';
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
        // SMTPMailSetup: Record 409;
        CompInfo: Record "Company Information";
        Text50034: Label '" We have received the order for following products & the same is sent to you for Discount approvals details as given below:  "';
        Text50035: Label ' Branch vide Stock Transfer Note No. ';
        Text50036: Label ' Dated ';
        RecSalesLine: Record "Sales Line";
        Text50037: Label 'Customer No: ';
        Text50038: Label 'Name: ';
        Text50039: Label 'Regards,';
        Text50040: Label 'Orient Bell Limited';
        Text50041: Label '<TD  width=5 Align=Center>';
        SalesPersons: Record "Salesperson/Purchaser";
        RecUserSetup: Record "User Setup";
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        HighValueProd: Boolean;
        Text50090: Label '<td width="20%" bgcolor="#80ff80"> ';
        Text50091: Label '<td width="50%" bgcolor="#80ff80"> ';
        ShowMarginDetail: Boolean;
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

        SalesHeader.CALCFIELDS(SalesHeader."D1 Amount", SalesHeader."D2 Amount", SalesHeader."D3 Amount", SalesHeader."D4 Amount", SalesHeader."S1 Amount", SalesHeader."D6 Amount", "Qty in Sq. Mt.");
        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        IF SalesPersons.GET(SPCode) THEN
            SalesPersons.TESTFIELD("E-Mail");
        IF SalesPersons."E-Mail" <> '' THEN BEGIN
            //  SMTPMailSetup.GET;
            //  SMTPMailSetup.TESTFIELD("User ID");
            //IF SalesPersons.Type IN [SalesPersons.Type::PSM,SalesPersons.Type::PAC] THEN
            //ShowMarginDetail := TRUE;
            IF NOT ShowMarginDetail THEN BEGIN
                IF SalesPersons."Margin Display" THEN
                    ShowMarginDetail := SalesPersons."Margin Display";
            END;

            TotalCostVal := 0;
            TSaleeval := 0;
            Tmargin := 0;
            SrNo := 1;
            // CLEAR(SMTPMail);
            IF RecState.GET(RecCustomer."State Code") THEN;
            //EmailMsg.Create(SalesPersons."E-Mail",'Test',);
            //SMTPMail.CreateMessage('Additional Discount Approval', 'donotreply@orientbell.com', SalesPersons."E-Mail", Text50001 + ' ' + SalesHeader."No." + ' (' + RecCustomer.Name + ' - ' + RecCustomer.City + '-' + RecState.Description + ') ' + SalesHeader."Location Code", '', TRUE);
            //    SMTPMail.CreateMessage('Discount Approvals ['+RecCustomer.Name+' - '+RecCustomer.City+' - '+RecCustomer."State Code"+']',SMTPMailSetup."User ID",'virendra.kumar@mindshell.info',Text50001,'',TRUE);
            EmailAddressList.Add(SalesPersons."E-Mail");
            EmailCCList.add('donotreply@orientbell.com');
            BodyText := Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50033 + Text60003;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text50024 + Text50034;

            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            //   SMTPMail.AppendBody('Customer Name : ' + RecCustomer.Name);
            BodyText += 'Customer Name : ' + RecCustomer.Name + ' - ' + RecCustomer.City + ' - ' + RecState.Description;
            BodyText += Text60011;
            BodyText += 'Billing Address:' + SalesHeader."Bill-to Address" + ' ' + SalesHeader."Bill-to Address 2" + ' ' + SalesHeader."Bill-to City";
            BodyText += Text60011;
            BodyText += 'Shipping Address:' + SalesHeader."Ship-to Address" + ' ' + SalesHeader."Ship-to Address 2" + ' ' + SalesHeader."Ship-to City";
            BodyText += Text60011;
            BodyText += 'Customer Type : ' + SalesHeader."Customer Type";
            BodyText += Text60011;
            BodyText += 'PMT Code: ' + SalesHeader."PMT Code";
            BodyText += Text60011;
            BodyText += 'Credit Rating : ' + FORMAT(RecCustomer."Credit Rating");
            BodyText += Text60011;
            BodyText += 'Freight Terms : ' + FORMAT(SalesHeader.Pay);
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'CD Applicable : ' + FORMAT(SalesHeader."CD Applicable");
            BodyText += Text60011;
            BodyText += 'Payment Terms : ' + SalesHeader."Payment Terms Code";
            BodyText += Text60011;
            BodyText += 'CD Discount %: ' + FORMAT(SalesHeader."Discount Charges %");
            BodyText += Text60011;
            BodyText += 'Order Qty.In Sq.Mt : ' + FORMAT(SalesHeader."Qty in Sq. Mt.");
            BodyText += Text60011;
            RecCustomer.CALCFIELDS(Balance);
            BodyText += 'Total Outstanding : ' + FORMAT(ROUND(RecCustomer.Balance));
            BodyText += Text60011;

            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'Remarks :-' + FORMAT(SalesHeader.Remarks); //Raushan 180417
            BodyText += Text60011;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            AppEntry.SETRANGE(Status, AppEntry.Status::Approved);
            IF AppEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF AppEntry."Comment Text" <> '' THEN BEGIN
                        IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                            BodyText += SalesPersons.Name + ' - ' + AppEntry."Comment Text";
                            BodyText += Text60011;
                        END;
                    END;
                UNTIL AppEntry.NEXT = 0;
            END;

            BodyText += Text60011;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50027 + Text50026 + Text50030 + Text60012 + 'Plant' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003;
            IF ShowMarginDetail THEN
                BodyText += Text50041 + Text60012 + 'Manuf Strategy' + Text60013 + Text60003;

            BodyText += Text50041 + Text60012 + 'State Price Group ' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Price Group' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Qty. Cartons' + Text60013 + Text60003;
            //BodyText +=Text50041+Text60012+'UOM'+Text60013+Text60003;
            BodyText += Text50041 + Text60012 + 'Qty. Sq. Mtr.' + Text60013 + Text60003;
            //BodyText +=Text50041+Text60012+'MRP Price '+Text60013+Text60003;
            BodyText += Text50041 + Text60012 + 'List/Sqm ' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Total Discount ' + Text60013 + Text60003;
            IF SalesHeader."S1 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'FRT' + Text60013 + Text60003;

            IF SalesHeader."D6 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'ORC' + Text60013 + Text60003;


            BodyText += Text50041 + Text60012 + 'Buyer Price/Sqm' + Text60013 + Text60003;//ADD
            BodyText += Text50041 + Text60012 + 'App Required' + Text60013 + Text60003;
            IF ShowMarginDetail THEN BEGIN
                BodyText += Text50041 + Text60012 + '   %     ' + Text60013 + Text60003;//MSKS
                BodyText += Text50041 + Text60012 + 'App Comments' + Text60013 + Text60003;
                //BodyText +=Text50041+Text60012+'App Required'+Text60013+Text60003;
            END;
            BodyText += Text60004;
            RecSalesLine.RESET;
            RecSalesLine.SETRANGE("Document No.", SalesHeader."No.");
            RecSalesLine.setrange(Type, RecSalesLine.Type::Item);
            IF RecSalesLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF RecItem.GET(RecSalesLine."No.") THEN;
                    //HighValueProd := (RecItem."Type Category Code Desc." = 'PGVT-Tiles');
                    HighValueProd := ((RecItem."Manuf. Strategy" = RecItem."Manuf. Strategy"::"Non Retained ") OR (RecItem."Quality Code" = '2'));
                    /*//PGVT Marking Start
                    IF RecItem."Type Category Code Desc." = 'PGVT-Tiles' THEN
                      Text50041 := '<TD  width=5 Align=Center bgcolor=Green>'
                    ELSE
                      Text50041 := '<TD  width=5 Align=Center>';
                    //PGVT Marking end
                    */
                    BodyText += Text50026 + Text50041 + FORMAT(COPYSTR(RecItem."Default Prod. Plant Code", 1, 3)) + Text60003;

                    IF HighValueProd THEN BEGIN
                        BodyText += Text50090 + FORMAT(RecSalesLine.Description) + Text60003;
                        BodyText += Text50091 + RecItem."Description 2" + Text60003;
                    END ELSE BEGIN
                        BodyText += Text50030 + FORMAT(RecSalesLine.Description + Text60003);
                        BodyText += Text50031 + RecItem."Description 2" + Text60003;
                    END;

                    IF ShowMarginDetail THEN
                        BodyText += Text50031 + FORMAT(RecItem."Manuf. Strategy") + Text60003;

                    BodyText += Text50031 + FORMAT(RecSalesLine."Customer Price Group") + Text60003;
                    BodyText += Text50031 + FORMAT(RecItem."Item Classification") + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine.Quantity) + Text60003;
                    //BodyText +=Text50041+FORMAT(RecSalesLine."Unit of Measure")+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Quantity in Sq. Mt.") + Text60003;
                    //SMTPMail.AppendBody(Text50041+FORMAT(RecSalesLine."MRP Price",0,'<Precision,2:2><Standard Format,2>')+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT"), 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    /*IF SalesHeader."D1 Amount"<>0  THEN
                    SMTPMail.AppendBody(Text50041+FORMAT(RecSalesLine.D1)+Text60003);
                    IF SalesHeader."D2 Amount"<>0  THEN
                    SMTPMail.AppendBody(Text50041+FORMAT(RecSalesLine.D2)+Text60003);
                    IF SalesHeader."D3 Amount" <>0  THEN
                    SMTPMail.AppendBody(Text50041+FORMAT(RecSalesLine.D3)+Text60003);
                    IF SalesHeader."D4 Amount" <>0  THEN
                    SMTPMail.AppendBody(Text50041+FORMAT(RecSalesLine.D4)+Text60003);*/
                    BodyText += Text50041 + FORMAT(RecSalesLine.D7) + Text60003;
                    IF SalesHeader."S1 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.S1) + Text60003;
                    IF SalesHeader."D6 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D6) + Text60003;

                    //SMTPMail.AppendBody(Text50041+FORMAT((RecSalesLine."Buyer's Price /Sq.Mt"-(RecSalesLine.S1))-(RecSalesLine.D1+RecSalesLine.D2+RecSalesLine.D3+RecSalesLine.D4),0,'<Precision,2:2><Standard Format,2>')+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt", 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine."Approval Required") + Text60003;
                    //Margin Start Kulbhushan Sharma 141118
                    buyprice := 0;
                    Costv := 0;
                    Saleeval := 0;
                    margin := 0;
                    IF RecItem."V. Cost" <> 0 THEN BEGIN
                        buyprice := (RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT")) - (RecSalesLine.D1 + RecSalesLine.D2 + RecSalesLine.D3 + RecSalesLine.D4);
                        Costv := RecItem."V. Cost" * (RecSalesLine."Quantity in Sq. Mt.");
                        Saleeval := buyprice * (RecSalesLine."Quantity in Sq. Mt.");
                        ;
                        margin := ((Saleeval - Costv) / Saleeval) * 100;

                        TSaleeval += Saleeval;
                        TotalCostVal += Costv;
                        //Vmargin := ((Saleeval-Costv)/RecSalesLine."Quantity in Sq. Mt.");
                        //TVmargin += Vmargin/TSaleeval;
                        //Tmargin := (Vmargin/TSaleeval) *100

                    END ELSE
                        margin := 0;
                    //Margin end Kulbhushan Sharma 141118

                    IF ShowMarginDetail THEN BEGIN
                        BodyText += Text50041 + FORMAT(FORMAT(margin, 0, '<Precision,2:2><Standard Format,2>') + ' %') + Text60003;
                        BodyText += Text50031 + FORMAT(RecItem."Discount Comments") + Text60003;
                        //SMTPMail.AppendBody(Text50041+FORMAT(RecSalesLine."Approval Required")+Text60003);
                    END;
                    BodyText += Text60004;
                    SrNo += 1;
                UNTIL RecSalesLine.NEXT = 0;
            END;
            BodyText += Text60004;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;

            IF RecItem."V. Cost" <> 0 THEN
                Tmargin := ((TSaleeval - TotalCostVal) / TSaleeval) * 100;

            IF ShowMarginDetail THEN
                BodyText += Text50041 + FORMAT(' % -' + FORMAT(Tmargin, 0, '<Precision,2:2><Standard Format,2>') + ' %') + Text60003;

            BodyText += Text60005;

            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50039 + Text60003;
            BodyText += Text60004;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            //    AppEntry.SETRANGE(Status,AppEntry.Status::Approved);
            IF AppEntry.FINDFIRST THEN;
            IF RecUserSetup.GET(AppEntry."Sender ID") THEN
                BodyText += '[' + RecUserSetup."User Name" + ']';

            BodyText += Text60004;


            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50040 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;

            BodyText += Text60011;
            BodyText += Text59999;
            BodyText += Text60000;
            BodyText += Text60001;
            BodyText += Text50024 + Text50025 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text60011;
            //    SMTPMail.AppendBody(getApprovalLink(SalesHeader."No.",1);
            BodyText += Text50045 + getApprovalLink(36, SalesHeader."No.", 1) + Text50046 + Text50047;
            EmailMsg.Create(EmailAddressList, Text50001 + ' ' + SalesHeader."No." + ' (' + RecCustomer.Name + ' - ' + RecCustomer.City + '-' + RecState.Description + ') ' + SalesHeader."Location Code", BodyText, true, EmailBccList, EmailCCList);

            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            //MESSAGE(Text50022);
        END;
        //END;

    end;


    procedure getApprovalLink(TblID: Integer; DocNo: Code[20]; TypeInt: Integer): Text
    var
        AppEntry: Record "Approval Entry";
        GUIDTXT: Text[100];
        TxtLink: Text[250];
    begin
        AppEntry.RESET;
        AppEntry.SETRANGE("Table ID", TblID);
        AppEntry.SETRANGE("Document No.", DocNo);
        AppEntry.SETRANGE(Status, AppEntry.Status::Created);
        AppEntry.SETFILTER("GUID Key", '<>%1', '{00000000-0000-0000-0000-000000000000}');
        IF AppEntry.FINDFIRST THEN BEGIN
            GUIDTXT := AppEntry."GUID Key";
        END;

        //TxtLink := '<button onclick="window.open('+'http://14.140.109.180/mailapproval/?ref='+GUIDTXT+')">Click me</button>';
        //TxtLink := TextButtonStart+GUIDTXT+TextButtonEnd;
        //TxtLink := 'http://182.73.118.183/mailapproval/?ref='+GUIDTXT; //live server
        //TxtLink := 'http://14.140.109.181/mailapproval/?ref='+GUIDTXT; //live server
        //TxtLink := 'http://192.168.3.98:89/mailapproval/?ref=' + GUIDTXT; //live server

        TxtLink := 'http://erp.orientapps.com/mailapproval/?ref=' + GUIDTXT;


        // TxtLink := 'http://erp.orientapps.com/mailapproval/?ref=' + GUIDTXT; //live server
        EXIT(TxtLink);
    end;


    procedure CreateMailForPORejection(SalesHeader: Record "Sales Header"; SPCode: Code[20])
    var
        Text50000: Label 'Dear      ';
        Text50001: Label 'ADA';
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
        // SMTPMail: Codeunit "400";
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
        //SMTPMailSetup: Record 409;
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


        SalesHeader.CALCFIELDS(SalesHeader."D1 Amount", SalesHeader."D2 Amount", SalesHeader."D3 Amount", SalesHeader."D4 Amount");
        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        IF SalesPersons.GET(SPCode) THEN
            SalesPersons.TESTFIELD("E-Mail");
        IF SalesPersons."E-Mail" <> '' THEN BEGIN
            //  SMTPMailSetup.GET;
            //  SMTPMailSetup.TESTFIELD("User ID");
            SrNo := 1;
            //  CLEAR(SMTPMail);
            //   SMTPMail.CreateMessage('Discount Approvals -Rejection', SMTPMailSetup."Sender Email", SalesPersons."E-Mail", Text50001, '', TRUE);
            //    SMTPMail.AddCC('kulwant@mindshell.info');

            EmailCCList.add('donotreply@orientbell.com');
            BodyText := Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50033 + Text60003;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text50024 + Text50034;

            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;

            BodyText += 'Customer Name : ' + RecCustomer.Name + ' - ' + RecCustomer.City + ' - ' + RecState.Description;
            BodyText += Text60011;

            BodyText += 'Customer Type : ' + SalesHeader."Customer Type";
            BodyText += Text60011;


            BodyText += Text60011;
            BodyText += 'Freight Terms : ' + FORMAT(SalesHeader.Pay);
            BodyText += Text60011;

            BodyText += Text60011;
            BodyText += 'Payment Terms : ' + SalesHeader."Payment Terms Code";
            BodyText += Text60011;
            BodyText += 'CD Discount %: ' + FORMAT(SalesHeader."Discount Charges %");
            BodyText += Text60011;
            BodyText += 'Order Qty.In Sq.Mt : ' + FORMAT(SalesHeader."Qty in Sq. Mt.");
            BodyText += Text60011;
            RecCustomer.CALCFIELDS(Balance);
            BodyText += 'Total Outstanding : ' + FORMAT(ROUND(RecCustomer.Balance));
            BodyText += Text60011;

            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'Remarks :-' + FORMAT(SalesHeader.Remarks); //Raushan 180417
            BodyText += Text60011;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            AppEntry.SETRANGE(Status, AppEntry.Status::Approved);
            IF AppEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF AppEntry."Comment Text" <> '' THEN BEGIN
                        IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                            BodyText += SalesPersons.Name + ' - ' + AppEntry."Comment Text";
                            BodyText += Text60011;
                        END;
                    END;
                UNTIL AppEntry.NEXT = 0;
            END;

            BodyText += Text60011;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50027 + Text50026 + Text50030 + Text60012 + 'Plant' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Qty. Cartons' + Text60013 + Text60003;
            //BodyText +=Text50041+Text60012+'UOM'+Text60013+Text60003);
            BodyText += Text50041 + Text60012 + 'Qty. Sq. Mtr.' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'MRP Price ' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'List/Sqm ' + Text60013 + Text60003;

            IF SalesHeader."D1 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'PCH' + Text60013 + Text60003;

            IF SalesHeader."D2 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'ZM' + Text60013 + Text60003;

            IF SalesHeader."D3 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'Sales Head' + Text60013 + Text60003;

            IF SalesHeader."D4 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'PAC' + Text60013 + Text60003;

            IF SalesHeader."S1 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'FRT' + Text60013 + Text60003;

            IF SalesHeader."D6 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'ORC' + Text60013 + Text60003;

            BodyText += Text50041 + Text60012 + 'Buyer Price/Sqm' + Text60013 + Text60003;//ADD
            BodyText += Text60004;
            RecSalesLine.RESET;
            RecSalesLine.SETRANGE("Document No.", SalesHeader."No.");
            IF RecSalesLine.FINDFIRST THEN BEGIN
                REPEAT
                    BodyText += Text50026 + Text50041 + FORMAT(COPYSTR(RecItem."Default Prod. Plant Code", 1, 3)) + Text60003;
                    BodyText += Text50030 + FORMAT(RecSalesLine.Description) + Text60003;
                    BodyText += Text50031 + RecItem."Description 2" + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine.Quantity) + Text60003;
                    //BodyText +=Text50041+FORMAT(RecSalesLine."Unit of Measure")+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Quantity in Sq. Mt.") + Text60003;
                    // 15578    BodyText += Text50041 + FORMAT(RecSalesLine."MRP Price", 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT"), 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    IF SalesHeader."D1 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D1) + Text60003;
                    IF SalesHeader."D2 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D2) + Text60003;
                    IF SalesHeader."D3 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D3) + Text60003;
                    IF SalesHeader."D4 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D4) + Text60003;
                    IF SalesHeader."S1 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.S1) + Text60003;
                    IF SalesHeader."D6 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D6) + Text60003;
                    //BodyText +=Text50041+FORMAT((RecSalesLine."Buyer's Price /Sq.Mt"-(RecSalesLine.S1))-(RecSalesLine.D1+RecSalesLine.D2+RecSalesLine.D3+RecSalesLine.D4),0,'<Precision,2:2><Standard Format,2>')+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt", 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    BodyText += Text60004;
                    SrNo += 1;
                UNTIL RecSalesLine.NEXT = 0;
            END;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50039 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50040 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;

            BodyText += Text60011;
            BodyText += Text59999;
            BodyText += Text60000;
            BodyText += Text60001;
            BodyText += Text50024 + Text50025 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'Remarks :-';
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            AppEntry.SETRANGE(Status, AppEntry.Status::Rejected);
            IF AppEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF AppEntry."Comment Text" <> '' THEN BEGIN
                        IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                            BodyText += SalesPersons.Name + ' - ' + AppEntry."Comment Text";
                            BodyText += Text60011;
                        END;
                    END;
                UNTIL AppEntry.NEXT = 0;
            END;

            BodyText += Text60011;
            //    SMTPMail.AppendBody(getApprovalLink(SalesHeader."No.",1));


            EmailMsg.Create(EmailAddressList, Text50001, BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            //MESSAGE(Text50022);
        END
        //END;

    end;


    procedure ApproveDocument(TxtGUID: Text; TxtComment: Text)
    var
        SalesHeader: Record "Sales Header";
        DocNo: Code[20];
        SP: Record "Salesperson/Purchaser";
        PACApproval: Boolean;
        CreatedBy: Code[20];
        UserSetup: Record "User Setup";
        TableID: Integer;
        IndentHeader: Record "Indent Header";
    begin

        IF TxtGUID = '' THEN
            EXIT;

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN
                ERROR('Document No. ' + ApprovalEntry."Document No." + ' is already Approved');

            IF ApprovalEntry.Status <> ApprovalEntry.Status::Created THEN
                ERROR('Document No. is Already %1', FORMAT(ApprovalEntry.Status));

            CreatedBy := ApprovalEntry."Sender ID";
            DocNo := ApprovalEntry."Document No.";
            TableID := ApprovalEntry."Table ID";

            //  CheckUserPIN(ApprovalEntry."Approver ID",otppassword);

            ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
            ApprovalEntry."Comment Text" := COPYSTR(TxtComment, 1, 249);
            ArchiveApprovalEntry(ApprovalEntry, ApprovalEntry);    //msks
            ApprovalEntry.MODIFY;
            //  msg := 'Document Approved Sucessfully';
            CASE TableID OF
                36:
                    ApproveSalesOrder(ApprovalEntry);
                50016:
                    BEGIN
                        IndentHeader.RESET;
                        IndentHeader.SETRANGE("No.", DocNo);
                        IF IndentHeader.FINDFIRST THEN BEGIN
                            UserSetup.RESET;
                            UserSetup.SETRANGE("User ID", ApprovalEntry."Approver ID");
                            /* IF UserSetup.FINDFIRST THEN
                                 IndentRelease.ApproveIndent(IndentHeader, UserSetup."User ID");*/ // 15578
                        END;
                    END;

                38:
                    BEGIN
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("No.", DocNo);
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            IF UserSetup.GET(ApprovalEntry."Approver ID") THEN;
                            PurchaseApproval(ApprovalEntry);
                        END;
                    END;
            END;

            /*
              //New Code Added for PAC Approval.
              SP.RESET;
              IF SP.GET(ApprovalEntry."Approver Code") THEN
                 IF SP.Type=SP.Type::PAC THEN
                    PACApproval := TRUE;

            IF PACApproval THEN BEGIN
              ApprovalEntryPAC.RESET;
              ApprovalEntryPAC.SETRANGE("Document No.",DocNo);
              IF ApprovalEntryPAC.FINDFIRST THEN BEGIN
                  REPEAT
                    IF ApprovalEntryPAC.Status = ApprovalEntryPAC.Status::Created THEN BEGIN
                        ApprovalEntryPAC.VALIDATE(Status,ApprovalEntryPAC.Status::Approved);
                        ArchiveApprovalEntry(ApprovalEntry,ApprovalEntry);    //msks
                        //ApprovalEntryPAC."Comment Text" := 'PAC APPROVAL1';
                        ApprovalEntryPAC.MODIFY;
                    END;
                  UNTIL ApprovalEntryPAC.NEXT=0;
                END;
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                  SalesHeader.Status := SalesHeader.Status::"Price Approved";
                  SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                  SalesHeader.MODIFY;

                  CLEAR(SMSMgt);
                  SMSMgt.CreateMsgOnDApriceApproved(SalesHeader); //MSKS2707

                END;
            END;
              //New Code Added for PAC Approval.



              ApprovalEntry.RESET;
              ApprovalEntry.SETRANGE(ApprovalEntry."Table ID",36);
              ApprovalEntry.SETRANGE(ApprovalEntry."Document No.",DocNo);
              ApprovalEntry.SETRANGE(ApprovalEntry.Status,ApprovalEntry.Status::Created);
              IF ApprovalEntry.FINDFIRST THEN BEGIN
                CLEAR(MailMgt);
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                  MailMgt.CreateMailForPO(SalesHeader,ApprovalEntry."Approver Code");
                  IF SP.GET(ApprovalEntry."Approver Code") THEN BEGIN
                     CASE SP.Type OF
                      SP.Type::PCH:
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PCH;
                          SalesHeader.MODIFY;
                        END;
                      SP.Type::"Zone Manager":
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::ZM;
                          SalesHeader.MODIFY;
                        END;
                      SP.Type::PSM:
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PSM;
                          SalesHeader.MODIFY;
                        END;
                      SP.Type::PAC:
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PAC;
                          SalesHeader.MODIFY;
                        END;

                     END;
                  END;

                END;
              END ELSE BEGIN
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                  SalesHeader.Status := SalesHeader.Status::"Price Approved";
                  SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                  SalesHeader.MODIFY;
                  CLEAR(MailMgt);
                  IF SP.GET('DAAPP') THEN
                  IF SP."E-Mail" <>'' THEN
                  MailMgt.CreateMailForPO(SalesHeader,'DAAPP');

                  IF CreatedBy<>'' THEN BEGIN
                     IF UserSetup.GET(CreatedBy) THEN
                      IF UserSetup."E-Mail" <>'' THEN
                         MailMgt.CreateMailForCreator(SalesHeader,UserSetup."E-Mail");
                  END;
                END;
              END;
              */
        END;

    end;


    procedure RejectDocument(TxtGUID: Text; TxtComment: Text)
    var
        DocNo: Code[20];
        SalesPersonCode: Code[20];
        IndentHeader: Record "Indent Header";
        TableID: Integer;
    begin
        IF TxtGUID = '' THEN
            EXIT;
        IF TxtComment = '' THEN
            ERROR('Please write comment as its Mandatory');

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN
                ERROR('Document No. ' + ApprovalEntry."Document No." + ' is already Approved');

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Rejected THEN
                ERROR('Document No. ' + ApprovalEntry."Document No." + ' is already Rejected');
            DocNo := ApprovalEntry."Document No.";
            TableID := ApprovalEntry."Table ID";
            // CheckUserPIN(ApprovalEntry."Approver ID",OTPPassword);
            //IF (ApprovalEntry.Status<>ApprovalEntry.Status::Created) OR (ApprovalEntry.Status<>ApprovalEntry.Status::Open) THEN
            // ERROR('Not a Valid Document');
            ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Rejected);
            ApprovalEntry."Comment Text" := COPYSTR(TxtComment, 1, 249);
            ApprovalEntry.MODIFY;

            //  Msg := 'Document Rejected Successfully';

            CASE TableID OF
                36:
                    BEGIN
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Created);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalEntry.MODIFYALL(Status, ApprovalEntry.Status::Cancelled);
                        END;
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            SalesHeader.Status := SalesHeader.Status::Open;
                            SalesHeader.MODIFY;
                        END;

                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                        ApprovalEntry.SETCURRENTKEY("Approver Code", Status);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            REPEAT
                                IF SalesPersonCode <> ApprovalEntry."Approver Code" THEN BEGIN
                                    CLEAR(MailMgt);
                                    SalesHeader.RESET;
                                    SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                                    IF SalesHeader.FINDFIRST THEN BEGIN
                                        MailMgt.CreateMailForPORejection(SalesHeader, ApprovalEntry."Approver Code");
                                    END;
                                    SalesPersonCode := ApprovalEntry."Approver Code";
                                END;
                            UNTIL ApprovalEntry.NEXT = 0;
                        END;
                    END;
                50016:
                    BEGIN
                        CancelIndentApprovalEnt(DocNo);
                    END;
                38:
                    BEGIN
                        CancelPurchaseApprovalEnt(DocNo);
                    END;

            END;

        END;

    end;


    procedure CreateMailForCreator(SalesHeader: Record "Sales Header"; EmailID: Code[50])
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
        //  SMTPMail: Codeunit "400";
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
        // SMTPMailSetup: Record 409;
        CompInfo: Record "Company Information";
        Text50034: Label '" We have received the order for following products & the same is sent to you for Discount approvals details as given below:  "';
        Text50035: Label ' Branch vide Stock Transfer Note No. ';
        Text50036: Label ' Dated ';
        RecSalesLine: Record "Sales Line";
        Text50037: Label 'Customer No: ';
        Text50038: Label 'Name: ';
        Text50039: Label 'Regards,';
        Text50040: Label 'Orient Bell Limited';
        Text50041: Label '<TD  width=5 Align=Center>';
        SalesPersons: Record "Salesperson/Purchaser";
        RecUserSetup: Record "User Setup";
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
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
        EmailAddressList.Add(EmailID);
        SalesHeader.CALCFIELDS(SalesHeader."D1 Amount", SalesHeader."D2 Amount", SalesHeader."D3 Amount", SalesHeader."D4 Amount", SalesHeader."S1 Amount", SalesHeader."D6 Amount", "Qty in Sq. Mt.");
        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        IF EmailID <> '' THEN BEGIN
            //  SMTPMailSetup.GET;
            //  SMTPMailSetup.TESTFIELD("User ID");
            SrNo := 1;
            //  CLEAR(SMTPMail);
            IF RecState.GET(RecCustomer."State Code") THEN;
            //  SMTPMail.CreateMessage('Additional Discount Intimation', 'donotreply@orientbell.com', EmailID, Text50001 + ' ' + SalesHeader."No." + ' [' + RecCustomer.Name + ' - ' + RecCustomer.City + '-' + RecState.Description + ']-' + SalesHeader."Location Code", '', TRUE);

            BodyText := Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50033 + Text60003;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text50024 + Text50034;

            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;

            BodyText += 'Customer Name : ' + RecCustomer.Name + ' - ' + RecCustomer.City + ' - ' + RecState.Description;
            BodyText += Text60011;

            BodyText += 'Customer Type : ' + SalesHeader."Customer Type";
            BodyText += Text60011;
            BodyText += 'Discount Group : ' + FORMAT(RecCustomer."Discount Group");
            BodyText += Text60011;

            BodyText += 'Freight Terms : ' + FORMAT(SalesHeader.Pay);
            BodyText += Text60011;

            BodyText += Text60011;
            BodyText += 'Payment Terms : ' + SalesHeader."Payment Terms Code";
            BodyText += Text60011;
            BodyText += 'Order Qty.In Sq.Mt : ' + FORMAT(SalesHeader."Qty in Sq. Mt.");
            BodyText += Text60011;
            RecCustomer.CALCFIELDS(Balance);
            BodyText += 'Total Outstanding : ' + FORMAT(ROUND(RecCustomer.Balance));
            BodyText += Text60011;

            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'Remarks :-' + FORMAT(SalesHeader.Remarks); //Raushan 180417
            BodyText += Text60011;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            AppEntry.SETRANGE(Status, AppEntry.Status::Approved);
            IF AppEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF AppEntry."Comment Text" <> '' THEN BEGIN
                        IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                            BodyText += SalesPersons.Name + ' - ' + AppEntry."Comment Text";
                            BodyText += Text60011;
                        END;
                    END;
                UNTIL AppEntry.NEXT = 0;
            END;

            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50027 + Text50026 + Text50030 + Text60012 + 'Plant' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;

            BodyText += Text50041 + Text60012 + 'Qty. Cartons' + Text60013 + Text60003;

            BodyText += Text50041 + Text60012 + 'Qty. Sq. Mtr.' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'MRP Price/CRT ' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'List/Sqm ' + Text60013 + Text60003;

            IF SalesHeader."D1 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'PCH' + Text60013 + Text60003;

            IF SalesHeader."D2 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'ZM' + Text60013 + Text60003;

            IF SalesHeader."D3 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'Sales Head' + Text60013 + Text60003;

            IF SalesHeader."D4 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'PAC' + Text60013 + Text60003;

            IF SalesHeader."S1 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'FRT' + Text60013 + Text60003;

            IF SalesHeader."D6 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'ORC' + Text60013 + Text60003;


            BodyText += Text50041 + Text60012 + 'Buyer Price/Sqm' + Text60013 + Text60003;//ADD
            BodyText += Text60004;
            RecSalesLine.RESET;
            RecSalesLine.SETRANGE("Document No.", SalesHeader."No.");
            IF RecSalesLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF RecItem.GET(RecSalesLine."No.") THEN;

                    BodyText += Text50026 + Text50041 + FORMAT(COPYSTR(RecItem."Default Prod. Plant Code", 1, 3)) + Text60003;
                    BodyText += Text50030 + FORMAT(RecSalesLine.Description + ' ' + RecItem."Description 2") + Text60003;

                    BodyText += Text50041 + FORMAT(RecSalesLine.Quantity) + Text60003;

                    BodyText += Text50041 + FORMAT(RecSalesLine."Quantity in Sq. Mt.") + Text60003;

                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT"), 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    IF SalesHeader."D1 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D1) + Text60003;
                    IF SalesHeader."D2 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D2) + Text60003;
                    IF SalesHeader."D3 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D3) + Text60003;
                    IF SalesHeader."D4 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D4) + Text60003;
                    IF SalesHeader."S1 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.S1) + Text60003;
                    IF SalesHeader."D6 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.S1) + Text60003;


                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt", 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    BodyText += Text60004;
                    SrNo += 1;
                UNTIL RecSalesLine.NEXT = 0;
            END;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50039 + Text60003;
            BodyText += Text60004;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");

            IF AppEntry.FINDFIRST THEN;
            IF RecUserSetup.GET(AppEntry."Sender ID") THEN
                BodyText += '[' + RecUserSetup."User Name" + ']';



            BodyText += Text60005;
            BodyText += Text60006;

            BodyText += Text50024 + Text50040 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;

            BodyText += Text60011;
            BodyText += Text59999;
            BodyText += Text60000;

            BodyText += Text50024 + Text50025 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;


            EmailMsg.Create(EmailAddressList, Text50001 + ' ' + SalesHeader."No." + ' [' + RecCustomer.Name + ' - ' + RecCustomer.City + '-' + RecState.Description + ']-' + SalesHeader."Location Code", BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            //MESSAGE(Text50022);
        END;
        //END;

    end;


    procedure ArchiveApprovalEntry(AppEntry: Record "Approval Entry"; xRecAppEntry: Record "Approval Entry")
    var
        ArchApprovalEntry: Record "Archive Approval Entry";
        EntryNo: Integer;
    begin
        ArchApprovalEntry.RESET;
        IF ArchApprovalEntry.FINDLAST THEN
            EntryNo := ArchApprovalEntry."Entry No." + 1
        ELSE
            EntryNo := 1;

        ArchApprovalEntry.INIT;
        ArchApprovalEntry.TRANSFERFIELDS(AppEntry);
        ArchApprovalEntry."Entry No." := EntryNo;
        ArchApprovalEntry."Old Status" := xRecAppEntry.Status;
        ArchApprovalEntry."Approval Date & Time" := CURRENTDATETIME;
        ArchApprovalEntry.INSERT;
    end;

    local procedure ApproveSalesOrder(ApprovalEntry: Record "Approval Entry")
    var
        SalesHeader: Record "Sales Header";
        DocNo: Code[20];
        SP: Record "Salesperson/Purchaser";
        PACApproval: Boolean;
        CreatedBy: Code[20];
        UserSetup: Record "User Setup";
        TableID: Integer;
        ProcessSalesOrders: Codeunit "Process Sales Orders";
    begin
        DocNo := ApprovalEntry."Document No.";
        IF PACApproval THEN BEGIN
            ApprovalEntryPAC.RESET;
            ApprovalEntryPAC.SETRANGE("Document No.", DocNo);
            IF ApprovalEntryPAC.FINDFIRST THEN BEGIN
                REPEAT
                    IF ApprovalEntryPAC.Status = ApprovalEntryPAC.Status::Created THEN BEGIN
                        ApprovalEntryPAC.VALIDATE(Status, ApprovalEntryPAC.Status::Approved);
                        ArchiveApprovalEntry(ApprovalEntry, ApprovalEntry);    //msks
                                                                               //ApprovalEntryPAC."Comment Text" := 'PAC APPROVAL1';
                        ApprovalEntryPAC.MODIFY;
                    END;
                UNTIL ApprovalEntryPAC.NEXT = 0;
            END;
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN BEGIN
                SalesHeader.Status := SalesHeader.Status::"Price Approved";
                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                SalesHeader."Price Approved" := TRUE;
                CLEAR(ProcessSalesOrders);
                ProcessSalesOrders.CreateSalesOrderLog(SalesHeader."No.", 2, FALSE, FALSE);
                SalesHeader.MODIFY;

                CLEAR(SMSMgt);
                SMSMgt.CreateMsgOnDApriceApproved(SalesHeader); //MSKS2707

            END;
        END;
        //New Code Added for PAC Approval.
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Created);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            CLEAR(MailMgt);
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN BEGIN
                MailMgt.CreateMailForPO(SalesHeader, ApprovalEntry."Approver Code");
                IF SP.GET(ApprovalEntry."Approver Code") THEN BEGIN
                    CASE SP.Type OF
                        SP.Type::PCH:
                            BEGIN
                                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PCH;
                                SalesHeader.MODIFY;
                            END;
                        SP.Type::"Zone Manager":
                            BEGIN
                                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::ZM;
                                SalesHeader.MODIFY;
                            END;
                        SP.Type::PSM:
                            BEGIN
                                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PSM;
                                SalesHeader.MODIFY;
                            END;
                        SP.Type::PAC:
                            BEGIN
                                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PAC;
                                SalesHeader.MODIFY;
                            END;

                    END;
                END;

            END;
        END ELSE BEGIN
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN BEGIN
                SalesHeader.Status := SalesHeader.Status::"Price Approved";
                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                SalesHeader."Price Approved" := TRUE;
                CLEAR(ProcessSalesOrders);
                ProcessSalesOrders.CreateSalesOrderLog(SalesHeader."No.", 2, FALSE, FALSE);

                SalesHeader.MODIFY;
                CLEAR(MailMgt);
                IF SP.GET('DAAPP') THEN
                    IF SP."E-Mail" <> '' THEN
                        MailMgt.CreateMailForPO(SalesHeader, 'DAAPP');

                IF CreatedBy <> '' THEN BEGIN
                    IF UserSetup.GET(CreatedBy) THEN
                        IF UserSetup."E-Mail" <> '' THEN
                            MailMgt.CreateMailForCreator(SalesHeader, UserSetup."E-Mail");
                END;
            END;
        END;
    end;


    procedure MakeApprovalEntry(TableID: Integer; DocNo: Code[20]; ApprovalType: Option "Workflow User Group","Sales Pers./Purchaser",Approver; SenderSPCode: Code[20]; ApprovalSPCode: Code[20]; DiscountAmt: Decimal; LastEmailID: Text)
    var
        ApprovalEntry: Record "Approval Entry";
        //  ApprovalSetup: Record 452;
        EntryNo: Integer;
        SalesHeader: Record "Sales Header";
        NewSequenceNo: Integer;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        IndentHeader: Record "Indent Header";
        PurchaseHeader: Record "Purchase Header";
        UserSetup: Record "User Setup";
        BudgetMaster: Record "Budget Master";
    begin
        WITH ApprovalEntry DO BEGIN
            ApprovalEntry.RESET;
            IF ApprovalEntry.FINDLAST THEN
                EntryNo := ApprovalEntry."Entry No.";

            SETRANGE("Table ID", TableID);
            SETRANGE("Document No.", DocNo);
            IF FINDLAST THEN BEGIN
                NewSequenceNo := "Sequence No." + 1;
                LastEmailID := EmailID;
            END ELSE
                NewSequenceNo := 1;
            "Entry No." := EntryNo + 1;
            "Table ID" := TableID;
            "Document Type" := "Document Type"::Order;
            "Document No." := DocNo;
            "Salespers./Purch. Code" := SenderSPCode;
            "Sequence No." := NewSequenceNo;

            "Sender ID" := USERID;
            Amount := DiscountAmt;
            "Amount (LCY)" := DiscountAmt;
            Status := Status::Created;
            "Currency Code" := "Currency Code";
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID1" := USERID;
            // 15578  "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            ApprovalEntry."Approver ID" := ApprovalSPCode;
            ApprovalEntry."Approver Code" := ApprovalSPCode;
            ApprovalEntry."Comment Text" := '';
            ApprovalEntry."Approval Type" := ApprovalType;
            IF ApprovalType = ApprovalType::"Sales Pers./Purchaser" THEN BEGIN
                IF SalespersonPurchaser.GET(ApprovalSPCode) THEN
                    IF SalespersonPurchaser."E-Mail" <> '' THEN
                        ApprovalEntry.EmailID := SalespersonPurchaser."E-Mail";
            END ELSE BEGIN
                IF UserSetup.GET(ApprovalEntry."Approver ID") THEN
                    IF UserSetup."E-Mail" <> '' THEN
                        ApprovalEntry.EmailID := UserSetup."E-Mail";
            END;
            CASE TableID OF
                36:
                    BEGIN
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SETRANGE("No.", DocNo);
                        IF SalesHeader.FINDFIRST THEN
                            ApprovalEntry."Record ID to Approve" := SalesHeader.RECORDID;
                        "Approval Code" := 'S-ORDER';
                    END;
                38:
                    BEGIN
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("No.", DocNo);
                        IF PurchaseHeader.FINDFIRST THEN
                            ApprovalEntry."Record ID to Approve" := PurchaseHeader.RECORDID;
                        "Approval Code" := 'P-ORDER';
                    END;

                50016:
                    BEGIN
                        IndentHeader.RESET;
                        IndentHeader.SETRANGE("No.", DocNo);
                        IF IndentHeader.FINDFIRST THEN
                            ApprovalEntry."Record ID to Approve" := IndentHeader.RECORDID;
                        "Approval Code" := 'INDENT';
                    END;
                50084:
                    BEGIN
                        BudgetMaster.RESET;
                        BudgetMaster.SETRANGE("No.", DocNo);
                        IF BudgetMaster.FINDFIRST THEN
                            ApprovalEntry."Record ID to Approve" := BudgetMaster.RECORDID;
                        "Approval Code" := 'BUDGET';
                    END;

            END;
            //IF LastEmailID <> ApprovalEntry.EmailID THEN
            INSERT(TRUE);
        END;
    end;


    procedure CancelApprovalEntries(TableID: Integer; DocNo: Code[20])
    var
        ApprovalEntries: Record "Approval Entry";
        IndentHeader: Record "Indent Header";
    begin
        ApprovalEntries.RESET;
        ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", TableID);
        //ApprovalEntries.SETRANGE(ApprovalEntries."Document Type",ApprovalEntries."Document Type"::Order);
        ApprovalEntries.SETRANGE("Document No.", DocNo);
        IF ApprovalEntries.FINDFIRST THEN BEGIN
            REPEAT
                ApprovalEntries.VALIDATE(Status, ApprovalEntries.Status::Cancelled);
                ApprovalEntries.MODIFY;
            UNTIL ApprovalEntries.NEXT = 0;

            //MSVRN 170818 >>
            CASE TableID OF
                50016:
                    BEGIN
                        IndentHeader.RESET;
                        IndentHeader.SETRANGE("No.", DocNo);
                        IF IndentHeader.FINDFIRST THEN BEGIN
                            IndentHeader.CancelIndentApprovalEnt(IndentHeader."No.");
                            SendMailRejection(IndentHeader);
                        END;
                    END;
            END;
        END;
    end;

    local procedure "--MSVRN--"()
    begin
    end;


    procedure CancelIndentApprovalEnt(IndentNo: Code[20])
    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        UserLocation: Record "User Location";
    begin
        IndentHeader.RESET;
        IndentHeader.SETRANGE("No.", IndentNo);
        IF IndentHeader.FINDFIRST THEN;

        IndentHeader."Reason of Rejection" := 'Rejected !'; //MSVRN >><<
        IndentHeader.MODIFY(TRUE);
        IndentHeader.TESTFIELD("Reason of Rejection");

        CLEAR(EmailN);
        SLEEP(1000);
        //EmailN.SendMail(Rec);

        //IF IndentHeader."Authorization 3" <> UPPERCASE(USERID) THEN BEGIN
        IndentLine.RESET;
        IndentLine.SETFILTER(IndentLine."Document No.", '%1', IndentHeader."No.");
        IndentLine.SETFILTER(IndentLine."Order No.", '<>%1', '');
        IF IndentLine.FIND('-') THEN
            ERROR('You cannot Cancel Indent %1 as Purchase Order Details exist for any of the lines. Please Delete the Indent.', IndentHeader."No."
           );
        //END;
        //IF Status <> Status::Authorization3 THEN
        // ERROR('Status must be authorized to close the Indent');

        //IF CONFIRM('Do you want to Close Indent %1?',TRUE,"No.") THEN BEGIN //MSVRN --Open
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."Location Code", IndentHeader."Location Code");
        UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);
        IF UserLocation.FIND('-') THEN BEGIN
            IndentHeader.VALIDATE(Status, IndentHeader.Status::Closed);
            IndentHeader.MODIFY;

            /*
            //MSVRN >>
            SendMailRejection(IndentHeader);
            //MSVRN <<
            */

            IndentLine.RESET;
            IndentLine.SETFILTER(IndentLine."Document No.", '%1', IndentHeader."No.");
            IndentLine.SETFILTER(IndentLine."Order No.", '%1', '');
            IF IndentLine.FIND('-') THEN
                REPEAT
                    IndentLine.Deleted := TRUE;
                    IndentLine.MODIFY;
                UNTIL IndentLine.NEXT = 0;
        END ELSE BEGIN
            MESSAGE('You are not authorized to Close this indent');
        END;
        MESSAGE('Indent %1 is available as Archived.', IndentHeader."No.");
        //END;

    end;


    procedure SendMailRejection(RecIndentHeader: Record "Indent Header")
    var
        RecIndentHeader1: Record "Indent Header";
        // SMTPMailCodeUnit: Codeunit 400;
        Subject: Text[100];
        EmailTo: Text[500];
        EmailCC: Text[500];
        EmailBCC: Text[500];
        CCMail: Text[500];
        RecUserSetup: Record "User Setup";
        cLocation: Record Location;
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        IndentText: Text[150];
        IndentDesc: Text[150];
        IndentRemarks: Text[150];
        EmailToName: Text[100];
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

        CLEAR(EmailTo);
        CLEAR(EmailCC);
        CLEAR(EmailBCC);
        EmailToName := '';
        //CLEAR(CCMail);

        // CLEAR(SMTPMailCodeUnit);

        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE("No.", RecIndentHeader."No.");
        IF RecIndentHeader1.FINDFIRST THEN BEGIN
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
                IF RecUserSetup.GET(RecIndentHeader."User ID") THEN
                    EmailTo := RecUserSetup."E-Mail";

                //CCMail:=Text50002;
                //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                RecIndentHeader1."Mail Authorization1" := TRUE;
                RecIndentHeader1.MODIFY;
            END ELSE
                IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
                    IF RecUserSetup.GET(RecIndentHeader."User ID") THEN
                        EmailTo := RecUserSetup."E-Mail";

                    IF RecUserSetup.GET(RecIndentHeader."Authorization 1") THEN
                        EmailCC := EmailCC + RecUserSetup."E-Mail";

                    //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                    RecIndentHeader1."Mail Authorization2" := TRUE;
                    RecIndentHeader1.MODIFY;
                END ELSE
                    IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
                        IF RecUserSetup.GET(RecIndentHeader."Authorization 1") THEN
                            EmailCC := EmailCC + RecUserSetup."E-Mail";

                        IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                            EmailTo := EmailTo + RecUserSetup."E-Mail";

                        IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
                            EmailCC := EmailCC + RecUserSetup."E-Mail";

                        //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                        RecIndentHeader1."Mail Authorization3" := TRUE;
                        RecIndentHeader1.MODIFY;
                    END;

            //  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
            // EmailTo, 'Rejection Mail' + RecIndentHeader."No.", '', TRUE);
            // SMTPMailCodeUnit.AppendBody('Dear ' +EmailToName );
            BodyText := 'Dear Sir, ';
            BodyText += Text50010;
            BodyText += FORMAT(RecIndentHeader."No.") + 'has been Rejected.';
            BodyText += Text50010;
            BodyText += Text50010;
            BodyText += Text50000;
            BodyText += Text50010;
            BodyText += Text50011;
            BodyText += IndentDesc;
            BodyText += Text50010;
            BodyText += Text50012;
            BodyText += IndentRemarks;
            IF EmailCC <> '' THEN
                EmailCCList.add(EmailCC);
            EmailMsg.Create(EmailAddressList, 'Rejection Mail' + RecIndentHeader."No.", BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            MESSAGE('Mail Sent For Rejection');
            // PCHMailed:=TRUE;

        END;
        // else
        // Message('');
        // END;

        /*
       //CLEAR(SMTPMailCodeUnit);
         // PCHMailed:=FALSE;
       CLEAR(SMTPMailCodeUnit);
       ReSIH.RESET;
       ReSIH.SETRANGE("No.",SalesInvHeader."No.");
       ReSIH.SETRANGE("PCH Mailed",FALSE);
       ReSIH.SETFILTER("Posting Date",'>=%1',280213D);
       IF ReSIH.FINDFIRST THEN BEGIN
         IF RecCustomer.GET(SalesInvHeader."Sell-to Customer No.") THEN
         BEGIN
          SalesInvHeader.CALCFIELDS("Amount to Customer","Qty In carton","Sq. Meter");
          SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',
          RecCustomer."PCH E-Maill ID",'Sales Invocie','',TRUE);
          SMTPMailCodeUnit.AppendBody(Text50000);
          SMTPMailCodeUnit.AppendBody(RecCustomer."PCH Name");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50001);
          SMTPMailCodeUnit.AppendBody(Text50002);
          SMTPMailCodeUnit.AppendBody(Text50011);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Sell-to Customer No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50012);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Bill-to Name");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50013);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Amount to Customer"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50019);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Order Date"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50020);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Order No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50014);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Posting Date"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50015);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50016);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Qty In carton"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50031);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Sq. Meter"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50017);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Transporter Name");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50018);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Truck No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50004);
          SMTPMailCodeUnit.AppendBody(Text50005);
          SMTPMailCodeUnit.AppendBody(Text50006);
          SMTPMailCodeUnit.AppendBody(Text50007);
          SMTPMailCodeUnit.AppendBody(Text50008);
          SMTPMailCodeUnit.AppendBody(Text50009);
          SMTPMailCodeUnit.Send();
          MESSAGE('Mail Sent');
          PCHMailed:=TRUE;

         END;
       END ELSE BEGIN
         IF SalesInvHeader."Posting Date" <= 011713D THEN;

           MESSAGE('Already sent the mail to PCH Head');
       END;

       ReSIH.RESET;
       ReSIH.SETRANGE("No.",SalesInvHeader."No.");
       IF ReSIH.FINDFIRST THEN
       BEGIN
          ReSIH."PCH Mailed":=PCHMailed;
       //   ReSIH."Invoiced Mailed":=PCHMailed;
          ReSIH.MODIFY;
       END;
        */

    end;

    local procedure "--PurchaseApproval--"()
    begin
    end;


    procedure PurchaseApproval(ApprovalEntry: Record "Approval Entry")
    var
        AppApprovalEntry: Record "Approval Entry";
    begin
        AppApprovalEntry.RESET;
        AppApprovalEntry.SETRANGE("Document No.", ApprovalEntry."Document No.");
        AppApprovalEntry.SETRANGE("Table ID", 38);
        AppApprovalEntry.SETRANGE(Status, AppApprovalEntry.Status::Created);
        IF AppApprovalEntry.FINDFIRST THEN BEGIN
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
                IndentRelease.SendNotificationforPurch(PurchaseHeader);
                SendPOMialApproval(PurchaseHeader);
            END;
        END ELSE BEGIN
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
                // 15578 IndentRelease.SendNotificationforPurch(PurchaseHeader);

                PurchaseHeader.Status := PurchaseHeader.Status::Released;
                PurchaseHeader."Approval Status" := PurchaseHeader."Approval Status"::Approved;
                PurchaseHeader."Approver ID" := '';
                PurchaseHeader.MODIFY;
                SendPOMialApproval(PurchaseHeader);
                SendPONotification(PurchaseHeader)
            END;
        END;
    end;


    procedure CancelPurchaseApprovalEnt(PurchOrdNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        UserLocation: Record "User Location";
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 38);
        ApprovalEntry.SETRANGE("Document No.", PurchOrdNo);
        IF ApprovalEntry.FINDSET THEN
            REPEAT
                ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Rejected);
                ApprovalEntry.MODIFY;
            UNTIL ApprovalEntry.NEXT = 0;

        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE(PurchaseHeader."No.", PurchOrdNo);
        IF PurchaseHeader.FINDFIRST THEN BEGIN
            PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Open);
            PurchaseHeader."Approval Status" := PurchaseHeader."Approval Status"::"Not Approved";
            PurchaseHeader."Approver ID" := '';
            PurchaseHeader."Approver Name" := '';
            PurchaseHeader.MODIFY;
            SendPOMailRejection(PurchaseHeader); //MSAK
        END;
    end;


    procedure SendPOMailRejection(PurchaseHeader: Record "Purchase Header")
    var
        // SMTPMailCodeUnit: Codeunit 400;
        Subject: Text[100];
        EmailTo: Text[500];
        EmailCC: Text[500];
        EmailBCC: Text[500];
        CCMail: Text[500];
        RecUserSetup: Record "User Setup";
        cLocation: Record Location;
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Puchase Order Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text50013: Label 'Reason:';
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
        Text50027: Label '<table border="1" width="70%">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width=5 Align=Center>';
        POText: Text[150];
        PODesc: Text[150];
        PORemarks: Text[150];
        EmailToName: Text[100];
        PurchaseLine3: Record "Purchase Line";
        Amt2: Decimal;
        SrNo: Integer;
        PurchaseLine: Record "Purchase Line";
        Amt: Decimal;
        ApprovalEntry1: Record "Approval Entry";
        rIndentHeader: Record "Indent Header";
        rPurchaseLine: Record "Purchase Line";
        xIndentNo: Code[20];
        recApprovalEntry: Record "Approval Entry";
        intSequeNo: Integer;
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


        CLEAR(EmailTo);
        CLEAR(EmailCC);
        CLEAR(EmailBCC);
        EmailToName := '';
        //CLEAR(CCMail);

        // CLEAR(SMTPMailCodeUnit);

        IF RecUserSetup.GET(PurchaseHeader."User Id") THEN
            EmailTo := RecUserSetup."E-Mail";

        // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
        // EmailTo, 'Rejection Mail ' + PurchaseHeader."No.", '', TRUE);

        //Keshav25062020
        intSequeNo := 0;
        recApprovalEntry.RESET;
        recApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
        recApprovalEntry.SETRANGE(Status, recApprovalEntry.Status::Rejected);
        IF recApprovalEntry.FINDLAST THEN
            intSequeNo := recApprovalEntry."Sequence No.";

        IF PurchaseHeader.Status = PurchaseHeader.Status::Open THEN BEGIN
            recApprovalEntry.RESET;
            recApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
            recApprovalEntry.SETRANGE(Status, recApprovalEntry.Status::Rejected);
            recApprovalEntry.SETFILTER("Sequence No.", '<%1', intSequeNo);
            IF recApprovalEntry.FIND('-') THEN BEGIN
                REPEAT
                    EmailCCList.add(recApprovalEntry.EmailID);
                UNTIL recApprovalEntry.NEXT = 0;
            END;
        END;
        //Keshav25062020

        //MSAK
        BodyText := 'Dear Sir,';
        BodyText += Text50010;
        PurchaseLine3.SETRANGE("Document No.", PurchaseHeader."No.");
        IF PurchaseLine3.FINDFIRST THEN
            REPEAT
                Amt2 += PurchaseLine3.Amount;
            UNTIL PurchaseLine3.NEXT = 0;

        //MSAK Kulbhushan

        BodyText += '<br><br>';
        BodyText += 'The Purchase Order No. ' + FORMAT(PurchaseHeader."No.") + ' amounting Rs. ' + FORMAT(Amt2) + ' has been rejected by '
        + PurchaseHeader."Approver Name" + 'for location ' + PurchaseHeader."Location Code" + '.';

        BodyText += ' The details of Purchasing Items are listed below:';
        BodyText += '<br><br>';

        ApprovalEntry1.RESET;
        ApprovalEntry1.SETRANGE("Table ID", 38);
        ApprovalEntry1.SETRANGE("Document No.", PurchaseHeader."No.");
        ApprovalEntry1.SETRANGE(Status, ApprovalEntry1.Status::Rejected);
        ApprovalEntry1.SETFILTER("Comment Text", '<>%1', '');
        IF ApprovalEntry1.FINDLAST THEN
            BodyText += '<b>Authorizer Remarks: ' + ApprovalEntry1."Comment Text" + '</b><br><br>';

        BodyText += '<br><br>';
        //Table Start
        BodyText += Text60005;
        BodyText += Text60006;
        BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Indent No.' + Text60013 + Text60003;
        SrNo := 1;
        BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003;
        BodyText += Text50041 + Text60012 + 'Rate' + Text60013 + Text60003;
        BodyText += Text50041 + Text60012 + 'Amount' + Text60013 + Text60003;
        BodyText += Text60004;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        IF PurchaseLine.FINDFIRST THEN BEGIN
            REPEAT
                BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."No.") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."Indent No.") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine.Description) + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."Description 2") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine.Quantity) + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."Unit Cost (LCY)") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine.Amount) + Text60003;
                BodyText += Text60004;
                SrNo += 1;
                Amt += PurchaseLine.Amount;
            UNTIL PurchaseLine.NEXT = 0;
        END;
        //
        //MSKS
        BodyText += Text50026 + Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('Total') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003; //MSAK
        BodyText += Text50041 + FORMAT(Amt) + Text60003;
        BodyText += Text60004;
        //MSKS
        BodyText += Text60004;
        BodyText += Text60005;
        BodyText += Text60006;
        BodyText += Text60011;
        //Table End
        BodyText += Text60011;
        //MSAK
        //BodyText +='Answer: ,<br><br>');
        //MSAK
        BodyText += 'Yours Truely, <br>';
        BodyText += 'For Orient Bell Limited  <br>';
        //MSAK
        //Keshav22042020
        xIndentNo := '';
        rPurchaseLine.RESET;
        rPurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        IF rPurchaseLine.FIND('-') THEN BEGIN
            REPEAT
                rIndentHeader.RESET;
                rIndentHeader.SETRANGE("No.", rPurchaseLine."Indent No.");
                IF rIndentHeader.FIND('-') THEN BEGIN
                    IF rIndentHeader."No." <> xIndentNo THEN BEGIN
                        xIndentNo := rIndentHeader."No.";
                        RecUserSetup.RESET;
                        RecUserSetup.GET(rIndentHeader."User ID");
                        IF RecUserSetup."E-Mail" <> '' THEN
                            EmailCCList.add(RecUserSetup."E-Mail");
                    END;
                END;
            UNTIL rPurchaseLine.NEXT = 0;
        END;

        // IF EmailCC<>'' THEN BEGIN
        // SMTPMailCodeUnit.AddCC(EmailCC);
        // END;
        //Keshav22042020
        IF EmailBCC <> '' THEN
            EmailCCList.add(EmailBCC);

        SLEEP(100);
        EmailMsg.Create(EmailAddressList, 'Rejection Mail ' + PurchaseHeader."No.", BodyText, true, EmailBccList, EmailCCList);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        SLEEP(500);
        IF GUIALLOWED THEN
            MESSAGE('Mail Sent For Rejection');
    end;

    local procedure "-----KeshavPOMailApproval--------"()
    begin
    end;


    procedure SendPOMialApproval(rPurchHeader: Record "Purchase Header")
    var
        // cduSMTPMail: Codeunit "400";
        rUserSetup: Record "User Setup";
        txtEmailID: Text;
        rPurchaseLine: Record "Purchase Line";
        rIndentHeader: Record "Indent Header";
        rApprovalEntry: Record "Approval Entry";
        xIndentNo: Text;
        IndentList: Text;
        recApprovalEntry: Record "Approval Entry";
        txtApprName: Text;
        recUser: Record User;
        AttachmentManagment: Record "Attachment Management";
        FilePath: Text;
        FileName: Text;
        ApprovalEntry1: Record "Approval Entry";
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Puchase Order Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text50013: Label 'Reason:';
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
        Text50027: Label '<table border="1" width="70%">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width=5 Align=Center>';
        SrNo: Integer;
        PurchaseLine: Record "Purchase Line";
        Amt: Decimal;
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

        ///   CLEAR(cduSMTPMail);
        rUserSetup.RESET;
        IF rUserSetup.GET(rPurchHeader."User Id") THEN
            rUserSetup.TESTFIELD("E-Mail");
        txtEmailID := rUserSetup."E-Mail";

        /*  cduSMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                    txtEmailID, 'Approval Mail ' + rPurchHeader."No.", '', TRUE);*/ // 15578
        EmailAddressList.add('donotreply@orientbell.com');
        xIndentNo := '';
        IndentList := '';
        rPurchaseLine.RESET;
        rPurchaseLine.SETRANGE("Document No.", rPurchHeader."No.");
        rPurchaseLine.SETFILTER("Indent No.", '<>%1', '');
        IF rPurchaseLine.FIND('-') THEN BEGIN
            rPurchaseLine.SETCURRENTKEY("No.", "Indent No.", "Indent Line No.", Status);
            REPEAT
                IF xIndentNo = '' THEN
                    xIndentNo := rPurchaseLine."Indent No." ELSE
                    xIndentNo := xIndentNo + '|' + rPurchaseLine."Indent No.";
            UNTIL rPurchaseLine.NEXT = 0;
            rIndentHeader.RESET;
            rIndentHeader.SETFILTER("No.", xIndentNo);
            IF rIndentHeader.FINDFIRST THEN BEGIN
                REPEAT
                    RecUserSetup.RESET;
                    IF RecUserSetup.GET(rIndentHeader."User ID") THEN
                        IF RecUserSetup."E-Mail" <> '' THEN
                            EmailCCList.add(RecUserSetup."E-Mail");
                    IF IndentList = '' THEN
                        IndentList := rIndentHeader."No." ELSE
                        IndentList += ',' + rIndentHeader."No.";
                UNTIL rIndentHeader.NEXT = 0;
            END;
        END;
        //keshav 08062020
        IF PurchaseHeader.Status = PurchaseHeader.Status::Released THEN BEGIN
            rApprovalEntry.RESET;
            rApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
            rApprovalEntry.SETRANGE(Status, rApprovalEntry.Status::Approved);
            IF rApprovalEntry.FIND('-') THEN BEGIN
                REPEAT
                    RecUserSetup.RESET;
                    IF RecUserSetup.GET(rApprovalEntry."Approver ID") THEN
                        IF RecUserSetup."E-Mail" <> '' THEN
                            EmailCCList.add(RecUserSetup."E-Mail");
                    txtApprName := rUserSetup."User Name";
                UNTIL rApprovalEntry.NEXT = 0;
            END;
        END;
        //keshav 08062020 As per Sharma G
        BodyText := ' Dear Sir / Madam, ';
        BodyText += '<br><br>';
        BodyText += 'Purchase Order : ' + rPurchHeader."No.";
        BodyText += ' List of Indent : ' + IndentList;
        //IF rPurchHeader.Status = rPurchHeader.Status::Approved THEN
        BodyText += ' has been Approved by : ' + rPurchHeader."Approver Name" + ' for Vendor Name ' + rPurchHeader."Buy-from Vendor Name";
        //IF rPurchHeader.Status = rPurchHeader.Status::Ope THEN
        //  BodyText +=' has been Rejected by : '+txtApprName);

        ApprovalEntry1.RESET;
        ApprovalEntry1.SETRANGE("Table ID", 38);
        ApprovalEntry1.SETRANGE("Document No.", PurchaseHeader."No.");
        ApprovalEntry1.SETRANGE(Status, ApprovalEntry1.Status::Approved);
        ApprovalEntry1.SETFILTER("Comment Text", '<>%1', '');
        IF ApprovalEntry1.FINDLAST THEN
            BodyText += ' <b>Authorizer Remarks: ' + ApprovalEntry1."Comment Text" + '</b><br><br>';

        BodyText += ' The details of Purchasing Items are listed below:';
        BodyText += '<br><br>';

        ApprovalEntry1.RESET;
        ApprovalEntry1.SETRANGE("Table ID", 38);
        ApprovalEntry1.SETRANGE("Document No.", PurchaseHeader."No.");
        ApprovalEntry1.SETRANGE(Status, ApprovalEntry1.Status::Rejected);
        ApprovalEntry1.SETFILTER("Comment Text", '<>%1', '');
        IF ApprovalEntry1.FINDLAST THEN
            //cduSMTPMail.AppendBody('<b>Authorizer Remarks: ' +ApprovalEntry1."Comment Text" + '</b><br><br>');

            BodyText += '<br><br>';
        //Table Start
        BodyText += Text60005;
        BodyText += Text60006;
        BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Indent No.' + Text60013 + Text60003;
        SrNo := 1;
        BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003;
        BodyText += Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003;
        BodyText += Text50041 + Text60012 + 'Rate' + Text60013 + Text60003;
        BodyText += Text50041 + Text60012 + 'Amount' + Text60013 + Text60003;
        BodyText += Text60004;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        IF PurchaseLine.FINDFIRST THEN BEGIN
            REPEAT
                BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."No.") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."Indent No.") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine.Description) + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."Description 2") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine.Quantity) + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine."Unit Cost (LCY)") + Text60003;
                BodyText += Text50041 + FORMAT(PurchaseLine.Amount) + Text60003;
                BodyText += Text60004;
                SrNo += 1;
                Amt += PurchaseLine.Amount;
            UNTIL PurchaseLine.NEXT = 0;
        END;
        //
        //MSKS
        BodyText += Text50026 + Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('Total') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003; //MSAK
        BodyText += Text50041 + FORMAT(Amt) + Text60003;
        BodyText += Text60004;
        //MSKS
        BodyText += Text60004;
        BodyText += Text60005;
        BodyText += Text60006;
        BodyText += Text60011;
        //Table End
        BodyText += Text60011;

        BodyText += '<br><br>';
        BodyText += '<br><br>';
        // 15578  BodyText += 'Yours Truely', '<br>';
        BodyText += '<br><br>';
        BodyText += 'For Orient Bell Limited  <br>';
        //Keshav_Add_Attchment27042020
        AttachmentManagment.ExportAttachmentAsFile(PurchaseHeader.RECORDID, FilePath, FileName);
        // if File.Exists(FilePath + '\' + FileName) THEN
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, FilePath + '\' + FileName);
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'Approval Mail ' + rPurchHeader."No.", BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists(FilePath + '\' + FileName) THEN begin
            EmailMsg.AddAttachment(FilePath + '\' + FileName, 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            // end;
        END;

        /* IF FILE.EXISTS(FilePath + '\' + FileName) THEN
             cduSMTPMail.AddAttachment(FilePath + '\' + FileName, FileName);


         /Keshav_Add_Attchment27042020
         cduSMTPMail.AddCC('donotreply@orientbell.com');

         cduSMTPMail.Send;*/ /// 15578
    end;



    procedure GetDocumentInformation(CompanyName: Text; TxtGUID: Text; var OtpMandatory: Text; var Header: Text; var Footer: Text)
    var

        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JsonTextWriter: DotNet JsonTextWriter;
        JsonFormatting: DotNet Formatting;
        GlobalNULL: Variant;
        JsonConvert: DotNet JsonConvert;


        HCaption: array[8] of Text;
        HValues: array[8] of Text;
        fCaption: array[8] of Text;
        FValues: array[8] of Text;
        i: Integer;
        ApprovalEntry: Record "Approval Entry";
        DocNo: Code[20];
        TableId: Integer;
        IndentHeader: Record "Indent Header";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        UserSetup: Record "User Setup";
        HCaptionFontName: array[8] of Text;
        HCaptionFontSize: array[8] of Integer;
        HCaptionFontBold: array[8] of Boolean;
        HTextFontName: array[8] of Text;
        HTextFontSize: array[8] of Integer;
        HTextFontBold: array[8] of Boolean;
        FCaptionFontName: array[8] of Text;
        FCaptionFontSize: array[8] of Integer;
        FCaptionFontBold: array[8] of Boolean;
        FTextFontName: array[8] of Text;
        FTextFontSize: array[8] of Integer;
        FTextFontBold: array[8] of Boolean;
        NextApprovalEntry: Record "Approval Entry";
        NextApproverID: Code[50];
        NextUserSetup: Record "User Setup";
        BudgetMaster: Record "Budget Master";
        VendorRequisition: Record "Vendor Requisition";
        AmountToVendor: Decimal;
        amytocustomer: Codeunit CalcAmttoVendor;
    begin
        IF TxtGUID = '' THEN
            EXIT;

        ApprovalEntry.RESET;
        ApprovalEntry.SETFILTER("GUID Key", '%1', TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            DocNo := ApprovalEntry."Document No.";
            TableId := ApprovalEntry."Table ID";
        END ELSE
            ERROR('Invalid Document!!');

        OtpMandatory := 'False';
        IF TableId <> 36 THEN BEGIN
            ApprovalEntry.RESET;
            ApprovalEntry.SETFILTER("Document No.", '%1', DocNo);
            ApprovalEntry.SETFILTER("Table ID", '%1', TableId);
            ApprovalEntry.SETFILTER(Status, '%1', ApprovalEntry.Status::Created);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                IF UserSetup.GET(ApprovalEntry."Approver ID") THEN
                    IF UserSetup.PIN <> '' THEN
                        OtpMandatory := 'True'
                    ELSE
                        OtpMandatory := 'False'
                ELSE
                    OtpMandatory := 'False';
            END;
        END;
        ApprovalEntry.RESET;
        ApprovalEntry.SETFILTER("Document No.", '%1', DocNo);
        ApprovalEntry.SETFILTER("Table ID", '%1', TableId);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            CASE ApprovalEntry."Table ID" OF
                36:
                    BEGIN
                        SalesHeader.RESET;
                        SalesHeader.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
                        SalesHeader.SETFILTER("No.", '%1', ApprovalEntry."Document No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            HCaption[1] := 'Sales Order No. :';
                            HValues[1] := SalesHeader."No.";
                            HCaption[2] := 'Order Date :';
                            HValues[2] := FORMAT(SalesHeader."Order Date");
                            HCaption[3] := 'Customer No.';
                            HValues[3] := SalesHeader."Sell-to Customer Name";
                            HCaption[4] := 'Branch  :';
                            HValues[4] := SalesHeader."Location Code";
                            HCaption[5] := 'Sales Person  :';
                            HValues[5] := SalesHeader."Salesperson Code";
                            //Footer Information
                            fCaption[1] := 'Order Value :';
                            //     SalesHeader.CALCFIELDS("Amount to Customer");
                            FValues[1] := FORMAT(amytocustomer.AmttoCustomer(SalesHeader));  //15578
                        END;
                    END;
                38:
                    BEGIN
                        NextApproverID := '';
                        NextApprovalEntry.RESET;
                        NextApprovalEntry.SETRANGE("Table ID", 38);
                        NextApprovalEntry.SETFILTER("Document No.", '%1', ApprovalEntry."Document No.");
                        NextApprovalEntry.SETFILTER(Status, '%1', NextApprovalEntry.Status::Created);
                        NextApprovalEntry.SETFILTER("Entry No.", '<>%1', ApprovalEntry."Entry No.");
                        IF NextApprovalEntry.FINDFIRST THEN
                            NextApproverID := NextApprovalEntry."Approver ID";

                        PurchaseHeader.RESET;
                        PurchaseHeader.SETFILTER("Document Type", '%1', PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SETFILTER("No.", '%1', ApprovalEntry."Document No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            GSTCalculation(PurchaseHeader, AmountToVendor);
                            HCaption[1] := 'Purch. Order No. :';
                            HValues[1] := PurchaseHeader."No.";
                            HCaption[2] := 'Order Date :';
                            HValues[2] := FORMAT(PurchaseHeader."Order Date");
                            HCaption[3] := 'Vendor No.';
                            HValues[3] := PurchaseHeader."Buy-from Vendor Name";
                            HCaption[4] := 'Branch  :';
                            HValues[4] := PurchaseHeader."Location Code";
                            HCaption[5] := 'Department  :';
                            HValues[5] := PurchaseHeader."Shortcut Dimension 2 Code";
                            HCaption[6] := 'NOE :';
                            HValues[6] := PurchaseHeader."Tax Area Code";

                            IF NextApproverID <> '' THEN BEGIN
                                IF NextUserSetup.GET(NextApproverID) THEN;
                                HCaption[7] := 'Next Approver:';
                                HValues[7] := NextUserSetup."User Name";
                                HCaptionFontName[7] := 'Arial';
                                HCaptionFontBold[7] := TRUE;
                                HCaptionFontSize[7] := 10;
                                HTextFontName[7] := 'Arial';
                                HTextFontBold[7] := TRUE;
                                HTextFontSize[7] := 10;
                            END;
                            HCaptionFontName[1] := 'Arial';
                            HCaptionFontBold[1] := TRUE;
                            HCaptionFontSize[1] := 10;
                            HTextFontName[1] := 'Arial';
                            HTextFontBold[1] := TRUE;
                            HTextFontSize[1] := 10;

                            HCaptionFontName[2] := 'Arial';
                            HCaptionFontBold[2] := FALSE;
                            HCaptionFontSize[2] := 10;
                            HTextFontName[2] := 'Arial';
                            HTextFontBold[2] := FALSE;
                            HTextFontSize[2] := 10;

                            HCaptionFontName[3] := 'Arial';
                            HCaptionFontBold[3] := TRUE;
                            HCaptionFontSize[3] := 10;
                            HTextFontName[3] := 'Arial';
                            HTextFontBold[3] := TRUE;
                            HTextFontSize[3] := 10;

                            HCaptionFontName[4] := 'Arial';
                            HCaptionFontBold[4] := FALSE;
                            HCaptionFontSize[4] := 10;
                            HTextFontName[4] := 'Arial';
                            HTextFontBold[4] := FALSE;
                            HTextFontSize[4] := 10;


                            HCaptionFontName[5] := 'Arial';
                            HCaptionFontBold[5] := TRUE;
                            HCaptionFontSize[5] := 10;
                            HTextFontName[5] := 'Arial';
                            HTextFontBold[5] := TRUE;
                            HTextFontSize[5] := 10;

                            HCaptionFontName[6] := 'Arial';
                            HCaptionFontBold[6] := FALSE;
                            HCaptionFontSize[6] := 10;
                            HTextFontName[6] := 'Arial';
                            HTextFontBold[6] := FALSE;
                            HTextFontSize[6] := 10;

                            //Footer Information
                            fCaption[1] := 'Order Value :';

                            FValues[1] := FORMAT(AmountToVendor);

                            FCaptionFontName[1] := 'Arial';
                            FCaptionFontBold[1] := FALSE;
                            FCaptionFontSize[1] := 10;
                            FTextFontName[1] := 'Arial';
                            FTextFontBold[1] := TRUE;
                            FTextFontSize[1] := 10;
                        END;
                    END;
                50016:
                    BEGIN
                        IndentHeader.RESET;
                        IndentHeader.SETFILTER("No.", '%1', ApprovalEntry."Document No.");
                        IF IndentHeader.FINDFIRST THEN BEGIN
                            HCaption[1] := 'Indent No. :';
                            HValues[1] := IndentHeader."No.";
                            HCaption[2] := 'Indent Date :';
                            HValues[2] := FORMAT(IndentHeader."Indent Date");
                            HCaption[3] := 'Requested By';
                            HValues[3] := IndentHeader."Created By";
                            HCaption[4] := 'Branch  :';
                            HValues[4] := IndentHeader."Location Code";
                            HCaption[5] := 'Department  :';
                            HValues[5] := IndentHeader."Dept Name";
                            HCaption[6] := 'Plant  :';
                            HValues[6] := IndentHeader."Plant Code";
                            IF IndentHeader."Capex No." <> '' THEN BEGIN
                                HCaption[7] := 'CAPEX No.  :';
                                HValues[7] := IndentHeader."Capex No.";
                            END;

                            //Footer Information
                            fCaption[1] := 'Indent Value (Rs) :';
                            IndentHeader.CALCFIELDS(Amount);
                            FValues[1] := FORMAT(IndentHeader.Amount);
                        END;

                    END;
                50084:
                    BEGIN
                        BudgetMaster.RESET;
                        BudgetMaster.SETFILTER("No.", '%1', ApprovalEntry."Document No.");
                        IF BudgetMaster.FINDFIRST THEN BEGIN
                            HCaption[1] := 'Capex No. :';
                            HValues[1] := BudgetMaster."No.";
                            HCaption[2] := 'Doc. Date :';
                            HValues[2] := FORMAT(BudgetMaster."Created Date & Time");
                            HCaption[3] := 'Requested By';
                            IF UserSetup.GET(BudgetMaster."Created By") THEN
                                HValues[3] := UserSetup."User Name"
                            ELSE
                                HValues[3] := BudgetMaster."Created By";
                            HCaption[4] := 'Est. Start Dt.:';
                            HValues[4] := FORMAT(BudgetMaster."Estimated Start Date");
                            HCaption[5] := 'Est.Finish Dt.:';
                            HValues[5] := FORMAT(BudgetMaster."Estimated Completion Date");
                            HCaption[7] := 'Project Name:';
                            HValues[7] := FORMAT(BudgetMaster."Project Name");

                            //Footer Information
                            fCaption[1] := 'Capex Value (Rs) :';
                            FValues[1] := FORMAT(BudgetMaster."Investment (In INR)");
                        END;
                    END;
                50062:
                    BEGIN
                        VendorRequisition.RESET;
                        VendorRequisition.SETFILTER("No.", '%1', ApprovalEntry."Document No.");
                        IF VendorRequisition.FINDFIRST THEN BEGIN
                            HCaption[1] := 'Vendor No. :';
                            HValues[1] := VendorRequisition."No.";
                            HCaption[2] := 'Vendor Name :';
                            HValues[2] := FORMAT(VendorRequisition.Name);
                            HCaption[3] := 'Requested By';
                            HValues[3] := VendorRequisition."Created By";
                            HCaption[4] := 'Address :';
                            HValues[4] := FORMAT(VendorRequisition.Address);
                            HCaption[5] := 'Address 2  :';
                            HValues[5] := FORMAT(VendorRequisition."Address 2");

                            //Footer Information
                            fCaption[1] := 'City :';
                            FValues[1] := FORMAT(VendorRequisition.City);
                        END;

                    END;

            END;
        END
        ELSE
            ERROR('Expired Document');

        CLEAR(StringBuilder);
        CLEAR(StringWriter);
        CLEAR(JsonTextWriter);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
        JsonTextWriter.Formatting := JsonFormatting.Indented;

        FOR i := 1 TO ARRAYLEN(HCaption) DO BEGIN
            JsonTextWriter.WritePropertyName('HCaption' + FORMAT(i));
            JsonTextWriter.WriteValue(HCaption[i]);

            JsonTextWriter.WritePropertyName('HText' + FORMAT(i));
            JsonTextWriter.WriteValue(HValues[i]);
            JsonTextWriter.WritePropertyName('HCaptionFontName' + FORMAT(i));
            JsonTextWriter.WriteValue(HCaptionFontName[i]);

            JsonTextWriter.WritePropertyName('HCaptionFontSize' + FORMAT(i));
            JsonTextWriter.WriteValue(HCaptionFontSize[i]);

            JsonTextWriter.WritePropertyName('HCaptionFontBold' + FORMAT(i));
            JsonTextWriter.WriteValue(HCaptionFontBold[i]);


            JsonTextWriter.WritePropertyName('HTextFontName' + FORMAT(i));
            JsonTextWriter.WriteValue(HTextFontName[i]);

            JsonTextWriter.WritePropertyName('HTextFontSize' + FORMAT(i));
            JsonTextWriter.WriteValue(HTextFontSize[i]);

            JsonTextWriter.WritePropertyName('HTextFontBold' + FORMAT(i));
            JsonTextWriter.WriteValue(HTextFontBold[i]);
        END;
        Header := '{' + StringBuilder.ToString() + '}';

        CLEAR(StringBuilder);
        CLEAR(StringWriter);
        CLEAR(JsonTextWriter);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
        JsonTextWriter.Formatting := JsonFormatting.Indented;

        FOR i := 1 TO ARRAYLEN(fCaption) DO BEGIN
            JsonTextWriter.WritePropertyName('FCaption' + FORMAT(i));
            JsonTextWriter.WriteValue(fCaption[i]);

            JsonTextWriter.WritePropertyName('FText' + FORMAT(i));
            JsonTextWriter.WriteValue(FValues[i]);

            JsonTextWriter.WritePropertyName('FCaptionFontName' + FORMAT(i));
            JsonTextWriter.WriteValue(FCaptionFontName[i]);

            JsonTextWriter.WritePropertyName('FCaptionFontSize' + FORMAT(i));
            JsonTextWriter.WriteValue(FCaptionFontSize[i]);

            JsonTextWriter.WritePropertyName('FCaptionFontBold' + FORMAT(i));
            JsonTextWriter.WriteValue(FCaptionFontBold[i]);


            JsonTextWriter.WritePropertyName('FTextFontName' + FORMAT(i));
            JsonTextWriter.WriteValue(FTextFontName[i]);

            JsonTextWriter.WritePropertyName('FTextFontSize' + FORMAT(i));
            JsonTextWriter.WriteValue(FTextFontSize[i]);

            JsonTextWriter.WritePropertyName('FTextFontBold' + FORMAT(i));
            JsonTextWriter.WriteValue(FTextFontBold[i]);

        END;
        Footer := '{' + StringBuilder.ToString() + '}';

    end;


    local procedure CheckUserPIN(CdUserID: Code[50]; UserPIN: Text)
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(CdUserID) THEN
            IF UserSetup.PIN <> '' THEN
                IF UserSetup.PIN <> UserPIN THEN
                    ERROR('Invalid User PIN');
    end;


    procedure ApproveDocumentNew(CompanyName: Text; txtguid: Text; txtcomment: Text; otppassword: Text; var msg: Text)
    var
        SalesHeader: Record "Sales Header";
        DocNo: Code[20];
        SP: Record "Salesperson/Purchaser";
        PACApproval: Boolean;
        CreatedBy: Code[20];
        UserSetup: Record "User Setup";
        TableID: Integer;
        IndentHeader: Record "Indent Header";
        BudgetMaster: Record "Budget Master";
        VendorRequisition: Record "Vendor Requisition";
    begin

        IF txtguid = '' THEN
            EXIT;

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("GUID Key", txtguid);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN
                ERROR('Document No. ' + ApprovalEntry."Document No." + ' is already Approved');

            IF ApprovalEntry.Status <> ApprovalEntry.Status::Created THEN
                ERROR('Document No. is Already %1', FORMAT(ApprovalEntry.Status));

            CreatedBy := ApprovalEntry."Sender ID";
            DocNo := ApprovalEntry."Document No.";
            TableID := ApprovalEntry."Table ID";
            IF TableID <> 36 THEN
                CheckUserPIN(ApprovalEntry."Approver ID", otppassword);

            IF (txtcomment = '') AND (TableID = 36) THEN
                ERROR('Please write comment as its Mandatory');


            ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
            ApprovalEntry."Comment Text" := COPYSTR(txtcomment, 1, 249);
            ArchiveApprovalEntry(ApprovalEntry, ApprovalEntry);    //msks
            ApprovalEntry.MODIFY;
            msg := 'Document Approved Sucessfully';
            CASE TableID OF
                36:
                    //ApproveSalesOrder(ApprovalEntry);
                    IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::"Credit Limit" THEN
                        ApproveSOCreditLimit(ApprovalEntry)
                    ELSE
                        ApproveSalesOrder(ApprovalEntry);
                50084:
                    BudgetMaster.BudgetApproval(ApprovalEntry);
                50016:
                    BEGIN
                        IndentHeader.RESET;
                        IndentHeader.SETRANGE("No.", DocNo);
                        IF IndentHeader.FINDFIRST THEN BEGIN
                            UserSetup.RESET;
                            UserSetup.SETRANGE("User ID", ApprovalEntry."Approver ID");
                            IF UserSetup.FINDFIRST THEN
                                IndentRelease.ApproveIndent(IndentHeader, UserSetup."User ID");
                        END;
                    END;

                38:
                    BEGIN
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("No.", DocNo);
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            IF UserSetup.GET(ApprovalEntry."Approver ID") THEN;
                            PurchaseApproval(ApprovalEntry);
                        END;
                    END;
                //  50084:
                //    BudgetMaster.BudgetApproval(ApprovalEntry);
                50062:
                    VendorRequisition.vendorApproval(ApprovalEntry);

            END;

            /*
              //New Code Added for PAC Approval.
              SP.RESET;
              IF SP.GET(ApprovalEntry."Approver Code") THEN
                 IF SP.Type=SP.Type::PAC THEN
                    PACApproval := TRUE;

            IF PACApproval THEN BEGIN
              ApprovalEntryPAC.RESET;
              ApprovalEntryPAC.SETRANGE("Document No.",DocNo);
              IF ApprovalEntryPAC.FINDFIRST THEN BEGIN
                  REPEAT
                    IF ApprovalEntryPAC.Status = ApprovalEntryPAC.Status::Created THEN BEGIN
                        ApprovalEntryPAC.VALIDATE(Status,ApprovalEntryPAC.Status::Approved);
                        ArchiveApprovalEntry(ApprovalEntry,ApprovalEntry);    //msks
                        //ApprovalEntryPAC."Comment Text" := 'PAC APPROVAL1';
                        ApprovalEntryPAC.MODIFY;
                    END;
                  UNTIL ApprovalEntryPAC.NEXT=0;
                END;
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                  SalesHeader.Status := SalesHeader.Status::"Price Approved";
                  SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                  SalesHeader.MODIFY;

                  CLEAR(SMSMgt);
                  SMSMgt.CreateMsgOnDApriceApproved(SalesHeader); //MSKS2707

                END;
            END;
              //New Code Added for PAC Approval.



              ApprovalEntry.RESET;
              ApprovalEntry.SETRANGE(ApprovalEntry."Table ID",36);
              ApprovalEntry.SETRANGE(ApprovalEntry."Document No.",DocNo);
              ApprovalEntry.SETRANGE(ApprovalEntry.Status,ApprovalEntry.Status::Created);
              IF ApprovalEntry.FINDFIRST THEN BEGIN
                CLEAR(MailMgt);
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                  MailMgt.CreateMailForPO(SalesHeader,ApprovalEntry."Approver Code");
                  IF SP.GET(ApprovalEntry."Approver Code") THEN BEGIN
                     CASE SP.Type OF
                      SP.Type::PCH:
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PCH;
                          SalesHeader.MODIFY;
                        END;
                      SP.Type::"Zone Manager":
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::ZM;
                          SalesHeader.MODIFY;
                        END;
                      SP.Type::PSM:
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PSM;
                          SalesHeader.MODIFY;
                        END;
                      SP.Type::PAC:
                        BEGIN
                          SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PAC;
                          SalesHeader.MODIFY;
                        END;

                     END;
                  END;

                END;
              END ELSE BEGIN
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                  SalesHeader.Status := SalesHeader.Status::"Price Approved";
                  SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                  SalesHeader.MODIFY;
                  CLEAR(MailMgt);
                  IF SP.GET('DAAPP') THEN
                  IF SP."E-Mail" <>'' THEN
                  MailMgt.CreateMailForPO(SalesHeader,'DAAPP');

                  IF CreatedBy<>'' THEN BEGIN
                     IF UserSetup.GET(CreatedBy) THEN
                      IF UserSetup."E-Mail" <>'' THEN
                         MailMgt.CreateMailForCreator(SalesHeader,UserSetup."E-Mail");
                  END;
                END;
              END;
              */
        END;

    end;


    procedure RejectDocumentNew(CompanyName: Text; TxtGUID: Text; TxtComment: Text; OTPPassword: Text; var Msg: Text)
    var
        DocNo: Code[20];
        SalesPersonCode: Code[20];
        IndentHeader: Record "Indent Header";
        TableID: Integer;
        BudgetMaster: Record "Budget Master";
        VendorRequisition: Record "Vendor Requisition";
    begin
        IF TxtGUID = '' THEN
            EXIT;
        IF TxtComment = '' THEN
            ERROR('Please mention Proper Rejection Reason');

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN
                ERROR('Document No. ' + ApprovalEntry."Document No." + ' is already Approved');

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Rejected THEN
                ERROR('Document No. ' + ApprovalEntry."Document No." + ' is already Rejected');
            DocNo := ApprovalEntry."Document No.";
            TableID := ApprovalEntry."Table ID";

            IF TableID <> 36 THEN
                CheckUserPIN(ApprovalEntry."Approver ID", OTPPassword);
            //IF (ApprovalEntry.Status<>ApprovalEntry.Status::Created) OR (ApprovalEntry.Status<>ApprovalEntry.Status::Open) THEN
            // ERROR('Not a Valid Document');
            ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Rejected);
            ApprovalEntry."Comment Text" := COPYSTR(TxtComment, 1, 249);
            ApprovalEntry.MODIFY;

            Msg := 'Document Rejected Successfully';

            CASE TableID OF
                36:
                    BEGIN
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Created);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalEntry.MODIFYALL(Status, ApprovalEntry.Status::Cancelled);
                        END;
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            SalesHeader.Status := SalesHeader.Status::Open;
                            //SalesHeader."Bypass Auto Order Process" := TRUE;
                            SalesHeader.MODIFY;
                        END;

                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                        ApprovalEntry.SETCURRENTKEY("Approver Code", Status);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            REPEAT
                                IF SalesPersonCode <> ApprovalEntry."Approver Code" THEN BEGIN
                                    CLEAR(MailMgt);
                                    SalesHeader.RESET;
                                    SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                                    IF SalesHeader.FINDFIRST THEN BEGIN
                                        MailMgt.CreateMailForPORejection(SalesHeader, ApprovalEntry."Approver Code");
                                    END;
                                    SalesPersonCode := ApprovalEntry."Approver Code";
                                END;
                            UNTIL ApprovalEntry.NEXT = 0;
                        END;
                    END;
                50016:
                    BEGIN
                        CancelIndentApprovalEnt(DocNo);
                    END;
                50084:
                    BEGIN
                        BudgetMaster.RESET;
                        BudgetMaster.SETRANGE("No.", DocNo);
                        IF BudgetMaster.FINDFIRST THEN
                            BudgetMaster.CancelApprovalEntries(BudgetMaster);
                    END;
                38:
                    BEGIN
                        CancelPurchaseApprovalEnt(DocNo);
                    END;
                50062:
                    BEGIN
                        VendorRequisition.RESET;
                        VendorRequisition.SETRANGE("No.", DocNo);
                        IF VendorRequisition.FINDFIRST THEN
                            VendorRequisition.CancelApprovalEntries(VendorRequisition);
                    END;

            END;
        END;

    end;


    procedure SendPONotification(PurchHeader: Record "Purchase Header")
    var
        //  cduSMTPMail: Codeunit "400";
        //  SMTPMailSetup: Record "409"
        RecPurchHdr: Record "Purchase Header";
        FileDirectory: Text;
        FileName: Text;
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

        FileDirectory := 'c:\inetpub\';
        FileName := CONVERTSTR(PurchHeader."No.", '\/-', '___') + '.pdf';

        RecPurchHdr.RESET;
        RecPurchHdr.SETFILTER("Document Type", '%1', PurchHeader."Document Type");
        RecPurchHdr.SETFILTER("No.", '%1', PurchHeader."No.");
        IF RecPurchHdr.FINDFIRST THEN
            // REPORT.SAVEASPDF(Report::"Purchase Order GST ", FileDirectory + FileName, RecPurchHdr);

            //  CLEAR(cduSMTPMail);
            //  cduSMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
            //                            'approvedpo@orientbell.com', 'Purchase Order Approval Mail ' + PurchHeader."No." + '[Location -' + PurchHeader."Location Code" + ']', '', TRUE);
            EmailAddressList.Add('donotreply@orientbell.com');
        BodyText := 'Dear Sir / Madam, ';
        BodyText += '<br><br>';
        BodyText += 'Please find herewith the Purchase Order : ' + PurchHeader."No.";
        BodyText += ' which has been released. ';

        BodyText += '<br><br>';
        BodyText += '<br><br>';
        BodyText += 'Yours Truely, <br>';
        BodyText += '<br><br>';
        BodyText += 'For Orient Bell Limited  <br>';

        //AttachmentManagment.ExportAttachmentAsFile(PurchaseHeader.RECORDID,FilePath,FileName);
        // if File.Exists(FileDirectory + FileName) THEN
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, FileDirectory + FileName);
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'Purchase Order Approval Mail ' + PurchHeader."No." + '[Location -' + PurchHeader."Location Code" + ']', BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists(FileDirectory + FileName) THEN
            EmailMsg.AddAttachment(FileDirectory + FileName, 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
        /* IF EXISTS(FileDirectory + FileName) THEN BEGIN
                 cduSMTPMail.AddAttachment(FileDirectory + FileName, FileName);
             END;
         cduSMTPMail.Send;*/
    end;

    local procedure "---------MSVrn---------"()
    begin
    end;


    procedure AppEntryVendor(recVendorIns: Record Vendor)
    var
        ApprovalEntry: Record "Approval Entry";
        recUserSetup: Record "User Setup";
        recAppUser: Record "User Setup";
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        //  SMTPMailCodeUnit: Codeunit "400";
        recVendor: Record Vendor;
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

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 23);
        ApprovalEntry.SETRANGE("Document No.", recVendorIns."No.");
        IF NOT ApprovalEntry.FINDFIRST THEN BEGIN
            ApprovalEntry.INIT;
            ApprovalEntry."Table ID" := 23;
            ApprovalEntry."Document No." := recVendorIns."No.";
            ApprovalEntry."Approval Code" := 'VENDOR';
            ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::Order;
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
            ApprovalEntry.EmailID := recAppUser."E-Mail";

            ApprovalEntry.INSERT;

            ApprovalEntry."GUID Key" := CREATEGUID;
            ApprovalEntry.MODIFY;

            MESSAGE('dfaf %1', ApprovalEntry."GUID Key"); //---

            MESSAGE('Sent approval for %1.', recVendorIns."No.");

            //----->> mailcode
            //  SMTPMailCodeUnit.CreateMessage('Test Vendor: ' + recVendorIns.Name, 'donotreply@orientbell.com',
            //   'kulbhushan.sharma@orientbell.com', 'Vendor' + recVendorIns.Name, 'Vendor' + recVendorIns."No." + 'Approval', TRUE);

            BodyText += 'Dear Sir, ';
            BodyText += Text50010;
            BodyText += FORMAT(ApprovalEntry."Document No.") + 'has been sent for Approval.';
            BodyText += Text50010;
            BodyText += Text50010;
            BodyText += Text50000;
            BodyText += Text50010;
            BodyText += 'Vendor Code: ';
            BodyText += recVendor."No.";
            BodyText += Text50010;
            BodyText += 'Vendor Name: ' + ' ' + recVendor.Name;
            BodyText += ApprovalEntry."Comment Text";

            BodyText += 'Approval or Rejection link: ';

            BodyText += Text50045 + getApprovalLink1(23, ApprovalEntry."Document No.", 3) + Text50046 + Text50047;
            //SMTPMailCodeUnit.AppendBody(getApprovalLink1(23, ApprovalEntry."Document No.", 3)); //Link

            MESSAGE('Vendor approval mail sent! %1', Text50045 + getApprovalLink1(23, ApprovalEntry."Document No.", 3) + Text50046 + Text50047);
            // EmailMsg.Create(EmailAddressList, 'Vendor' + recVendorIns.Name, 'Vendor' + recVendorIns."No." + 'Approval', BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
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
                ApprovalEntry.EmailID := recAppUser."E-Mail";
                MESSAGE('Vendor approved for: %1.', recVendorIns."No.");
                ApprovalEntry.MODIFY;
            END;
    end;


    procedure ApprovedEntryVendor(ApprovalEntry: Record "Approval Entry")
    var
        recUserSetup: Record "User Setup";
        recAppUser: Record "User Setup";
        recVendor1: Record Vendor;
        recVendor: Record Vendor;
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
        recVendor: Record Vendor;
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

    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        IF recUserSetup.GET(USERID) THEN;
        IF recAppUser.GET(recUserSetup."Vendor Approver") THEN;
        IF recVendor.GET(ApprovalEntry."Document No.") THEN;
        //----------------
        /* SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
             'kulbhushan.sharma@orientbell.com', 'Rejection Mail' + ApprovalEntry."Document No.", '', TRUE);*/ // 15578
        EmailAddressList.Add('donotreply@orientbell.com');
        EmailMsg.Create(EmailAddressList, 'Rejection Mail' + ApprovalEntry."Document No.", BodyText, true, EmailBccList, EmailCCList);
        BodyText += 'Dear Sir, ';
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
        BodyText += getApprovalLink1(23, ApprovalEntry."Document No.", 4); //Link

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


    procedure getApprovalLink1(TblID: Integer; DocNo: Code[20]; TypeInt: Integer): Text
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
        TxtLink := 'http://192.168.1.118/mailapproval/?ref=' + GUIDTXT; //live server
        // TxtLink := 'http://erp.orientapps.com/mailapproval/?ref=' + GUIDTXT; //live server
        EXIT(TxtLink);
    end;

    local procedure ApproveSOCreditLimit(ApprovalEntry: Record "Approval Entry")
    var
        SalesHeader: Record "Sales Header";
        DocNo: Code[20];
        SP: Record "Salesperson/Purchaser";
        PACApproval: Boolean;
        CreatedBy: Code[20];
        UserSetup: Record "User Setup";
        TableID: Integer;
    begin
        DocNo := ApprovalEntry."Document No.";
        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
        IF SalesHeader.FINDFIRST THEN BEGIN
            SalesHeader.Status := SalesHeader.Status::"Credit Approved";
            SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
            SalesHeader.MODIFY;
        END;
        //New Code Added for PAC Approval.
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
        ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Credit Limit");
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Created);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            CLEAR(MailMgt);
            MailMgt.CreateMailForCreditApproval(SalesHeader, ApprovalEntry."Approver Code");
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN BEGIN

            END;
        END ELSE BEGIN
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN BEGIN
                SalesHeader.Status := SalesHeader.Status::"Pending Approval";
                SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                SalesHeader.MODIFY;
            END;
        END;
    end;


    procedure CreateMailForCreditApproval(SalesHeader: Record "Sales Header"; SPCode: Code[20])
    var
        Text50000: Label 'Dear      ';
        Text50001: Label 'ADA';
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
        //  SMTPMail: Codeunit "400";
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
        // SMTPMailSetup: Record "409";
        CompInfo: Record "Company Information";
        Text50034: Label '" We have received the order for following products & the same is sent to you for Discount approvals details as given below:  "';
        Text50035: Label ' Branch vide Stock Transfer Note No. ';
        Text50036: Label ' Dated ';
        RecSalesLine: Record "Sales Line";
        Text50037: Label 'Customer No: ';
        Text50038: Label 'Name: ';
        Text50039: Label 'Regards,';
        Text50040: Label 'Orient Bell Limited';
        Text50041: Label '<TD  width=5 Align=Center>';
        SalesPersons: Record "Salesperson/Purchaser";
        RecUserSetup: Record "User Setup";
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        HighValueProd: Boolean;
        Text50090: Label '<td width="20%" bgcolor="#80ff80"> ';
        Text50091: Label '<td width="50%" bgcolor="#80ff80"> ';
        ShowMarginDetail: Boolean;
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
        SalesHeader.CALCFIELDS(SalesHeader."D1 Amount", SalesHeader."D2 Amount", SalesHeader."D3 Amount", SalesHeader."D4 Amount", SalesHeader."S1 Amount", SalesHeader."D6 Amount", "Qty in Sq. Mt.");
        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        IF SalesPersons.GET(SPCode) THEN
            SalesPersons.TESTFIELD("E-Mail");
        IF SalesPersons."E-Mail" <> '' THEN BEGIN
            //    SMTPMailSetup.GET;
            //    SMTPMailSetup.TESTFIELD("User ID");
            //IF SalesPersons.Type IN [SalesPersons.Type::PSM,SalesPersons.Type::PAC] THEN
            //ShowMarginDetail := TRUE;
            IF NOT ShowMarginDetail THEN BEGIN
                IF SalesPersons."Margin Display" THEN
                    ShowMarginDetail := SalesPersons."Margin Display";
            END;

            TotalCostVal := 0;
            TSaleeval := 0;
            Tmargin := 0;
            SrNo := 1;
            //   CLEAR(SMTPMail);
            IF RecState.GET(RecCustomer."State Code") THEN;
            ///    SMTPMail.CreateMessage('Credit Approval', 'donotreply@orientbell.com', SalesPersons."E-Mail", Text50001 + ' ' + SalesHeader."No." + ' (' + RecCustomer.Name + ' - ' + RecCustomer.City + '-' + RecState.Description + ') ' + SalesHeader."Location Code", '', TRUE);
            //    SMTPMail.CreateMessage('Discount Approvals ['+RecCustomer.Name+' - '+RecCustomer.City+' - '+RecCustomer."State Code"+']',SMTPMailSetup."User ID",'virendra.kumar@mindshell.info',Text50001,'',TRUE);

            EmailCCList.Add('donotreply@orientbell.com');
            BodyText := Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50033 + Text60003;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text50024 + Text50034;

            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            //   BodyText +='Customer Name : ' + RecCustomer.Name;
            BodyText += 'Customer Name : ' + RecCustomer.Name + ' - ' + RecCustomer.City + ' - ' + RecState.Description;
            BodyText += Text60011;
            BodyText += 'Billing Address:' + SalesHeader."Bill-to Address" + ' ' + SalesHeader."Bill-to Address 2" + ' ' + SalesHeader."Bill-to City";
            BodyText += Text60011;
            BodyText += 'Shipping Address:' + SalesHeader."Ship-to Address" + ' ' + SalesHeader."Ship-to Address 2" + ' ' + SalesHeader."Ship-to City";
            BodyText += Text60011;
            BodyText += 'Customer Type : ' + SalesHeader."Customer Type";
            BodyText += Text60011;
            BodyText += 'PMT Code: ' + SalesHeader."PMT Code";
            BodyText += Text60011;
            BodyText += 'Credit Rating : ' + FORMAT(RecCustomer."Credit Rating");
            BodyText += Text60011;
            BodyText += 'Freight Terms : ' + FORMAT(SalesHeader.Pay);
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'CD Applicable : ' + FORMAT(SalesHeader."CD Applicable");
            BodyText += Text60011;
            BodyText += 'Payment Terms : ' + SalesHeader."Payment Terms Code";
            BodyText += Text60011;
            BodyText += 'CD Discount %: ' + FORMAT(SalesHeader."Discount Charges %");
            BodyText += Text60011;
            BodyText += 'Order Qty.In Sq.Mt : ' + FORMAT(SalesHeader."Qty in Sq. Mt.");
            BodyText += Text60011;
            RecCustomer.CALCFIELDS(Balance);
            BodyText += 'Total Outstanding : ' + FORMAT(ROUND(RecCustomer.Balance));
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += 'Remarks :-' + FORMAT(SalesHeader.Remarks); //Raushan 180417
            BodyText += Text60011;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document Type", AppEntry."Document Type"::"Credit Limit");
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            AppEntry.SETRANGE(Status, AppEntry.Status::Approved);
            IF AppEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF AppEntry."Comment Text" <> '' THEN BEGIN
                        IF SalesPersons.GET(AppEntry."Approver Code") THEN BEGIN
                            BodyText += SalesPersons.Name + ' - ' + AppEntry."Comment Text";
                            BodyText += Text60011;
                        END;
                    END;
                UNTIL AppEntry.NEXT = 0;
            END;

            BodyText += Text60011;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50027 + Text50026 + Text50030 + Text60012 + 'Plant' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003;
            IF ShowMarginDetail THEN
                BodyText += Text50041 + Text60012 + 'Manuf Strategy' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'State Price Group ' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Price Group' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Qty. Cartons' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Qty. Sq. Mtr.' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'List/Sqm ' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Total Discount ' + Text60013 + Text60003;

            IF SalesHeader."S1 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'FRT' + Text60013 + Text60003;

            IF SalesHeader."D6 Amount" <> 0 THEN
                BodyText += Text50041 + Text60012 + 'ORC' + Text60013 + Text60003;


            BodyText += Text50041 + Text60012 + 'Buyer Price/Sqm' + Text60013 + Text60003;//ADD
            BodyText += Text50041 + Text60012 + 'App Required' + Text60013 + Text60003;
            IF ShowMarginDetail THEN BEGIN
                BodyText += Text50041 + Text60012 + '   %     ' + Text60013 + Text60003;//MSKS
                BodyText += Text50041 + Text60012 + 'App Comments' + Text60013 + Text60003;
                //BodyText +=Text50041+Text60012+'App Required'+Text60013+Text60003);
            END;
            BodyText += Text60004;
            RecSalesLine.RESET;
            RecSalesLine.SETRANGE("Document No.", SalesHeader."No.");
            IF RecSalesLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF RecItem.GET(RecSalesLine."No.") THEN;
                    HighValueProd := ((RecItem."Manuf. Strategy" = RecItem."Manuf. Strategy"::"Non Retained ") OR (RecItem."Quality Code" = '2'));
                    BodyText += Text50026 + Text50041 + FORMAT(COPYSTR(RecItem."Default Prod. Plant Code", 1, 3)) + Text60003;

                    IF HighValueProd THEN BEGIN
                        BodyText += Text50090 + FORMAT(RecSalesLine.Description) + Text60003;
                        BodyText += Text50091 + RecItem."Description 2" + Text60003;
                    END ELSE BEGIN
                        BodyText += Text50030 + FORMAT(RecSalesLine.Description) + Text60003;
                        BodyText += Text50031 + RecItem."Description 2" + Text60003;
                    END;

                    IF ShowMarginDetail THEN
                        BodyText += Text50031 + FORMAT(RecItem."Manuf. Strategy") + Text60003;

                    BodyText += Text50031 + FORMAT(RecSalesLine."Customer Price Group") + Text60003;
                    BodyText += Text50031 + FORMAT(RecItem."Item Classification") + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine.Quantity) + Text60003;
                    //BodyText +=Text50041+FORMAT(RecSalesLine."Unit of Measure")+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Quantity in Sq. Mt.") + Text60003;
                    //BodyText +=Text50041+FORMAT(RecSalesLine."MRP Price",0,'<Precision,2:2><Standard Format,2>')+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT"), 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine.D7) + Text60003;
                    IF SalesHeader."S1 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.S1) + Text60003;
                    IF SalesHeader."D6 Amount" <> 0 THEN
                        BodyText += Text50041 + FORMAT(RecSalesLine.D6) + Text60003;

                    //BodyText +=Text50041+FORMAT((RecSalesLine."Buyer's Price /Sq.Mt"-(RecSalesLine.S1))-(RecSalesLine.D1+RecSalesLine.D2+RecSalesLine.D3+RecSalesLine.D4),0,'<Precision,2:2><Standard Format,2>')+Text60003);
                    BodyText += Text50041 + FORMAT(RecSalesLine."Buyer's Price /Sq.Mt", 0, '<Precision,2:2><Standard Format,2>') + Text60003;
                    BodyText += Text50041 + FORMAT(RecSalesLine."Approval Required") + Text60003;
                    //Margin Start Kulbhushan Sharma 141118
                    buyprice := 0;
                    Costv := 0;
                    Saleeval := 0;
                    margin := 0;
                    IF RecItem."V. Cost" <> 0 THEN BEGIN
                        buyprice := (RecSalesLine."Buyer's Price /Sq.Mt" + (RecSalesLine."Discount Per SQ.MT")) - (RecSalesLine.D1 + RecSalesLine.D2 + RecSalesLine.D3 + RecSalesLine.D4);
                        Costv := RecItem."V. Cost" * (RecSalesLine."Quantity in Sq. Mt.");
                        Saleeval := buyprice * (RecSalesLine."Quantity in Sq. Mt.");
                        ;
                        margin := ((Saleeval - Costv) / Saleeval) * 100;

                        TSaleeval += Saleeval;
                        TotalCostVal += Costv;
                        //Vmargin := ((Saleeval-Costv)/RecSalesLine."Quantity in Sq. Mt.");
                        //TVmargin += Vmargin/TSaleeval;
                        //Tmargin := (Vmargin/TSaleeval) *100

                    END ELSE
                        margin := 0;
                    //Margin end Kulbhushan Sharma 141118

                    IF ShowMarginDetail THEN BEGIN
                        BodyText += Text50041 + FORMAT(FORMAT(margin, 0, '<Precision,2:2><Standard Format,2>') + ' %') + Text60003;
                        BodyText += Text50031 + FORMAT(RecItem."Discount Comments") + Text60003;
                        //BodyText +=Text50041+FORMAT(RecSalesLine."Approval Required")+Text60003);
                    END;
                    BodyText += Text60004;
                    SrNo += 1;
                UNTIL RecSalesLine.NEXT = 0;
            END;
            BodyText += Text60004;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;
            BodyText += Text50041 + FORMAT('') + Text60003;

            IF RecItem."V. Cost" <> 0 THEN
                Tmargin := ((TSaleeval - TotalCostVal) / TSaleeval) * 100;

            IF ShowMarginDetail THEN
                BodyText += Text50041 + FORMAT(' % -' + FORMAT(Tmargin, 0, '<Precision,2:2><Standard Format,2>') + ' %') + Text60003;

            BodyText += Text60005;

            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50039 + Text60003;
            BodyText += Text60004;
            BodyText += Text60011;
            AppEntry.RESET;
            AppEntry.SETRANGE("Table ID", 36);
            AppEntry.SETRANGE("Document Type", AppEntry."Document Type"::"Credit Limit");
            AppEntry.SETRANGE("Document No.", SalesHeader."No.");
            //    AppEntry.SETRANGE(Status,AppEntry.Status::Approved);
            IF AppEntry.FINDFIRST THEN;
            IF RecUserSetup.GET(AppEntry."Sender ID") THEN
                BodyText += '[' + RecUserSetup."User Name" + ']';

            BodyText += Text60004;


            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text50024 + Text50040 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;

            BodyText += Text60011;
            BodyText += Text59999;
            BodyText += Text60000;
            BodyText += Text60001;
            BodyText += Text50024 + Text50025 + Text60003;
            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text60011;
            BodyText += Text50045 + getApprovalLink(36, SalesHeader."No.", 2) + Text50046 + Text50047;
            EmailMsg.Create(EmailAddressList, Text50001 + ' ' + SalesHeader."No." + ' (' + RecCustomer.Name + ' - ' + RecCustomer.City + '-' + RecState.Description + ') ' + SalesHeader."Location Code", BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            //  SMTPMail.Send;
        END;
        //END;

    end;

    local procedure "----------------VendorApp Email----"()
    begin
    end;


    procedure CreateMailForVendorApproval(VendorReplica: Record "Vendor Requisition"; SPCode: Code[20]; ISFinalApproval: Boolean)
    var
        recVendorRep: Record "Vendor Requisition";
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Vendor Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        UserSetup: Record "User Setup";
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

        IF UserSetup.GET(SPCode) THEN;

        IF UserSetup."E-Mail" <> '' THEN BEGIN

            CASE VendorReplica."Vendor Class" OF
                VendorReplica."Vendor Class"::Employee:
                    BEGIN
                        IF VendorReplica."No. Series Code" <> '' THEN BEGIN
                            /*   SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                               UserSetup."E-Mail", 'Employee Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);*/ // 15578
                            EmailAddressList.Add('donotreply@orientbell.com');
                            EmailMsg.Create(EmailAddressList, 'Employee Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailBccList, EmailCCList);
                        END ELSE BEGIN
                            EmailAddressList.Add('donotreply@orientbell.com');
                            EmailMsg.Create(EmailAddressList, 'Employee Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailBccList, EmailCCList);
                            /*    SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                UserSetup."E-Mail", 'Employee Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);*/ // 15578

                        END;
                    END ELSE BEGIN
                    IF VendorReplica."No. Series Code" <> '' THEN BEGIN
                        /*  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',    
                          UserSetup."E-Mail", 'Vendor Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);*/ // 15578
                        EmailAddressList.Add('donotreply@orientbell.com');
                        EmailMsg.Create(EmailAddressList, 'Vendor Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailBccList, EmailCCList);
                    END ELSE BEGIN
                        EmailAddressList.Add('donotreply@orientbell.com');
                        EmailMsg.Create(EmailAddressList, 'Vendor Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailBccList, EmailCCList);
                        /*   SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                           UserSetup."E-Mail", 'Vendor Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);*/ // 15578

                    END;
                END;
            END;
            BodyText := Text50010;
            BodyText += 'Vendor Code: ' + recVendorRep."No.";
            BodyText += Text50010;
            BodyText += 'Vendor Name: ' + ' ' + recVendorRep.Name;
            BodyText += Text50010;
            BodyText += ApprovalEntry."Comment Text";
            BodyText += Text50010;
            IF NOT ISFinalApproval THEN BEGIN
                BodyText += 'Approval or Rejection link: ';
                BodyText += Text50045 + getApprovalLink(50062, VendorReplica."No.", 3) + Text50046 + Text50047;
            END;
            EmailCCList.add('kulbhushan.sharma@orientbell.com');
            IF ISFinalApproval THEN BEGIN
                IF UserSetup.GET(VendorReplica."Created By") THEN
                    IF UserSetup."E-Mail" <> '' THEN
                        EmailCCList.add(UserSetup."E-Mail");
                EmailCCList.add('Sandeep.Jhanwar@orientBell.com');
            END;
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
    end;


    procedure CreateMailForVendorApproval1(VendorReplica: Record 50062; SPCode: Code[20]; ISFinalApproval: Boolean)
    var
        recVendorRep: Record 50062;
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Vendor Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        UserSetup: Record 91;
        WorkflowUserGroupMember: Record 1541;
        "Field": Record 2000000041;
        i: Integer;
        AttachmentManagment: Record 50099;
        FilePath: Text;
        FileName: Text;
        InstreamVar: InStream;
        OutstreamVar: OutStream;
        TempBlobCU: Codeunit "Temp Blob";
        FileMgmt: Codeunit 419;

        EmailObj: Codeunit 8901; // 15578TEXT
        EmailMsg: codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        EmailBccList: list of [Text];

    begin
        IF UserSetup.GET(SPCode) THEN;

        /* IF UserSetup."E-Mail" <> '' THEN BEGIN

            CASE VendorReplica."Vendor Class" OF
                VendorReplica."Vendor Class"::Employee:
                    BEGIN
                        EmailAddressList.Add(UserSetup."E-Mail");
                        IF VendorReplica."No. Series Code" = '' THEN BEGIN
                            //SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Employee Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                            EmailMsg.Create(EmailAddressList, 'Employee Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                        END ELSE BEGIN
                            // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Employee Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                            EmailMsg.Create(EmailAddressList, 'Employee Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                        END;
                    END ELSE BEGIN
                    IF VendorReplica."No. Series Code" = '' THEN BEGIN
                        // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Vendor Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                        EmailMsg.Create(EmailAddressList, 'Vendor Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                    END ELSE BEGIN
                        // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Vendor Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                        EmailMsg.Create(EmailAddressList, 'Vendor Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                    END;
                END;
            END;
         */
        // EmailAddressList.Add('donotreply@orientbell.com');

        BodyText := ('Dear Sir</p></p>');
        BodyText += ('Thank you for submitting the Vendor Registration form along with KYC documents. The documents submitted by you are under scrutiny and are enclosed for your final verification. Basis these documents provisional registration has been completed under Code: ' + VendorReplica."No. Series Code" + '</p>');
        BodyText += ('We request your concern and confirmation for the validity of these documents. In case we do not receive your response with in 24 hours, these documents shall be taken on record as validated by you and the said provisional registration will be treated as final registration.</p>');
        BodyText += ('For any query and communication in this regard please feel free to contact at sumit.sharma@orientbell.com</p>');

        BodyText += ('<h2>Orient Bell Ltd - Vendor Registration form</h2>');
        //BodyText +=('<table style="width:100%">');
        BodyText += ('<h3>GST No. and PAN is Mandatory in India</h3>');

        BodyText += ('<table border ="1"; style="width:80%">');
        BodyText += ('<tr>');
        BodyText += ('<th>Name of the Firm/Company(*)</th>');
        BodyText += ('<th>Type of the Firm(*)</th>');
        BodyText += ('<th>Status of the Firm(*)</th>');
        BodyText += ('<th>Type of Service Provide(*)</th>');
        BodyText += ('</tr>');

        BodyText += ('<tr text-align: left>');
        BodyText += ('<td>' + VendorReplica.Name + '</td>');
        BodyText += ('<td>' + FORMAT(VendorReplica."Vend. Company Type") + '</td>');
        BodyText += ('<td>' + FORMAT(VendorReplica.Status) + '</td>');
        BodyText += ('<td>' + FORMAT(VendorReplica."GST Vendor Type") + '</td>');
        BodyText += ('</tr>');

        BodyText += ('<tr>');
        BodyText += ('<th>Country(*)</th>');
        BodyText += ('<th>GST No.(*)</th>');
        BodyText += ('<th>PAN No.(*)</th>');
        BodyText += ('<th>MSME No/UAN(if applicable)</th>');
        BodyText += ('</tr>');

        BodyText += ('<tr text-align: left>');
        BodyText += ('<td>' + VendorReplica."Country/Region Code" + '</td>');
        BodyText += ('<td>' + VendorReplica."GST Registration No." + '</td>');
        BodyText += ('<td>' + VendorReplica."P.A.N. No." + '</td>');
        BodyText += ('<td>' + VendorReplica."Msme Code" + '</td>');
        BodyText += ('</tr>');
        BodyText += ('</table>');
        //--------------------------------------------------First Table <<

        BodyText += ('<h3>Detail of Vendor</h3>');
        //BodyText +=('<table style="width:100%">');
        BodyText += ('<table border ="1"; style="width:80%">');
        BodyText += ('<tr>');
        BodyText += ('<th>Address(*)</th>');
        BodyText += ('<th>STD Code with phone no.(*)</th>');
        BodyText += ('<th>Name of Contact person(*)</th>');
        BodyText += ('<th>Type of item interested for Supply(*)</th>');
        BodyText += ('</tr>');
        BodyText += ('<tr>');
        BodyText += ('<td>' + VendorReplica.Address + VendorReplica."Vendor Address 2" + '</td>');
        BodyText += ('<td>' + VendorReplica."Phone No." + '</td>');
        BodyText += ('<td>' + VendorReplica.Contact + '</td>');
        BodyText += ('<td>' + FORMAT(VendorReplica."Vendor Class") + '</td>');
        BodyText += ('</tr>');

        BodyText += ('<tr>');
        BodyText += ('<th>City(*)</th>');
        BodyText += ('<th>Website(*)</th>');
        BodyText += ('<th>Designation of Contact person(*)</th>');
        BodyText += ('<th>Mobile No.(*)</th>');
        BodyText += ('</tr>');
        BodyText += ('<tr>');
        BodyText += ('<td>' + VendorReplica.City + '</td>');
        BodyText += ('<td>' + VendorReplica."Home Page" + '</td>');
        BodyText += ('<td>' + VendorReplica.Dsgn + '</td>');
        BodyText += ('<td>' + VendorReplica."Phone No." + '</td>');
        BodyText += ('</tr>');

        BodyText += ('<tr>');
        BodyText += ('<th>State(*)</th>');
        BodyText += ('<th>Pin(*)</th>');
        BodyText += ('<th>Fax</th>');
        BodyText += ('<th>E-mail(*)</th>');
        BodyText += ('</tr>');
        BodyText += ('<tr>');
        BodyText += ('<td>' + VendorReplica."State Code" + '</td>');
        BodyText += ('<td>' + VendorReplica."Pin Code" + '</td>');
        BodyText += ('<td>' + VendorReplica."Fax No." + '</td>');
        BodyText += ('<td>' + VendorReplica."E-Mail" + '</td>');
        BodyText += ('</tr>');

        BodyText += ('<tr>');
        BodyText += ('<th>Bank Name and Address(*)</th>');
        BodyText += ('<th>Bank Account No.(*)</th>');
        BodyText += ('<th>IFSC/Swift code(*)</th>');
        BodyText += ('<th>AD Code (only in case of Import)(*)</th>');
        BodyText += ('</tr>');
        BodyText += ('<tr>');
        BodyText += ('<td>' + VendorReplica."Bank Account Name" + '</td>');
        BodyText += ('<td>' + VendorReplica."Bank A/c" + '</td>');
        BodyText += ('<td>' + VendorReplica."RTGS/NEFT Code" + '</td>');
        BodyText += ('<td>' + '----------' + '</td>');
        BodyText += ('</tr>');
        BodyText += ('</table>');
        //------------------------------------Table 2 <<

        BodyText += ('<p>Following Mandatory Required along with stamp and signed copy of this form by the Vendor:-</p>');
        BodyText += ('1. Copy of PAN</p>');
        BodyText += ('2. Copy of GST Registration Certificate.</p>');
        BodyText += ('3. Scan copy of cancelled cheque leaf/Bank certificate.</p>');
        BodyText += ('4. Udyog Adhar(MSME certificate).</p>');
        BodyText += ('5. Import Vendors must share bank certificate in addition to cancel cheque leaf.</p>');
        BodyText += ('6. SWIFT No. and AD No. is required in case of Import.</p>');
        BodyText += ('7. In case of Proprietors, Vendor must share the name of person along with proof in whom favour payment required.</p>');
        BodyText += ('8. (*) Mandatory field.</p>');
        BodyText += ('<br></br>');
        //BodyText +=('<br></br>');

        BodyText += ('<h3>Detail of Modifications</h3>');
        //BodyText +=('<table style="width:100%">');
        BodyText += ('<table border ="1"; style="width:70%">');
        BodyText += ('<tr>');
        BodyText += ('<th>S.No.(*)</th>');
        BodyText += ('<th>Field Name</th>');
        BodyText += ('<th>Old Value</th>');
        BodyText += ('<th>New Value</th>');
        BodyText += ('</tr>');

        IF VendorReplica."No. Series Code" <> '' THEN BEGIN
            i := 1;
            Field.RESET;
            Field.SETRANGE(TableNo, 23);
            Field.SETFILTER("No.", '2|3|5|6|1600|50026|50027|50028|50029|50030');
            IF Field.FINDFIRST THEN
                REPEAT
                    BodyText += ('<tr>');
                    BodyText += ('<td>' + FORMAT(i) + '</td>');
                    BodyText += ('<td>' + Field."Field Caption" + '</td>');
                    BodyText += ('<td>' + GetOldValue(VendorReplica."No. Series Code", Field."No.") + '</td>');
                    BodyText += ('<td>' + GetNewValue(VendorReplica."No.", Field."No.") + '</td>');
                    BodyText += ('</tr>');
                    i += 1;
                UNTIL Field.NEXT = 0;
            BodyText += ('<tr>');
            BodyText += ('</table>');
        END;
        IF NOT ISFinalApproval THEN BEGIN
            BodyText += ('<br>Vendor approval link: ' + Text50045 + getApprovalLink(50062, VendorReplica."No.", 3) + Text50046 + Text50047 + '</br>');
            //BodyText +=('</body>');
        END;
        //MESSAGE('Vendor approval mail sent! %1', Text50045+getApprovalLink(50062, VendorReplica."No.", 3)+Text50046+Text50047);
        //SMTPMailCodeUnit.AddBCC('kulwant@mindshell.info');
        EmailCCList.add('kulbhushan.sharma@orientbell.com');
        IF ISFinalApproval THEN BEGIN
            WorkflowUserGroupMember.RESET;
            WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."Workflow User Group Code", 'VENDAPP');
            IF WorkflowUserGroupMember.FINDFIRST THEN BEGIN
                REPEAT
                    IF UserSetup.GET(WorkflowUserGroupMember."User Name") THEN
                        IF UserSetup."E-Mail" <> '' THEN
                            EmailCCList.add(UserSetup."E-Mail");
                UNTIL WorkflowUserGroupMember.NEXT = 0;
            END;
            EmailCCList.add('Sandeep.Jhanwar@orientBell.com');
            IF VendorReplica."E-Mail" <> '' THEN
                EmailCCList.add(VendorReplica."E-Mail");
        END;

        AttachmentManagment.RESET;
        AttachmentManagment.SETRANGE("Document No.", VendorReplica."No.");
        IF AttachmentManagment.FINDFIRST THEN BEGIN
            REPEAT
                AttachmentManagment.CALCFIELDS(Attachment);
                IF AttachmentManagment.Attachment.HASVALUE THEN BEGIN
                    AttachmentManagment.ExportAttachmentAsFile(AttachmentManagment."Primary Key", FilePath, FileName);
                    IF AttachmentManagment.Attachment.HasValue then begin
                        AttachmentManagment.Attachment.CreateInStream(InstreamVar);
                        EmailMsg.AddAttachment(AttachmentManagment."File Name", 'application/pdf', InstreamVar);

                        /* IF FILE.EXISTS(FilePath + '\' + FileName) THEN
                            SMTPMailCodeUnit.AddAttachment(FilePath + '\' + FileName, FileName);
                         *///AttachmentManagment.Attachment.CREATEINSTREAM(IStream);
                           //SMTPMailCodeunit.AddAttachmentStream(IStream,AttachmentManagment."File Name");
                    END;
                end;
            UNTIL AttachmentManagment.NEXT = 0;

        END;
        IF UserSetup."E-Mail" <> '' THEN BEGIN
            EmailAddressList.Add(UserSetup."E-Mail");
            CASE VendorReplica."Vendor Class" OF
                VendorReplica."Vendor Class"::Employee:
                    BEGIN

                        IF VendorReplica."No. Series Code" = '' THEN BEGIN
                            //SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Employee Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                            EmailMsg.Create(EmailAddressList, 'Employee Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                        END ELSE BEGIN
                            // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Employee Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                            EmailMsg.Create(EmailAddressList, 'Employee Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                        END;
                    END ELSE BEGIN
                    IF VendorReplica."No. Series Code" = '' THEN BEGIN
                        // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Vendor Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                        EmailMsg.Create(EmailAddressList, 'Vendor Creation Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                    END ELSE BEGIN
                        // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', UserSetup."E-Mail", 'Vendor Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), '', TRUE);
                        EmailMsg.Create(EmailAddressList, 'Vendor Edit Approval Mail -' + VendorReplica."No." + ' Status - ' + FORMAT(VendorReplica.Status), BodyText, true, EmailCCList, EmailBccList);
                    END;
                END;
            END;

            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            Message('Mail Sent');
            // SMTPMailCodeUnit.Send;
        END;
    end;


    local procedure GetOldValue(DocNo: Code[20]; IntFieldNo: Integer): Text
    var
        VendorMastArch: Record "Vendor Master Archive";
        RecRef: RecordRef;
        FieldRefer: FieldRef;
        FieldIndex: Integer;
    begin
        VendorMastArch.RESET;
        VendorMastArch.SETFILTER("No.", '%1', DocNo);

        //IF VendorRequisition.GET(DocNo) THEN BEGIN
        IF VendorMastArch.FINDLAST THEN BEGIN
            RecRef.GET(VendorMastArch.RECORDID);
            FieldRefer := RecRef.FIELD(IntFieldNo);
            FieldIndex := 0;
            /*
              REPEAT
                FieldIndex +=1;
                IF FieldRefer.NUMBER = IntFieldNo THEN BEGIN
                  FieldRefer:= RecRef.FIELDINDEX(IntFieldNo);
                END;
              UNTIL FieldIndex =15;*/
            EXIT(FORMAT(FieldRefer.VALUE))
        END;

    end;

    local procedure GetNewValue(DocNo: Code[20]; IntFieldNo: Integer): Text
    var
        VendorRequisition: Record "Vendor Requisition";
        RecRef: RecordRef;
        FieldRefer: FieldRef;
        FieldIndex: Integer;
    begin
        VendorRequisition.RESET;
        VendorRequisition.SETFILTER("No.", '%1', DocNo);
        //IF VendorRequisition.GET(DocNo) THEN BEGIN
        IF VendorRequisition.FINDFIRST THEN BEGIN
            RecRef.GET(VendorRequisition.RECORDID);
            FieldRefer := RecRef.FIELD(IntFieldNo);
            /*
            FieldIndex :=0;
            REPEAT
              FieldIndex +=1;
              FieldRefer := RecRef.FIELDINDEX(FieldIndex);
              IF FieldRefer.NUMBER = IntFieldNo THEN
                FieldRefer:= RecRef.FIELDINDEX(IntFieldNo);
            UNTIL FieldIndex =15;*/
            EXIT(FORMAT(FieldRefer.VALUE))
        END;

    end;

    procedure GSTCalculation(RecPurchaseHeader: Record "Purchase Header"; Var AmountToVendor: Decimal) // 15578
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igstTotal: Decimal;
        GSTper3: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        RecPurchaseLine: Record "Purchase Line";
        ComponentName: Code[20];
        sgst: Decimal;
        cgst: Decimal;
        igst: Decimal;
        TotalAmt: Decimal;
    begin
        Clear(sgst);
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        RecPurchaseLine.Reset();
        RecPurchaseLine.SetRange("Document Type", RecPurchaseHeader."Document Type");
        RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
        if RecPurchaseLine.FindSet() then
            repeat
                TotalAmt += RecPurchaseLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if RecPurchaseLine."GST Jurisdiction Type" = RecPurchaseLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if RecPurchaseLine.Type <> RecPurchaseLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", RecPurchaseLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    begin
                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper3 := TaxTransactionValue.Percent;
                                    end;
                                2:
                                    begin
                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper2 := TaxTransactionValue.Percent;
                                    end;
                                3:
                                    begin
                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper1 := TaxTransactionValue.Percent;
                                    end;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    cgstTOTAL += cgst;
                    sgstTOTAL += sgst;
                    igstTotal += igst;
                end;
            until RecPurchaseLine.Next() = 0;
        AmountToVendor := TotalAmt + igst + sgst + cgst;
        //15578 text
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;
}

