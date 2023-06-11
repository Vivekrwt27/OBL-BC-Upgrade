table 50055 "IC In Header"
{
    DrillDownPageID = "Posted IC Transfer - In List";
    LookupPageID = "Posted IC Transfer - In List";

    fields
    {
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Inter Company';
            OptionMembers = "Inter Company";
        }
        field(20; "No."; Code[20])
        {
        }
        field(30; "From Company"; Text[30])
        {
        }
        field(40; "To Company"; Text[30])
        {
            TableRelation = Company;
        }
        field(50; "From Location"; Code[20])
        {
        }
        field(60; "To Location"; Code[20])
        {
        }
        field(70; "Posting Date"; Date)
        {
        }
        field(80; "Shortcut Dimesion 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(90; "Shortcut Dimesion 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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
        key(Key1; "Transfer Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ICHeader: Record "IC Header";
        WhrsSetup: Record "Warehouse Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ICHandler: Codeunit "IC Transfer - Out";
        ICLine: Record "IC Line";
        TEXT50000: Label 'From Company and To Company cannot be Same';
        TEXT50001: Label 'Update in Line Section';


    procedure AssistEdit(OldICHeader: Record "IC Header"): Boolean
    var
        ICHeader2: Record "IC Header";
    begin
    end;

    local procedure TestNoSeries(): Boolean
    begin
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
    end;

    procedure InsertPreData()
    begin
    end;

    procedure UpdateValues()
    begin
    end;

    procedure UpdateFromCompany()
    begin
    end;

    procedure UpdateToCompany()
    begin
    end;

    procedure UpdateFromLocation()
    begin
    end;


    procedure UpdateToLocation()
    begin
    end;

    procedure UpdatePostingDate()
    begin
    end;

    procedure UpdateShortcutDimesion1()
    begin
    end;

    procedure UpdateShortcutDimesion2()
    begin
    end;
}

