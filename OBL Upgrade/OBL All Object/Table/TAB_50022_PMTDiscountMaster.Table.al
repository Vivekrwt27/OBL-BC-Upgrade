table 50022 "PMT Discount Master"
{

    fields
    {
        field(1; "PMT ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Lead ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Price Validaty"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; Location; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(170; "Creation Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(175; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(180; "PMT Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Order Qty."; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(200; "Despatch Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(210; "Remaining Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(211; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(212; "Cash Discount"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(213; "Project Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(214; Tolerance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(215; "First Inv Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(216; "Last Inv Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(217; "Total AD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(218; "Actual AD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(219; "Sales Return"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(220; "Ship To Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(221; "Ship To Pin"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(222; "PMT Creation Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(223; "Ship To Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(224; "Order Qty upto 310322"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(225; "Despatch Qty. 310322"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(226; "Contractor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(227; "Complete Description"; Text[110])
        {
            FieldClass = Normal;
        }
        field(228; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(229; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(230; State; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(231; Zone; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "PMT ID")
        {
            Clustered = true;
        }
        key(Key2; "Lead ID", Closed)
        {
        }
        key(Key3; Closed)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Creation Date & Time" := CURRENTDATETIME;
        "Created By" := USERID;
        "Remaining Qty." := "PMT Qty." + Tolerance;
    end;
}

