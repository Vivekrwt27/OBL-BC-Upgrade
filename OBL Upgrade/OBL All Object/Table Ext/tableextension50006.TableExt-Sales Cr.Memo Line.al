tableextension 50006 tableextension50006 extends "Sales Cr.Memo Line"
{
    fields
    {


        field(50005; "Size Code"; Code[3])
        {
        }
        field(50007; Schemes; Code[20])
        {
            Description = 'Customization No. 47';
        }
        field(50008; "Color Code"; Code[4])
        {
            Description = 'report s20';
        }
        field(50009; "Design Code"; Code[4])
        {
        }
        field(50010; "Packing Code"; Code[2])
        {
        }
        field(50011; "Quality Code"; Code[1])
        {
        }
        field(50012; "Salesperson Code"; Code[10])
        {
            Description = 'report n-10';
        }
        field(50013; "Quantity in Sq. Mt."; Decimal)
        {
            Editable = false;
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50030; "Type Catogery Code"; Code[2])
        {
        }
        field(50060; "Sales Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(50141; BD; Boolean)
        {
        }
        field(50142; GPS; Boolean)
        {
        }
        field(50143; OBTB; Boolean)
        {
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
        field(50147; "Orient Bell Tiles Boutique"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60000; "TDS Nature of Deduction"; Code[10])
        {
            Description = 'TRI TDS DG 290710';
            Editable = false;
        }
        field(60001; "TDS Group"; Option)
        {
            Description = 'TRI TDS DG 290710';
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Others;
        }
        field(60002; "TDS Amount Including Surcharge"; Decimal)
        {
            Description = 'TRI TDS DG 290710';
            Editable = false;
        }
        field(60003; "Balance Surcharge Amount"; Decimal)
        {
            Description = 'TRI TDS DG 290710';
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
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHEMECODE'));
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
        key(Key9; "Document No.", Type)
        {
            SumIndexFields = Amount;
        }
        key(Key10; "Size Code"/*, "No."*/)
        {
        }
    }


    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 8)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    TRANSFERFIELDS(SalesLine);
    IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
      Type := Type::" ";
    "Posting Date" := SalesCrMemoHeader."Posting Date";
    "Document No." := SalesCrMemoHeader."No.";
    Quantity := SalesLine."Qty. to Invoice";
    "Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    //Upgrade(+)
      "Sales Type" := SalesLine."Sales Type";
    //Upgrade(-)
    */
    //end;

    //Unsupported feature: Property Deletion (CaptionML).

}

