table 50018 "Non-Stock Item"
{
    LookupPageID = "Non-Stock Item List";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InventorySetup.GET;
                    NoSeriesMgt.TestManual(InventorySetup."Non-Stock Item Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Unit of Measurement"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(5; "No. Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50000; Blocked; Boolean)
        {
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

    trigger OnInsert()
    begin


        IF "No." = '' THEN BEGIN
            InventorySetup.GET;
            InventorySetup.TESTFIELD("Non-Stock Item Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Non-Stock Item Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

