pageextension 50208 pageextension50208 extends "Items by Location"
{
    layout
    {

        addafter(ShowColumnName)
        {
            field("Show Item in Location"; Rec."Stockkeeping Unit Exists")
            {
                Caption = 'Show Item in Location';
                ApplicationArea = All;
            }
            field(Location; LocationFilter)
            {
                Lookup = false;
                TableRelation = Location;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //  SetColumns(MATRIX_SetWanted::Initial);
                    CurrPage.UPDATE(TRUE);
                end;
            }
        }
        addfirst(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }

        }
    }

    var
        LocationFilter: Code[30];

}

