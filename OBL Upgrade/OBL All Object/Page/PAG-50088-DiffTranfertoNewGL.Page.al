page 50088 "Diff Tranfer to New GL"
{
    PageType = Card;

    layout
    {
    }

    actions
    {
        area(processing)
        {
            action("Rate Diffrence Transfer to New GL")
            {
                Caption = 'Rate Diffrence Transfer to New GL';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StartDate := 20040106D;
                    EndDate := 20040630D;
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
                    GLEntry.SETRANGE("G/L Account No.", '51051000');
                    GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                    IF GLEntry.FIND('-') THEN
                        REPEAT
                            ILE.RESET;
                            ILE.SETCURRENTKEY("Order No.");
                            ILE.SETRANGE("Order No.", GLEntry."Document No.");
                            IF ILE.FIND('-') THEN
                                REPEAT
                                    GLEntry1.RESET;
                                    GLEntry1.SETCURRENTKEY("Document No.", "Posting Date");
                                    GLEntry1.SETRANGE("Document No.", ILE."Document No.");
                                    IF GLEntry1.FIND('-') THEN
                                        REPEAT
                                            GLEntryNew.TRANSFERFIELDS(GLEntry1);
                                            IF GLEntryNew.INSERT THEN;
                                        UNTIL GLEntry1.NEXT = 0;
                                UNTIL ILE.NEXT = 0;
                        UNTIL GLEntry.NEXT = 0;
                    MESSAGE('Process Ended.....');
                end;
            }
        }
    }

    var
        GLEntry: Record "G/L Entry";
        ILE: Record "Item Ledger Entry";
        GLEntryNew: Record "G/L Entry new";
        StartDate: Date;
        EndDate: Date;
        GLEntry1: Record "G/L Entry";
}

