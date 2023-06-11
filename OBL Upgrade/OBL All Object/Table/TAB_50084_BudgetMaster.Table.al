table 50084 "Budget Master"
{
    DrillDownPageID = "Budget Master Lookup";
    LookupPageID = "Budget Master Lookup";
    Permissions = TableData "Approval Entry" = rmd;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    Location.GET("Location Code");
                    //Location.TESTFIELD("Budget No. Series");
                    //NoSeriesMgt.TestManual(Location."Budget No. Series");
                    "No. Series" := '';
                    "Posting No. Series" := GetPostingNoSeriesCode;
                END;
            end;
        }
        field(5; "Capex Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Non-Regular,Disposal';
            OptionMembers = Regular,"Non-Regular",Disposal;
        }
        field(10; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Description 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Project Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Location;

            trigger OnLookup()
            begin
                //GetLocationCode();
            end;
        }
        field(35; "Operation Unit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SKD,HSK,DORA,HO';
            OptionMembers = " ",SKD,HSK,DORA,HO;

            trigger OnValidate()
            begin
                IF "No." <> '' THEN
                    ERROR(ErrorMsg001);
            end;
        }
        field(40; "Budget Amount (In Rs)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Investment (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateAFETotal();
            end;
        }
        field(50; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending for Approval,Released,Completed,Rejected';
            OptionMembers = Open,"Pending for Approval",Released,Completed,Rejected;

            trigger OnValidate()
            begin
                ArchiveBudget(xRec);
            end;
        }
        field(51; "Estimated Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Estimated Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Created By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; "Created Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(85; "Rejected Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "UnPosted Amount"; Decimal)
        {
            CalcFormula = Sum("Capex Entry".Amount WHERE("Entry Type" = CONST("Purchase Order"),
                                                          "Document Type" = CONST("Order"),
                                                          "Capex No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Amount Utilised"; Decimal)
        {
            CalcFormula = Sum("Capex Entry".Amount WHERE("Capex No." = FIELD("No."),
                                                          "Entry Type" = CONST("Invoice"),
                                                          "Document Type" = CONST("Invoice")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(110; "Authorization 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(115; "Authorization 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(120; "Authorization 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(125; "Authorization 4"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(128; "Authorization 5"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(131; "Authorization 6"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(134; "Authorization 7"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(137; "Authorization 8"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Authorization 1 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(145; "Authorization 1 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; "Authorization 2 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(155; "Authorization 2 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(160; "Authorization 3 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(165; "Authorization 3 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(167; "Authorization 4 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(168; "Authorization 4 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(170; "Authorization 5 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(171; "Authorization 5 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(173; "Authorization 6 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(174; "Authorization 6 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(176; "Authorization 7 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(177; "Authorization 7 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(178; "Authorization 8 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(179; "Authorization 8 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(180; "Included In Capex Plan"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(190; Supplementary; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(195; "Type of Investment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Replacement (R),Legal (L)/Compliance , Improvement (I) , Expansion (E) , Strategic (S),Environment';
            OptionMembers = " ","Replacement (R)","Legal (L)/Compliance "," Improvement (I) "," Expansion (E) "," Strategic (S)",Environment;
        }
        field(196; "Investment Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fixed Assets ,Financial Assets';
            OptionMembers = " ","Fixed Assets ","Financial Assets";
        }
        field(200; "Executive Summary"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(210; "Project Rational"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(220; "Financial Evaluation"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(230; "Capital Investment (in INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(231; "NPV (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(240; "IRR%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(245; "Expenditure Sum"; Decimal)
        {
            CalcFormula = Sum("Budget Master Line"."Estimation (In INR)" WHERE("Document No." = FIELD("No."),
                                                                                "Capex Request" = FIELD("Capex Request"),
                                                                                "Type" = FILTER("Project Budget")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(250; "Pay Back Period (In Years)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(260; Contigency; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(270; "AFE Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(280; "Pending Approval UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(282; Currency; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(283; Conversion; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(284; Department; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", 'DEPT');
                DimensionValue.SETRANGE("Display Allow", TRUE);
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE(Department, DimensionValue.Code);
            end;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                ValidateDepartment();

            end;
        }
        field(285; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(286; "Posting No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(287; "Posting No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(900; "Plant & Machinery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(901; "Furniture & Fixture"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(902; "Office Equipment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(903; Vehicles; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(904; Buildings; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(905; "Computer & Peripherals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(906; "Furniture & Fixture SIS/COCO"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(907; "Replacement required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(998; "Executive Summary 1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Executive Summary';
        }
        field(999; "Project Rational 1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Rational';
        }
        field(1000; "Financial Evaluation 1"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Capex Request", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestStatusOpen();
    end;

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            CheckAndAssignLocation();
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", WORKDATE, "No.", "No. Series");
        END;

        "Created By" := USERID;
        "Created Date & Time" := CURRENTDATETIME;
        "Posting No. Series" := GetPostingNoSeriesCode;
    end;

    trigger OnModify()
    begin
        TestStatusOpen();
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Location: Record Location;
        ErrorMsg001: Label 'You cannot change Operation Type once No. is assigned !!!';

    procedure AssistEdit(rec: Record "Budget Master"): Boolean
    begin
        GetPurchSetup;
        PurchasesPayablesSetup.TESTFIELD("Budget No. Series");
        IF NoSeriesMgt.SelectSeries(PurchasesPayablesSetup."Budget No. Series", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestStatusOpen()
    begin
        TESTFIELD(Status, Status::Open);
    end;

    local procedure TestMandatoryFields()
    begin
        TESTFIELD("Included In Capex Plan");
        TESTFIELD(Supplementary);
        TESTFIELD("Type of Investment");
        TESTFIELD("Investment Class");
        TESTFIELD("Investment (In INR)");
        TESTFIELD("Estimated Start Date");
        TESTFIELD("Estimated Completion Date");
    end;

    local procedure GetPurchSetup()
    begin
        PurchasesPayablesSetup.GET;
    end;

    procedure ArchiveBudget(BudgetMaster: Record "Budget Master")
    var
        BudgetMasterArchive: Record "Budget Master Archive";
    begin
        BudgetMasterArchive.INIT;
        BudgetMasterArchive.TRANSFERFIELDS(BudgetMaster);
        BudgetMasterArchive."Archive No." := NextArchiveNo;
        BudgetMasterArchive."Archive By" := USERID;
        BudgetMasterArchive."Archive Date and Time" := CURRENTDATETIME;
        BudgetMasterArchive."Created By" := USERID;
        BudgetMasterArchive."Created Date & Time" := CURRENTDATETIME;
        BudgetMasterArchive.INSERT;
    end;

    local procedure NextArchiveNo(): Integer
    var
        BudgetMasterArchive: Record "Budget Master Archive";
    begin
        BudgetMasterArchive.RESET;
        BudgetMasterArchive.SETRANGE("No.", "No.");
        IF BudgetMasterArchive.FINDLAST THEN
            EXIT(BudgetMasterArchive."Archive No." + 1)
        ELSE
            EXIT(1);
    end;

    procedure SendforApprovalAndCreateApprovalEntries(var BudgetMaster: Record "Budget Master")
    var
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        ApprovalEntryCreated: Boolean;
    begin
        BudgetMaster.TESTFIELD(Status, Status::Open);
        TestMandatoryFields();
        CheckBlankCapexUser();
        CheckSameCapexUserMapped();
        ClearApprovalDateTime(BudgetMaster);
        ApprovalEntryCreated := CheckApprovalLimit(BudgetMaster);
        CLEAR(ApprovalMgt);
        UserSetup.GET(USERID);
        IF NOT ApprovalEntryCreated THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", UserSetup."Capex Authorization 4",
            UserSetup."Capex Authorization 5", UserSetup."Capex Authorization 6", UserSetup."Capex Authorization 7", UserSetup."Capex Authorization 8");
        END;
        BudgetMaster.MODIFY();
        SendNotificationforBudget(BudgetMaster);
    end;

    procedure CancelApprovalEntries(var BudgetMaster: Record "Budget Master")
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        BudgetMaster.TESTFIELD(Status, BudgetMaster.Status::"Pending for Approval");
        CancelNotificationforBudget(BudgetMaster);
        ApprovalEntry.RESET;
        ApprovalEntry.SETFILTER("Table ID", '%1', 50084);
        ApprovalEntry.SETFILTER("Document No.", '%1', BudgetMaster."No.");
        ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            REPEAT
                ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Canceled);
                ApprovalEntry.MODIFY;
            UNTIL ApprovalEntry.NEXT = 0;
        END;
        BudgetMaster."Rejected Date & Time" := CURRENTDATETIME();
        BudgetMaster.Status := BudgetMaster.Status::Open;
        BudgetMaster."Pending Approval UserID" := '';
        BudgetMaster.MODIFY;
    end;

    procedure BudgetApproval(ApprovalEntry: Record "Approval Entry")
    var
        AppApprovalEntry: Record "Approval Entry";
        BudgetMaster: Record "Budget Master";
        BudgetDocNo: Code[20];
    begin
        BudgetDocNo := ApprovalEntry."Document No.";
        BudgetMaster.RESET;
        BudgetMaster.SETRANGE("No.", BudgetDocNo);
        IF BudgetMaster.FINDFIRST THEN BEGIN
            SendNotificationforBudget(BudgetMaster);
        END
        ELSE
            EXIT;
    end;


    procedure SendNotificationforBudget(BudgetMaster: Record "Budget Master")////15578
    var
        //16225 SMTPMailCodeunit: Codeunit 400;
        SrNo: Integer;
        RecCust: Record Customer;
        //16225  SMTPMailSetup: Record "SMTP Mail Setup";
        CompInfo: Record "Company Information";
        Usersetup1: Record "User Setup";
        Usersetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        EmailTo: Text[150];
        EmailCC: Text[150];
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
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
        Email3: Text;
        UserSetup6: Record "User Setup";
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        IndentAppLink: Text[250];
        ShortLink: Text[250];
        ApprovalEntry: Record "Approval Entry";
        PurchaseLine1: Record "Purchase Line";
        TxtBoldBegin: Text;
        TxtBoldEnd: Text;
        Amt2: Decimal;
        ApproverName: Code[100];
        ApprovalEntry1: Record "Approval Entry";
        UserName: Text[100];
        UserSetup7: Record "User Setup";
        ApprovalEntry2: Record "Approval Entry";
        DRAPrice: Decimal;
        SKDPrice: Decimal;
        HSKPrice: Decimal;
        AttachmentManagment: Record "Attachment Lines";
        FilePath: Text;
        FileName: Text;
        Text50090: Label '<TR  bgcolor="#80ff80">';
        Text50091: Label '<TD  width=5 Align=Center bgcolor="#80ff80"> ';
        BudgetDesc: Text;
        BudgetRemark: Text;
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        IsFinalApproval: Boolean;
        ///  ProjectBudgetReport: Report 50085;
        BudgetMaster1: Record "Budget Master";
        IStream: InStream;
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: Codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        FileMgmt: Codeunit "File Management";
        EmailBccList: list of [Text];
        TempBlobCU: Codeunit "Temp Blob";
        InstreamVar: InStream;
        OutstreamVar: OutStream;
        AddRecp: Text;

    begin

        IsFinalApproval := FALSE;
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 50084);
        ApprovalEntry.SETRANGE("Document No.", BudgetMaster."No.");
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Created);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF Usersetup1.GET(ApprovalEntry."Approver ID") THEN BEGIN
                EmailTo := Usersetup1."E-Mail";
                //ApproverName := Usersetup1."User Name"; //MSAK
            END;
            Usersetup1.GET(ApprovalEntry."Approver ID");
            BudgetMaster."Pending Approval UserID" := Usersetup1."User Name";
            BudgetMaster.MODIFY();
            BudgetDesc := 'RecPurchaseHeader1.Description';
            BudgetRemark := 'RecPurchaseHeader1.Remarks';
        END ELSE BEGIN
            IsFinalApproval := TRUE;
            EmailTo := GetEmailID(BudgetMaster."Authorization 1");
            BudgetMaster.Status := BudgetMaster.Status::Released;
            BudgetMaster."Pending Approval UserID" := '';
            BudgetMaster.UpdatePostingNo;

            BudgetMaster.MODIFY;
        END;

        ApprovalEntry1.SETRANGE("Table ID", 50084);
        ApprovalEntry1.SETRANGE("Document No.", BudgetMaster."No.");
        ApprovalEntry1.SETRANGE(Status, ApprovalEntry.Status::Approved);
        IF ApprovalEntry1.FINDLAST THEN
            UpdateApprovalDateTime(BudgetMaster, ApprovalEntry1);

        /*
        CommentLine.RESET;
        CommentLine.SETRANGE(CommentLine."No.",PurchaseHeader."No.");
        IF CommentLine.FINDFIRST THEN BEGIN
          I :=1;
          REPEAT
            Comments += CommentLine.Comment;
          UNTIL (CommentLine.NEXT=0) OR (I = 2);
        END;
        */
        IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN

            // SMTPMailSetup.GET;
            // SMTPMailSetup.TESTFIELD("User ID");
            SrNo := 1;
            //   CLEAR(SMTPMailCodeunit);
            Clear(EmailAddressList);
            Clear(EmailCCList);
            Clear(EmailBccList);

            // SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',EmailTo, FORMAT(BudgetMaster."Operation Unit") + ' Capex No. ' + BudgetMaster."Posting No." + ' for ' + BudgetMaster."Project Name" + ' Amounting Rs. ' + FORMAT(BudgetMaster."Investment (In INR)") + ' - ' + FORMAT(BudgetMaster.Status), '', TRUE);
            EmailAddressList.Add('donotreply@orientbell.com');
            EmailCCList.add('kulbhushan.sharma@orientbell.com');
            IF IsFinalApproval THEN BEGIN
                IF BudgetMaster."Authorization 1" <> '' THEN
                    AddRecp := BudgetMaster."Authorization 1";
                //SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 1"));
                EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 1"));

                IF BudgetMaster."Authorization 2" <> '' THEN
                    //  SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 2"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 2"));
                IF BudgetMaster."Authorization 3" <> '' THEN
                    //  SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 3"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 3"));
                IF BudgetMaster."Authorization 4" <> '' THEN
                    // SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 4"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 4"));
                IF BudgetMaster."Authorization 5" <> '' THEN
                    //  SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 5"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 5"));
                IF BudgetMaster."Authorization 6" <> '' THEN
                    //   SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 6"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 6"));
                IF BudgetMaster."Authorization 7" <> '' THEN
                    //  SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 7"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 7"));
                IF BudgetMaster."Authorization 8" <> '' THEN
                    //SMTPMailCodeunit.AddRecipients(GetEmailID(BudgetMaster."Authorization 8"));
                    EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 8"));
                EmailCCList.Add('pawan.daga@orientbell.com');
                EmailCCList.Add('manish.singh@orientbell.com');

            END;

            EmailBccList.Add('kulbhushan.sharma@orientbell.com');
            BodyText := ('Dear Sir,');
            BodyText += (Text50010);
            BodyText += ('<br><br>');
            //MSAK
            IF BudgetMaster.Status = BudgetMaster.Status::Open THEN BEGIN
                UserSetup7.RESET;
                IF UserSetup7.GET(BudgetMaster."Created By") THEN
                    UserName := UserSetup7."User Name";

                BodyText += ('The Budget No. ' + FORMAT(BudgetMaster."Posting No.") + '  has been raised by ' + UserName + ' for Your Approval.');

                BudgetMaster.VALIDATE(Status, BudgetMaster.Status::"Pending for Approval");
                BudgetMaster.MODIFY;
            END ELSE BEGIN
                ApprovalEntry1.SETRANGE("Table ID", 50084);
                ApprovalEntry1.SETRANGE("Document No.", BudgetMaster."No.");
                ApprovalEntry1.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry1.FINDLAST THEN BEGIN
                    IF Usersetup1.GET(ApprovalEntry1."Approver ID") THEN BEGIN
                        ApproverName := Usersetup1."User Name";
                    END;
                    BodyText += ('The Budget No. ' + FORMAT(BudgetMaster."Posting No.") + ' for ' + BudgetMaster.Description + ' has been approved by ' + ApproverName + ' for Your Approval.');
                END;
            END;

            BodyText += (Text50026 + Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('Total ') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003); //MSAK
            BodyText += (Text50041 + FORMAT(BudgetMaster."Investment (In INR)") + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text60004);
            //MSKS
            BodyText += (Text60004);
            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text60011);
            //Table End
            BodyText += (Comments);
            BodyText += (Text60011);
            BodyText += ('Authoriser Comments, <br>');
            ApprovalEntry2.RESET;
            ApprovalEntry2.SETRANGE("Table ID", 50084);
            ApprovalEntry2.SETRANGE("Document No.", BudgetMaster."No.");
            //ApprovalEntry2.SETRANGE(Status, ApprovalEntry1.Status::Approved);
            ApprovalEntry2.SETFILTER("Comment Text", '<>%1', '');
            IF ApprovalEntry2.FINDFIRST THEN BEGIN
                REPEAT
                    IF Usersetup2.GET(ApprovalEntry2."Approver Code") THEN
                        BodyText += (FORMAT(ApprovalEntry2.Status) + ' : ' + FORMAT(ApprovalEntry2."Last Date-Time Modified") + ' : ' + Usersetup2."User Name" + ' : ' + ApprovalEntry2."Comment Text" + '<br>');
                // BodyText +=('Answer: '+BudgetMaster.Description +'<br><br>');
                UNTIL ApprovalEntry2.NEXT = 0;
            END;
            BodyText += (Text60011);
            BodyText += ('Yours Truly, <br>');
            BodyText += ('For Orient Bell Limited  <br>');
            IF UserSetup6.GET("Created By") THEN
                BodyText += (FORMAT(UserSetup6."User Name") + '<br>');

            IF NOT IsFinalApproval THEN BEGIN
                IndentAppLink := '';
                IndentAppLink := ApprovalMgt.getApprovalLink(50084, BudgetMaster."No.", 0);
                ShortLink := '<a href="' + IndentAppLink + '">Budget Approve/Reject</a>';
                BodyText += (ShortLink);
            END;
            //MSVRN 230818 <<

            AttachmentManagment.ExportAttachmentAsFile(BudgetMaster.RECORDID, FilePath, FileName);

            /*  IF FILE.EXISTS(FilePath + '\' + FileName) THEN //15578
                 EmailMsg.AddAttachment(FilePath + '\' + FileName, FileName, InstreamVar);
  *///15578
    // SMTPMailCodeunit.AddAttachment(FilePath + '\' + FileName, FileName);




            //   CLEAR(ProjectBudgetReport);
            /* BudgetMaster1.RESET;
            BudgetMaster1.SETRANGE("No.", BudgetMaster."No.");
            IF BudgetMaster1.FINDFIRST THEN BEGIN
                FilePath := TEMPORARYPATH;

                IF FILE.EXISTS(FilePath + 'Capex.pdf') THEN
                    ERASE(FilePath + 'Capex.pdf');
 */
            //    ProjectBudgetReport.SETTABLEVIEW(BudgetMaster1);
            //    ProjectBudgetReport.SAVEASPDF(FilePath + 'Capex.pdf');
            //MESSAGE(DestinationFileName);
            // EmailMsg.AddAttachment(FilePath + 'Capex.pdf', 'Capex -' + BudgetMaster1."Posting No." + '.pdf', InstreamVar);


            /*  AttachmentManagment.RESET;
             AttachmentManagment.SETRANGE(AttachmentManagment."Source Document No.", BudgetMaster1."No.");
             IF AttachmentManagment.FINDFIRST THEN BEGIN
                 REPEAT
                     AttachmentManagment.CALCFIELDS(Attachment);
                     IF AttachmentManagment.Attachment.HASVALUE THEN BEGIN
                         AttachmentManagment.ExportAttachmentAsFile(AttachmentManagment."Primary Record ID", FilePath, FileName);
                         //16225 AttachmentManagment.ExportAttachmentAsFile(AttachmentManagment."Primary Key", FilePath, FileName);
                         IF FILE.EXISTS(FilePath + '\' + FileName) THEN
                             EmailMsg.AddAttachment(FilePath + '\' + FileName, FileName, InstreamVar);
                         //AttachmentManagment.Attachment.CREATEINSTREAM(IStream);
                         //SMTPMailCodeunit.AddAttachmentStream(IStream,AttachmentManagment."File Name");
                     END;
                 UNTIL AttachmentManagment.NEXT = 0;
             END; *///15578
            AttachmentManagment.RESET;
            AttachmentManagment.SETRANGE(AttachmentManagment."Source Document No.", BudgetMaster1."No.");
            IF AttachmentManagment.FINDFIRST THEN BEGIN
                AttachmentManagment.CALCFIELDS(Attachment);
                //if AttachmentManagment.Get(BudgetMaster.RecordId) then begin
                IF AttachmentManagment.Attachment.HASVALUE THEN BEGIN
                    AttachmentManagment.Attachment.CreateInStream(InstreamVar);
                    EmailMsg.AddAttachment(AttachmentManagment."File Name", 'application/pdf', InstreamVar);
                END;
                // END;
            end;
        end;



        IF EmailCC <> '' THEN
            EmailCCList.add(EmailCC);
        IF EmailCC1 <> '' THEN
            EmailCCList.add(EmailCC1); //MSKS2310
        IF Email3 <> '' THEN
            EmailCCList.add(Email3);

        EmailAddressList.Add(EmailTo);
        //SLEEP(100);
        EmailMsg.Create(EmailAddressList, FORMAT(BudgetMaster."Operation Unit") + ' Capex No. ' + BudgetMaster."Posting No." + ' for ' + BudgetMaster."Project Name" + ' Amounting Rs. ' + FORMAT(BudgetMaster."Investment (In INR)") + ' - ' + FORMAT(BudgetMaster.Status), BodyText, TRUE, EmailBccList, EmailCCList);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        MESSAGE('Mail has been sent for Capex Document Approval!');

        //  SMTPMailCodeunit.Send();
        // SLEEP(1000);
        IF GUIALLOWED THEN
            MESSAGE('Mail has been sent for Capex Document Approval!');
    END;

    //end;

    procedure CancelNotificationforBudget(BudgetMaster: Record "Budget Master")
    var
        //  SMTPMailCodeunit: Codeunit 400;//16225
        SrNo: Integer;
        RecCust: Record Customer;
        //  SMTPMailSetup: Record SMTP Mail Setup;//16225
        CompInfo: Record "Company Information";
        Usersetup1: Record "User Setup";
        Usersetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        EmailTo: Text[150];
        EmailCC: Text[150];
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
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
        Email3: Text;
        UserSetup6: Record "User Setup";
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        IndentAppLink: Text[250];
        ShortLink: Text[250];
        ApprovalEntry: Record "Approval Entry";
        PurchaseLine1: Record "Purchase Line";
        TxtBoldBegin: Text;
        TxtBoldEnd: Text;
        Amt2: Decimal;
        ApproverName: Code[100];
        ApprovalEntry1: Record "Approval Entry";
        UserName: Text[100];
        UserSetup7: Record "User Setup";
        ApprovalEntry2: Record "Approval Entry";
        DRAPrice: Decimal;
        SKDPrice: Decimal;
        HSKPrice: Decimal;
        AttachmentManagment: Record "Attachment Management";
        FilePath: Text;
        FileName: Text;
        Text50090: Label '<TR  bgcolor="#80ff80">';
        Text50091: Label '<TD  width=5 Align=Center bgcolor="#80ff80"> ';
        BudgetDesc: Text;
        BudgetRemark: Text;
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: Codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        FileMgmt: Codeunit "File Management";
        EmailBccList: list of [Text];
        TempBlobCU: Codeunit "Temp Blob";
        InstreamVar: InStream;
        OutstreamVar: OutStream;

    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);


        IF BudgetMaster."Created Date & Time" <> 0DT THEN
            EmailTo := GetEmailID(BudgetMaster."Created By")
        ELSE
            EXIT;

        //  SMTPMailSetup.GET;
        //  SMTPMailSetup.TESTFIELD("User ID");
        SrNo := 1;
        //   CLEAR(SMTPMailCodeunit);
        //  SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
        // EmailTo, 'Budget No. ' + BudgetMaster."Posting No." + ' ' + ' - ' + FORMAT(BudgetMaster.Status), '', TRUE);
        EmailAddressList.Add('donotreply@orientbell.com');
        //SMTPMailCodeunit.AddCC('donotreply@orientbell.com');//keshav02062020/
        EmailBccList.Add('kulbhushan.sharma@orientbell.com');

        IF BudgetMaster."Authorization 1 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 1"));

        IF BudgetMaster."Authorization 2 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 2"));

        IF BudgetMaster."Authorization 3 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 3"));

        IF BudgetMaster."Authorization 4 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 4"));

        IF BudgetMaster."Authorization 5 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 5"));

        IF BudgetMaster."Authorization 6 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 6"));

        IF BudgetMaster."Authorization 7 Date" <> 0D THEN
            EmailCCList.Add(GetEmailID(BudgetMaster."Authorization 7"));

        BodyText := ('Dear Sir,');
        BodyText += (Text50010);
        BodyText += ('<br><br>');

        ApprovalEntry1.SETRANGE("Table ID", 50084);
        ApprovalEntry1.SETRANGE("Document No.", BudgetMaster."No.");
        ApprovalEntry1.SETRANGE(Status, ApprovalEntry.Status::Rejected);
        IF ApprovalEntry1.FINDLAST THEN BEGIN
            IF Usersetup1.GET(ApprovalEntry1."Approver ID") THEN BEGIN
                ApproverName := Usersetup1."User Name";
            END;
            BodyText += ('The Budget No. ' + FORMAT(BudgetMaster."Posting No.") + ' for ' + BudgetMaster.Description + ' has been Rejected by ' + ApproverName + ' .');
        END;

        BodyText += (Text50026 + Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('Total') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003); //MSAK
        BodyText += (Text50041 + FORMAT(BudgetMaster."Investment (In INR)") + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text50041 + FORMAT('') + Text60003);
        BodyText += (Text60004);
        //MSKS
        BodyText += (Text60004);
        BodyText += (Text60005);
        BodyText += (Text60006);
        BodyText += (Text60011);
        //Table End
        BodyText += (Comments);
        BodyText += (Text60011);

        ApprovalEntry2.RESET;
        ApprovalEntry2.SETRANGE("Table ID", 50084);
        ApprovalEntry2.SETRANGE("Document No.", BudgetMaster."No.");
        ApprovalEntry2.SETRANGE(Status, ApprovalEntry1.Status::Rejected);
        ApprovalEntry2.SETFILTER("Comment Text", '<>%1', '');
        IF ApprovalEntry2.FINDLAST THEN BEGIN
            BodyText += ('Query: ' + ApprovalEntry2."Comment Text" + '<br>');
            BodyText += ('Answer: ' + BudgetMaster.Description + '<br><br>');
        END;

        BodyText += ('Yours Truly, <br>');
        BodyText += ('For Orient Bell Limited  <br>');
        IF UserSetup6.GET(USERID) THEN
            BodyText += (FORMAT(UserSetup6."User Name") + '<br>');

        SLEEP(100);
        EmailMsg.Create(EmailAddressList, 'Budget No. ' + BudgetMaster."Posting No." + ' ' + ' - ' + FORMAT(BudgetMaster.Status), '', TRUE, EmailBccList, EmailCCList);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);

        //  SMTPMailCodeunit.Send();
        SLEEP(1000);
        IF GUIALLOWED THEN
            MESSAGE('Mail has been sent for Capex Document Approval!');

    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
        Location: Record Location;
    begin
        TESTFIELD("Location Code");
        Location.GET("Location Code");
        Location.TESTFIELD("Budget No. Series (Regular)");
        Location.TESTFIELD("Budget Posting No. Series");
        TESTFIELD("Location Code");
        Location.GET("Location Code");
        CASE Rec."Capex Request" OF
            Rec."Capex Request"::Regular:
                BEGIN

                    Location.TESTFIELD("Budget No. Series (Regular)");
                    EXIT(Location."Budget No. Series (Regular)");
                END;
            Rec."Capex Request"::"Non-Regular":
                BEGIN
                    Location.TESTFIELD("Budget No. Series (Non-Regula)");
                    EXIT(Location."Budget No. Series (Non-Regula)");
                END;
            Rec."Capex Request"::Disposal:
                BEGIN
                    Location.TESTFIELD("Budget No. Series(Disposal)");
                    EXIT(Location."Budget No. Series(Disposal)");

                END;
        END;
    end;

    local procedure GetPostingNoSeriesCode(): Code[10]
    var
        Location: Record Location;
    begin
        TESTFIELD("Location Code");
        Location.GET("Location Code");
        Location.GET("Location Code");
        CASE Rec."Capex Request" OF
            Rec."Capex Request"::Regular:
                BEGIN

                    Location.TESTFIELD("Budget Posting No. Series");
                    EXIT(Location."Budget Posting No. Series");
                END;
            Rec."Capex Request"::"Non-Regular":
                BEGIN
                    Location.TESTFIELD("Bud. No. Post Series(Non-Reg.)");
                    EXIT(Location."Bud. No. Post Series(Non-Reg.)");
                END;
            Rec."Capex Request"::Disposal:
                BEGIN
                    Location.TESTFIELD("Budget No. Series(Disposal)");
                    EXIT(Location."Bud. No. Post Series(Disposal)");

                END;
        END;
    end;

    local procedure CheckAndAssignLocation()
    begin

        GetLocationCode();
    end;

    local procedure GetLocationCode()
    begin
        TESTFIELD("Operation Unit");
        Location.RESET;
        IF Rec."Operation Unit" = "Operation Unit"::DORA THEN BEGIN
            Location.RESET;
            Location.SETFILTER(Code, 'DRA-STORE');
            IF PAGE.RUNMODAL(0, Location) = ACTION::LookupOK THEN BEGIN
                VALIDATE("Location Code", Location.Code);
            END;
        END
        ELSE
            IF Rec."Operation Unit" = "Operation Unit"::HSK THEN BEGIN
                Location.RESET;
                Location.SETFILTER(Code, 'HSK-STORE');
                IF PAGE.RUNMODAL(0, Location) = ACTION::LookupOK THEN BEGIN
                    VALIDATE("Location Code", Location.Code);
                END;
            END
            ELSE
                IF Rec."Operation Unit" = "Operation Unit"::SKD THEN BEGIN
                    Location.RESET;
                    Location.SETFILTER(Code, 'SKD-STORE');
                    IF PAGE.RUNMODAL(0, Location) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("Location Code", Location.Code);
                    END;
                END
                ELSE
                    IF Rec."Operation Unit" = "Operation Unit"::HO THEN BEGIN
                        Location.RESET;
                        Location.SETFILTER(Code, 'HEADOFFICE');
                        IF PAGE.RUNMODAL(0, Location) = ACTION::LookupOK THEN BEGIN
                            VALIDATE("Location Code", Location.Code);
                        END;
                    END;
        TESTFIELD("Location Code");
    end;

    procedure getExceutiveSummary(): Text
    var
        CL: Text[1];
    //tempblob: Record 99008535;//16225 TABLE N/F
    begin
        CALCFIELDS("Executive Summary");
        IF NOT "Executive Summary".HASVALUE THEN
            EXIT('');

        CL[1] := 10;
        /*tempblob.Blob:="Executive Summary";/16225 TABLE N/F
        EXIT(tempblob.ReadAsText(CL,TEXTENCODING::UTF8));*/
    end;

    procedure setExceutiveSummary(Text1: Text): Text
    var
        // tempblob: Record "99008535"; //16225 TABLE N/F
        TemBlob: Codeunit "Temp Blob";
    begin
        CALCFIELDS("Executive Summary");

        /*tempblob.Blob:="Executive Summary";/16225 TABLE N/F
        tempblob.WriteAsText(Text1,TEXTENCODING::UTF8);/16225 TABLE N/F
        "Executive Summary":=tempblob.Blob;*///16225 TABLE N/F
        MODIFY;
    end;

    procedure getProjectRational(): Text
    var
        CL: Text[1];
    //tempblob: Record "99008535";//16225 TABLE N/F
    begin
        CALCFIELDS("Project Rational");
        IF NOT "Project Rational".HASVALUE THEN
            EXIT('');

        CL[1] := 10;
        /*tempblob.Blob:="Project Rational";//16225 TABLE N/F
        EXIT(tempblob.ReadAsText(CL,TEXTENCODING::UTF8));*///16225 TABLE N/F
    end;

    procedure setProjectRational(Text1: Text): Text
    var
    //tempblob: Record "99008535"; //16225 TABLE N/F
    begin
        CALCFIELDS("Project Rational");

        /* tempblob.Blob:="Project Rational";//16225 TABLE N/F
         tempblob.WriteAsText(Text1,TEXTENCODING::UTF8);//16225 TABLE N/F
         "Project Rational":=tempblob.Blob;*///16225 TABLE N/F
        MODIFY;
    end;

    procedure getFinancialEvaluation(): Text
    var
        CL: Text[1];
    // tempblob: Record "99008535";//16225 TABLE N/F
    begin
        CALCFIELDS("Financial Evaluation");
        IF NOT "Financial Evaluation".HASVALUE THEN
            EXIT('');

        CL[1] := 10;
        /*tempblob.Blob:="Financial Evaluation";//16225 TABLE N/F
        EXIT(tempblob.ReadAsText(CL,TEXTENCODING::UTF8));*///16225 TABLE N/F
    end;

    procedure setFinancialEvaluation(Text1: Text): Text
    var
    //tempblob: Record "99008535";//16225 TABLE N/F
    begin
        CALCFIELDS("Financial Evaluation");

        /*tempblob.Blob:="Financial Evaluation";//16225 TABLE N/F
        tempblob.WriteAsText(Text1,TEXTENCODING::UTF8);//16225 TABLE N/F
        "Financial Evaluation":=tempblob.Blob;*///16225 TABLE N/F
        MODIFY;
    end;

    local procedure CheckBlankCapexUser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Capex Authorization 1");
        UserSetup.TESTFIELD("Capex Authorization 2");
        UserSetup.TESTFIELD("Capex Authorization 3");
        UserSetup.TESTFIELD("Capex Authorization 4");
        UserSetup.TESTFIELD("Capex Authorization 5");
        UserSetup.TESTFIELD("Capex Authorization 6");
        UserSetup.TESTFIELD("Capex Authorization 7");
        UserSetup.TESTFIELD("Capex Authorization 8");
    end;

    local procedure CheckSameCapexUserMapped()
    var
        UserSetup: Record "User Setup";
        SameUserMappedErr: Label 'Same User can''''t be mapped in Capex Approval Setup !!!';
    begin
        UserSetup.GET(USERID);

        CASE USERID OF
            UserSetup."Capex Authorization 1":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 2":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 3":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 4":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 5":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 6":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 7":
                ERROR(SameUserMappedErr);
            UserSetup."Capex Authorization 8":
                ERROR(SameUserMappedErr);
        END;
    end;

    local procedure CheckApprovalLimit(var BudgetMaster: Record "Budget Master"): Boolean
    var
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        IsApprovalLimitExist: Boolean;
        NoSuitableApproverFoundErr: Label 'No qualified approver was found.';
    begin
        UserSetup.GET(USERID);
        IsApprovalLimitExist := FALSE;

        UserSetup1.GET(UserSetup."Capex Authorization 1");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", '', '', '',
                  '', '', '', '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 2");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", '', '',
                  '', '', '', '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 3");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", '',
                  '', '', '', '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 4");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", UserSetup."Capex Authorization 4",
                  '', '', '', '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 5");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", UserSetup."Capex Authorization 4",
                  UserSetup."Capex Authorization 5", '', '', '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 6");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", UserSetup."Capex Authorization 4",
                  UserSetup."Capex Authorization 5", UserSetup."Capex Authorization 6", '', '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 7");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1.GetCapexApprovalLimit(BudgetMaster."Created By", UserSetup1."User ID") >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", UserSetup."Capex Authorization 4",
                  UserSetup."Capex Authorization 5", UserSetup."Capex Authorization 6", UserSetup."Capex Authorization 7", '');
                EXIT(TRUE);
            END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 8");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
            IsApprovalLimitExist := TRUE;
            IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
                CreateApprovalEntriesForMultipleUsers(BudgetMaster, UserSetup."Capex Authorization 1", UserSetup."Capex Authorization 2", UserSetup."Capex Authorization 3", UserSetup."Capex Authorization 4",
                  UserSetup."Capex Authorization 5", UserSetup."Capex Authorization 6", UserSetup."Capex Authorization 7", UserSetup."Capex Authorization 8");
                EXIT(TRUE);
            END;
        END;
        /*
        UserSetup.GET(USERID);
        IsApprovalLimitExist := FALSE;
        
        UserSetup1.GET(UserSetup."Capex Authorization 1");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",'','','',
              '','','','');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 2");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",'','',
              '','','','');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 3");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",UserSetup."Capex Authorization 3",'',
              '','','','');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 4");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",UserSetup."Capex Authorization 3",UserSetup."Capex Authorization 4",
              '','','','');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 5");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",UserSetup."Capex Authorization 3",UserSetup."Capex Authorization 4",
              UserSetup."Capex Authorization 5",'','','');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 6");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",UserSetup."Capex Authorization 3",UserSetup."Capex Authorization 4",
              UserSetup."Capex Authorization 5",UserSetup."Capex Authorization 6",'','');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 7");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",UserSetup."Capex Authorization 3",UserSetup."Capex Authorization 4",
              UserSetup."Capex Authorization 5",UserSetup."Capex Authorization 6",UserSetup."Capex Authorization 7",'');
            EXIT(TRUE);
          END;
        END;
        UserSetup1.GET(UserSetup."Capex Authorization 8");
        IF UserSetup1."Request Capex Amount Limit" <> 0 THEN BEGIN
          IsApprovalLimitExist := TRUE;
          IF UserSetup1."Request Capex Amount Limit" >= BudgetMaster."Investment (In INR)" THEN BEGIN
            CreateApprovalEntriesForMultipleUsers(BudgetMaster,UserSetup."Capex Authorization 1",UserSetup."Capex Authorization 2",UserSetup."Capex Authorization 3",UserSetup."Capex Authorization 4",
              UserSetup."Capex Authorization 5",UserSetup."Capex Authorization 6",UserSetup."Capex Authorization 7",UserSetup."Capex Authorization 8");
            EXIT(TRUE);
          END;
        END;
        */
        IF IsApprovalLimitExist THEN
            ERROR(NoSuitableApproverFoundErr);

    end;

    local procedure CreateApprovalEntriesForMultipleUsers(var BudgetMaster: Record "Budget Master"; User1: Text; User2: Text; User3: Text; User4: Text; User5: Text; User6: Text; User7: Text; User8: Text)
    var
        UserSetup1: Record "User Setup";
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        i: Integer;
        NoOfUser: Integer;
        RpUserID: Text;
    begin
        //UserSetup.GET(USERID);

        // User Authorization 1
        IF User1 <> '' THEN BEGIN
            UserSetup1.GET(User1);
            BudgetMaster.VALIDATE("Authorization 1", UserSetup1."User ID");
            ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 1", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID := UserSetup1."User ID";
        END;

        // User Authorization 2
        IF User2 <> '' THEN BEGIN
            UserSetup1.GET(User2);
            BudgetMaster.VALIDATE("Authorization 2", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 2", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;

        // User Authorization 3
        IF User3 <> '' THEN BEGIN
            UserSetup1.GET(User3);
            BudgetMaster.VALIDATE("Authorization 3", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 3", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;

        // User Authorization 4
        IF User4 <> '' THEN BEGIN
            UserSetup1.GET(User4);
            BudgetMaster.VALIDATE("Authorization 4", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 4", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;

        // User Authorization 5
        IF User5 <> '' THEN BEGIN
            UserSetup1.GET(User5);
            BudgetMaster.VALIDATE("Authorization 5", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 5", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;

        // User Authorization 6
        IF User6 <> '' THEN BEGIN
            UserSetup1.GET(User6);
            BudgetMaster.VALIDATE("Authorization 6", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 6", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;

        // User Authorization 7
        IF User7 <> '' THEN BEGIN
            UserSetup1.GET(User7);
            BudgetMaster.VALIDATE("Authorization 7", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 7", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;

        // User Authorization 8
        IF User8 <> '' THEN BEGIN
            UserSetup1.GET(User8);
            BudgetMaster.VALIDATE("Authorization 8", UserSetup1."User ID");
            IF STRPOS(RpUserID, UserSetup1."User ID") = 0 THEN
                ApprovalMgt.MakeApprovalEntry(50084, BudgetMaster."No.", 2, USERID, BudgetMaster."Authorization 8", BudgetMaster."Investment (In INR)", UserSetup1."E-Mail");
            RpUserID += '|' + UserSetup1."User ID";
        END;
    end;

    local procedure ClearApprovalDateTime(var BudgetMaster: Record "Budget Master")
    begin
        BudgetMaster.VALIDATE("Authorization 1", '');
        BudgetMaster.VALIDATE("Authorization 1 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 1 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 2", '');
        BudgetMaster.VALIDATE("Authorization 2 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 2 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 3", '');
        BudgetMaster.VALIDATE("Authorization 3 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 3 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 4", '');
        BudgetMaster.VALIDATE("Authorization 4 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 4 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 5", '');
        BudgetMaster.VALIDATE("Authorization 5 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 5 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 6", '');
        BudgetMaster.VALIDATE("Authorization 6 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 6 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 7", '');
        BudgetMaster.VALIDATE("Authorization 7 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 7 Time", 0T);
        BudgetMaster.VALIDATE("Authorization 8", '');
        BudgetMaster.VALIDATE("Authorization 8 Date", 0D);
        BudgetMaster.VALIDATE("Authorization 8 Time", 0T);
        BudgetMaster.VALIDATE("Rejected Date & Time", 0DT);
        BudgetMaster.VALIDATE("Pending Approval UserID", '');
        BudgetMaster.MODIFY();
    end;

    local procedure UpdateApprovalDateTime(BudgetMaster: Record "Budget Master"; ApprovalEntry: Record "Approval Entry")
    begin
        IF BudgetMaster.Status = BudgetMaster.Status::Open THEN
            EXIT;
        IF BudgetMaster."Authorization 1" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 1 Date" := TODAY;
            BudgetMaster."Authorization 1 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 2" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 2 Date" := TODAY;
            BudgetMaster."Authorization 2 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 3" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 3 Date" := TODAY;
            BudgetMaster."Authorization 3 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 4" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 4 Date" := TODAY;
            BudgetMaster."Authorization 4 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 5" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 5 Date" := TODAY;
            BudgetMaster."Authorization 5 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 6" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 6 Date" := TODAY;
            BudgetMaster."Authorization 6 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 7" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 7 Date" := TODAY;
            BudgetMaster."Authorization 7 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
        IF BudgetMaster."Authorization 8" = ApprovalEntry."Approver ID" THEN BEGIN
            BudgetMaster."Authorization 8 Date" := TODAY;
            BudgetMaster."Authorization 8 Time" := TIME;
            BudgetMaster.MODIFY; //MSAK
        END;
    end;

    local procedure GetEmailID(UserID: Code[50]): Text
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(UserID);
        //EXIT('rohan.garg@mindshell.info');
        EXIT(UserSetup."E-Mail");
    end;

    local procedure UpdateAFETotal()
    begin
        VALIDATE("AFE Total", "Investment (In INR)");
    end;

    procedure AllowUserToUpdate(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(UPPERCASE(USERID));
        EXIT(UserSetup."Allow Capex Modify");
    end;

    local procedure ValidateDepartment()
    var
        DimensionValue: Record "Dimension Value";
        InvalidOption: Label '%1 is not an option.';
    begin
        DimensionValue.RESET;
        DimensionValue.SETFILTER(DimensionValue."Dimension Code", 'DEPT');
        DimensionValue.SETRANGE("Display Allow", TRUE);
        DimensionValue.SETRANGE(Code, Department);
        IF DimensionValue.FINDFIRST THEN
            VALIDATE("Department Name", DimensionValue.Name)
        ELSE
            IF Department <> '' THEN
                ERROR(InvalidOption, Department)
            ELSE
                "Department Name" := '';
    end;

    procedure UpdatePaymentAmount()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvLine: Record "Purch. Inv. Line";
        RpPurchInvNo: Text;
    begin
        RpPurchInvNo := '';
        PurchInvLine.SETCURRENTKEY("Document No.");
        PurchInvLine.RESET();
        PurchInvLine.SETRANGE("Capex No.", "No.");
        IF PurchInvLine.FINDFIRST THEN BEGIN
            "Payment Amount" := 0;
            REPEAT
                IF RpPurchInvNo <> PurchInvLine."Document No." THEN BEGIN
                    VendorLedgerEntry.SETAUTOCALCFIELDS(Amount, "Remaining Amount");
                    VendorLedgerEntry.RESET();
                    // VendorLedgerEntry.SETCURRENTKEY("Document Type","Document No.","TDS Nature of Deduction","TDS Group");//16225 TABLE FIELD N/F
                    VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                    VendorLedgerEntry.SETRANGE("Document No.", PurchInvLine."Document No.");
                    IF VendorLedgerEntry.FINDFIRST THEN
                        "Payment Amount" += ABS(VendorLedgerEntry.Amount) - ABS(VendorLedgerEntry."Remaining Amount");
                END;
                RpPurchInvNo := PurchInvLine."Document No.";
            UNTIL PurchInvLine.NEXT = 0;
            MODIFY();
        END;
    end;

    procedure GetName(UserCode: Code[50]): Text
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UserCode) THEN
            EXIT(UserSetup."User Name");
    end;

    procedure UpdatePostingNo()
    begin
        TESTFIELD("Posting No. Series");

        IF "Posting No." = '' THEN
            "Posting No." := NoSeriesMgt.GetNextNo("Posting No. Series", WORKDATE, TRUE);
    end;
}

