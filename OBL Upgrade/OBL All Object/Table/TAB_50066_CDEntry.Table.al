table 50066 "CD Entry"
{

    fields
    {
        field(1; "Cust. Entry No."; Integer)
        {
            TableRelation = "Cust. Ledger Entry"."Entry No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(2; "CD Document Type"; Option)
        {
            OptionCaption = ' ,Payment';
            OptionMembers = " ",Payment;
        }
        field(5; Amount; Decimal)
        {
        }
        field(10; "Cust. No."; Code[20])
        {
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
        field(45; "CD Days"; Integer)
        {
        }
        field(47; "CD % age"; Decimal)
        {
        }
        field(48; "CD Base Amount"; Decimal)
        {
        }
        field(50; "CD Amount"; Decimal)
        {
        }
        field(65; "State Code"; Code[10])
        {
            TableRelation = State;
        }
        field(90; "Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(95; "Due Date"; Date)
        {
        }
        field(100; "Reciept Date"; Date)
        {
        }
        field(150; "Insurance Amount"; Decimal)
        {
        }
        field(170; "Sales Order No."; Code[20])
        {
        }
        field(500; Posted; Boolean)
        {
        }
        field(600; "Holidays Grace"; Integer)
        {
        }
        field(700; "Customer Type"; Code[20])
        {
        }
        field(800; "Next Slab Date"; Date)
        {
        }
        field(900; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '20';
        }
    }

    keys
    {
        key(Key1; "CD Document Type", "Cust. Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Cust. No.", "Posting Date", "Cust. Entry No.")
        {
            SumIndexFields = "CD Base Amount", "CD Amount";
        }
    }
}

