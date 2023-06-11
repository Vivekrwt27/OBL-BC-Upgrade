report 50013 RGP
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\RGP.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Header"; 50012)
        {
            DataItemTableView = SORTING("No.", "Document Type")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Out));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Posting Date";
            column(Name_CompInfo; CompInfo.Name + '' + CompInfo."Name 2")
            {
            }
            column(Add_CompInfo; CompInfo.Address + '' + CompInfo."Address 2")
            {
            }
            column(VendorAdd; VendorRec."Name 2" + ' ' + VendorRec.Address + ' ' + VendorRec."Address 2" + ' ' + VendorRec.City)
            {
            }
            column(NameAddVend; "RGP Header"."Name 2" + ' ' + "RGP Header".Address + ' ' + "RGP Header"."Address 2" + ' ' + "RGP Header".City)
            {
            }
            column(cst; cst)
            {
            }
            column(uptt; uptt)
            {
            }
            column(TinNo; TinNo)
            {
            }
            column(Name_RGPHeader; "RGP Header".Name)
            {
            }
            column(Name2_RGPHeader; "RGP Header"."Name 2")
            {
            }
            column(Address_RGPHeader; "RGP Header".Address + '' + "RGP Header"."Address 2")
            {
            }
            column(City_RGPHeader; "RGP Header".City)
            {
            }
            column(TinNo_RGPHeader; "RGP Header"."Tin No.")
            {
            }
            column(VehicleNo_RGPHeader; "RGP Header"."Vehicle No.")
            {
            }
            column(Location_RGPHeader; "RGP Header".Location)
            {
            }
            column(PostingDate_RGPHeader; FORMAT("RGP Header"."Posting Date"))
            {
            }
            column(No; "RGP Header"."No.")
            {
            }
            column(LocationName; LocationRec.Name + ' ' + LocationRec."Name 2")
            {
            }
            column(AddressLocation; LocationRec.Address + ' ' + LocationRec."Address 2")
            {
            }
            column(Locationcity; LocationRec.City + ' ' + LocationRec."State Code" + ' ' + LocationRec."Post Code")
            {
            }
            column(gst; LocationRec."GST Registration No.")
            {
            }
            column(comment; Comment)
            {
            }
            column(vend_gst; vendgst)
            {
            }
            dataitem("RGP Line"; 50013)
            {
                DataItemLink = "RGP No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "RGP No.", "Line No.")
                                    ORDER(Ascending);
                column(Sno2; Sno2)
                {
                }
                column(No_RGPLine; "RGP Line"."No.")
                {
                }
                column(Description_RGPLine; "RGP Line".Description + '' + "RGP Line"."Description 2")
                {
                }
                column(UnitofMeasure_RGPLine; "RGP Line"."Unit of Measure")
                {
                }
                column(Quantity_RGPLine; "RGP Line".Quantity)
                {
                }
                column(ApproximatePrice_RGPLine; "RGP Line"."Approximate Price")
                {
                }
                column(Location_RGPLine; "RGP Line".Location)
                {
                }
                column(Purpose_RGPLine; "RGP Line".Purpose)
                {
                }
                column(ExpectedReceiptDate_RGPLine; FORMAT("RGP Line"."Expected Receipt Date"))
                {
                }
                column(IndentNo; "RGP Line"."Indent No.")
                {
                }
                column(HSNCode_RGPLine; "RGP Line"."HSN Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF "RGP Line".Quantity <> 0 THEN BEGIN
                        "sno." := "sno." + 1;
                        Sno2 := "sno.";
                    END ELSE
                        Sno2 := 0;

                    IF (Quantity = 0) AND (Type <> Type::" ") THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    "sno." := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                location1.SETFILTER(location1.Code, '%1', Location);
                IF location1.FIND('-') THEN BEGIN
                    companyinfo := location1.Address + '' + location1."Address 2";
                    /*  cst := location1."C.S.T. No.";
                      uptt := location1."U.P.T.T. No.";
                      TinNo := location1."T.I.N. No.";*/ // 16630
                END;

                IF LocationRec.GET("RGP Header".Location) THEN;

                IF "RGP Header".Type = "RGP Header".Type::Vendor THEN
                    IF VendorRec.GET("RGP Header".Code) THEN;
                vendgst := VendorRec."GST Registration No.";

                /*
              Comment := '';
              CommentLine.RESET;
              CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"Indent Header");
              CommentLine.SETRANGE("No.", "RGP Header"."Indent No.");
              CommentLine.SETFILTER("Line No.", '<>%1', 0);
              IF CommentLine.FINDFIRST THEN
                REPEAT
                  IF (CommentLine."No." <> '') THEN
                    Comment += CommentLine.Comment + ' ';
                UNTIL CommentLine.NEXT = 0;
                */

                Comment := '';
                RGPLine.RESET;
                RGPLine.SETRANGE("RGP No.", "No.");
                RGPLine.SETFILTER("Indent No.", '<>%1', '');
                IF RGPLine.FINDFIRST THEN
                    REPEAT
                        CommentLine.RESET;
                        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"Indent Header");
                        CommentLine.SETRANGE("No.", RGPLine."Indent No.");
                        IF CommentLine.FINDFIRST THEN
                            REPEAT
                                Comment += CommentLine.Comment + ' ';
                            UNTIL CommentLine.NEXT = 0;
                    UNTIL RGPLine.NEXT = 0;

                /*
                   END ELSE
                   IF RGPLine."Indent No." = '' THEN BEGIN
                      REPEAT
                      CommentLine.RESET;
                      CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::);
                      CommentLine.SETRANGE("No.", "RGP Header"."Indent No.");
                      IF CommentLine.FINDFIRST THEN
                        REPEAT
                          Comment += CommentLine.Comment + ' ';
                        UNTIL CommentLine.NEXT = 0;
                    UNTIL RGPLine.NEXT = 0;
                   END;
                */

            end;

            trigger OnPreDataItem()
            begin
                IF "RGP Header".GETFILTER("RGP Header"."No.") = '' THEN
                    ERROR('Please enter RGP No.');
                CompInfo.GET;
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
        CompInfo: Record "Company Information";
        "sno.": Integer;
        cst: Code[20];
        uptt: Code[20];
        location1: Record Location;
        companyinfo: Text[250];
        Sno2: Integer;
        TinNo: Code[20];
        LocationRec: Record Location;
        VendorRec: Record Vendor;
        CommentLine: Record "Comment Line";
        Comment: Text;
        RGPLine: Record "RGP Line";
        vendgst: Code[20];
}

