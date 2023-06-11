codeunit 50063 "Axis Bank Integration"
{
    Permissions = TableData "Bank Account Ledger Entry" = rm;
    TableNo = "Bank Account";

    trigger OnRun()
    var
        BALedEntry: Record "Bank Account Ledger Entry";
        BankAccount: Record "Bank Account";
    begin
        //IF (Rec."File Creation DateTime" <>0DT) OR (NOT "Online Bank Transfer") THEN
        //EXIT;
        //CreatePaymentRequestFile(Rec);

        BankAccount.RESET;
        BankAccount.SETRANGE("Integration Bank", BankAccount."Integration Bank"::"Axis Bank");
        IF BankAccount.FINDFIRST THEN BEGIN
            ReverseFeedFolder := 'C:\AxisInvoice\h2hReversefeedIn\\';
            // ReadFile;
        END;

        BankAccount.RESET;
        BankAccount.SETRANGE("Integration Bank", BankAccount."Integration Bank"::"IDFC Bank");
        IF BankAccount.FINDFIRST THEN BEGIN
            ReverseFeedFolder := 'C:\IDFC\Input_File\\';
            // ReadIDFCFile;
        END;

        /*
        BALedEntry.RESET;
        BALedEntry.SETFILTER("Online Bank Transfer",'%1',TRUE);
        IF BALedEntry.FINDFIRST THEN
        REPEAT
          CreatePaymentRequestFile(BALedEntry);
        UNTIL BALedEntry.NEXT=0;
        */

    end;

    var
        Identifier: Label 'P';
        Deliminator: Label '^';
        PaymentMode: Text;
        AmtPaid: Decimal;
        NoOfTransaction: Integer;
        RecordSeperatorNotReq: Boolean;
        vString: Text;
        vStringCode: Integer;
        ReverseFeedFolder: Text;


    procedure CreatePaymentRequestFile(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        FileName: Text;
        BankFile: File;
        CompanyInformation: Record "Company Information";
    begin
        FileName := '';
        CompanyInformation.GET;
        CompanyInformation.TESTFIELD("Axis Bank In Folder");
        CompanyInformation.TESTFIELD("Axis Bank Out Folder");

        FileName := CompanyInformation."Axis Bank In Folder" + 'ORIENTBELL_' + CONVERTSTR(FORMAT(CURRENTDATETIME, 0,
                                            '<Year4>-<Month,2>-<Day,2> <Hours24,2>-<Minutes,2>-<Seconds,2>'), '.:\/ ', '_____') + '.txt';
        IF BankAccountLedgerEntry.COUNT = 1 THEN
            RecordSeperatorNotReq := TRUE;
        /*  IF EXISTS(FileName) THEN
     ERASE(FileName);
 BankFile.TEXTMODE(TRUE);
 BankFile.CREATE(FileName); */
        REPEAT
            IF BankAccountLedgerEntry."File Creation DateTime" = 0DT THEN BankAccountLedgerEntry."File Creation DateTime" := CURRENTDATETIME;
            // BankFile.WRITE(FORMAT(CreateBankRequestData(BankAccountLedgerEntry)));
            BankAccountLedgerEntry."File Create By User ID" := USERID;
            BankAccountLedgerEntry."File Name" := FileName;
            BankAccountLedgerEntry.MODIFY;
        UNTIL BankAccountLedgerEntry.NEXT = 0;
    end;

    local procedure CreateBankRequestData(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry") Reqtxt: Text
    var
        BankAccount: Record "Bank Account";
        LF: Text[3];
        CR: Text[3];
        Vendor: Record Vendor;
        EmailID: Text;
    begin
        Reqtxt := '';
        CR[1] := 13;
        CR[2] := 10;
        Reqtxt := Identifier + Deliminator;
        BankAccount.GET(BankAccountLedgerEntry."Bank Account No.");
        Reqtxt += FORMAT(GetPaymentMode(BankAccountLedgerEntry."Amount (LCY)", BankAccountLedgerEntry."Beneficiary IFSC Code")) + Deliminator;
        Reqtxt += FORMAT('ORIENTBELL') + Deliminator;//FORMAT("Amount (LCY)",9) +Deliminator;
        Reqtxt += FORMAT(BankAccountLedgerEntry."Document No." + '-' + FORMAT(BankAccountLedgerEntry."Entry No.")) + Deliminator;//FORMAT("Amount (LCY)",9) +Deliminator;
                                                                                                                                 // Reqtxt += '337010100099891' +Deliminator;
        Reqtxt += BankAccount."Bank Account No." + Deliminator;
        Reqtxt += FORMAT(BankAccountLedgerEntry."Posting Date", 0, 9) + Deliminator;
        Reqtxt += 'INR' + Deliminator;
        //Reqtxt += FORMAT(1,0,9) +Deliminator;//FORMAT("Amount (LCY)",9) +Deliminator;
        Reqtxt += FORMAT(-1 * BankAccountLedgerEntry."Amount (LCY)", 0, 9) + Deliminator;
        Reqtxt += BankAccountLedgerEntry."Beneficiary Name" + Deliminator;
        Reqtxt += BankAccountLedgerEntry."Bal. Account No." + Deliminator;
        //code
        Reqtxt += BankAccountLedgerEntry."Beneficiary Account No." + Deliminator;
        Reqtxt += GetAccountType(BankAccountLedgerEntry."Beneficiary Account Type") + Deliminator;
        Reqtxt += '' + Deliminator;
        //Beneficiary Add1
        Reqtxt += '' + Deliminator;
        //Beneficiary Add2
        Reqtxt += '' + Deliminator;
        //Beneficiary Add3
        Reqtxt += '' + Deliminator;
        //Beneficiary City
        Reqtxt += '' + Deliminator;
        //Beneficiary State
        Reqtxt += '' + Deliminator;
        //Beneficiary pin
        Reqtxt += BankAccountLedgerEntry."Beneficiary IFSC Code" + Deliminator;
        //Beneficiary ifsc
        Reqtxt += BankAccount.Name + Deliminator;
        Reqtxt += BankAccount.IBAN + Deliminator;

        Reqtxt += '' + Deliminator;
        //che No.
        Reqtxt += '' + Deliminator;
        //Ch Date
        Reqtxt += Deliminator;
        //Payable Location
        Reqtxt += '' + Deliminator;
        //Print Location
        Reqtxt += '' + Deliminator;
        //Bene email
        Reqtxt += '' + Deliminator;
        //Bene email
        //Reqtxt += "Document No."+Deliminator; //
        Reqtxt += '' + Deliminator;
        //mobile
        Reqtxt += '' + Deliminator;
        //Brach code
        Reqtxt += '' + Deliminator;
        //Com code
        Reqtxt += '' + Deliminator;
        //prod code
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator;
        //Extra Info
        EmailID := 'sandeep.narula@orientbell.com';
        IF Vendor.GET(BankAccountLedgerEntry."Bal. Account No.") THEN
            IF Vendor."E-Mail" <> '' THEN
                EmailID := Vendor."E-Mail";

        Reqtxt += 'VEND' + Deliminator;
        //pay Type
        Reqtxt += EmailID + Deliminator;
        //
        //   Reqtxt += Deliminator; //Ph. No.
        //  Reqtxt += Deliminator; //le
        Reqtxt += FORMAT(BankAccountLedgerEntry."File Creation DateTime", 0, '<Year4>-<Month,2>-<Day,2> <Hours24,2>-<Minutes,2>-<Seconds,2>') + Deliminator;
        //Transmission Date & Time
        Reqtxt += '' + Deliminator;
        //User ID
        Reqtxt += '' + Deliminator;
        //Department
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator;
        //Extra Info
        Reqtxt += '' + Deliminator; //Extra Info

    end;

    local procedure GetPaymentMode(Amt: Decimal; IFSCCode: Code[12]): Text
    begin
        IF Amt = 0 THEN EXIT;
        IF IFSCCode = '' THEN EXIT;
        IF COPYSTR(IFSCCode, 1, 4) = 'UTIB' THEN
            EXIT('FT');

        IF Amt < 200000 THEN
            EXIT('NE')
        ELSE
            EXIT('RT');
    end;

    local procedure GetAccountType(AccType: Option " ",Saving,Current,"Cash credit"): Text
    begin
        CASE AccType OF
            AccType::Saving:
                EXIT('10');
            AccType::Current:
                EXIT('11');
            AccType::"Cash credit":
                EXIT('13');
        END;
    end;

    /* local procedure ReadFile()
    var
        File: Record File;
        ReverseFeedFile: File;
    begin
        File.RESET;
        File.SETFILTER(File.Path, '%1', ReverseFeedFolder);
        File.SETFILTER(File."Is a file", '%1', TRUE);
        File.SETFILTER(Name, 'axis*');
        IF File.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(ReverseFeedFile);
                ReverseFeedFile.TEXTMODE(TRUE);
                ReverseFeedFile.WRITEMODE(FALSE);
                ReverseFeedFile.OPEN(File.Path + '\' + File.Name);
                REPEAT
                    ReverseFeedFile.READ(vString);
                    vStringCode := STRPOS(vString, '^');
                    // MESSAGE('%1 & [%2] & [%3]',vString,vStringCode,GetEntryNo(COPYSTR(vString,1,vStringCode)));
                    UpdateStatus(GetEntryNo(SplitString(vString, '^', 1)),
                                  SplitString(vString, '^', 7),
                                  SplitString(vString, '^', 5));
                //  MESSAGE('hi %1',SplitString(vString,'^',7)); //Status
                // MESSAGE('%1',GetEntryNo(SplitString(vString,'^',1))); //Document No
                UNTIL ReverseFeedFile.POS = ReverseFeedFile.LEN;
                ReverseFeedFile.CLOSE;
                CopyFile(File.Name);
                RemoveFile(File.Name);
            UNTIL File.NEXT = 0;
        END;
    end;
 */

    procedure GetDocumentNo(Stringcode: Text): Code[20]
    var
        DocNo: Code[20];
    begin
    end;


    procedure GetEntryNo(Stringcode: Text) EntryNo: Integer
    var
        txtEntryNo: Text;
        DelPos: Integer;
    begin
        txtEntryNo := COPYSTR(Stringcode, STRLEN(Stringcode) - 10, 12);
        DelPos := STRPOS(txtEntryNo, '-');
        IF DelPos > 0 THEN
            txtEntryNo := COPYSTR(txtEntryNo, DelPos + 1, 12);
        IF EVALUATE(EntryNo, txtEntryNo) THEN
            EXIT(EntryNo);
    end;

    local procedure UpdateStatus(EntryNo: Integer; txtStatus: Text; BankRefNo: Text)
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        IF BankAccountLedgerEntry.GET(EntryNo) THEN BEGIN
            //  IF BankAccountLedgerEntry."Bank RF Status"='' THEN BEGIN
            BankAccountLedgerEntry."Bank RF Status" := COPYSTR(txtStatus, 1, 50);
            BankAccountLedgerEntry."Bank UTR/Ref. No." := COPYSTR(BankRefNo, 1, 30);
            BankAccountLedgerEntry.MODIFY;
            //  END;
        END;
    end;

    local procedure SplitString(Text: Text; Separator: Text[1]; PlaceofDelim: Integer) Token: Text
    var
        Pos: Integer;
        i: Integer;
    begin
        FOR i := 1 TO PlaceofDelim DO BEGIN
            Pos := STRPOS(Text, Separator);
            IF Pos > 0 THEN BEGIN
                Token := COPYSTR(Text, 1, Pos - 1);
                IF Pos + 1 <= STRLEN(Text) THEN
                    Text := COPYSTR(Text, Pos + 1)
                ELSE
                    Text := '';
            END ELSE BEGIN
                Token := Text;
                Text := '';
            END;
        END;
    end;

    local procedure CopyFile(FileName: Text)
    begin
        /*   IF (FILE.EXISTS(ReverseFeedFolder + FileName)) AND NOT FILE.EXISTS(ReverseFeedFolder + 'Processed\' + FileName) THEN BEGIN
              FILE.COPY(ReverseFeedFolder + FileName, ReverseFeedFolder + 'Processed\' + FileName);
          END; */
    end;

    /*  local procedure RemoveFile(FileName: Text)
     var
         RecFile: Record File;
     begin
         RecFile.RESET;
         WITH RecFile DO BEGIN
             SETRANGE(Path, ReverseFeedFolder);
             SETRANGE("Is a file", TRUE);
             IF FIND('-') THEN
                 REPEAT
                     IF FileName <> '' THEN BEGIN
                         IF (FILE.EXISTS(ReverseFeedFolder + FileName)) THEN BEGIN //AND NOT FILE.EXISTS(strPath+'Processed\'+Name)THEN BEGIN
                             FILE.ERASE(ReverseFeedFolder + FileName);
                         END;
                     END;
                 UNTIL NEXT = 0;

         END;
     end;
  */
    /*  local procedure ReadIDFCFile()
     var
         File: Record File;
         ReverseFeedFile: File;
         EntNo: Integer;
         Header: Boolean;
         TxtEntNo: Text;
     begin
         File.RESET;
         File.SETFILTER(File.Path, '%1', ReverseFeedFolder);
         File.SETFILTER(File."Is a file", '%1', TRUE);
         File.SETFILTER(Name, 'OBEL*');
         IF File.FINDFIRST THEN BEGIN
             REPEAT
                 Header := TRUE;
                 CLEAR(ReverseFeedFile);
                 ReverseFeedFile.TEXTMODE(TRUE);
                 ReverseFeedFile.WRITEMODE(FALSE);
                 ReverseFeedFile.OPEN(File.Path + '\' + File.Name);
                 REPEAT
                     ReverseFeedFile.READ(vString);
                     IF NOT Header THEN BEGIN
                         vStringCode := STRPOS(vString, ',');
                         TxtEntNo := SplitString(vString, ',', 11);
                         //TxtEntNo := DELCHR(TxtEntNo,'=','"');
                         //MESSAGE('%1',TxtEntNo);
                         IF EVALUATE(EntNo, RemoveQuoteChar(TxtEntNo)) THEN
                             UpdateStatus(EntNo,
                                           RemoveQuoteChar(SplitString(vString, ',', 14)),
                                           RemoveQuoteChar(SplitString(vString, ',', 13)));

                     END;
                     Header := FALSE;
                 UNTIL ReverseFeedFile.POS = ReverseFeedFile.LEN;
                 ReverseFeedFile.CLOSE;
                 CopyFile(File.Name);
                 RemoveFile(File.Name);
             UNTIL File.NEXT = 0;
         END;
     end;
  */
    local procedure RemoveQuoteChar(Txt: Text): Text
    begin
        EXIT(DELCHR(Txt, '=', '"'));
    end;
}

