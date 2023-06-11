tableextension 50138 tableextension50138 extends "Reason Code"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Code(Field 1)".

        field(50001; Reason; Boolean)
        {
        }
        field(50002; Remarks; Boolean)
        {
        }
        field(50003; Purchase; Boolean)
        {
        }
        field(50004; "SO Hold Reason"; Boolean)
        {
        }
        field(50005; "Despatch Remarks"; Boolean)
        {
        }
        field(50006; "Reason Group"; Text[30])
        {
        }
        field(50007; "Item Change Remarks"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Varient Codes"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key2; Description)
        {
        }
    }
}

