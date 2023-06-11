page 50291 "Gen Post Setup"
{
    PageType = List;
    Permissions = TableData "General Posting Setup" = rimd;
    SourceTable = "General Posting Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Sales Account"; Rec."Sales Account")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Disc. Account"; Rec."Sales Line Disc. Account")
                {
                    ApplicationArea = All;
                }
                field("Sales Inv. Disc. Account"; Rec."Sales Inv. Disc. Account")
                {
                    ApplicationArea = All;
                }
                field("Sales Pmt. Disc. Debit Acc."; Rec."Sales Pmt. Disc. Debit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Account"; Rec."Purch. Account")
                {
                    ApplicationArea = All;
                }
                field("Purch. Line Disc. Account"; Rec."Purch. Line Disc. Account")
                {
                    ApplicationArea = All;
                }
                field("Purch. Inv. Disc. Account"; Rec."Purch. Inv. Disc. Account")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pmt. Disc. Credit Acc."; Rec."Purch. Pmt. Disc. Credit Acc.")
                {
                    ApplicationArea = All;
                }
                field("COGS Account"; Rec."COGS Account")
                {
                    ApplicationArea = All;
                }
                field("Inventory Adjmt. Account"; Rec."Inventory Adjmt. Account")
                {
                    ApplicationArea = All;
                }
                field("Sales Credit Memo Account"; Rec."Sales Credit Memo Account")
                {
                    ApplicationArea = All;
                }
                field("Purch. Credit Memo Account"; Rec."Purch. Credit Memo Account")
                {
                    ApplicationArea = All;
                }
                field("Sales Pmt. Disc. Credit Acc."; Rec."Sales Pmt. Disc. Credit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pmt. Disc. Debit Acc."; Rec."Purch. Pmt. Disc. Debit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Sales Pmt. Tol. Debit Acc."; Rec."Sales Pmt. Tol. Debit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Sales Pmt. Tol. Credit Acc."; Rec."Sales Pmt. Tol. Credit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pmt. Tol. Debit Acc."; Rec."Purch. Pmt. Tol. Debit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pmt. Tol. Credit Acc."; Rec."Purch. Pmt. Tol. Credit Acc.")
                {
                    ApplicationArea = All;
                }
                field("Sales Prepayments Account"; Rec."Sales Prepayments Account")
                {
                    ApplicationArea = All;
                }
                field("Purch. Prepayments Account"; Rec."Purch. Prepayments Account")
                {
                    ApplicationArea = All;
                }
                field("Purch. FA Disc. Account"; Rec."Purch. FA Disc. Account")
                {
                    ApplicationArea = All;
                }
                field("Invt. Accrual Acc. (Interim)"; Rec."Invt. Accrual Acc. (Interim)")
                {
                    ApplicationArea = All;
                }
                field("COGS Account (Interim)"; Rec."COGS Account (Interim)")
                {
                    ApplicationArea = All;
                }
                //16225 Table Feild N/F Start
                /*field("Purch. Account (Trading)"; "Purch. Account (Trading)")
                {
                }
                field("Sales Account (Trading)"; "Sales Account (Trading)")
                {
                }
                field("Purch. Cr. Memo Acc. (Trading)"; "Purch. Cr. Memo Acc. (Trading)")
                {
                }
                field("Sales Cr. Memo Acc. (Trading)"; "Sales Cr. Memo Acc. (Trading)")
                {
                }*///16225 Table Feild N/F End
                field("Direct Cost Applied Account"; Rec."Direct Cost Applied Account")
                {
                    ApplicationArea = All;
                }
                field("Overhead Applied Account"; Rec."Overhead Applied Account")
                {
                    ApplicationArea = All;
                }
                field("Purchase Variance Account"; Rec."Purchase Variance Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

