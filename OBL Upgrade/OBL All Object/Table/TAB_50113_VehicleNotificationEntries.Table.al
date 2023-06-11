table 50113 "Vehicle Notification  Entries"
{

    fields
    {
        field(1; "Primary Key"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sales Order No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
        }
        field(20; "Sales Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Releasing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(50; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "No. of Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Zonal Manager"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Branch Head"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Zonal Head"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(100; Salesperson; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(110; CSO; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Mail Send Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Mail Send Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Primary Key" := CREATEGUID;
        "Mail Send Date" := TODAY;
        "Mail Send Time" := TIME;
    end;
}

