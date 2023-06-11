table 70004 "Location New"
{
    Caption = 'Location';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = "Location List";
    LookupPageID = "Location List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(5700; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(5701; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(5702; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(5703; City; Text[30])
        {
            Caption = 'City';
        }
        field(5704; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(5705; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
        }
        field(5706; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(5707; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(5713; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(5714; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5715; County; Text[30])
        {
            Caption = 'County';
        }
        field(5718; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(5719; "Home Page"; Text[90])
        {
            Caption = 'Home Page';
        }
        field(5720; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(5724; "Use As In-Transit"; Boolean)
        {
            Caption = 'Use As In-Transit';
        }
        field(5726; "Require Put-away"; Boolean)
        {
            Caption = 'Require Put-away';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseRcptHeader: Record "Warehouse Receipt Header";
            begin
            end;
        }
        field(5727; "Require Pick"; Boolean)
        {
            Caption = 'Require Pick';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
            begin
            end;
        }
        field(5728; "Cross-Dock Due Date Calc."; DateFormula)
        {
            Caption = 'Cross-Dock Due Date Calc.';
        }
        field(5729; "Use Cross-Docking"; Boolean)
        {
            Caption = 'Use Cross-Docking';
        }
        field(5730; "Require Receive"; Boolean)
        {
            Caption = 'Require Receive';

            trigger OnValidate()
            var
                WhseRcptHeader: Record "Warehouse Receipt Header";
                WhseActivHeader: Record "Warehouse Activity Header";
            begin
            end;
        }
        field(5731; "Require Shipment"; Boolean)
        {
            Caption = 'Require Shipment';

            trigger OnValidate()
            var
                WhseShptHeader: Record "Warehouse Shipment Header";
                WhseActivHeader: Record "Warehouse Activity Header";
            begin
            end;
        }
        field(5732; "Bin Mandatory"; Boolean)
        {
            Caption = 'Bin Mandatory';

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                WhseEntry: Record "Warehouse Entry";
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
                WhseRcptHeader: Record "Warehouse Receipt Header";
                Window: Dialog;
            begin
            end;
        }
        field(5733; "Directed Put-away and Pick"; Boolean)
        {
            Caption = 'Directed Put-away and Pick';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
                WhseRcptHeader: Record "Warehouse Receipt Header";
            begin
            end;
        }
        field(5734; "Default Bin Selection"; Option)
        {
            Caption = 'Default Bin Selection';
            OptionCaption = ' ,Fixed Bin,Last-Used Bin';
            OptionMembers = " ","Fixed Bin","Last-Used Bin";
        }
        field(5790; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5791; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(7305; "Put-away Template Code"; Code[10])
        {
            Caption = 'Put-away Template Code';
            TableRelation = "Put-away Template Header";
        }
        field(7306; "Use Put-away Worksheet"; Boolean)
        {
            Caption = 'Use Put-away Worksheet';
        }
        field(7308; "Allow Breakbulk"; Boolean)
        {
            Caption = 'Allow Breakbulk';
        }
        field(7309; "Bin Capacity Policy"; Option)
        {
            Caption = 'Bin Capacity Policy';
            OptionCaption = 'Never Check Capacity,Allow More Than Max. Capacity,Prohibit More Than Max. Cap.';
            OptionMembers = "Never Check Capacity","Allow More Than Max. Capacity","Prohibit More Than Max. Cap.";
        }
        field(7313; "Open Shop Floor Bin Code"; Code[20])
        {
            Caption = 'Open Shop Floor Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7314; "Inbound Production Bin Code"; Code[20])
        {
            Caption = 'Inbound Production Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7315; "Outbound Production Bin Code"; Code[20])
        {
            Caption = 'Outbound Production Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7317; "Adjustment Bin Code"; Code[20])
        {
            Caption = 'Adjustment Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7319; "Always Create Put-away Line"; Boolean)
        {
            Caption = 'Always Create Put-away Line';
        }
        field(7320; "Always Create Pick Line"; Boolean)
        {
            Caption = 'Always Create Pick Line';
        }
        field(7321; "Special Equipment"; Option)
        {
            Caption = 'Special Equipment';
            OptionCaption = ' ,According to Bin,According to SKU/Item';
            OptionMembers = " ","According to Bin","According to SKU/Item";
        }
        field(7323; "Receipt Bin Code"; Code[20])
        {
            Caption = 'Receipt Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7325; "Shipment Bin Code"; Code[20])
        {
            Caption = 'Shipment Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7326; "Cross-Dock Bin Code"; Code[20])
        {
            Caption = 'Cross-Dock Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7327; "Outbound BOM Bin Code"; Code[20])
        {
            Caption = 'Outbound BOM Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7328; "Inbound BOM Bin Code"; Code[20])
        {
            Caption = 'Inbound BOM Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Code"));
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(7700; "Use ADCS"; Boolean)
        {
            Caption = 'Use ADCS';
        }
        field(13701; "Purch. Invoice Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13702; "Purch. Receipt Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13703; "Sales Invoice Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13704; "Sales Shipment Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13707; "Excise Bus. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Bus. Posting Group";//16225 table N/F
        }
        field(13708; "E.C.C. No."; Code[20])
        {
            // TableRelation = "E.C.C. Nos."; //16225 TABLE N/F
        }
        field(13709; "C.E. Regd No."; Code[20])
        {
        }
        field(13710; "C.E. Range"; Code[20])
        {
        }
        field(13711; "C.E. Commissionerate"; Code[20])
        {
        }
        field(13713; "C.E. Division"; Code[20])
        {
        }
        field(13714; State; Code[10])
        {
            TableRelation = State;
        }
        field(16360; "Subcontracting Location"; Boolean)
        {
        }
        field(16361; "Subcontractor No."; Code[20])
        {
            Editable = false;
            TableRelation = Vendor;
        }
        field(16362; "T.A.N. No."; Code[10])
        {
            //TableRelation = "T.A.N. Nos.";//16225 TABLE N/F
        }
        field(50000; "Main Location"; Code[10])
        {
            Description = 'Customization No. 64';
            TableRelation = Location.Code WHERE("Main Location" = FILTER(''));
        }
        field(50001; "Location Dimension"; Code[20])
        {
            Description = 'Customization No. 64';

            trigger OnLookup()
            var
                "....tri1.0": Integer;
                GLSetup: Record "General Ledger Setup";
                DimValue: Record "Dimension Value";
            begin
            end;
        }
        field(50002; "C.S.T. No."; Code[20])
        {
            Description = 'report I5';
        }
        field(50003; "U.P.T.T. No."; Code[20])
        {
            Description = 'report I5';
        }
        field(50004; "T.I.N. No."; Code[11])
        {
            Description = 'HF13';
            //TableRelation = "T.I.N. Nos."; //16225 TABLE N/F
        }
        field(50005; "Related Location Code"; Code[20])
        {
        }
        field(50006; "Form Code"; Code[10])
        {
            // TableRelation = "Form Codes"; //16225 TABLE N/F
        }
        field(50007; Structure; Code[10])
        {
            //TableRelation = "Structure Header"; //16225 TABLE N/F

            trigger OnValidate()
            var
                //StrDetails: Record 13793; //16225 TABLE N/F
                //StrOrderDetails: Record "13794"; //16225 TABLE N/F
                //StrOrderLines: Record "13795"; //16225 TABLE N/F
                SaleLines: Record "Sales Line";
            begin
            end;
        }
        field(50008; "Warehouse Location"; Boolean)
        {
            Description = 'report 50010';
        }
        field(50009; "Customer Price Group"; Code[10])
        {
            Description = 'ND';
            TableRelation = "Customer Price Group";
        }
        field(50010; Pay; Option)
        {
            Description = 'TRI A.S 07.11.08';
            OptionMembers = " ","To Pay","To be billed";
        }
        field(50011; Comment; Text[30])
        {
            Description = 'TRI A.S 31.12.08';
        }
        field(50012; "Shipment No. Series"; Code[20])
        {
            Description = 'TRI A.S 31.12.08';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; State)
        {
        }
        key(Key3; "Related Location Code", "Code")
        {
        }
        key(Key4; City, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        TransferRoute: Record "Transfer Route";
        "...tri1.0": Integer;
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
    end;

    trigger OnInsert()
    var
        "......tri1.0": Integer;
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
    end;

    trigger OnModify()
    var
        DimValue: Record "Dimension Value";
    begin
    end;

    trigger OnRename()
    var
        GLSetup: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
    begin
    end;
}

