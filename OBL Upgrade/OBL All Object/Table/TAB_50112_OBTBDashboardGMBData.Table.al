table 50112 "OBTB Dashboard GMB Data"
{

    fields
    {
        field(1; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF Customer.GET("Customer No") THEN
                    "Customer Name" := Customer.Name;
                "Salesperson Code" := Customer."Salesperson Code";
                IF SalespersonPurchaser.GET("Salesperson Code") THEN
                    "Salesperson Description" := SalespersonPurchaser.Name;

                "PCH Code" := Customer."PCH Code";
                IF SalespersonPurchaser.GET("PCH Code") THEN
                    "PCH Name" := SalespersonPurchaser.Name;

                "Zonal Manager" := Customer."Zonal Manager";
                IF SalespersonPurchaser.GET("Zonal Manager") THEN
                    Zonal_Manager := SalespersonPurchaser.Name;

                "Zonal Head" := Customer."Zonal Head";
                IF SalespersonPurchaser.GET("Zonal Head") THEN
                    Zonal_Head := SalespersonPurchaser.Name;
            end;
        }
        field(3; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Salesperson Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "PCH Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "PCH Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Zonal Manager"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Zonal_Manager; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Zonal Head"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Zonal_Head; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Total Views"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Direction Actions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Phone call Actions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Date, "Customer No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF Customer.GET("Customer No") THEN
            "Customer Name" := Customer.Name;
        "Salesperson Code" := Customer."Salesperson Code";
        IF SalespersonPurchaser.GET("Salesperson Code") THEN
            "Salesperson Description" := SalespersonPurchaser.Name;

        "PCH Code" := Customer."PCH Code";
        IF SalespersonPurchaser.GET("PCH Code") THEN
            "PCH Name" := SalespersonPurchaser.Name;

        "Zonal Manager" := Customer."Zonal Manager";
        IF SalespersonPurchaser.GET("Zonal Manager") THEN
            Zonal_Manager := SalespersonPurchaser.Name;

        "Zonal Head" := Customer."Zonal Head";
        IF SalespersonPurchaser.GET("Zonal Head") THEN
            Zonal_Head := SalespersonPurchaser.Name;
    end;

    var
        Customer: Record Customer;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
}

