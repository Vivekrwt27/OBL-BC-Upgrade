page 50255 "Wharehouse Inv Management"
{
    ApplicationArea = all;
    UsageCategory = Lists;
    PageType = List;
    Permissions = TableData 50093 = rimd;
    SourceTable = 50093;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("item Code"; rec."item Code")
                {
                }
                field("Complete Desc"; rec."Complete Desc")
                {
                    Editable = false;
                }
                field(Location; rec.Location)
                {
                }
                field("Batch No."; rec."Batch No.")
                {
                }
                field("WH Loc"; rec.Inv_Location)
                {
                }
                field(Qty; rec.Qty)
                {
                }
                field(Utilize; rec.Utilize)
                {
                    Editable = false;
                }
                field(Remaining; rec.Remaining)
                {
                    Editable = false;
                }
                field("MFG Date"; rec."MFG Date")
                {
                }
                field("Loading Qty"; rec."Loading Qty")
                {
                }
                field(Size; rec.size)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Release Loading Qty.")
            {
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Do you want to Release Loading Qty.', FALSE) THEN EXIT;
                    WarehouseInvManement.RESET;
                    CurrPage.SETSELECTIONFILTER(WarehouseInvManement);
                    IF WarehouseInvManement.COUNT > 0 THEN BEGIN
                        IF WarehouseInvManement.FINDFIRST THEN
                            REPEAT
                                WarehouseInvManement."Loading Qty" := 0;
                                WarehouseInvManement.MODIFY;
                            UNTIL WarehouseInvManement.NEXT = 0;
                    END;
                end;
            }
        }
    }

    var
        WarehouseInvManement: Record 50093;
}

