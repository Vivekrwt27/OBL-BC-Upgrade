page 50113 "Rejection Line2"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Rejection Purchase Line";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Store Rejection No."; Rec."Store Rejection No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Rejection Date"; Rec."Rejection Date")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("MRN Date"; Rec."MRN Date")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Rejection No."; Rec."Rejection No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Challan Quantity"; Rec."Challan Quantity")
                {
                    ApplicationArea = All;
                }
                field("Actual Quantity"; Rec."Actual Quantity")
                {
                    ApplicationArea = All;
                }
                field("Accepted Quantity"; Rec."Accepted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shortage Quantity"; Rec."Shortage Quantity")
                {
                    ApplicationArea = All;
                }
                field("Rejected Quantity"; Rec."Rejected Quantity")
                {
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Rejection Advice")
                {
                    Caption = 'Rejection Advice';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        RecRejpurchline.RESET;
                        RecRejpurchline.SETFILTER("Rejection No.", '%1', Rec."Rejection No.");
                        //RecRejpurchline.SETFILTER("No.","No.");
                        //  RejectionAdvice.SETTABLEVIEW(RecRejpurchline);
                        //  RejectionAdvice.RUN;
                    end;
                }
            }
        }
    }

    var
        RecRejpurchline: Record "Rejection Purchase Line";
    // RejectionAdvice: Report 50209;
}

