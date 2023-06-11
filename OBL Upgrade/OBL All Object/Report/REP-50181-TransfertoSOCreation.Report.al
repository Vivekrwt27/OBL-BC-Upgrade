report 50181 "Transfer to SO Creation"
{
    // <MIPL 13012020>

    Permissions = TableData "Sales Header" = rimd,
                  TableData "Sales Line" = rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer SO Sales Header"; 50100)
        {
            DataItemTableView = WHERE("Sales Order Created" = FILTER(false),
                                      "Location Code" = FILTER(<> ''),
                                      Status = FILTER(1));
            RequestFilterFields = "No.", "Location Code";
            column(HdrID; "Transfer SO Sales Header".Id)
            {
            }
            column(DocNo; "Transfer SO Sales Header"."No.")
            {
            }
            dataitem("Transfer SO Line"; 50101)
            {
                DataItemLink = "No." = FIELD("No.");
                column(ItemNo; "Transfer SO Line"."Item No")
                {
                }
                column(LineNo; "Transfer SO Line".LineID)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    LineNo += 10000;
                    SalesLine.INIT;
                    SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.VALIDATE("Document No.", SODocNo);
                    SalesLine."Line No." := LineNo;
                    //SalesLine.INSERT(TRUE);
                    SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", "Transfer SO Line"."Item No");
                    //SalesLine."Location Code" := "Location Code";
                    SalesLine.VALIDATE("Quantity in Cartons", "Transfer SO Line"."Quantity in Carton");
                    SalesLine.VALIDATE("Quantity in Sq. Mt.", "Transfer SO Line"."Quantity in sqmt");
                    SalesLine."Transfer Line No." := LineID;
                    //SalesLine.D7 := "Transfer SO Line";
                    //SalesLine.VALIDATE(D7);
                    SalesLine.INSERT(TRUE);
                    //SalesLine.MODIFY;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            var
                StrSalesHeader: Record "Sales Header";
                LocalSalesLine, LocalSalesLine1 : Record "Sales Line";
                CalculateTax: Codeunit "Calculate Tax";
                SalesTaxCalculationBeforePost: Codeunit "Sales Before Post Tax Calculat";
            begin
                LineNo := 0;
                SODocNo := '';//SODRA
                SODocNo := NoSeriesManagement.GetNextNo(GetNoSeriesCode("Location Code"), TODAY, TRUE);

                SalesHeader.INIT;
                SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.VALIDATE("No.", SODocNo);
                SalesHeader.INSERT;

                /*
                IF NOT transporter.GET(SalesHeader."No.") THEN BEGIN
                  transporter.INIT;
                  transporter."Document No.":=SalesHeader."No.";
                  transporter.INSERT;
                END;
                */

                SalesHeader.VALIDATE("Sell-to Customer No.", "Transfer SO Sales Header"."Sell-to Customer No.");
                SalesHeader.VALIDATE("Order Booked Date", CURRENTDATETIME);
                SalesHeader.VALIDATE("Requested Delivery Date", TODAY);
                SalesHeader.VALIDATE("Promised Delivery Date", TODAY);
                SalesHeader.VALIDATE("Make Order Date", CURRENTDATETIME);

                SalesHeader.VALIDATE("Group Code", "Transfer SO Sales Header"."Group Code");

                IF "Transfer SO Sales Header"."Vehicle Provided" = 1 THEN
                    SalesHeader.VALIDATE("Shipping Agent Code", 'PARTYVEH')
                ELSE
                    SalesHeader.VALIDATE("Shipping Agent Code", "Transfer SO Sales Header"."Vehicle Code");


                SalesHeader.VALIDATE("Discount Charges %", "Transfer SO Sales Header"."Discount Percentage");

                SalesHeader.VALIDATE("Location Code", "Location Code");
                //SalesHeader.VALIDATE("No.");
                SalesHeader.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                SalesHeader.VALIDATE("No. Series", GetNoSeriesCode("Location Code"));
                SalesHeader.VALIDATE("Posting No. Series", GetPostingNo("Location Code"));
                SalesHeader.VALIDATE("Sales Type", "Sales Type");
                //SalesHeader.VALIDATE(Pay, Pay);
                SalesHeader.VALIDATE("ORC Terms", "ORC Terms");
                IF "Transfer SO Sales Header"."Dealer's Salesperson Code" = 'NONE' THEN
                    "Transfer SO Sales Header"."Dealer's Salesperson Code" := ''
                ELSE
                    SalesHeader.VALIDATE("Dealer Code", "Dealer's Salesperson Code");

                // 16630 SalesHeader.VALIDATE(Structure);
                SalesHeader.BD := Set;
                SalesHeader.VALIDATE("Business Development", "Transfer SO Sales Header"."Specified Ent Team");
                SalesHeader.CKA := Pet;
                SalesHeader.VALIDATE("CKA Code", "Transfer SO Sales Header"."Private Ent Team");
                SalesHeader.GPS := Get;
                SalesHeader.VALIDATE("Govt. Project Sales", "Transfer SO Sales Header"."Govt Ent Team");
                SalesHeader.None := None;
                SalesHeader."PMT Code" := "PMT Code";
                SalesHeader."Ship-to Address" := "Transfer SO Sales Header"."Ship-to Address";
                SalesHeader."Ship-to Address 2" := "Transfer SO Sales Header"."Ship-to Address 2";
                SalesHeader."Ship-to City" := "Transfer SO Sales Header"."Ship-to City";
                SalesHeader."Ship-to Post Code" := "Transfer SO Sales Header"."Ship-to Post Code";
                SalesHeader."GST Ship-to State Code" := "Transfer SO Sales Header"."State Code";
                SalesHeader."Ship to Pin" := "Transfer SO Sales Header"."Ship to Pin Code";
                SalesHeader."Ship-to Contact" := "Transfer SO Sales Header"."Ship-to Contact";
                SalesHeader.Remarks := "Transfer SO Sales Header"."Your Reference";
                SalesHeader."Transport Method" := 'ROAD';

                // 16630IF SalesHeader.State = '19' THEN
                // 16630   SalesHeader.VALIDATE(Structure, 'GST+FD+TD');

                IF SalesHeader."Discount Charges %" < 0 THEN BEGIN
                    SalesHeader."Payment Terms Code" := '0'
                END ELSE BEGIN
                    PaymentTermsLocationWise.RESET;
                    PaymentTermsLocationWise.SETRANGE("Location Code", SalesHeader."Location Code");
                    PaymentTermsLocationWise.SETRANGE("State Code", SalesHeader.State);
                    IF PaymentTermsLocationWise.FINDFIRST THEN BEGIN
                        SalesHeader."Payment Terms Code" := PaymentTermsLocationWise."Payment Terms Code";
                    END;
                END;

                IF (SalesHeader."Customer Type" = 'PROJECT') AND (SalesHeader."Customer Type" = 'MISC.') THEN
                    SalesHeader."Payment Terms Code" := '0';

                //Keshav

                SalesHeader."Transfer No." := "No.";
                SalesHeader.MODIFY;

                TransferSOLine.RESET;
                TransferSOLine.SETFILTER("No.", "No.");

                IF TransferSOLine.FINDSET THEN
                    REPEAT
                        LineNo += 10000;
                        SalesLine.INIT;
                        SalesLine."Line No." := LineNo;
                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.VALIDATE("Document No.", SODocNo);
                        SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                        SalesLine."GST Place of Supply" := SalesLine."GST Place of Supply"::"Bill-to Address";
                        SalesLine."Calculate TCS" := TRUE;
                        SalesLine.INSERT;
                        SalesLine.VALIDATE("No.", TransferSOLine."Item No");
                        SalesLine."Transfer No." := TransferSOLine."No.";
                        SalesLine."Transfer Line No." := TransferSOLine.LineID;
                        SalesLine.VALIDATE("Location Code", "Location Code");

                        SalesLine.VALIDATE("Itemr Change Remarks", 'ICR00001');
                        IF reas1.GET(SalesLine."Itemr Change Remarks") THEN
                            SalesLine."Itemr Change Remarks" := reas1.Description;

                        SalesLine.VALIDATE("Quantity in Cartons", TransferSOLine."Quantity in Carton");
                        SalesLine.VALIDATE("Quantity in Sq. Mt.", TransferSOLine."Quantity in sqmt");
                        SalesLine.VALIDATE(Quantity, TransferSOLine."Quantity in Carton");
                        SalesLine.VALIDATE(Amount);
                        SalesLine.VALIDATE(D7, TransferSOLine."Total Discount sqmt");
                        SalesLine.VALIDATE(D6, (TransferSOLine.ORC * -1));
                        SalesLine.VALIDATE(S1, (TransferSOLine.Freight * -1));
                        //SalesLine.VALIDATE("AD Remarks",'CODE8');

                        SalesLine.MODIFY;
                        IF SalesLine."No." <> '' THEN
                            //IF NOT (SalesLine."Location Code" IN ['SKD-WH-MFG']) THEN
                             SalesLine.AutoReserveModified;//15578
                        TransferSOLine."Sales Order Created" := TRUE;
                        TransferSOLine.MODIFY;

                    UNTIL TransferSOLine.NEXT = 0;

                TransferSOSalesHeader.RESET;
                TransferSOSalesHeader.SETRANGE("No.", "No.");
                IF TransferSOSalesHeader.FINDFIRST THEN BEGIN
                    TransferSOSalesHeader."Sales Order Created" := TRUE;
                    TransferSOSalesHeader."Sales Order No." := SalesHeader."No.";
                    TransferSOSalesHeader.MODIFY;
                    //MSKS
                    IF StrSalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.") THEN BEGIN
                        //  StrSalesHeader.CALCFIELDS("Amount to Customer");
                        /*  StrSalesHeader.VALIDATE(Structure, SalesHeader.Structure);
                          SalesLine.CalculateStructures(StrSalesHeader);
                          SalesLine.AdjustStructureAmounts(StrSalesHeader);
                          SalesLine.UpdateSalesLines(StrSalesHeader);
                          SalesLine.CalculateTCS(StrSalesHeader);*/
                        //  StrSalesHeader.SendForApproval;
                        //LocalSalesLine1.Reset;


                        //Tax Calculation
                        LocalSalesLine1.Reset;
                        if LocalSalesLine1.FindFirst then;

                        StrSalesHeader.Reset;
                        StrSalesHeader.SetRange("No.", SODocNo);
                        if StrSalesHeader.FindFirst then begin
                            LocalSalesLine.Reset;
                            LocalSalesLine.SetRange("Document No.", StrSalesHeader."No.");
                            if LocalSalesLine.FindFirst then begin
                                repeat
                                    CalculateTax.CallTaxEngineOnSalesLine(LocalSalesLine, LocalSalesLine1);
                                    SalesTaxCalculationBeforePost.CalculateTax(StrSalesHeader);
                                until LocalSalesLine.Next = 0;
                            end;
                        end;
                        //Tax Calculation

                        StrSalesHeader.MODIFY;
                    END;
                    //MSKS;
                END;
                // MESSAGE('Sales Order No. %1 has been successfully created!', SODocNo);

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

    trigger OnInitReport()
    begin
        //IF (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'IT005') THEN
        //  ERROR(' ');
    end;

    trigger OnPreReport()
    begin
        // REPORT.RUN(50306,FALSE,FALSE);
    end;

    var
        NoSeries: Record "No. Series";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SODocNo: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        TransferSOLine: Record "Transfer SO Line";
        TransferSOSalesHeader: Record "Transfer SO Sales Header";
        reas1: Record "Reason Code";
        PaymentTermsLocationWise: Record "Payment Terms Location Wise";

    local procedure GetNoSeriesCode(LocCode: Text) NoSrCode: Code[20]
    var
        NoSeries: Record "No. Series";
        SOImpExp: Text;
    begin
        IF "Transfer SO Sales Header"."Sell-to Country/Region Code" = '01' THEN BEGIN
            NoSeries.RESET;
            NoSeries.SETRANGE("Sales Imp. or Exp.", NoSeries."Sales Imp. or Exp."::Domestic);
            NoSeries.SETRANGE(Location, LocCode);
            IF NoSeries.FINDFIRST THEN
                NoSrCode := NoSeries.Code;
        END ELSE BEGIN
            NoSeries.RESET;
            NoSeries.SETRANGE("Sales Imp. or Exp.", NoSeries."Sales Imp. or Exp."::Import);
            NoSeries.SETRANGE(Location, LocCode);
            IF NoSeries.FINDFIRST THEN
                NoSrCode := NoSeries.Code;
        END;
    end;

    local procedure GetPostingNo(Location: Text) PostingNo: Code[20]
    var
        NoSeries: Record "No. Series";
        SOImpExp: Text;
    begin
        IF "Transfer SO Sales Header"."Sell-to Country/Region Code" = '01' THEN BEGIN
            NoSeries.RESET;
            NoSeries.SETRANGE("Sales Imp. or Exp.", NoSeries."Sales Imp. or Exp."::Domestic);
            NoSeries.SETRANGE(Location, Location);
            IF NoSeries.FINDFIRST THEN
                PostingNo := NoSeries."Posted Invoice No. Series";
        END ELSE BEGIN
            NoSeries.RESET;
            NoSeries.SETRANGE("Sales Imp. or Exp.", NoSeries."Sales Imp. or Exp."::Import);
            NoSeries.SETRANGE(Location, Location);
            IF NoSeries.FINDFIRST THEN
                PostingNo := NoSeries."Posted Invoice No. Series";
        END;
    end;
}