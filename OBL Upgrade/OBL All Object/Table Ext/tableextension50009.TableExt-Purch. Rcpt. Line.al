tableextension 50009 tableextension50009 extends "Purch. Rcpt. Line"
{
    fields
    {


        /* modify("Excise Refund")
         {
             Caption = 'Excise Refund';
         }
         modify("CWIP G/L Type")
         {
             Caption = 'CWIP G/L Type';
             OptionCaption = ' ,Labor,Material,Overheads';
         }*/


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
        field(50004; "Accepted Qunatity"; Decimal)
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
        field(50008; City; Text[30])
        {
            Description = 'Customization No. 9 from Header(Buy-from City)';
        }
        field(50009; "Posting Date2"; Date)
        {
            Description = 'Customization No. 9';
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
                //Vipul Tri1.0
                IF ("Ending Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50016; "Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
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
            Caption = 'Posting Date';
            Editable = true;
        }
        field(50021; "Posting Date Head"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            Caption = 'Posting Date';
            Description = 'TRI55.9PG 24112006';
            FieldClass = FlowField;
        }
        field(50024; "Vendor Invoice No."; Code[20])
        {
            Description = 'TRI A.S';
        }
        field(50025; Name; Text[200])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Buy-from Vendor No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; Mailed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Orient MRP"; Decimal)
        {
            Description = 'TRI V.D New Field Added';
            Editable = false;
        }
        field(50039; "Capex No."; Code[20])
        {
            Description = 'Ori Ut';
            TableRelation = "Budget Master"."Posting No.";
        }
        field(50040; "Store rejection No."; Code[20])
        {
        }
        field(50041; "Store Rejection Date"; Date)
        {
        }
        field(50042; "Ref. Rate"; Decimal)
        {
        }
        field(50043; "Possible Cenvat"; Decimal)
        {
        }
        field(50047; "Batch No."; Code[15])
        {
        }
        field(60050; "Invoice Created"; Boolean)
        {
            Description = 'MSVRN 211117';
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document No.,Line No."(Key)".

        key(Key8; "Buy-from Vendor No.", "Document No.", Type, "No.")
        {
        }
        key(Key9; "No.")
        {
        }
        key(Key10; "Pay-to Vendor No.", "Posting Date")
        {
        }
        key(Key11; "Indent No.", "Indent Line No.")
        {
        }
    }
    var
        PurchaseHeader: Record "Purchase Header";
}

