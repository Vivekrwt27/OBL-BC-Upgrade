table 50061 "C-form"
{

    fields
    {
        field(3; "No."; Code[30])
        {
            TableRelation = "Sales Invoice Header";

            trigger OnValidate()
            begin
                IF SIH.GET("No.") THEN BEGIN
                    //  SIH.CALCFIELDS("Amount to Customer"); //16225  TABLE FIELD N/F
                    //   "Invoice Amount" := SIH."Amount to Customer";//16225  TABLE FIELD N/F
                    "Customer No." := SIH."Sell-to Customer No.";
                    "Location Code" := SIH."Location Code";
                    "Branch Code" := SIH."Shortcut Dimension 1 Code";
                    //  "Customer Type" := SIH."Customer Type";//16225  TABLE FIELD N/F
                    //  "ORC Dealer Code" := SIH."Dealer Code";//16225  TABLE FIELD N/F
                    "Sell To Customer Name" := SIH."Sell-to Customer Name";
                    "Post Code" := SIH."Sell-to Post Code";
                    //   SIH.CALCFIELDS("State name");//16225  TABLE FIELD N/F
                    //  "State Desc." := SIH."State name";//16225  TABLE FIELD N/F
                    //  "Tin No." := SIH."Tin No.";//16225  TABLE FIELD N/F
                    "Posting Date" := SIH."Posting Date";
                    "Salesperson Code" := SIH."Salesperson Code";
                    //   SIH.CALCFIELDS("Amount to Customer");//16225  TABLE FIELD N/F
                    //  "Invoice Amount" := SIH."Amount to Customer";//16225  TABLE FIELD N/F
                    //  SIH.CALCFIELDS("Tax Base");//16225  TABLE FIELD N/F
                    //   "Tax Base Amount" := SIH."Tax Base";//16225  TABLE FIELD N/F
                    //  SIH.CALCFIELDS("Sales Tax Amount");//16225  TABLE FIELD N/F
                    //  "Cst Amount" := SIH."Sales Tax Amount";//16225  TABLE FIELD N/F
                    "No of Days" := TODAY - SIH."Posting Date";
                    "Tax Code" := SIH."Tax Area Code";


                    IF (COPYSTR("No.", 1, 4) = 'SIGJ') OR (COPYSTR("No.", 1, 4) = 'HIGJ') THEN BEGIN
                        //          Cform."Tax Base Amount" := "Tax Base"-ABS("Invoice Discount Amount");
                        SIH.CALCFIELDS("Invoice Discount Amount");
                        // "Tax Base Amount" := SIH."Tax Base" + SIH."Invoice Discount Amount";//16225  TABLE FIELD N/F
                        "Full Tax Liability" := ("Tax Base Amount" / 1.02 * 12 / 100);
                    END ELSE
                        // "Tax Base Amount" := SIH."Tax Base";//16225  TABLE FIELD N/F

                        tAXpERCENTAGE := 0;
                    tAL.RESET;
                    tAL.SETRANGE("Tax Area", SIH."Tax Area Code");
                    IF tAL.FINDFIRST THEN BEGIN
                        REPEAT
                            tAL.CALCFIELDS("Tax %");
                            tAXpERCENTAGE += tAL."Tax %";
                        UNTIL tAL.NEXT = 0;
                    END;
                    "Tax %" := tAXpERCENTAGE;
                    "Full Tax Liability" := ("Tax Base Amount" * "Tax %" / 100);
                    "Differential Tax Liability" := ("Full Tax Liability" - "Cst Amount");

                    "Followup Status" := 'Pending';
                    Interest := (("Differential Tax Liability" * 24 / 100) / 365 * "No of Days");
                    "Total Tax Liability" := ("Differential Tax Liability" + Interest);
                    "C-Form Pending Amt" := "Tax Base Amount" - "C-Form Recd Amt";
                    "C Form Recd Date" := 0D;
                    //16225 TABLE N/F START
                    /* Periods.SETFILTER("Starting Date", '>=%1', "Posting Date");
                     IF Periods.FINDFIRST THEN
                         Period := FORMAT(Periods.Quarter);

                     IF CUSTOMER.GET("Customer No.") THEN
                         "PCH Code" := CUSTOMER."PCH Code";*/
                    //16225 TABLE N/F END   
                END;
            end;
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
            ValidateTableRelation = true;
        }
        field(5; "Invoice Amount"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(6; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(7; "Branch Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Customer Type"; Code[10])
        {
        }
        field(9; "ORC Dealer Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));
        }
        field(10; "Sell To Customer Name"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Sell To Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Sell To City"; Text[30])
        {
            CalcFormula = Lookup("Post Code"."City" WHERE(Code = FIELD("Post Code")));
            Caption = 'Sell To City';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Bill-to City","Bill-to Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity("Bill-to City","Bill-to Post Code");
            end;
        }
        field(12; "State Desc."; Text[50])
        {
            DateFormula = true;
            Editable = false;
        }
        field(13; "Tin No."; Code[20])
        {
            Editable = false;
        }
        field(14; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(15; "Salesperson Description"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser"."Name" WHERE("Code" = FIELD("Salesperson Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Tax Base Amount"; Decimal)
        {
        }
        field(18; "C Form No."; Code[25])
        {

            trigger OnValidate()
            begin
                "C Form Recd Date" := TODAY;
                IF (STRLEN("C Form No.") < 5) AND ("C Form No." <> '') THEN
                    ERROR(Text16501);

                IF "C Form No." = '' THEN
                    ERROR(Text10001);

                IF "C Form No." <> '' THEN BEGIN
                    "Followup Status" := 'Received';
                    Interest := 0;
                    "Total Tax Liability" := 0;
                    "Differential Tax Liability" := 0;
                    "C-Form Recd Amt" := "C-Form Pending Amt";
                    "C-Form Pending Amt" := 0;
                END;
            end;
        }
        field(19; "Cst Amount"; Decimal)
        {
        }
        field(20; "C Form Recd Date"; Date)
        {
        }
        field(21; "No of Days"; Integer)
        {
        }
        field(22; Interest; Decimal)
        {
        }
        field(23; "Tax Code"; Code[20])
        {
        }
        field(24; "Tax %"; Decimal)
        {
            FieldClass = Normal;
        }
        field(25; "Full Tax Liability"; Decimal)
        {
        }
        field(26; "Total Tax Liability"; Decimal)
        {
        }
        field(27; "Sent Date"; Date)
        {
        }
        field(28; Zone; Text[20])
        {
            //CalcFormula = Lookup("Customer"."Zone" WHERE ("No."=FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(29; "PCH Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(31; "C-Form Person"; Text[30])
        {
        }
        field(32; "Followup Status"; Text[30])
        {
        }
        field(33; "C-Form Recd Amt"; Decimal)
        {
        }
        field(34; "C-Form Pending Amt"; Decimal)
        {
        }
        field(35; Period; Text[3])
        {
        }
        field(36; "Differential Tax Liability"; Decimal)
        {
        }
        field(37; "PCH Name"; Text[30])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("PCH Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "ORC Dealer Name"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("ORC Dealer Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(40; "Remove Invoice"; Boolean)
        {
        }
        field(41; Brand; Text[7])
        {
        }
        field(42; "No. Series"; Text[10])
        {
        }
        field(43; "Current Sales Invoice"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.")
        {
        }
        key(Key3; "Current Sales Invoice")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text16501: Label 'C Form No. Should Not Be Less Then 5 Cherator';
        SIH: Record "Sales Invoice Header";
        tAL: Record "Tax Area Line";
        tAXpERCENTAGE: Decimal;
        //Periods: Record 16501; //16225 TABLE N/F
        CUSTOMER: Record Customer;
        Text10001: Label 'C. Form No. Cannot be Blank';
        UserLocation: Record "User Location";
        UserSetup1: Record "User Setup";
        Location1: Record "User Location";
}

