pageextension 50456 customercardE extends "Customer Card"
{
    layout
    {
        movebefore("Responsibility Center"; "Salesperson Code")

        moveafter("Credit Limit (LCY)"; "E-Mail", "Payment Terms Code")
        addafter("Phone No.")
        {
            field("Cust Landline No."; Rec."Cust Landline No.")
            {
                ApplicationArea = all;
            }
            field(Contact; Rec.Contact)
            {
                ApplicationArea = all;
            }

            field("Pin Code"; Rec."Pin Code")
            {
                ApplicationArea = all;
            }
            field("Aadhaar No."; Rec."Aadhaar No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Salesperson Code")
        {
            field("PCH Code"; Rec."PCH Code")
            {
                ApplicationArea = all;
            }
            field("Zonal Manager"; Rec."Zonal Manager")
            {
                ApplicationArea = all;
            }
            field("Zonal Head"; Rec."Zonal Head")
            {
                ApplicationArea = all;
            }
            field("Govt. SP Resp."; Rec."Govt. SP Resp.")
            {
                ApplicationArea = all;
            }
            field("Private SP Resp."; Rec."Private SP Resp.")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Area Code"; Rec."Area Code")
            {
                ApplicationArea = all;
            }


        }

        modify("GST Registration No.")
        {
            trigger OnBeforeValidate()
            var
                AllowedNOC: Record "Allowed NOC";
                Customer: Record Customer;
            begin
                if Rec."GST Registration No." = '' then begin
                    rec."P.A.N. No." := '';
                    rec."Assessee Code" := '';
                end;
                AllowedNOC.Reset();
                AllowedNOC.SetRange("Customer No.", rec."No.");
                AllowedNOC.SetRange("TCS Nature of Collection", '206C-1H');
                if not AllowedNOC.FindFirst() then begin
                    AllowedNOC.Init();
                    AllowedNOC."Customer No." := rec."No.";
                    AllowedNOC."TCS Nature of Collection" := '206C-1H';
                    AllowedNOC."Default NOC" := true;
                    AllowedNOC.Insert();
                end;
                //rec.TESTFIELD("GST Registration No.");
                rec.GenerateNODNOCData;
            end;
        }
        addafter("Balance (LCY)")
        {
            field("CF Customer"; Rec."CF Customer")
            {
                ApplicationArea = all;
            }
            field("Structure Change Item"; Rec."Structure Change Item")
            {
                ApplicationArea = all;
            }

            field("CF Limit"; Rec."CF Limit")
            {
                ApplicationArea = all;
            }
            field("CXO Target"; Rec."CXO Target")
            {
                ApplicationArea = all;
            }

            /* field("PCH Code"; Rec."PCH Code")
            {
                ApplicationArea = all;
            } */



            field("CTS 1"; Rec."CTS 1")
            {
                ApplicationArea = all;
            }
            field("CTS 2"; Rec."CTS 2")
            {
                ApplicationArea = all;
            }
            field("Cust. Company Type"; Rec."Cust. Company Type")
            {
                ApplicationArea = all;
            }
            field("Discount Group"; Rec."Discount Group")
            {
                ApplicationArea = all;
            }
            field("Customer Category"; Rec."Customer Category")
            {
                ApplicationArea = all;
            }
            field("Customer Status"; Rec."Customer Status")
            {
                ApplicationArea = all;
            }
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = all;
            }
            field("Virtual ID"; Rec."Virtual ID")
            {
                ApplicationArea = all;
            }
            field("CC Team"; Rec."CC Team")
            {
                ApplicationArea = all;
            }


        }
    }
    actions
    {
        addfirst(reporting)
        {
            action("Billing Exception Report")
            {
                ApplicationArea = All;
                Caption = 'Billing Exception Report';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CustRec: Record Customer;
                begin
                    CustRec.RESET;
                    CustRec.SETRANGE("No.", Rec."No.");
                    IF CustRec.FINDFIRST THEN
                        REPORT.RUN(50327, TRUE, FALSE, CustRec);
                end;

            }
        }
        addafter("F&unctions")
        {
            action("Validate SMS Detailed")
            {
                ApplicationArea = All;
                Caption = 'Validate SMS Detailed';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GLSetup: Record "General Ledger Setup";
                    RecCustomer: Record Customer;
                begin
                    GLSetup.GET;
                    GLSetup.TESTFIELD("SMS Updatation", TRUE);
                    RecCustomer.Reset();
                    RecCustomer.SetRange("No.", Rec."No.");
                    if RecCustomer.FindFirst() then
                        REPORT.RUNMODAL(50310, TRUE, TRUE, RecCustomer);

                end;
            }
            action("SMS Mobile No.")
            {
                ApplicationArea = All;
                Caption = 'SMS Mobile No.';
                Promoted = true;
                ShortcutKey = 'Ctrl+F10';

                trigger OnAction()
                var
                    recMobileNo: Record "SMS - Mobile No.";
                    frmMobileNo: Page "SMS - Mobile No.";
                begin
                    recMobileNo.RESET;
                    recMobileNo.SETRANGE("Link With", recMobileNo."Link With"::Customer);
                    recMobileNo.SETRANGE("Link Code", rec."No.");
                    frmMobileNo.SETTABLEVIEW(recMobileNo);
                    frmMobileNo.RUN;
                end;


            }

        }
        modify("TCS Allowed NOC")//15578
        {
            trigger OnAfterAction()
            var
                TCS: Record "Allowed NOC";
            begin
                // rec.TESTFIELD("GST Registration No.");
                //rec.GenerateNODNOCData;
            end;
        }
    }

    /*   trigger OnInsertRecord(BelowxRec: Boolean): Boolean
      var
          VirtualNoSeriesMgt: Codeunit NoSeriesManagement;
      begin
          Rec."Creation Date" := Today;
          Rec."Created By" := UserId;
          IF rec."Virtual ID" = '' THEN BEGIN
              rec."Virtual ID" := VirtualNoSeriesMgt.GetNextNo('VIRTUALID', 0D, TRUE);
          END;

      end;
   */
    trigger OnOpenPage()
    begin
        IF rec.Name <> '' THEN
            NameEditable := FALSE;


        //Upgrade(+)
        IF (LOWERCASE(USERID) = 'MA011') THEN BEGIN

            CustomerTypeEditable := TRUE;
            MapPointVisible := TRUE;
            ContactEditable := TRUE;
            SocialListeningSetupVisible := TRUE;
            SocialListeningVisible := TRUE;
            CRMIntegrationEnabled := TRUE;
            CRMIsCoupledToRecord := TRUE;
            OpenApprovalEntriesExistCurrUser := TRUE;
            OpenApprovalEntriesExist := TRUE;
            ShowWorkflowStatus := TRUE;

            NoEditable := TRUE;

            "Search NameEditable" := TRUE;
            "Name 2Editable" := TRUE;
            AddressEditable := TRUE;
            "Address 2Editable" := TRUE;
            CityEditable := TRUE;
            "Phone No.Editable" := TRUE;
            GlobalDimension1CodeEditable := TRUE;
            "Credit Limit (LCY)Editable" := TRUE;
            "Customer Posting GroupEditable" := TRUE;
            "Currency CodeEditable" := TRUE;
            "Customer Price GroupEditable" := TRUE;
            "Language CodeEditable" := TRUE;
            "Payment Terms CodeEditable" := TRUE;
            "Fin. Charge Terms CodeEditable" := TRUE;
            "Shipment Method CodeEditable" := TRUE;
            "Shipping Agent CodeEditable" := TRUE;
            "Invoice Disc. CodeEditable" := TRUE;
            "Customer Disc. GroupEditable" := TRUE;
            CountryRegionCodeEditable := TRUE;
            CommentEditable := TRUE;
            BlockedEditable := TRUE;
            InvoiceCopiesEditable := TRUE;
            LastStatementNoEditable := TRUE;
            PrintStatementsEditable := TRUE;
            BilltoCustomeNoEditable := TRUE;
            PaymentMethodCodeEditable := TRUE;
            LastDateModifiedEditable := TRUE;
            SalesLCYEditable := TRUE;
            TaxLiableEditable := TRUE;
            VATBusPostingGroupEditable := TRUE;
            ReserveEditable := TRUE;
            BlockPaymentToleranceEditable := TRUE;
            ShippingAdviceEditable := TRUE;
            ShippingTimeEditable := TRUE;
            ShippingAgentServiceCodeEditab := TRUE;
            AllowLineDiscEditable := TRUE;
            BaseCalendarCodeEditable := TRUE;
            TINNoEditable := TRUE;
            LSTNoEditable := TRUE;
            CSTNoEditable := TRUE;
            PANNoEditable := TRUE;
            ECCNoEditable := TRUE;
            RangeEditable := TRUE;
            CollectorateEditable := TRUE;
            ExciseBusPostingGroupEditable := TRUE;
            StateCodeEditable := TRUE;
            StructureEditable := TRUE;
            PANReferenceNoEditable := TRUE;
            PANStatusEditable := TRUE;
            CustomerTypeEditable := TRUE;
            SecurityAmountEditable := TRUE;
            SecurityDateEditable := TRUE;
            StateDescEditable := TRUE;
            FormCodeEditable := TRUE;
            PPDNoofDaysEditable := TRUE;
            PPDEditable := TRUE;
            PaymentTermsDaysEditable := TRUE;
            QuantityinCartonEditable := TRUE;
            ExFactoryAmountEditable := TRUE;
            ExciseAmountEditable := TRUE;
            SalesAmountEditable := TRUE;
            PayEditable := TRUE;
            PinCodeEditable := TRUE;
            CustCompanyTypeEditable := TRUE;
            SecurityChqAvailabilityEditabl := TRUE;
            BankAccountNoEditable := TRUE;
            CustLandlineNoEditable := TRUE;
            MobileNoEditable := TRUE;
            CocoCustomerEditable := TRUE;
            TINDateEditable := TRUE;
            PCHNameEditable := TRUE;
            PCHEMaillIDEditable := TRUE;
            CreationDateEditable := TRUE;
            PCHMobileNoEditable := TRUE;
            SalesPerMobEditable := TRUE;
            AreaCodeEditable := TRUE;
            LongitudeEditable := TRUE;
            LatitudeEditable := TRUE;
            ZoneEditable := TRUE;
            SecurityCheque1Editable := TRUE;
            SecurityCheque2Editable := TRUE;
            CTS1Editable := TRUE;
            CTS2Editable := TRUE;
            SecurityChecqueMaxLimit1Editab := TRUE;
            SecurityChecqueMaxLimit2Editab := TRUE;
            BankAccountNameEditable := TRUE;
            SecurityCheque1BankNameEditabl := TRUE;
            SecurityCheque2BankNameEditabl := TRUE;
            SecurityCheque1AcNoEditable := TRUE;
            SecurityCheque2AcNoEditable := TRUE;
            MinmumAmtpurvalueEditable := TRUE;
            DealerSchemeEditable := TRUE;
            AllowAutoDebitEditable := TRUE;
            OldTINEditable := TRUE;
            DealerFileNoEditable := TRUE;
            PostCodeEditable := TRUE;
            HomePageEditable := TRUE;
            EMailEditable := TRUE;
            FaxNoEditable := TRUE;
            GenBusPostingGroupEditable := TRUE;


        END
        ELSE
            CurrPage.EDITABLE(TRUE)
        //Upgrade(-)
    END;

    var
        NameEditable: Boolean;
        MapPointVisible: Boolean;
        ContactEditable: Boolean;
        SocialListeningSetupVisible: Boolean;
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

        NoEditable: Boolean;

        "Search NameEditable": Boolean;
        "Name 2Editable": Boolean;
        AddressEditable: Boolean;
        "Address 2Editable": Boolean;
        CityEditable: Boolean;
        "Phone No.Editable": Boolean;
        GlobalDimension1CodeEditable: Boolean;
        "Credit Limit (LCY)Editable": Boolean;
        "Customer Posting GroupEditable": Boolean;
        "Currency CodeEditable": Boolean;
        "Customer Price GroupEditable": Boolean;
        "Language CodeEditable": Boolean;
        "Payment Terms CodeEditable": Boolean;
        "Fin. Charge Terms CodeEditable": Boolean;
        "Shipment Method CodeEditable": Boolean;
        "Shipping Agent CodeEditable": Boolean;
        "Invoice Disc. CodeEditable": Boolean;
        "Customer Disc. GroupEditable": Boolean;
        CountryRegionCodeEditable: Boolean;
        CommentEditable: Boolean;
        BlockedEditable: Boolean;
        InvoiceCopiesEditable: Boolean;
        LastStatementNoEditable: Boolean;
        PrintStatementsEditable: Boolean;
        BilltoCustomeNoEditable: Boolean;
        PaymentMethodCodeEditable: Boolean;
        LastDateModifiedEditable: Boolean;
        SalesLCYEditable: Boolean;
        TaxLiableEditable: Boolean;
        VATBusPostingGroupEditable: Boolean;
        ReserveEditable: Boolean;
        BlockPaymentToleranceEditable: Boolean;
        ShippingAdviceEditable: Boolean;
        ShippingTimeEditable: Boolean;
        ShippingAgentServiceCodeEditab: Boolean;
        AllowLineDiscEditable: Boolean;
        BaseCalendarCodeEditable: Boolean;
        TINNoEditable: Boolean;
        LSTNoEditable: Boolean;
        CSTNoEditable: Boolean;
        PANNoEditable: Boolean;
        ECCNoEditable: Boolean;
        RangeEditable: Boolean;
        CollectorateEditable: Boolean;
        ExciseBusPostingGroupEditable: Boolean;
        StateCodeEditable: Boolean;
        StructureEditable: Boolean;
        PANReferenceNoEditable: Boolean;
        PANStatusEditable: Boolean;
        CustomerTypeEditable: Boolean;
        SecurityAmountEditable: Boolean;
        SecurityDateEditable: Boolean;
        StateDescEditable: Boolean;
        FormCodeEditable: Boolean;
        PPDNoofDaysEditable: Boolean;
        PPDEditable: Boolean;
        PaymentTermsDaysEditable: Boolean;
        QuantityinCartonEditable: Boolean;
        ExFactoryAmountEditable: Boolean;
        ExciseAmountEditable: Boolean;
        SalesAmountEditable: Boolean;
        PayEditable: Boolean;
        PinCodeEditable: Boolean;
        CustCompanyTypeEditable: Boolean;
        SecurityChqAvailabilityEditabl: Boolean;
        BankAccountNoEditable: Boolean;
        CustLandlineNoEditable: Boolean;
        MobileNoEditable: Boolean;
        CocoCustomerEditable: Boolean;
        TINDateEditable: Boolean;
        PCHNameEditable: Boolean;
        PCHEMaillIDEditable: Boolean;
        CreationDateEditable: Boolean;
        PCHMobileNoEditable: Boolean;
        SalesPerMobEditable: Boolean;
        AreaCodeEditable: Boolean;
        LongitudeEditable: Boolean;
        LatitudeEditable: Boolean;
        ZoneEditable: Boolean;
        SecurityCheque1Editable: Boolean;
        SecurityCheque2Editable: Boolean;
        CTS1Editable: Boolean;
        CTS2Editable: Boolean;
        SecurityChecqueMaxLimit1Editab: Boolean;
        SecurityChecqueMaxLimit2Editab: Boolean;
        BankAccountNameEditable: Boolean;
        SecurityCheque1BankNameEditabl: Boolean;
        SecurityCheque2BankNameEditabl: Boolean;
        SecurityCheque1AcNoEditable: Boolean;
        SecurityCheque2AcNoEditable: Boolean;
        MinmumAmtpurvalueEditable: Boolean;
        DealerSchemeEditable: Boolean;
        AllowAutoDebitEditable: Boolean;
        OldTINEditable: Boolean;
        DealerFileNoEditable: Boolean;
        PostCodeEditable: Boolean;
        HomePageEditable: Boolean;
        EMailEditable: Boolean;
        FaxNoEditable: Boolean;
        GenBusPostingGroupEditable: Boolean;


}