tableextension 50005 tableextension50005 extends "Sales Cr.Memo Header"
{
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 60)".

        /*  modify(Structure)
          {
              TableRelation = "Structure Header" WHERE (Structure Type=FILTER(Sales));
          }*/ // 15578

        //Unsupported feature: Property Modification (Name) on ""Payment Date Base"(Field 16624)".

        modify("Acknowledgement No.")
        {
            Caption = 'Invoice Reference No.';
        }


        field(50012; "Transporter's Name"; Code[20])
        {
            Description = 'Customization No. 25';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));
        }
        field(50013; "GR No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50014; "Truck No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50018; "GR Date"; Date)
        {
            Description = 'Customization No. 25';
        }
        field(50033; "Transporter Name"; Text[30])
        {
            Editable = false;
        }
        field(50047; "Releasing Date"; Date)
        {
        }
        field(50048; "Releasing Time"; Time)
        {
        }
        field(50060; "Sales Type"; Option)
        {
            Editable = true;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
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
        field(50105; "Ship to Phone No."; Code[15])
        {
        }
        field(50106; "Email ID"; Text[30])
        {
        }
        field(50107; "Calculate Discount"; Boolean)
        {
        }
        field(50125; "PCH Code"; Code[10])
        {
        }
        field(50126; "Govt./Private Sales Person"; Code[10])
        {
        }
        field(50141; BD; Boolean)
        {
        }
        field(50142; GPS; Boolean)
        {
        }
        field(50143; OBTB; Boolean)
        {
        }
        field(50144; "None"; Boolean)
        {
        }
        field(50145; "Business Development"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50146; "Govt. Project Sales"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50147; "Orient Bell Tiles Boutique"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60010; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(60011; "Customer Type"; Code[10])
        {
        }
        field(60012; "Order No."; Code[20])
        {
        }
        field(60034; CKA; Boolean)
        {
        }
        field(60035; "CKA Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60040; "PMT Code"; Code[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF (STRLEN("PMT Code") < 14) AND (STRLEN("PMT Code") > 15)  THEN
                //    ERROR('Please Enter Correct PMT Code');
            end;
        }
        field(60090; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "Trade Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60302; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90003; "Structure Freight Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key10;/*State,*/"Sell-to Customer No.")
        {
        }
        key(Key11; "Posting Date")
        {
        }
    }
}

