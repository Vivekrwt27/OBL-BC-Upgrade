pageextension 50448 pageextension50448 extends "Purchase Return Order Subform"
{
    layout
    {
        /*modify("Control 1500017")//16225 N/F field 
        {
            Visible = false;
        }*/
        addafter("VAT Prod. Posting Group")
        {
            /*  field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
             {
                 ApplicationArea = All;
             } */
        }
        moveafter(Quantity; "Tax Group Code", "Description 2", "Tax Area Code")
        addafter(Quantity)
        {
            /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")//16225 N/F field 
             {
             }*/
            field("Excise Amount Per Unit"; Rec."Excise Amount Per Unit")
            {
                ApplicationArea = All;
            }

            /* field("Capital Item"; "Capital Item")//16225 N/F field 
             {
             }
             field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")//16225 N/F field 
             {
             }*/

            /*field("Form Code"; "Form Code")//16225 N/F field 
            {
            }*/

            /* field("GST %"; "GST %")//16225 N/F field 
             {
             }
             field("TDS Nature of Deduction"; "TDS Nature of Deduction")//16225 N/F field 
             {
             }*/
        }
    }

    var
        PurchHeader: Record "Purchase Header";
}

