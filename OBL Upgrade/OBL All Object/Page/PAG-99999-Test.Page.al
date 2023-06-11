page 99999 Test
{
    PageType = Card;
    SourceTable = Test;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; rec.No)
                {
                    ApplicationArea = All;
                }
                field(Desc; Rec.Desc)
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(City; rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Balance; rec.Balance)
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
}

