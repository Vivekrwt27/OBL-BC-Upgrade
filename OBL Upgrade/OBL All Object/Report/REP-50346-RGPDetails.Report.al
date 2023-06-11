report 50346 "RGP Details"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\RGPDetails.rdl';

    dataset
    {
        dataitem("RGP Header"; "RGP Header")
        {
            DataItemTableView = WHERE(Posted = FILTER(true),
                                      "Document Type" = FILTER(Out));
            RequestFilterFields = "No.", "Posting Date";
            column(Name; "RGP Header".Name)
            {
            }
            column(Location; "RGP Header".Location)
            {
            }
            column(No; "RGP Header"."No.")
            {
            }
            column(PostingDate; "RGP Header"."Posting Date")
            {
            }
            dataitem("RGP Line"; "RGP Line")
            {
                DataItemLink = "RGP No." = FIELD("No."),
                               "Document Type" = FIELD("Document Type");
                DataItemTableView = SORTING("Document Type", "RGP No.", "Line No.")
                                    WHERE("Document Type" = CONST(Out));
                column(SrNo; SrNo)
                {
                }
                column(Description; "RGP Line".Description)
                {
                }
                column(Quantity; "RGP Line".Quantity)
                {
                }
                column(RectQty; RectQty)
                {
                }
                column(RecDate; RecDate)
                {
                }
                column(Pending; "RGP Line".Quantity - RectQty)
                {
                }
                column(CompName; CompInfo.Name)
                {
                }
                column(CompAddress; CompInfo.Address)
                {
                }
                column(PostCode; CompInfo."Post Code")
                {
                }
                column(City; CompInfo.City)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    SrNo += 1;
                    RGPLine.RESET;
                    RGPLine.SETRANGE("Document Type", RGPLine."Document Type"::"In");
                    RGPLine.SETRANGE("RGP Out No.", "RGP No.");
                    RGPLine.SETRANGE("RGP Outline No.", "Line No.");
                    IF RGPLine.FINDFIRST THEN BEGIN
                        RectQty := RGPLine.Quantity;
                        RecDate := RGPLine."Receiving Date";
                    END
                    ELSE BEGIN
                        RectQty := 0;
                        RecDate := 0D;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);
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
        //RepAuditMgt.CreateAudit(50346)
    end;

    var
        SrNo: Integer;
        CompInfo: Record "Company Information";
        RGPLine: Record "RGP Line";
        RectQty: Decimal;
        RecDate: Date;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ExcelBuf: Record "Excel Buffer" temporary;
        printtoexcel: Boolean;
        Text001: Label 'GRP Detail';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
}

