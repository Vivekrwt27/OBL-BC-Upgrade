tableextension 50007 tableextension50007 extends "Purch. Rcpt. Header"
{
    // 
    // 1. TRI V.D 08.11.10 - Table Property "DrillDownFormID" added.

    //Unsupported feature: Property Insertion (Permissions) on ""Purch. Rcpt. Header"(Table 120)".

    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Buy-from Vendor Name"(Field 79)".

        /* modify(Structure)
         {
             TableRelation = "Structure Header" WHERE (Structure Type=FILTER(Purchase));
         }*/ // 15578

        field(50003; "Vendor Classification"; Code[15])
        {
            Description = 'customization 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(Vendor));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'customization 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'customization 22';
        }
        field(50006; "Insurance Amount"; Decimal)
        {
            Description = 'New field added for only information point of view';
        }
        field(50007; "Gate Entry No."; Code[10])
        {
        }
        field(50008; Date; Date)
        {
        }
        field(50009; "Vendor Invoice Date"; Date)
        {
        }
        field(50010; "Vendor Invoice No."; Code[20])
        {
            Caption = 'Vendor Invoice No.';
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
        field(50022; "NRGP No."; Code[50])
        {
            Description = 'ND';
        }
        field(50024; "Capital PO"; Boolean)
        {
            Description = 'TRI VS';
        }
        field(50025; "Ordered Qty"; Decimal)
        {
            Description = 'Ori UT on 020710';
            Editable = false;
        }
        field(50026; "Total Recd. Quantity"; Decimal)
        {
            Description = 'Ori UT on 020710';
        }
        field(50027; "Total Qty. Rcd. Not Invoiced"; Decimal)
        {
            CalcFormula = Sum("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced" WHERE("Document No." = FIELD("No.")));
            Description = 'Ori UT on 020710';
            FieldClass = FlowField;
        }
        field(50028; "Total UnitCost(LCY)"; Decimal)
        {
            CalcFormula = Sum("Purch. Rcpt. Line"."Unit Cost (LCY)" WHERE("Document No." = FIELD("No.")));
            Description = 'Ori UT on 020710';
            FieldClass = FlowField;
        }
        field(50029; "Store Return No."; Code[30])
        {
        }
        field(50030; "Store Rejection Date"; Date)
        {
        }
        field(50031; "Excise Approved (Accounts)"; Boolean)
        {
        }
        field(50032; "Capex No."; Code[20])
        {
        }
        field(50033; "Actual MRN Date"; Date)
        {
        }
        field(50034; Mailed; Boolean)
        {
            DataClassification = ToBeClassified;
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
        field(50095; "E-Way Bill No.1"; Code[12])
        {
        } // 15578
        field(60003; "Delivary Date"; Date)
        {
            Description = 'TRI SC';
        }
        field(60019; "GE Date"; Date)
        {
        }
        field(60020; Residue; Text[4])
        {
            Description = 'KBS';
        }
        field(60021; Moisture; Text[4])
        {
            Description = 'KBS';
        }
        field(60022; "Form 38 No."; Code[20])
        {
        }
        field(60028; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            TableRelation = "NOE Permission".NOE WHERE(Location = FIELD("Location Code"));
        }
        field(80000; "Due Date Calc. On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor Invoice Date,Inv Posting Date,GRN Date,Document Date';
            OptionMembers = " ","Vendor Invoice Date","Inv Posting Date","GRN Date","Document Date";
        }
        field(80005; "Return Order No"; Code[20])
        {

        }
        field(80007; "Posting Description New"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Description';
        }
    }
    keys
    {
        /* key(Key7; "Posting Date", "No.", "Vendor Invoice No.")
       {
       } */
        key(Key7; "Vendor Invoice No.")
        {
        }
    }
}

