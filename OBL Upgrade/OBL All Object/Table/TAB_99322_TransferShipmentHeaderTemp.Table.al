table 99322 "Transfer Shipment Header Temp"
{
    Caption = 'Transfer Shipment Header';
    DataCaptionFields = "No.";
    LookupPageID = "Posted Transfer Shipments";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
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
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
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
        field(20; "Transfer Order Date"; Date)
        {
            Caption = 'Transfer Order Date';
        }
        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(22; Comment; Boolean)
        {
            CalcFormula = Exist("Inventory Comment Line" WHERE("Document Type" = CONST("Posted Transfer Shipment"),
                                                                "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(25; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            TableRelation = "Transfer Header";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(26; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(27; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(28; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
        }
        field(29; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(true));
        }
        field(30; "Transfer-from Contact"; Text[30])
        {
            Caption = 'Transfer-from Contact';
        }
        field(31; "Transfer-to Contact"; Text[30])
        {
            Caption = 'Transfer-to Contact';
        }
        field(32; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(33; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(34; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(35; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(13707; "Excise Bus. Posting Group"; Code[10])
        {
            //   TableRelation = "Excise Bus. Posting Group"; //16225 TABLE N/F
        }
        field(13723; "Form Code"; Code[10])
        {
            // TableRelation = "Form Codes"; //16225 TABLE N/F
        }
        field(13724; "Form No."; Code[10])
        {
            //16225 TABLE N/F
            //TableRelation = "Tax Forms Details" WHERE("Form Code" = FIELD("Form Code"));
        }
        field(13750; Structure; Code[10])
        {
            // TableRelation = "Structure Header".Code; //16225 TABLE N/F

            trigger OnValidate()
            var
                //   StrDetails: Record 13793; //16225 TABLE N/F
                //   StrOrderDetails: Record 13794; //16225 TABLE N/F
                //   StrOrderLines: Record 13795; //16225 TABLE N/F
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
        }
        field(50007; "Transfer-to State"; Code[20])
        {
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
        field(50020; "Locked Order"; Boolean)
        {
        }
        field(50021; "External Transfer"; Boolean)
        {
        }
        field(50027; "SalesPerson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "Releasing Date"; Date)
        {
            Editable = false;
        }
        field(50031; "Releasing Time"; Time)
        {
            Editable = false;
        }
        field(50032; "Batch Executed"; Boolean)
        {
            Description = 'Tri5.0PG 10112006 -- Transfer Shipment Batch 56001';
        }
        field(50033; "Transfer Receipt No."; Code[20])
        {
            Description = 'Tri5.0PG 10112006 -- Transfer Shipment Batch 56001';
        }
        field(50034; "Group Code"; Code[2])
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
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {
        }
        key(Key3; "SalesPerson Code", "Transfer-to Code", "No.")
        {
        }
        key(Key4; "Transfer-from Code", "Transfer-to Code", "Posting Date")
        {
        }
        key(Key5; "Transfer Order No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        InvtCommentLine: Record "Inventory Comment Line";
        TransShptLine: Record "Transfer Shipment Line";
    begin
    end;
}

