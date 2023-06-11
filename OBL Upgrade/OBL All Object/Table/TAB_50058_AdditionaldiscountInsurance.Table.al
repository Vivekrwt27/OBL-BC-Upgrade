table 50058 "Additional discount Insurance"
{

    fields
    {
        field(50010; RecId; Integer)
        {
            AutoIncrement = true;
        }
        field(50011; CustId; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                cCust.RESET;
                //cCust.SETFILTER(cCust."Customer Type", '%1|%2', 'Dealer', 'Distributor');//16225 customer type N/F
                cCust.SETRANGE(cCust."No.", CustId);
                IF NOT cCust.FIND('-') THEN
                    ERROR('Customer not found. Must be Dealer Or Distributor');
            end;
        }
        field(50012; "Cust Name"; Text[40])
        {
        }
        field(50013; cType; Option)
        {
            OptionMembers = Insurance;
        }
        field(50014; cAmount; Decimal)
        {
        }
        field(50015; cFlag; Text[10])
        {
            InitValue = 'INITIAL';
        }
        field(50016; cDate; Date)
        {
        }
        field(50018; "Remaining Amount"; Decimal)
        {
        }
        field(50019; cRecRefId; Integer)
        {
        }
        field(50020; "Amount paid"; Decimal)
        {
        }
        field(50021; cDescription; Text[250])
        {
        }
        field(50023; AmountToGive; Boolean)
        {

            trigger OnValidate()
            begin
                IF FORMAT(USERID) <> 'fa007' THEN
                    ERROR('No Access');
            end;
        }
    }

    keys
    {
        key(Key1; RecId)
        {
            Clustered = true;
        }
        key(Key2; CustId, cAmount, cDate)
        {
        }
    }

    fieldgroups
    {
    }

    var
        cCust: Record Customer;
}

