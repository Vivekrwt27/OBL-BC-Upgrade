page 50071 "Purchase List Archive1"
{
    Caption = 'Purchase List Archive';
    Editable = false;
    PageType = Card;
    SourceTable = "Freight Master IBOT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                //16225 field N/F Start
                /*   field("Version No."; "Version No.")
                   {
                       ApplicationArea = All;
                   }
                   field("No."; "No.")
                   {
                       ApplicationArea = All;
                   }
                   field("Date Archived"; "Date Archived")
                   {
                       ApplicationArea = All;
                   }
                   field("Time Archived"; "Time Archived")
                   {
                       ApplicationArea = All;
                   }
                   field("Archived By"; "Archived By")
                   {
                       ApplicationArea = All;
                   }
                   field("Interaction Exist"; "Interaction Exist")
                   {
                       ApplicationArea = All;
                   }
                   field("Buy-from Vendor No."; "Buy-from Vendor No.")
                   {
                       ApplicationArea = All;
                   }
                   field("Order Address Code"; "Order Address Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                   {
                       ApplicationArea = All;
                   }
                   field("Vendor Authorization No."; "Vendor Authorization No.")
                   {
                       ApplicationArea = All;
                   }
                   field("Buy-from Post Code"; "Buy-from Post Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Buy-from Country Code"; "Buy-from Country Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Buy-from Contact"; "Buy-from Contact")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Pay-to Vendor No."; "Pay-to Vendor No.")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Pay-to Name"; "Pay-to Name")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Pay-to Post Code"; "Pay-to Post Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Pay-to Country Code"; "Pay-to Country Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Pay-to Contact"; "Pay-to Contact")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Ship-to Code"; "Ship-to Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Ship-to Name"; "Ship-to Name")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Ship-to Post Code"; "Ship-to Post Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Ship-to Country Code"; "Ship-to Country Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Ship-to Contact"; "Ship-to Contact")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Posting Date"; "Posting Date")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Location Code"; "Location Code")
                   {
                       Visible = true;
                       ApplicationArea = All;
                   }
                   field("Purchaser Code"; "Purchaser Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }
                   field("Currency Code"; "Currency Code")
                   {
                       Visible = false;
                       ApplicationArea = All;
                   }*/ //16225 field N/F End
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 field N/F Start
                        /* CASE "Document Type" OF
                             "Document Type"::"1":
                                 FORM.RUN(FORM::"Purchase Order Archive1", Rec);
                             "Document Type"::"0":
                                 FORM.RUN(FORM::Form5164, Rec);//16225 field N/F End
                         END;*/
                    end;
                }
            }
        }
    }
}

