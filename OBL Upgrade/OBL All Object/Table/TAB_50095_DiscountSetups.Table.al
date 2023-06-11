table 50095 "Discount Setups"
{

    fields
    {
        field(1; "Area Code"; Code[12])
        {
            TableRelation = "Matrix Master"."Type 2" WHERE("Mapping Type" = FILTER(City));
        }
        field(10; State; Code[10])
        {
            TableRelation = State.Code;
        }
        field(20; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(30; "Item Classification"; Code[20])
        {
            TableRelation = "Item Classification".Code;
        }
        field(50; "Manuf. Strategy"; Option)
        {
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO,Non Retain - Ex';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO,"Non Retain - Ex";
        }
        field(70; "PreApproved Discount"; Decimal)
        {
        }
        field(80; "Discount on Approval"; Decimal)
        {
        }
        field(100; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                CheckDateValidation;
            end;
        }
        field(110; "Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                CheckDateValidation;
            end;
        }
    }

    keys
    {
        key(Key1; "Area Code", State, "Customer No.", "Item Classification", "Manuf. Strategy", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure CheckDateValidation()
    begin
        IF ("Ending Date" = 0D) OR ("Starting Date" = 0D) THEN
            EXIT;
        IF "Ending Date" <= "Starting Date" THEN
            ERROR('Ending Date cannot be smaller than Starting Date');
    end;
}

