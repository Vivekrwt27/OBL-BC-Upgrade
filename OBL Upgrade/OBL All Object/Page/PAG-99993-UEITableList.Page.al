/* page 99993 "UEI - Table List"
{
    // //
    // // Universal Excel Importer
    // // (c) 2006-2008 Slawek Guzek, sguzek@onet.pl
    // //

    //The property 'Caption' cannot be empty.
    //Caption = '';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Object;
    SourceTableView = SORTING(Type, "Company Name", ID)
                      WHERE(Type = CONST(Table));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field(ID; rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Caption; rec.Caption)
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
        CurrPage.LOOKUPMODE := TRUE;
    end;


    procedure GetTableNo(): Integer
    begin
        EXIT(REC.ID);
    end;
}
 */
