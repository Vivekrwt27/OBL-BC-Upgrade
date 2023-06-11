table 50012 "RGP Header"
{
    //                   Customization No. 63

    Description = 'Customization No. 63';
    LookupPageID = "RGP Out List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                "User ID" := USERID;

                IF "No." <> xRec."No." THEN BEGIN
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Document Type"; Option)
        {
            Description = '''Out'' or ''In''';
            OptionCaption = 'Out,In';
            OptionMembers = Out,"In";
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Order Date"; Date)
        {
        }
        field(5; "User ID"; Code[20])
        {
            Editable = false;
        }
        field(6; "Employee ID"; Code[20])
        {

            trigger OnLookup()
            begin
                //Customization No. 63 Start Vipul

                GeneralLedgerSetup.RESET;
                GeneralLedgerSetup.FIND('-');
                IF GeneralLedgerSetup."Employee Dimension Code" = '' THEN
                    ERROR('You must fill Employee Dimension Code in General Ledger Setup');
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", '%1', GeneralLedgerSetup."Employee Dimension Code");
                //Form 560 "Dimension Value List"
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Employee ID", DimensionValue.Code);

                //Customization No. 63 End Vipul
            end;
        }
        field(7; Posted; Boolean)
        {
            Description = 'Posted';
        }
        field(10; Purpose; Text[50])
        {

            trigger OnValidate()
            begin

                RGPLines.RESET;
                RGPLines.SETFILTER(RGPLines."Document Type", '%1', "Document Type");
                RGPLines.SETFILTER(RGPLines."RGP No.", "No.");
                RGPLines.SETFILTER(RGPLines.Purpose, '%1', '');
                IF RGPLines.FIND('-') THEN
                    REPEAT
                        RGPLines.VALIDATE(RGPLines.Purpose, Purpose);
                        RGPLines.MODIFY;
                    UNTIL RGPLines.NEXT = 0;
            end;
        }
        field(11; Type; Option)
        {
            OptionMembers = Customer,Vendor,Party;

            trigger OnValidate()
            begin
                Code := '';
                Name := '';
                "Name 2" := '';
                Address := '';
                "Address 2" := '';
                City := '';

                RGPLines.RESET;
                RGPLines.SETFILTER(RGPLines."Document Type", '%1', "Document Type");
                RGPLines.SETFILTER(RGPLines."RGP No.", "No.");
                IF RGPLines.FIND('-') THEN RGPLines.DELETEALL;
            end;
        }
        field(12; "Code"; Code[20])
        {
            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                IF Type = Type::Customer THEN BEGIN
                    Cust.GET(Code);
                    Name := Cust.Name;
                    "Name 2" := Cust."Name 2";
                    Address := Cust.Address;
                    "Address 2" := Cust."Address 2";
                    City := Cust.City;
                END ELSE
                    IF Type = Type::Vendor THEN BEGIN
                        Vend.GET(Code);
                        Name := Vend.Name;
                        "Name 2" := Vend."Name 2";
                        Address := Vend.Address;
                        "Address 2" := Vend."Address 2";
                        City := Vend.City;
                    END;

                RGPLines.RESET;
                RGPLines.SETFILTER(RGPLines."Document Type", '%1', "Document Type");
                RGPLines.SETFILTER(RGPLines."RGP No.", "No.");
                IF RGPLines.FIND('-') THEN RGPLines.DELETEALL;

                /*
                IF "Document Type" = "Document Type"::"In" THEN BEGIN
                  RGPLines.RESET;
                  RGPLines.SETFILTER(RGPLines."Document Type",'%1',RGPLines."Document Type"::"In");
                  RGPLines.SETFILTER(RGPLines."RGP No.","No.");
                  IF RGPLines.FIND THEN RGPLines.DELETEALL;
                END ELSE IF "Document Type" = "Document Type"::Out THEN BEGIN
                  RGPLines.RESET;
                  RGPLines.SETFILTER(RGPLines."Document Type",'%1',RGPLines."Document Type"::Out);
                  RGPLines.SETFILTER(RGPLines."RGP No.","No.");
                  IF RGPLines.FIND('-') THEN REPEAT
                    RGPLines.VALIDATE(RGPLines."Party Code",Code);
                    RGPLines.MODIFY;
                  UNTIL RGPLines.NEXT = 0;
                END;
                */

            end;
        }
        field(13; Name; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(14; "Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(15; Address; Text[100])
        {
            Caption = 'Bill-to Address';
        }
        field(16; "Address 2"; Text[100])
        {
            Caption = 'Bill-to Address 2';
        }
        field(17; City; Text[30])
        {
            Caption = 'Bill-to City';
        }
        field(18; "No. Series"; Code[20])
        {
        }
        field(19; Location; Code[10])
        {

            trigger OnLookup()
            begin
                //ND
                UserLocation.RESET;
                UserLocation.SETFILTER(UserLocation."User ID", USERID);
                IF "Document Type" = "Document Type"::"In" THEN
                    UserLocation.SETFILTER(UserLocation."RGP IN", '%1', TRUE);
                IF "Document Type" = "Document Type"::Out THEN
                    UserLocation.SETFILTER(UserLocation."RGP OUT", '%1', TRUE);
                IF PAGE.RUNMODAL(Page::"User Locations", UserLocation) = ACTION::LookupOK THEN
                    VALIDATE(Location, UserLocation."Location Code");
                //ND


                IF xRec.Location <> '' THEN BEGIN
                    RGPLines.RESET;
                    //  RGPLines.SETFILTER(RGPLines."Document Type",'%1',"Document Type");
                    RGPLines.SETFILTER(RGPLines."RGP No.", "No.");
                    //RGPLines.SETRANGE("Indent No.", ''); //MSVRN 210618
                    IF RGPLines.FIND('-') THEN BEGIN
                        REPEAT
                            IF RGPLines."Indent No." <> '' THEN
                                ERROR(Text0001)
                        UNTIL RGPLines.NEXT = 0
                    END
                    ELSE
                        IF CONFIRM('Location of all the lines will be changed as header new Location. Do you want to proceed.', TRUE) THEN
                            REPEAT
                                RGPLines.VALIDATE("Location", Location);
                                RGPLines.MODIFY;
                            UNTIL RGPLines.NEXT = 0;
                END;
            end;

            trigger OnValidate()
            begin
                /*
                //ND
                IF xRec.Location <> '' THEN BEGIN
                  RGPLines.RESET;
                  RGPLines.SETFILTER(RGPLines."Document Type",'%1',"Document Type");
                  RGPLines.SETFILTER(RGPLines."RGP No.","No.");
                  RGPLines.SETRANGE("Indent No.", ''); //MSVRN 210618
                  IF RGPLines.FIND('-') THEN BEGIN
                    IF CONFIRM('Location of all the lines will be changed as header new Location. Do you want to proceed.',TRUE) THEN
                      REPEAT
                        RGPLines.VALIDATE(Location,Location);
                        RGPLines.MODIFY;
                      UNTIL RGPLines.NEXT = 0;
                  END
                  ELSE
                    IF NOT RGPLines.FINDFIRST THEN
                      ERROR(Text0001); //MSVRN 210618
                END;
                //ND
                */

                /*
                IF xRec.Location <> '' THEN BEGIN
                  RGPLines.RESET;
                //  RGPLines.SETFILTER(RGPLines."Document Type",'%1',"Document Type");
                  RGPLines.SETFILTER(RGPLines."RGP No.","No.");
                  //RGPLines.SETRANGE("Indent No.", ''); //MSVRN 210618
                  IF RGPLines.FIND('-') THEN
                    IF RGPLines."Indent No." <> '' THEN
                      ERROR(Text0001)
                    ELSE
                      IF CONFIRM('Location of all the lines will be changed as header new Location. Do you want to proceed.',TRUE) THEN
                        REPEAT
                          RGPLines.VALIDATE(Location,Location);
                          RGPLines.MODIFY;
                        UNTIL RGPLines.NEXT = 0;
                END;
                */

            end;
        }
        field(20; "Vehicle No."; Code[15])
        {
        }
        field(21; "Tin No."; Text[15])
        {
        }
        field(50010; "Indent No."; Code[20])
        {
            Description = 'MSVRN 290518';
        }
    }

    keys
    {
        key(Key1; "No.", "Document Type")
        {
            Clustered = true;
        }
        key(Key2; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


        //ND
        IF "Document Type" = "Document Type"::"In" THEN
            UserAccess := 33;
        IF "Document Type" = "Document Type"::Out THEN
            UserAccess := 34;
        Permissions.Type(UserAccess, xRec.Location);
        Permissions.Type(UserAccess, Location);
        //ND
    end;

    trigger OnInsert()
    begin


        IF "No." = '' THEN BEGIN
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
        END;
        VALIDATE("Order Date", WORKDATE);
        VALIDATE("Posting Date", WORKDATE);
        VALIDATE("User ID", USERID);
        //ND
        UserLocation.RESET;
        UserLocation.SETFILTER("User ID", USERID);
        IF "Document Type" = "Document Type"::"In" THEN
            UserLocation.SETFILTER(UserLocation."RGP IN", '%1', TRUE);
        IF "Document Type" = "Document Type"::Out THEN
            UserLocation.SETFILTER(UserLocation."RGP OUT", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            VALIDATE(Location, UserLocation."Location Code");

        IF "Document Type" = "Document Type"::"In" THEN
            UserAccess := 33;
        IF "Document Type" = "Document Type"::Out THEN
            UserAccess := 34;
        Permissions.Type(UserAccess, Location);
        //ND
    end;

    trigger OnModify()
    begin


        //ND
        IF "Document Type" = "Document Type"::"In" THEN
            UserAccess := 33;
        IF "Document Type" = "Document Type"::Out THEN
            UserAccess := 34;
        Permissions.Type(UserAccess, xRec.Location);
        Permissions.Type(UserAccess, Location);
        //ND
    end;

    trigger OnRename()
    begin


        //ND
        IF "Document Type" = "Document Type"::"In" THEN
            UserAccess := 33;
        IF "Document Type" = "Document Type"::Out THEN
            UserAccess := 34;
        Permissions.Type(UserAccess, xRec.Location);
        Permissions.Type(UserAccess, Location);
        //ND
    end;

    var
        RGPLines: Record "RGP Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Vend: Record Vendor;
        UserLocation: Record "User Location";
        UserAccess: Integer;
        Permissions: Codeunit Permissions1;
        PurchSetup: Record "Purchases & Payables Setup";
        Text0001: Label 'Delete all lines before changing location!';

    procedure GetNoSeriesCode(): Code[10]
    begin
        InventorySetup.GET;
        CASE "Document Type" OF
            "Document Type"::"In":
                BEGIN
                    InventorySetup.TESTFIELD(InventorySetup."RGP In Nos.");
                    EXIT(InventorySetup."RGP In Nos.");
                END;
            "Document Type"::Out:
                BEGIN
                    InventorySetup.TESTFIELD(InventorySetup."RGP Out Nos.");
                    EXIT(InventorySetup."RGP Out Nos.");
                END;
        END;
    end;

    procedure AssistEdit(OldRGPheader: Record "RGP Header"): Boolean
    begin
        PurchSetup.GET;
        IF NoSeriesMgt.SelectSeries(PurchSetup."RGP No. Series", OldRGPheader."No. Series", "No. Series") THEN BEGIN
            PurchSetup.GET;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;
}

