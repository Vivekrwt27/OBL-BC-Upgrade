pageextension 50279 pageextension50279 extends "Posted Transfer Rcpt. Subform"
{

    layout
    {
        moveafter("Variant Code"; Amount)
        moveafter("Variant Code"; Description)
        addafter("Variant Code")
        {
            /*  field(Amount; Rec.Amount)//16225 move Field 
              {
              }
              field(Description; Rec.Description)//16225 Move Field
              {
              }*/
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
            }
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {
                ApplicationArea = All;
            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}

