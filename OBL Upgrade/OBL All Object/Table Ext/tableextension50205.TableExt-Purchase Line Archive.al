tableextension 50205 tableextension50205 extends "Purchase Line Archive"
{
    fields
    {


        field(50000; "Rejection Reason Code"; Code[20])
        {
            Description = 'Customization No. 10';
            TableRelation = "Return Reason";
        }
        field(50001; "Shortage Reason Code"; Code[20])
        {
            Description = 'Customization No. 10';
            TableRelation = "Return Reason";
        }
        field(50002; "Challan Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50003; "Actual Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50004; "Accepted Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50005; "Shortage Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50006; "Rejected Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50010; "Indent No."; Code[20])
        {
            Description = 'Customization No. 1 ND';
        }
        field(50011; "Indent Line No."; Integer)
        {
            Description = 'Customization No. 1 ND';
        }
        field(50012; Make; Text[30])
        {
        }
        field(50013; "Indent Date"; Date)
        {
            Description = 'Report 84 EXIM ravi';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                IF ("Ending Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50016; "Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                IF ("Starting Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50019; "Excise Amount Per Unit"; Decimal)
        {
            Description = 'ND';
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
    }


}

