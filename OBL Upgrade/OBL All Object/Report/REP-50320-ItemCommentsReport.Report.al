report 50320 "Item Comments Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ItemCommentsReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Inventory Posting Group" = FILTER('<>MANUF'));
            RequestFilterFields = "No.";
            column(No_Item; Item."No.")
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(BaseUnitofMeasure_Item; Item."Base Unit of Measure")
            {
            }
            dataitem("Comment Line"; "Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = WHERE("Table Name" = FILTER(Item));
                column(Comment_CommentLine; "Comment Line".Comment)
                {
                }
                column(LineNo_CommentLine; "Comment Line"."Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF ("Item Category Code" = 'H001') OR ("Item Category Code" = 'D001') OR ("Item Category Code" = 'T001') OR ("Item Category Code" = 'M001') OR ("Item Category Code" = 'SAMPLE') THEN
                    CurrReport.SKIP;
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
}

