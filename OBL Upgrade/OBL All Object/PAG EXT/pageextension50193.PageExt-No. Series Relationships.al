pageextension 50193 pageextension50193 extends "No. Series Relationships"
{
    layout
    {
        addafter("Series Code")
        {
            field(Location; Rec.Location)
            {
                ApplicationArea = all;
            }
            field(type; Rec.type)
            {
                ApplicationArea = all;
            }
        }

    }

    procedure GetSeriesCode() SalesOrderNo: Code[20]
    begin
        SalesOrderNo := Rec."Series Code";
    end;
}

