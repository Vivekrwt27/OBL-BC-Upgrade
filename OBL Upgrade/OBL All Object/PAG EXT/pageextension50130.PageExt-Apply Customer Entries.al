pageextension 50130 pageextension50130 extends "Apply Customer Entries"
{
    layout
    {
        addafter("Document Type")
        {
            /*   field("External Document No."; rec."External Document No.")
              {
                  Editable = false;
                  ApplicationArea = All;
              } */
        }
    }
    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

    end;

    //Unsupported feature: Code Modification on "HandlChosenEntries(PROCEDURE 14)".// Function N/F

    //procedure HandlChosenEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF AppliedCustLedgEntry.FINDSET(FALSE,FALSE) THEN BEGIN
      REPEAT
        AppliedCustLedgEntryTemp := AppliedCustLedgEntry;
    #4..36
            IF (ABS(CurrentAmount) = ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
                  AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
            THEN BEGIN
              PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
              CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
              AppliedAmount := AppliedAmount + CorrectionAmount;
            END ELSE
              IF FromZeroGenJnl THEN BEGIN
    #46..58
                  AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END;
        END ELSE BEGIN
          IF ((CurrentAmount + AppliedCustLedgEntryTemp."Amount to Apply") * CurrentAmount) <= 0 THEN
            AppliedAmount := AppliedAmount + CorrectionAmount;
          CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Amount to Apply";
        END;
    #66..87

    UNTIL NOT AppliedCustLedgEntryTemp.FINDFIRST;
    CheckRounding;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..39
              PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
              CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
              PossiblePmtDisc := 0;
    #43..61
          IF ((CurrentAmount - PossiblePmtDisc + AppliedCustLedgEntryTemp."Amount to Apply") * CurrentAmount) <= 0 THEN
    #63..90
    */
    //end;


    //Unsupported feature: Code Modification on "PostDirectApplication(PROCEDURE 15)".

    //procedure PostDirectApplication();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CalcType = CalcType::Direct THEN BEGIN
      IF ApplyingCustLedgEntry."Entry No." <> 0 THEN BEGIN
        Rec := ApplyingCustLedgEntry;
        ApplicationDate := CustEntryApplyPostedEntries.GetApplicationDate(Rec);

        IF CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Invoice THEN BEGIN
          IF CustLedgEntry.HasGSTEntry("Transaction No.") AND (CustLedgEntry."TCS Nature of Collection" <> '') THEN
            IF AppliedCustLedgEntry."TCS Nature of Collection" <> '' THEN
              ERROR(GSTWithTCSErr);
          IF NOT CustLedgEntry.HasGSTEntry("Transaction No.") AND (CustLedgEntry."TCS Nature of Collection" <> '') THEN
            IF (AppliedCustLedgEntry."GST Group Code" <> '') OR (AppliedCustLedgEntry."TCS Nature of Collection" <>'') THEN
              ERROR(GSTWithTCSErr);
          IF CustLedgEntry.HasGSTEntry("Transaction No.") AND (CustLedgEntry."TCS Nature of Collection" = '') THEN
            IF AppliedCustLedgEntry."TCS Nature of Collection" <>'' THEN
              ERROR(GSTWithTCSErr)
        END;
        IF CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::"Finance Charge Memo" THEN BEGIN
          IF AppliedCustLedgEntry."GST on Advance Payment" THEN
            ERROR(GSTWithFinChargeErr);
          IF (AppliedCustLedgEntry."TCS Nature of Collection" <> '') OR
             (AppliedCustLedgEntry."Total TDS/TCS Incl SHE CESS" <> 0)
          THEN
            ERROR(TCSWithFinChargeErr);
        END;
        IF CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Payment THEN BEGIN
          IF (CustLedgEntry."GST Group Code" <> '') AND (CustLedgEntry."TCS Nature of Collection" <> '') THEN
            IF AppliedCustLedgEntry.HasGSTEntry(AppliedCustLedgEntry."Transaction No.") THEN
              ERROR(GSTWithTCSErr);
          IF (CustLedgEntry."GST Group Code" <> '') AND (CustLedgEntry."TCS Nature of Collection" = '') THEN
            IF AppliedCustLedgEntry."TCS Nature of Collection" <> '' THEN
              ERROR(GSTWithTCSErr);
          IF (CustLedgEntry."GST Group Code" = '') AND (CustLedgEntry."TCS Nature of Collection" <> '') THEN
            IF AppliedCustLedgEntry.HasGSTEntry(AppliedCustLedgEntry."Transaction No.") THEN
              ERROR(GSTWithTCSErr);
        END;
        PostApplication.SetValues("Document No.",ApplicationDate);
        IF ACTION::OK = PostApplication.RUNMODAL THEN BEGIN
          PostApplication.GetValues(NewDocumentNo,NewApplicationDate);
          IF NewApplicationDate < ApplicationDate THEN
            ERROR(Text013,FIELDCAPTION("Posting Date"),TABLECAPTION);
        END ELSE
          ERROR(Text019);

        IF PreviewMode THEN
          CustEntryApplyPostedEntries.PreviewApply(Rec,NewDocumentNo,NewApplicationDate)
        ELSE
          Applied := CustEntryApplyPostedEntries.Apply(Rec,NewDocumentNo,NewApplicationDate);

        IF (NOT PreviewMode) AND Applied THEN BEGIN
          MESSAGE(Text012);
          PostingDone := TRUE;
          CurrPage.CLOSE;
        END;
      END ELSE
        ERROR(Text002);
    END ELSE
      ERROR(Text003);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
        IF CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Payment THEN BEGIN
          IF (CustLedgEntry."GST Group Code" <> '') AND (CustLedgEntry."TCS Nature of Collection" <> '') THEN
            IF ApplyingCustLedgEntry.HasGSTEntry(AppliedCustLedgEntry."Transaction No.") THEN
              ERROR(GSTWithTCSErr);
          IF (CustLedgEntry."GST Group Code" <> '') AND (CustLedgEntry."TCS Nature of Collection" = '') THEN
            IF ApplyingCustLedgEntry."TCS Nature of Collection" <> '' THEN
              ERROR(GSTWithTCSErr);
          IF (CustLedgEntry."GST Group Code" = '') AND (CustLedgEntry."TCS Nature of Collection" <> '') THEN
            IF ApplyingCustLedgEntry.HasGSTEntry(AppliedCustLedgEntry."Transaction No.") THEN
    #34..46
          CustEntryApplyPostedEntries.Apply(Rec,NewDocumentNo,NewApplicationDate);

        IF NOT PreviewMode THEN BEGIN
    #50..57
    */
    //end;





}

