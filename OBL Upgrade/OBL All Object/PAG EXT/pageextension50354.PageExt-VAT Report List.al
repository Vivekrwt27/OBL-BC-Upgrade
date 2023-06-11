pageextension 50354 pageextension50354 extends "VAT Report List"
{
    Caption = 'VAT Report List';
    layout
    {


    }
    actions
    {
        modify("Create From VAT Return Period")
        {
            Visible = false;
        }


        modify("Open VAT Return Period Card")
        {
            Visible = false;
        }
        modify("Report Setup")
        {
            Visible = false;
        }
    }


}

