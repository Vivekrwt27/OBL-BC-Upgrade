page 50215 "Prod. Reporting List"
{
    CardPageID = "Prod. Reporting Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Prod. Reporting Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Shift; Rec.Shift)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Order No. Series"; Rec."Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Prod. Units"; Rec."Prod. Units")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //15578 EVALUATE(gHour_Value, FORMAT(TIME, 0, '<Hours24,2>'));
        //IF NOT (gHour_Value IN [6,7,8,9,14,15]) THEN
        //IF NOT (gHour_Value IN [6, 7, 8, 9, 14, 15, 22, 23]) THEN
        //   ERROR('Not Allowed');

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE(Status,Status<>5);
        Rec.SETFILTER(Status, '<>5', Rec.Status);
    end;

    var
        gHour_Value: Decimal;
}

