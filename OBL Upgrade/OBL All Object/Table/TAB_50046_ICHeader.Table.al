table 50046 "IC Header"
{
    DrillDownPageID = "IC Transfer - Out List";
    LookupPageID = "IC Transfer - Out List";

    fields
    {
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Inter Company';
            OptionMembers = "Inter Company";
        }
        field(20; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    WhrsSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(30; "From Company"; Text[30])
        {

            trigger OnValidate()
            begin
                TESTFIELD("From Company");
                UpdateFromCompany;
            end;
        }
        field(40; "To Company"; Text[30])
        {

            trigger OnValidate()
            begin
                TESTFIELD("To Company");
                IF "To Company" = "From Company" THEN
                    ERROR(TEXT50000);

                UpdateToCompany;
            end;
        }
        field(50; "From Location"; Code[20])
        {

            trigger OnValidate()
            begin
                TESTFIELD("From Location");
                "To Location" := "From Location";
                UpdateFromLocation;
                UpdateToLocation;
            end;
        }
        field(60; "To Location"; Code[20])
        {

            trigger OnValidate()
            begin
                TESTFIELD("To Location");
            end;
        }
        field(70; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Posting Date");
                UpdatePostingDate;
            end;
        }
        field(80; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                UpdateShortcutDimesion1;
            end;
        }
        field(90; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                UpdateShortcutDimesion2;
            end;
        }
        field(100; "No. Series"; Code[20])
        {
        }
        field(110; "Transfer Type"; Option)
        {
            OptionCaption = 'Transfer In,Transfer Out';
            OptionMembers = "Transfer In","Transfer Out";
        }
        field(50001; "IC Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'IC Gen. Bus. Posting Group';
            Description = 'MSBS.Rao';
            TableRelation = "Gen. Business Posting Group";
        }
    }

    keys
    {
        key(Key1; "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        WhrsSetup.GET;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;
        //MSBS.Rao Begin Dt. 05-09-12
        ComInfo.GET;
        ComInfo.TESTFIELD("IC Gen. Bus. Posting Group");
        "IC Gen. Bus. Posting Group" := ComInfo."IC Gen. Bus. Posting Group";
        //MSBS.Rao End Dt. 05-09-12
    end;

    var
        ICHeader: Record "IC Header";
        WhrsSetup: Record "Warehouse Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ICHandler: Codeunit "IC Transfer - Out";
        ICLine: Record "IC Line";
        DimMgt: Codeunit DimensionManagement;
        ComInfo: Record "Company Information";
        TEXT50000: Label 'From Company and To Company cannot be Same';
        TEXT50001: Label 'Update in Line Section';

    procedure AssistEdit(OldICHeader: Record "IC Header"): Boolean
    var
        ICHeader2: Record "IC Header";
    begin
        WITH ICHeader DO BEGIN
            COPY(Rec);
            WhrsSetup.GET;
            TestNoSeries;
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldICHeader."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := ICHeader;
                EXIT(TRUE);
            END;
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        CASE "Document Type" OF
            "Document Type"::"Inter Company":
                BEGIN
                    WhrsSetup.TESTFIELD("IC Transfer-In Nos.");
                END;
        END;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::"Inter Company":
                BEGIN
                    EXIT(WhrsSetup."IC Transfer-In Nos.");
                END;
        END;
    end;

    procedure InsertPreData()
    begin
        "Transfer Type" := "Transfer Type"::"Transfer Out";
        "Document Type" := "Document Type"::"Inter Company";
        "From Company" := COMPANYNAME;
        "Posting Date" := TODAY;
        IF COMPANYNAME = 'Orient Bell Limited - Bell' THEN
            VALIDATE("To Company", 'Orient Tiles Live Set Up')
        ELSE
            IF COMPANYNAME = 'Orient Tiles Live Set Up' THEN
                VALIDATE("To Company", 'Orient Bell Limited - Bell');
    end;

    procedure UpdateValues()
    begin
    end;

    procedure UpdateFromCompany()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."From Company" := "From Company";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure UpdateToCompany()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."To Company" := "To Company";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure UpdateFromLocation()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."From Location" := "From Location";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure UpdateToLocation()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."To Location" := "To Location";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure UpdatePostingDate()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."Posting Date" := "Posting Date";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure UpdateShortcutDimesion1()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure UpdateShortcutDimesion2()
    begin
        ICLine.RESET;
        ICLine.SETRANGE("Transfer Type", "Transfer Type"::"Transfer Out");
        ICLine.SETRANGE("Document No.", "No.");
        IF ICLine.FINDFIRST THEN BEGIN
            REPEAT
                ICLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                ICLine.MODIFY(TRUE);
            UNTIL ICLine.NEXT = 0;
        END;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        ChangeLogMgt: Codeunit "Change Log Management";
        RecRef: RecordRef;
        xRecRef: RecordRef;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        IF "No." <> '' THEN BEGIN
            //DimMgt.SaveDocDim(
            //DATABASE::"Sales Header","Document Type","No.",0,FieldNumber,ShortcutDimCode);   code blocked for upgrade
            xRecRef.GETTABLE(xRec);
            MODIFY;
            RecRef.GETTABLE(Rec);
        END
        //ChangeLogMgt.LogModification(RecRef,xRecRef);   code blocked for upgrade
        //END ELSE    code blocked for upgrade
        //DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);code blocked for upgrade
    end;
}

