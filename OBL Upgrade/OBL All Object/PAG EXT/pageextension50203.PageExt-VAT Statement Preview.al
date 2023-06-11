pageextension 50203 pageextension50203 extends "VAT Statement Preview"
{
    layout
    {
        addfirst(content)
        {
            field("Statement Template Name"; Rec."Statement Template Name")
            {
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
        }
    }
}

