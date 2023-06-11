tableextension 50224 tableextension50224 extends "Transfer Receipt Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""External Document No."(Field 32)".

        /*  modify(Structure)
          {
              TableRelation = "Structure Header" WHERE("Structure Type" = FILTER(Transfer));
              Caption = 'Structure';
          }*/ // 15578
        field(50000; Purpose; Text[50])
        {
            Description = 'New Field Added For Information Point Only';
        }
        field(50001; "Transporter's Name"; Code[40])
        {
            Description = 'report 54 - S2';
            TableRelation = Vendor WHERE(Transporter1 = CONST(true));
        }
        field(50002; "GR No."; Code[20])
        {
            Description = 'report 54 - S2';
        }
        field(50003; "GR Date"; Date)
        {
            Description = 'report 54 - S2';
        }
        field(50004; "Truck No."; Code[20])
        {
            Description = 'report 54 - S2';
        }
        field(50005; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50006; "Transfer-from State"; Code[20])
        {
        }
        field(50007; "Transfer-to State"; Code[20])
        {
        }
        field(50008; "From Main Location"; Code[10])
        {
        }
        field(50009; "To Main Location"; Code[10])
        {
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Report 113 N-10A';
        }
        field(50020; "Locked Order"; Boolean)
        {
        }
        field(50021; "External Transfer"; Boolean)
        {
        }
        field(50027; "SalesPerson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "Releasing Date"; Date)
        {
            Editable = false;
        }
        field(50031; "Releasing Time"; Time)
        {
            Editable = false;
        }
        field(50034; "Group Code"; Code[2])
        {
        }
        field(50036; Pay; Option)
        {
            Description = 'TRI A.S 07.11.08';
            Editable = false;
            OptionCaption = ' ,To Pay,To be billed';
            OptionMembers = " ","To Pay","To be billed";
        }
        field(50037; "Location Comment"; Text[30])
        {
            Description = 'TRI A.S 31.12.08';
        }
        field(50038; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(50060; "OutPut Date"; Date)
        {
            Description = 'TRI S.K.21.06.10';
        }
        field(50062; "Shortage TO"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50063; "Post Credit Memo"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50064; "Trf Shipment Inv No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Transfer Shipment Header"."No." WHERE("Transfer Order No." = FIELD("Transfer Order No.")));

        }
        field(50069; "E-way Bill No."; Code[12])
        {
        }
        field(50070; "Total Receipt Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Receipt Line".Quantity WHERE("Document No." = FIELD("No.")));

        }
    }
    keys
    {
        key(Key3; "Transfer Order No.")
        {
        }
    }

}

