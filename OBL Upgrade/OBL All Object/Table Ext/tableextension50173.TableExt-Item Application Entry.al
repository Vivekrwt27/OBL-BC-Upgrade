tableextension 50173 tableextension50173 extends "Item Application Entry"
{
    fields
    {
        field(50000; "Item Code"; Code[20])
        {
        }
        field(50001; "Item Code1"; Code[20])
        {
            CalcFormula = Lookup("Item Ledger Entry"."Item No." WHERE("Entry No." = FIELD("Item Ledger Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "In Bond Entries"; Code[20])
        {
            CalcFormula = Lookup("Item Ledger Entry"."Document No." WHERE("Entry No." = FIELD("Inbound Item Entry No.")));
            FieldClass = FlowField;
        }
        field(50003; "Out Bond Entries"; Code[20])
        {
            CalcFormula = Lookup("Value Entry"."Document No." WHERE("Item Ledger Entry No." = FIELD("Outbound Item Entry No.")));
            FieldClass = FlowField;
        }
        field(50004; "Posted Purch Invoice"; Code[20])
        {
            //CalcFormula = Lookup("Purch. Inv. Line"."Document No." WHERE("Receipt Document No." = FIELD("In Bond Entries")));
            // FieldClass = FlowField;
        }
        field(50005; "Vend Name"; Text[100])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Pay-to Name" WHERE("No." = FIELD("Posted Purch Invoice")));
            FieldClass = FlowField;
        }
        field(50006; "Vend Inv"; Code[20])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No." = FIELD("Posted Purch Invoice")));
            FieldClass = FlowField;
        }
        field(50007; Location; Code[10])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Location Code" WHERE("No." = FIELD("Out Bond Entries")));
            FieldClass = FlowField;
        }
        field(50008; "Cust Name"; Text[100])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Bill-to Name" WHERE("No." = FIELD("Out Bond Entries")));
            FieldClass = FlowField;
        }
        field(50009; "Trf Price"; Decimal)
        {
            // CalcFormula = Lookup("Transfer Receipt Line"."MRP Price" WHERE("Item No." = FIELD("Item Code1"),
            //  "Document No." = FIELD("In Bond Entries")));
            // FieldClass = FlowField;
        }
        field(50010; "Pur Price"; Decimal)
        {
            CalcFormula = Lookup("Purch. Rcpt. Line"."Direct Unit Cost" WHERE("Document No." = FIELD("In Bond Entries"),
                                                                               "No." = FIELD("Item Code1")));
            FieldClass = FlowField;
        }
    }

}

