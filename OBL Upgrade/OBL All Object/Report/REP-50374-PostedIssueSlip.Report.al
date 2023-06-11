report 50374 "Posted Issue Slip"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\PostedIssueSlip.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.";
            column(CompName; CompInfo.Name)
            {
            }
            column(No; "Transfer Shipment Header"."No.")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                RequestFilterFields = "Document No.";
                column(TSL_TransferToCode; "Transfer Shipment Line"."Transfer-to Code")
                {
                }
                column(SNo; SNo)
                {
                }
                column(TSL_ItemNo; "Transfer Shipment Line"."Item No.")
                {
                }
                column(TSL_Description; "Transfer Shipment Line".Description)
                {
                }
                column(UnitOfMeasureCode; "Transfer Shipment Line"."Unit of Measure Code")
                {
                }
                column(Quantity; "Transfer Shipment Line".Quantity)
                {
                }
                column(Amount; "Transfer Shipment Line".Amount)
                {
                }
                column(LocQty; LocQty)
                {
                }
                column(DocumentNo; "Transfer Shipment Line"."Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NoVar = '' THEN
                        NoVar := "Transfer Shipment Header"."No.";

                    IF "Transfer Shipment Header"."No." <> NoVar THEN BEGIN
                        SNo := 0;
                        NoVar := "Transfer Shipment Header"."No.";
                    END;

                    SNo += 1;
                    LocQty := 0;
                    RecItem.SETRANGE("No.", "Transfer Shipment Line"."Item No.");
                    RecItem.SETRANGE("Location Filter", "Transfer Shipment Line"."Transfer-to Code");
                    IF RecItem.FINDFIRST THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        LocQty := RecItem.Inventory;
                    END;
                end;
            }
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

    trigger OnInitReport()
    begin
        NoVar := '';
    end;

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50374)
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
    end;

    var
        SNo: Integer;
        LocQty: Decimal;
        RecItem: Record Item;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        CompInfo: Record "Company Information";
        NoVar: Code[100];
}

