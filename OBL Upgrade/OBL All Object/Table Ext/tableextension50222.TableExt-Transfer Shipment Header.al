tableextension 50222 tableextension50222 extends "Transfer Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""External Document No."(Field 32)".

        field(50000; Purpose; Text[50])
        {
            Description = 'New Field Added For Information Point Only';
        }
        field(50001; "Transporter's Name"; Code[40])
        {
            Description = 'report 54 - S2';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));
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
        field(50032; "Batch Executed"; Boolean)
        {
            Description = 'Tri5.0PG 10112006 -- Transfer Shipment Batch 56001';
        }
        field(50033; "Transfer Receipt No."; Code[20])
        {
            Description = 'Tri5.0PG 10112006 -- Transfer Shipment Batch 56001';
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
            Description = 'TRI S.K. 21.06.10';
        }
        field(50062; "Shortage TO"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50063; Amount; Decimal)
        {
            CalcFormula = Sum("Transfer Shipment Line".Amount WHERE("Document No." = FIELD("No.")));
            Description = 'MSPL-ND on 19/08/14';
            FieldClass = FlowField;
        }
        field(50064; Quantity; Decimal)
        {
            CalcFormula = Sum("Transfer Shipment Line".Quantity WHERE("Document No." = FIELD("No.")));
            Description = 'MSPL-ND on 19/08/14';
            FieldClass = FlowField;
        }
        field(50067; "Created ID"; Code[20])
        {
        }
        field(50068; "Gross Weight"; Decimal)
        {
            CalcFormula = Sum("Transfer Shipment Line"."Gross Weight" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50069; "Net Weight"; Decimal)
        {
            CalcFormula = Sum("Transfer Shipment Line"."Net Weight" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50070; "E-Way No."; Code[12])
        {
        }
        field(50100; "E-Way Bill No."; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50101; "E-Way Bill Date"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50102; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50103; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50104; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50105; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50106; "Vechile No. Update Remark"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = ' ,Due to Break Down,Due to Transhipment,Others,First Time';
            OptionMembers = " ","Due to Break Down","Due to Transhipment",Others,"First Time";
        }
        field(50107; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50108; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50109; "E-Way URL"; Text[200])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50110; "Reason of Cancel"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry mistake,Others';
            OptionMembers = " ",Duplicate,"Order Cancelled","Data Entry mistake",Others;
        }
        field(50111; "Bill From Pin Code"; Code[7])
        {
        }
        field(50112; "Bill To  Pin Code"; Code[7])
        {
        }
        field(88000; "Acknowledgement No."; Text[30])
        {
            Caption = 'Invoice Reference No.';
            DataClassification = ToBeClassified;
        }
        field(88001; "IRN Hash"; Text[64])
        {
            Caption = 'IRN Hash';
            DataClassification = ToBeClassified;
        }
        field(88002; "QR Code"; BLOB)
        {
            Caption = 'QR Code';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(88003; "Acknowledgement Date"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key3; "Transfer-from Code", "Transfer-to Code", "Posting Date")
        {
        }
        /* key(Key4; "SalesPerson Code", "Transfer-to Code", "No.")
         {
         }*/
        key(Key5; "Transfer-to Code")
        {
        }
        key(Key6; "Transfer Order No.", "Posting Date")
        {
        }
    }
}

