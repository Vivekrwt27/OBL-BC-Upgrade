table 50006 "Production Planing"
{

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(2; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                IF Item.GET("Item No") THEN
                    Description := Item."Complete Description";
                Size := Item."Size Code Desc.";
                "Manuf. Stategy" := Item."Manuf. Strategy";

            end;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Manuf. Stategy"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO,Non Retain - Ex';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO,"Non Retain - Ex";
        }
        field(7; "Avg. Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Wharehouse Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Retail Pending Order"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Enterprises Pending Orders"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Production  Plan in sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Size; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; WMD; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Date, "Location Code", "Item No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
}

