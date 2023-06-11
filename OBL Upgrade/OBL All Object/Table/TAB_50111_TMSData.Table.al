table 50111 "TMS Data"
{

    fields
    {
        field(1; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Make Order Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Bill-to Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Ship-to City"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "From Plant Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Total Load(KG)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; Status; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Loading Officer"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Transport Method"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Releasing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Quantity in SqMt."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Outstanding Qty."; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Closed := ("Outstanding Qty." = 0);
            end;
        }
        field(115; "Quantity Invoiced"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Gross Wt. Shipped"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Gross Wt. Outstanding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Dispatch City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Sales Person MobileNo."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(160; "Sales Person Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(170; "Customer Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(180; "State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Ship to State Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(200; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(201; "Sales Order No Main"; Code[20])
        {
            CalcFormula = Lookup("Sales Header"."No." WHERE("No." = FIELD("Sales Order No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Sales Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

