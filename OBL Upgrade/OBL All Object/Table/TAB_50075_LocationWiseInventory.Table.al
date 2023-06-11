table 50075 "Location Wise Inventory"
{
    DrillDownPageID = "Phy.Jrnl.Loc. Wise Inventory";
    LookupPageID = "Phy.Jrnl.Loc. Wise Inventory";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Location; Code[20])
        {
        }
        field(10; "Inventory at Location"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(15; "Inventory Exists"; Boolean)
        {
            CalcFormula = Exist("Physical Journal Output Entrie" WHERE("Document No." = FIELD(FILTER("Physical Journal Filter")),
                                                                        "RM Code" = FIELD("No."),
                                                                        "Location Code" = FIELD("Location")));
            FieldClass = FlowField;
        }
        field(20; "Physical Journal Filter"; Code[20])
        {
        }
        field(25; Plant; Option)
        {
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;
        }
        field(30; "Phys.Jrnl. Output Ent. Exists"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Physical Journal Filter", Location, "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLocation: Record Location;
    begin
        RecLocation.GET(Location);
        Plant := RecLocation."Prod. Units";

        PhysicalJournalOutputEntrie.RESET;
        PhysicalJournalOutputEntrie.SETRANGE("Document No.", "Physical Journal Filter");
        PhysicalJournalOutputEntrie.SETRANGE("Location Code", Location);
        PhysicalJournalOutputEntrie.SETRANGE("RM Code", "No.");
        IF PhysicalJournalOutputEntrie.FINDFIRST THEN
            "Phys.Jrnl. Output Ent. Exists" := TRUE;
    end;

    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
}

