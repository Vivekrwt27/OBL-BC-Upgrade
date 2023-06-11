pageextension 50277 pageextension50277 extends "Posted Transfer Shpt. Subform"
{


    layout
    {
        moveafter(Description; Amount)
        addafter(Description)
        {
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            /* field("Unit Cost"; "Unit Cost")//16225 Table Field N/F
             {
             }*/
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            /*    field(MRP; MRP)//16225 Table Field N/F
                {
                }*/
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            /*  field("MRP Price"; "MRP Price")//16225 Table Field N/F
              {
              }
              field("Excise Amount"; "Excise Amount")
              {
              }
              field("BED Amount"; "BED Amount")
              {
              }
              field("Charges to Transfer"; "Charges to Transfer")
              {
              }*/
            /*  field(Amount; Rec.Amount)
              {
              }*/
            //16225 Table Field N/F
            /*  field("SHE Cess Amount"; "SHE Cess Amount")
              {
              }
              field("eCess Amount"; "eCess Amount")
              {
              }*/
        }
        addafter("Gross Weight")
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Customer Code"; Rec."Customer Code")
            {
                ApplicationArea = All;
            }
            field("Requested by"; Rec."Requested by")
            {
                ApplicationArea = All;
            }
        }
    }
}

