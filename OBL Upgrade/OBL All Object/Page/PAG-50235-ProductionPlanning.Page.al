page 50235 "Production Planning"
{
    // `

    PageType = List;
    Permissions = TableData 50006 = rimd;
    SourceTable = 50006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; rec."Location Code")
                {
                }
                field("Item No"; rec."Item No")
                {
                }
                field(Date; rec.Date)
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Manuf. Stategy"; rec."Manuf. Stategy")
                {
                }
                field("Avg. Sales"; rec."Avg. Sales")
                {
                }
                field("Production  Plan in sqm"; rec."Production  Plan in sqm")
                {
                }
                field(Size; rec.Size)
                {
                }
                field(WMD; Rec.WMD)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF (UPPERCASE(USERID) <> 'FA017') AND (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'FA015') AND (UPPERCASE(USERID) <> 'FA028') THEN
            ERROR('You are not authorized to run this page');
    end;
}

