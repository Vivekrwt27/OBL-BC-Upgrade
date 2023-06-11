pageextension 50114 pageextension50114 extends "Cash Receipt Voucher"
{

    //Unsupported feature: Property Modification (PageType) on ""Cash Receipt Voucher"(Page 16579)".

    layout
    {
        moveafter("Document No."; "Location Code")
        moveafter("Applies-to Doc. Type"; AccountName)
    }

}

