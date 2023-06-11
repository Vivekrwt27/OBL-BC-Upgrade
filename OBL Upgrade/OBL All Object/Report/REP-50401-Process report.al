report 50402 Updatecustonsalesorder1
{
    DefaultLayout = RDLC;
    Caption = 'Updatecustonsalesorder';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("No.", "Document Type", "posting date");
            RequestFilterFields = "Posting Date";

            trigger
            OnAfterGetRecord()
            begin
                Clear(PaymentTerms);
                Clear(status1);
                Clear(locationcode);
                Clear(BillTocustomerNo);
                Status1 := "Sales Header".Status;
                BillTocustomerNo := "Sales Header"."Bill-to Customer No.";

                "Sales Header".Status := "Sales Header".Status::Open;
                PaymentTerms := "Sales Header"."Payment Terms Code";
                locationcode := "Sales Header"."Location Code";

                if customer.get("Sales Header"."Sell-to Customer No.") then
                    if customer.Blocked = customer.Blocked::" " then begin


                        "Sales Header".Validate("Sell-to Customer No.", customer."No.");
                        "Sales Header".validate("Bill-to Customer No.", BillTocustomerNo);
                        "Sales Header".validate("Location Code", locationcode);

                        saleslinerec.reset;
                        saleslinerec.setrange("Document No.", "Sales Header"."No.");
                        if saleslinerec.FindSet then
                            repeat
                                saleslinerec.Status := saleslinerec.Status::Open;
                                saleslinerec.Modify;
                            until saleslinerec.Next = 0;
                        if saleslinerec.FindSet then
                            repeat

                                saleslinerec."GST Credit" := saleslinerec."GST Credit"::Availment;
                                saleslinerec."VAT Calculation Type" := saleslinerec."VAT Calculation Type"::"Normal VAT";
                                saleslinerec.Status := status1;
                                saleslinerec.Modify;
                            until saleslinerec.Next = 0;
                        "Sales Header".Status := Status1;

                        "Sales Header"."Payment Terms Code" := PaymentTerms;
                        "Sales Header"."Calculate Insurance" := true;
                        "Sales Header".Modify;

                    end;

            end;


            trigger OnPostDataItem()
            begin
                //  Message('Done');
            end;

            trigger OnPreDataItem()
            begin
                "Sales Header".setrange("Order Date", 20230522D, 20230527D);
                //  "Sales Header".SetFilter("No.", 'SOSKD/2324/005636|SOSKD/2324/004936|SOSKD/2324/005634|SOSKD/2324/006002|SOSKD/2324/006037|SOSKD/2324/005997|SOSKD/2324/006010|SOSKD/2324/005999|SOSKD/2324/006006|SOSKD/2324/006016|SOSKD/2324/003643|SOSKD/2324/006017|SOSKD/2324/006035|SOSKD/2324/006282');
            end;
        }


    }
    var

        saleslinerec: Record 37;
        Saleshdr: Record 36;
        saleslinerec1: Record 37;
        customer: Record 18;
        status1: Option
         Open,Released,"Pending Approval","Pending Prepayment","Price Approved","Credit Approval Pending","Credit Approved","Not in Inventory",Approved;
        locationcode: code[100];
        PaymentTerms: Code[100];
        BillTocustomerNo: Code[100];



}

