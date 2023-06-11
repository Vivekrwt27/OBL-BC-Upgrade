page 80107 "Select Companies"
{
    // Data Transfer Wizard 4.0 (Navision) Eduard Sanosian, The Netherlands, 08-2006

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    // SourceTable = 80106;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            /*   repeater(GROUP)
               {
                   field(Company; Company)
                   {
                       Editable = false;
                       ApplicationArea = All;
                   }
                   field(Selected; Selected)
                   {
                       ApplicationArea = All;
                   }
               }*/
        }
    }

    actions
    {
        area(navigation)
        {
            group(Selection)
            {
                Caption = 'Selection';
                action("Select All")
                {
                    Caption = 'Select All';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        i: Integer;
                    begin
                        /*   CurrPage.SETSELECTIONFILTER(Rec);
                           i := COUNT;
                           IF i = 1 THEN RESET;
                           MODIFYALL(Selected, TRUE);
                           RESET;*/
                    end;
                }
                action("Release All")
                {
                    Caption = 'Release All';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        i: Integer;
                    begin
                        /*  CurrPage.SETSELECTIONFILTER(Rec);
                          i := COUNT;
                          IF i = 1 THEN RESET;
                          MODIFYALL(Selected, FALSE);
                          RESET;*/
                    end;
                }
            }
        }
    }
}

