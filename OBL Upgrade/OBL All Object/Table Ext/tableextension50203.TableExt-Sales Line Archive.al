tableextension 50203 tableextension50203 extends "Sales Line Archive"
{
    fields
    {
        field(50002; "Quantity in Cartons"; Decimal)
        {
        }
        field(50003; "Type Code"; Code[2])
        {
        }
        field(50004; "Plant Code"; Code[1])
        {
        }
        field(50005; "Size Code"; Code[3])
        {
        }
        field(50006; "Posting Date"; Date)
        {
            Description = 'report  S15';
        }
        field(50007; Schemes; Code[20])
        {
            Description = 'Customization No. 47';
        }
        field(50008; "Color Code"; Code[4])
        {
            Description = 'report s-20';
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
            Description = 'Report n-4';
        }
        field(50013; "Quantity in Sq. Mt."; Decimal)
        {
            Editable = false;
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
        field(50028; "Group Code"; Code[2])
        {
            Editable = false;
        }
        field(50029; "Item Type"; Code[2])
        {
            Description = 'tri LM 100308';
        }
        field(50030; "Type Catogery Code"; Code[2])
        {
            Description = 'Tri NM 160308';
        }
        field(50031; "Order Qty"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FILTER(Order),
                                                                            "Blanket Order No." = FIELD("Document No."),
                                                                            "Blanket Order Line No." = FIELD("Line No.")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Remaining Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Variant Code" = FIELD("Variant Code")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; "Total Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Source Type" = FILTER(32),
                                                                  "Variant Code" = FIELD("Variant Code")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "Quantity in Sq. Mt.(Ship)"; Decimal)
        {
            Editable = false;
        }
        field(50035; "Quantity in Cartons(Ship)"; Decimal)
        {
            Editable = false;
        }
        field(50036; "Quantity in Hand"; Decimal)
        {
            Editable = false;
        }
        field(50038; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(50039; "Gross Weight (Ship)"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50040; "Net Weight (Ship)"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50041; "Arch Date"; Date)
        {
            CalcFormula = Lookup("Sales Header Archive"."Date Archived" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50042; "Arch Time"; Time)
        {
            CalcFormula = Lookup("Sales Header Archive"."Time Archived" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50043; "Release Date"; Date)
        {
            CalcFormula = Lookup("Sales Header Archive"."Releasing Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50044; "Release Time"; Time)
        {
            CalcFormula = Lookup("Sales Header Archive"."Releasing Time" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50061; "AD Remarks"; Text[30])
        {
            Description = 'Remarks for Sales Line';
            TableRelation = "Reason Code" WHERE(Remarks = CONST(true));
        }
        field(50062; "Invoice Posting Date"; Date)
        {
            CalcFormula = Lookup("Sales Invoice Header"."Posting Date" WHERE("Order No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60067; "Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60082; "Itemr Change Remarks"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Order Change Remarks';
            TableRelation = "Reason Code" WHERE("Item Change Remarks" = CONST(true));
        }
        field(70003; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90033; "Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Source Type" = CONST(37),
                                                                   "Source Subtype" = FIELD("Document Type"),
                                                                   "Reservation Status" = CONST(Reservation)));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90034; "Cust Type"; Code[10])
        {
            CalcFormula = Lookup("Sales Header Archive"."Customer Type" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(90035; "reason code"; Code[10])
        {
            CalcFormula = Lookup("Sales Header Archive"."Reason Code" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(90050; "Posting Date1"; Date)
        {
            CalcFormula = Lookup("Sales Invoice Header"."Posting Date" WHERE("Order No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key7; "Design Code", "Color Code", "Quality Code", "Size Code", "Packing Code")
        {
        }
        /* key(Key8; "Design Code", "Color Code", "Quality Code", "Size Code", "Packing Code", "Sell-to Customer No.")
         {
         }*/
    }

    procedure CalculateBuyerRate(SalesLine: Record "Sales Line Archive") BuyersRatePerSqMtr: Decimal
    var
        Cart: Decimal;
        SQMt: Decimal;
        Item: Record Item;
        DecRate: Decimal;
        wt: Decimal;
    begin
        Cart := 0;
        SQMt := 0;
        wt := 0;
        Cart := Item.UomToCart(SalesLine."No.", SalesLine."Unit of Measure Code", SalesLine.Quantity);
        SQMt := Item.UomToSqm(SalesLine."No.", SalesLine."Unit of Measure Code", SalesLine.Quantity);
        wt := SalesLine."Gross Weight";
        IF SalesLine."Quantity in Sq. Mt." <> 0 THEN BEGIN
            DecRate := SalesLine."Line Discount Amount" / SQMt;
        END;
        CLEAR(BuyersRatePerSqMtr);
        IF SQMt <> 0 THEN BEGIN
            BuyersRatePerSqMtr := (SalesLine."Buyer's Price" * SalesLine.Quantity / SQMt) + DecRate;
        END;
    end;

    //Unsupported feature: Property Deletion (CaptionML).

}

