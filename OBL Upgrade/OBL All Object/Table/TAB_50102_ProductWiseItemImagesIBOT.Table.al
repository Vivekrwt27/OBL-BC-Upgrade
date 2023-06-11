table 50102 "Product Wise Item Images IBOT"
{

    fields
    {
        field(1; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;

            trigger OnLookup()
            begin
                "Updation Date" := TODAY;
            end;

            trigger OnValidate()
            begin
                "Updation Date" := TODAY;
            end;
        }
        field(2; "Product Image"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Updation Date" := TODAY;
            end;
        }
        field(3; "Product Information"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Updation Date" := TODAY;
            end;
        }
        field(4; "Updation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Updation Date" := TODAY;
            end;
        }
    }

    keys
    {
        key(Key1; "Item Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Updation Date" := TODAY;
    end;

    trigger OnModify()
    begin
        "Updation Date" := TODAY;
    end;

    var
        Recvend: Record "Transport Method";
}

