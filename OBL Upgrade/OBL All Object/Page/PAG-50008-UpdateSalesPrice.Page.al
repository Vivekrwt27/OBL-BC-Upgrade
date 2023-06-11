page 50008 "Update Sales Price"
{
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            field(StartingDate; StartingDate)
            {
                ApplicationArea = All;
            }
            field(EndingDate; EndingDate)
            {
                ApplicationArea = All;
            }
            field(Update; Update)
            {
                Caption = 'Update Existing Entries';
                ApplicationArea = All;
            }
            field("Item Classification"; "Item Classification")
            {
                TableRelation = "Item Classification";
                ApplicationArea = All;
            }
            field("Item No."; "Item No.")
            {
                TableRelation = Item;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF "Item Classification" = '' THEN;
                    Item.SETRANGE(Item."Item Classification", "Item Classification");
                    IF PAGE.RUNMODAL(Page::"Item List", Item) = ACTION::LookupOK THEN
                        "Item No." := Item."No.";
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Update")
            {
                Caption = '&Update';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ItemSalesPrice.SETFILTER(ItemSalesPrice."Starting Date", '%1..%2', StartingDate, EndingDate);
                    IF "Item Classification" <> '' THEN
                        ItemSalesPrice.SETRANGE(ItemSalesPrice."Item Classification No.", "Item Classification");
                    Window.OPEN('#1###############################/#2####################', Item."No.", ctr);
                    IF NOT ItemSalesPrice.FIND('-') THEN
                        ERROR('No record Exist') ELSE
                        REPEAT
                            Item.RESET;
                            Item.SETRANGE(Item."Item Classification", ItemSalesPrice."Item Classification No.");
                            IF "Item No." <> '' THEN
                                Item.SETRANGE(Item."No.", "Item No.");
                            IF Item.FIND('-') THEN
                                REPEAT
                                    Window.UPDATE;

                                    IF SalesPrice.GET(Item."No.", ItemSalesPrice."Sales Type", ItemSalesPrice."Sales Code", ItemSalesPrice."Starting Date",
                                      ItemSalesPrice."Currency Code", ItemSalesPrice."Variant Code", ItemSalesPrice."Unit of Measure Code",
                                      ItemSalesPrice."Minimum Quantity") THEN BEGIN
                                        IF Update = TRUE THEN BEGIN
                                            SalesPrice.VALIDATE(SalesPrice."Unit Price", ROUND(ItemSalesPrice."Unit Price", 0.01));
                                            SalesPrice.VALIDATE(SalesPrice."Price Includes VAT", ItemSalesPrice."Price Includes VAT");
                                            SalesPrice.VALIDATE(SalesPrice."Allow Invoice Disc.", ItemSalesPrice."Allow Invoice Disc.");
                                            SalesPrice.VALIDATE(SalesPrice."VAT Bus. Posting Gr. (Price)", ItemSalesPrice."VAT Bus. Posting Gr. (Price)");
                                            SalesPrice.VALIDATE(SalesPrice."Ending Date", ItemSalesPrice."Ending Date");
                                            SalesPrice.VALIDATE(SalesPrice."Allow Line Disc.", ItemSalesPrice."Allow Line Disc.");
                                            //15578    SalesPrice.VALIDATE(SalesPrice."MRP Price", ROUND(ItemSalesPrice.MRP, 0.01));
                                            SalesPrice.MODIFY(TRUE);
                                        END;
                                    END ELSE BEGIN

                                        /*  IF NOT SalesPrice.GET(Item."No.",ItemSalesPrice."Sales Type",ItemSalesPrice."Sales Code",ItemSalesPrice."Starting Date",
                                            ItemSalesPrice."Currency Code",ItemSalesPrice."Variant Code",ItemSalesPrice."Unit of Measure Code",
                                            ItemSalesPrice."Minimum Quantity") THEN   BEGIN
                                         */
                                        IF ItemSalesPrice."Unit of Measure Code" <> '' THEN
                                            IF NOT IUOM.GET(Item."No.", ItemSalesPrice."Unit of Measure Code") THEN BEGIN
                                                IUOM.INIT;
                                                IUOM.VALIDATE(IUOM."Item No.", Item."No.");
                                                IUOM.VALIDATE(IUOM.Code, ItemSalesPrice."Unit of Measure Code");
                                                IUOM.VALIDATE(IUOM."Qty. per Unit of Measure", 1);
                                                IUOM.INSERT(TRUE);
                                            END;
                                        insertsalesprice;
                                        ctr := ctr + 1;
                                        Window.UPDATE;


                                        //     IF ItemSalesPrice."Unit of Measure Code"='' THEN insertsalesprice;
                                    END;
                                UNTIL Item.NEXT = 0;
                        UNTIL ItemSalesPrice.NEXT = 0;
                    Window.CLOSE;
                    CurrPage.CLOSE;

                end;
            }
            action("Delete Data")
            {
                Caption = 'Delete Data';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Delete Sales Price Lines?', TRUE) THEN BEGIN
                        IF CONFIRM('Are you absolutely sure to delete Sales Price Lines?', TRUE) THEN BEGIN
                            SalesPrice.RESET;
                            SalesPrice.SETRANGE(SalesPrice."Starting Date", StartingDate, EndingDate);
                            SalesPrice.SETFILTER(SalesPrice."Can Delete", '%1', TRUE);
                            //    IF "Item No."<>'' THEN
                            //     SalesPrice.SETRANGE(SalesPrice."Item No.","Item No.");
                            IF SalesPrice.FIND('-') THEN BEGIN
                                Window1.OPEN('Item no. #2########/Sales Code #3########', SalesPrice."Item No.", SalesPrice."Sales Code");
                                REPEAT
                                    Window1.UPDATE(2, SalesPrice."Item No.");
                                    Window1.UPDATE(3, SalesPrice."Sales Code");
                                    //    IF "Item Classification"<>'' THEN BEGIN
                                    //     Item.GET(SalesPrice."Item No.");
                                    //   IF  Item."Item Classification"="Item Classification" THEN
                                    //     SalesPrice.DELETE(TRUE);
                                    // END ELSE
                                    SalesPrice.DELETEALL;
                                UNTIL SalesPrice.NEXT = 0;
                                Window1.CLOSE;
                            END ELSE BEGIN
                                ERROR('There is no data to delete.');
                            END;
                        END;
                    END;
                end;
            }
        }
    }

    var
        StartingDate: Date;
        EndingDate: Date;
        Update: Boolean;
        SalesPrice: Record "Sales Price";
        ItemSalesPrice: Record "Item Sales Price1";
        Window: Dialog;
        Item: Record Item;
        IUOM: Record "Item Unit of Measure";
        Window1: Dialog;
        ctr: Integer;
        "Item Classification": Code[10];
        "Item No.": Code[20];


    procedure insertsalesprice()
    begin
        SalesPrice.INIT;
        SalesPrice."Item No." := Item."No.";
        SalesPrice.VALIDATE(SalesPrice."Sales Type", ItemSalesPrice."Sales Type");
        SalesPrice.VALIDATE(SalesPrice."Sales Code", ItemSalesPrice."Sales Code");
        SalesPrice.VALIDATE(SalesPrice."Starting Date", ItemSalesPrice."Starting Date");
        SalesPrice.VALIDATE(SalesPrice."Currency Code", ItemSalesPrice."Currency Code");
        SalesPrice.VALIDATE(SalesPrice."Variant Code", ItemSalesPrice."Variant Code");
        SalesPrice.VALIDATE(SalesPrice."Unit of Measure Code", ItemSalesPrice."Unit of Measure Code");
        SalesPrice.VALIDATE(SalesPrice."Minimum Quantity", ItemSalesPrice."Minimum Quantity");
        SalesPrice.VALIDATE(SalesPrice."Price Includes VAT", ItemSalesPrice."Price Includes VAT");
        SalesPrice.VALIDATE(SalesPrice."Allow Invoice Disc.", ItemSalesPrice."Allow Invoice Disc.");
        SalesPrice.VALIDATE(SalesPrice."VAT Bus. Posting Gr. (Price)", ItemSalesPrice."VAT Bus. Posting Gr. (Price)");
        SalesPrice.VALIDATE(SalesPrice."Ending Date", ItemSalesPrice."Ending Date");
        SalesPrice.VALIDATE(SalesPrice."Allow Line Disc.", ItemSalesPrice."Allow Line Disc.");
        //15578    SalesPrice.VALIDATE(SalesPrice."MRP Price", ROUND(ItemSalesPrice.MRP, 0.01));
        //15578    SalesPrice.VALIDATE(SalesPrice.MRP, TRUE);
        SalesPrice.VALIDATE(SalesPrice."Can Delete", TRUE);
        SalesPrice.VALIDATE(SalesPrice."Unit Price", ROUND(ItemSalesPrice."Unit Price", 0.01));
        SalesPrice.VALIDATE(SalesPrice."Nepal Price", ROUND(ItemSalesPrice."Nepal Price", 0.01));
        SalesPrice.INSERT(TRUE);
    end;
}

