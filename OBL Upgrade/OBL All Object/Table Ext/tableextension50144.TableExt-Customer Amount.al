tableextension 50144 tableextension50144 extends "Customer Amount"
{
    fields
    {
        field(4; "SP Code"; Code[20])
        {
        }
        field(5; "SNo."; Integer)
        {
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Amount (LCY),Amount 2 (LCY),Customer No."(Key)".

        /* key(Key2; "SNo.", "SP Code", "Amount 2 (LCY)", "Amount (LCY)", "Customer No.")
         {
             Clustered = true;
         }*/
    }
}

