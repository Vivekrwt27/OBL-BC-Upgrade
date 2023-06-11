tableextension 50246 tableextension50246 extends "Return Receipt Header"
{
    fields
    {
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
        field(50034; "Ship-to Address 3"; Text[50])
        {
            Description = 'TRI SC 10.03.10';
        }
    }
}

