pageextension 50409 pageextension50409 extends "Purchase Statistics"
{
    layout
    {
        addafter(Quantity)
        {
            field(TCSAmt; TCSAmt)
            {
                Caption = 'TCS Amt';
                Editable = false;
                ApplicationArea = All;
            }
            /* field("Purchase Value"; TotalAmount1 + ABS(ABS(TotalGSTInvoiced) - TotalAdvGSTInvoiced) + TotalPurchLine."Charges To Vendor" - TCSAmt + TCSAmt)
             {
             }*/
        }
        addafter(TotalAmount1)
        {
            /* field(TotalPurchLine."Line Amount"+ABS(ABS(TotalGSTInvoiced) - TotalAdvGSTInvoiced);
                 TotalPurchLine."Line Amount"+ABS(ABS(TotalGSTInvoiced) - TotalAdvGSTInvoiced))
             {
                 AutoFormatExpression = "Currency Code";
                 // AutoFormatType = 1;
                 Caption = 'Total';
                 Editable = false;
                 Importance = Promoted;
             }*/
        }
    }

    var
        TCSAmt: Decimal;
        TotalPurchLine: Record "Purchase Line";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.GET;
    AllowInvDisc :=
      NOT (PurchSetup."Calc. Inv. Discount" AND VendInvDiscRecExists("Invoice Disc. Code"));
    AllowVATDifference :=
      PurchSetup."Allow VAT Difference" AND
      NOT ("Document Type" IN ["Document Type"::Quote,"Document Type"::"Blanket Order"]);
    CurrPage.EDITABLE := AllowVATDifference OR AllowInvDisc;
    SetVATSpecification;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    TCSAmt:=0;
    TCSAmt := CalculateTCSAmt;
    */
    //end;
}

