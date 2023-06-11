tableextension 50204 tableextension50204 extends "Purchase Header Archive"
{
    fields
    {

        field(50000; Deleted; Boolean)
        {
            Description = 'Used for Tracking of ArchieveManagement For Deleted Purchase Order';
        }
        field(50001; "New Status"; Option)
        {
            OptionMembers = " ","Short Close",Cancel;
        }
        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'Customization No. 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Vendor));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50009; "Vendor Invoice Date"; Date)
        {
        }
        field(50012; "Document Received from Bank"; Boolean)
        {
            Description = 'Report 84 EXIM';
        }
        field(50013; "Document Receiving Date"; Date)
        {
            Description = 'Report 84 EXIM';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "GE No."; Code[20])
        {
        }
        field(50016; "Transporter's Code"; Code[20])
        {
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));
        }
        field(50017; "Quotation No."; Code[20])
        {
        }
        field(50018; "State Desc."; Text[50])
        {
            Editable = false;
        }
        field(50019; "Transporter Name"; Text[50])
        {
            Editable = false;
        }
        field(50020; "Delivery Period"; Text[50])
        {
        }
        field(50021; "Form 31 Amount"; Decimal)
        {
        }
        field(50022; "Amount to Vendor Version"; Code[20])
        {
            /* 15578  CalcFormula = Sum("Purchase Line Archive"."Amount To Vendor" WHERE("Document No." = FIELD("No."),
                                                                                  "Document Type" = FIELD("Document Type"),
                                                                                  "Version No." = FIELD("Version No.")));*/
            // FieldClass = FlowField;
        }
        field(50023; "Version qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line Archive".Quantity WHERE("Document No." = FIELD("No."),
                                                                      "Document Type" = FIELD("Document Type"),
                                                                      "Version No." = FIELD("Version No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        /* key(Key4; "Vendor Classification", "No.")
         {
         }*/
    }

}

