page 50117 "Customer Group"
{
    AutoSplitKey = true;
    DataCaptionFields = "No.";
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Customer Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Type"; Rec."Group Type")
                {
                    Editable = "Group TypeEditable";
                    ApplicationArea = All;
                }
                field(All; Rec.All)
                {
                    Editable = AllEditable;
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    Editable = CodeEditable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(FormStates);
                        CLEAR(CustomerVendorList);
                        CLEAR(FormCustList);
                        CASE Rec."Group Type" OF
                            Rec."Group Type"::State:
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    CustGroup.RESET;
                                    CustGroup.SETRANGE("Group Type", Rec."Group Type"::State);
                                    CustGroup.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    CustGroup.SETRANGE(All, TRUE);
                                    IF CustGroup.FINDFIRST THEN
                                        //ERROR(Text50001,CustGroup."No.");
                                        CLEAR(FormStates);
                                    FormStates.SETTABLEVIEW(State);
                                    IF FormStates.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        FormStates.GETRECORD(State);
                                        Rec.Code := State.Code;
                                        Rec.Description := State.Description;
                                    END;
                                END;
                            Rec."Group Type"::"Customer Type":
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    CustGroup.RESET;
                                    CustGroup.SETRANGE("Group Type", Rec."Group Type"::"Customer Type");
                                    CustGroup.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    CustGroup.SETRANGE(All, TRUE);
                                    IF CustGroup.FINDFIRST THEN
                                        //ERROR(Text50002,CustGroup."No.");
                                        SalesSetup.GET;
                                    CustomerType.RESET;
                                    CustomerType.SETRANGE(CustomerType.Type, CustomerType.Type::Customer);
                                    IF CustomerType.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionValues);
                                        CustomerVendorList.SETTABLEVIEW(CustomerType);
                                        IF CustomerVendorList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            CustomerVendorList.GETRECORD(CustomerType);
                                            Rec.Code := CustomerType.Code;
                                            Rec.Description := CustomerType.Description;
                                        END;
                                    END;
                                END;
                            Rec."Group Type"::Customer:
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    CustGroup.RESET;
                                    CustGroup.SETRANGE("Group Type", Rec."Group Type"::Customer);
                                    CustGroup.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    CustGroup.SETRANGE(All, TRUE);
                                    IF CustGroup.FINDFIRST THEN
                                        //ERROR(Text50003,CustGroup."No.");
                                        CLEAR(FormCustList);
                                    FormCustList.SETTABLEVIEW(Customer);
                                    IF FormCustList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        FormCustList.GETRECORD(Customer);
                                        Rec.Code := Customer."No.";
                                        Rec.Description := Customer.Name;
                                        Rec."State Name" := Customer."State Desc.";
                                    END;
                                END;
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = DescriptionEditable;
                    ApplicationArea = All;
                }
                field("State Name"; Rec."State Name")
                {
                    Editable = "State NameEditable";
                    ApplicationArea = All;
                }
                field("Include/Exclude"; Rec."Include/Exclude")
                {
                    Editable = "Include/ExcludeEditable";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DiscountHeader.RESET;
        DiscountHeader.SETRANGE("No.", Rec."No.");
        IF DiscountHeader.FIND('-') THEN BEGIN
            Rec.Status := DiscountHeader.Status;
        END;

        IF Rec.Status = Rec.Status::Enable THEN BEGIN
            "Group TypeEditable" := FALSE;
            CodeEditable := FALSE;
            "Include/ExcludeEditable" := FALSE;
            AllEditable := FALSE;
            DescriptionEditable := FALSE;
            //CurrForm."Valid From".EDITABLE(FALSE);
            //CurrForm."Valid To".EDITABLE(FALSE);
            //CurrForm.Status.EDITABLE(FALSE);
            "State NameEditable" := FALSE;

        END
        ELSE BEGIN
            "Group TypeEditable" := TRUE;
            CodeEditable := TRUE;
            "Include/ExcludeEditable" := TRUE;
            AllEditable := TRUE;
            DescriptionEditable := TRUE;
            //CurrForm."Valid From".EDITABLE(TRUE);
            //CurrForm."Valid To".EDITABLE(TRUE);
            //CurrForm.Status.EDITABLE(TRUE);
            "State NameEditable" := TRUE;


        END;
    end;

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        "State NameEditable" := TRUE;
        DescriptionEditable := TRUE;
        AllEditable := TRUE;
        "Include/ExcludeEditable" := TRUE;
        CodeEditable := TRUE;
        "Group TypeEditable" := TRUE;
    end;

    var
        State: Record State;
        DimensionValue: Record "Dimension Value";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        Text50001: Label 'All States are defined for Discount No. %1.';
        CustGroup: Record "Customer Group";
        Text50002: Label 'All Customer Type are defined for Discount No. %1.';
        Text50003: Label 'All Customers are defined for Discount No. %1.';
        DiscountHeader: Record "Discount Header";
        Status: Option " ",Enable,Disable;
        CustomerType: Record "Customer Type";
        [InDataSet]
        "Group TypeEditable": Boolean;
        [InDataSet]
        CodeEditable: Boolean;
        [InDataSet]
        "Include/ExcludeEditable": Boolean;
        [InDataSet]
        AllEditable: Boolean;
        [InDataSet]
        DescriptionEditable: Boolean;
        [InDataSet]
        "State NameEditable": Boolean;
        FormStates: Page States;
        CustomerVendorList: Page "Customer/Vendor Type List";
        FormCustList: Page "Customer List";
        FormDimensionValues: Page "Dimension Values";
}

