tableextension 50168 tableextension50168 extends "Tax Jurisdiction"
{
    // 
    // TRI RK 21.04.10 - Two new field Created for Report purpose
    fields
    {
        field(50000; "Additional Tax"; Boolean)
        {
            Description = 'TRI RK';
        }
        field(50001; Surcharge; Boolean)
        {
            Description = 'TRI RK';
        }
    }
}

