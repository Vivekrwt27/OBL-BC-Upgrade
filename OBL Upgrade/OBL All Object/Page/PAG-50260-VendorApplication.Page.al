page 50260 "Vendor Application"
{
    Editable = false;
    PageType = List;
    SourceTable = "Item Application Entry";
    SourceTableView = WHERE("Out Bond Entries" = FILTER(<> ''),
                            "Item Code1" = CONST('*W'),
                            "Posting Date" = FILTER('>=04/01/19'));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("MRN No,"; rec."In Bond Entries")
                {
                    ApplicationArea = All;
                }
                field("Vend Name"; rec."Vend Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Cust Name")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; rec."Item Code1")
                {
                    ApplicationArea = All;
                }
                field("Sales Invoice No."; rec."Out Bond Entries")
                {
                    ApplicationArea = All;
                }
                field("Despatch Location"; rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
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
        IF UPPERCASE(USERID) <> 'SC002' THEN
            ERROR('You are not Allowed');
    end;
}

