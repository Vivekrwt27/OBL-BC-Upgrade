page 50208 "Prod. Reporting Card"
{
    Caption = 'Production Header Card';
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Prod. Reporting Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Shift; Rec.Shift)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Prod. Units"; Rec."Prod. Units")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
            part(ProductionLine; "Prod.Reporting Line Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");

                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Release)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdReportingHeader: Record "Prod. Reporting Header";
                    begin

                        EVALUATE(gHour_Value, FORMAT(TIME, 0, '<Hours24,2>'));
                        //IF NOT (gHour_Value IN [6,7,8,9,14,15]) THEN
                        IF NOT (gHour_Value IN [6, 7, 8, 9, 14, 15, 22, 23]) THEN
                            //15578   ERROR('Not Allowed');

                            Rec.TESTFIELD(Status, Rec.Status::Open);
                        CLEAR(ProdReportingMgt);
                        ProdReportingHeader := Rec;
                        ProdReportingMgt.PostProdOrder(ProdReportingHeader);
                        Rec := ProdReportingHeader;
                    end;
                }
                action("Post Output")
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdReportingHeader: Record "Prod. Reporting Header";
                    begin
                        EVALUATE(gHour_Value, FORMAT(TIME, 0, '<Hours24,2>'));
                        //IF NOT (gHour_Value IN [6,7,8,9,14,15]) THEN
                        IF NOT (gHour_Value IN [6, 7, 8, 9, 14, 15, 22, 23]) THEN
                            // 15578    ERROR('Not Allowed');

                        rec.TESTFIELD(Status, rec.Status::Released);
                        CLEAR(ProdReportingMgt);
                        ProdReportingHeader := Rec;
                        ProdReportingMgt.ReportOutput(ProdReportingHeader);
                        Rec := ProdReportingHeader;

                        IF rec.Status IN [rec.Status::Open, rec.Status::Closed, rec.Status::Released] THEN
                            ERROR('Status Must be Output Reported/Part. Consume');


                        CLEAR(ProdReportingMgt);
                        ProdReportingHeader := Rec;
                        ProdReportingMgt.ReportConsumption(ProdReportingHeader);
                        Rec := ProdReportingHeader;

                        //MESSAGE('Under WIP');
                        IF rec.Status = rec.Status::"Consumption Done" THEN BEGIN
                            CLEAR(ProdReportingMgt);
                            ProdReportingHeader := Rec;
                            ProdReportingMgt.CloseDocument(ProdReportingHeader);
                            Rec := ProdReportingHeader;
                            //Message('Done');
                        END;

                        CurrPage.SaveRecord;
                    end;
                }
                action("Post Consumption")
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdReportingHeader: Record "Prod. Reporting Header";
                    begin
                        //15578 EVALUATE(gHour_Value, FORMAT(TIME, 0, '<Hours24,2>'));
                        //IF NOT (gHour_Value IN [6,7,8,9,14,15]) THEN
                        // IF NOT (gHour_Value IN [6, 7, 8, 9, 14, 15, 22, 23]) THEN
                        //15578    ERROR('Not Allowed');

                        IF rec.Status IN [rec.Status::Open, rec.Status::Closed, rec.Status::Released] THEN
                            ERROR('Status Must be Output Reported/Part. Consume');

                        CLEAR(ProdReportingMgt);
                        ProdReportingHeader := Rec;
                        ProdReportingMgt.ReportConsumption(ProdReportingHeader);
                        Rec := ProdReportingHeader;


                        IF rec.Status = rec.Status::"Consumption Done" THEN BEGIN
                            CLEAR(ProdReportingMgt);
                            ProdReportingHeader := Rec;
                            ProdReportingMgt.CloseDocument(ProdReportingHeader);
                            Rec := ProdReportingHeader;

                        END;
                    end;
                }
                action("Close Document")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdReportingHeader: Record "Prod. Reporting Header";
                    begin
                        //MESSAGE('Under WIP');
                        Rec.TESTFIELD(Status, Rec.Status::"Consumption Done");
                        CLEAR(ProdReportingMgt);
                        ProdReportingHeader := Rec;
                        ProdReportingMgt.CloseDocument(Rec);
                        Rec := ProdReportingHeader;
                    end;
                }
            }
            group(Navigate)
            {
                action("Release Production Orders")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Released Production Order";
                    RunPageLink = "Prod. Reporting No." = FIELD("No.");

                    RunPageView = SORTING(Status, "No.");
                    ApplicationArea = All;
                }
                action("Finished Prod. Order")
                {
                    RunObject = Page "Finished Production Orders";
                    RunPageLink = "Prod. Reporting No." = FIELD("No.");
                    RunPageView = SORTING(Status, "No.");
                    ApplicationArea = All;
                }
                action("Show Prod. Components")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProdRepComponentLines: Page "Prod. Rep. Component Lines";
                    begin
                        CLEAR(ProdRepComponentLines);
                        ProdRepComponentLines.SetDocument(Rec."No.", 0);
                        ProdRepComponentLines.RUN;
                    end;
                }
            }
        }
    }

    var
        ProdReportingMgt: Codeunit "Prod. Reporting Mgt.";
        gHour_Value: Decimal;
}

