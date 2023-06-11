pageextension 50001 pageextension50001 extends "Company Information"
{
    layout
    {
        addafter(Address)
        {
            field("IC Gen. Bus. Posting Group"; rec."IC Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Home Page")
        {
            field(Picture1; rec.Picture1)
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Registration No.")
        {
            field("T.I.N No. w.e.f"; rec."T.I.N No. w.e.f")
            {
                ApplicationArea = All;
            }
        }
        addafter(Picture)
        {
            field("IDFC Bank Out Folder"; Rec."IDFC Bank Out Folder")
            {
                ApplicationArea = All;
            }
        }
        addafter(Picture)
        {
            field("IDFC Bank In Folder"; Rec."IDFC Bank In Folder")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Ward No."; "Deductor Category")
    }
}

