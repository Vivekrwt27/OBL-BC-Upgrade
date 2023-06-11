tableextension 50244 tableextension50244 extends "Return Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Posting Description"(Field 22)".

        field(50009; "Vendor Invoice Date"; Date)
        {
        }
        field(50010; "Vendor Invoice No."; Code[20])
        {
            Caption = 'Vendor Invoice No.';
        }
    }
}

