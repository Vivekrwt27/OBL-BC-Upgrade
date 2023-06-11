tableextension 50223 tableextension50223 extends "Transfer Shipment Line"
{
    fields
    {

        field(50003; "From Main Location"; Code[10])
        {
        }
        field(50004; "To Main Location"; Code[10])
        {
        }
        field(50005; "Size Code"; Code[10])
        {
        }
        field(50006; "Posting Date"; Date)
        {
        }
        field(50007; "External Transfer"; Boolean)
        {
        }
        field(50008; "Plant Code"; Code[1])
        {
        }
        field(50009; "SalesPerson Code"; Code[10])
        {
        }
        field(50010; "Type Code"; Code[2])
        {
        }
        field(50012; "Qty in Sq. Mt."; Decimal)
        {
            Editable = true;
        }
        field(50013; "Qty in Carton."; Decimal)
        {
            Editable = false;
        }
        field(50016; "Transfer-to State"; Code[20])
        {
            Description = 'mo';
            TableRelation = State.Code;
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
        field(50021; OK; Boolean)
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
        field(50033; Remarks; Text[150])
        {
        }
        field(50034; "Customer Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(50035; "Requested by"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
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
        field(60045; "Creation Date"; Date)
        {
        }
        field(60046; "Ship Date"; Date)
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document No.,Line No."(Key)".

        /*  key(Key3; "Type Code", "Transfer-to State", "Transfer-to Code")
          {
          }
          key(Key4; "Size Code", "Unit of Measure Code")
          {
          }
          key(Key5; "Type Catogery Code")
          {
          }
          key(Key6; "Plant Code", "Type Code", "Item No.", "Posting Date", "Unit of Measure Code")
          {
          }
          key(Key7; "Item No.", "Posting Date", "Unit of Measure Code")
          {
          }
          key(Key8; "Transfer-to Code", "Item No.")
          {
          }
          key(Key9; "Size Code", "Document No.", "Line No.", "Item No.")
          {
          }
          key(Key10; "Size Code", "Item No.")
          {
          }*/
    }
    trigger OnInsert()// 15578
    begin
        "Ship Date" := TODAY;
    end;
}

