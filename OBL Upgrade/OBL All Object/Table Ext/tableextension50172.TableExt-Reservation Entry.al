tableextension 50172 tableextension50172 extends "Reservation Entry"
{
    fields
    {

        modify("Qty. per Unit of Measure")//15578
        {
            trigger OnBeforeValidate()
            begin
                "Qty In Crt" := ROUND("Quantity (Base)" / "Qty. per Unit of Measure", 0.0001);
            end;
        }
        field(50000; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Conversion; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Qty In Crt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Morbi Batch No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Morbi Reservation';
        }
        field(50005; "Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Morbi Reservation';
        }
    }
}

