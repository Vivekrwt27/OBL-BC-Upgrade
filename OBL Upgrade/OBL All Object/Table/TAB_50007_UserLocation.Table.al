table 50007 "User Location"
{
    // 
    // 
    // //1. TRI P.G 09.03.2010 -- NEW FIELD ADDED


    fields
    {
        field(1; "User ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Location Code"; Code[10])
        {
            Editable = true;
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                IF LocationRec.GET("Location Code") THEN
                    "Main Location" := LocationRec."Main Location";
            end;
        }
        field(3; "Create Sales Order"; Boolean)
        {
        }
        field(4; "Transfer From"; Boolean)
        {
        }
        field(5; "Transfer To"; Boolean)
        {
        }
        field(6; "Create Sales Invoice"; Boolean)
        {
        }
        field(7; "View Sales Order"; Boolean)
        {
        }
        field(8; "View Sales Invoice"; Boolean)
        {
        }
        field(9; "Create Sales Credit memo"; Boolean)
        {
        }
        field(10; "Create Sales Blanket Order"; Boolean)
        {
        }
        field(11; "Create Sales Return order"; Boolean)
        {
        }
        field(12; "View Sales Credit memo"; Boolean)
        {
        }
        field(13; "View Sales Blanket Order"; Boolean)
        {
        }
        field(14; "View Sales Return order"; Boolean)
        {
        }
        field(15; "Create Sales Quote"; Boolean)
        {
        }
        field(16; "View Sales Quote"; Boolean)
        {
        }
        field(17; "Create Purchase Order"; Boolean)
        {
        }
        field(18; "Create Purchase Invoice"; Boolean)
        {
        }
        field(19; "View Purchase Order"; Boolean)
        {
        }
        field(20; "View Purchase Invoice"; Boolean)
        {
        }
        field(21; "Create Purchase Credit memo"; Boolean)
        {
        }
        field(22; "Create Purchase Blanket Order"; Boolean)
        {
        }
        field(23; "Create Purchase Return order"; Boolean)
        {
        }
        field(24; "View Purchase Credit memo"; Boolean)
        {
        }
        field(25; "View Purchase Blanket Order"; Boolean)
        {
        }
        field(26; "View Purchase Return order"; Boolean)
        {
        }
        field(27; "Create Purchase Quote"; Boolean)
        {
        }
        field(28; "View Purchase Quote"; Boolean)
        {
        }
        field(29; "GJT General"; Boolean)
        {
        }
        field(30; "GJT Sales"; Boolean)
        {
        }
        field(31; "GJT Purchases"; Boolean)
        {
        }
        field(32; "GJT Cash Receipts"; Boolean)
        {
        }
        field(33; "GJT Payments"; Boolean)
        {
        }
        field(34; "GJT Assets"; Boolean)
        {
        }
        field(35; "GJT TDS Adjustments"; Boolean)
        {
        }
        field(36; "GJT LC"; Boolean)
        {
        }
        field(37; "GJT Receipts"; Boolean)
        {
        }
        field(38; "GJT JV"; Boolean)
        {
        }
        field(39; "GJT StdPayments"; Boolean)
        {
        }
        field(40; "IJT Item"; Boolean)
        {
        }
        field(41; "IJT Transfer"; Boolean)
        {
        }
        field(42; "IJT Phys. Inventory"; Boolean)
        {
        }
        field(43; "IJT Revaluation"; Boolean)
        {
        }
        field(44; "IJT Consumption"; Boolean)
        {
        }
        field(45; "IJT Output"; Boolean)
        {
        }
        field(46; "IJT Capacity"; Boolean)
        {
        }
        field(47; "Create Indent"; Boolean)
        {
        }
        field(48; "View Indent"; Boolean)
        {
        }
        field(49; "Sales Shipment"; Boolean)
        {
        }
        field(50; Purchaser; Boolean)
        {
        }
        field(51; "RGP IN"; Boolean)
        {
        }
        field(52; "RGP OUT"; Boolean)
        {
        }
        field(53; "View Export Order"; Boolean)
        {
        }
        field(54; "Create Export Order"; Boolean)
        {
        }
        field(55; "Main Location"; Code[10])
        {
            Editable = true;
        }
        field(56; "View Import Order"; Boolean)
        {
        }
        field(57; "Create Import Order"; Boolean)
        {
        }
        field(58; "Create Sales Forecast"; Boolean)
        {
            Description = 'TRI P.G 09.03.2010 -- NEW FIELD ADDED';
        }
        field(59; "Create Production Order"; Boolean)
        {
        }
        field(60; "View Production Order"; Boolean)
        {
        }
        field(61; "View Transfer Order"; Boolean)
        {
        }
        field(62; "View Customer"; Boolean)
        {
            Description = 'MSAK050515';
        }
        field(500; "Transfer Shipment"; Boolean)
        {
        }
        field(505; "Transfer Reciept"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LocationRec: Record Location;
}

