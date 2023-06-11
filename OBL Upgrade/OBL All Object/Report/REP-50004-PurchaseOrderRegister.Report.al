report 50004 "Purchase Order Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseOrderRegister.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Company Information"; 79)
        {
            DataItemTableView = SORTING("Primary Key");
            column(CompName; "Company Information".Name)
            {
            }
            column(CompName2; "Company Information"."Name 2")
            {
            }
        }
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING("Vendor Classification", "No.");
            column(VenClasName; VendorClassName)
            {
            }
            dataitem("Purchase Header"; 38)
            {
                DataItemTableView = SORTING("Vendor Classification", "No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = CONST(Order));
                column(PurchNo; "Purchase Header"."No.")
                {
                }
                column(PurchOrderDate; "Purchase Header"."Order Date")
                {
                }
                column(PurchByFromVndNum; "Purchase Header"."Buy-from Vendor No.")
                {
                }
                column(PurchByVendName; "Purchase Header"."Buy-from Vendor Name")
                {
                }
                column(PurchValueOfOrder; "Purchase Header"."Value of Order")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF Option = Option::Posted THEN
                        CurrReport.SKIP;
                    IF LocationCodeFilter <> '' THEN
                        IF NOT LocationRec.GetLocationFilter(LocationCodeFilter, "Location Code") THEN
                            CurrReport.SKIP;

                    // 16630  CALCFIELDS("Value of Order");

                    "Num." += 1;
                end;

                trigger OnPreDataItem()
                begin
                    IF StatusFilter = StatusFilter::Released THEN
                        SETFILTER(Status, '%1', Status::Released);
                    IF StatusFilter = StatusFilter::Open THEN
                        SETFILTER(Status, '%1', Status::Open);

                    IF OrderDateFilter <> '' THEN
                        SETFILTER("Order Date", OrderDateFilter);
                    IF PostingDateFilter <> '' THEN
                        SETFILTER("Posting Date", PostingDateFilter);
                    IF DocumentDateFilter <> '' THEN
                        SETFILTER("Document Date", DocumentDateFilter);
                    //IF LocationCodeFilter<>'' THEN
                    //  SETFILTER("Location Code",LocationCodeFilter);
                    IF PaymentsTermsCodeFilter <> '' THEN
                        SETFILTER("Payment Terms Code", PaymentsTermsCodeFilter);
                    IF PaymentMethodCodeFilter <> '' THEN
                        SETFILTER("Payment Method Code", PaymentMethodCodeFilter);
                    IF VendorNoFilter <> '' THEN
                        SETFILTER("Buy-from Vendor No.", VendorNoFilter);

                    CLEAR("Num.");
                end;
            }
            dataitem("Purchase Header Archive"; 5109)
            {
                DataItemTableView = SORTING("Vendor Classification", "No.")
                                     ORDER(Ascending)
                                     WHERE("No." = CONST('1'),
                                           Deleted = CONST(true));
                column(PurchNo2; "Purchase Header Archive"."No.")
                {
                }
                column(PurchOrderDate2; "Purchase Header Archive"."Order Date")
                {
                }
                column(PurchByFromVndNum2; "Purchase Header Archive"."Buy-from Vendor No.")
                {
                }
                column(PurchByVendName2; "Purchase Header Archive"."Buy-from Vendor Name")
                {
                }
                column(Amount; "Purchase Header Archive".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF Option = Option::Existing THEN
                        CurrReport.SKIP;
                    IF LocationCodeFilter <> '' THEN
                        IF NOT LocationRec.GetLocationFilter(LocationCodeFilter, "Location Code") THEN
                            CurrReport.SKIP;

                    CALCFIELDS(Amount);
                    "Num." += 1;
                end;

                trigger OnPreDataItem()
                begin

                    IF StatusFilter = StatusFilter::Released THEN
                        SETFILTER(Status, '%1', Status::Released);
                    IF StatusFilter = StatusFilter::Open THEN
                        SETFILTER(Status, '%1', Status::Open);

                    IF OrderDateFilter <> '' THEN
                        SETFILTER("Order Date", OrderDateFilter);
                    IF PostingDateFilter <> '' THEN
                        SETFILTER("Posting Date", PostingDateFilter);
                    IF DocumentDateFilter <> '' THEN
                        SETFILTER("Document Date", DocumentDateFilter);
                    //IF LocationCodeFilter<>'' THEN
                    //  SETFILTER("Location Code",LocationCodeFilter);
                    IF PaymentsTermsCodeFilter <> '' THEN
                        SETFILTER("Payment Terms Code", PaymentsTermsCodeFilter);
                    IF PaymentMethodCodeFilter <> '' THEN
                        SETFILTER("Payment Method Code", PaymentMethodCodeFilter);
                    IF VendorNoFilter <> '' THEN
                        SETFILTER("Buy-from Vendor No.", VendorNoFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin


                IF VendorType.GET(VendorType.Type::Vendor, Vendor."Vendor Classification") THEN
                    VendorClassName := VendorType.Description

                //CurrReport.CREATETOTALS(PurchaseHeaderArchive.Amount,PurchaseHeader."Value of Order");
            end;

            trigger OnPreDataItem()
            begin
                IF VendorClassificationFilter <> '' THEN
                    SETFILTER("Vendor Classification", VendorClassificationFilter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field(Option; Option)
                    {
                        ApplicationArea = All;
                    }
                    field(Status; StatusFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Posting Date"; PostingDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Order Date"; OrderDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Document Date "; DocumentDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor No"; VendorNoFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Clossification ode"; VendorClassificationFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Location Code"; LocationCodeFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Term Code"; PaymentsTermsCodeFilter)
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Method Code"; PaymentMethodCodeFilter)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        // 16630  ApplicationMgt: Codeunit 1;
        LocationRec: Record Location;
        VendorType: Record "Customer Type";
        "Num.": Integer;
        i: Integer;
        Option: Option "Existing and Posted",Existing,Posted;
        OrderDateFilter: Text[250];
        PostingDateFilter: Text[250];
        DocumentDateFilter: Text[250];
        VendorClassificationFilter: Code[20];
        VendorNoFilter: Code[20];
        LocationCodeFilter: Code[20];
        PaymentsTermsCodeFilter: Code[20];
        PaymentMethodCodeFilter: Code[20];
        StatusFilter: Option " ",Open,Released;
        FilterString: Text[100];
        GrandTotal: Decimal;
        VendorClassName: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

