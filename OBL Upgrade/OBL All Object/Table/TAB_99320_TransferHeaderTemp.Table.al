table 99320 "Transfer Header Temp"
{
    Caption = 'Transfer Header';
    LookupPageID = "Transfer Orders";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Description = 'Where Subcontracting = No';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Subcontracting Location" = CONST(false));

            trigger OnValidate()
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
            end;
        }
        field(3; "Transfer-from Name"; Text[50])
        {
            Caption = 'Transfer-from Name';
        }
        field(4; "Transfer-from Name 2"; Text[50])
        {
            Caption = 'Transfer-from Name 2';
        }
        field(5; "Transfer-from Address"; Text[50])
        {
            Caption = 'Transfer-from Address';
        }
        field(6; "Transfer-from Address 2"; Text[50])
        {
            Caption = 'Transfer-from Address 2';
        }
        field(7; "Transfer-from Post Code"; Code[20])
        {
            Caption = 'Transfer-from Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8; "Transfer-from City"; Text[30])
        {
            Caption = 'Transfer-from City';
        }
        field(9; "Transfer-from County"; Text[30])
        {
            Caption = 'Transfer-from County';
        }
        field(10; "Transfer-from Country Code"; Code[10])
        {
            Caption = 'Transfer-from Country Code';
        }
        field(11; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            Description = 'Where Subcontracting = No';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Subcontracting Location" = CONST(false));

            trigger OnValidate()
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
            end;
        }
        field(12; "Transfer-to Name"; Text[50])
        {
            Caption = 'Transfer-to Name';
        }
        field(13; "Transfer-to Name 2"; Text[50])
        {
            Caption = 'Transfer-to Name 2';
        }
        field(14; "Transfer-to Address"; Text[50])
        {
            Caption = 'Transfer-to Address';
        }
        field(15; "Transfer-to Address 2"; Text[50])
        {
            Caption = 'Transfer-to Address 2';
        }
        field(16; "Transfer-to Post Code"; Code[20])
        {
            Caption = 'Transfer-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(17; "Transfer-to City"; Text[30])
        {
            Caption = 'Transfer-to City';
        }
        field(18; "Transfer-to County"; Text[30])
        {
            Caption = 'Transfer-to County';
        }
        field(19; "Transfer-to Country Code"; Code[10])
        {
            Caption = 'Transfer-to Country Code';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(22; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(24; Comment; Boolean)
        {
            CalcFormula = Exist("Inventory Comment Line" WHERE("Document Type" = CONST("Transfer Order"),
                                                                "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(26; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(27; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(29; "Last Shipment No."; Code[20])
        {
            Caption = 'Last Shipment No.';
            Editable = false;
            TableRelation = "Transfer Shipment Header";
        }
        field(30; "Last Receipt No."; Code[20])
        {
            Caption = 'Last Receipt No.';
            Editable = false;
            TableRelation = "Transfer Receipt Header";
        }
        field(31; "Transfer-from Contact"; Text[30])
        {
            Caption = 'Transfer-from Contact';
        }
        field(32; "Transfer-to Contact"; Text[30])
        {
            Caption = 'Transfer-to Contact';
        }
        field(33; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(34; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(35; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(36; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(37; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5751; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Transfer Line"."Completely Shipped" WHERE("Document No." = FIELD("No."),
                                                                          "Shipment Date" = FIELD("Date Filter"),
                                                                          "Transfer-from Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Completely Received"; Boolean)
        {
            CalcFormula = Min("Transfer Line"."Completely Received" WHERE("Document No." = FIELD("No."),
                                                                           "Receipt Date" = FIELD("Date Filter"),
                                                                           "Transfer-to Code" = FIELD("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(13707; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //  TableRelation = "Excise Bus. Posting Group"; //16225 TABLE N/F
        }
        field(13723; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            //  TableRelation = "Form Codes"; //16225 TABLE N/F
        }
        field(13724; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            //TableRelation = "Tax Forms Details"."Form No." WHERE("Form Code" = FIELD("Form Code")); //16225 TABLE N/F
        }
        field(13750; Structure; Code[10])
        {
            Caption = 'Structure';
            // TableRelation = "Structure Header".Code; //16225 TABLE N/F

            trigger OnValidate()
            var
                //  StrDetails: Record 13793;  //16225 TABLE N/F
                //  StrOrderDetails: Record 13794;  //16225 TABLE N/F
                //  StrOrderLines: Record 13795;  //16225 TABLE N/F
                TransLines: Record "Transfer Line";
            begin
            end;
        }
        field(50000; Purpose; Text[50])
        {
            Description = 'New Field Added For Information Point Only';
        }
        field(50001; "Transporter's Name"; Code[20])
        {
            Description = 'report 54 - S2';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));

            trigger OnValidate()
            var
                Vendorrec: Record Vendor;
            begin
            end;
        }
        field(50002; "GR No."; Code[20])
        {
            Description = 'report 54 - S2';
        }
        field(50003; "GR Date"; Date)
        {
            Description = 'report 54 - S2';
        }
        field(50004; "Truck No."; Code[20])
        {
            Description = 'report 54 - S2';
        }
        field(50005; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50006; "Transfer-from State"; Code[20])
        {
            TableRelation = State.Code;
        }
        field(50007; "Transfer-to State"; Code[20])
        {
            TableRelation = State.Code;
        }
        field(50008; "From Main Location"; Code[10])
        {
        }
        field(50009; "To Main Location"; Code[10])
        {
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Report 113 N-10A';
        }
        field(50018; "Customer Price Group"; Code[20])
        {
            TableRelation = "Customer Price Group".Code;
        }
        field(50019; "Transit Document"; Boolean)
        {
        }
        field(50020; "Locked Order"; Boolean)
        {
        }
        field(50021; "Transfer order Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Released;
        }
        field(50022; "Transporter Name"; Text[30])
        {
            Editable = false;
        }
        field(50023; "Qty in Sq Mtr"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Qty in Sq. Mt." WHERE("Document No." = FIELD("No."),
                                                                      "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Total Weight"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Gross Weight" WHERE("Document No." = FIELD("No."),
                                                                    "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Total Qty"; Decimal)
        {
            CalcFormula = Sum("Transfer Line".Quantity WHERE("Document No." = FIELD("No."),
                                                              "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Shipment No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50027; "SalesPerson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50028; "Qty. To Ship"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Qty. to Ship" WHERE("Document No." = FIELD("No."),
                                                                    "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "External Transfer"; Boolean)
        {
        }
        field(50030; "Releasing Date"; Date)
        {
            Editable = false;
        }
        field(50031; "Releasing Time"; Time)
        {
            Editable = false;
        }
        field(50034; "Group Code"; Code[2])
        {
            TableRelation = "Item Group";
        }
        field(50035; "Group Code Check"; Boolean)
        {
        }
        field(50036; Pay; Option)
        {
            Description = 'TRI A.S 07.11.08';
            Editable = false;
            OptionCaption = ' ,To Pay,To be billed';
            OptionMembers = " ","To Pay","To be billed";
        }
        field(50037; "Location Comment"; Text[30])
        {
            Description = 'TRI A.S 31.12.08';
        }
        field(50038; "Amount Including Excise"; Decimal)
        {
            //16225 TABLE "Transfer Line"."Amount Including Excise" FIELD N/F
            //  CalcFormula = Sum("Transfer Line"."Amount Including Excise" WHERE("Document No." = FIELD("No.")));
            Description = 'TRI P.G 22.06.2009';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Transfer-to Code", "No.")
        {
        }
        key(Key3; "Transfer-to State", "Transfer-to Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        TransLine: Record "Transfer Line";
        InvtCommentLine: Record "Inventory Comment Line";
    begin
    end;
}

