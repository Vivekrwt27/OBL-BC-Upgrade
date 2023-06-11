report 50112 "General Ledger"
{
    // 
    // //-------------------------------------------------------------------------------
    // //-- Multi Balancing Option Tri 18.1 (Pahul Gupta)
    // //-------------------------------------------------------------------------------
    // //-- 1. Tri18.1 PG 13112006
    // //-- Data Item ( G/L Entry ) Table View Changed
    // //-- SORTING(G/L Account No.,Year,Month,Posting Date,Transaction No.) ORDER(Ascending)
    // 
    // //-- 2. Tri18.1 PG 13112006
    // //-- Data Item ( G/L Entry ) Group Total Field Changed
    // //-- G/L Account No.,Year,Month,Posting Date
    // 
    // 
    // //-- 3. Tri18.1 PG 13112006
    // //-- New Global Variable Added "Balance Option" Type Option ("Range,Day,Month,Year")
    // 
    // //-- 4. Tri18.1 PG 13112006
    // //-- Global Variable "Balance Option" Located on Request Form
    // 
    // 
    // //-- 5. Tri18.1 PG 13112006
    // //-- New Code Added In "G/L Entry, GroupHeader (6) - OnPreSection()" Trigger
    // 
    // //- 6. Tri18.1 PG 13112006
    // //-- New Code Added In "G/L Entry, GroupFooter (9) - OnPreSection()" Trigger
    // //-------------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\GeneralLedger.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Company Information"; 79)
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            column(Name; "Company Information".Name)
            {
            }
            column(Name2; "Company Information"."Name 2")
            {
            }
            column(Address; "Company Information".Address)
            {
            }
            column(Address2; "Company Information"."Address 2")
            {
            }
            column(City; City)
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PhoneNo; "Company Information"."Phone No.")
            {
            }
            column(FormatDate; FORMAT(TODAY, 0, 4))
            {
            }
            column(PageNo; CurrReport.PAGENO)
            {
            }
            column(Summary_Field; summary)
            {
            }
        }
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "G/L Account No.", "Posting Date", "Global Dimension 2 Code";
            column(DateFilter; FORMAT(fromdate) + '   to   ' + FORMAT(todate))
            {
            }
            column(acntnmbr; "G/L Account No.")
            {
            }
            column(AccDescription; accountDescription)
            {
            }
            column(OpBalDebit; OpBalanceDebit)
            {
            }
            column(opnblnccredit; OpBalanceCredit)
            {
            }
            column(postingdate; FORMAT("Posting Date"))
            {
            }
            column(DocNo; "Document No.")
            {
            }
            column(Description1; Description)
            {
            }
            column(Extndocsnmbr; "External Document No.")
            {
            }
            column(Desciption2; "G/L Entry"."Description 2")
            {
            }
            column(blnceoption; "Balance Option")
            {
            }
            column(TotalDebit1; TotalDebit)
            {
            }
            column(TotalCredit1; TotalCredit)
            {
            }
            column(ClosingBalDebit; clBalancedebit)
            {
            }
            column(ClosingBalCredit; clBalancecredit)
            {
            }
            column(BalDebit; Balancedebit)
            {
            }
            column(BalCredit; Balancecredit)
            {
            }
            dataitem("Document Loop"; 17)
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Posting Date")
                                    ORDER(Ascending);
                column(AccNo; "G/L Account No.")
                {
                }
                column(Account_Desc; accDescription)
                {
                }
                column(Amount; ABS(Amount))
                {
                }
                column(CrDrTxt; CRDRText)
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(Creditamnt; "Credit Amount")
                {
                }
                column(DebtAmt; DebtAmt)
                {
                }
                column(CretAmt; CretAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNoTmep += 1;

                    IF SNoTmep > 1 THEN BEGIN
                        CLEAR(DebtAmt);
                        //CLEAR(CretAmt);
                    END;
                    //MESSAGE('%1  ok  %2  Yes   %3',CretAmt,SNoTmep,DebtAmt);
                    IF "Document Loop"."Entry No." = "G/L Entry"."Entry No." THEN CurrReport.SKIP;
                end;

                trigger OnPostDataItem()
                begin

                    GlAccount1.SETRANGE("No.", "G/L Account No.");
                    IF GlAccount1.FIND('-') THEN
                        accDescription := GlAccount.Name
                    ELSE
                        accDescription := '';


                    IF "Document Loop".Amount < 0 THEN CRDRText := 'Cr.' ELSE CRDRText := 'Dr.';

                    DebtAmt := "Debit Amount";
                    CretAmt := "Credit Amount";
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(SNoTmep);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                DebtAmt := 0;
                CretAmt := 0;
                GlAccount.SETRANGE(GlAccount."No.", "G/L Entry"."G/L Account No.");
                IF GlAccount.FIND('-') THEN
                    accountDescription := GlAccount.Name
                ELSE
                    accountDescription := '';

                //-- 5. Tri18.1 PG 13112006 -- Start
                IF "Balance Option" = "Balance Option"::Day THEN BEGIN
                    /*  CurrReport.SHOWOUTPUT :=
                         CurrReport.TOTALSCAUSEDBY = "G/L Entry".FIELDNO("Posting Date");*/ // 16630
                END
                ELSE
                    IF "Balance Option" = "Balance Option"::Month THEN BEGIN
                        /*
                            CurrReport.SHOWOUTPUT :=
                               CurrReport.TOTALSCAUSEDBY = "G/L Entry".FIELDNO(Month);
                         *///TRI S.R
                    END
                    ELSE
                        IF "Balance Option" = "Balance Option"::Year THEN BEGIN
                            /*
                                CurrReport.SHOWOUTPUT :=
                                   CurrReport.TOTALSCAUSEDBY = "G/L Entry".FIELDNO(Year);
                             *///TRI S.R
                        END
                        ELSE
                            IF "Balance Option" = "Balance Option"::Range THEN BEGIN
                                /*   CurrReport.SHOWOUTPUT :=
                                      CurrReport.TOTALSCAUSEDBY = "G/L Entry".FIELDNO("G/L Account No.");*/ // 16630
                            END;
                //-- 5. Tri18.1 PG 13112006 -- Stop

                BEGIN                                            //-- 5. Tri18.1 PG 13112006
                    OpBalanceDebit := 0;
                    OpBalanceCredit := 0;
                    OpeningBalance := 0;
                    TotalDebit := 0;
                    TotalCredit := 0;
                    clBalancedebit := 0;
                    clBalancecredit := 0;

                    // msdr calcsums removed by repeat until since g/l entry table is not allowing to create key due some server issue
                    IF (closingBalance = 0) THEN BEGIN
                        //  openingDate:="Bank Account Ledger Entry".GETRANGEMIN("Bank Account Ledger Entry"."Posting Date");
                        GlLedgerrec.RESET;
                        GlLedgerrec.SETCURRENTKEY(GlLedgerrec."G/L Account No.", GlLedgerrec."Posting Date");
                        GlLedgerrec.SETRANGE(GlLedgerrec."G/L Account No.", "G/L Entry"."G/L Account No.");
                        IF Locationfileter <> '' THEN
                            // 16630      GlLedgerrec.SETRANGE(GlLedgerrec."Location Code", Locationfileter); //msdr
                            GlLedgerrec.SETFILTER(GlLedgerrec."Posting Date", '<%1', fromdate);
                        // GlLedgerrec.CALCSUMS(GlLedgerrec."Debit Amount",GlLedgerrec."Credit Amount");
                        IF GlLedgerrec.FINDFIRST THEN BEGIN
                            REPEAT
                                OpeningBalance += GlLedgerrec."Debit Amount" - GlLedgerrec."Credit Amount";
                            UNTIL GlLedgerrec.NEXT = 0;
                        END
                        ELSE
                            OpeningBalance := closingBalance;
                    END;

                    IF OpeningBalance < 0 THEN BEGIN
                        OpBalanceCredit := ABS(OpeningBalance);
                        OpBalanceDebit := 0;
                    END
                    ELSE
                        IF OpeningBalance > 0 THEN BEGIN
                            OpBalanceCredit := 0;
                            OpBalanceDebit := OpeningBalance;
                        END
                END;                                        //-- 5. Tri18.1 PG 13112006

                BEGIN                                       //-- 6. Tri18.1 PG 13112006
                    TotalDebit := "G/L Entry"."Debit Amount" + OpBalanceDebit;
                    TotalCredit := "G/L Entry"."Credit Amount" + OpBalanceCredit;

                    closingBalance := TotalDebit - TotalCredit;
                    IF closingBalance > 0 THEN BEGIN
                        clBalancecredit := ABS(closingBalance);
                        clBalancedebit := 0;
                    END
                    ELSE
                        IF closingBalance < 0 THEN BEGIN
                            clBalancecredit := 0;
                            clBalancedebit := ABS(closingBalance);
                        END;
                    Balancedebit := TotalDebit + clBalancedebit;

                    Balancecredit := TotalCredit + clBalancecredit;
                END;                                        //-- 6. Tri18.1 PG 13112006


                CostCenter := '';
                Employee := '';

                IF "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::Customer THEN BEGIN
                    customerrec.RESET;
                    IF customerrec.GET("G/L Entry"."Bal. Account No.") THEN
                        Accountname := customerrec.Name;
                END
                ELSE
                    IF "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"Bank Account" THEN BEGIN
                        Bankrec.RESET;
                        IF Bankrec.GET("G/L Entry"."Bal. Account No.") THEN
                            Accountname := Bankrec.Name
                    END
                    ELSE
                        IF "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::Vendor THEN BEGIN
                            Vendorrec.RESET;
                            IF Vendorrec.GET("G/L Entry"."Bal. Account No.") THEN
                                Accountname := Vendorrec.Name;
                        END
                        ELSE
                            IF "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"G/L Account" THEN BEGIN
                                GlAccount.RESET;
                                IF GlAccount.GET("G/L Entry"."Bal. Account No.") THEN
                                    Accountname := GlAccount.Name;
                            END
                            ELSE
                                IF "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"Fixed Asset" THEN BEGIN
                                    FA.RESET;
                                    IF FA.GET("G/L Entry"."Bal. Account No.") THEN
                                        Accountname := FA.Description;
                                END;



                /*
                Dimensionrec.RESET;
                Dimensionrec.SETRANGE(Dimensionrec."Dimension Code",GlobalDimension1);
                Dimensionrec.SETRANGE(Dimensionrec."Dimension Value Type",Dimrec."Dimension Value Type"::"End-Total");
                Dimensionrec.FIND('-');
                
                REPEAT
                fromchar:='..';
                Tochar:=',,';
                NewStr:=CONVERTSTR(Dimensionrec.Totaling,fromchar,Tochar);
                minrange:=SELECTSTR(1,NewStr);
                maxrange:=SELECTSTR(3,NewStr);
                
                IF ("G/L Entry"."Global Dimension 1 Code" >= minrange) AND ("G/L Entry"."Global Dimension 1 Code" <= maxrange) THEN BEGIN
                 Dimrec.RESET;
                 IF Dimrec.GET(GlobalDimension1,minrange) THEN BEGIN
                  IF Dimrec.Location=TRUE THEN BEGIN
                   CostCenter:=Dimrec.Name;
                  END
                  END
                END
                UNTIL Dimensionrec.NEXT=0;
                
                Dimrec2.RESET;
                IF Dimrec2.GET(GlobalDimension2,"G/L Entry"."Global Dimension 2 Code") THEN
                Employee:=Dimrec2.Name
                */

                IF RangeOption = RangeOption::"<" THEN BEGIN
                    IF ABS("G/L Entry".Amount) > AmountRange THEN BEGIN
                        // TotalC:=TotalC+"G/L Entry"."Credit Amount";
                        // TotalB:=TotalB+"G/L Entry"."Debit Amount";
                        CurrReport.SKIP;
                    END
                END
                ELSE
                    IF RangeOption = RangeOption::">" THEN BEGIN
                        IF ABS("G/L Entry".Amount) <= AmountRange THEN BEGIN
                            TotalC := TotalC + "G/L Entry"."Credit Amount";
                            TotalB := TotalB + "G/L Entry"."Debit Amount";
                            CurrReport.SKIP;
                        END
                    END
                    ELSE
                        IF RangeOption = RangeOption::"=" THEN BEGIN
                            IF ABS("G/L Entry".Amount) <> AmountRange THEN
                                CurrReport.SKIP;
                        END;



                IF BankAccNo <> "G/L Entry"."G/L Account No." THEN BEGIN
                    closingBalance := 0;
                END;
                BankAccNo := "G/L Entry"."G/L Account No.";



                //Balancedebit:=TotalDebit+clBalancedebit;
                //Balancecredit:=TotalCredit+clBalancecredit;

                GLEntryrec.RESET;
                //CurrReport.SKIP;
                //GLEntryrec.SETRANGE(GLEntryrec."G/L Account No.","G/L Entry".GETFILTER("G/L Account No."));
                //GLEntryrec.SETfilter(GLEntryrec."Posting Date","G/L Entry".GETFILTER("Posting Date"));
                //GLEntryrec.SETfilter(GLEntryrec."Amount",'<>%1',"G/L Entry".GETFILTER("Amount"));

                //CurrReport.SKIP;
                CurrReport.SHOWOUTPUT(RangeOption = RangeOption::">");
                IF RangeOption = RangeOption::">" THEN
                    RangeOptionNEG := '<';

            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("Posting Date");
                /*
                IF GlobalDim1<>'' THEN
                "G/L Entry".SETFILTER("G/L Entry"."Global Dimension 1 Code",'=%1',GlobalDim1);
                IF GlobalDim2<>'' THEN
                "G/L Entry".SETFILTER("G/L Entry"."Global Dimension 2 Code",'=%1',GlobalDim2);
                */

                TotalC := 0;
                TotalB := 0;


                //-- 5. Tri18.1 PG 13112006 -- Stop

                GLSetup.GET;
                GlobalDimension1 := GLSetup."Global Dimension 1 Code";
                GlobalDimension2 := GLSetup."Global Dimension 2 Code";

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field(RangeOption; RangeOption)
                    {
                        ApplicationArea = All;
                    }
                    field(AmountRange; AmountRange)
                    {
                        ApplicationArea = All;
                    }
                    field("Balance Option"; "Balance Option")
                    {
                        Caption = 'Balance Option';
                        ApplicationArea = All;
                    }
                    field(summary; summary)
                    {
                        Caption = 'Summary';
                        ApplicationArea = All;
                    }
                }
            }
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

        //RepAuditMgt.CreateAudit(50112)
    end;

    trigger OnPreReport()
    begin

        // 16630   Locationfileter := "G/L Entry".GETFILTER("Location Code");
        IF "G/L Entry".GETFILTER("Posting Date") = '' THEN BEGIN
            fromdate := 0D;
            todate := TODAY;
        END
        ELSE
            IF "G/L Entry".GETFILTER("Posting Date") <> '' THEN BEGIN
                fromdate := "G/L Entry".GETRANGEMIN("Posting Date");

                todate := "G/L Entry".GETRANGEMAX("Posting Date");
            END;
        /*
        IF "G/L Entry".GETFILTER("G/L Account No.")='' THEN
         BEGIN
          ERROR(Text6000);
         END
        ELSE

         GlAccount.RESET;
         GlAccount.GET("G/L Entry".GETFILTER("G/L Account No."));
          */


        //      IF GlAccount.Cash=FALSE THEN
        //     ERROR(text60001,"G/L Entry".GETFILTER("G/L Account No."))


        GlFilter := "G/L Entry".GETFILTERS;

    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        OpBalanceDebit: Decimal;
        OpBalanceCredit: Decimal;
        GlLedgerrec: Record "G/L Entry";
        openingDate: Date;
        OpeningBalance: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        closingBalance: Decimal;
        clBalancedebit: Decimal;
        clBalancecredit: Decimal;
        Balancedebit: Decimal;
        Balancecredit: Decimal;
        BankAccNo: Code[30];
        Accountname: Text[250];
        GlAccount: Record "G/L Account";
        fromdate: Date;
        todate: Date;
        customerrec: Record Customer;
        Vendorrec: Record Vendor;
        Bankrec: Record "Bank Account";
        GLEntryrec: Record "G/L Entry";
        AmountRange: Decimal;
        GlobalDim1: Text[30];
        GlobalDim2: Text[30];
        RangeOption: Option ">","<","=";
        Dimensionrec: Record "Dimension Value";
        CostCenter: Text[250];
        Employee: Text[250];
        TotalC: Decimal;
        TotalB: Decimal;
        GLSetup: Record "General Ledger Setup";
        RangeOptionNEG: Text[30];
        minrange: Code[10];
        maxrange: Code[10];
        NewStr: Text[250];
        fromchar: Text[30];
        Tochar: Text[30];
        GlobalDimension1: Code[20];
        Dimrec: Record "Dimension Value";
        GlobalDimension2: Code[10];
        Dimrec2: Record "Dimension Value";
        FA: Record "Fixed Asset";
        accountDescription: Text[60];
        GlFilter: Text[300];
        "Balance Option": Option Range,Day,Month,Year;
        CRDRText: Text[4];
        summary: Boolean;
        Locationfileter: Text[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        TotalFor: Label 'Total for ';
        Text6000: Label 'Account No. can not be blank';
        text60001: Label '%1 is not a cash account.';
        GlAccount1: Record "G/L Account";
        accDescription: Text[50];
        DebtAmt: Decimal;
        CretAmt: Decimal;
        SNoTmep: Integer;
}

