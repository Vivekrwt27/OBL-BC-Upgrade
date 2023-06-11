tableextension 50004 tableextension50004 extends "Sales Invoice Line"
{
    fields
    {


        field(50002; "Quantity in Cartons"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Type Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Code", DimensionValue.Code);
            end;
        }
        field(50004; "Plant Code"; Code[1])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Plant Code", DimensionValue.Code);
            end;
        }
        field(50005; "Size Code"; Code[3])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Size Code", DimensionValue.Code);
            end;
        }
        field(50006; "Posting Date1"; Date)
        {
            Description = 'report  S15';
        }
        field(50007; Schemes; Code[20])
        {
            Description = 'Customization No. 47';
        }
        field(50008; "Color Code"; Code[4])
        {
            Description = 'report s20';

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Color Code", DimensionValue.Code);
            end;
        }
        field(50009; "Design Code"; Code[4])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Design Code", DimensionValue.Code);
            end;
        }
        field(50010; "Packing Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Packing Code", DimensionValue.Code);
            end;
        }
        field(50011; "Quality Code"; Code[1])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Quality Code", DimensionValue.Code);
            end;
        }
        field(50012; "Salesperson Code"; Code[10])
        {
            Description = 'report n-10';
        }
        field(50013; "Quantity in Sq. Mt."; Decimal)
        {
            Editable = true;
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Buyer's Price"; Decimal)
        {
            Editable = false;
        }
        field(50016; "Discount Per Unit"; Decimal)
        {
        }
        field(50018; "Related Location code"; Code[20])
        {
        }
        field(50019; "Unit Price (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50020; "Amount (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50021; "Carton No. From"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50022; "Carton No. To"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50023; "Pallet No. From"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50024; "Pallet No. To"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50025; "Total Pallets"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50026; "Total Cartons"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50027; OK; Boolean)
        {
        }
        field(50028; "Group Code"; Code[2])
        {
            Editable = false;
        }
        field(50030; "Type Catogery Code"; Code[2])
        {
            Description = 'Tri NM 160308';

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Catogery Code", DimensionValue.Code);
            end;
        }
        field(50045; COCO; Boolean)
        {
            Description = 'Ori ut 05-08-10';
        }
        field(50060; "Sales Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(50061; "AD Remarks"; Text[30])
        {
            Description = 'Remarks for Sales Line';
            TableRelation = "Reason Code" WHERE(Remarks = CONST(true));
        }

        field(50062; "Order No. 1"; Code[20])// Base Application by Microsoft (20.1.39764.39901)
        {
            Caption = 'Order No.';
            CalcFormula = Lookup("Sales Invoice Header"."Order No." WHERE("No." = FIELD("Document No.")));
            Description = 'MSVRN 241117';
            FieldClass = FlowField;
        }  // 15578
        field(60004; Remarks; Text[40])
        {
            Description = 'TRI DG 290710';
            Editable = false;
        }
        field(60010; "Offer Code"; Code[10])
        {
        }
        field(60011; Slab; Code[10])
        {
        }
        field(60013; "Quantity Discount %"; Decimal)
        {
            Caption = 'Quantity Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(60014; "Quantity Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity Discount Amount';
        }
        field(60015; "Accrued Quantity"; Decimal)
        {
        }
        field(60016; "Calculate Line Discount"; Boolean)
        {
        }
        field(60017; "Accrued Discount"; Decimal)
        {
        }
        field(60018; Month; Option)
        {
            OptionCaption = ' ,Jan,Feb,Mar,April,May,Jun,July,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = " ",Jan,Feb,Mar,April,May,Jun,July,Aug,Sep,Oct,Nov,Dec;
        }
        field(60019; "Structure Calculated"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHEMECODE'));
        }
        field(60031; "V. Cost"; Decimal)
        {
        }
        field(60050; D1; Decimal)
        {
        }
        field(60051; D2; Decimal)
        {
        }
        field(60052; D3; Decimal)
        {
        }
        field(60053; D4; Decimal)
        {
        }
        field(60054; S1; Decimal)
        {
        }
        field(60055; "Discount Amt 1"; Decimal)
        {
        }
        field(60056; "Discount Amt 2"; Decimal)
        {
        }
        field(60057; "Discount Amt 3"; Decimal)
        {
        }
        field(60058; "Discount Amt 4"; Decimal)
        {
        }
        field(60059; "System Discount Amount"; Decimal)
        {
        }
        field(60062; D6; Decimal)
        {
            Caption = 'D6';
        }
        field(60063; "Discount Amt 6"; Decimal)
        {
            Caption = 'Discount Amt 6';
            Editable = false;
        }
        field(60064; D7; Decimal)
        {
        }
        field(60065; "Discount Amt 7"; Decimal)
        {
        }
        field(60066; "RG No."; Code[20])
        {
        }
        field(60067; "Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60301; "Trade Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60302; "Structure Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60303; "Line Discount Amount 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60100; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "TCS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MIPL-Rohan 310821';
        }
        field(70002; MRP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90004; "Amount Inc CD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        //Unsupported feature: Property Modification (SumIndexFields) on ""Document No.,Line No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Sell-to Customer No."(Key)".

        /*   key(Key10; "Sell-to Customer No.", Month)
           {
               SumIndexFields = "Amount Including VAT", "BED Amount", "AED(GSI) Amount", "SED Amount", "SAED Amount", "CESS Amount", "NCCD Amount", "eCess Amount", "ADET Amount", "ADE Amount", Amount, Quantity, "Amount To Customer", "SHE Cess Amount", "Excise Amount", "Amount Including Excise";
           }*/
        key(Key11; "No.", Type)
        {
            //15578  SumIndexFields = "Excise Amount";
        }
        key(Key12; "Document No.", Quantity)
        {
            //15578  SumIndexFields = "Amount Including Excise";
        }
        key(Key13; "Sell-to Customer No.", "Unit of Measure")
        {
        }
        /*  key(Key14; "Type Code", State, "Sell-to Customer No.")
          {
          }
          key(Key15; "Plant Code", "Type Code", "Size Code", "Unit of Measure Code")
          {
          }
          key(Key16; State, "Sell-to Customer No.", "Size Code", "Unit of Measure Code", "Posting Date")
          {
              //15578 SumIndexFields = "Amount To Customer";
          }*/
        key(Key17; "Size Code", "Packing Code", "Design Code", "Color Code", "Quality Code")
        {
        }
        /*   key(Key18; "Plant Code", "Sell-to Customer No.", "Posting Date1", "Document No.")
           {
           }
           key(Key19; State, "Related Location code", "Sell-to Customer No.", "Document No.", "Posting Date1", "Size Code", "Design Code", "Color Code", "Quality Code")
           {
           }
           key(Key20; State, "Sell-to Customer No.", "Posting Date1", "Size Code", "Design Code", "Color Code", "Quality Code")
           {
           }
           key(Key21; "Plant Code", "Salesperson Code", "Sell-to Customer No.", "Type Code")
           {
           }
           key(Key22; "Type Catogery Code")
           {
           }
           key(Key23; "Plant Code", "Related Location code", "Sell-to Customer No.", "Document No.", "Posting Date1", "Size Code", "Design Code", "Color Code", "Quality Code")
           {
           }
           key(Key24; "Salesperson Code", "Size Code", "Quality Code")
           {
           }
           key(Key25; "Document No.", "Posting Date1")
           {
           }
           key(Key26; "Plant Code", State, "Size Code", "Unit of Measure Code")
           {
           }
           key(Key27; "Plant Code", "Type Code", Type, "No.", "Posting Date1", "Unit of Measure Code")
           {
           }
           key(Key28; "No.", Type, "Posting Date1", "Unit of Measure Code")
           {
           }
           key(Key29; State, "Size Code", "Packing Code")
           {
           }
           key(Key30; "Size Code", "Plant Code")
           {
           }
           key(Key31; "Size Code", State, "Packing Code")
           {
           }
           key(Key32; "Quality Code", "Size Code", State, "Packing Code")
           {
           }
           key(Key33; State, "Size Code", "Design Code", "Color Code", "Packing Code")
           {
           }
           key(Key34; "Sell-to Customer No.", "Size Code", "Design Code", "Color Code", "Packing Code")
           {
           }
           key(Key35; "Size Code", "Design Code", "Color Code", "Packing Code")
           {
           }
           key(Key36; "Plant Code", State, "Sell-to Customer No.", "Size Code", "Unit of Measure Code")
           {
           }
           key(Key37; "Posting Date1", "Document No.", Quantity)
           {
           }
           key(Key38; State, "No.", "Size Code", "Unit of Measure Code", "Posting Date1")
           {
           }
           key(Key39; "Size Code", "No.")
           {
           }*/
    }

    procedure GetPreApprovedDiscount(): Decimal
    var
        DiscountSetups: Record "Discount Setups";
        Item: Record Item;
        SalesHeader: Record "Sales Invoice Header";
        TempDiscountSetups: Record "Discount Setups" temporary;
        Customer: Record Customer;
        PMTDiscount: Decimal;
    begin
        IF Type <> Type::Item THEN EXIT;

        IF Item.GET("No.") THEN;
        IF Item."Item Classification" = '' THEN
            EXIT;

        SalesHeader.GET("Document No.");
        Customer.GET("Sell-to Customer No.");

        CLEAR(TempDiscountSetups);
        DiscountSetups.RESET;
        DiscountSetups.SETFILTER("Item Classification", Item."Item Classification");
        DiscountSetups.SETFILTER("Starting Date", '<=%1', SalesHeader."Order Date");
        DiscountSetups.SETFILTER("Ending Date", '>=%1', SalesHeader."Order Date");
        DiscountSetups.SETFILTER("Manuf. Strategy", '%1', Item."Manuf. Strategy");
        DiscountSetups.SETFILTER("Customer No.", '%1', "Sell-to Customer No.");
        IF DiscountSetups.FINDLAST THEN BEGIN
            TempDiscountSetups := DiscountSetups;
        END ELSE BEGIN
            DiscountSetups.RESET;
            DiscountSetups.SETFILTER("Item Classification", Item."Item Classification");
            DiscountSetups.SETFILTER("Starting Date", '<=%1', SalesHeader."Order Date");
            DiscountSetups.SETFILTER("Ending Date", '>=%1', SalesHeader."Order Date");
            DiscountSetups.SETFILTER("Manuf. Strategy", '%1', Item."Manuf. Strategy");

            DiscountSetups.SETFILTER("Customer No.", '%1', '');
            DiscountSetups.SETFILTER(DiscountSetups."Area Code", '%1', Customer."Area Code");
            DiscountSetups.SETFILTER(DiscountSetups.State, '%1', Customer."State Code");
            IF DiscountSetups.FINDLAST THEN
                TempDiscountSetups := DiscountSetups;
            //  ELSE BEGIN
            //  DiscountSetups.SETRANGE(State);
            //  DiscountSetups.SETFILTER(DiscountSetups."Area Code",'%1',Customer."Area Code");
            //  IF DiscountSetups.FINDFIRST THEN
            //    TempDiscountSetups := DiscountSetups

            // END;

        END;

        EXIT(TempDiscountSetups."PreApproved Discount");

        //EXIT(TempDiscountSetups."PreApproved Discount");
    end;

    //Unsupported feature: Property Deletion (CaptionML).


    var
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
}

