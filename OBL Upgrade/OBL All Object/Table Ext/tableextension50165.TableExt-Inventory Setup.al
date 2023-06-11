tableextension 50165 tableextension50165 extends "Inventory Setup"
{
    fields
    {
        field(50000; "Type Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Type Code", 23, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50001; "Type Catogery Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Type Catogery Code", 24, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50002; "Size Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Size Code", 25, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50003; "Design Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Design Code", 26, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50004; "Color Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Color Code", 27, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50005; "Packing Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Packing Code", 28, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50006; "Quality Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Quality Code", 29, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50007; "Plant Code"; Code[20])
        {
            Description = '17';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF Dim.CheckIfDimUsed("Plant Code", 30, '', '', 0) THEN
                    ERROR(Text0002, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }
        field(50008; "RGP In Nos."; Code[10])
        {
            Description = 'Cust 63';
            TableRelation = "No. Series";
        }
        field(50009; "RGP Out Nos."; Code[10])
        {
            Description = 'Cust 63';
            TableRelation = "No. Series";
        }
        field(50010; "Non-Stock Item Nos."; Code[10])
        {
            Description = 'Cust 1 ND';
            TableRelation = "No. Series".Code;
        }
        field(50011; "Unit of Measure for Carton"; Code[10])
        {
            Description = 'Cust 26';
            NotBlank = true;
            TableRelation = "Unit of Measure";
        }
        field(50012; "Unit of Measure for Sq. Mt."; Code[10])
        {
            Description = 'Cust 26';
            TableRelation = "Unit of Measure";
        }
        field(50013; "Fuel Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group".Code;
        }
        field(50014; "Form Code For F-Form"; Code[10])
        {
            // 15578   TableRelation = "Form Codes".Code;
        }
        field(50015; "Unit of Measure for Pieces"; Code[10])
        {
            Description = 'Tri30.0 PG';
            TableRelation = "Unit of Measure";
        }
        field(50016; "Sample Unit Of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50017; "Branch Code"; Code[10])
        {
            Description = 'Use for report 50149';
            TableRelation = Dimension;
        }
        field(50018; "Physical Journal No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50019; "Item No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
    }

    var
        Dim: Record Dimension;
        Text0002: Label '%1\You cannot use the same dimension twice.';
}

