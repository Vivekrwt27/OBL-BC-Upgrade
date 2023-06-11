page 50234 "Forcast Bom Details"
{
    PageType = List;
    SourceTable = "Item Details - IBOT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /* field("Source No."; "Source No.") //16225 table Field N/F
                 {
                 }*/
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                //16225 table Field N/F start
                /*field("RM Code"; "RM Code")
                {
                }
                field("BOM Quantity"; "BOM Quantity")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Forcast Quantity"; "Forcast Quantity")
                {
                }*///16225 table Field N/F End
            }
        }
    }

    actions
    {
    }
}

