table 50079 "Scheme Entries"
{
    //DrillDownPageID = 50223;//16225 PAGE N/F
    //LookupPageID = 50223;//16225 PAGE N/F

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(10; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(20; Scheme; Code[20])
        {
            TableRelation = "Scheme Master".Code;
        }
        field(30; "Sales Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(40; "Sales Invoice Line"; Integer)
        {
        }
        field(45; HVP; Boolean)
        {
        }
        field(50; "Discontinued Product"; Boolean)
        {
        }
        field(70; "Target Sales"; Decimal)
        {
        }
        field(80; "Eligible Sales"; Decimal)
        {
        }
        field(85; "Eligible Discount"; Decimal)
        {
        }
        field(88; "Discount Given"; Decimal)
        {
        }
        field(90; "Item Code"; Code[20])
        {
        }
        field(100; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(110; "Child Customer"; Code[20])
        {
        }
        field(111; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(112; "Item Desc"; Text[100])
        {
            //CalcFormula = Lookup("Item"."Complete Description" WHERE ("No."=FIELD("Item Code")));
            //16225 ITEM TABLE "Complete Description" N/F
            FieldClass = FlowField;
        }
        field(113; "Item Remarks"; Text[60])
        {
            /* CalcFormula = Lookup("Sales Invoice Line"."Remarks" WHERE ("Document No."=FIELD("Sales Invoice No."),
                                                                      "No."=FIELD("Item Code")));*/
            //16225 "Sales Invoice Line"."Remarks" N/F
            FieldClass = FlowField;
        }
        field(114; "External Document"; Text[50])
        {
            CalcFormula = Lookup("Sales Invoice Header"."External Document No." WHERE("No." = FIELD("Sales Invoice No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Scheme, "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

