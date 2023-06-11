tableextension 50227 tableextension50227 extends "Item Charge"
{
    fields
    {

        field(50000; "CN Charges allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Structure Editable Allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Insurance Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50003; "Calculation Type"; Option)
        {
            OptionCaption = ' ,Percentage,Amount Per Qty,Fixed Value';
            OptionMembers = " ",Percentage,"Amount Per Qty","Fixed Value";
        }

        field(50004; "GL Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Sales; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Structure Type "; Option)
        {
            OptionCaption = ' ,Sales,Purchase';
            OptionMembers = " ",Sales,Purchase;

        }


    }



}

