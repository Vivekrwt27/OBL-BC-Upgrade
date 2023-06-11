report 50184 "PO Pending for MRN"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\POPendingforMRN.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; 38)
        {
            DataItemTableView = SORTING("User Id", "Buy-from Vendor No.")
                                WHERE("Document Type" = FILTER(Order),
                                      Status = FILTER(Released),
                                      "Delivary Date" = FILTER(<> ''),
                                      "No." = FILTER(<> 'POTR*'));
            column(PartyCode; "Buy-from Vendor No.")
            {
            }
            column(PartyName; "Buy-from Vendor Name")
            {
            }
            column(PONo; "No.")
            {
            }
            column(UserId; "User Id")
            {
            }
            column(UserEmail; UserSetup."E-Mail")
            {
            }
            column(PODate; FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(OrderDate; FORMAT("Order Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DeliveryDate; FORMAT("Delivary Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(POStatus; "Purchase Header".Status)
            {
            }
            column(GraceDate; GraceDate)
            {
            }
            column(VendorCode; Vendor."No.")
            {
            }
            column(VendorName; Vendor.Name)
            {
            }
            dataitem("Purchase Line"; 39)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(<> 0),
                                          "Outstanding Quantity" = FILTER(<> 0));
                column(ItemCode; "No.")
                {
                }
                column(ItemDescription; Description)
                {
                }
                column(UnitCost; "Direct Unit Cost")
                {
                }
                column(Qty; Quantity)
                {
                }
                column(Amount; Amount)
                {
                }
                column(OutstandingQty; "Outstanding Quantity")
                {
                }
                column(OurstandingAmount; "Outstanding Amount")
                {
                }
                column(IndentNo; "Indent No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Purchase Line"."Outstanding Quantity" = 0 THEN
                        CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GraceDate := "Purchase Header"."Delivary Date" + 5;
                IF TODAY - GraceDate <= 0 THEN
                    CurrReport.SKIP;
                IF UserSetup.GET("Purchase Header"."User Id") THEN;
                IF Vendor.GET("Purchase Header"."Buy-from Vendor No.") THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        UserSetup: Record "User Setup";
        GraceDate: Date;
        Vendor: Record Vendor;
}

