table 50064 "Item-Customer Group Discount"
{
    //16225 Permissions = TableData 99979 = rimd;

    fields
    {
        field(5; "Customer Group"; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(10; "Item Group"; Option)
        {
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
        }
        field(15; "Discount Percentage"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Customer Group", "Item Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

