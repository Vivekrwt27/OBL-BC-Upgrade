page 50085 "Transfer Data"
{
    PageType = Card;
    SourceTable = "Physical Journal Output Entrie";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /*  field("Document Type"; rec."Document Type")
                  {
                      ApplicationArea = All;
                  }*/
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                /*   field("Posting Date"; rec."Posting Date")
                   {
                       ApplicationArea = All;
                   }
                   field("Sell-to Customer No."; rec."Sell-to Customer No.")
                   {
                       ApplicationArea = All;
                   }*/
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                /* field("No."; rec."No.")
                 {
                     ApplicationArea = All;
                 }*/
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                /*  field("Description 2"; rec."Description 2")
                  {
                      ApplicationArea = All;
                  }*/
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                /*  field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                  {
                      ApplicationArea = All;
                  }
                  field(Quantity; rec.Quantity)
                  {
                      ApplicationArea = All;
                  }
                  field("Unit of Measure Code"; rec."Unit of Measure Code")
                  {
                      ApplicationArea = All;
                  }
                  field(MRP; rec.MRP)
                  {
                      ApplicationArea = All;
                  }
                  field("Buyer's Price"; rec."Buyer's Price")
                  {
                      ApplicationArea = All;
                  }
                  field("Unit Price"; rec."Unit Price")
                  {
                      ApplicationArea = All;
                  }
                  field("Quantity in Cartons"; rec."Quantity in Cartons")
                  {
                      ApplicationArea = All;
                  }
                  field("Quantity in Sq. Mt."; rec."Quantity in Sq. Mt.")
                  {
                      ApplicationArea = All;
                  }
                  field("Salesperson Code"; rec."Salesperson Code")
                  {
                      ApplicationArea = All;
                  }
                  field("Salesperson Description"; rec."Salesperson Description")
                  {
                      ApplicationArea = All;
                  }*/
            }
            field(FromDate; FromDate)
            {
                Caption = 'From Date';
                ApplicationArea = All;
            }
            field(ToDate; ToDate)
            {
                Caption = 'To Date';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        FromDate: Date;
        TransferData: Codeunit "SMS - Nas Handler";
        ToDate: Date;
}

