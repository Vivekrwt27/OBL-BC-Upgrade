page 50066 "User Location Form"
{
    PageType = List;
    SourceTable = "User Location";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Main Location"; rec."Main Location")
                {
                    ApplicationArea = All;
                }
                field("View Transfer Order"; rec."View Transfer Order")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Forecast"; rec."Create Sales Forecast")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Order"; rec."Create Sales Order")
                {
                    ApplicationArea = All;
                }
                field("Transfer From"; rec."Transfer From")
                {
                    ApplicationArea = All;
                }
                field("Transfer To"; rec."Transfer To")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Invoice"; rec."Create Sales Invoice")
                {
                    ApplicationArea = All;
                }
                field("View Sales Order"; rec."View Sales Order")
                {
                    ApplicationArea = All;
                }
                field("View Sales Invoice"; rec."View Sales Invoice")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Credit memo"; rec."Create Sales Credit memo")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Blanket Order"; rec."Create Sales Blanket Order")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Return order"; rec."Create Sales Return order")
                {
                    ApplicationArea = All;
                }
                field("View Sales Credit memo"; rec."View Sales Credit memo")
                {
                    ApplicationArea = All;
                }
                field("View Sales Blanket Order"; rec."View Sales Blanket Order")
                {
                    ApplicationArea = All;
                }
                field("View Sales Return order"; rec."View Sales Return order")
                {
                    ApplicationArea = All;
                }
                field("Create Sales Quote"; rec."Create Sales Quote")
                {
                    ApplicationArea = All;
                }
                field("View Sales Quote"; rec."View Sales Quote")
                {
                    ApplicationArea = All;
                }
                field("Create Purchase Order"; rec."Create Purchase Order")
                {
                    ApplicationArea = All;
                }
                field("Create Purchase Invoice"; rec."Create Purchase Invoice")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Order"; rec."View Purchase Order")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Invoice"; rec."View Purchase Invoice")
                {
                    ApplicationArea = All;
                }
                field("Create Purchase Credit memo"; rec."Create Purchase Credit memo")
                {
                    ApplicationArea = All;
                }
                field("Create Purchase Blanket Order"; rec."Create Purchase Blanket Order")
                {
                    ApplicationArea = All;
                }
                field("Create Purchase Return order"; rec."Create Purchase Return order")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Credit memo"; rec."View Purchase Credit memo")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Blanket Order"; rec."View Purchase Blanket Order")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Return order"; rec."View Purchase Return order")
                {
                    ApplicationArea = All;
                }
                field("Create Purchase Quote"; rec."Create Purchase Quote")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Quote"; rec."View Purchase Quote")
                {
                    ApplicationArea = All;
                }
                field("GJT General"; rec."GJT General")
                {
                    ApplicationArea = All;
                }
                field("GJT Sales"; rec."GJT Sales")
                {
                    ApplicationArea = All;
                }
                field("GJT Purchases"; rec."GJT Purchases")
                {
                    ApplicationArea = All;
                }
                field("GJT Cash Receipts"; rec."GJT Cash Receipts")
                {
                    ApplicationArea = All;
                }
                field("GJT Payments"; rec."GJT Payments")
                {
                    ApplicationArea = All;
                }
                field("GJT Assets"; rec."GJT Assets")
                {
                    ApplicationArea = All;
                }
                field("GJT TDS Adjustments"; rec."GJT TDS Adjustments")
                {
                    ApplicationArea = All;
                }
                field("GJT LC"; rec."GJT LC")
                {
                    ApplicationArea = All;
                }
                field("GJT Receipts"; rec."GJT Receipts")
                {
                    ApplicationArea = All;
                }
                field("GJT JV"; rec."GJT JV")
                {
                    ApplicationArea = All;
                }
                field("GJT StdPayments"; rec."GJT StdPayments")
                {
                    ApplicationArea = All;
                }
                field("IJT Item"; rec."IJT Item")
                {
                    ApplicationArea = All;
                }
                field("IJT Transfer"; rec."IJT Transfer")
                {
                    ApplicationArea = All;
                }
                field("IJT Phys. Inventory"; rec."IJT Phys. Inventory")
                {
                    ApplicationArea = All;
                }
                field("IJT Revaluation"; rec."IJT Revaluation")
                {
                    ApplicationArea = All;
                }
                field("IJT Consumption"; rec."IJT Consumption")
                {
                    ApplicationArea = All;
                }
                field("IJT Output"; rec."IJT Output")
                {
                    ApplicationArea = All;
                }
                field("IJT Capacity"; rec."IJT Capacity")
                {
                    ApplicationArea = All;
                }
                field("Create Indent"; rec."Create Indent")
                {
                    ApplicationArea = All;
                }
                field("View Indent"; rec."View Indent")
                {
                    ApplicationArea = All;
                }
                field("Sales Shipment"; rec."Sales Shipment")
                {
                    ApplicationArea = All;
                }
                field(Purchaser; rec.Purchaser)
                {
                    ApplicationArea = All;
                }
                field("RGP IN"; rec."RGP IN")
                {
                    ApplicationArea = All;
                }
                field("RGP OUT"; rec."RGP OUT")
                {
                    ApplicationArea = All;
                }
                field("View Export Order"; rec."View Export Order")
                {
                    ApplicationArea = All;
                }
                field("Create Export Order"; rec."Create Export Order")
                {
                    ApplicationArea = All;
                }
                field("View Import Order"; rec."View Import Order")
                {
                    ApplicationArea = All;
                }
                field("Create Production Order"; rec."Create Production Order")
                {
                    ApplicationArea = All;
                }
                field("View Production Order"; rec."View Production Order")
                {
                    ApplicationArea = All;
                }
                field("View Customer"; rec."View Customer")
                {
                    ApplicationArea = All;
                }
                field("Create Import Order"; rec."Create Import Order")
                {
                    ApplicationArea = All;
                }
            }
            field(User; User)
            {
                TableRelation = User."User Security ID";
                ApplicationArea = All;
            }
            field("All Locations"; "All Locations")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Enter Locations")
                {
                    Caption = 'Enter Locations';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LocationRec.RESET;
                        IF NOT "All Locations" THEN
                            LocationRec.SETFILTER(LocationRec."Main Location", '%1', '');
                        IF LocationRec.FIND('-') THEN
                            REPEAT
                                IF NOT UserLocation.GET(User, LocationRec.Code) THEN BEGIN
                                    UserLocation."User ID" := User;
                                    UserLocation.VALIDATE(UserLocation."Location Code", LocationRec.Code);
                                    UserLocation.INSERT(TRUE);
                                END;
                            UNTIL LocationRec.NEXT = 0;
                    end;
                }
                action("Copy Rights to Sublocations")
                {
                    Caption = 'Copy Rights to Sublocations';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Main Location", '');
                        UserLocation.RESET;
                        UserLocation.SETFILTER(UserLocation."User ID", Rec."User ID");
                        UserLocation.SETFILTER(UserLocation."Main Location", '%1', Rec."Location Code");
                        IF UserLocation.FIND('-') THEN
                            REPEAT
                                UserLocation."Create Sales Order" := Rec."Create Sales Order";
                                UserLocation."Transfer From" := Rec."Transfer From";
                                UserLocation."Transfer To" := Rec."Transfer To";
                                UserLocation."Create Sales Invoice" := Rec."Create Sales Invoice";
                                UserLocation."View Sales Order" := Rec."View Sales Order";
                                UserLocation."View Sales Invoice" := Rec."View Sales Invoice";
                                UserLocation."Create Sales Credit memo" := Rec."Create Sales Credit memo";
                                UserLocation."Create Sales Blanket Order" := Rec."Create Sales Blanket Order";
                                UserLocation."Create Sales Return order" := Rec."Create Sales Return order";
                                UserLocation."View Sales Credit memo" := Rec."View Sales Credit memo";
                                UserLocation."View Sales Blanket Order" := Rec."View Sales Blanket Order";
                                UserLocation."View Sales Return order" := Rec."View Sales Return order";
                                UserLocation."Create Sales Quote" := Rec."Create Sales Quote";
                                UserLocation."View Sales Quote" := Rec."View Sales Quote";
                                UserLocation."Create Purchase Order" := Rec."Create Purchase Order";
                                UserLocation."Create Purchase Invoice" := Rec."Create Purchase Invoice";
                                UserLocation."View Purchase Order" := Rec."View Purchase Order";
                                UserLocation."View Purchase Invoice" := Rec."View Purchase Invoice";
                                UserLocation."Create Purchase Credit memo" := Rec."Create Purchase Credit memo";
                                UserLocation."Create Purchase Blanket Order" := rec."Create Purchase Blanket Order";
                                UserLocation."Create Purchase Return order" := rec."Create Purchase Return order";
                                UserLocation."View Purchase Credit memo" := rec."View Purchase Credit memo";
                                UserLocation."View Purchase Blanket Order" := rec."View Purchase Blanket Order";
                                UserLocation."View Purchase Return order" := rec."View Purchase Return order";
                                UserLocation."Create Purchase Quote" := rec."Create Purchase Quote";
                                UserLocation."View Purchase Quote" := rec."View Purchase Quote";
                                UserLocation."GJT General" := rec."GJT General";
                                UserLocation."GJT Sales" := rec."GJT Sales";
                                UserLocation."GJT Purchases" := rec."GJT Purchases";
                                UserLocation."GJT Cash Receipts" := rec."GJT Cash Receipts";
                                UserLocation."GJT Payments" := rec."GJT Payments";
                                UserLocation."GJT Assets" := rec."GJT Assets";
                                UserLocation."GJT TDS Adjustments" := rec."GJT TDS Adjustments";
                                UserLocation."GJT LC" := rec."GJT LC";
                                UserLocation."GJT Receipts" := rec."GJT Receipts";
                                UserLocation."GJT JV" := rec."GJT JV";
                                UserLocation."GJT StdPayments" := rec."GJT StdPayments";
                                UserLocation."IJT Item" := rec."IJT Item";
                                UserLocation."IJT Transfer" := rec."IJT Transfer";
                                UserLocation."IJT Phys. Inventory" := rec."IJT Phys. Inventory";
                                UserLocation."IJT Revaluation" := rec."IJT Revaluation";
                                UserLocation."IJT Consumption" := rec."IJT Consumption";
                                UserLocation."IJT Output" := rec."IJT Output";
                                UserLocation."IJT Capacity" := rec."IJT Capacity";
                                UserLocation."Create Indent" := rec."Create Indent";
                                UserLocation."View Indent" := rec."View Indent";
                                UserLocation."Sales Shipment" := rec."Sales Shipment";
                                UserLocation.Purchaser := rec.Purchaser;
                                UserLocation."RGP IN" := rec."RGP IN";
                                UserLocation."RGP OUT" := rec."RGP OUT";
                                UserLocation."View Export Order" := rec."View Export Order";
                                UserLocation."Create Export Order" := rec."Create Export Order";
                                UserLocation."View Import Order" := rec."View Import Order";
                                UserLocation."Create Import Order" := rec."Create Import Order";
                                UserLocation."Create Sales Forecast" := rec."Create Sales Forecast";
                                UserLocation.MODIFY(TRUE);
                            UNTIL UserLocation.NEXT = 0;
                    end;
                }
            }
        }
    }

    var
        User: Code[20];
        LocationRec: Record Location;
        UserLocation: Record "User Location";
        "All Locations": Boolean;
        LocationCode: Code[10];
        MainLocation: Code[10];
}

