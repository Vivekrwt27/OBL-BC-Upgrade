tableextension 50269 tableextension50269 extends "Inventory Posting Group"
{
    fields
    {
        field(50000; Trading; Boolean)
        {
        }
        field(50001; Factory; Boolean)
        {
        }
        field(50002; "Consumption Value (Actual)"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Inventory Posting Group" = FIELD(Code),
                                                                          "Item Ledger Entry Type" = CONST(Consumption),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Item No." = FIELD("Item FIlter"),
                                                                         "Location Code" = FIELD("Location Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Production; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Inventory Posting Group" = FIELD(Code),
                                                                          "Item Ledger Entry Type" = CONST(Output),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Item No." = FIELD("Item FIlter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;

            trigger OnValidate()
            begin
                //"Date Filter 2" := CALCDATE('-1D',"Date Filter");
            end;
        }
        field(50005; Capital; Boolean)
        {
            Description = 'Tri1.3 PG 10112006 - Excise Batch';

            trigger OnValidate()
            begin
                //-- 1. Tri1.3 PG 10112006 - New Field Added "Capital" Bolean -- Excise Batch
                //-- 2. Tri1.3 PG 10112006 - New Field Added "Excise Accounting Type" Option -- Excise Batch
            end;
        }
        field(50006; "Excise Accounting Type"; Option)
        {
            Description = 'Tri1.3 PG 10112006 - Excise Batch';
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";

            trigger OnValidate()
            begin
                //TestNoEntriesExist(FIELDCAPTION("Excise Accounting Type")); // Pahul
            end;
        }
        field(50007; Sales; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Inventory Posting Group" = FIELD(Code),
                                                                          "Item Ledger Entry Type" = CONST(Sale),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                         "Item No." = FIELD("Item FIlter")));
            FieldClass = FlowField;
        }
        field(50008; Balance; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Inventory Posting Group" = FIELD(Code),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Item No." = FIELD("Item FIlter")));
            FieldClass = FlowField;
        }
        field(50009; "Item FIlter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        field(50010; Opening; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Inventory Posting Group" = FIELD(Code),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                          "Item No." = FIELD("Item FIlter")));
            FieldClass = FlowField;
        }
        field(50011; "Date Filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50012; qty; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Posting Date" = FIELD("Date Filter"),
                                                                  "Item No." = FIELD("Item FIlter")));
            FieldClass = FlowField;
        }
        field(50013; "Branch Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('BRANCH'));
        }
        field(50014; Group; Code[20])
        {
            Description = 'TRI DG 290910';
        }
        field(50015; "Location Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(50016; "Consumption Value (Expected)"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Expected)" WHERE("Inventory Posting Group" = FIELD(Code),
                                                                           "Item Ledger Entry Type" = CONST(Consumption),
                                                                            "Posting Date" = FIELD("Date Filter"),
                                                                            "Item No." = FIELD("Item FIlter"),
                                                                           "Location Code" = FIELD("Location Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; Category; Code[10])
        {
        }
        field(50018; "PICC Allowed"; Boolean)
        {
        }
        field(50019; "Item Code Service App"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'keshav';
            OptionCaption = '  ,Domestic,Imported,U Series,SRV Service';
            OptionMembers = "  ",Domestic,Imported,"U Series","SRV Service";
        }
    }
    keys
    {
        key(Key1; Group)
        {
        }
        key(Key2; Category)
        {
        }
    }
}

