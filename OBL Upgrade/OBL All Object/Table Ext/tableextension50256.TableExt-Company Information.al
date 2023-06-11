tableextension 50256 tableextension50256 extends "Company Information"
{
    fields
    {
        modify("P.A.N. Status")
        {
            OptionCaption = 'Available,Not available';
        }
        modify("Ministry Type")
        {
            OptionCaption = ' ,Regular,Others';
        }


        field(50000; "UPTT No."; Code[30])
        {
        }
        field(50001; "Importer Code No."; Code[30])
        {
        }
        field(50002; "T.I.N No. w.e.f"; Date)
        {
            Description = 'TRI ADD';
        }
        field(50003; Picture1; BLOB)
        {
        }
        field(50004; "IC Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'IC Gen. Bus. Posting Group';
            Description = 'MSBS.Rao';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50005; "Axis Bank Out Folder"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Axis Bank In Folder"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Block ILE Functionality"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "UPI ID"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "UPI Bank Payment Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "UPI Payment Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "IEC Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "IDFC Bank Out Folder"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "IDFC Bank In Folder"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

}

