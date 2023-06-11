pageextension 50115 pageextension50115 extends "Inward Gate Entry"
{
    layout
    {
        /* modify("Control 1500023")
         {
             Visible = false;
         }*/
        addafter("No.")
        {
            field("Vendor No"; rec."Vendor No")
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; rec."Vendor Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter("Document Time"; "Vehicle No.")
        addafter("Document Time")
        {
            field("Reporting Date"; rec."Reporting Date")
            {
                ApplicationArea = All;
            }
            field("Reporting Time"; rec."Reporting Time")
            {
                ApplicationArea = All;
            }
            field("Vehicle In Time"; rec."Vehicle In Time")
            {
                ApplicationArea = All;
            }
            field("Vehicle Out Time"; rec."Vehicle Out Time")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        modify("Po&st")
        {
            trigger OnBeforeAction()
            begin
                IF (rec."Vehicle Out Time" = 0DT) THEN  //Tcpl::shiv  code added
                    ERROR(Text16502);                    //Tcpl::shiv code added



                GateEntryLine.RESET;
                GateEntryLine.SETRANGE("Entry Type", rec."Entry Type");
                GateEntryLine.SETRANGE("Gate Entry No.", rec."No.");
                GateEntryLine.SETFILTER(GateEntryLine."Gate Pass Qty", '>%1', 0); //TCPL-7632-240516
                IF NOT GateEntryLine.FIND('-') THEN
                    ERROR(Text16500);

            end;
        }



        addfirst(navigation)
        {
            group("&Gate Entry")
            {
                Caption = '&Gate Entry';
            }
            action("&Get Purchase Line")
            {
                Caption = '&Get Purchase Line';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GateEntry2.RESET;
                    GateEntry2.SETFILTER(GateEntry2."Gate Entry No.", rec."No.");

                    IF GateEntry2.FIND('+') THEN
                        LineNo1 := GateEntry2."Line No.";

                    PurchLine.RESET;
                    PurchLine.SETCURRENTKEY(PurchLine."Document No.", "Line No.");
                    PurchLine.SETFILTER(PurchLine."Buy-from Vendor No.", rec."Vendor No");

                    IF PAGE.RUNMODAL(50057, PurchLine) = ACTION::LookupOK THEN BEGIN

                        PurchLineList.GETRECORD(PurchLine);
                        PurchLine.SETFILTER(PurchLine."Buy-from Vendor No.", Rec."Vendor No");
                        PurchLine.SETFILTER(PurchLine."Selection.", '%1', TRUE);
                        IF PurchLine.FIND('-') THEN
                            REPEAT
                                PurchLine."Selection." := FALSE;

                                PurchLine.MODIFY;
                                LineNo1 := LineNo1 + 10000;
                                IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
                                    GateEntry2."Source Type" := GateEntry2."Source Type"::"Purchase Order";
                                    GateEntry2.VALIDATE(GateEntry2."Entry Type", GateEntry2."Entry Type"::Inward);
                                    GateEntry2.VALIDATE(GateEntry2."Line No.", LineNo1);
                                    GateEntry2.VALIDATE(GateEntry2."Source No.", PurchLine."Document No.");
                                    GateEntry2.VALIDATE(GateEntry2."Vendor No", PurchLine."Buy-from Vendor No.");
                                    vendor.RESET;
                                    vendor.SETRANGE(vendor."No.", PurchLine."Buy-from Vendor No.");
                                    IF vendor.FIND('-') THEN
                                        GateEntry2."Source Name" := vendor.Name;

                                    GateEntry2.VALIDATE(GateEntry2."Item No", PurchLine."No.");
                                    GateEntry2.VALIDATE(GateEntry2."Order Qty", PurchLine.Quantity);
                                    GateEntry2.VALIDATE(GateEntry2."Item Description", PurchLine.Description);

                                    IF CONFIRM('Do you want to use Purchase Line Item?', TRUE) THEN
                                        GateEntry2.INSERT(TRUE);

                                END;


                            UNTIL PurchLine.NEXT = 0;

                    END;
                end;
            }

        }
        addafter("Po&st")
        {
            group(Print)
            {
                Caption = 'Print';
                action("Gate Entry Slip")
                {
                    Caption = 'Gate Entry Slip';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        GateEntryHeader.RESET;
                        GateEntryHeader.SETRANGE(GateEntryHeader."No.", rec."No.");
                        GateentryReport.SETTABLEVIEW(GateEntryHeader);
                        GateentryReport.RUN;
                    end;
                }
            }
        }



    }

    var

        GateEntryLine: Record "Gate Entry Line";
        Text16500: Label 'There is nothing to post.';
        Text16502: Label 'Out Time should be Mention';

        // GateEntryLocSetup: Record 16554;
        NoSeriesMgt: Codeunit 396;
        GateEntry2: Record "Gate Entry Line";
        LineNo1: Integer;
        PurchLine: Record 39;
        PurchLineList: Page 50057;
        GateEntryHeader: Record "Gate Entry Header";
        vendor: Record 23;
        GateentryReport: Report "Gate Entry";
}

