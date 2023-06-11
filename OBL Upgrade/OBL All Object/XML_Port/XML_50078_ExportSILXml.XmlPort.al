xmlport 50078 "Export SIL Xml"
{
    Direction = Both;
    Format = VariableText;
    DefaultFieldsValidation = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Invoice Line"; "Sales Invoice Line")
            {
                XmlName = 'SalesInvLineXML';
                AutoUpdate = true;
                fieldelement(Field1; "Sales Invoice Line"."Document No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field2; "Sales Invoice Line"."Line No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field3; "Sales Invoice Line"."Quantity in Cartons")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field4; "Sales Invoice Line"."Type Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field5; "Sales Invoice Line"."Plant Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field6; "Sales Invoice Line"."Size Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field7; "Sales Invoice Line"."Posting Date1")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field8; "Sales Invoice Line".Schemes)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field9; "Sales Invoice Line"."Color Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field10; "Sales Invoice Line"."Design Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field11; "Sales Invoice Line"."Packing Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field12; "Sales Invoice Line"."Quality Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field13; "Sales Invoice Line"."Salesperson Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field14; "Sales Invoice Line"."Quantity in Sq. Mt.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field15; "Sales Invoice Line"."Main Location")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field16; "Sales Invoice Line"."Buyer's Price")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field17; "Sales Invoice Line"."Discount Per Unit")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field18; "Sales Invoice Line"."Related Location code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field19; "Sales Invoice Line"."Unit Price (FCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field20; "Sales Invoice Line"."Amount (FCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field21; "Sales Invoice Line"."Carton No. From")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field22; "Sales Invoice Line"."Carton No. To")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field23; "Sales Invoice Line"."Pallet No. From")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field24; "Sales Invoice Line"."Pallet No. To")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field25; "Sales Invoice Line"."Total Pallets")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field26; "Sales Invoice Line"."Total Cartons")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field27; "Sales Invoice Line".OK)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field28; "Sales Invoice Line"."Group Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field29; "Sales Invoice Line"."Type Catogery Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field30; "Sales Invoice Line".COCO)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field31; "Sales Invoice Line"."Sales Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field32; "Sales Invoice Line"."AD Remarks")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field33; "Sales Invoice Line"."Order No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field34; "Sales Invoice Line".Remarks)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field35; "Sales Invoice Line"."Offer Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field36; "Sales Invoice Line".Slab)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field37; "Sales Invoice Line"."Quantity Discount %")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field38; "Sales Invoice Line"."Quantity Discount Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field39; "Sales Invoice Line"."Accrued Quantity")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field40; "Sales Invoice Line"."Calculate Line Discount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field41; "Sales Invoice Line"."Accrued Discount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field42; "Sales Invoice Line".Month)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field43; "Sales Invoice Line"."Structure Calculated")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field44; "Sales Invoice Line"."Scheme Group Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field45; "Sales Invoice Line"."V. Cost")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field46; "Sales Invoice Line".D1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field47; "Sales Invoice Line".D2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field48; "Sales Invoice Line".D3)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field49; "Sales Invoice Line".D4)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field50; "Sales Invoice Line".S1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field51; "Sales Invoice Line"."Discount Amt 1")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field52; "Sales Invoice Line"."Discount Amt 2")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field53; "Sales Invoice Line"."Discount Amt 3")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field54; "Sales Invoice Line"."Discount Amt 4")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field55; "Sales Invoice Line"."System Discount Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field56; "Sales Invoice Line".D6)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field57; "Sales Invoice Line"."Discount Amt 6")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field58; "Sales Invoice Line".D7)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field59; "Sales Invoice Line"."Discount Amt 7")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field60; "Sales Invoice Line"."RG No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field61; "Sales Invoice Line"."Approval Required")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Field62; "Sales Invoice Line"."TCS Base Amount")
                {
                    MinOccurs = Zero;
                }
            }
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
}

