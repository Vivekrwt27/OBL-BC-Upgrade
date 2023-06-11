tableextension 50116 tableextension50116 extends "Gate Entry Header"
{
    fields
    {
        field(50000; "Reporting Date"; Date)
        {
            Description = '//Ori Ut 270710';
            Editable = true;
        }
        field(50001; "Reporting Time"; Time)
        {
            Description = '//Ori Ut 270710';
            Editable = true;
        }
        field(50002; "Vehicle In Time"; DateTime)
        {
            Description = '//Ori Ut 270710';
        }
        field(50003; "Vehicle Out Time"; DateTime)
        {
            Description = '//Ori Ut 270710';
        }
        field(50004; "Vendor No"; Code[20])
        {
            Description = '//Ori Ut 270710';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                VENDOR.GET("Vendor No");
                "Vendor Name" := VENDOR.Name;
            end;
        }
        field(50005; "Vendor Name"; Text[50])
        {
            Description = '//Ori Ut 270710';
        }
    }
    trigger OnBeforeInsert()// 15578
    begin
        //UPGRADE(+)
        "Reporting Date" := WORKDATE;
        "Reporting Time" := TIME;
        //UPGRADE(-)

    end;



    var
        VENDOR: Record Vendor;
}

