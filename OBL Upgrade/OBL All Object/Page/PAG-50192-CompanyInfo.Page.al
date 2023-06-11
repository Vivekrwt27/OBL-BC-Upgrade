page 50192 CompanyInfo
{
    PageType = CardPart;
    SourceTable = "Company Information";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("."; Rec.Picture)
                {
                    Caption = '.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

