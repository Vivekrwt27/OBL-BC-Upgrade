tableextension 50266 tableextension50266 extends "Posted Assembly Header"
{
    fields
    {
        field(50000; "Transfer Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Transfer Shipment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Transfer Shipment Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}

