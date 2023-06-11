table 50105 "Sales Order Ledger Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer"."No.";
        }
        field(10; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '2';
        }
        field(20; "Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(40; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item"."No.";
        }
        field(50; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Original SO Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Outstanding Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Sales Person Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(170; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(190; "Despatch Remark"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Size Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(210; "Size Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(220; "Mfg Plant"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(230; "Order Plant"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(250; "PMT ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(300; "Basic Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(310; "Buyer Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(400; "Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(420; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(430; "Default Prod. Line Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(440; "Reserved Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(500; "Sales Order Deleted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(501; "Inventory status"; Boolean)
        {
            CalcFormula = Lookup("Sales Order Status Log"."Inventory Approved" WHERE("Sales Order No."=FIELD("Sales Order No."),
                                                                                      Processed=CONST(true)));
                Editable = false;
                Enabled = true;
                FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Sales Order No.", "Sales Order Line No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key3; "Mfg Plant", "Order Plant", "Size Code", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

