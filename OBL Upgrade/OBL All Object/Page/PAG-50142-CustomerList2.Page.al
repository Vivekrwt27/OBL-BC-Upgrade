page 50142 "Customer List 2"
{
    Caption = 'Customer List 2';
    Editable = false;
    PageType = List;
    SourceTable = Customer;



    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Description"; Rec."Salesperson Description")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Pin Code"; Rec."Pin Code")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Blocked Old"; Rec."Blocked Old")
                {
                    ApplicationArea = All;
                }
                field("Security Amount"; Rec."Security Amount")
                {
                    ApplicationArea = All;
                }
                field("Security Date"; Rec."Security Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                /*field("T.I.N. No."; Rec."T.I.N. No.")
                {
                }*/
                field("PAN Ref. No."; Rec."PAN Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("PAN Status"; Rec."PAN Status")
                {
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("State Desc."; Rec."State Desc.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Customer")
            {
                Caption = '&Customer';
                Visible = false;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    action("Issued &Reminders")
                    {
                        Caption = 'Issued &Reminders';
                        RunObject = Page "Issued Reminder List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ApplicationArea = All;
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        Caption = 'Issued &Finance Charge Memos';
                        RunObject = Page "Issued Fin. Charge Memo List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ApplicationArea = All;
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                    ApplicationArea = All;

                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(18), "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            Cust: Record Customer;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Cust);
                            // 16630     DefaultDimMultiple.SetMultiCust(Cust);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Ship-&to Addresses")
                {
                    Caption = 'Ship-&to Addresses';
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&ontact")
                {
                    Caption = 'C&ontact';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                separator(Control)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("Statistics by C&urrencies")
                {
                    Caption = 'Statistics by C&urrencies';
                    RunObject = Page "Dimension Set ID Filter";
                    ApplicationArea = All;
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("S&ales")
                {
                    Caption = 'S&ales';
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                separator(Control1)
                {
                }
                action("Cross Re&ferences")
                {
                    Caption = 'Cross Re&ferences';
                    ApplicationArea = All;
                    /* RunObject = Page 5723;
                     RunPageLink = "Cross-Reference Type" = CONST(Customer), "Cross-Reference Type No." = FIELD("No.");
                     RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");*/ //16630 This Page Close
                }
                separator(Control2)
                {
                }
                action("Ser&vice Contracts")
                {
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                    ApplicationArea = All;
                }
                action("Service &Items")
                {
                    Caption = 'Service &Items';
                    RunObject = Page "Service Items";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                    ApplicationArea = All;
                }
            }
            group("S&ales1")
            {
                Caption = 'S&ales';
                action("Invoice &Discounts")
                {
                    Caption = 'Invoice &Discounts';
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    ApplicationArea = All;
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Sales Type" = CONST(Customer), "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = "Sales Type" = CONST(Customer), "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ApplicationArea = All;
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Sales Type" = CONST(Customer), "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ApplicationArea = All;
                }
                action("S&td. Cust. Sales Codes")
                {
                    Caption = 'S&td. Cust. Sales Codes';
                    RunObject = Page "Standard Customer Sales Codes";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Control3)
                {
                }
                action(Quotes)
                {
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Orders";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    ApplicationArea = All;
                }
                action("Service Orders")
                {
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Orders";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Customer No.");
                    ApplicationArea = All;
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                    begin
                        // 16630        ItemTrackingMgt.CallItemTrackingEntryForm(1, Rec."No.", '', '', '', '', '');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF USERID = 'DE025' THEN
            CurrPage.EDITABLE := FALSE;
        //Cust.VISIBLE:=FALSE;
    end;

    var
        Cust: Page "Customer Card";

    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FIND('-');
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

