pageextension 50337 pageextension50337 extends "Purchase Prices"
{
    layout
    {
        addafter("Ending Date")
        {
            field(Description; Description)
            {
                ApplicationArea = All;
            }
            field(PaymentTerms; Rec.PaymentTerms)
            {
                ApplicationArea = All;
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
            }
            field("Excise %"; Rec."Excise %")
            {
                ApplicationArea = All;
            }
            field("VAT %"; Rec."VAT %")
            {
                ApplicationArea = All;
            }
            field("Sales Tax %"; Rec."Sales Tax %")
            {
                ApplicationArea = All;
            }
            field("Charges %"; Rec."Charges %")
            {
                ApplicationArea = All;
            }
            field("Other Taxes %"; Rec."Other Taxes %")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(CopyPrices)
        {
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PurchasePriceRec.RESET;
                    PurchasePriceRec.SETFILTER(PurchasePriceRec."Order No.", Rec."Order No.");
                    // PurchasePriceReport.SETTABLEVIEW(PurchasePriceRec);
                    // PurchasePriceReport.RUN;
                end;
            }
        }
    }

    var
        // PurchasePriceReport: Report 50084;
        PurchasePriceRec: Record "Purchase Price";
        Description: Text[250];
        Item: Record Item;

    trigger OnAfterGetRecord()
    begin
        //code added in upgrade start(+)
        IF Rec."Item No." <> '' THEN BEGIN
            Item.GET(Rec."Item No.");
            Description := Item.Description + ' ' + Item."Description 2" + ' ' + Item."Manufacturer Code";
        END;
        //code added in upgrade end (-)
    end;
    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
    /*

    //code added in upgrade start(+)
    IF "Item No."<>'' THEN BEGIN
    Item.GET("Item No.");
    Description:=Item.Description+' '+Item."Description 2"+' '+Item."Manufacturer Code";
    END;
    //code added in upgrade end (-)
    */
    //end;
}

