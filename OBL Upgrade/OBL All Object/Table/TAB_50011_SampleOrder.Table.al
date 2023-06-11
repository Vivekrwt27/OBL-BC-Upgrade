table 50011 "Sample Order"
{
    Description = 'Customization No. 15';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF Item.GET("Item No.") THEN
                    "Item Description" := Item."Description";
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF "Customer".GET("Customer No.") THEN
                    "Customer Name" := Customer.Name;
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; "Unit Of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(6; "SO No."; Code[10])
        {
        }
        field(7; "SO Date"; Date)
        {
        }
        field(8; "SO Created"; Boolean)
        {
        }
        field(9; "Item Description"; Text[30])
        {
        }
        field(10; "Customer Name"; Text[30])
        {
        }
        field(11; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(12; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Item No.", Date)
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Customer No.", Date)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Customer: Record Customer;
}

