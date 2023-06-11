page 50093 tms_so_data
{
    PageType = List;
    SourceTable = "TMS Data";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SO_Number; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field(SO_Date_n_time; Rec."Make Order Date")
                {
                    ApplicationArea = All;
                }
                field(Buyer_Name; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field(Ship_to_City; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field(From_Plant_Name; Rec."From Plant Name")
                {
                    ApplicationArea = All;
                }
                field(Total_Load_Kg; Rec."Total Load(KG)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Loading_officer; Rec."Loading Officer")
                {
                    ApplicationArea = All;
                }
                field(Transport_Method; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field(Releasing_Date; Rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field(Quantity_in_SqMt; Rec."Quantity in SqMt.")
                {
                    ApplicationArea = All;
                }
                field(Outstanding_Quantity; Rec."Outstanding Qty.")
                {
                    ApplicationArea = All;
                }
                field(Sum_Quantity_Invoiced; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field(Shipped_Load_kg; Rec."Gross Wt. Shipped")
                {
                    ApplicationArea = All;
                }
                field(Balance_Load_KG; Rec."Gross Wt. Outstanding")
                {
                    ApplicationArea = All;
                }
                field(Sales_Officer_no; Rec."Sales Person MobileNo.")
                {
                    ApplicationArea = All;
                }
                field(Sales_officer_Name; Rec."Sales Person Name")
                {
                    ApplicationArea = All;
                }
                field(Customer_Type; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field(Ship_to_State; Rec."Ship to State Description")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field(From_Plant_City; From_Plant_City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Location.GET(Rec."From Plant Name") THEN
            From_Plant_City := Location.City;
    end;

    trigger OnOpenPage()
    begin

        Rec.SETFILTER("Releasing Date", '%1..', TODAY() - 10);
    end;

    var
        Location: Record Location;
        From_Plant_City: Text[30];
}

