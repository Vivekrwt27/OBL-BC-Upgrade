table 50103 "LC Detail for Export"
{

    fields
    {
        field(1; "LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "LC Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "LC Issuing Bank"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Terms of Delivery"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Place of Discharge"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Plant of Final Distenation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Customer Code"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                IF reccustname.GET("Customer Code") THEN
                    "Customer Name" := reccustname.Name;

            end;
        }
        field(8; "Customer Name"; Text[30])
        {
            CalcFormula = Lookup(Customer."Name" WHERE("No." = FIELD("Customer Code")));
            FieldClass = FlowField;
        }
        field(9; "Customer Exim Code"; Code[20])
        {
            //CalcFormula = Lookup(Customer."E.C.C. No." WHERE ("No."=FIELD("Customer Code")));//16225 E.C.C. No." FIELD N/F
            FieldClass = FlowField;
        }
        field(10; "Ecc No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Issueing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Proforma Invoice"; Code[16])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Exporter Bank Detail"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(14; "Sales Order"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";

            trigger OnValidate()
            begin
                IF "Sales Order" <> '' THEN
                    Saleshead.RESET;
                Saleshead.SETRANGE("No.", Rec."Sales Order");
                IF Saleshead.FINDFIRST THEN
                    "Payment Terms Code" := Saleshead."Payment Terms Code";
                // MESSAGE('%1 and %2',Saleshead."No.",Saleshead."Payment Terms Code");

                IF payter.GET("Payment Terms Code") THEN
                    "Payment Terms Desc" := payter.Description
            end;
        }
        field(15; Tolerance; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Port of Loading"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Port of Discharge"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Origin; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Partial & Trans Shipment"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Discription of Goods"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Harmonic; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Post of Discharge"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Payment Terms Desc"; Text[30])
        {
        }
        field(25; "Proforma Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "LC No.")
        {
            Clustered = true;
        }
        key(Key2; "Sales Order")
        {
        }
    }

    fieldgroups
    {
    }

    var
        reccustname: Record Customer;
        Saleshead: Record "Sales Header";
        payter: Record "Payment Terms";
}

