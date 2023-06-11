report 50011 "Outstanding RGP"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\Reportlayouts\OutstandingRGP.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Header"; 50012)
        {
            DataItemTableView = SORTING(Type, Code)
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Out),
                                      Posted = CONST(true));
            RequestFilterFields = "Posting Date", "No.", Type;
            column(Name_CompInfo; CompInfo.Name + '' + CompInfo."Name 2")
            {
            }
            column(PostingDate_RGPHeader; FORMAT("RGP Header"."Posting Date"))
            {
            }
            column(Purpose_RGPHeader; "RGP Header".Purpose)
            {
            }
            column(Date; Date)
            {
            }
            column(Filters; Filters)
            {
            }
            column(Code_RGPHeader; "RGP Header".Code)
            {
            }
            column(Name_RGPHeader; "RGP Header".Name)
            {
            }
            dataitem("RGP Line"; 50013)
            {
                DataItemLink = "RGP No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "RGP No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Quantity to Receive" = FILTER(> 0));
                column(S_No; "SNo.")
                {
                }
                column(RGPNo_RGPLine; "RGP Line"."RGP No.")
                {
                }
                column(LineNo_RGPLine; "RGP Line"."Line No.")
                {
                }
                column(Type_RGPLine; "RGP Line".Type)
                {
                }
                column(No_RGPLine; "RGP Line"."No.")
                {
                }
                column(Description_RGPLine; "RGP Line".Description)
                {
                }
                column(UnitofMeasure_RGPLine; "RGP Line"."Unit of Measure")
                {
                }
                column(Quantity_RGPLine; "RGP Line".Quantity)
                {
                }
                column(QuantitytoReceive_RGPLine; "RGP Line"."Quantity to Receive")
                {
                }
                column(ReceivingQuantity_RGPLine; ReceivedQty)
                {
                }
                column(Location_RGPLine; "RGP Line".Location)
                {
                }
                column(RGPLine_ExpectedReceiptDate; "RGP Line"."Expected Receipt Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('ok');
                    "SNo." += 1;
                    ReceivedQty := "RGP Line".Quantity - "RGP Line"."Quantity to Receive";

                    /*IF LocNo <> '' THEN
                       IF NOT Location1.GetLocationFilter(LocNo,"RGP Line".Location) THEN
                          CurrReport.SKIP;
                     */

                end;

                trigger OnPreDataItem()
                begin
                    "SNo." := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                IF Employee <> '' THEN
                    "RGP Header".SETFILTER("RGP Header"."Employee ID", '%1', Employee);

                IF LocNo <> '' THEN
                    "RGP Header".SETFILTER(Location, LocNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(Location; LocNo)
                    {
                        TableRelation = Location;
                        ApplicationArea = All;
                    }
                    field(Employee; Employee)
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

    trigger OnPreReport()
    begin

        Date := FORMAT("RGP Header".GETFILTER("RGP Header"."Posting Date"));
        IF Date = '' THEN
            Date := FORMAT(TODAY, 0, 4);

        IF "RGP Header".GETFILTER("RGP Header".Location) <> '' THEN
            ERROR('Please select the Location Code from Option Tab');
        IF "RGP Header".GETFILTER("RGP Header"."Employee ID") <> '' THEN
            ERROR('Please select the Employee ID from Option Tab');

        Filters := "RGP Header".GETFILTERS;

        IF Employee <> '' THEN BEGIN
            IF "RGP Header".GETFILTERS <> '' THEN
                Filters := Filters + ', ';
            Filters := Filters + 'Employee ID : ' + Employee;
        END;

        IF LocNo <> '' THEN BEGIN
            IF ("RGP Header".GETFILTERS <> '') OR (Employee <> '') THEN
                Filters := Filters + ', ';
            Filters := Filters + 'Location Code : ' + LocNo;
        END;
    end;

    var
        CompInfo: Record "Company Information";
        ReceivedQty: Decimal;
        "SNo.": Integer;
        Date: Text[30];
        Location1: Record Location;
        Employee: Code[10];
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Filters: Text[500];
        LocNo: Code[10];
        K: Integer;
}

