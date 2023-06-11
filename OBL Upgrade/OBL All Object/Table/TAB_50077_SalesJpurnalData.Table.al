table 50077 "Sales Jpurnal Data"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ERP Size"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Type Code Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Type Category Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit of Measure"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Customer Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Customer City"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(22; "State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = State;
        }
        field(23; "State Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Customer Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Type".Code WHERE("Type" = FILTER(= Customer));
            ValidateTableRelation = false;
        }
        field(26; "Dealer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Cust. Price Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Price Group";
            ValidateTableRelation = false;
        }
        field(29; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; CRT; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Sq. Mt."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Basic Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Excise Duty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Excise Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; AD1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; AD2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; AD3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; AD4; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; AD5; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; AD6; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61; AD7; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Total AD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; QD; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; AQD; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Cash Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Sales Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(100; Frieght; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Insurance Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Entry Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(115; VAT; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "VAT Cess"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(125; "GST%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Total GST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(131; "TCS Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(135; "Total Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Net Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(145; "Item Classification"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(155; "Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(160; "Quality Code"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(165; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            ValidateTableRelation = false;
        }
        field(170; Pay; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'To Pay, To Be Billed, FOB Mundra Port';
            OptionMembers = "To Pay"," To Be Billed"," FOB Mundra Port";
        }
        field(175; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(180; "S/O No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Make SO Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(195; "Releasing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(200; "MRP /BOX"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(201; "MRP /Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(202; "AD1/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(203; "AD2/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(204; "AD3/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(205; "AD4/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(206; "AD5/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(207; "AD6/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(208; "AD7/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(209; "Total AD/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(220; "Billing Rate/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(221; "Buyer Rate/Sqm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(230; "Offer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(240; "External Doc. No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(245; "Form Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(250; "Transport Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }
        field(255; "GR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(260; "GR Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(265; "Sales Line Remark"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(270; "GR Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(275; "Sales Person Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(276; "Sales Person Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(280; "Variable Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(281; "Truck No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(282; "LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(283; "Transported Name"; Text[35])
        {
            DataClassification = ToBeClassified;
        }
        field(290; "PCH Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(295; "Govt. SP. Resp."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(300; "Private SP .Resp."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(310; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(315; "Sales Territory"; Code[12])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Matrix Master"."Type 2" WHERE("Mapping Type" = FILTER(City));
        }
        field(320; "ORC Terms"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(325; "Sales Line Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Retail,Govt,Private,CKA,Sale Return';
            OptionMembers = " ",Retail,Govt,Private,CKA,"Sale Return";
        }
        field(330; "Ship-to City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(335; "Trf/Pur Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(340; "GST No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(345; "Trade Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(346; "Other Claim"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(347; "Insurance Claim"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(350; "AD Remarks"; Text[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code" WHERE("Remarks" = CONST(true));
            ValidateTableRelation = false;
        }
        field(355; "Order Processed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(360; "Promise Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(361; "Business Development"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(362; "Govt. Project Sales"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(363; "Orient Bell Boutique"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(370; CKA; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(371; Retail; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(372; "Ref Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(373; "Tableau Product Code"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(375; Zone; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(376; "PMT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(380; "Order Received Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(385; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(390; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(400; Week; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(401; Month; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(402; "Month No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(405; Quarter; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(406; "Financial Year"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(407; Day; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(410; "SKU Cat."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(415; "Sale Type"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(416; Enterprises; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(420; "Get Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(425; Territory; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Territory;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(430; "Customer Type2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));
        }
        field(435; "NPD Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(436; Ashwamedha; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(440; OBTB; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(450; "OBTB New/Existing"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(460; Liquidation; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(465; "Manuf Strategy"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(470; "CD Availed from Utilisation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(500; "User ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(501; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(510; "Modified UserID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(511; "Modified DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(512; "Cust Parent Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "State Code", "Customer Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;
        "Created DateTime" := CURRENTDATETIME;
    end;

    trigger OnModify()
    begin
        "Modified UserID" := USERID;
        "Modified DateTime" := CURRENTDATETIME;
    end;

    var
        SalesJournalData: Record "Sales Jpurnal Data";

    procedure GetLastEntryNo(): Integer
    begin
        SalesJournalData.RESET();
        IF SalesJournalData.FINDLAST THEN
            EXIT(SalesJournalData."Entry No.");
    end;
}

