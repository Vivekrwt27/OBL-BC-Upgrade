page 99992 "UEI - Field Choose"
{
    // //
    // // Universal Excel Importer
    // // (c) 2006-2008 Slawek Guzek, sguzek@onet.pl
    // //

    Caption = 'Choose target field';
    Editable = false;
    PageType = Card;
    SourceTable = Field;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(FieldName; rec.FieldName)
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; rec."Field Caption")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Len; rec.Len)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

