table 50073 "Issued Credit Details"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            TableRelation = "Cust. Ledger Entry"."Entry No.";
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Payment';
            OptionMembers = " ",Payment;
        }
        field(5; "Item Charge No."; Code[20])
        {
            TableRelation = "Item Charge"."No." WHERE("CN Charges allowed" = CONST(true));
        }
        field(10; "Cust. No."; Code[20])
        {
            TableRelation = Customer."No." WHERE(Blocked = CONST(" "));

            trigger OnValidate()
            begin
                //MS
                CLEAR("Cust Name");
                CusrRec.RESET;
                IF CusrRec.GET("Cust. No.") THEN
                    "Cust Name" := CusrRec.Name;
                //MS
            end;
        }
        field(15; "Posting Date"; Date)
        {
        }
        field(25; "Invoice Amount"; Decimal)
        {
        }
        field(30; "Payment Amount"; Decimal)
        {
        }
        field(50; Amount; Decimal)
        {
        }
        field(65; "State Code"; Code[10])
        {
            TableRelation = State;
        }
        field(90; "Invoice No."; Code[20])
        {
            CalcFormula = Lookup("Sales Invoice Header"."No." WHERE("Order No." = FILTER(<> ' '),
                                                                   "Order No." = FIELD("Sales Order No.")));
            FieldClass = FlowField;
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(95; "External Doc. No."; Code[20])
        {
        }
        field(100; Narration; Text[100])
        {
        }
        field(170; "Sales Order No."; Code[20])
        {
        }
        field(200; "Created By"; Code[20])
        {
        }
        field(210; "Creation Date"; DateTime)
        {
        }
        field(215; "Posting Date & Time"; DateTime)
        {
        }
        field(300; Reversed; Boolean)
        {
        }
        field(500; Posted; Boolean)
        {
        }
        field(50000; "Cust Name"; Text[100])
        {
        }
        field(50001; "Invoice Date"; Date)
        {
            CalcFormula = Lookup("Sales Invoice Header"."Posting Date" WHERE("Order No." = FIELD("Sales Order No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Cust. No.", "Posting Date", "Entry No.")
        {
        }
        key(Key3; "Document Type", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Creation Date" := CURRENTDATETIME;
    end;

    var
        CusrRec: Record Customer;
}

