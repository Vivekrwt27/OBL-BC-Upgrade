table 50092 "Purchase order Attachment"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(10; Date; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPostedDocument
            end;
        }
        field(15; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                //IF "Vendor No."='' THEN
                //  VALIDATE("Document No.",'');
                CheckPostedDocument;
                IF Rec."Vendor No." <> xRec."Vendor No." THEN
                    IF "Vendor No." = '' THEN
                        VALIDATE("Document No.", '');

                UpdateVendorDetails("Vendor No.");
            end;
        }
        field(20; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Address; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; State; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase Order,Purchase Invoice,Purchase Reciepts';
            OptionMembers = "Purchase Order","Purchase Invoice","Purchase Reciepts";

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(50; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Type" = CONST("Purchase Order"),
                                "Vendor No." = FILTER('')) "Purchase Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF ("Document Type" = CONST("Purchase Order"),
                                         "Vendor No." = FILTER(<> '')) "Purchase Header"."No." WHERE("Document Type" = CONST(Order),
                                                                                               "Buy-from Vendor No." = FIELD("Vendor No."))
            ELSE
            IF ("Document Type" = CONST("Purchase Reciepts"),
                                                                                                        "Vendor No." = FILTER('')) "Purch. Rcpt. Header"."No."
            ELSE
            IF ("Document Type" = CONST("Purchase Reciepts"),
                                                                                                                 "Vendor No." = FILTER(<> '')) "Purch. Rcpt. Header"."No." WHERE("Buy-from Vendor No." = FIELD("Vendor No."));

            trigger OnValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchRcptHeader: Record "Purch. Rcpt. Header";
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                CheckPostedDocument;
                "Document Date" := 0D;
                Name := '';
                Address := '';
                "Address 2" := '';
                "Post Code" := '';
                State := '';
                City := '';
                CASE "Document Type" OF
                    "Document Type"::"Purchase Order":
                        BEGIN
                            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "Document No.") THEN
                                VALIDATE("Vendor No.", PurchaseHeader."Buy-from Vendor No.");
                            "Document Date" := PurchaseHeader."Order Date";
                            "Location Code" := PurchaseHeader."Location Code";
                        END;
                    "Document Type"::"Purchase Reciepts":
                        BEGIN
                            IF PurchRcptHeader.GET("Document No.") THEN
                                VALIDATE("Vendor No.", PurchRcptHeader."Buy-from Vendor No.");
                            "Document Date" := PurchRcptHeader."Posting Date";
                            "Location Code" := PurchRcptHeader."Location Code";
                        END;
                    "Document Type"::"Purchase Invoice":
                        BEGIN
                            IF PurchInvHeader.GET("Document No.") THEN
                                VALIDATE("Vendor No.", PurchInvHeader."Buy-from Vendor No.");
                            "Document Date" := PurchInvHeader."Posting Date";
                            "Location Code" := PurchInvHeader."Location Code";
                        END;
                END;
            end;
        }
        field(52; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Location;

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(55; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(60; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; "Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; "Posting DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(90; "Posted UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(95; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(100; Recieved; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(110; "Recieving DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(120; "Recieving UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(130; "Vendor Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(131; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(132; "Bill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPostedDocument;
            end;
        }
        field(140; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; RejectedBy; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(160; "Rejection DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(170; "Rejection Remark"; Text[50])
        {
            DataClassification = ToBeClassified;
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
        /*
        IF "No." = '' THEN BEGIN
          PurchasesPayablesSetup.GET;
          PurchasesPayablesSetup.TESTFIELD("Scan Document No.Series");
          NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Scan Document No.Series",xRec."No. Series",0D,"No.","No. Series");
        END;
        */
        VALIDATE(Date, WORKDATE);
        VALIDATE("Created By", USERID);
        "Creation DateTime" := CURRENTDATETIME;

    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(OldPurchaseOrderAttachment: Record "Purchase order Attachment"): Boolean
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        /*
        PurchSetup.GET;
        IF NoSeriesMgt.SelectSeries(PurchSetup."Scan Document No.Series",OldPurchaseOrderAttachment."No. Series","No. Series") THEN BEGIN
          PurchSetup.GET;
          NoSeriesMgt.SetSeries("No.");
          EXIT(TRUE);
        END;
        */

    end;

    local procedure UpdateVendorDetails(VendorNo: Code[20])
    var
        Vendor: Record Vendor;
    begin
        IF Vendor.GET(VendorNo) THEN BEGIN
            Name := Vendor.Name;
            Address := Vendor.Address;
            "Address 2" := Vendor."Address 2";
            City := Vendor.City;
            "Post Code" := Vendor.City;
            State := Vendor."State Code";
        END;
    end;

    procedure PostDocument(var PurchaseOrderAttachment: Record "Purchase order Attachment")
    begin
        IF CONFIRM('Do you want to Post the Document', FALSE) THEN BEGIN
            PurchaseOrderAttachment.TESTFIELD(Posted, FALSE);
            PurchaseOrderAttachment.Posted := TRUE;
            PurchaseOrderAttachment."Posted UserID" := USERID;
            PurchaseOrderAttachment."Posting DateTime" := CURRENTDATETIME;
        END;
    end;

    procedure RecieveDocument(var PurchaseOrderAttachment: Record "Purchase order Attachment")
    begin
        IF CONFIRM('Do you want to Recieve the Document', FALSE) THEN BEGIN
            PurchaseOrderAttachment.TESTFIELD(Recieved, FALSE);
            PurchaseOrderAttachment.Recieved := TRUE;
            PurchaseOrderAttachment."Recieving UserID" := USERID;
            PurchaseOrderAttachment."Recieving DateTime" := CURRENTDATETIME;
        END;
    end;

    local procedure CheckPostedDocument()
    begin
        TESTFIELD(Posted, FALSE);
        TESTFIELD(Recieved, FALSE);
    end;

    procedure RejectDocument(var PurchaseOrderAttachment: Record "Purchase order Attachment")
    begin
        IF CONFIRM('Do you want to Reject the Document', FALSE) THEN BEGIN
            PurchaseOrderAttachment.TESTFIELD(Recieved, FALSE);
            PurchaseOrderAttachment.TESTFIELD(Rejected, FALSE);
            PurchaseOrderAttachment.TESTFIELD("Rejection Remark");
            PurchaseOrderAttachment.Rejected := TRUE;
            PurchaseOrderAttachment.RejectedBy := USERID;
            PurchaseOrderAttachment."Rejection DateTime" := CURRENTDATETIME;
            PurchaseOrderAttachment.Posted := FALSE;
            PurchaseOrderAttachment."Posted UserID" := USERID;
            PurchaseOrderAttachment."Posting DateTime" := CURRENTDATETIME;
        END;
    end;
}

