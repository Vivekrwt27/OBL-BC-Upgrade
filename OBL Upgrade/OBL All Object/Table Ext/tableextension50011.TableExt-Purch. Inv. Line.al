tableextension 50011 tableextension50011 extends "Purch. Inv. Line"
{

    //Unsupported feature: Property Modification (Permissions) on ""Purch. Inv. Line"(Table 123)".

    fields
    {


        /*  modify("Custom eCess Amount")
          {
              Caption = 'Custom eCess Amount';
          }
          modify("Custom SHECess Amount")
          {
              Caption = 'Custom SHECess Amount';
          }*/ // 15578


        field(50000; "Rejection Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
        }
        field(50001; "Shortage Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
        }
        field(50002; "Challan Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50003; "Actual Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50004; "Accepted Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50005; "Shortage Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50006; "Rejected Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50010; "Indent No."; Code[20])
        {
            Description = 'Customization No. 1 ND';
        }
        field(50011; "Indent Line No."; Integer)
        {
            Description = 'Customization No. 1 ND';
        }
        field(50012; Make; Text[30])
        {
        }
        field(50013; "Indent Date"; Date)
        {
            Description = 'Report 84 EXIM ravi';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                IF ("Ending Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50016; "Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                IF ("Starting Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50019; "Excise Amount Per Unit"; Decimal)
        {
            DecimalPlaces = 2 : 4;
            Description = 'ND';
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
        field(50021; "Posting Date Header"; Date)
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            Description = 'Tri1.3 PG 10112006 -- Excise Batch';
            FieldClass = FlowField;
        }
        field(50025; "Source Order No."; Code[20])
        {
            Description = 'TRI S.K 030610';
        }
        field(50038; "Orient MRP"; Decimal)
        {
            Description = 'TRI V.D New Field Added';
            Editable = false;
        }
        field(50039; "Capex No."; Code[20])
        {
            Description = 'ori ut';
            // 15578 TableRelation = "Budget Master";
        }
        field(50040; "PO Date"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Order Date" WHERE("No." = FIELD("Source Order No.")));
            FieldClass = FlowField;
        }
        field(50041; "Form 38 No."; Code[20])
        {
            // 15578 CalcFormula = Lookup("Purch. Rcpt. Header"."Form 38 No." WHERE ("No."=FIELD("Receipt Document No.")));
            // FieldClass = FlowField;
        }
        field(50049; "ITC Type"; Option)
        {
            OptionCaption = ' ,Input Goods,Input Servce,Input Capital Goods,NON ITC';
            OptionMembers = " ","Input Goods","Input Servce","Input Capital Goods","NON ITC";
        }
        field(50050; "PO No."; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Buy-from Vendor No." = FIELD("Buy-from Vendor No."),
                                                         "Document Type" = CONST(Order));
        }
        field(60028; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            // 15578  TableRelation = "NOE Permission".NOE WHERE (Location=FIELD("Location Code"));
        }
    }
    keys
    {

        //Unsupported feature: Property Modification (SumIndexFields) on ""Document No.,Line No."(Key)".

        /* key(Key7;"Form No.")
         {
         }*/ // 15578
        key(Key8; "Document No.", Type)
        {
        }
        key(Key9; "No.", "Buy-from Vendor No.", "Posting Date")
        {
        }
        key(Key10; "No.", "Posting Date")
        {
        }
    }

    //Unsupported feature: Property Deletion (CaptionML).

}

