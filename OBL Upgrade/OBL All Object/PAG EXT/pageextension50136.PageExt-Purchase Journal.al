pageextension 50136 pageextension50136 extends "Purchase Journal"
{
    layout
    {

        moveafter("Account No."; "Nature of Remittance", "Act Applicable")
    }
    actions
    {
        modify("Apply Provisional Entry")
        {
            Visible = false;
        }
    }

}

