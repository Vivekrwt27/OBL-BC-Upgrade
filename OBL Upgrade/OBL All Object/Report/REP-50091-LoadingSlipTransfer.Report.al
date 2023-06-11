report 50091 "Loading Slip Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\LoadingSlipTransfer.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Transfer Header"; 5740)
        {
            RequestFilterFields = "No.";
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Name2_CompanyInformation; "Company Information"."Name 2")
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Address2_CompanyInformation; "Company Information"."Address 2")
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PostCode_CompanyInformation; "Company Information"."Post Code")
            {
            }
            column(State; "Company Information"."State Code") // 16630 replace here State
            {
            }
            column(No_TransferHeader; "Transfer Header"."No.")
            {
            }
            column(PostingDate_TransferHeader; FORMAT("Transfer Header"."Posting Date"))
            {
            }
            column(TransfertoName_TransferHeader; "Transfer Header"."Transfer-to Name")
            {
            }
            column(TransfertoAddress_TransferHeader; "Transfer Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferHeader; "Transfer Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoCity_TransferHeader; "Transfer Header"."Transfer-to City")
            {
            }
            column(StateName; StateName)
            {
            }
            column(LST; LST)
            {
            }
            column(CST; CST)
            {
            }
            column(LocationComment_TransferHeader; "Transfer Header"."Location Comment")
            {
            }
            column(ReleasingDate_TransferHeader; "Transfer Header"."Releasing Date")
            {
            }
            column(ReleasingTime_TransferHeader; "Transfer Header"."Releasing Time")
            {
            }
            column(ShipmentDate_TransferHeader; FORMAT("Transfer Header"."Shipment Date"))
            {
            }
            column(TransporterName; TransporterName)
            {
            }
            column(TruckNo_TransferHeader; "Transfer Header"."Truck No.")
            {
            }
            column(Pay_TransferHeader; "Transfer Header".Pay)
            {
            }
            dataitem("Transfer Line"; 5741)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Plant Code")
                                    ORDER(Ascending)
                                    WHERE("Derived From Line No." = CONST(0));
                RequestFilterFields = "Plant Code";
                column(DocNoTL; "Transfer Line"."Document No.")
                {
                }
                column(SNo; SNo)
                {
                }
                column(TransferFromBin; "Transfer Line"."Transfer-from Bin Code")
                {
                }
                column(Description_TransferLine; "Transfer Line".Description)
                {
                }
                column(Description2_TransferLine; "Transfer Line"."Description 2")
                {
                }
                column(VariantCode_TransferLine; "Transfer Line"."Variant Code")
                {
                }
                column(UnitofMeasureCode_TransferLine; "Transfer Line"."Unit of Measure Code")
                {
                }
                column(TransferPrice_TransferLine; "Transfer Line"."Transfer Price")
                {
                }
                column(MRPPrice_TransferLine; 0) // 16630 blank "Transfer Line"."MRP Price"
                {
                }
                column(Quantity_TransferLine; "Transfer Line".Quantity)
                {
                }
                column(Wt; Wt)
                {
                }
                column(QtySqm; QtySqm)
                {
                }
                column(TxtComment; TxtComment)
                {
                }
                column(PlantName; PlantName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo := SNo + 1;
                    QtyCart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                    //Wt := Item.UomToWeight("Item No.","Unit of Measure Code",Quantity);
                    Wt := "Transfer Line"."Gross Weight";
                    QtySqm := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                    InventorySetup.GET;
                    IF DimValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                        PlantName := DimValue.Name;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(QtyCart, Wt, QtySqm, "Transfer Line".Quantity);
                    SNo := 0;
                end;
            }
            dataitem(SalesLine; 5741)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Type Code" = FILTER(''),
                                          "Derived From Line No." = CONST(0));
                RequestFilterFields = "Plant Code";
                column(SalDOcNo; SalesLine."Document No.")
                {
                }
                column(Description_SalesLine; SalesLine.Description)
                {
                }
                column(Description2_SalesLine; SalesLine."Description 2")
                {
                }
            }
            dataitem("Inventory Comment Line"; 5748)
            {
                DataItemLink = "No." = FIELD("No.");
                column(Comment; "Inventory Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                TxtComment := '';
                InvCommentLine.RESET;
                InvCommentLine.SETRANGE(InvCommentLine."Document Type", InvCommentLine."Document Type"::"Transfer Order");
                InvCommentLine.SETRANGE(InvCommentLine."No.", "Transfer Header"."No.");
                IF InvCommentLine.FINDFIRST THEN
                    TxtComment := InvCommentLine.Comment;


                IF Customer.GET("Transfer Header"."Transfer-to Code") THEN BEGIN
                    CST := Customer."C.S.T. No.";
                    //  LST := Customer."Party's L.S.T No.";
                END;

                IF TransporterRec.GET("Transfer Header"."Transporter's Name") THEN
                    TransporterName := TransporterRec.Name;
                Counter := 11;
                StateName := '';
                IF State.GET("Transfer-to State") THEN
                    StateName := State.Description;



                /*InventorySetup.GET;
                IF DimValue.GET(InventorySetup."Plant Code","Plant Code") THEN
                  PlantName := DimValue.Name;
                *///tmc::6823 Comment due to error

            end;

            trigger OnPreDataItem()
            begin
                SNo := 0;
                "Company Information".GET();
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

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50091)
    end;

    var
        SNo: Integer;
        QtyCart: Decimal;
        Item: Record Item;
        Wt: Decimal;
        Customer: Record Location;
        CST: Code[50];
        LST: Code[50];
        CodeDesc: Text[30];
        // 16630 TaxChargeGroup: Record 13791;
        InventorySetup: Record "Inventory Setup";
        DimValue: Record "Dimension Value";
        PlantName: Text[50];
        TransporterRec: Record Vendor;
        TransporterName: Text[50];
        Counter: Integer;
        QtySqm: Decimal;
        State: Record State;
        StateName: Text[50];
        InvCommentLine: Record "Inventory Comment Line";
        TxtComment: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        "Company Information": Record "Company Information";
}

