page 50233 "Forcast SubPage"
{
    PageType = ListPart;
    SourceTable = "Branch Wise focused Prod IBOT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                //16225 table field N/F
                /*   field("Source No."; "Source No.")
                   {
                   }
                   field(Description; Description)
                   {
                   }
                   field(Quantity; Quantity)
                   {
                   }
                   field("Forcast Quantity"; "Forcast Quantity")
                   {
                   }
                   field("Manually Changed"; "Manually Changed")
                   {
                   }*/
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("BOM Details")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ShowBOMDetails;//16225 Funcation N/F
                end;
            }
        }
    }
}

