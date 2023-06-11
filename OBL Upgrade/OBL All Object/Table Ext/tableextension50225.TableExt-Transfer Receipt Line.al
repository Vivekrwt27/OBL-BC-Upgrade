tableextension 50225 tableextension50225 extends "Transfer Receipt Line"
{
    fields
    {


        field(50000; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50001; "Size Code"; Code[3])
        {

            trigger OnLookup()
            var
                InventorySetup: Record "Inventory Setup";
                DimensionValue: Record "Dimension Value";
            begin
            end;
        }
        field(50004; "From Main Location"; Code[10])
        {
        }
        field(50005; "To Main Location"; Code[10])
        {
        }
        field(50006; "External Transfer"; Boolean)
        {
        }
        field(50008; "Plant Code"; Code[1])
        {
        }
        field(50017; "Quality Code"; Code[10])
        {
        }
        field(50018; "Packing Code"; Code[10])
        {
        }
        field(50019; "Color Code"; Code[10])
        {
        }
        field(50020; "Design Code"; Code[10])
        {
        }
        field(50021; "Type Code"; Code[10])
        {
        }
        field(50022; "Group Code"; Code[2])
        {
        }
        field(50023; "Type Catogery Code"; Code[2])
        {
            Description = 'TRI NM 160308';
        }
        field(50027; "Short Quantity"; Decimal)
        {
        }
        field(50028; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code".Code;
        }
        field(50029; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(50030; "Shoratge Transfer Rcpt No."; Code[20])
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50031; "Customer Price Group"; Code[20])
        {
            Description = 'TRI VKG 23.09.10';
            TableRelation = "Customer Price Group".Code;
        }
        field(50041; "Shoratge Quantity Shipped"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50042; "Transfer Shipment No."; Code[20])
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50043; "Transfer Shipment Date"; Date)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(60040; "End Use Item"; Boolean)
        {
        }
        field(60041; "Issue to Machine"; Code[40])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('MACHINE'));
            ValidateTableRelation = false;
        }
        field(60042; "Shelf No."; Code[20])
        {
        }
        field(60044; "Capex No."; Code[20])
        {
            Description = 'Kulbhushan';
            TableRelation = "Budget Master";
        }
        field(60045; "Received Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(70001; "Sample Conversion Qty"; Decimal)
        {
            CalcFormula = Sum("Posted Assembly Line"."Quantity (Base)" WHERE("Transfer Shipment No." = FIELD("Document No."),
                                                                              "Transfer Shipment Line No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        /*  key(Key3; "Transfer-to Code", "Size Code", "Unit of Measure")
          {
          }
          key(Key4; "Size Code", "Item No.")
          {
          }*/
    }
    trigger OnInsert()// 15578
    begin
        "Receipt Date" := TODAY;
    end;
}

