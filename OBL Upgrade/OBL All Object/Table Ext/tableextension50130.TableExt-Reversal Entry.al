tableextension 50130 tableextension50130 extends "Reversal Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 11)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Line No."(Field 1)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Entry Type"(Field 2)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""Entry Type"(Field 2)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Entry No."(Field 3)".


        //Unsupported feature: Property Deletion (CaptionML) on ""G/L Register No."(Field 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Source Code"(Field 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Journal Batch Name"(Field 6)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transaction No."(Field 7)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Source Type"(Field 8)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""Source Type"(Field 8)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Source No."(Field 9)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Currency Code"(Field 10)".


        //Unsupported feature: Property Deletion (CaptionML) on "Description(Field 11)".


        //Unsupported feature: Property Deletion (CaptionML) on "Amount(Field 12)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Debit Amount"(Field 13)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Credit Amount"(Field 14)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Amount (LCY)"(Field 15)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Debit Amount (LCY)"(Field 16)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Credit Amount (LCY)"(Field 17)".


        //Unsupported feature: Property Deletion (CaptionML) on ""VAT Amount"(Field 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Posting Date"(Field 19)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Document Type"(Field 20)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""Document Type"(Field 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Document No."(Field 21)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Account No."(Field 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Account Name"(Field 23)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bal. Account Type"(Field 25)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""Bal. Account Type"(Field 25)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bal. Account No."(Field 26)".


        //Unsupported feature: Property Deletion (CaptionML) on ""FA Posting Category"(Field 27)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""FA Posting Category"(Field 27)".


        //Unsupported feature: Property Deletion (CaptionML) on ""FA Posting Type"(Field 28)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""FA Posting Type"(Field 28)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Reversal Type"(Field 30)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on ""Reversal Type"(Field 30)".


        //Unsupported feature: Property Deletion (CaptionML) on ""TDS Amount"(Field 13700)".


        //Unsupported feature: Property Deletion (CaptionML) on ""TCS Amount"(Field 16500)".

    }

    //Unsupported feature: Code Modification on "CheckFAPostingDate(PROCEDURE 24)".

    //procedure CheckFAPostingDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (AllowPostingFrom = 0D) AND (AllowPostingto = 0D) THEN BEGIN
      IF USERID <> '' THEN
        IF UserSetup.GET(USERID) THEN BEGIN
    #4..9
        AllowPostingto := FASetup."Allow FA Posting To";
      END;
      IF AllowPostingto = 0D THEN
        AllowPostingto := 31129998D;
    END;
    IF (FAPostingDate < AllowPostingFrom) OR (FAPostingDate > AllowPostingto) THEN
      ERROR(Text005,Caption,EntryNo,FALedgEntry.FIELDCAPTION("FA Posting Date"));
    IF FAPostingDate > MaxPostingDate THEN
      MaxPostingDate := FAPostingDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
        AllowPostingto := 12319998D;
    #14..18
    */
    //end;

    //Unsupported feature: Property Deletion (CaptionML).



    //Unsupported feature: Property Modification (TextConstString) on "Text000(Variable 1010)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot reverse %1 No. %2 because the entry is either applied to an entry or has been changed by a batch job.;ENN=You cannot reverse %1 No. %2 because the entry is either applied to an entry or has been changed by a batch job.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot reverse %1 No. %2 because the entry is either applied to an entry or has been changed by a batch job.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.;ENN=You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 1016)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot reverse the transaction because it is out of balance.;ENN=You cannot reverse the transaction because it is out of balance.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot reverse the transaction because it is out of balance.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You cannot reverse %1 No. %2 because the entry has a related check ledger entry.;ENN=You cannot reverse %1 No. %2 because the entry has a related check ledger entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You cannot reverse %1 No. %2 because the entry has a related check ledger entry.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text004(Variable 1018)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=You can only reverse entries that were posted from a journal.;ENN=You can only reverse entries that were posted from a journal.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=You can only reverse entries that were posted from a journal.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text005(Variable 1020)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot reverse %1 No. %2 because the %3 is not within the allowed posting period.;ENN=You cannot reverse %1 No. %2 because the %3 is not within the allowed posting period.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot reverse %1 No. %2 because the %3 is not within the allowed posting period.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text006(Variable 1022)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot reverse %1 No. %2 because the entry is closed.;ENN=You cannot reverse %1 No. %2 because the entry is closed.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot reverse %1 No. %2 because the entry is closed.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 1021)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot reverse %1 No. %2 because the entry is included in a bank account reconciliation line. The bank reconciliation has not yet been posted.;ENN=You cannot reverse %1 No. %2 because the entry is included in a bank account reconciliation line. The bank reconciliation has not yet been posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot reverse %1 No. %2 because the entry is included in a bank account reconciliation line. The bank reconciliation has not yet been posted.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text008(Variable 1019)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot reverse the transaction because the %1 has been sold.;ENN=You cannot reverse the transaction because the %1 has been sold.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot reverse the transaction because the %1 has been sold.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text009(Variable 1025)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=The transaction cannot be reversed, because the %1 has been compressed or a %2 has been deleted.;ENN=The transaction cannot be reversed, because the %1 has been compressed or a %2 has been deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=The transaction cannot be reversed, because the %1 has been compressed or a %2 has been deleted.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text010(Variable 1023)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=You cannot reverse %1 No. %2 because the register has already been involved in a reversal.;ENN=You cannot reverse %1 No. %2 because the register has already been involved in a reversal.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=You cannot reverse %1 No. %2 because the register has already been involved in a reversal.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text011(Variable 1026)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=You cannot reverse %1 No. %2 because the entry has already been involved in a reversal.;ENN=You cannot reverse %1 No. %2 because the entry has already been involved in a reversal.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=You cannot reverse %1 No. %2 because the entry has already been involved in a reversal.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text012(Variable 1028)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=You cannot reverse register No. %1 because it contains customer or vendor ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register No. %1 separately.;ENN=You cannot reverse register No. %1 because it contains customer or vendor ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register No. %1 separately.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=You cannot reverse register No. %1 because it contains customer or vendor ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register No. %1 separately.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text013(Variable 1039)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=You cannot reverse %1 No. %2 because the entry has an associated Realized Gain/Loss entry.;ENN=You cannot reverse %1 No. %2 because the entry has an associated Realized Gain/Loss entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=You cannot reverse %1 No. %2 because the entry has an associated Realized Gain/Loss entry.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text13700(Variable 1280002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text13700 : ENU=You cannot reverse register No. %1 because it contains entries that have been posted and applied in the payable entries.;ENN=You cannot reverse register No. %1 because it contains entries that have been posted and applied in the payable entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text13700 : ENU=You cannot reverse register No. %1 because it contains entries that have been posted and applied in the payable entries.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text16500(Variable 1500003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text16500 : ENU=You cannot reverse %1 No. %2 because the service tax credit has already been utilized against the tax payment.;ENN=You cannot reverse %1 No. %2 because the service tax credit has already been utilized against the tax payment.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text16500 : ENU=You cannot reverse %1 No. %2 because the service tax credit has already been utilized against the tax payment.;
    //Variable type has not been exported.
}

