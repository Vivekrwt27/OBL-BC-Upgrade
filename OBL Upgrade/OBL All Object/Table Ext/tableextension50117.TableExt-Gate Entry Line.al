tableextension 50117 tableextension50117 extends "Gate Entry Line"
{
    fields
    {
        modify("Source Type")// 15578
        {
            trigger OnBeforeValidate()
            begin
                //UPGRADE(+)
                "Source Type" := "Source Type"::"Purchase Order";
                //UPGRADE(-)

            end;
        }
        modify("Source No.")
        {
            trigger OnAfterValidate()

            begin
                CASE "Source Type" OF

                    "Source Type"::"Purchase Return Shipment":
                        begin
                            //Upgrade(+)
                            ReturnShipHeader.GET(PurchLine."Document Type", "Source No.");
                            //upgrade(-)
                            "Source Name" := ReturnShipHeader."Pay-to Name";
                        END;
                end;
            end;


        }

        field(50000; "Order Qty"; Decimal)
        {
        }
        field(50001; "Gate Pass Qty"; Decimal)
        {
        }
        field(50002; "Item No"; Code[20])
        {
        }
        field(50003; "Item Description"; Text[40])
        {
        }
        field(50004; "Vendor No"; Code[20])
        {
        }
    }

    var
        GateEntryLine2: Record "Gate Entry Line";
        PurchLine: Record "Purchase Line";
        //  PurchLineList: Page 50057;
        LineNo1: Integer;
        ReturnShipHeader: Record "Return Shipment Header";
}

