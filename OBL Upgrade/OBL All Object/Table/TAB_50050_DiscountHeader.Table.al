table 50050 "Discount Header"
{
    DrillDownPageID = "Discount List";
    LookupPageID = "Discount List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Status; Option)
        {
            Editable = true;
            OptionCaption = ' ,Enable,Disable';
            OptionMembers = " ",Enable,Disable;
        }
        field(4; "Currency Code"; Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(10; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(11; "Slab Group"; Code[20])
        {
            TableRelation = Slabs."Slab Group";
        }
        field(12; "Valid From"; Date)
        {
        }
        field(13; "Valid To"; Date)
        {

            trigger OnValidate()
            begin
                IF "Valid From" > "Valid To" THEN
                    ERROR(Text50001);
            end;
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

        IF Status = Status::Enable THEN
            ERROR(Text50000);
    end;

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD("Discount No.");
            NoSeriesMgt.InitSeries(SalesSetup."Discount No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin

        IF Status = Status::Enable THEN
            ERROR(Text50000);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DiscountHeader: Record "Discount Header";
        Text50000: Label 'You cannot change Discount offer after it Enabled';
        Text50001: Label 'Please varify the Valid Date ';

    procedure AssistEdit(OldDisc: Record "Discount Header"): Boolean
    var
        Vend: Record Vendor;
    begin
        WITH DiscountHeader DO BEGIN
            DiscountHeader := Rec;
            SalesSetup.GET;
            SalesSetup.TESTFIELD("Discount No.");
            IF NoSeriesMgt.SelectSeries(SalesSetup."Discount No.", OldDisc."No. Series", "No. Series") THEN BEGIN
                SalesSetup.GET;
                SalesSetup.TESTFIELD("Discount No.");
                NoSeriesMgt.SetSeries("No.");
                Rec := DiscountHeader;
                EXIT(TRUE);
            END;
        END;
    end;
}

