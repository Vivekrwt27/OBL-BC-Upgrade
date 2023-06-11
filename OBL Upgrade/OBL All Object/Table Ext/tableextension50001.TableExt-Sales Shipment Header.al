tableextension 50001 tableextension50001 extends "Sales Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Transport Method"(Field 77)".

        /*  modify(Structure)
          {
              TableRelation = "Structure Header" WHERE (Structure Type=FILTER(Sales));
          }*/ // 15578

        //Unsupported feature: Deletion (FieldCollection) on ""Post GST to Customer"(Field 16636)".

        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Customization No. 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; "PO No."; Code[40])
        {
            Description = 'Customization No. 5.3.3/Ori Ut';
        }
        field(50010; Remarks; Text[100])
        {
            Description = 'Customization No. 28';
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
        field(50015; "Shipping Bill No."; Code[10])
        {
            Description = 'Customization No. 33';
        }
        field(50016; "HS Code"; Code[10])
        {
            Description = 'Customization No. 33';
            Enabled = false;
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Customization No. 25';
        }
        field(50018; "GR Date"; Date)
        {
            Description = 'Customization No. 25';
        }
        field(50020; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50021; "Foreign Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50022; "Indian Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50023; "Entry No."; Integer)
        {
            Description = 'Report 18 Letter';
        }
        field(50024; "Entry Date"; Date)
        {
            Description = 'Report 18 Letter';
        }
        field(50025; "Main Location"; Code[10])
        {
        }
        field(50026; "Shipment Status"; Text[50])
        {
            Description = 'Report 102 EXIM';
        }
        field(50030; "State Desc."; Text[50])
        {
        }
        field(50031; "Salesperson Description"; Text[50])
        {
        }
        field(50033; "Transporter Name"; Text[30])
        {
            Editable = false;
        }
        field(50037; "FOB Value"; Decimal)
        {
            Description = 'ND';
            Enabled = false;
        }
        field(50038; "Ocean Freight"; Decimal)
        {
            Description = 'ND';
        }
        field(50039; "No. of Containers"; Integer)
        {
            Description = 'ND';
        }
        field(50040; "Payment Terms"; Text[250])
        {
            Description = 'ND';
        }
        field(50041; "LC Number"; Code[100])
        {
            Description = 'ND';
        }
        field(50042; "Currency Code 1"; Code[50])
        {
            Description = 'ND';
            TableRelation = Currency;
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
        }
        field(50046; "Quote Date"; Date)
        {
        }
        field(50047; "Releasing Date"; Date)
        {
        }
        field(50048; "Releasing Time"; Time)
        {
        }
        field(50049; "SB No."; Code[15])
        {
        }
        field(50050; "SB Date"; Date)
        {
        }
        field(50051; ICD; Text[15])
        {
        }
        field(50052; "Export To"; Text[15])
        {
        }
        field(50053; "OTS No."; Code[15])
        {
        }
        field(50054; "Container No."; Code[15])
        {
        }
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            Editable = false;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(50061; "Group Code"; Code[2])
        {
        }
        field(50071; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            Editable = false;
            OptionMembers = "To Pay"," To Be Billed";
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
        field(50096; "Make Order Date"; DateTime)
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50097; "Order Created ID"; Text[20])
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50098; "RELEASING DATETIME"; DateTime)
        {
            Description = 'Ori Ut 130710';
        }
        field(50099; "Order Date Time"; DateTime)
        {
            Description = 'Ori Ut 130710';
        }
        field(50104; "TPT Method"; Option)
        {
            Description = 'Ori UT  280111';
            OptionCaption = ' ,Truck,Container, Party''s Vehicle,Tempo,Wagon';
            OptionMembers = " ",Truck,Container," Party's Vehicle",Tempo,Wagon;
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
        field(50126; "Govt./Private Sales Person"; Code[10])
        {
        }
        field(60090; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "Trade Discount"; Decimal)
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
}

