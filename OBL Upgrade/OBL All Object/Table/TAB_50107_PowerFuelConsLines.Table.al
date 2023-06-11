table 50107 "Power & Fuel Cons. Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Consumed Item No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(20; "FG Item No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(22; "FG Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(25; "Total Sq. Meter Produced"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(30; "Prod. Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Prod. Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(45; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50; "Prod. Units"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(60; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(80; "Consumption Qty."; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatusOpen;
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckStatusOpen;
    end;

    trigger OnInsert()
    begin
        CheckStatusOpen;
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        DimMgt: Codeunit DimensionManagement;
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
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    local procedure CheckStatusOpen()
    var
        PowerandFuelHeader: Record "Power and Fuel Header";
    begin
        PowerandFuelHeader.GET("Document No.");
        PowerandFuelHeader.TESTFIELD(Status, PowerandFuelHeader.Status::Open)
    end;
}

