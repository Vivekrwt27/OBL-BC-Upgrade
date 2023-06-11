tableextension 50003 tableextension50003 extends "Sales Invoice Header"
{



    fields
    {

        /* 15578 modify("LC No.")
         {

             //Unsupported feature: Property Modification (Data type) on ""LC No."(Field 13753)".

             TableRelation = "LC Detail for Export"."LC No.";

             //Unsupported feature: Property Insertion (ValidateTableRelation) on ""LC No."(Field 13753)".

         }
         modify(Structure)
         {
             TableRelation = "Structure Header" WHERE (Structure Type=FILTER(Sales));
         }*/ // 15578


        modify("Acknowledgement No.")
        {
            Caption = 'Invoice Reference No.';
        }
        modify("Ship-to GST Customer Type")
        {
            OptionCaption = ' ,Registered,Unregistered,Export,Deemed Export,Exempted,SEZ Development,SEZ Unit';
        }


        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Cust 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; "PO No."; Code[40])
        {
            Description = 'Customization No. 5.3.3 /Ori Ut';
        }
        field(50007; Marked; Boolean)
        {
            Description = 'Customization No. 20';
        }
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
        field(50015; "Shipping Bill No."; Code[10])
        {
            Description = 'Field Can be use disable on SO';
        }
        field(50016; "HS Code"; Code[10])
        {
            Description = 'Customization No. 33';
            Enabled = false;
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Customization No. 25';
        }
        field(50018; "GR Date"; Date)
        {
            Description = 'Customization No. 25';
        }
        field(50019; "Prompt Pmt. Discount"; Decimal)
        {
            Description = 'Customization No. 27';
            Editable = true;
            Enabled = false;
        }
        field(50020; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50021; "Foreign Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50022; "Indian Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50023; "Entry No."; Integer)
        {
            Description = 'Report 18 Letter';
        }
        field(50024; "Entry Date"; Date)
        {
            Description = 'Report 18 Letter';
        }
        field(50025; "Main Location"; Code[10])
        {
        }
        field(50026; "Shipment Status"; Text[50])
        {
            Description = 'Report 102 EXIM';
        }
        field(50030; "State Desc."; Text[50])
        {
        }
        field(50031; "Salesperson Description"; Text[50])
        {
        }
        field(50032; "Amount Including Excise"; Decimal)
        {
            /* 15578  CalcFormula = Sum("Sales Invoice Line"."Amount Including Excise" WHERE ("Document No."=FIELD("No."),
                                                                                      Quantity=FILTER(<>0)));*/
            // FieldClass = FlowField;
        }
        field(50033; "Transporter Name"; Text[35])
        {
            Editable = true;
        }
        field(50035; "Excise Amount 1"; Decimal)
        {
            /* CalcFormula = Sum("Sales Invoice Line"."Excise Amount" WHERE ("Document No."=FIELD("No.")));*/ // 15578
            // FieldClass = FlowField;
        }
        field(50036; "Invoice Discount Amount1"; Decimal)
        {
            /* CalcFormula = Sum("Posted Str Order Line Details"."Amount (LCY)" WHERE (Type=CONST(Sale),
                                                                                     "Document Type"=CONST(Invoice),
                                                                                     "Invoice No."=FIELD("No."),
                                                                                     "Tax/Charge Type"=CONST(Charges),
                                                                                     "Tax/Charge Group"=CONST(DISCOUNT)));*/ // 15578
            // FieldClass = FlowField;
        }
        field(50037; "FOB Value"; Decimal)
        {
            Description = 'ND';
            Enabled = false;
        }
        field(50038; "Ocean Freight"; Decimal)
        {
            Description = 'ND';
        }
        field(50039; "No. of Containers"; Integer)
        {
            Description = 'ND';
        }
        field(50040; "Payment Terms"; Text[240])
        {
            Description = 'ND';
        }
        field(50041; "LC Number"; Code[90])
        {
            Description = 'ND';
        }
        field(50042; "Currency Code 1"; Code[30])
        {
            Description = 'MS-PB Reduces Size form 50 to 30';
            TableRelation = Currency;
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND,Tri3.1PG';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
        }
        field(50046; "Quote Date"; Date)
        {
        }
        field(50047; "Releasing Date"; Date)
        {
        }
        field(50048; "Releasing Time"; Time)
        {
        }
        field(50049; "E-Way No."; Code[1])
        {
            Enabled = false;
        }
        field(50055; "Gross Weight"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Gross Weight" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50056; "Net Weight"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Net Weight" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50057; "Sq. Meter"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Quantity in Sq. Mt." WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50058; "Qty In carton"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("Document No." = FIELD("No."),
                                                                   Type = FILTER(Item)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50059; "Sales Tax Amount"; Decimal)
        {
            /*  CalcFormula = Sum("Posted Str Order Line Details"."Amount (LCY)" WHERE (Type=CONST(Sale),
                                                                                      "Document Type"=CONST(Invoice),
                                                                                      "Invoice No."=FIELD("No."),
                                                                                      "Tax/Charge Type"=CONST("Sales Tax")));*/ // 15578
            // FieldClass = FlowField;
        }
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            Editable = true;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(50061; "Group Code"; Code[2])
        {
        }
        field(50065; "PCH Mailed"; Boolean)
        {
            Description = 'TSPL SA';
        }
        field(50071; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            Editable = false;
            OptionMembers = "To Pay"," To Be Billed"," FOB Mundra Port";
        }
        field(50074; "Blanket Order No."; Code[20])
        {
            Editable = false;
        }
        field(50082; "Discount Charges %"; Decimal)
        {
        }
        field(50088; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
            InitValue = true;
        }
        field(50089; "Other Comp. Location"; Code[1])
        {
            Description = 'MS-PB';
            Enabled = false;
        }
        field(50093; COCO; Boolean)
        {
            Description = 'Ori Ut 130710';
        }
        field(50094; "Elite Solution"; Boolean)
        {
            Description = 'Ori Ut 130710';
            Enabled = false;
        }
        field(50095; "COCO Store"; Code[10])
        {
            Description = 'Ori Ut 130710';
            TableRelation = Location;
        }
        field(50096; "Make Order Date"; DateTime)
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50097; "Order Created ID"; Text[15])
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50098; "RELEASING DATETIME"; DateTime)
        {
            Description = 'Ori Ut 130710';
        }
        field(50099; "Order Date Time"; DateTime)
        {
            Description = 'Ori Ut 130710';
        }
        field(50100; "Release DateTime"; Text[20])
        {
            Description = 'Ori Ut 130710';
        }
        field(50104; "TPT Method"; Option)
        {
            Description = 'Ori UT  280111';
            OptionCaption = ' ,Truck,Container, Party''s Vehicle,Tempo,Wagon';
            OptionMembers = " ",Truck,Container," Party's Vehicle",Tempo,Wagon;
        }
        field(50105; "Ship to Phone No."; Code[10])
        {
            Description = 'Field Can be use Disable from SO';
        }
        field(50106; "Email ID"; Text[20])
        {
            Enabled = false;
        }
        field(50107; "Calculate Discount"; Boolean)
        {
        }
        field(50109; "ORC Terms"; Text[50])
        {
            Description = 'Ori Kulb 230113';
        }
        field(50111; "Road Permit"; Text[1])
        {
            Enabled = false;
        }
        field(50114; "GR Value"; Decimal)
        {
        }
        field(50115; "CR Exception Type"; Option)
        {
            Enabled = false;
            OptionMembers = " ","No Exception",,"Dealer Undertaking","Over Due","Credit Limit","Over Due & Credit Limit";
        }
        field(50116; "CR Approved By"; Option)
        {
            Enabled = false;
            OptionMembers = " ","Approved by PSM"," Approved by Sales Head";
        }
        field(50126; "Govt./Private Sales Person"; Code[10])
        {
        }
        field(50129; "Payment Amount"; Decimal)
        {
            Enabled = false;
        }
        field(50130; "Payment Date1"; Date)
        {
            Enabled = false;
        } // 15578
        field(50131; "Order Booked Date"; DateTime)
        {
        }
        field(50133; "Confirmed Desc"; Text[1])
        {
            Enabled = false;
        }
        field(50134; "Despatch Remarks"; Text[30])
        {
        }
        field(50135; Commitment; Text[46])
        {
        }
        field(50136; "Payment Amount 2"; Decimal)
        {
            Enabled = false;
        }
        field(50137; "Payment Date 2"; Date)
        {
            Enabled = false;
        }
        field(50138; "Payment Amount 3"; Decimal)
        {
            Enabled = false;
        }
        field(50139; "Payment Date 3"; Date)
        {
        }
        field(50140; "Trade Discount"; Decimal)
        {
        }
        field(50141; BD; Boolean)
        {
        }
        field(50142; GPS; Boolean)
        {
        }
        field(50143; OBTB; Boolean)
        {
            Enabled = false;
        }
        field(50144; "None"; Boolean)
        {
        }
        field(50145; "Business Development"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50146; "Govt. Project Sales"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50147; "Orient Bell Tiles Boutique"; Code[1])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50148; "Posting Time"; Time)
        {
        }
        field(50170; "E-Way Bill No.1"; Text[12])
        {
            Description = 'Alle-[E-Way API]';
        } // 15578
        field(50171; "E-Way Bill Date"; Text[24])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50172; "E-Way Bill Validity"; Text[24])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50173; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50174; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50175; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50176; "Vechile No. Update Remark"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = ' ,Due to Break Down,Due to Transhipment,Others,First Time';
            OptionMembers = " ","Due to Break Down","Due to Transhipment",Others,"First Time";
        }
        field(50177; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50178; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50179; "E-Way URL"; Text[100])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50180; "Reason of Cancel"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry mistake,Others';
            OptionMembers = " ",Duplicate,"Order Cancelled","Data Entry mistake",Others;
        }
        field(50181; "E-Way Transaction Type"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = 'Regular,Bill To Ship To,Bill/Disp From,Comb of Bill To and Bill From';
            OptionMembers = Regular,"Bill To Ship To","Bill/Disp From","Comb of Bill To and Bill From";
        }
        field(60000; "State name"; Text[22])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD(State)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60010; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(60011; "Invoiced Mailed"; Boolean)
        {
        }
        field(60012; "Add Insu Discount"; Decimal)
        {
        }
        field(60015; "Tin No."; Code[11])
        {
        }
        field(60019; "Tax Base"; Decimal)
        {
            // 15578  CalcFormula = Sum("Sales Invoice Line"."Tax Base Amount" WHERE ("Document No."=FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(60020; "Sales Territory"; Code[12])
        {
            TableRelation = "Matrix Master"."Type 2" WHERE("Mapping Type" = FILTER(City));
        }
        field(60025; "CD Applicable"; Boolean)
        {
        }
        field(60027; "vendor code"; Code[15])
        {
            Enabled = false;
            TableRelation = Vendor;
        }
        field(60028; "Secondry Sales Person"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(60030; "CD Availed from Utilisation"; Decimal)
        {
            /* CalcFormula = Sum("Posted Str Order Line Details"."Amount (LCY)" WHERE (Type=CONST(Sale),
                                                                                     "Invoice No."=FIELD("No."),
                                                                                     "Tax/Charge Group"=CONST(TRDDISC)));*/ // 15578
            Editable = false;
            // FieldClass = FlowField;
        }
        field(60033; "Contribution Percentage"; Decimal)
        {
        }
        field(60034; CKA; Boolean)
        {
        }
        field(60035; "CKA Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60036; Retail; Boolean)
        {
        }
        field(60037; "Retail Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60038; "Ship to Pin"; Code[6])
        {
        }
        field(60040; "PMT Code"; Code[15])
        {
        }
        field(60090; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60092; "Direct Not Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60093; "InventoryNot Directly Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60302; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90000; "Qty. in Sq. Meter"; Decimal)
        {
        }
        field(90001; "Last Payment Receipt Date"; Date)
        {
            CalcFormula = Max("Detailed Cust. Ledg. Entry"."Posting Date" WHERE("Document Type" = FILTER(Payment),
                                                                                 Amount = FILTER(< -10),
                                                                                 "Cust. Ledger Entry No." = FIELD("Cust. Ledger Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90002; "Insurance Amt"; Decimal)
        {
            /* CalcFormula = Sum("Posted Str Order Line Details".Amount WHERE (Type=CONST(Sale),
                                                                             "Document Type"=CONST(Invoice),
                                                                             "Invoice No."=FIELD("No."),
                                                                             "Charge Type"=CONST(Insurance)));*/
            Editable = false;
            // FieldClass = FlowField;
        }
        field(90003; "Freight Amt"; Decimal)
        {
            /* CalcFormula = Sum("Posted Str Order Line Details".Amount WHERE (Type=CONST(Sale),
                                                                             Document Type=CONST(Invoice),
                                                                             Invoice No.=FIELD(No.),
                                                                             Charge Type=CONST(Freight)));*/ // 15578
            // FieldClass = FlowField;
        }
    }
    keys
    {
        /*key(Key14; "Sell-to Customer No.", "Form No.")
        {
        }*/ // 15578
        key(Key25; "Sell-to City", "Sell-to Customer No.")
        {
        }
        key(Key16;/* State,*/ "Sell-to Customer No.")// 15578
        {
        }
        key(Key17; "Salesperson Code"/*, State*/)// 15578
        {
        }
        key(Key18; "Salesperson Code", "Sell-to Customer No.")
        {
        }
        key(Key19; "Sell-to Customer No.", "Posting Date")
        {
        }
        key(Key20;/* "Form Code",*/ "Group Code")// 15578
        {
        }
    }
}

