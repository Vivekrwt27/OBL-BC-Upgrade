table 70020 "Fixed Asset New"
{
    Caption = 'Fixed Asset';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Fixed Asset List";
    LookupPageID = "Fixed Asset List";
    Permissions = TableData "Ins. Coverage Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Search Description"; Code[30])
        {
            Caption = 'Search Description';
        }
        field(4; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
        }
        field(5; "FA Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            TableRelation = "FA Class";
        }
        field(6; "FA Subclass Code"; Code[10])
        {
            Caption = 'FA Subclass Code';
            TableRelation = "FA Subclass";
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(10; "FA Location Code"; Code[10])
        {
            Caption = 'FA Location Code';
            TableRelation = "FA Location";
        }
        field(11; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(12; "Main Asset/Component"; Option)
        {
            Caption = 'Main Asset/Component';
            Editable = false;
            OptionCaption = ' ,Main Asset,Component';
            OptionMembers = " ","Main Asset",Component;
        }
        field(13; "Component of Main Asset"; Code[20])
        {
            Caption = 'Component of Main Asset';
            Editable = false;
            TableRelation = "Fixed Asset";
        }
        field(14; "Budgeted Asset"; Boolean)
        {
            Caption = 'Budgeted Asset';
        }
        field(15; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(16; "Responsible Employee"; Code[20])
        {
            Caption = 'Responsible Employee';
            TableRelation = Employee;
        }
        field(17; "Serial No."; Text[30])
        {
            Caption = 'Serial No.';
        }
        field(18; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(19; Insured; Boolean)
        {
            CalcFormula = Exist("Ins. Coverage Ledger Entry" WHERE("FA No." = FIELD("No."),
                                                                    "Disposed FA" = CONST(false)));
            Caption = 'Insured';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Fixed Asset"),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(22; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(23; "Maintenance Vendor No."; Code[20])
        {
            Caption = 'Maintenance Vendor No.';
            TableRelation = Vendor;
        }
        field(24; "Under Maintenance"; Boolean)
        {
            Caption = 'Under Maintenance';
        }
        field(25; "Next Service Date"; Date)
        {
            Caption = 'Next Service Date';
        }
        field(26; Inactive; Boolean)
        {
            Caption = 'Inactive';
        }
        field(27; "FA Posting Date Filter"; Date)
        {
            Caption = 'FA Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(29; "FA Posting Group"; Code[10])
        {
            Caption = 'FA Posting Group';
            TableRelation = "FA Posting Group";
        }
        field(13701; "Excise Prod. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Prod. Posting Group".Code;//16225 TABLE N/F
        }
        field(13702; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENTVAT,Without CENTVAT';
            OptionMembers = "With CENTVAT","Without CENTVAT";
        }
        field(13703; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(13708; "Tax Group Code"; Code[10])
        {
            TableRelation = "Tax Group".Code;
        }
        field(13740; "Import Duty Group"; Code[10])
        {
            // TableRelation = Table13752;//16225 TABLE N/F
        }
        field(16351; "VAT Product Posting Group"; Code[10])
        {
            // TableRelation = Table16351.Field1; //16225 TABLE N/F
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Description")
        {
        }
        key(Key3; "FA Class Code")
        {
        }
        key(Key4; "FA Subclass Code")
        {
        }
        key(Key5; "Component of Main Asset", "Main Asset/Component")
        {
        }
        key(Key6; "FA Location Code")
        {
        }
        key(Key7; "Global Dimension 1 Code")
        {
        }
        key(Key8; "Global Dimension 2 Code")
        {
        }
        key(Key9; "FA Posting Group")
        {
        }
        key(Key10; "FA Class Code", "FA Subclass Code", "Vendor No.", "FA Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'A main asset cannot be deleted.';
        Text001: Label 'You cannot delete %1 %2 because it has associated depreciation books.';
        CommentLine: Record "Comment Line";
        FA: Record "Fixed Asset";
        FASetup: Record "FA Setup";
        MaintenanceRegistration: Record "Maintenance Registration";
        FADeprBook: Record "FA Depreciation Book";
        MainAssetComp: Record "Main Asset Component";
        InsCoverageLedgEntry: Record "Ins. Coverage Ledger Entry";
        FAMoveEntries: Codeunit "FA MoveEntries";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;

    procedure AssistEdit(OldFA: Record "Fixed Asset"): Boolean
    begin
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    procedure "--NAVIN--"()
    begin
    end;

    procedure TestNoEntriesExists(CurrentFieldName: Text[100])
    var
        ErrorText: Label 'You cannot change %1 because there are one or more ledger entries for this FA.';
        FALedger: Record "FA Ledger Entry";
    begin
    end;
}

