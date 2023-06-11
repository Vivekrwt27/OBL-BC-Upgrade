tableextension 50010 tableextension50010 extends "Purch. Inv. Header"
{



    fields
    {

        /*modify(Structure)
        {
            TableRelation = "Structure Header" WHERE (Structure Type=FILTER(Purchase));
        }*/
        field(50000; Marked; Boolean)
        {
            Description = 'Customization No. 20';
        }
        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'Customization No. 22';
            // 15578TableRelation = "Customer Type".Code WHERE(Type = FILTER(Vendor));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50009; "Vendor Invoice Date"; Date)
        {
        }
        field(50011; "Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(50012; "Document Received from Bank"; Boolean)
        {
            Description = 'Report 84 EXIM';
        }
        field(50013; "Document Receiving Date"; Date)
        {
            Description = 'Report 84 EXIM';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "GE No."; Code[20])
        {
        }
        field(50016; "Transporter's Code"; Code[20])
        {
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));
        }
        field(50017; "Quotation No."; Code[20])
        {
        }
        field(50018; "State Desc."; Text[50])
        {
            Editable = false;
        }
        field(50019; "Transporter Name"; Text[50])
        {
            Editable = false;
        }
        field(50020; "Delivery Period"; Text[50])
        {
        }
        field(50021; "Form 31 Amount"; Decimal)
        {
            Editable = false;
        }
        field(50022; ExciseAmt; Code[20])//
        {
            // 15578 CalcFormula = Sum("Purch. Inv. Line"."Excise Amount" WHERE ("Document No."=FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(50023; InvDiscAmt; Decimal)
        {
            CalcFormula = Sum("Purch. Inv. Line"."Inv. Discount Amount" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50025; "Ordered Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document No." = FIELD("No.")));
            Description = 'Ori UT on 020810';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Total Recd. Quantity"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Received" WHERE("Document No." = FIELD("No.")));
            Description = 'Ori UT on 020810';
            FieldClass = FlowField;
        }
        field(50031; "Excise Approved (Accounts)"; Boolean)
        {
            Description = 'TSPL SA';
        }
        field(50088; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
            InitValue = true;
        }
        field(50089; "Other Comp. Location"; Code[10])
        {
            Description = 'MS-PB';
        }
        field(50090; "Form C No."; Code[15])
        {
        }
        field(50091; "Form C Amt"; Decimal)
        {
        }
        field(50092; "Buy-from State"; Text[50])
        {
            // 15578 CalcFormula = Lookup(State.Description WHERE(Code= FIELD(State)));
            // FieldClass = FlowField;
        }
        field(50093; "Truck No."; Text[15])
        {
        }
        field(50094; "GR No."; Code[15])
        {
        }
        field(60003; "Delivary Date"; Date)
        {
            Description = 'TRI SC';
        }
        field(60028; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            // TableRelation = "NOE Permission".NOE WHERE(Location = FIELD("Location Code"));
        }
        field(80000; "Due Date Calc. On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor Invoice Date,Inv Posting Date,GRN Date,Document Date';
            OptionMembers = " ","Vendor Invoice Date","Inv Posting Date","GRN Date","Document Date";
        }
        field(80007; "Posting Description New"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Description';
        }
    }
    keys
    {
        key(Key10;/* "Form No.", */"Vendor Invoice No.")
        {
        }
    }
}

