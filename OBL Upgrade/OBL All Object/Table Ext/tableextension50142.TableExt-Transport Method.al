tableextension 50142 tableextension50142 extends "Transport Method"
{
    DrillDownPageID = "Transport Methods";
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Code(Field 1)".

        field(50000; "E-Way transport method"; Code[10])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50001; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; City; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(50003; State; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = State;
        }
        field(50004; "City Name"; Text[30])
        {
            CalcFormula = Lookup("Post Code".City WHERE(Code = FIELD(City)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "State Name"; Text[30])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD(State)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; Address; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Address 1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Morbi Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Morbi Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Morbi Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Morbi Reserve Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key2; Description)
        {
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: DrillDown)".


    var
        postcode: Record "Post Code";
}

