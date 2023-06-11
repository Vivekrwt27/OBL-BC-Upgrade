page 50209 "Prod.Reporting Line Subform"
{
    AutoSplitKey = true;
    Caption = 'Production Line Subform';
    CardPageID = "Prod.Reporting Line Subform";
    Editable = true;
    LinksAllowed = true;
    PageType = ListPart;
    SourceTable = "Prod. Reporting Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FG No."; Rec."FG No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF COMPANYNAME = 'Orient Bell Limited' THEN
                            IF ritem.GET(Rec."FG No.") THEN
                                IF (ritem."Production BOM No." = '') AND (ritem."Quality Code" = '1') THEN
                                    ERROR('BOM Not Attached')
                    end;
                }
                field(Shift; Rec.Shift)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }

                field("Qty. in CRT"; Rec."Qty. in CRT.")
                {
                    ApplicationArea = All;
                }
                field("Quantity Produced"; Rec."Quantity Produced")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Finished Quantity"; Rec."Finished Quantity")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Shortcut Dimension 1 Code" := Rec.Location
                    end;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Broken Tiles"; Rec."Broken Tiles")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Commercial Quantity"; Rec."Commercial Quantity")
                {
                    Visible = true;
                    ApplicationArea = All;
                }

                field("Economic Quantity"; Rec."Economic Quantity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Consumption Remaining"; Rec."Consumption Remaining")
                {
                    ApplicationArea = All;
                }
                field("Morbi Batch No."; Rec."Morbi Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    TableRelation = "Reason Code".Code WHERE("Varient Codes" = FILTER(true));
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //IF Location IN  ['DRA-PROD','HSK-PROD'] THEN
                        ERROR('Please MFG. Batch No.');
                    end;
                }
                field("Mfg. Batch No."; Rec."Mfg. Batch No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Production Journal")
            {
                Image = Journal;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ProdReportingLine: Record "Prod. Reporting Line";
                begin
                    ProdReportingLine := Rec;
                    ShowProdJrnl(ProdReportingLine);
                    Rec := ProdReportingLine;
                end;
            }
            action(ShowComponents)
            {
                /* Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true; */
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(ProdRepComponentLines);
                    ProdRepComponentLines.SetDocument(Rec."Document No.", Rec."Line No.");
                    ProdRepComponentLines.RUN;
                end;
            }
        }
    }

    var
        ProdRepComponentLines: Page "Prod. Rep. Component Lines";
        ritem: Record Item;

    local procedure ShowProdJrnl(var ProdReportingLine: Record "Prod. Reporting Line")
    var
        ProdOrder: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
    begin
        /*
        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE(Status,ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.",ProdReportingLine."Prod. Order No.");
        IF ProdOrderLine.FINDFIRST THEN BEGIN
          ReleasedProdOrderLines.SETTABLEVIEW(ProdOrderLine);
          ReleasedProdOrderLines.ShowProductionJournal;
        
        END;
        */

        CurrPage.SAVERECORD;

        ProdOrder.GET(ProdOrder.Status::Released, Rec."Prod. Order No.");

        CLEAR(ProductionJrnlMgt);
        //ProductionJrnlMgt.SetQty("Actual Quantity Produced");
        ProductionJrnlMgt.Handling(ProdOrder, Rec."Prod. Order Line No.");

    end;
}

