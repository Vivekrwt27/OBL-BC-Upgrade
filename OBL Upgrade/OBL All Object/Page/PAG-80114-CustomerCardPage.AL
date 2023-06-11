page 79991 "Customer Creation Card App"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata 18 = rimd;
    Caption = 'Customer Creation Card app';
    SourceTable = 18;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }


                field("Virtual ID"; Rec."Virtual ID")
                {
                    ApplicationArea = all;
                }



            }
        }


    }



    /*  trigger OnInsertRecord(BelowxRec: Boolean): Boolean
         var
             VirtualNoSeriesMgt: Codeunit NoSeriesManagement;
         begin
             Rec."Creation Date" := Today;
             Rec."Created By" := UserId;
             IF rec."Virtual ID" = '' THEN BEGIN
                 rec."Virtual ID" := VirtualNoSeriesMgt.GetNextNo('VIRTUALID', 0D, TRUE);
             END;

         end; */


}