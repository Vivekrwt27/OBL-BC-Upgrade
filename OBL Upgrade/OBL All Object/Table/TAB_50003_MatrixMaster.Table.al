table 50003 "Matrix Master"
{
    DrillDownPageID = "Matrix Master List Lookup";
    LookupPageID = "Matrix Master List Lookup";

    fields
    {
        field(1; "Mapping Type"; Option)
        {
            OptionCaption = ' ,Zone,States,Division,City,Area';
            OptionMembers = " ",Zone,States,Division,City,"Area";
        }
        field(2; "Type 1"; Code[10])
        {
        }
        field(3; "Type 2"; Code[10])
        {
        }
        field(4; Description; Text[30])
        {
        }
        field(5; "Description 2"; Text[30])
        {
        }
        field(50001; "Tableau Zone"; Text[10])
        {
            CalcFormula = Lookup(Customer."Tableau Zone" WHERE("Area Code" = FIELD("Type 1")));
            FieldClass = FlowField;
        }
        field(50002; Target; Decimal)
        {
        }
        field(50003; PCH; Code[10])
        {
            Editable = true;
            Enabled = true;
        }
        field(50004; "Target GVT"; Decimal)
        {
        }
        field(50005; "PCH Name"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("PCH")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; ZH; Code[10])
        {
        }
        field(50007; "Sorting Order"; Integer)
        {
        }
        field(50008; "Annual Target"; Decimal)
        {
        }
        field(50009; "Q1 Tgt"; Decimal)
        {
        }
        field(50010; "Retail Sales Tgt"; Decimal)
        {
        }
        field(50011; "Enterprise Tgt"; Decimal)
        {
        }
        field(50012; "Sales Tgt Phasing 1-7"; Decimal)
        {
        }
        field(50013; "Sales Tgt Phasing 8-14"; Decimal)
        {
        }
        field(50014; "Sales Tgt Phasing 15-21"; Decimal)
        {
        }
        field(50015; "Sales Tgt Phasing 22-27"; Decimal)
        {
        }
        field(50016; "Collection Phasing 1-7"; Decimal)
        {
        }
        field(50017; "Collection Phasing 8-14"; Decimal)
        {
        }
        field(50018; "Collection Phasing 15-21"; Decimal)
        {
        }
        field(50019; "Collection Phasing 22-27"; Decimal)
        {
        }
        field(50020; "Enterprise SP Tgt Direct"; Decimal)
        {
        }
        field(50021; "Enterprise SP Tgt Indirect"; Decimal)
        {
        }
        field(50022; "Sales Tgt Phasing 28-30"; Decimal)
        {
        }
        field(50023; "Collection Phasing 28-30"; Decimal)
        {
        }
        field(50024; "Outstanding Amount"; Decimal)
        {
            Editable = true;
        }
        field(50025; "OverDue Amount"; Decimal)
        {
            Editable = true;
        }
        field(50026; "Collection Amount"; Decimal)
        {
            Editable = false;
        }
        field(50027; Hide; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Strong Market"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Mapping Type", "Type 1", "Type 2")
        {
            Clustered = true;
        }
        key(Key2; "Mapping Type", Description, "Type 1")
        {
        }
        key(Key3; ZH, "Sorting Order", PCH)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CheckValidation;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        DimensionValue: Record "Dimension Value";

    procedure CheckValidation()
    var
        SalesPersonMatrix: Record "Matrix Master";
    begin
        SalesPersonMatrix.RESET;
        SalesPersonMatrix.SETRANGE("Mapping Type", "Mapping Type");
        SalesPersonMatrix.SETRANGE("Type 2", "Type 2");
        IF SalesPersonMatrix.FINDFIRST THEN BEGIN
            //Message('%1',SalesPersonMatrix."Type 2");
            ERROR('It is all ready Exit');
        END;
    end;
}

