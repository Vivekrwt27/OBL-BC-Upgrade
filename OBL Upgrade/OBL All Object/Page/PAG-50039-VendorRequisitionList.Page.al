page 50039 "Vendor Requisition List"
{
    Caption = 'Vendor Creation List';
    CardPageID = "Vendor Requisition";
    Editable = false;
    PageType = List;
    SourceTable = "Vendor Requisition";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pending With"; Rec.GetUserName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vend. Company Type"; Rec."Vend. Company Type")
                {
                    ApplicationArea = All;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = All;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = All;
                }
                field("Bank A/c"; Rec."Bank A/c")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Address"; Rec."Bank Address")
                {
                    ApplicationArea = All;
                }
                field("Bank Address 2"; Rec."Bank Address 2")
                {
                    ApplicationArea = All;
                }
                field("RTGS/NEFT Code"; Rec."RTGS/NEFT Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("P.A.N. Reference No."; Rec."P.A.N. Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Tranporter RCM GST No."; Rec."GST No.")
                {
                    Caption = 'Tranporter RCM GST No.';
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
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
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Transporter1; Rec.Transporter1)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
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
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code2"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Msme Code"; Rec."Msme Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    Caption = 'Zone';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Supplier's E-Mail"; Rec."E-Mail")
                {
                    Caption = 'Supplier''s E-Mail';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("A/C user E-mail"; Rec."A/C user E-mail")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Aggregate Turnover"; Rec."Aggregate Turnover")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("194Q "; Rec."194Q")
                {
                    Caption = '194Q';
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            /*   part(T1; "Social Listening FactBox")
               {
                   SubPageLink = "Source Type" = CONST(Vendor),
                                 "Source No." = FIELD("No.");
                   Visible = SocialListeningVisible;
                   ApplicationArea = All;
               }
               part(; 876)
               {
                   SubPageLink = "Source Type" = CONST(Vendor),
                                 "Source No." = FIELD("No.");
                   UpdatePropagation = Both;
                   Visible = SocialListeningSetupVisible;
                   ApplicationArea = All;
               }*/
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part("Vendor Hist. Pay-to FactBox"; 9096)
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                Image = Vendor;
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(23),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension = R;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            Vend: Record 50062;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            /* //--Vrn
                            CurrPage.SETSELECTIONFILTER(Vend);
                            DefaultDimMultiple.SetMultiVendor(Vend);
                            DefaultDimMultiple.RUNMODAL;
                            */

                        end;
                    }
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Vendor Bank Account List";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&ontact")
                {
                    AccessByPermission = TableData Contact = R;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.ShowContact;
                    end;
                }
                separator(T2)
                {
                }
                action("Order &Addresses")
                {
                    Caption = 'Order &Addresses';
                    Image = Addresses;
                    RunObject = Page "Order Address List";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Cross Re&ferences")
                {
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    /*    RunObject = Page 5723;
                        RunPageLink = "Cross-Reference Type" = CONST(Vendor),
                                      "Cross-Reference Type No." = FIELD("No.");
                        RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");*/
                    ApplicationArea = All;
                }
                separator(gernal)
                {
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                Image = Purchasing;
                action(Items)
                {
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page "Vendor Item Catalog";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Invoice &Discounts")
                {
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Vend. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    ApplicationArea = All;
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Purchase Prepmt. Percentages";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("S&td. Vend. Purchase Codes")
                {
                    Caption = 'S&td. Vend. Purchase Codes';
                    Image = CodesList;
                    RunObject = Page "Standard Vendor Purchase Codes";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Administration;
                action(Quotes)
                {
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Purchase Quotes";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
                action(Orders1)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Order List";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Order List";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Purchase Orders";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action(Purchases)
                {
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Vendor Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Statistics by C&urrencies")
                {
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Vend. Stats. by Curr. Lines";
                    RunPageLink = "Vendor Filter" = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Date Filter" = FIELD("Date Filter");
                    ApplicationArea = All;
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        // 15578     ItemTrackingDocMgt.ShowItemTrackingForMasterData(2, rec."No.", '', '', '', '', '');
                    end;
                }
            }
        }
        area(creation)
        {
            action("Blanket Purchase Order")
            {
                Caption = 'Blanket Purchase Order';
                Image = BlanketOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Blanket Purchase Order";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Purchase Quote")
            {
                Caption = 'Purchase Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Purchase Quote";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Purchase Invoice")
            {
                Caption = 'Purchase Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Purchase Invoice";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Purchase Order";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Purchase Credit Memo")
            {
                Caption = 'Purchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Purchase Credit Memo";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Purchase Return Order")
            {
                Caption = 'Purchase Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Purchase Return Order";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /* //--Vrn
                        IF ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendVendorForApproval(Rec);
                          */

                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec); //--Vrn
                    end;
                }
            }
            action("Payment Journal")
            {
                Caption = 'Payment Journal';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payment Journal";
                ApplicationArea = All;
            }
            action("Purchase Journal")
            {
                Caption = 'Purchase Journal';
                Image = Journals;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Journal";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group(General)
            {
                Caption = 'General';
                action("Vendor - List")
                {
                    Caption = 'Vendor - List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - List";
                    ApplicationArea = All;
                }
                action("Vendor Register")
                {
                    Caption = 'Vendor Register';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor Register";
                    ApplicationArea = All;
                }
                action("Vendor Item Catalog")
                {
                    Caption = 'Vendor Item Catalog';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor Item Catalog";
                    ApplicationArea = All;
                }
                action("Vendor - Labels")
                {
                    Caption = 'Vendor - Labels';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Labels";
                    ApplicationArea = All;
                }
                action("Vendor - Top 10 List")
                {
                    Caption = 'Vendor - Top 10 List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Top 10 List";
                    ApplicationArea = All;
                }
            }
            group(Orders)
            {
                Caption = 'Orders';
                Image = "Report";
                action("Vendor - Order Summary")
                {
                    Caption = 'Vendor - Order Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Order Summary";
                    ApplicationArea = All;
                }
                action("Vendor - Order Detail")
                {
                    Caption = 'Vendor - Order Detail';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Order Detail";
                    ApplicationArea = All;
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = Purchase;
                action("Vendor - Purchase List")
                {
                    Caption = 'Vendor - Purchase List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Purchase List";
                    ApplicationArea = All;
                }
                action("Vendor/Item Purchases")
                {
                    Caption = 'Vendor/Item Purchases';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor/Item Purchases";
                    ApplicationArea = All;
                }
                action("Purchase Statistics")
                {
                    Caption = 'Purchase Statistics';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Purchase Statistics";
                    ApplicationArea = All;
                }
            }
            group("Financial Management")
            {
                Caption = 'Financial Management';
                Image = "Report";
                action("Payments on Hold")
                {
                    Caption = 'Payments on Hold';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payments on Hold";
                    ApplicationArea = All;
                }
                action("Vendor - Summary Aging")
                {
                    Caption = 'Vendor - Summary Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Summary Aging";
                    ApplicationArea = All;
                }
                action("Aged Accounts Payable")
                {
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ApplicationArea = All;
                }
                action("Vendor - Balance to Date")
                {
                    Caption = 'Vendor - Balance to Date';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Balance to Date";
                    ApplicationArea = All;
                }
                action("Vendor - Trial Balance")
                {
                    Caption = 'Vendor - Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Trial Balance";
                    ApplicationArea = All;
                }
                action("Vendor - Detail Trial Balance")
                {
                    Caption = 'Vendor - Detail Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Detail Trial Balance";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetSocialListeningFactboxVisibility;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID)
    end;

    trigger OnAfterGetRecord()
    begin
        SetSocialListeningFactboxVisibility
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        [InDataSet]
        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure GetSelectionFilter(): Text
    var
        Vend: Record Vendor;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Vend);
        EXIT(SelectionFilterManagement.GetSelectionFilterForVendor(Vend));
    end;


    procedure SetSelection(var Vend: Record Vendor)
    begin
        CurrPage.SETSELECTIONFILTER(Vend);
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    ///  SocialListeningMgt: Codeunit "Social Listening Management";
    begin
        //SocialListeningMgt.GetVendFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible); //--Vrn
    end;
}

