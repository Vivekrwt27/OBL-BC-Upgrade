page 50116 "Discount Line"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Discount Line";

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
                        CLEAR(FormDimensionValues);
                        CLEAR(ItemGroup2);
                        CLEAR(FormItemList);
                        CASE Rec."Group Type" OF
                            Rec."Group Type"::"Item Type":
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    DiscountLine.RESET;
                                    DiscountLine.SETRANGE("Group Type", Rec."Group Type"::"Item Type");
                                    DiscountLine.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    DiscountLine.SETRANGE(All, TRUE);
                                    IF DiscountLine.FINDFIRST THEN
                                        // ERROR(Text50001,DiscountLine."Document No.");
                                        SalesSetup.GET;
                                    //SalesSetup.TESTFIELD("ItemType Dimension Code");
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", 'TYPE');
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionValues);
                                        FormDimensionValues.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionValues.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionValues.GETRECORD(DimensionValue);
                                            Rec.Code := DimensionValue.Code;
                                            Rec.Description := DimensionValue.Name;
                                        END;
                                    END;
                                END;
                            Rec."Group Type"::Size:
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    DiscountLine.RESET;
                                    DiscountLine.SETRANGE("Group Type", Rec."Group Type"::Size);
                                    DiscountLine.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    DiscountLine.SETRANGE(All, TRUE);
                                    IF DiscountLine.FINDFIRST THEN
                                        // ERROR(Text50002,DiscountLine."Document No.");
                                        SalesSetup.GET;
                                    //SalesSetup.TESTFIELD("Size Dimension Code");
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", 'SIZE');
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionValues);
                                        FormDimensionValues.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionValues.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionValues.GETRECORD(DimensionValue);
                                            Rec.VALIDATE(Code, DimensionValue.Code);
                                            Rec.Description := DimensionValue.Name;
                                        END;
                                    END;
                                END;
                            Rec."Group Type"::"Tile Group":
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    DiscountLine.RESET;
                                    DiscountLine.SETRANGE("Group Type", Rec."Group Type"::"Tile Group");
                                    DiscountLine.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    DiscountLine.SETRANGE(All, TRUE);
                                    IF DiscountLine.FINDFIRST THEN
                                        // ERROR(Text50003,DiscountLine."Document No.");

                                        SalesSetup.GET;
                                    //SalesSetup.TESTFIELD("Tile Group Dimension Code");
                                    DimensionValue.RESET;
                                    DimensionValue.SETRANGE("Dimension Code", 'CATG');
                                    IF DimensionValue.FINDFIRST THEN BEGIN
                                        CLEAR(FormDimensionValues);
                                        FormDimensionValues.SETTABLEVIEW(DimensionValue);
                                        IF FormDimensionValues.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            FormDimensionValues.GETRECORD(DimensionValue);
                                            Rec.VALIDATE(Code, DimensionValue.Code);
                                            Rec.Description := DimensionValue.Name;
                                        END;
                                    END;

                                    /*
                                    ItemGroup.RESET;
                                    //ItemGroup.SETRANGE(ItemGroup."Group Code",SalesSetup."Tile Group Dimension Code");
                                    IF ItemGroup.FINDFIRST THEN BEGIN
                                      CLEAR(ItemGroup2);
                                      ItemGroup2.SETTABLEVIEW(ItemGroup);
                                      IF ItemGroup2.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        ItemGroup2.GETRECORD(ItemGroup);
                                        VALIDATE(Code,ItemGroup."Group Code");
                                        Description :=ItemGroup.Name;
                                      END;
                                    END;
                                    */
                                END;
                            Rec."Group Type"::Item:
                                BEGIN
                                    Rec.TESTFIELD(All, FALSE);
                                    DiscountLine.RESET;
                                    DiscountLine.SETRANGE("Group Type", Rec."Group Type"::Item);
                                    DiscountLine.SETRANGE("Include/Exclude", Rec."Include/Exclude"::Include);
                                    DiscountLine.SETRANGE(All, TRUE);
                                    IF DiscountLine.FINDFIRST THEN
                                        //ERROR(Text50004,DiscountLine."Document No.");
                                        CLEAR(FormItemList);
                                    FormItemList.SETTABLEVIEW(Item);
                                    IF FormItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        FormItemList.GETRECORD(Item);
                                        Rec.Code := Item."No.";
                                        Rec.Description := Item.Description;
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
                field(Description2; Rec.Description2)
                {
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
        DiscountHeader.SETRANGE(DiscountHeader."No.", Rec."Document No.");
        IF DiscountHeader.FIND('-') THEN BEGIN
            Rec.Status := DiscountHeader.Status;
        END;

        IF Rec.Status = Rec.Status::Enable THEN BEGIN
            "Group TypeEditable" := FALSE;
            AllEditable := FALSE;
            CodeEditable := FALSE;
            DescriptionEditable := FALSE;
            "Include/ExcludeEditable" := FALSE;
            //CurrForm."Valid From".EDITABLE(FALSE);
            //CurrForm."Valid To".EDITABLE(FALSE);
            //CurrForm.Status.EDITABLE(FALSE);

        END
        ELSE BEGIN
            "Group TypeEditable" := TRUE;
            AllEditable := TRUE;
            CodeEditable := TRUE;
            DescriptionEditable := TRUE;
            "Include/ExcludeEditable" := TRUE;
            // CurrForm."Valid From".EDITABLE(TRUE);
            // CurrForm."Valid To".EDITABLE(TRUE);
            //CurrForm.Status.EDITABLE(TRUE);

        END;
    end;

    trigger OnInit()
    begin
        "Include/ExcludeEditable" := TRUE;
        CodeEditable := TRUE;
        AllEditable := TRUE;
        "Group TypeEditable" := TRUE;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        DimensionValue: Record "Dimension Value";
        Item: Record Item;
        DiscountLine: Record "Discount Line";
        Text50001: Label 'All Item Type are defined for Discount No. %1.';
        Text50002: Label 'All Size are defined for Discount No. %1.';
        Text50003: Label 'All Tile Group are defined for Discount No. %1.';
        Text50004: Label 'All Item are defined for Discount No. %1.';
        ItemGroup: Record "Item Group";
        DiscountHeader: Record "Discount Header";
        Status: Option " ",Enable,Disable;
        [InDataSet]
        "Group TypeEditable": Boolean;
        [InDataSet]
        AllEditable: Boolean;
        [InDataSet]
        CodeEditable: Boolean;
        [InDataSet]
        DescriptionEditable: Boolean;
        [InDataSet]
        "Include/ExcludeEditable": Boolean;
        FormDimensionValues: Page "Dimension Values";
        ItemGroup2: Page "Item Group 2";
        FormItemList: Page "Item List";

}

