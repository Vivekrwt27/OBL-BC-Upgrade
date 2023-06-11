table 50016 "Indent Header"
{
    // 
    // 
    // //-- 1. Tri36.1 PG 14112006 -- New Field Added "Department Code" Code 10 -- Capture Department Code
    // //-- 2. Tri36.1 PG 14112006 -- New Field Added "Plant Code" Code 10 -- Capture Plant Code
    // //-- 3. Tri36.1 PG 14112006 -- New Field Added "Authorization 1 Date" Date -- Stage Wise Auth. Date & Time
    // //-- 4. Tri36.1 PG 14112006 -- New Field Added "Authorization 1 Time" Time -- Stage Wise Auth. Date & Time
    // //-- 5. Tri36.1 PG 14112006 -- New Field Added "Authorization 2 Date" Date -- Stage Wise Auth. Date & Time
    // //-- 6. Tri36.1 PG 14112006 -- New Field Added "Authorization 2 Time" Time -- Stage Wise Auth. Date & Time
    // //-- 7. Tri36.1 PG 14112006 -- New Field Added "Authorization Date" Date -- Stage Wise Auth. Date & Time
    // //-- 8. Tri36.1 PG 14112006 -- New Field Added "Authorization Time" Time -- Stage Wise Auth. Date & Time
    // //-- 9. Tri36.1 PG 14112006 -- New Field Added "Closed Date" Date -- Stage Wise Auth. Date & Time
    // //-- 10. Tri36.1 PG 14112006 -- New Field Added "Closed Time" Time -- Stage Wise Auth. Date & Time
    // 1.TRI S.R 220310 - New field Added for Group Code.

    LookupPageID = "Indent Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchasesPayablesSetup.GET;
                    NoSeriesMgt.TestManual(PurchasesPayablesSetup."Indent Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Indent Date"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                IndentLine.RESET;
                IndentLine.SETFILTER(IndentLine."Document No.", "No.");
                IF IndentLine.FIND('-') THEN
                    REPEAT
                        IndentLine.VALIDATE(IndentLine."Date", "Indent Date");
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
                VALIDATE("Validity Period");
            end;
        }
        field(3; "User ID"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            var
                UserSetup1: Record "User Setup";
            begin
                UserSetup.RESET;
                UserSetup.SETFILTER(UserSetup."User ID", "User ID");
                IF UserSetup.FIND('-') THEN BEGIN
                    VALIDATE("Authorization 1", UserSetup."Authorization 1");
                    VALIDATE("Authorization 2", UserSetup."Authorization 2");
                    VALIDATE("Authorization 3", UserSetup."Authorization 3");
                    CLEAR(ApprovalMgt);
                    CALCFIELDS(Amount);
                    IF "Indent Date" > 20180823D THEN //16225 082318D Change 20180823D
                        "Mail Approval" := TRUE;
                    ApprovalMgt.MakeApprovalEntry(50016, Rec."No.", 2, "User ID", UserSetup."Authorization 1", Amount, UserSetup."E-Mail");
                    CLEAR(ApprovalMgt);
                    IF UserSetup1.GET(UserSetup."Authorization 1") THEN
                        ApprovalMgt.MakeApprovalEntry(50016, Rec."No.", 2, "User ID", UserSetup."Authorization 2", Amount, UserSetup1."E-Mail");
                    CLEAR(ApprovalMgt);
                    IF UserSetup1.GET(UserSetup."Authorization 2") THEN
                        ApprovalMgt.MakeApprovalEntry(50016, Rec."No.", 2, "User ID", UserSetup."Authorization 3", Amount, UserSetup1."E-Mail");
                END;
            end;
        }
        field(4; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Authorization1,Authorization2,Authorized,Closed,Authorization3';
            OptionMembers = Open,Authorization1,Authorization2,Authorized,Closed,Authorization3;

            trigger OnValidate()
            begin
                IndentLine.RESET;
                IndentLine.SETFILTER(IndentLine."Document No.", "No.");
                IF IndentLine.FIND('-') THEN
                    REPEAT
                        IndentLine.VALIDATE(IndentLine.Status, Status);
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(5; Deleted; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            begin
                IndentLine.RESET;
                IndentLine.SETFILTER(IndentLine."Document No.", "No.");
                IF IndentLine.FIND('-') THEN
                    REPEAT
                        IndentLine.Deleted := TRUE;
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(6; Description; Text[100])
        {

            trigger OnValidate()
            begin
                //IF IndentHeader.GET("Document No.") THEN //MSBS.Rao 290914
                //IndentHeader.TESTFIELD(IndentHeader.Status,IndentHeader.Status::Open);
            end;
        }
        field(7; "No. Series"; Code[10])
        {
        }
        field(8; "Location Code"; Code[10])
        {
            TableRelation = Location;

            trigger OnLookup()
            begin
                UserLocation.RESET;
                UserLocation.SETFILTER(UserLocation."User ID", USERID);
                UserLocation.SETFILTER(UserLocation."Create Indent", '%1', TRUE);
                IF UserLocation.FIND('-') THEN
                    IF PAGE.RUNMODAL(Page::"User Locations", UserLocation) = ACTION::LookupOK THEN
                        VALIDATE("Location Code", UserLocation."Location Code");
            end;

            trigger OnValidate()
            begin
                IndentHeader.TESTFIELD(IndentHeader.Status, IndentHeader.Status::Open);
                IndentLine.RESET;
                IndentLine.SETFILTER(IndentLine."Document No.", '%1', "No.");
                IF IndentLine.FIND('-') THEN
                    REPEAT
                        IndentLine."Location Code" := "Location Code";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(9; Selection; Boolean)
        {
        }
        field(10; comment; Boolean)
        {
            FieldClass = FlowField;

            CalcFormula = Exist("Comment Line" WHERE("Table Name" = const("Indent Header"),
                                                      "No." = FIELD("No.")));

        }
        field(11; "Authorization 1"; Code[20])
        {
            Editable = false;
        }
        field(12; "Authorization 2"; Code[20])
        {
            Editable = false;
        }
        field(13; "Completely Ordered"; Boolean)
        {
        }
        field(14; Remarks; Text[30])
        {
        }
        field(15; "Department Code"; Code[20])
        {
            Description = 'Tri36.1 PG 14112006 -- Capture Department Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPT'));
        }
        field(16; "Plant Code"; Code[10])
        {
            Description = 'Tri36.1 PG 14112006 -- Capture Plant Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('PLANT'));
        }
        field(17; "Authorization 1 Date"; Date)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(18; "Authorization 1 Time"; Time)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(19; "Authorization 2 Date"; Date)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(20; "Authorization 2 Time"; Time)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(21; "Authorization Date"; Date)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(22; "Authorization Time"; Time)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(23; "Closed Date"; Date)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(24; "Closed Time"; Time)
        {
            Description = 'Tri36.1 PG 14112006 -- Stage Wise Auth. Date & Time';
            Editable = false;
        }
        field(25; "Authorization 3"; Code[20])
        {
            Description = 'MS-PB';
            Editable = false;
        }
        field(26; "Authorization 3 Date"; Date)
        {
            Description = 'MS-PB';
            Editable = false;
        }
        field(27; "Authorization 3 Time"; Time)
        {
            Description = 'MS-PB';
            Editable = false;
        }
        field(50; Hold; Boolean)
        {

            trigger OnValidate()
            begin
                CLEAR(IndentMail);
                IF xRec.Hold <> Hold THEN
                    IndentMail.SendNotificationHold(Rec);
            end;
        }
        field(55; "Hold By"; Code[50])
        {
        }
        field(60; "Hold on"; DateTime)
        {
            Editable = false;
        }
        field(90; "Auto Indent"; Boolean)
        {
        }
        field(50001; Amount; Decimal)
        {
            CalcFormula = Sum("Indent Line".Amount WHERE("Document No." = FIELD("No.")));
            Description = 'TRI S.S.J DATE 30032009';
            FieldClass = FlowField;
        }
        field(50002; "Group Code"; Code[2])
        {
            Description = 'TRI S.R 220310 - New field Add';
            TableRelation = "Item Group";

            trigger OnValidate()
            begin
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FIND('-') THEN
                    ERROR(Err003);
            end;
        }
        field(50003; "Validate Upto"; Date)
        {
            Editable = false;
        }
        field(50004; "Validity Period"; DateFormula)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Indent Date");
                IF "Validity Period" <> CheckDate THEN
                    "Validate Upto" := CALCDATE("Validity Period", "Indent Date")
                ELSE
                    "Validate Upto" := 0D;
            end;
        }
        field(50005; "Capex No."; Code[22])
        {
            Description = 'Ori Ut';
            TableRelation = "Budget Master"."No." WHERE(Status = FILTER(Released),
                                                       "Location Code" = FIELD("Location Code"));
        }
        field(50006; Replied; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50007; Commented; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50008; "Mail Authorization1"; Boolean)
        {
            Description = 'MSAK';
        }
        field(50009; "Mail Authorization2"; Boolean)
        {
            Description = 'MSAK';
        }
        field(50010; "Mail Authorization3"; Boolean)
        {
            Description = 'MSAK';
        }
        field(50011; "Mail Authorized"; Boolean)
        {
            Description = 'MSAK';
        }
        field(50012; "Reason of Rejection"; Text[250])
        {
        }
        field(50013; "Created By"; Text[100])
        {
        }
        field(50014; "Job Indent"; Boolean)
        {
        }
        field(50015; "Requition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,Urgent';
            OptionMembers = " ",Normal,Urgent;
        }
        field(50020; "RGP No."; Code[20])
        {
            Description = 'MSVRN 290518';
        }
        field(50021; "RGP Made"; Boolean)
        {
            Description = 'MSVRN 310518';
        }
        field(50022; "Mail Approval"; Boolean)
        {
        }
        field(50023; "Dept Name"; Text[40])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('DEPT'),
                                                               "Code" = FIELD("Department Code")));
            FieldClass = FlowField;
        }
        field(50024; "Executed By"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID" WHERE("Purchase User" = CONST(true));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


        IF Status <> Status::Open THEN
            ERROR('You cannot delete Indent No. %1. To delete Status should be Open', "No.");

        IndentLine.RESET;
        IndentLine.SETFILTER(IndentLine."Document No.", '%1', "No.");
        IF IndentLine.FIND('-') THEN
            IndentLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin


        IF "No." = '' THEN BEGIN
            PurchasesPayablesSetup.GET;
            PurchasesPayablesSetup.TESTFIELD("Indent Nos.");
            NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Indent Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        VALIDATE("Indent Date", WORKDATE);
        VALIDATE("User ID", USERID);
        VALIDATE(Status, Status::Open);

        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."Create Indent", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            VALIDATE("Location Code", UserLocation."Location Code");

        MARK(TRUE);

        "Indent Date" := TODAY;

        IF NoSeries1.GET("No. Series") THEN //MSVRN 290518
            VALIDATE("Job Indent", NoSeries1."Job Indent");
    end;

    trigger OnModify()
    begin
        /*UserSetup.RESET;
        UserSetup.SETFILTER(UserSetup."User ID","User ID");
        IF UserSetup.FIND('-') THEN BEGIN
          CASE Status OF
        
          Status::Open:
            IF UserSetup."User ID" <> UPPERCASE(USERID) THEN
              ERROR('You are not allowed to modify this Indent');
        
          Status::Authorization1:
            IF UserSetup."Authorization 1" <> UPPERCASE(USERID) THEN
              ERROR('You are not allowed to modify this Indent');
        
          Status::Authorization2:
            IF UserSetup."Authorization 2" <> UPPERCASE(USERID) THEN
              ERROR('You are not allowed to modify this Indent');
        
          Status::Authorization3:
            IF UserSetup."Authorization 3" <> UPPERCASE(USERID) THEN
              ERROR('You are not allowed to modify this Indent');
        
          END;
        
        END;
        //UserAccess := 32;
        //Permissions.Type(UserAccess,"Location Code");
        
        TESTFIELD("Indent Date");
         */

    end;

    trigger OnRename()
    begin


        //TRI DG 031109 Add Start
        //IF Status = Status::Authorized THEN
        ERROR('You cannot rename Authorized Indent');
        //TRI DG 031109 Add Stop
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserLocation: Record "User Location";
        IndentLine: Record "Indent Line";
        Permissions: Codeunit Permissions1;
        UserAccess: Integer;
        UserSetup: Record "User Setup";
        IndentHeader: Record "Indent Header";
        PurchSetup: Record "Purchases & Payables Setup";
        CheckDate: DateFormula;
        Err001: Label 'Enter Dept Code. ';
        Err002: Label 'Enter Plant Code.';
        Err003: Label 'You can not chang the Group Code. ';
        IndentMail: Codeunit IndentRelease;
        NoSeries1: Record "No. Series";
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        EmailN: Text;

    procedure AssistEdit(OldIndentheader: Record "Indent Header"): Boolean
    begin
        PurchSetup.GET;
        IF NoSeriesMgt.SelectSeries(PurchSetup."Indent Nos.", OldIndentheader."No. Series", "No. Series") THEN BEGIN
            PurchSetup.GET;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    procedure HoldIndent(var IndentHeader1: Record "Indent Header")
    begin
        IndentHeader1.TESTFIELD(Hold, FALSE);
        IF IndentHeader1.Hold THEN
            EXIT;

        IndentHeader1.VALIDATE(Hold, TRUE);
        IndentHeader1."Hold By" := USERID;
        IndentHeader1."Hold on" := CURRENTDATETIME;
        IndentHeader1.MODIFY;
    end;

    procedure UnHoldIndent(var IndentHeader1: Record "Indent Header")
    begin
        IF NOT IndentHeader1.Hold THEN
            EXIT;
        IndentHeader1.TESTFIELD(IndentHeader1."Hold By", USERID);
        IndentHeader1.VALIDATE(Hold, FALSE);
        IndentHeader1."Hold By" := '';
        IndentHeader1."Hold on" := CREATEDATETIME(0D, 0T);
        IndentHeader1.MODIFY;
    end;

    local procedure "--MSVRN--"()
    begin
    end;

    procedure CancelIndentApprovalEnt(IndentNo: Code[20])
    begin
        "Reason of Rejection" := 'Rejected !'; //MSVRN >><<
        MODIFY(TRUE);
        TESTFIELD("Reason of Rejection");

        CLEAR(EmailN);
        SLEEP(1000);
        //EmailN.SendMail(Rec);

        IF "Authorization 3" <> UPPERCASE(USERID) THEN BEGIN
            IndentLine.RESET;
            IndentLine.SETFILTER(IndentLine."Document No.", IndentNo);
            IndentLine.SETFILTER(IndentLine."Order No.", '<>%1', '');
            IF NOT IndentLine.FIND('-') THEN
                ERROR('You cannot Close Indent %1 as Purchase Order Details does not exist for any of the lines. Please Delete the Indent.', "No."
               );
        END;
        //IF Status <> Status::Authorization3 THEN
        // ERROR('Status must be authorized to close the Indent');

        //IF CONFIRM('Do you want to Close Indent %1?',TRUE,"No.") THEN BEGIN //MSVRN --Open
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."Location Code", "Location Code");
        UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);
        IF UserLocation.FIND('-') THEN BEGIN
            VALIDATE(Status, Status::Closed);
            MODIFY;


            IndentLine.RESET;
            IndentLine.SETFILTER(IndentLine."Document No.", "No.");
            IndentLine.SETFILTER(IndentLine."Order No.", '%1', '');
            IF IndentLine.FIND('-') THEN
                REPEAT
                    IndentLine.Deleted := TRUE;
                    IndentLine.MODIFY;
                UNTIL IndentLine.NEXT = 0;
        END ELSE BEGIN
            MESSAGE('You are not authorized to Close this indent');
        END;
        MESSAGE('Indent %1 is available as Archived.', "No.");
        //END;
    end;
}

