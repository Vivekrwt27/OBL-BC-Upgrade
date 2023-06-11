table 99920 Test
{

    fields
    {
        field(1; No; Code[10])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF RecVend.GET(No) THEN
                    Desc := RecVend.Name;
                City := RecVend.City;
                Balance := RecVend.Balance;
                outamt.CALCSUMS(Amount);
                amt := outamt.Amount;
            end;
        }
        field(2; Desc; Text[30])
        {
        }
        field(3; City; Text[30])
        {
        }
        field(4; Balance; Decimal)
        {
        }
        field(5; Outstanding; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecVend: Record Vendor;
        outamt: Record "Cust. Ledger Entry";
        amt: Decimal;
}

