report 50097 "Transfer Order confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TransferOrderconfirmation.rdl';
    PreviewMode = Normal;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Transfer Header"; 5740)
        {
            column(Locat_T_From_GSTNo; Location1."GST Registration No.")
            {
            }
            column(Trans_From_state; Trans_From_state)
            {
            }
            column(ExDocNo; "Transfer Header"."External Document No.")
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(TransfertoName_TransferHeader; "Transfer Header"."Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferHeader; "Transfer Header"."Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferHeader; "Transfer Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferHeader; "Transfer Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferHeader; "Transfer Header"."Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferHeader; "Transfer Header"."Transfer-to City")
            {
            }
            column(TransportersName_TransferHeader; "Transfer Header"."Transporter Name")
            {
            }
            column(GRNo_TransferHeader; "Transfer Header"."GR No.")
            {
            }
            column(GRDate_TransferHeader; "Transfer Header"."GR Date")
            {
            }
            column(TruckNo_TransferHeader; "Transfer Header"."Truck No.")
            {
            }
            column(ShipmentDate_TransferHeader; FORMAT("Transfer Header"."Shipment Date"))
            {
            }
            column(No_TransferHeader; "Transfer Header"."No.")
            {
            }
            column(CST; CST)
            {
            }
            dataitem("Transfer Line"; 5741)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Derived From Line No." = CONST(0));
                column(CRate; CRate)
                {
                }
                column(CAmount; CAmount)
                {
                }
                column(SRate; SRate)
                {
                }
                column(SAmount; SAmount)
                {
                }
                column(IRate; IRate)
                {
                }
                column(IAmount; IAmount)
                {
                }
                column(URate; URate)
                {
                }
                column(UAmount; UAmount)
                {
                }
                column(ItemNo_TransferLine; "Transfer Line"."Item No.")
                {
                }
                column(Quantity_TransferLine; "Transfer Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferLine; "Transfer Line"."Unit of Measure")
                {
                }
                column(Description_TransferLine; "Transfer Line".Description)
                {
                }
                column(Description2_TransferLine; "Transfer Line"."Description 2")
                {
                }
                column(UnitPrice_TransferLine; "Transfer Line"."Unit Price")
                {
                }
                column(UnitofMeasureCode_TransferLine; "Transfer Line"."Unit of Measure Code")
                {
                }
                column(ExciseAmount_TransferLine; 0) // 16630 blank "Transfer Line"."Excise Amount"
                {
                }
                column(ExciseEffectiveRate_TransferLine; 0) // 16630 blank "Transfer Line"."Excise Effective Rate"
                {
                }
                column(MRP; 0) // 16630 blank "Transfer Line"."MRP Price"
                {
                }
                column(unitpricepers; unitpricepers)
                {
                }
                column(Cart; Cart)
                {
                }
                column(SqMt; SqMt)
                {
                }
                column(Wt; Wt / 1000)
                {
                }
                column(SubTotal; SubTotal)
                {
                }
                column(Amount_StructureOrderLineDetails; 0)//16630 "Structure Order Line Details".Amount
                {
                }
                column(TaxChargeType; 0)//16630 "Structure Order Line Details"."Tax/Charge Type"
                {
                }
                column(Taxtotal; Taxtotal)
                {
                }
                column(NoText1; NoText[1])
                {
                }
                column(NoText2; NoText[2])
                {
                }


                trigger OnAfterGetRecord()
                var
                    BaseUOM: Record "Item Unit of Measure";
                    AmtinWrd: Decimal;
                begin
                    //RKS GST START
                    CRate := 0;
                    SRate := 0;
                    IRate := 0;
                    CAmount := 0;
                    SAmount := 0;
                    IAmount := 0;
                    URate := 0;
                    UAmount := 0;

                    DetailedGSTEntryBuffer.RESET;
                    DetailedGSTEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                    //DetailedGSTEntryBuffer.SETRANGE("Transaction Type",DetailedGSTEntryBuffer."Transaction Type"::Sales);
                    //DetailedGSTEntryBuffer.SETRANGE("Document Type","Transfer Line"."Document Type");
                    DetailedGSTEntryBuffer.SETRANGE("Document No.", "Transfer Line"."Document No.");
                    DetailedGSTEntryBuffer.SETRANGE("No.", "Transfer Line"."Item No.");
                    DetailedGSTEntryBuffer.SETRANGE("Line No.", "Transfer Line"."Line No.");

                    IF DetailedGSTEntryBuffer.FINDFIRST THEN
                        REPEAT
                            IF DetailedGSTEntryBuffer."GST Component Code" = 'CGST' THEN BEGIN
                                CRate := DetailedGSTEntryBuffer."GST %";
                                CAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                // CAmount1+=CAmount;
                            END;

                            IF DetailedGSTEntryBuffer."GST Component Code" = 'SGST' THEN BEGIN
                                SRate := DetailedGSTEntryBuffer."GST %";
                                SAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                //SAmount1+=SAmount
                            END;

                            IF DetailedGSTEntryBuffer."GST Component Code" = 'IGST' THEN BEGIN
                                IRate := DetailedGSTEntryBuffer."GST %";
                                IAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                //IAmount1+=IAmount;
                            END;

                            IF DetailedGSTEntryBuffer."GST Component Code" = 'UGST' THEN BEGIN
                                URate := DetailedGSTEntryBuffer."GST %";
                                UAmount := ABS(DetailedGSTEntryBuffer."GST Amount");
                                //IAmount1+=IAmount;
                            END;

                        UNTIL
DetailedGSTEntryBuffer.NEXT = 0;




                    SubTotal := 0;
                    Cart := 0;
                    SqMt := 0;
                    Wt := 0;
                    Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                    SqMt := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                    //Wt := Item.UomToWeight("Item No.","Unit of Measure Code",Quantity);
                    Wt := "Transfer Line"."Gross Weight";
                    /*
                    IF "Quantity in Cartons" <> 0 THEN
                      RateperCart := "Unit Price"*Quantity/"Quantity in Cartons";
                    
                    IF "Quantity in Cartons" <> 0 THEN
                      DiscPerCart := "Line Discount Amount"/"Quantity in Cartons";
                    Value :="Quantity in Cartons"*(RateperCart-DiscPerCart);
                    */
                    IF BaseUOM.GET("Item No.", "Unit of Measure Code") THEN
                        IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                            unitpricepers := "Unit Price" / BaseUOM."Qty. per Unit of Measure"; //6700



                    SubTotal := "Transfer Line".Quantity * "Transfer Line"."Unit Price";
                    SubTotal1 += "Transfer Line".Quantity * "Transfer Line"."Unit Price";


                    //AmtinWrd := ,1,'>');
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(NoText, ROUND(SubTotal1 + StrAmt), '');

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(SubTotal, Cart, SqMt, Wt);
                end;
            }
            /* 16630  dataitem(DataItem1000000002; 13795)
              {
                  DataItemLink = "Document No." = FIELD("No.");
                  DataItemTableView = SORTING("Tax/Charge Type")
                                      ORDER(Ascending)
                                      WHERE(Type = CONST('Transfer'));
                  column(Amount_StructureOrderLineDetails; "Structure Order Line Details".Amount)
                  {
                  }
                  column(TaxChargeType; "Structure Order Line Details"."Tax/Charge Type")
                  {
                  }
                  column(Taxtotal; Taxtotal)
                  {
                  }
                  column(NoText1; NoText[1])
                  {
                  }
                  column(NoText2; NoText[2])
                  {
                  }

                  trigger OnAfterGetRecord()
                  begin
                      Taxtotal := Amount;
                      Taxtotal1 += Amount;
                  end;
              }*/ // 16630
            dataitem("Inventory Comment Line"; 5748)
            {
                DataItemLink = "No." = FIELD("No.");
                column(Comment; "Inventory Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyName1 := CompanyInfo.Name;
                Taxtotal := 0;

                Location1.RESET;
                IF Location1.GET("Transfer Header"."Transfer-from Code") THEN BEGIN
                    RecState.RESET;
                    IF RecState.GET(Location1."State Code") THEN
                        Trans_From_state := RecState."State Code (GST Reg. No.)";
                END;




                /*  Location.RESET;
                  IF Location.GET("Transfer-to Code") THEN BEGIN
                      CST := Location."C.S.T. No."
                  END
                  ELSE
                      CST := '';
                  CLEAR(StrAmt);
                  StructureOrderLineDetails.RESET;
                  StructureOrderLineDetails.SETRANGE("Document No.", "Transfer Header"."No.");
                  StructureOrderLineDetails.SETFILTER(Type, 'Transfer');
                  IF StructureOrderLineDetails.FINDFIRST THEN BEGIN
                      REPEAT
                          StrAmt += StructureOrderLineDetails.Amount;
                      UNTIL StructureOrderLineDetails.NEXT = 0;
                  END;*/ // 16630
            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50097)
    end;

    var
        Trans_From_state: Text[100];
        RecState: Record State;
        Location1: Record Location;
        DetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        URate: Decimal;
        UAmount: Decimal;
        Customer: Record Customer;
        RateperCart: Decimal;
        DiscPerCart: Decimal;
        Item: Record Item;
        Value: Decimal;
        SubTotal: Decimal;
        SubTotal1: Decimal;
        Taxtotal: Decimal;
        Taxtotal1: Decimal;
        Netamt: Decimal;
        Location: Record Location;
        Address: Text[250];
        Ph: Text[100];
        Fax: Text[100];
        OurTIN: Code[50];
        CheckReport: Report "Check Report";
        NoText: array[2] of Text[80];
        CST: Code[20];
        Cart: Decimal;
        SqMt: Decimal;
        Wt: Decimal;
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        // 16630 StructureOrderLineDetails: Record 13795;
        StrAmt: Decimal;
        unitpricepers: Decimal;
}

