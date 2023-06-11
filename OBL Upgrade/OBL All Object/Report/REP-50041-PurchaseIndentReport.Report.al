report 50041 "Purchase Indent Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseIndentReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Indent Header"; 50016)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(ConsDate; ConsDate)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(Description; "Indent Header".Description)
            {
            }
            column(IndentDt; FORMAT("Indent Header"."Indent Date"))
            {
            }
            column(IndentNo; "Indent Header"."No.")
            {
            }
            column(Text0002; Text0002)
            {
            }
            column(Text0003; Text0003)
            {
            }
            column(Text0004; Text0004)
            {
            }
            column(IndDate; "Indent Header"."Indent Date")
            {
            }
            column(Text0005; Text0005)
            {
            }
            column(Text0006; Text0006)
            {
            }
            column(amt; "Indent Header".Amount)
            {
            }
            dataitem("Indent Line"; 50017)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(Sno1; Sno1)
                {
                }
                column(IndentNoLine; "Indent Line"."No.")
                {
                }
                column(Desc; "Indent Line".Description)
                {
                }
                column(Desc2; "Indent Line"."Description 2")
                {
                }
                column(UOM; "Indent Line"."Unit of Measurement")
                {
                }
                column(ItemGrade; ItemGrade)
                {
                }
                column(ReorderLabel; ReorderLabel)
                {
                }
                column(PresentStock; PresentStock)
                {
                }
                column(Consumption; Consumption)
                {
                }
                column(Last4MonthCon; Last4MonthCon)
                {
                }
                column(Quantity; "Indent Line".Quantity)
                {
                }
                column(Rate; "Indent Line".Rate)
                {
                }
                column(DueDate; "Indent Line"."Due Date")
                {
                }
                column(IndentHdrRemark; "Indent Header".Remarks)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //IF ("New Item" OR (Type <> Type::" ")) THEN
                    SNo := SNo + 1;
                    Sno1 := SNo;
                    //calculation of present stock

                    IF Item.GET("No.") THEN
                        IF (NOT Item."Inventory Value Zero") THEN BEGIN
                            PresentStock := 0;
                            //MSNK START 010715
                            RecILE.RESET;
                            RecILE.SETRANGE("Item No.", "No.");
                            RecILE.SETRANGE("Location Code", "Location Code");
                            IF RecILE.FINDFIRST THEN BEGIN
                                REPEAT
                                    PresentStock += RecILE."Remaining Quantity";
                                UNTIL RecILE.NEXT = 0;
                            END;
                        END;
                    //MSNK STOP 010715
                    Item.RESET;
                    IF "No." <> '' THEN BEGIN
                        IF Item.GET("Indent Line"."No.") THEN BEGIN
                            //    Item.SETRANGE(Item."Date Filter",0D,"Indent Line".Date);

                            // Item.CALCFIELDS("Net Change");
                            //   PresentStock := Item."Net Change";
                        END;

                        /*
                        //Item.SETFILTER("Location Filter",'%1',"Location Code");
                        IF Location1.GET("Indent Line"."Location Code") THEN BEGIN
                          IF Location1."Main Location" <> '' THEN
                            Item.SETFILTER("Location Filter",'%1|%2',Location1."Main Location","Location Code")
                          ELSE
                            Item.SETFILTER("Location Filter",'%1',"Location Code");
                        END;
                        */

                        //Calculation of consumption in current year
                        Consumption := 0;
                        CurrYear := DATE2DMY("Indent Line".Date, 3);
                        DateFilter := FORMAT(DMY2DATE(1, 4, CurrYear)) + '..' + FORMAT(DMY2DATE(31, 3, CurrYear + 1));
                        ILE.RESET;
                        ILE.SETFILTER("Item No.", "No.");
                        ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                        ILE.SETFILTER("Posting Date", DateFilter);
                        /*
                        //ILE.SETFILTER("Location Code",'%1',"Location Code");
                        IF Location1.GET("Indent Line"."Location Code") THEN BEGIN
                          IF Location1."Main Location" <> '' THEN
                            ILE.SETFILTER("Location Code",'%1|%2',Location1."Main Location","Location Code")
                          ELSE
                            ILE.SETFILTER("Location Code",'%1',"Location Code");
                        END;
                        */
                        IF ILE.FIND('-') THEN
                            REPEAT
                                Consumption += ABS(ILE.Quantity);
                            UNTIL ILE.NEXT = 0;

                        //TSPL SA 201210 START
                        ILE1.RESET;
                        ILE1.SETFILTER("Item No.", "No.");
                        ILE1.SETRANGE("Entry Type", ILE1."Entry Type"::"Negative Adjmt.");
                        ILE1.SETRANGE("Direct Consumption Entries", TRUE);
                        ILE1.SETFILTER("Posting Date", DateFilter);
                        IF ILE1.FIND('-') THEN
                            REPEAT
                                Consumption += ABS(ILE1.Quantity);
                            UNTIL ILE1.NEXT = 0;
                        //TSPL SA 201210 END

                        Item.RESET;
                        IF Item.GET("Indent Line"."No.") THEN
                            ReorderLabel := FORMAT(Item."Reordering Policy");

                        //Calculation of consumption for last 4 months
                        year := CurrYear;
                        CurrDate := DATE2DMY("Indent Line".Date, 1);
                        CurrMonth := DATE2DMY("Indent Line".Date, 2);
                        IF ((CurrMonth = 1) OR (CurrMonth = 2) OR (CurrMonth = 3)) THEN BEGIN
                            year := year - 1;
                            IF CurrMonth = 1 THEN
                                Mon := 9;
                            IF CurrMonth = 2 THEN
                                Mon := 10;
                            IF CurrMonth = 3 THEN
                                Mon := 11;
                            //message('%1 = %2 = %3', CurrDate, Mon, year);
                            // DateFilter := FORMAT(DMY2DATE(CurrDate,Mon,year)) + '..' + FORMAT("Indent Line".Date); //MSVRN /010218 blocked
                            //MSVRN /010218 >>
                            IF (Mon = 9) AND (CurrDate = 31) THEN
                                DateFilter := FORMAT(DMY2DATE(CurrDate - 1, Mon, year)) + '..' + FORMAT("Indent Line".Date)
                            ELSE
                                //MSVRN /010218 <<
                                DateFilter := FORMAT(DMY2DATE(CurrDate, Mon, year)) + '..' + FORMAT("Indent Line".Date);
                        END ELSE BEGIN
                            DateFilter := FORMAT(CALCDATE('-4M', "Indent Line".Date)) + '..' + FORMAT("Indent Line".Date);
                        END;

                        Last4MonthCon := 0;
                        ILE.RESET;
                        ILE.SETFILTER("Item No.", "No.");
                        ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                        ILE.SETFILTER("Posting Date", DateFilter);
                        IF ILE.FIND('-') THEN
                            REPEAT
                                Last4MonthCon += ABS(ILE.Quantity);
                            UNTIL ILE.NEXT = 0;

                        //TSPL SA 201210 START
                        ILE1.RESET;
                        ILE1.SETFILTER("Item No.", "No.");
                        ILE1.SETRANGE("Entry Type", ILE1."Entry Type"::"Negative Adjmt.");
                        ILE1.SETRANGE("Direct Consumption Entries", TRUE);
                        ILE1.SETFILTER("Posting Date", DateFilter);
                        IF ILE1.FIND('-') THEN
                            REPEAT
                                Last4MonthCon += ABS(ILE1.Quantity);
                            UNTIL ILE1.NEXT = 0;
                        //TSPL SA 201210 END

                    END;
                    IF ("Indent Line".Rate * "Indent Line".Quantity) >= 10000 THEN
                        ItemGrade := 'A'
                    ELSE
                        IF ("Indent Line".Rate * "Indent Line".Quantity) >= 5000 THEN
                            ItemGrade := 'B'
                        ELSE
                            IF ("Indent Line".Rate * "Indent Line".Quantity) > 0 THEN
                                ItemGrade := 'C'
                            ELSE
                                ItemGrade := '';

                    Commentline.RESET;
                    Commentline.SETRANGE("No.", "No.");
                    IF BlnComment = TRUE THEN
                        Abc := 'Com:-'
                    ELSE
                        Abc := '';

                    //
                    /* //6823
                    IF NOT ("New Item" OR (Type <> Type::" ")) THEN BEGIN
                      CurrReport.SHOWOUTPUT(FALSE);
                      Sno1 := 0;
                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin

                    //IF NOT ("New Item" OR (Type <> Type::" ")) THEN BEGIN
                    IF NOT ("New Item") THEN BEGIN
                        Sno1 := 0;
                    END;
                end;
            }
            dataitem("Comment Line1"; 97)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(CM1Coment; "Comment Line1".Comment)
                {
                }
                dataitem("Comment Line"; 97)
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("No.")
                                        ORDER(Ascending);
                    column(CMComent; "Comment Line".Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    /*   IF BlnComment = TRUE THEN
                           CurrReport.SHOWOUTPUT := TRUE
                       ELSE
                           CurrReport.SHOWOUTPUT := FALSE;*/ // 16630
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ConsDate := 'Fyr # ' + FORMAT(DATE2DMY("Indent Header"."Indent Date", 3));     //6823
            end;

            trigger OnPreDataItem()
            begin
                ConsDate := '';
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
        //RepAuditMgt.CreateAudit(50041)
    end;

    trigger OnPreReport()
    begin
        WORKDATE := TODAY;
        CompanyInfo.GET;
    end;

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        PresentStock: Decimal;
        Consumption: Decimal;
        CurrYear: Integer;
        DateFilter: Text[30];
        CurrMonth: Integer;
        ReorderLabel: Text[30];
        SNo: Integer;
        Mon: Integer;
        year: Integer;
        Last4MonthCon: Decimal;
        Text1: Text[30];
        Location1: Record Location;
        ItemGrade: Text[3];
        Sno1: Integer;
        CurrDate: Integer;
        ILE1: Record "Item Ledger Entry";
        Commentline: Record "Comment Line";
        BlnComment: Boolean;
        Abc: Text[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        RecILE: Record "Item Ledger Entry";
        Text0001: Label 'Delivery required by (specify) : WITHIN 10 DAYS';
        Text0002: Label 'Grade "A" = Value > Rs. 10,000/- , Grade "B" = Value => Rs. 5,000 and value < Rs. 10,000/-';
        Text0003: Label 'Grade "C" = value < Rs. 5,000/-, Grade " "= Value = 0';
        Text0004: Label 'Deptt Head';
        Text0005: Label 'Stores Deptt';
        Text0006: Label 'Authorozation 1';
        Text0007: Label 'Authorozation 2';
        ConsDate: Text;
}

