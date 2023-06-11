page 50090 "Sales BO Archive Subform"
{
    Caption = 'Sales Order Archive Subform';
    PageType = Card;
    SourceTable = "Branch Wise focused Prod IBOT";
    //  SourceTableView = WHERE("Item No." = CONST(4));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                //  field("Location Filter"; Rec."Location Filter")
                //{
                //  ApplicationArea = All;
                // }
            }
            //  field("Variant Code"; Rec."Variant Code")
            //{
            //  Visible = false;
            //ApplicationArea = All;
            //}

        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50091. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLinesArchive.FORM.*/
                        _ShowDimensions;

                    end;
                }
            }
        }
    }


    procedure _ShowDimensions()
    begin
        ShowDimensions;
    end;


    procedure ShowDimensions()
    begin
        ShowDimensions;
    end;
}

