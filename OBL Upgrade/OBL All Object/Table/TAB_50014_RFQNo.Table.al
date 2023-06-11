table 50014 "RFQ No."
{
    // 
    // //cust 3 ravi


    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchPaySetup.GET;
                    NoSeriesMgt.TestManual(PurchPaySetup."RFQ No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; Purpose; Text[100])
        {
        }
        field(4; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        IF "No." = '' THEN BEGIN
            PurchPaySetup.GET;
            PurchPaySetup.TESTFIELD(PurchPaySetup."RFQ No.");
            NoSeriesMgt.InitSeries(PurchPaySetup."RFQ No.", xRec."No.", 0D, "No.", "No. Series");
        END
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchPaySetup: Record "Purchases & Payables Setup";
}

