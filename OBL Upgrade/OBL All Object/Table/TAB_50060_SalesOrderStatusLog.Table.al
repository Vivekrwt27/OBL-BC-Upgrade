table 50060 "Sales Order Status Log"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit Approved,Price Approved,Inventory Approved,All Clear';
            OptionMembers = " ","Credit Approved","Price Approved","Inventory Approved","All Clear";
        }
        field(20; "Change Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Users ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Clear Release"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Order Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Elapse Time"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Manual; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Credit Approved Time"; DateTime)
        {
            CalcFormula = Lookup("Sales Order Status Log"."Change Datetime" WHERE("Sales Order No." = FIELD("Sales Order No."),
                                                                                   Status = FILTER("Credit Approved")));
            FieldClass = FlowField;
        }
        field(52; "Price Approved Time"; DateTime)
        {
            CalcFormula = Lookup("Sales Order Status Log"."Change Datetime" WHERE("Sales Order No." = FIELD("Sales Order No."),
                                                                                   Status = FILTER("Price Approved")));
            FieldClass = FlowField;
        }
        field(53; "Inventory Approved Time"; DateTime)
        {
            CalcFormula = Lookup("Sales Order Status Log"."Change Datetime" WHERE("Sales Order No." = FIELD("Sales Order No."),
                                                                                   Status = FILTER("Inventory Approved")));
            FieldClass = FlowField;
        }
        field(54; "All ClearTime"; DateTime)
        {
            CalcFormula = Lookup("Sales Order Status Log"."Change Datetime" WHERE("Sales Order No." = FIELD("Sales Order No."),
                                                                                   Status = FILTER("All Clear")));
            FieldClass = FlowField;
        }
        field(55; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56; Zone; Text[13])
        {
            CalcFormula = Lookup(Customer."Tableau Zone" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(57; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60094; "Credit Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60095; "Inventory Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60096; "Price Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60097; Processed; Boolean)
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
        key(Key2; "Sales Order No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Sales Order No.") THEN BEGIN
            "Order Date & Time" := SalesHeader."Order Booked Date";
            //IF SalesHeader."Order Date" >= 071022D THEN;
            IF "Order Date & Time" <> 0DT THEN
                "Elapse Time" := ROUND((CURRENTDATETIME - "Order Date & Time") / 60000, 2);
        END;
    end;

    trigger OnModify()
    begin
        IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Sales Order No.") THEN BEGIN
            "Order Date & Time" := SalesHeader."Order Booked Date";
            //IF SalesHeader."Order Date" >= 071022D THEN;
            IF "Order Date & Time" <> 0DT THEN
                "Elapse Time" := ROUND((CURRENTDATETIME - "Order Date & Time") / 60000, 2);
        END;
    end;

    var
        SalesHeader: Record "Sales Header";
}

