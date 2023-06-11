table 50013 "RGP Line"
{
    // 
    // 
    // Customization 63 Vipul

    Description = 'Customization No. 63';
    LookupPageID = "RGP List";

    fields
    {
        field(1; "RGP No."; Code[20])
        {
            Description = 'RGP Header Number';
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            Description = ' ,Fixed Assets,Item';
            OptionCaption = ' ,Fixed Assets,Item';
            OptionMembers = " ","Fixed Assets",Item;

            trigger OnValidate()
            begin
                /*//"No." := '';
                Description := '';
                "Unit of Measure" := '';
                Quantity := 0;
                "Approximate Price" := 0;
                "Expected Receipt Date" := 0D;
                "Quantity to Receive" := 0;
                "Receiving Quantity" := 0;
                "Receiving Date" := 0D;
                "Unit Price" := 0;
                //MODIFY;
                */

            end;
        }
        field(4; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST("Fixed Assets")) "Fixed Asset"."No."
            ELSE
            IF (Type = CONST(Item)) Item."No.";

            trigger OnValidate()
            begin
                IF RgpHeader.GET("RGP No.") THEN
                    VALIDATE(Location, RgpHeader.Location);

                IF Type = Type::"Fixed Assets" THEN BEGIN
                    FixedAsset.RESET;
                    FixedAsset.GET("No.");
                    Description := FixedAsset.Description;
                    "Description 2" := FixedAsset."Description 2";

                    DepreciationBook.RESET;
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Acq. Cost", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Depreciation", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Write-Down", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Appreciation", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Custom 1", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Custom 2", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Disposal", TRUE);
                    DepreciationBook.SETRANGE(DepreciationBook."G/L Integration - Maintenance", TRUE);
                    IF DepreciationBook.FIND('-') THEN BEGIN
                        FADepreciationBook.RESET;
                        FADepreciationBook.SETFILTER(FADepreciationBook."FA No.", "No.");
                        FADepreciationBook.SETFILTER(FADepreciationBook."Depreciation Book Code", DepreciationBook.Code);
                        IF FADepreciationBook.FIND('-') THEN BEGIN
                            FADepreciationBook.CALCFIELDS(FADepreciationBook."Book Value");
                            VALIDATE("Unit Price", FADepreciationBook."Book Value");
                        END;
                    END;
                END;

                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    Item.GET("No.");
                    Description := Item.Description;
                    "Description 2" := Item."Description 2";
                    "Unit of Measure" := Item."Base Unit of Measure";
                    VALIDATE("Unit Price", Item."Unit Price");
                    "HSN Code" := Item."HSN/SAC Code";
                END;
            end;
        }
        field(5; Description; Text[130])
        {
        }
        field(6; "Unit of Measure"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            IF (Type = CONST("Fixed Assets")) "Unit of Measure"."Code"
            ELSE
            IF (Type = CONST(" ")) "Unit of Measure"."Code";
        }
        field(7; Quantity; Decimal)
        {

            trigger OnValidate()
            begin

                "Approximate Price" := Quantity * "Unit Price";
            end;
        }
        field(8; "Approximate Price"; Decimal)
        {
        }
        field(10; "Expected Receipt Date"; Date)
        {
        }
        field(11; "RGP Out No."; Code[20])
        {
            Description = 'Hidden in RGP Out Form';

            trigger OnLookup()
            begin
                RGPLine.RESET;
                RgpHeader.RESET;
                IF RgpHeader.GET("RGP No.", RgpHeader."Document Type"::"In") THEN BEGIN

                    RGPLine.SETRANGE(RGPLine."Document Type", RGPLine."Document Type"::Out);
                    RGPLine.SETFILTER(RGPLine."Quantity to Receive", '<>0');
                    RGPLine.SETRANGE(RGPLine."Party Type", RgpHeader.Type);
                    RGPLine.SETRANGE(RGPLine."Party Code", RgpHeader.Code);
                    RGPLine.SETRANGE(RGPLine.Posted, TRUE);
                    RGPLine.SETFILTER(Location, RgpHeader.Location);
                    IF PAGE.RUNMODAL(Page::"RGP List", RGPLine) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("RGP Out No.", RGPLine."RGP No.");
                        VALIDATE("RGP Outline No.", RGPLine."Line No.");
                        //VALIDATE(Type,RGPLine.Type);
                        VALIDATE("No.", RGPLine."No.");
                        VALIDATE(Description, RGPLine.Description);
                        VALIDATE("Unit of Measure", RGPLine."Unit of Measure");
                        VALIDATE(Quantity, RGPLine.Quantity);
                        VALIDATE("Expected Receipt Date", RGPLine."Expected Receipt Date");
                        VALIDATE("Quantity to Receive", RGPLine."Quantity to Receive");
                        VALIDATE("Unit Price", RGPLine."Unit Price");
                    END;
                END;
            end;
        }
        field(12; "RGP Outline No."; Integer)
        {
            Description = 'Hidden in RGP Out Form';
        }
        field(13; "Quantity to Receive"; Decimal)
        {
            MinValue = 0;
        }
        field(14; "Receiving Quantity"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Receiving Quantity" > "Quantity to Receive" THEN
                    ERROR('Receiving quantity should not be more than %1', "Quantity to Receive");
            end;
        }
        field(15; "Receiving Date"; Date)
        {
        }
        field(16; "Unit Price"; Decimal)
        {

            trigger OnValidate()
            begin
                "Approximate Price" := Quantity * "Unit Price";
            end;
        }
        field(17; "Document Type"; Option)
        {
            Description = '''Out'' or ''In''';
            OptionCaption = 'Out,In';
            OptionMembers = Out,"In";
        }
        field(18; "Party Type"; Option)
        {
            OptionMembers = Customer,Vendor,Party;
        }
        field(19; "Party Code"; Code[20])
        {
        }
        field(20; Posted; Boolean)
        {
            Editable = true;
        }
        field(21; Location; Code[10])
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
            end;
        }
        field(22; "Description 2"; Text[130])
        {
        }
        field(23; Purpose; Text[50])
        {
        }
        field(24; Remarks; Text[50])
        {
        }
        field(50010; "Indent No."; Code[20])
        {
            Description = 'MSVRN 290518';
        }
        field(50011; "Indent Line No."; Integer)
        {
            Description = 'MSVRN 310518';
        }
        field(50012; "HSN Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "RGP No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "RGP No.")
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
    var
        RGPL: Record "RGP Line";
    begin


        RGPL.RESET;
        RGPL.SETRANGE("Document Type", "Document Type");
        RGPL.SETRANGE("RGP No.", "RGP No.");
        IF RGPL.FINDLAST THEN
            "Line No." := RGPL."Line No." + 10000
        ELSE
            "Line No." := 10000;


        RgpHeader.GET("RGP No.", "Document Type");

        "Party Type" := RgpHeader.Type;
        "Party Code" := RgpHeader.Code;
        Purpose := RgpHeader.Purpose;
        //ND
        IF Location = '' THEN BEGIN
            UserLocation.RESET;
            UserLocation.SETFILTER("User ID", USERID);
            IF "Document Type" = "Document Type"::"In" THEN
                UserLocation.SETFILTER(UserLocation."RGP IN", '%1', TRUE);
            IF "Document Type" = "Document Type"::Out THEN
                UserLocation.SETFILTER(UserLocation."RGP OUT", '%1', TRUE);
            IF UserLocation.FIND('-') THEN
                Location := RgpHeader.Location;
        END;

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
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        DepreciationBook: Record "Depreciation Book";
        FADepreciationBook: Record "FA Depreciation Book";
        RgpHeader: Record "RGP Header";
        RGPLine: Record "RGP Line";
        UserLocation: Record "User Location";
        UserAccess: Integer;
        Permissions: Codeunit Permissions1;
        IndentLine: Record "Indent Line";
        IndentHeader: Record "Indent Header";
}

