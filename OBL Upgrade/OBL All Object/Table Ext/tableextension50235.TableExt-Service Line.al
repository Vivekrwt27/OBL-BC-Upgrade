tableextension 50235 tableextension50235 extends "Service Line"
{
    fields
    {
        modify("Shipping Time")
        {
            Caption = 'Shipping Time';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        /*  modify("Excise Accounting Type")
          {
              OptionCaption = 'With CENVAT,Without CENVAT';
          }
          modify("VAT Type")
          {
              OptionCaption = ' ,Item,Capital Goods';
          }
          modify("Source Document Type")
          {
              OptionCaption = 'Posted Invoice,Posted Credit Memo';
          }*/

    }

}