pageextension 50233 pageextension50233 extends "Purchase Order Archive"
{
    layout
    {

    }

    var
        [InDataSet]
        "Version No.Visible": Boolean;

    trigger OnOpenPage()
    begin
        //Pr Start Tri1.0
        "Version No.Visible" := FALSE;    //Code Commented as it is not working
                                          //Pr End Tri1.0
    end;

}

