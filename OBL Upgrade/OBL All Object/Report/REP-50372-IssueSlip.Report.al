report 50372 "Issue Slip"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\IssueSlip.rdl';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            column(TH_PostingDate; "Transfer Header"."Posting Date")
            {
            }
            column(TH_ReleasingDate; "Transfer Header"."Releasing Date")
            {
            }
            column(TH_No; "Transfer Header"."No.")
            {
            }
            column(TH_Remarks; "Transfer Header".Remarks)
            {
            }
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Document No.";
                column(TL_ShortcutDimension2Code; "Transfer Line"."Shortcut Dimension 2 Code")
                {
                }
                column(SNo; SNo)
                {
                }
                column(TL_ItemNo; "Transfer Line"."Item No.")
                {
                }
                column(TL_Description; "Transfer Line".Description)
                {
                }
                column(TL_UnitOFMeasure; "Transfer Line"."Unit of Measure")
                {
                }
                column(TL_Quantity; "Transfer Line".Quantity)
                {
                }
                column(TL_QtytoShip; "Transfer Line"."Qty. to Ship")
                {
                }
                column(TL_Amount; "Transfer Line".Amount)
                {
                }
                column(TL_Inventory; "Transfer Line".Inventory)
                {
                }
                column(TL_ShortcutDimension1Code; "Transfer Line"."Shortcut Dimension 1 Code")
                {
                }
                column(TL_ShelfNo; "Transfer Line"."Shelf No.")
                {
                }
                column(LocQty; LocQty)
                {
                }
                column(prep; prep)
                {
                }
                column(TL_DocumentNo; "Transfer Line"."Document No.")
                {
                }
                column(TL_TransfertoCode; "Transfer Line"."Transfer-to Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    SNo += 1;
                    LocQty := 0;
                    RecItem.SETRANGE("No.", "Transfer Line"."Item No.");
                    RecItem.SETRANGE("Location Filter", "Transfer Line"."Transfer-to Code");
                    IF RecItem.FINDFIRST THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        LocQty := RecItem.Inventory;
                    END;

                    prep := "Transfer Header"."Requested By"
                end;

                trigger OnPreDataItem()
                begin
                    SNo := 0;
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

    var
        SNo: Integer;
        LocQty: Decimal;
        RecItem: Record Item;
        prep: Text[50];
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

