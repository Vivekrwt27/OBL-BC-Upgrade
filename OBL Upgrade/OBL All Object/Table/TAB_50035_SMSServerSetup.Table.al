table 50035 "SMS - Server Setup"
{
    // //1. TRI PG 20.11.2008 -- SMS Server -- NEW TABLE ADDED


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; Enable; Boolean)
        {
        }
        field(3; "Working Mode"; Option)
        {
            OptionMembers = "Message Queue","Direct SQL Server Access";
        }
        field(4; "Track Send Status"; Boolean)
        {
        }
        field(5; "NAS ID"; Code[1])
        {
        }
        field(6; "Message Queue Send Message"; Text[1])
        {
        }
        field(7; "Message Queue Send Status"; Text[1])
        {
        }
        field(8; "Message Log"; Boolean)
        {
        }
        field(100; "Activate SMS Sending"; Boolean)
        {
        }
        field(201; "Post Customer Invoice"; Boolean)
        {
        }
        field(202; "Post Customer Cr. Note"; Boolean)
        {
        }
        field(203; "Post Customer Payment"; Boolean)
        {
        }
        field(204; "Post Customer Refund"; Boolean)
        {
        }
        field(205; "Post Customer Due Date"; Boolean)
        {
        }
        field(206; "Post Customer +5 Due Date"; Boolean)
        {
        }
        field(207; "Post Customer -5 Due Date"; Boolean)
        {
        }
        field(208; "Send Cust. Due Message On Date"; Integer)
        {
        }
        field(209; "Send Msg. on DA Release"; Boolean)
        {
        }
        field(251; "SMS Template Cust. Invoice"; Text[200])
        {
        }
        field(252; "SMS Template Cust. Cr. Note"; Text[200])
        {
        }
        field(253; "SMS Template Cust. Payment"; Text[200])
        {
        }
        field(254; "SMS Template Cust. Refund"; Text[200])
        {
        }
        field(255; "SMS Template Cust. Due Date"; Text[200])
        {
        }
        field(256; "SMS Template Cust.+5 Due Date"; Text[200])
        {
        }
        field(257; "SMS Template Cust.-5 Due Date"; Text[200])
        {
        }
        field(258; "SMS Template Cust. On Date"; Text[200])
        {
        }
        field(259; "SMS Template Cust. Order"; Text[200])
        {
        }
        field(260; "SMS Template for DA Release"; Text[200])
        {
        }
        field(301; "Post Vendor Invoice"; Boolean)
        {
        }
        field(302; "Post Vendor Dr. Note"; Boolean)
        {
        }
        field(303; "Post Vendor Payment"; Boolean)
        {
        }
        field(304; "Post Vendor Refund"; Boolean)
        {
        }
        field(351; "SMS Template Vend. Invoice"; Text[210])
        {
        }
        field(352; "SMS Template Vend. Dr. Note"; Text[210])
        {
        }
        field(353; "SMS Template Vend. Payment"; Text[210])
        {
        }
        field(354; "SMS Template Vend. Refund"; Text[210])
        {
        }
        field(500; "Send Generic Message"; Boolean)
        {
        }
        field(501; "Allow Only From Master List"; Boolean)
        {
        }
        field(800; "SMS Counter"; Integer)
        {
            Editable = false;
        }
        field(801; "SMS Counter Last Reset On"; DateTime)
        {
            Editable = false;
        }
        field(900; "Message Queue Created Date"; Date)
        {
        }
        field(1010; "SMS Template Order Booked"; Text[210])
        {
        }
        field(1020; "SMS Temp. Order Price Approved"; Text[210])
        {
        }
        field(1030; "SMS Template Order Released"; Text[210])
        {
        }
        field(1251; "Template ID Cust. Invoice"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1252; "Template ID Cust. Cr. Note"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1253; "Template ID Cust. Payment"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1254; "Template ID Cust. Refund"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1255; "Template ID Cust. Due Date"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1256; "Template ID Cust.+5 Due Date"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1257; "Template ID Cust.-5 Due Date"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1258; "Template ID Cust. On Date"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1259; "Template ID Cust. Order"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1260; "Template ID for DA Release"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1351; "Template ID Vend. Invoice"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1352; "Template ID Vend. Dr. Note"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1353; "Template ID Vend. Payment"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1354; "Template ID Vend. Refund"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11010; "Template ID Order Booked"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11020; "Temp. ID Order Price Approved"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11030; "Template ID Order Released"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

