report 50403 "Update Item UOM"
{

    Caption = 'Update Item UOM';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;


    dataset
    {
        dataitem(Item; Item)
        {

            trigger
            OnAfterGetRecord()
            begin
                Item.Validate("Base Unit Of Measure New", Item."Base Unit of Measure");
                Item.Modify;
            end;


            trigger OnPostDataItem()
            begin
                Message('Done');
            end;


        }


    }
    var


}

