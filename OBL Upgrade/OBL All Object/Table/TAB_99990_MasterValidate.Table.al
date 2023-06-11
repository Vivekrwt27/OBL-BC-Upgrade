table 99990 "Master Validate"
{

    fields
    {
        field(1; "Table"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(2; "Table Name"; Text[100])
        {
            /*  CalcFormula = Lookup(Object.Name WHERE(Type = CONST(Table),
                                                      ID = FIELD(Table)));
             FieldClass = FlowField; */
        }
        field(3; Validate; Boolean)
        {

            trigger OnValidate()
            begin
                IF Validate = TRUE THEN BEGIN
                    CALCFIELDS("Table Name");
                    windows.OPEN('#1###################################\#2##############################', "Table Name", Code);
                    windows.UPDATE;
                    Check("Table Name");
                    windows.CLOSE;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Table")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        windows: Dialog;
        "Code": Code[20];

    procedure Check(Text: Text[100])
    begin
        CASE Text OF
            'Location':
                Location;
            'Customer':
                Customer;
            'Vendor':
                Vendor;
            'Item':
                Item;
            'Customer Posting Group':
                "Customer Posting Group";
            'Vendor Posting Group':
                "Vendor Posting Group";
            'Inventory Posting Group':
                "Inventory Posting Group";
            'General Ledger Setup':
                "General Ledger Setup";
            'Bank Account':
                "Bank Account";
            'Sales & Receivables Setup':
                "Sales & Receivables Setup";
            'Purchases & Payables Setup':
                "Purchases & Payables Setup";
            'Inventory Setup':
                "Inventory Setup";
            'Salesperson/Purchaser':
                "Salesperson/Purchaser";
            'General Posting Setup':
                "General Posting Setup";

        END;
    end;

    procedure Location()
    var
        Location: Record Location;
    begin
        Location.FIND('-');
        Code := Location.Code;
        windows.UPDATE;
        Location.VALIDATE(Location.Code);
        Location.VALIDATE(Location.City);
        //  Location.VALIDATE(Location."Excise Bus. Posting Group");//16225 Table N/F
        //  Location.VALIDATE(Location."E.C.C. No.");//16225 Table N/F
        Location.VALIDATE(Location."State Code");
        Location.VALIDATE(Location."Main Location");
        Location.TESTFIELD(Location."Location Dimension");
        Location.VALIDATE(Location."Location Dimension");
        Location.MODIFY;
        REPEAT
        UNTIL Location.NEXT = 0;
    end;

    procedure Customer()
    var
        Customer: Record Customer;
    begin
        Customer.FIND('-');
        REPEAT
            Code := Customer."No.";
            windows.UPDATE;
            Customer.VALIDATE(Customer.City);
            Customer.TESTFIELD(Customer."Customer Posting Group");
            Customer.VALIDATE(Customer."Customer Posting Group");
            Customer.VALIDATE(Customer."Currency Code");
            Customer.VALIDATE(Customer."Customer Price Group");
            Customer.VALIDATE(Customer."Payment Terms Code");
            Customer.VALIDATE(Customer."Fin. Charge Terms Code");
            Customer.VALIDATE(Customer."Salesperson Code");
            Customer.VALIDATE(Customer."Shipment Method Code");
            Customer.VALIDATE(Customer."Shipping Agent Code");
            Customer.VALIDATE(Customer."Place of Export");
            Customer.VALIDATE(Customer."Invoice Disc. Code");
            Customer.VALIDATE(Customer."Customer Disc. Group");
            Customer.VALIDATE(Customer."Country/Region Code");
            Customer.VALIDATE(Customer."Collection Method");
            Customer.VALIDATE(Customer."Bill-to Customer No.");
            Customer.VALIDATE(Customer."Payment Method Code");
            Customer.VALIDATE(Customer."Location Code");
            Customer.VALIDATE(Customer."Gen. Bus. Posting Group");
            Customer.VALIDATE(Customer."Post Code");
            Customer.VALIDATE(Customer."Reminder Terms Code");
            Customer.VALIDATE(Customer."Tax Area Code");
            Customer.VALIDATE(Customer."VAT Bus. Posting Group");
            //Customer.VALIDATE(Customer.Structure); //16225 Table N/F
            //Customer.VALIDATE(Customer."VAT Business Posting Group");
            IF Customer."Customer Type" <> '' THEN
                Customer.VALIDATE(Customer."Customer Type");
            // Customer.VALIDATE(Customer."Excise Bus. Posting Group");//16225 Table N/F
            Customer.MODIFY;
        UNTIL Customer.NEXT = 0;
    end;

    procedure Vendor()
    var
        Vendor: Record Vendor;
    begin
        Vendor.FIND('-');
        REPEAT
            Code := Vendor."No.";
            windows.UPDATE;
            Vendor.VALIDATE(Vendor.City);
            Vendor.VALIDATE(Vendor."Territory Code");
            Vendor.VALIDATE(Vendor."Vendor Posting Group");
            Vendor.VALIDATE(Vendor."Currency Code");
            Vendor.VALIDATE(Vendor."Payment Terms Code");
            Vendor.VALIDATE(Vendor."Fin. Charge Terms Code");
            Vendor.VALIDATE(Vendor."Purchaser Code");
            Vendor.VALIDATE(Vendor."Shipment Method Code");
            Vendor.VALIDATE(Vendor."Shipping Agent Code");
            Vendor.VALIDATE(Vendor."Country/Region Code");
            Vendor.VALIDATE(Vendor."Pay-to Vendor No.");
            Vendor.VALIDATE(Vendor."Payment Method Code");
            Vendor.VALIDATE(Vendor."Gen. Bus. Posting Group");
            Vendor.VALIDATE(Vendor."Tax Area Code");
            Vendor.VALIDATE(Vendor."VAT Bus. Posting Group");
            Vendor.VALIDATE(Vendor."Location Code");
            Vendor.VALIDATE(Vendor."State Code");
            //  Vendor.VALIDATE(Vendor.Structure);//16225 Table Field N/F
            //Vendor.VALIDATE(Vendor."VAT Business Posting Group");
            IF Vendor."Vendor Classification" <> '' THEN
                Vendor.VALIDATE(Vendor."Vendor Classification");
            Vendor.MODIFY;
        UNTIL Vendor.NEXT = 0;
    end;

    procedure Item()
    var
        item: Record Item;
    begin
        item.FIND('-');
        REPEAT
            Code := item."No.";
            windows.UPDATE;
            //   item.validate(item."Base Unit of Measure");
            item.VALIDATE(item."Inventory Posting Group");
            item.VALIDATE(item."Item Disc. Group");
            item.VALIDATE(item."Commission Group");
            item.VALIDATE(item."Vendor No.");
            item.VALIDATE(item."Vendor Item No.");
            item.VALIDATE(item."VAT Bus. Posting Gr. (Price)");
            item.VALIDATE(item."Gen. Prod. Posting Group");
            item.VALIDATE(item."Tax Group Code");
            item.VALIDATE(item."VAT Prod. Posting Group");
            item.VALIDATE(item."Item Category Code");
            // item.VALIDATE(item."Product Group Code");//16225 Item Table Field N/F
            //   item.VALIDATE(item."Excise Prod. Posting Group");
            //   item.VALIDATE(item."Excise Accounting Type");
            item.VALIDATE(item."Item Classification");
            item.VALIDATE(item."Type Code");
            item.VALIDATE(item."Type Catogery Code");
            item.VALIDATE(item."Size Code");
            item.VALIDATE(item."Design Code");
            item.VALIDATE(item."Color Code");
            item.VALIDATE(item."Packing Code");
            item.VALIDATE(item."Quality Code");
            item.VALIDATE(item."Plant Code");
            item.MODIFY;

        UNTIL item.NEXT = 0;
    end;

    procedure "Customer Posting Group"()
    var
        CustPostGrp: Record "Customer Posting Group";
    begin
        CustPostGrp.FIND('-');
        REPEAT
            Code := CustPostGrp.Code;
            windows.UPDATE;
            CustPostGrp.TESTFIELD(CustPostGrp."Receivables Account");
            CustPostGrp.VALIDATE(CustPostGrp."Receivables Account");
            CustPostGrp.MODIFY;
        UNTIL CustPostGrp.NEXT = 0;
    end;

    procedure "Vendor Posting Group"()
    var
        VendPostGrp: Record "Vendor Posting Group";
    begin
        VendPostGrp.FIND('-');
        REPEAT
            Code := VendPostGrp.Code;
            windows.UPDATE;
            VendPostGrp.TESTFIELD(VendPostGrp."Payables Account");
            VendPostGrp.VALIDATE(VendPostGrp."Payables Account");
            VendPostGrp.MODIFY;
        UNTIL VendPostGrp.NEXT = 0;
    end;

    procedure "Inventory Posting Group"()
    var
        InvPostGrp: Record "Inventory Posting Setup";
    begin
        InvPostGrp.FIND('-');
        REPEAT
            Code := InvPostGrp."Location Code" + ' ' + InvPostGrp."Invt. Posting Group Code";
            windows.UPDATE;
            InvPostGrp.TESTFIELD(InvPostGrp."Inventory Account");
            InvPostGrp.VALIDATE(InvPostGrp."Inventory Account");
            InvPostGrp.MODIFY;
        UNTIL InvPostGrp.NEXT = 0;
    end;

    procedure "General Ledger Setup"()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.FIND('-');
        GLSetup.TESTFIELD(GLSetup."Tour Dimension Code");
        GLSetup.TESTFIELD(GLSetup."Employee Dimension Code");
        GLSetup.TESTFIELD(GLSetup."Tour Nos.");
        GLSetup.TESTFIELD(GLSetup."Customer Dimension Code");
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        GLSetup.TESTFIELD(GLSetup."Item Dimension Code");
        GLSetup.TESTFIELD(GLSetup."Location Dimension Code");

        GLSetup.VALIDATE(GLSetup."Tour Dimension Code");
        GLSetup.VALIDATE(GLSetup."Employee Dimension Code");
        GLSetup.VALIDATE(GLSetup."Tour Nos.");
        GLSetup.VALIDATE(GLSetup."Customer Dimension Code");
        GLSetup.VALIDATE(GLSetup."Vendor Dimension Code");
        GLSetup.VALIDATE(GLSetup."Item Dimension Code");
        GLSetup.VALIDATE(GLSetup."Location Dimension Code");
        GLSetup.MODIFY;
    end;

    procedure "Bank Account"()
    var
        "Bank Account": Record "Bank Account";
    begin
        "Bank Account".FIND('-');
        REPEAT
            Code := "Bank Account"."No.";
            windows.UPDATE;
            "Bank Account".TESTFIELD("Bank Account"."Bank Account No.");
            "Bank Account".VALIDATE("Bank Account"."Bank Account No.");
            "Bank Account".TESTFIELD("Bank Account"."Bank Acc. Posting Group");
            "Bank Account".VALIDATE("Bank Account"."Bank Acc. Posting Group");
            "Bank Account".MODIFY;
        UNTIL "Bank Account".NEXT = 0;
    end;


    procedure "Sales & Receivables Setup"()
    var
        "Sales & Receivables Setup": Record "Sales & Receivables Setup";
    begin
        "Sales & Receivables Setup".FIND('-');
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Customer Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Customer Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Quote Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Quote Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Order Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Order Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Invoice Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Invoice Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Posted Invoice Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Posted Invoice Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Credit Memo Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Credit Memo Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Posted Credit Memo Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Posted Credit Memo Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Posted Shipment Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Posted Shipment Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Reminder Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Reminder Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Issued Reminder Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Issued Reminder Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Fin. Chrg. Memo Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Fin. Chrg. Memo Nos.");
        "Sales & Receivables Setup".TESTFIELD("Sales & Receivables Setup"."Issued Fin. Chrg. M. Nos.");
        "Sales & Receivables Setup".VALIDATE("Sales & Receivables Setup"."Issued Fin. Chrg. M. Nos.");
        "Sales & Receivables Setup".MODIFY;
    end;

    procedure "Purchases & Payables Setup"()
    var
        "Purchases & Payables Setup": Record "Purchases & Payables Setup";
    begin
        "Purchases & Payables Setup".FIND('-');
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Vendor Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Vendor Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Quote Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Quote Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Order Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Order Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Invoice Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Invoice Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Posted Invoice Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Posted Invoice Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Credit Memo Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Credit Memo Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Posted Credit Memo Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Posted Credit Memo Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Posted Receipt Nos.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Posted Receipt Nos.");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Rejection Reason Code");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Rejection Reason Code");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."Shortage Reason Code");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."Shortage Reason Code");
        "Purchases & Payables Setup".TESTFIELD("Purchases & Payables Setup"."RFQ No.");
        "Purchases & Payables Setup".VALIDATE("Purchases & Payables Setup"."RFQ No.");
        "Purchases & Payables Setup".MODIFY;
    end;

    procedure "Inventory Setup"()
    var
        "Inventory Setup": Record "Inventory Setup";
    begin
        "Inventory Setup".FIND('-');
        "Inventory Setup".TESTFIELD("Inventory Setup"."Item Nos.");
        "Inventory Setup".VALIDATE("Inventory Setup"."Item Nos.");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Transfer Order Nos.");
        "Inventory Setup".VALIDATE("Inventory Setup"."Transfer Order Nos.");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Posted Transfer Shpt. Nos.");
        "Inventory Setup".VALIDATE("Inventory Setup"."Posted Transfer Shpt. Nos.");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Posted Transfer Rcpt. Nos.");
        "Inventory Setup".VALIDATE("Inventory Setup"."Posted Transfer Rcpt. Nos.");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Type Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Type Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Type Catogery Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Type Catogery Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Size Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Size Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Design Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Design Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Color Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Color Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Packing Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Packing Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Quality Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Quality Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."Plant Code");
        "Inventory Setup".VALIDATE("Inventory Setup"."Plant Code");
        "Inventory Setup".TESTFIELD("Inventory Setup"."RGP In Nos.");
        "Inventory Setup".VALIDATE("Inventory Setup"."RGP In Nos.");
        "Inventory Setup".TESTFIELD("Inventory Setup"."RGP Out Nos.");
        "Inventory Setup".VALIDATE("Inventory Setup"."RGP Out Nos.");
        "Inventory Setup".MODIFY;
    end;

    procedure "Salesperson/Purchaser"()
    var
        "Salesperson/Purchaser": Record "Salesperson/Purchaser";
    begin
        "Salesperson/Purchaser".FIND('-');
        REPEAT
            Code := "Salesperson/Purchaser".Code;
            windows.UPDATE;

            "Salesperson/Purchaser".MODIFY;
        UNTIL "Salesperson/Purchaser".NEXT = 0;
    end;

    procedure "General Posting Setup"()
    var
        "General Posting Setup": Record "General Posting Setup";
    begin
        "General Posting Setup".FIND('-');
        REPEAT
            Code := "General Posting Setup"."Gen. Bus. Posting Group" + ' ' + "General Posting Setup"."Gen. Prod. Posting Group";
            windows.UPDATE;
            "General Posting Setup".VALIDATE("General Posting Setup"."Gen. Bus. Posting Group");
            "General Posting Setup".VALIDATE("General Posting Setup"."Gen. Prod. Posting Group");
            "General Posting Setup".VALIDATE("General Posting Setup"."Sales Account");
            "General Posting Setup".VALIDATE("General Posting Setup"."Purch. Account");
            "General Posting Setup".VALIDATE("General Posting Setup"."COGS Account");
            "General Posting Setup".VALIDATE("General Posting Setup"."Sales Credit Memo Account");
            "General Posting Setup".VALIDATE("General Posting Setup"."Purch. Credit Memo Account");
            "General Posting Setup".VALIDATE("General Posting Setup"."Direct Cost Applied Account");
            "General Posting Setup".MODIFY;
        UNTIL "General Posting Setup".NEXT = 0;
    end;
}

