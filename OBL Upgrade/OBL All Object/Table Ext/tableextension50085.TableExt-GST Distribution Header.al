tableextension 50085 tableextension50085 extends "GST Distribution Header"
{
    fields
    {
        modify("No.")
        {
            Caption = 'No.';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("No. Series")
        {
            Caption = 'No. Series';
        }
        modify("Creation Date")
        {
            Caption = 'Creation Date';
        }
        modify("User ID")
        {
            Caption = 'User ID';
        }
        modify(Reversal)
        {
            Caption = 'Reversal';
        }
    }
    var
        UpdateDimErr: Label 'You may have changed a dimension.Do you want to update the lines?';
}

