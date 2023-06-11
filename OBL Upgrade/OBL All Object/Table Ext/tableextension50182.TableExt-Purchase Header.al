tableextension 50182 tableextension50182 extends "Purchase Header"
{
    // 
    // 
    // MIJS, MBA-Infosoft, Jalaj Srivastava,
    //   : Provide the functionality so that Branch code can be posted same as Location code while the posting
    fields
    {

        /* modify("Posting Description")
        {

            Description = '50>>250,TRI DG';
        } */


        modify("Reason Code")
        {
            TableRelation = "Reason Code".Code WHERE(Purchase = CONST(true));
        }
        modify(Status)
        {

            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Short Close,Authorization1,Approved,Authorization3,Authorized,Closed';
            trigger OnAfterValidate()
            begin
                //Keshav
                IF Status = Status::Released THEN
                    "Approval Status" := "Approval Status"::Approved
                ELSE
                    "Approval Status" := "Approval Status"::"Not Approved";
                //Keshav

            end;
        }
        /*   modify("Form Code")
           {
               TableRelation = IF ("C Form" = CONST(No)) "State Forms"."Form Code" WHERE(State = FIELD(State),
                                                                                      "Transit Document" = CONST(false))
               ELSE
               IF ("C Form" = CONST(true)) "Form Codes".Code WHERE("C Form" = CONST(true));
           }
           modify(Structure)
           {
               TableRelation = "Structure Header" WHERE("Structure Type" = FILTER('Purchase|Others'),
                                                         "Tax Abatement" = CONST(false));
           }*/



        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
                GLSetup: Record "General Ledger Setup";
                locationREC: Record 14;
            begin
                IF NOT SkipBuyFromContact THEN
                    "Vendor Classification" := Vend."Vendor Classification";
                "Security Amount" := Vend."Security Amount";
                "Security Date" := Vend."Security Date";
                IF NOT SkipBuyFromContact THEN
                    //  UpdateBuyFromCont("Buy-from Vendor No.");

                    GLSetup.GET;
                //ND Tri Start Cust 38
                GeneralLedgerSetup.RESET;
                GeneralLedgerSetup.FIND('-');
                Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    VALIDATE("Shortcut Dimension 1 Code", Location1."Location Dimension"); //TEAM::3333
                    VALIDATE("Shortcut Dimension 8 Code", GLSetup."Location Dimension Code"); //TEAM::3333
                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;


                end;



                "Location State Code" := xRec."Location State Code";
                "Location GST Reg. No." := xRec."Location GST Reg. No.";
                "Shortcut Dimension 1 Code" := xrec."Shortcut Dimension 1 Code";


            end;
        }

        modify("Buy-from Vendor Name")
        {
            trigger OnAfterValidate()
            var
                locationREC: Record 14;
            begin
                "Location State Code" := xRec."Location State Code";
                "Location GST Reg. No." := xRec."Location GST Reg. No.";
                "Shortcut Dimension 1 Code" := xrec."Shortcut Dimension 1 Code";
            end;
        }


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".



        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        modify("Ship-to Code")// 15578
        {
            trigger OnAfterValidate()
            var
                ShipToAddr: Record "Ship-to Address";
                Cust: Record Customer;

            begin
                IF ShipToAddr."Location Code" <> '' THEN
                    IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                        VALIDATE("Location Code", ShipToAddr."Location Code")
                    else
                        IF Cust."Location Code" <> '' THEN
                            IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                VALIDATE("Location Code", Cust."Location Code");
            end;
        }


        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".


        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                PurchaseLine2.RESET;
                PurchaseLine2.SETFILTER(PurchaseLine2."Document Type", '%1', "Document Type");
                PurchaseLine2.SETFILTER("Document No.", "No.");
                IF PurchaseLine2.FIND('-') THEN
                    REPEAT
                        PurchaseLine2."Posting Date 1" := "Posting Date";
                        PurchaseLine2.MODIFY;
                    UNTIL PurchaseLine2.NEXT = 0;

            end;
        }


        //Unsupported feature: Code Modification on ""Payment Terms Code"(Field 23).OnValidate".

        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            begin
                ValidatePaymentTerms;
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                //ND Tri Start cust 64
                //IF xRec."Location Code"<>'' THEN
                //IF xRec."Location Code"<>"Location Code" THEN
                //ERROR('%1--%2',xRec."Location Code","Location Code");
                //IF NOT "Auto Create Return Order" THEN BEGIN
                UserLocation.RESET;
                IF "Document Type" = "Document Type"::Quote THEN
                    UserLocation.SETFILTER(UserLocation."Create Purchase Quote", '%1', TRUE);
                IF ("Document Type" = "Document Type"::Order) THEN
                    UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
                IF "Document Type" = "Document Type"::Invoice THEN
                    UserLocation.SETFILTER(UserLocation."Create Purchase Invoice", '%1', TRUE);
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    UserLocation.SETFILTER(UserLocation."Create Purchase Credit memo", '%1', TRUE);
                IF "Document Type" = "Document Type"::"Blanket Order" THEN
                    UserLocation.SETFILTER(UserLocation."Create Purchase Blanket Order", '%1', TRUE);
                IF "Document Type" = "Document Type"::"Return Order" THEN
                    UserLocation.SETFILTER(UserLocation."Create Purchase Return order", '%1', TRUE);

                UserLocation.SETFILTER(UserLocation."User ID", UPPERCASE(USERID));
                UserLocation.SETFILTER(UserLocation."Location Code", "Location Code");
                IF NOT UserLocation.FIND('-') THEN BEGIN
                    IF "Location Code" <> '' THEN BEGIN
                        IF DIALOG.CONFIRM('You are not allowed to use %1 location. Do you still want to continue.',
                                           TRUE, "Location Code") THEN BEGIN
                            IF "Document Type" = "Document Type"::Quote THEN
                                UserLocation.SETFILTER(UserLocation."Create Purchase Quote", '%1', TRUE);
                            IF ("Document Type" = "Document Type"::Order) THEN
                                UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
                            IF ("Document Type" = "Document Type"::Order) THEN
                                UserLocation.SETFILTER(UserLocation."Create Import Order", '%1', TRUE);
                            IF "Document Type" = "Document Type"::Invoice THEN
                                UserLocation.SETFILTER(UserLocation."Create Purchase Invoice", '%1', TRUE);
                            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                                UserLocation.SETFILTER(UserLocation."Create Purchase Credit memo", '%1', TRUE);
                            IF "Document Type" = "Document Type"::"Blanket Order" THEN
                                UserLocation.SETFILTER(UserLocation."Create Purchase Blanket Order", '%1', TRUE);
                            IF "Document Type" = "Document Type"::"Return Order" THEN
                                UserLocation.SETFILTER(UserLocation."Create Purchase Return order", '%1', TRUE);

                            UserLocation.RESET;
                            UserLocation.SETFILTER(UserLocation."User ID", USERID);
                            IF UserLocation.FIND('-') THEN
                                REPEAT
                                    IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                                        IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                                            IF Location1.GET(UserLocation."Location Code") THEN
                                                IF Location1."Main Location" = '' THEN
                                                    IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                                        VALIDATE("Location Code", UserLocation."Location Code");
                                        END ELSE BEGIN
                                            IF Location1.GET(UserLocation."Location Code") THEN
                                                IF Location1."Main Location" = '' THEN
                                                    IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                                        VALIDATE("Location Code", UserLocation."Location Code");
                                        END;
                                UNTIL UserLocation.NEXT = 0;
                        END ELSE BEGIN
                            ERROR('Please select another option.');
                        END;
                    END;
                END;

                IF Location.GET("Location Code") THEN
                    IF Location."Main Location" <> '' THEN BEGIN
                        IF "Location Code" <> '' THEN BEGIN
                            IF DIALOG.CONFIRM('You are not allowed to use %1 Sub location on header. Do you still want to continue.',
                                TRUE, "Location Code") THEN BEGIN
                                IF "Document Type" = "Document Type"::Quote THEN
                                    UserLocation.SETFILTER(UserLocation."Create Purchase Quote", '%1', TRUE);
                                IF ("Document Type" = "Document Type"::Order) THEN
                                    UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
                                IF ("Document Type" = "Document Type"::Order) THEN
                                    UserLocation.SETFILTER(UserLocation."Create Import Order", '%1', TRUE);
                                IF "Document Type" = "Document Type"::Invoice THEN
                                    UserLocation.SETFILTER(UserLocation."Create Purchase Invoice", '%1', TRUE);
                                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                                    UserLocation.SETFILTER(UserLocation."Create Purchase Credit memo", '%1', TRUE);
                                IF "Document Type" = "Document Type"::"Blanket Order" THEN
                                    UserLocation.SETFILTER(UserLocation."Create Purchase Blanket Order", '%1', TRUE);
                                IF "Document Type" = "Document Type"::"Return Order" THEN
                                    UserLocation.SETFILTER(UserLocation."Create Purchase Return order", '%1', TRUE);
                                UserLocation.RESET;
                                UserLocation.SETFILTER(UserLocation."User ID", USERID);
                                IF UserLocation.FIND('-') THEN
                                    REPEAT
                                        IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                                            IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                                                IF Location1.GET(UserLocation."Location Code") THEN
                                                    IF Location1."Main Location" = '' THEN
                                                        IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                                            VALIDATE("Location Code", UserLocation."Location Code");
                                            END ELSE BEGIN
                                                IF Location1.GET(UserLocation."Location Code") THEN
                                                    IF Location1."Main Location" = '' THEN
                                                        IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                                            VALIDATE("Location Code", UserLocation."Location Code");
                                            END;
                                    UNTIL UserLocation.NEXT = 0;
                            END ELSE BEGIN
                                ERROR('Please select another option.');
                            END;
                        END;
                    END;

                IF "Location Code" = '' THEN BEGIN
                    IF "Document Type" = "Document Type"::Quote THEN
                        UserLocation.SETFILTER(UserLocation."Create Purchase Quote", '%1', TRUE);
                    IF ("Document Type" = "Document Type"::Order) THEN
                        UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
                    IF ("Document Type" = "Document Type"::Order) THEN
                        UserLocation.SETFILTER(UserLocation."Create Import Order", '%1', TRUE);
                    IF "Document Type" = "Document Type"::Invoice THEN
                        UserLocation.SETFILTER(UserLocation."Create Purchase Invoice", '%1', TRUE);
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN
                        UserLocation.SETFILTER(UserLocation."Create Purchase Credit memo", '%1', TRUE);
                    IF "Document Type" = "Document Type"::"Blanket Order" THEN
                        UserLocation.SETFILTER(UserLocation."Create Purchase Blanket Order", '%1', TRUE);
                    IF "Document Type" = "Document Type"::"Return Order" THEN
                        UserLocation.SETFILTER(UserLocation."Create Purchase Return order", '%1', TRUE);
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                                IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                                    IF Location1.GET(UserLocation."Location Code") THEN
                                        IF Location1."Main Location" = '' THEN
                                            IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                                VALIDATE("Location Code", UserLocation."Location Code");
                                END ELSE BEGIN
                                    IF Location1.GET(UserLocation."Location Code") THEN
                                        IF Location1."Main Location" = '' THEN
                                            IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                                                VALIDATE("Location Code", UserLocation."Location Code");
                                END;
                        UNTIL UserLocation.NEXT = 0;
                END;

                IF "Location Code" <> '' THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETFILTER("User ID", USERID);
                    IF UserSetup.FIND('-') THEN
                        IF NOT UserSetup."Change Location" THEN
                            ERROR('You cannot change the location. Please contact your system administrator.');
                END;

                GLSetup.GET;
                GeneralLedgerSetup.RESET;
                GeneralLedgerSetup.FIND('-');
                Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    IF PH.GET("Document Type", "No.") THEN BEGIN
                        VALIDATE("Shortcut Dimension 1 Code", Location1."Location Dimension"); //TEAM::3333
                        VALIDATE("Shortcut Dimension 8 Code", GLSetup."Location Dimension Code"); //TEAM::3333
                    END;
                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;

                END;
                //ND Tri end cust 38
                //ND Tri1.0 Start
                IF Location.GET("Location Code") THEN
                    "Main Location" := Location."Main Location";
                //ND Tri1.0 End
                //Vipul Tri1.0 Start
                IF "Location Code" <> '' THEN BEGIN
                    IF Location.GET("Location Code") THEN
                        IF Location."Main Location" <> '' THEN
                            ERROR('You can not use Sub Locations on header.');
                    //Vipul Tri1.0 End
                    "Shortcut Dimension 1 Code" := "Location Code";//TRI-VKG ADD 220910
                END;



            end;

            trigger OnAfterValidate()
            var
                locationREC: Record 14;
            begin
                if "Location Code" <> '' then begin
                    locationREC.Get("Location Code");
                    "Location State Code" := locationREC."State Code";
                    "Location GST Reg. No." := locationREC."GST Registration No.";
                    "Shortcut Dimension 1 Code" := locationREC."Location Dimension";

                end;
            end;

        }


        //Unsupported feature: Code Modification on ""Currency Code"(Field 32).OnValidate".


        modify("Sell-to Customer No.")
        {
            trigger OnBeforeValidate()
            begin
                IF NOT Trading THEN BEGIN
                    IF "Sell-to Customer No." = '' THEN BEGIN
                        IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                            VALIDATE("Location Code", UserSetupMgt.GetLocation(1, '', "Responsibility Center"))
                    END ELSE BEGIN
                        VALIDATE("Ship-to Code", '');
                    END;
                END;

            end;
        }

        //Unsupported feature: Code Modification on ""Buy-from Post Code"(Field 88).OnValidate".

        modify("Buy-from Post Code")
        {
            trigger OnAfterValidate()
            begin
                //mo tri1.0 customization no. start
                IF Status = Status::Released THEN
                    ERROR(Text0001);
                //mo tri1.0 customization no. end

            end;
        }

        //Unsupported feature: Code Modification on ""Order Address Code"(Field 95).OnValidate".

        modify("Order Address Code")
        {
            trigger OnAfterValidate()
            begin
                IF Vend."Location Code" <> '' THEN
                    IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                        VALIDATE("Location Code", Vend."Location Code");

            end;
        }



        field(50000; Deleted; Boolean)
        {
        }
        field(50001; "New Status"; Option)
        {
            OptionMembers = " ","Short Close",Cancel;
        }
        field(50002; "RFQ No."; Code[20])
        {
            Description = 'customization 3';
            NotBlank = true;
        }
        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'customization 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Vendor));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'customization 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'customization 22';
        }
        field(50006; "Value of Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Description = 'Report 49';
            FieldClass = FlowField;
        }
        field(50009; "Vendor Invoice Date"; Date)
        {

            trigger OnValidate()
            begin
                /*
                //TRI SC

                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE(PurchRcptLine."Buy-from Vendor No.","Buy-from Vendor No.");
                IF PurchRcptLine.FIND('-') THEN REPEAT
                  IF "Vendor Invoice Date" < PurchRcptLine."Posting Date" THEN
                    ERROR(Text0002)
                   ELSE
                      "Vendor Invoice Date":=0D;
                UNTIL PurchRcptLine.NEXT=0;
               //TRI SC
                 */

            end;
        }
        field(50012; "Document Received from Bank"; Boolean)
        {
            Description = 'Report 84 EXIM';
        }
        field(50013; "Document Receiving Date"; Date)
        {
            Description = 'Report 84 EXIM';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "GE No."; Code[20])
        {

            trigger OnValidate()
            begin
                Purchheader1.RESET;
                Purchheader1.SETFILTER("GE No.", "GE No.");
                IF Purchheader1.FIND('-') THEN
                    ERROR('You have already used this No.');

                PurchHeaderA.RESET;
                PurchHeaderA.SETFILTER(Deleted, '%1', TRUE);
                PurchHeaderA.SETFILTER("GE No.", "GE No.");
                IF PurchHeaderA.FIND('-') THEN
                    ERROR('You have already used this No.');
            end;
        }
        field(50016; "Transporter's Code"; Code[20])
        {
            TableRelation = Vendor WHERE(Transporter1 = const(true));

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.RESET;
                IF vendor.GET("Transporter's Code") THEN
                    "Transporter Name" := vendor.Name
                ELSE
                    "Transporter Name" := '';
            end;
        }
        field(50017; "Quotation No."; Code[20])
        {
        }
        field(50018; "State Desc."; Text[50])
        {
            Editable = false;
        }
        field(50019; "Transporter Name"; Text[50])
        {
            Editable = false;
        }
        field(50020; "Delivery Period"; Text[30])
        {
        }
        field(50021; "Form 31 Amount"; Decimal)
        {
        }
        field(50022; "Currency Code 1"; Code[20])
        {
            Description = 'ND';
            TableRelation = Currency;
        }
        field(50023; "Terms of Delivery"; Option)
        {
            OptionCaption = ' ,FOB,EXW,C&W,CIF';
            OptionMembers = " ",FOB,EXW,"C&W",CIF;
        }
        field(50024; "Capital PO"; Boolean)
        {
            Description = 'TRI VS';
        }
        field(50025; "Ordered Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document No." = FIELD("No.")));
            Description = 'Ori UT on 020810';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Total Recd. Quantity"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Received" WHERE("Document No." = FIELD("No.")));
            Description = 'Ori UT on 020810';
            FieldClass = FlowField;
        }
        field(50030; "Rejection Date"; Date)
        {
            Description = 'Ori Ut';
        }
        field(50031; "Excise Approved (Accounts)"; Boolean)
        {
        }
        field(50032; "Capex No."; Code[20])
        {
            Description = 'Ori Ut';
            TableRelation = "Budget Master" WHERE(Status = CONST(Released),
                                                   "Location Code" = FIELD("Location Code"));
        }
        field(50088; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
            InitValue = true;
        }
        field(50089; "Other Comp. Location"; Code[10])
        {
            Description = 'MS-PB';
        }
        field(50093; "Truck No."; Text[15])
        {
        }
        field(50094; "GR No."; Code[15])
        {
        }
        field(50095; "E-Way Bill No.1"; Code[12])
        {
        } // 15578
        field(50096; "Vendor GST CN  available"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(50097; "Vendor CN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Locked Order"; Boolean)
        {
            Description = 'TRI DG';
        }
        field(60003; "Delivary Date"; Date)
        {
            Description = 'TRI SC';
        }
        field(60004; "Shortage CRN"; Boolean)
        {
            Description = 'TRI-VKG 23.09.10';
        }
        field(60005; "User Id"; Code[20])
        {
            Description = 'MS-VC';
        }
        field(60006; "PUrchase Type"; Option)
        {
            OptionMembers = "Purchase Order No.","Work Order No.........";
        }
        field(60007; "Quotation Date"; Date)
        {
        }
        field(60015; "Amendment No."; Code[10])
        {
        }
        field(60016; "Amendment Date"; Date)
        {
        }
        field(60017; "Releasing Date"; Date)
        {
        }
        field(60018; "Releasing Time"; Time)
        {
        }
        field(60019; "GE Date"; Date)
        {
        }
        field(60020; Residue; Text[4])
        {
        }
        field(60021; Moisture; Text[4])
        {
        }
        field(60022; "Form 38 No."; Code[20])
        {
        }
        field(60023; "Auto Create Return Order"; Boolean)
        {
        }
        field(60024; "Return Order Pend. For Posting"; Boolean)
        {
            CalcFormula = Exist("Purchase Header" WHERE("Document Type" = CONST("Return Order"),
                                                         "Return Ref. Order No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60025; "Return Ref. Order No."; Code[20])
        {
        }
        field(60026; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(60027; "Approver ID"; Code[20])
        {
            Description = 'MSVRN 270818';
            Editable = false;
            TableRelation = "User Setup"."User Name";
        }
        field(60028; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            TableRelation = "NOE Permission".NOE WHERE(Location = FIELD("Location Code"));
        }
        field(60029; "Approver Name"; Text[50])
        {
        }
        field(60030; "Reason for Approval"; Text[80])
        {
        }
        field(60031; "Approval Status"; Option)
        {
            Description = 'Keshav';
            Editable = false;
            OptionCaption = 'Not Approved,Approved';
            OptionMembers = "Not Approved",Approved;
        }
        field(60032; Currency_Code; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'keshav 18042020';
            TableRelation = Currency;
        }
        field(60033; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav 18042020';
        }
        field(80000; "Due Date Calc. On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor Invoice Date,Inv Posting Date,GRN Date,Document Date';
            OptionMembers = " ","Vendor Invoice Date","Inv Posting Date","GRN Date","Document Date";

            trigger OnValidate()
            begin
                ValidatePaymentTerms;
            end;
        }
        field(80001; "GRN Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidatePaymentTerms;
            end;
        }
        field(80002; "Adv Payment"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("PO No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(80003; "User Location Code"; code[10])

        {
            DataClassification = ToBeClassified;
            Description = 'User Location Code';

            trigger OnLookup()
            begin
                UserLocation.Reset();
                UserLocation.SetRange("User ID", UserId);
                if UserLocation.FindSet then
                    IF PAGE.RUNMODAL(50003, UserLocation) = ACTION::LookupOK THEN
                        IF NOT ("Document Type" = "Document Type"::Order) THEN//Keshav10042020
                            VALIDATE("Location Code", UserLocation."Location Code");
                VALIDATE("Shortcut Dimension 1 Code", "Location Code");//Oriut

            end;
        }
        field(80004; "Reason Code New"; Code[10])
        {

            TableRelation = "Reason Code".Code WHERE(Purchase = CONST(true));

            trigger OnValidate()
            begin
                Validate("Reason Code", "Reason Code New");
            end;
        }

        field(80005; "Return Order No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80006; "Return Order Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80007; "Posting Description New"; Text[250])//Posting description is only 100 words In Base need 250 words atleast.
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Description';
        }

    }
    keys
    {
        /* key(Key10; "Vendor Classification", "No.")
         {
         }*/
    }

    trigger OnDelete()
    begin
        IF "Document Type" = "Document Type"::Order THEN
            IF UPPERCASE(USERID) <> 'ADMIN' THEN
                ERROR('You Cannot Delete the Purchase Order');
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 8;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 9;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 36;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 10;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 11;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 12;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 13;
        //ND Tri Start Cust 38
        IF "Location Code" <> '' THEN BEGIN
            Permissions.Type(UserAccess, xRec."Location Code");
            Permissions.Type(UserAccess, "Location Code");
        END;
        //ND Tri End Cust 38

    end;


    trigger OnInsert()
    var
        rNoSeries: Record 308;
        rUserLocation: Record "User Location";
        locationREC: Record 14;
    begin

        IF NOT "Auto Create Return Order" THEN BEGIN
            //ND Tri Start cust 38
            UserLocation.RESET;
            UserLocation.SETFILTER("User ID", USERID);
            IF "Document Type" = "Document Type"::Quote THEN
                UserLocation.SETFILTER(UserLocation."Create Purchase Quote", '%1', TRUE);
            IF ("Document Type" = "Document Type"::Order) THEN
                UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
            //IF ("Document Type" = "Document Type"::Order) THEN
            // UserLocation.SETFILTER(UserLocation."Create Import Order",'%1',TRUE);
            IF "Document Type" = "Document Type"::Invoice THEN
                UserLocation.SETFILTER(UserLocation."Create Purchase Invoice", '%1', TRUE);
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                UserLocation.SETFILTER(UserLocation."Create Purchase Credit memo", '%1', TRUE);
            IF "Document Type" = "Document Type"::"Blanket Order" THEN
                UserLocation.SETFILTER(UserLocation."Create Purchase Blanket Order", '%1', TRUE);
            IF "Document Type" = "Document Type"::"Return Order" THEN
                UserLocation.SETFILTER(UserLocation."Create Purchase Return order", '%1', TRUE);
            IF UserLocation.FIND('-') THEN
                REPEAT
                    IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                        IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                            IF Location1.GET(UserLocation."Location Code") THEN
                                IF Location1."Main Location" = '' THEN
                                    VALIDATE("Location Code", UserLocation."Location Code");
                        END ELSE BEGIN
                            IF Location1.GET(UserLocation."Location Code") THEN
                                IF Location1."Main Location" = '' THEN
                                    VALIDATE("Location Code", UserLocation."Location Code");
                        END;
                UNTIL UserLocation.NEXT = 0;

            IF "Document Type" = "Document Type"::Quote THEN
                UserAccess := 8;
            IF ("Document Type" = "Document Type"::Order) THEN
                UserAccess := 9;
            IF "Document Type" = "Document Type"::Invoice THEN
                UserAccess := 10;
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                UserAccess := 11;
            IF "Document Type" = "Document Type"::"Blanket Order" THEN
                UserAccess := 12;
            IF "Document Type" = "Document Type"::"Return Order" THEN
                UserAccess := 13;
            Permissions.Type(UserAccess, "Location Code");

            //ND Tri End cust 38
        END;
        //ravi Tri Start
        IF "Document Type" = "Document Type"::Quote THEN
            "Quotation No." := "No.";
        //ravi Tri End

        //mo tri1.0 start
        //IF "Document Type" = "Document Type" ::"Credit Memo" THEN
        //  "Vendor Cr. Memo No." := "No.";
        //mo tri1.0 end

        //"User Id" := USERID;

        /*IF "Purchaser Code" = '' THEN
            SetDefaultPurchaser;

       NODNOCHeader.RESET;
        IF NODNOCHeader.GET(NODNOCHeader.Type::Vendor, NODNOCHeader."No.") THEN
            "Assessee Code" := NODNOCHeader."Assesse Code";
*/
        rNoSeries.RESET;
        rNoSeries.SETRANGE(Code, Rec."No. Series");
        IF rNoSeries.FIND('-') THEN BEGIN
            rNoSeries.TESTFIELD(Location);
            rUserLocation.RESET;
            rUserLocation.SETRANGE("User ID", USERID);
            rUserLocation.SETRANGE("Location Code", rNoSeries.Location);
            rUserLocation.SETRANGE("Create Purchase Order", TRUE);
            IF rUserLocation.FIND('-') THEN BEGIN
                VALIDATE("Location Code", rNoSeries.Location);

                locationREC.Get(rNoSeries.Location);
                "Location State Code" := locationREC."State Code";
                "Location GST Reg. No." := locationREC."GST Registration No.";
                "Shortcut Dimension 1 Code" := locationREC."Location Dimension";
                "User Location Code" := rNoSeries.Location;

                //Rec.MODIFY;
            END ELSE BEGIN
                ERROR('You are not authorised to use this location : ' + rNoSeries.Location);
            END;
        END;







    end;

    trigger OnModify()
    begin
        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 8;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 9;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 10;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 11;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 12;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 13;
        //IF  THEN BEGIN
        Permissions.Type(UserAccess, xRec."Location Code");
        rec."Location Code" := xRec."Location Code";
        Permissions.Type(UserAccess, rec."Location Code");

        PurchaseLine1.RESET;
        PurchaseLine1.SETFILTER("Document No.", "No.");
        IF PurchaseLine1.FIND('-') THEN
            REPEAT
                ItemNo := PurchaseLine1."No.";
            //  PurchaseLine1.VALIDATE(PurchaseLine1."No.",ItemNo);
            UNTIL PurchaseLine1.NEXT = 0;

    end;




    //Unsupported feature: Variable Insertion (Variable: TaxLocation) (VariableCollection) on "RecreatePurchLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".// Table TaxLocation N/F

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PurchLinesExist THEN BEGIN
      IF HideValidationDialog THEN
        Confirmed := TRUE
      ELSE
        Confirmed :=
          CONFIRM(
            Text016 +
            Text004,FALSE,ChangedFieldName);
      IF Confirmed THEN BEGIN
        PurchLine.LOCKTABLE;
        ItemChargeAssgntPurch.LOCKTABLE;
    #12..15
        PurchLine.SETRANGE("Document No.","No.");
        IF PurchLine.FINDSET THEN BEGIN
          REPEAT
            PurchLine.TESTFIELD("Quantity Received",0);
            PurchLine.TESTFIELD("Quantity Invoiced",0);
            PurchLine.TESTFIELD("Return Qty. Shipped",0);
            PurchLine.CALCFIELDS("Reserved Qty. (Base)");
            PurchLine.TESTFIELD("Reserved Qty. (Base)",0);
            PurchLine.TESTFIELD("Receipt No.",'');
            PurchLine.TESTFIELD("Return Shipment No.",'');
            PurchLine.TESTFIELD("Blanket Order No.",'');
            IF PurchLine."Drop Shipment" OR PurchLine."Special Order" THEN BEGIN
              CASE TRUE OF
                PurchLine."Drop Shipment":
    #30..133
                      PurchLine."Work Center No." := PurchLineTmp."Work Center No.";
                      PurchLine."Prod. Order Line No." := PurchLineTmp."Prod. Order Line No.";
                      PurchLine."Overhead Rate" := PurchLineTmp."Overhead Rate";
                    END;
                  END;
              END;
    #140..196
        ERROR(
          Text018,ChangedFieldName);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
        Confirmed := TRUE;
         { CONFIRM(
            Text016 +
            Text004,FALSE,ChangedFieldName);}
    #9..18
          {  PurchLine.TESTFIELD("Quantity Received",0);
    #20..26
            } //TRI
    #27..136
                      PurchLine.VALIDATE(PurchLine."Direct Unit Cost",PurchLineTmp."Direct Unit Cost"); //TRI VS 270410 Add Start
                      //TRI VS 270410 Add Start
                      TaxLocation.RESET;
                      TaxLocation.SETRANGE(Type,TaxLocation.Type::Vendor);
                      TaxLocation.SETRANGE("Dispatch / Receiving Location","Location Code");
                      TaxLocation.SETRANGE("Customer / Vendor Location",State);
                      IF TaxLocation.FIND('-') THEN
                        "Tax Area Code" := TaxLocation."Tax Area Code";
                      //TRI VS 270410 Add Stop
                      PurchLine.INSERT;
    #137..199
    */
    //end;




    procedure CreateApprovalEnt(var PurchaseHeader: Record "Purchase Header")
    var
        NOEPermission: Record "NOE Permission";
        ApprovalEntry: Record "Approval Entry";
        Txt001: Label 'Approval entries already created for PO No. %1!';
        PurchaseLine: Record "Purchase Line";
        TotalAmt: Decimal;
        NOEPermission1: Record "NOE Permission";
        UpperLimit: Decimal;
        IndentRelease: Codeunit IndentRelease;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET;
        IF PurchasesPayablesSetup."Indent No. Mandatory" THEN BEGIN
            PurchaseLine.SETFILTER("Document Type", '%1', PurchaseHeader."Document Type");
            PurchaseLine.SETFILTER("Document No.", '%1', PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
            IF PurchaseLine.FINDFIRST THEN
                REPEAT
                    IF PurchaseLine.Quantity <> 0 THEN //Kulbhushan
                        PurchaseLine.TESTFIELD("Indent No.");
                UNTIL PurchaseLine.NEXT = 0;
        END;
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 38);
        ApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Created);
        IF ApprovalEntry.FINDFIRST THEN
            ERROR(Txt001, "No.");
        //MSAK
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 38);
        ApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Rejected);
        IF ApprovalEntry.FINDFIRST THEN
            TESTFIELD("Reason for Approval");
        //MSAK
        CLEAR(ApprovalMgt);
        PurchaseHeader.CALCFIELDS(Amount, "Amount Including VAT");

        NOEPermission.RESET;
        NOEPermission.SETCURRENTKEY(Limit);
        NOEPermission.ASCENDING;
        NOEPermission.SETRANGE(Location, PurchaseHeader."Location Code");
        NOEPermission.SETRANGE(NOE, PurchaseHeader.NOE);
        NOEPermission.SETFILTER(Limit, '>=%1', PurchaseHeader."Amount Including VAT");
        IF NOEPermission.FINDFIRST THEN
            UpperLimit := NOEPermission.Limit;
        IF UpperLimit <> 0 THEN BEGIN
            //UpperLimit := 9999999999999.0;
            //  ERROR('Limit Not Defined for the current NOE');
            NOEPermission.RESET;
            NOEPermission.SETCURRENTKEY(Limit);
            NOEPermission.ASCENDING;
            NOEPermission.SETRANGE(Location, PurchaseHeader."Location Code");
            NOEPermission.SETRANGE(NOE, PurchaseHeader.NOE);
            NOEPermission.SETFILTER(Limit, '<=%1', UpperLimit);
            IF NOEPermission.FINDFIRST THEN BEGIN
                REPEAT
                    ApprovalMgt.MakeApprovalEntry(38, PurchaseHeader."No.", 2, USERID, NOEPermission.Approver, PurchaseHeader."Amount Including VAT", '');
                UNTIL NOEPermission.NEXT = 0;
            END;
        END ELSE BEGIN

            ReleasePurchaseDocument.RUN(PurchaseHeader);
        END;
        //PurchaseHeader.Status := PurchaseHeader.Status::"Pending Approval"; //MSAK

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 38);
        ApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Created);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IndentRelease.SendNotificationforPurch(PurchaseHeader); //Approval -- final 040918
        END;
        //KB211218
    end;

    procedure CancelApprovalEntry(var PurchaseHeader: Record "Purchase Header")
    begin
        ApprovalMgt.CancelPurchaseApprovalEnt(PurchaseHeader."No."); //KB211218
        PurchaseHeader.Status := PurchaseHeader.Status::Open;
    end;

    procedure CheckTradingPO(): Boolean
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", "No.");
        PurchaseLine.SETFILTER("Item Category Code", '%1|%2|%3|%4|%5', 'M001', 'D001', 'T001', 'H001', 'SAMPLE');
        IF PurchaseLine.FINDFIRST THEN
            EXIT(TRUE);
    end;

    local procedure ValidatePaymentTerms()
    var
        DueDateCalc: Date;
    begin
        //TESTFIELD("Due Date Calc. On");
        CASE "Due Date Calc. On" OF
            "Due Date Calc. On"::"Document Date":
                BEGIN
                    TESTFIELD("Document Date");
                    DueDateCalc := "Document Date";
                END;
            "Due Date Calc. On"::"Inv Posting Date":
                BEGIN
                    TESTFIELD("Posting Date");
                    DueDateCalc := "Posting Date";
                END;
            "Due Date Calc. On"::"GRN Date":
                BEGIN
                    IF "Document Type" = "Document Type"::Invoice THEN
                        TESTFIELD("GRN Date");
                    DueDateCalc := "GRN Date";
                END;
            "Due Date Calc. On"::"Vendor Invoice Date":
                BEGIN
                    IF "Document Type" = "Document Type"::Invoice
                      THEN
                        TESTFIELD("Vendor Invoice Date");
                    DueDateCalc := "Vendor Invoice Date";
                END;
        END;
        IF ("Payment Terms Code" <> '') AND (DueDateCalc <> 0D) THEN BEGIN
            PaymentTerms.GET("Payment Terms Code");
            IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
            THEN BEGIN
                VALIDATE("Due Date", DueDateCalc);
                VALIDATE("Pmt. Discount Date", 0D);
                VALIDATE("Payment Discount %", 0);
            END ELSE BEGIN
                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", DueDateCalc);
                "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", DueDateCalc);
                /* IF NOT UpdateDocumentDate THEN
                     VALIDATE("Payment Discount %", PaymentTerms."Discount %")*///
            END;
        END ELSE BEGIN
            VALIDATE("Due Date", DueDateCalc);
            /* IF NOT UpdateDocumentDate THEN BEGIN
                 VALIDATE("Pmt. Discount Date", 0D);
                 VALIDATE("Payment Discount %", 0);
             END;*///
        END;
        IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
            VALIDATE("Prepmt. Payment Terms Code", "Payment Terms Code");
    end;

    /* procedure CalculateTCSAmt() TCSAmt: Decimal
     var
         StructureOrderLineDetails: Record "13795";
     begin
         StructureOrderLineDetails.RESET;
         StructureOrderLineDetails.SETFILTER("Document Type", '%1', "Document Type");
         StructureOrderLineDetails.SETFILTER("Document No.", '%1', "No.");
         StructureOrderLineDetails.SETFILTER(StructureOrderLineDetails."Tax/Charge Code", '%1', 'TCS');
         IF StructureOrderLineDetails.FINDFIRST THEN
             REPEAT
                 TCSAmt += StructureOrderLineDetails."Amount (LCY)";
             UNTIL StructureOrderLineDetails.NEXT = 0;
     end;*/

    procedure CheckCapexEntry()
    var
        CapexEntry: Record "Capex Entry";
        PurchaseLine: Record "Purchase Line";
        PurchaseLine1: Record "Purchase Line";
        RpCapexNo: Code[50];
        BudgetMaster: Record "Budget Master";
        CapexOrderAmt: Decimal;
        CapexInvestmentAmt: Decimal;
        CapexErr001: Label 'Order Amount %1  is greater than Capex Investment Amount  %2';
    begin
        RemoveCapexEntry();

        RpCapexNo := '';
        PurchaseLine.SETCURRENTKEY("Capex No.");
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        PurchaseLine.SETRANGE("Document Type", "Document Type");
        PurchaseLine.SETFILTER("Capex No.", '<>%1', '');
        IF PurchaseLine.FINDFIRST THEN BEGIN
            REPEAT
                IF RpCapexNo <> PurchaseLine."Capex No." THEN BEGIN
                    PurchaseLine1.RESET();
                    PurchaseLine1.SETRANGE("Document No.", "No.");
                    PurchaseLine1.SETRANGE("Document Type", "Document Type");
                    PurchaseLine1.SETFILTER("Capex No.", PurchaseLine."Capex No.");
                    PurchaseLine1.CALCSUMS(Amount);

                    /*CapexEntry.RESET();
                    CapexEntry.SETRANGE("Entry Type",CapexEntry."Entry Type"::"Purchase Order");
                    CapexEntry.SETRANGE("Document Type",CapexEntry."Document Type"::Order);
                    CapexEntry.SETRANGE("Capex No.",PurchaseLine."Capex No.");
                    CapexEntry.CALCSUMS(Amount);*/
                    CapexOrderAmt := GetCapexOrderAmt(PurchaseLine."Capex No.");
                    CapexInvestmentAmt := GetCapexInvestAmt(PurchaseLine."Capex No.");
                    IF (CapexOrderAmt + PurchaseLine1.Amount) > CapexInvestmentAmt THEN
                        ERROR(CapexErr001, CapexOrderAmt + PurchaseLine1.Amount, CapexInvestmentAmt);
                END;
                /* CapexEntry.CreateCapexEntry(CapexEntry."Entry Type"::"Purchase Order", PurchaseLine."Capex No.", PurchaseLine."Location Code", "Posting Date", CapexEntry."Document Type"::Order,
                     PurchaseLine."Document No.", PurchaseLine."Line No.", PurchaseLine.Type, PurchaseLine."No.", PurchaseLine.Quantity, PurchaseLine."Unit Cost", PurchaseLine.Amount, PurchaseLine."Amount To Vendor",
                     PurchaseLine."Total GST Amount", PurchaseLine."Charges To Vendor", 0, CapexInvestmentAmt);*/ // 15578
                RpCapexNo := PurchaseLine."Capex No.";
            UNTIL PurchaseLine.NEXT = 0;
        END;

    end;

    procedure RemoveCapexEntry()
    var
        CapexEntry: Record "Capex Entry";
    begin
        CapexEntry.RESET();
        CapexEntry.SETRANGE("Entry Type", CapexEntry."Entry Type"::"Purchase Order");
        CapexEntry.SETRANGE("Document Type", CapexEntry."Document Type"::Order);
        CapexEntry.SETRANGE("Document No.", Rec."No.");
        IF CapexEntry.FINDFIRST THEN
            CapexEntry.DELETEALL();
    end;

    local procedure GetCapexOrderAmt(CapexNo: Code[50]): Decimal
    var
        BudgetMaster: Record "Budget Master";
    begin
        BudgetMaster.RESET();
        BudgetMaster.SETRANGE("No.", CapexNo);
        IF BudgetMaster.FINDFIRST THEN BEGIN
            BudgetMaster.CALCFIELDS("UnPosted Amount");
            EXIT(BudgetMaster."UnPosted Amount");
        END;
    end;

    local procedure GetCapexInvestAmt(CapexNo: Code[50]): Decimal
    var
        BudgetMaster: Record "Budget Master";
    begin
        BudgetMaster.RESET();
        BudgetMaster.SETRANGE("No.", CapexNo);
        IF BudgetMaster.FINDFIRST THEN
            EXIT(BudgetMaster."Investment (In INR)")
    end;

    var
        //NODNOCHeader: Record "13786";
        PH: Record "Purchase Header";
        Purchheader1: Record "Purchase Header";
        PaymentTerms: Record "Payment Terms";
        PurchHeaderA: Record "Purchase Header Archive";
        UserSetup: Record "User Setup";
        UserLocation: Record "User Location";
        Location1: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        ItemNo: Code[20];
        Permissions: Codeunit Permissions1;
        UserAccess: Integer;
        PurchaseLine1: Record "Purchase Line";
        UserSetup1: Record "User Setup";
        PurchaseLine2: Record "Purchase Line";
        StateVar: Record State;
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Text16501: Label 'Text';
        Text0001: Label 'Status must be Open while changing  the "Buy- from Post code" ';
        Text0002: Label 'Vendor Inv. Date must be later then Posting Date';
        Text165011: Label 'Text';
        Text165021: Label 'Text1';
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        UserSetupMgt: Codeunit "User Setup Management";
        Vend: Record Vendor;
}

