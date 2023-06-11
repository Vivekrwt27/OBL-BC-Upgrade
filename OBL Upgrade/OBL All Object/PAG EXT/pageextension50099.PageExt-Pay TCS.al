pageextension 50099 pageextension50099 extends "Pay TCS"
{
    actions
    {
        modify("&Pay")
        {
            trigger OnAfterAction()
            var
                TCSEntry: Record "TCS Entry";
                TotalTCSAmount: Decimal;
                DocNo: Code[20];
            begin
                TCSEntry.COPY(Rec);
                IF TCSEntry.FIND('-') THEN
                    REPEAT
                        TotalTCSAmount := TotalTCSAmount + TCSEntry."Bal. TCS Including SHE CESS";
                        TCSEntry."Pay TCS Document No." := DocNo;
                        TCSEntry.MODIFY;
                    UNTIL TCSEntry.NEXT = 0;

            end;
        }

    }
}

