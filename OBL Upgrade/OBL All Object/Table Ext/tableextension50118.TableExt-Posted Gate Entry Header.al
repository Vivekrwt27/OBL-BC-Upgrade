tableextension 50118 tableextension50118 extends "Posted Gate Entry Header"
{
    fields
    {
        field(50000; "Reporting Date"; Date)
        {
        }
        field(50001; "Reporting Time"; Time)
        {
        }
        field(50002; "Vehicle In Time"; DateTime)
        {
        }
        field(50003; "Vehicle Out Time"; DateTime)
        {
        }
        field(50004; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50005; "Vendor Name"; Text[50])
        {
        }
    }
}

