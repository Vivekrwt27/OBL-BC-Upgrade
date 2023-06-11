table 50039 "Prod. Reporting Header"
{
    Caption = 'Production Header';
    DataCaptionFields = "No.";

    fields
    {
        field(3; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin

                IF "No." <> xRec."No." THEN BEGIN
                    MfgSetup.GET;
                    NoSeriesMgt.TestManual(MfgSetup."Production Reporting No.Series");
                    "No. Series" := '';
                END;
            end;
        }
        field(10; Shift; Code[20])
        {
            TableRelation = "Work Shift";

            trigger OnValidate()
            begin
                TESTFIELD("Status", Status::Open);
            end;
        }
        field(15; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(20; Location; Code[20])
        {
            TableRelation = Location."Code" WHERE("Prod. Units" = FIELD("Prod. Units"));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(25; Posted; Boolean)
        {
            Editable = false;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(100; "Prod. Units"; Option)
        {
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                TESTFIELD(Posted, FALSE);
            end;
        }
        field(109; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series"."Default Nos.";
        }
        field(110; "Order No. Series"; Code[10])
        {
            Caption = 'Order No. Series';
            TableRelation = "No. Series";
        }
        field(112; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(113; "Created By"; Code[20])
        {
        }
        field(114; "Created Date"; Date)
        {
        }
        field(120; "Prod. Order No."; Code[20])
        {
        }
        field(125; Status; Option)
        {
            OptionMembers = Open,Released,"Output Reported","Partially Consumed","Consumption Done",Closed;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(481; PMT_Flag; Boolean)
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(DropDown; "No.")//,Field2,Field79) 16225 N/F
        {
        }
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            MfgSetup.GET;
            MfgSetup.TESTFIELD("Production Reporting No.Series");
            NoSeriesMgt.InitSeries(MfgSetup."Production Reporting No.Series", xRec."No. Series", WORKDATE, "No.", MfgSetup."Production Reporting No.Series");
        END;


        "Created By" := USERID;
        "Created Date" := WORKDATE;
        "Posting Date" := WORKDATE;
    end;

    var
        MfgSetup: Record "Manufacturing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProdReportingLine: Record "Prod. Reporting Line";
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        Text010: Label 'One or more reservation entries exist for the item with %1 = %2, %3 = %4, %5 = %6 which may be disrupted if you post this negative adjustment. Do you want to continue?', Comment = 'One or more reservation entries exist for the item with Item No. = 1000, Location Code = BLUE, Variant Code = NEW which may be disrupted if you post this negative adjustment. Do you want to continue?';
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ProdReportHeader: Record "Prod. Reporting Header";
        DimMgt: Codeunit DimensionManagement;

    procedure AssistEdit(OldPRHExecuteHeader: Record "Prod. Reporting Header"): Boolean
    var
        SalesHeader2: Record "Sales Header";
    begin
        MfgSetup.GET;
        MfgSetup.TESTFIELD("Production Reporting No.Series");
        IF NoSeriesMgt.SelectSeries(MfgSetup."Production Reporting No.Series", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestStatusOpen()
    begin
        //IF StatusCheckSuspended THEN
        // EXIT;
        //GetPurchHeader;
        //IF NOT "System-Created Entry" THEN
        IF ProdReportingLine."FG No." <> '' THEN
            ProdReportHeader.TESTFIELD(Status, ProdReportHeader.Status::Open);
    end;

    procedure ReleaseProductionOrder()
    begin
        ProdReportingLine.RESET;
        ProdReportingLine.SETRANGE("Document No.", "No.");
        IF ProdReportingLine.FINDFIRST THEN
            REPEAT
                ProdReportingLine.TESTFIELD("Quantity Produced");
            UNTIL ProdReportingLine.NEXT = 0;

        IF CONFIRM('Do you want to release the document', FALSE, TRUE) THEN
            Rec.Status := Rec.Status::Released
        ELSE
            EXIT;
        MODIFY;
        MESSAGE('Document Successfully Released');
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID, No, '',
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

