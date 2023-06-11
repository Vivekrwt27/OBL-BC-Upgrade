tableextension 50280 tableextension50280 extends "Production Forecast Name"
{
    // 1.TRI S.R 220310 - New code Added
    fields
    {
        field(50000; Status; Option)
        {
            OptionCaption = 'Open,Authorization1,Authorization2,Authorized,Closed';
            OptionMembers = Open,Authorization1,Authorization2,Authorized,Closed;
        }
        field(50001; "Forecast Type1"; Option)
        {
            OptionCaption = 'Sales,Production';
            OptionMembers = Sales,Production;
        }
    }

    var
        ErrText001: Label 'You can not Delete or Change the Forcast Name. ';
}

