tableextension 50145 tableextension50145 extends "Vendor Amount"
{
    fields
    {
        field(4; "SP Code"; Code[20])
        {
        }
        field(5; "Line No"; Integer)
        {
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Amount (LCY),Amount 2 (LCY),Vendor No."(Key)".

        /* key(Key2; "Vendor No.", "SP Code", "Amount (LCY)", "Amount 2 (LCY)", "Line No")
         {
             Clustered = true;
         }*/
    }
}

