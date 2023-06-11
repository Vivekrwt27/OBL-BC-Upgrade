table 50094 "Item Details - IBOT"
{

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '20';
        }
        field(10; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '20';
        }
        field(15; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(100; Inventory; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Gross Weight Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Inventory In Cartons"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Last Sales Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Last MRP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; Discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Reserved Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Type Catogery Code"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Size Code"; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Design Code"; Code[4])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Color Code"; Code[4])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Packing Code"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Quality Code"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Plant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Item Classification"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Classification";
        }
        field(50009; "Type Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "Type Category Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Size Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Design Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Color Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "Packing Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015; "Quality Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Plant Code Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50017; "Manufacturer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50034; "Group Code"; Code[3])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Group";
        }
        field(50035; "Group code Desc"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'tri LM 100308';
            Editable = false;
        }
        field(50127; "Manuf. Strategy"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Kulbhushan Field for to know the production purpose';
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO,Non Retain - Ex';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO,"Non Retain - Ex";
        }
        field(50130; NPD; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50132; "Tableau Product Group"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50133; Liquidaton; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Default Prod. Plant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'TRI S.R 040610';
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(60006; Conversion; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "Weight Per Carton"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "Inventory In Hand"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

