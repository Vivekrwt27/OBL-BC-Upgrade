table 50101 "Transfer SO Line"
{

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; Size; Text[30])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Item No"; Code[20])
        {
        }
        field(5; "SKU Category"; Text[15])
        {
        }
        field(6; Stock; Text[30])
        {
        }
        field(7; "Quantity in Carton"; Decimal)
        {
        }
        field(8; "Total Discount sqmt"; Decimal)
        {
        }
        field(9; "Sales Type"; Text[30])
        {
            Editable = true;
        }
        field(20; LineID; Integer)
        {
        }
        field(21; "Location Code"; Code[10])
        {
        }
        field(22; "Description 2"; Text[50])
        {
        }
        field(23; Freight; Decimal)
        {
        }
        field(24; ORC; Decimal)
        {
        }
        field(25; "Reg Discount Approval"; Text[150])
        {
        }
        field(26; "No."; Text[150])
        {
        }
        field(27; "NET Realisation"; Decimal)
        {
        }
        field(28; ItemMsr; Decimal)
        {
        }
        field(29; ItemWeight; Decimal)
        {
        }
        field(30; "Quantity in sqmt"; Decimal)
        {
        }
        field(31; "List Price in sqmt"; Decimal)
        {
        }
        field(32; "Billing sqmt"; Decimal)
        {
        }
        field(33; ItemOrgWeight; Decimal)
        {
        }
        field(34; "Plant Code"; Text[150])
        {
        }
        field(60060; "Sales Order Created"; Boolean)
        {
            Description = 'MSVRN 13012020';
        }
        field(60061; Retained; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
            OptionCaption = ' ,Continue,Discontinue';
            OptionMembers = " ",Continue,Discontinue;
        }
        field(60062; "Manuf. Strategy"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO,Non Retain - Ex';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO,"Non Retain - Ex";
        }
        field(60063; NPD; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
        }
        field(60064; Layer; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
        }
        field(60065; "Pallet Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
        }
        field(60066; "Tableau Product Group"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
        }
        field(60067; "SO No,"; Code[20])
        {
            CalcFormula = Lookup("Transfer SO Sales Header"."Sales Order No." WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60068; "So Date"; Date)
        {
            CalcFormula = Lookup("Transfer SO Sales Header"."Order Date" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

