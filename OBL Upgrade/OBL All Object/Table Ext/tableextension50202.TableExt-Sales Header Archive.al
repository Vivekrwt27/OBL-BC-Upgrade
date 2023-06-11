tableextension 50202 tableextension50202 extends "Sales Header Archive"
{
    fields
    {
        field(50000; Deleted; Boolean)
        {
            Description = 'Used for Tracking of ArchieveManagement For Deleted Sales Order';
        }
        field(50001; "New Status"; Option)
        {
            OptionCaption = ',Short Close,Cancel,Close';
            OptionMembers = ,"Short Close",Cancel,Close;
        }
        field(50002; "Locked Order"; Boolean)
        {
            Description = 'Customization No. 5.3';
        }
        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Customization No. 22';
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; "Clubbed With SO"; Code[20])
        {
            Description = 'Customization No. 5.3.3';
        }
        field(50012; "Transporter's Name"; Code[20])
        {
            Description = 'Customization No. 25';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));
        }
        field(50013; "GR No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50014; "Truck No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Customization No. 25';
        }
        field(50018; "GR Date"; Date)
        {
            Description = 'Customization No. 25';
        }
        field(50020; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50021; "Foreign Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50022; "Indian Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50023; "Entry No."; Integer)
        {
            Description = 'Report 18 Letter';
        }
        field(50024; "Entry Date"; Date)
        {
            Description = 'Report 18 Letter';
        }
        field(50025; "Main Location"; Code[10])
        {
        }
        field(50026; "Shipment Status"; Text[50])
        {
            Description = 'Report 102 EXIM';
        }
        field(50030; "State Desc."; Text[30])
        {
        }
        field(50031; "Salesperson Description"; Text[50])
        {
        }
        field(50033; "Transporter Name"; Text[30])
        {
            Editable = false;
        }
        field(50037; "FOB Value"; Decimal)
        {
            Description = 'ND';
        }
        field(50038; "Ocean Freight"; Decimal)
        {
            Description = 'ND';
        }
        field(50039; "No. of Containers"; Integer)
        {
            Description = 'ND';
        }
        field(50040; "Payment Terms"; Text[40])
        {
            Description = 'ND';
        }
        field(50041; "LC Number"; Code[20])
        {
            Description = 'ND';
        }
        field(50042; "Currency Code 1"; Code[50])
        {
            Description = 'ND';
            TableRelation = Currency;
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
        }
        field(50045; "Quote No."; Code[20])
        {
        }
        field(50046; "Quote Date"; Date)
        {
        }
        field(50047; "Releasing Date"; Date)
        {
        }
        field(50048; "Releasing Time"; Time)
        {
        }
        field(50049; "SB No."; Code[15])
        {
        }
        field(50050; "SB Date"; Date)
        {
        }
        field(50051; ICD; Text[15])
        {
        }
        field(50052; "Export To"; Text[15])
        {
        }
        field(50053; "OTS No."; Code[15])
        {
        }
        field(50054; "Container No."; Code[15])
        {
        }
        field(50055; "Abatement Required"; Boolean)
        {
            Description = 'rakesh for sales tax calculation';
        }
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            OptionMembers = " Project","Project Sale",Dealer;
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';
        }
        field(50062; "Group Code Check"; Boolean)
        {
        }
        field(50070; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            OptionMembers = "To Pay"," To Be Billed";
        }
        field(50072; "Sales Order No."; Code[20])
        {
            Description = 'TRI DP 140309';
        }
        field(50073; "Archive Version"; Integer)
        {
            CalcFormula = Count("Sales Header Archive" WHERE("Document Type" = FIELD("Document Type"),
                                                              "No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50074; "Blanket Order No."; Code[20])
        {
            Editable = false;
        }
        field(50075; "Date of Release"; Date)
        {
            Editable = false;
        }
        field(50076; "Time of Release"; Time)
        {
            Editable = false;
        }
        field(50077; "Releaser ID"; Code[20])
        {
            Editable = false;
        }
        field(50078; "Opener ID"; Code[10])
        {
            Editable = false;
        }
        field(50079; "Date of Reopen"; Date)
        {
            Editable = false;
        }
        field(50080; "Time of Reopen"; Time)
        {
            Editable = false;
        }
        field(50081; "Sales Order No"; Code[20])
        {
            Description = 'TRI DP';
        }
        field(50082; "Discount Charges %"; Decimal)
        {
        }
        field(50083; "Canceller ID"; Code[20])
        {
        }
        field(50084; "Cancellation Time"; Time)
        {
        }
        field(50085; "Quantity sq.mt"; Decimal)
        {
            CalcFormula = Sum("Sales Line Archive"."Quantity in Sq. Mt." WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50086; Quantity; Decimal)
        {
            CalcFormula = Sum("Sales Line Archive".Quantity WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50087; "Qty Invoiced"; Decimal)
        {
            CalcFormula = Sum("Sales Line Archive"."Quantity Invoiced" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50088; "Qty Outstanding"; Decimal)
        {
            CalcFormula = Sum("Sales Line Archive"."Outstanding Quantity" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50131; "Order Booked Date"; DateTime)
        {
        }
        field(50134; "Despatch Remarks"; Text[30])
        {
            TableRelation = "Reason Code" WHERE("Despatch Remarks" = CONST(true));
        }
        field(50135; Commitment; Text[40])
        {
            TableRelation = "Reason Code" WHERE("SO Hold Reason" = CONST(true));
        }
        field(50139; "Payment Date 3"; Date)
        {
        }
        field(50150; "Tonnage of Vehicle placed"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50151; "Driver Phone No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50152; "Driver Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50153; "Estimated Date of Arrival"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50154; "Transport Punch Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60033; "Contribution Percentage"; Decimal)
        {
            InitValue = 100;
        }
        field(60034; CKA; Boolean)
        {
        }
        field(60035; "CKA Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60036; Retail; Boolean)
        {
        }
        field(60037; "Retail Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60080; "Transfer No."; Code[20])
        {
            Description = 'MSVRN 13012020';
        }
        field(60082; "Order Change Remarks"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Order Change Remarks';
            TableRelation = "Reason Code" WHERE("Item Change Remarks" = CONST(true));
        }
        field(60092; "Direct Not Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60093; "InventoryNot Directly Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60094; "Credit Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60095; "Inventory Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60096; "Price Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Document Type,Sell-to Customer No."(Key)".

        key(Key4; "Document Type", "Sell-to Customer No.", "No.")
        {
        }
        key(Key5;/* State,*/ "Sell-to City", "Price Group Code", "Sell-to Customer No.")
        {
        }
    }


}

