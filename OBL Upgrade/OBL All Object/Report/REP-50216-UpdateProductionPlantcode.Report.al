report 50216 "Update Production Plant code"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayouts\UpdateProductionPlantcode.rdl';
    Permissions = TableData "Item Ledger Entry" = rm;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Production Plant Code", "Size Code", "Packing Code", "Posting Date")
                                ORDER(Ascending)
                                WHERE("Production Plant Code" = FILTER(''),
                                      "Item No." = FILTER('@*M' | '@*D' | '@*H'));

            trigger OnAfterGetRecord()
            begin

                Itm.GET("Item No.");
                ILE.GET("Entry No.");
                ILE."Production Plant Code" := Itm."Default Prod. Plant Code";
                IF ILE."Plant Code" = '' THEN
                    ILE."Plant Code" := Itm."Plant Code";
                ILE.MODIFY;
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
        Itm: Record Item;
        ILE: Record "Item Ledger Entry";
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

