report 50067 "IDFC Bank File Generation"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\IDFCBankFileGeneration.rdl';
    Permissions = TableData "Bank Account Ledger Entry" = rm;
    UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Bank Account"; 270)
        {
            DataItemTableView = SORTING("No.")
             WHERE("Integration Bank" = FILTER("IDFC Bank"));
            RequestFilterFields = "No.";
            dataitem("Bank Account Ledger Entry"; 271)
            {
                DataItemLink = "Bank Account No." = FIELD("No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                    WHERE("Online Bank Transfer" = FILTER(true),
                                          Amount = FILTER(< 0),
                                          "File Name" = FILTER(= ''));
                RequestFilterFields = "Posting Date", "Entry No.";
                column(ClientCode; 'OBL')
                {
                }
                column(DrBankAccount; "Bank Account"."Bank Account No.")
                {
                }
                column(TranType; TranType)
                {
                }
                column(ValueDate; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(Amt; -1 * "Bank Account Ledger Entry"."Amount (LCY)")
                {
                }
                column(BeneName; "Bank Account Ledger Entry"."Beneficiary Name")
                {
                }
                column(BeneAcc; "Bank Account Ledger Entry"."Beneficiary Account No.")
                {
                }
                column(BeneIFSCCode; "Bank Account Ledger Entry"."Beneficiary IFSC Code")
                {
                }
                column(CustRefNo; FORMAT("Bank Account Ledger Entry"."Document No."))
                {
                }
                column(BeneEmail; BeneEmail)
                {
                }
                column(BeneMobNo; BeneMobNo)
                {
                }
                column(Remark; "Bank Account Ledger Entry"."Entry No.")
                {
                }
                column(PaymentMode; "Bank Account Ledger Entry"."Payment Mode")
                {
                }
                column(PurposeCode; PurposeCode)
                {
                }
                column(BeneAccType; GetAccountType("Bank Account Ledger Entry"."Beneficiary Account Type"))
                {
                }
                column(CurrCode; 'INR')
                {
                }
                column(Address1; Address[1])
                {
                }
                column(Address2; Address[2])
                {
                }
                column(Address3; Address[3])
                {
                }
                column(Address4; Address[4])
                {
                }
                column(Address5; Address[5])
                {
                }

                trigger OnAfterGetRecord()
                var
                    Vendor: Record Vendor;
                begin
                    IF COPYSTR("Bank Account Ledger Entry"."Beneficiary IFSC Code", 1, 4) = 'IDFB' THEN
                        TranType := 'BT' ELSE BEGIN
                        TranType := 'LBT';
                        PurposeCode := 'OTH';
                    END;
                    BeneEmail := '';
                    BeneMobNo := '';
                    IF "Bank Account Ledger Entry"."Bal. Account No." <> '' THEN BEGIN
                        IF Vendor.GET("Bank Account Ledger Entry"."Bal. Account No.") THEN BEGIN
                            BeneEmail := Vendor."E-Mail";
                            BeneMobNo := Vendor."Phone No.";
                        END;
                    END;
                    "Bank Account Ledger Entry"."File Create By User ID" := USERID;
                    "Bank Account Ledger Entry"."File Creation DateTime" := CURRENTDATETIME;
                    "Bank Account Ledger Entry"."File Name" := GlbFileName;
                    "Bank Account Ledger Entry".MODIFY;
                    I += 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF I <> 0 THEN
                        MESSAGE('%1 No of Entries Exported for Bank Account No. ', I, "Bank Account Ledger Entry"."Bank Account No.");
                end;
            }

            trigger OnAfterGetRecord()
            var
                CompanyInformation: Record "Company Information";
            begin
                I := 0;
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
        TranType: Code[10];
        BeneEmail: Text;
        BeneAccount: Text;
        CustRefNo: Text;
        BeneMobNo: Text;
        PurposeCode: Code[10];
        PayLoc: Text;
        PrintBranchName: Text;
        ModeOfDel: Text;
        TranCurr: Text;
        Address: array[5] of Text;
        GlbFileName: Text;
        I: Integer;

    procedure GetAccountType(AccType: Option " ",Saving,Current,"Cash credit"): Text
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

    procedure GetFileName(var FileName: Text)
    begin
        GlbFileName := FileName;
    end;
}

