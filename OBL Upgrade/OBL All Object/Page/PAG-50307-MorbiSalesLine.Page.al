page 50307 "Morbi Sales Line"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      WHERE("Document Type" = CONST(Order),
                            "Item Category Code" = CONST('M001|D001|T001|H001'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec."Status Hdr")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //CurrPage.SAVERECORD;
                        GetMorbiInventory;
                        //CurrPage.UPDATE(FALSE);
                        COMMIT;
                        vendname := '';
                        Vendor.SETFILTER("Morbi Location Code", '%1&<>%2', Rec."Vendor Code", '');
                        IF Vendor.FINDFIRST THEN
                            vendname := Vendor.Name;
                    end;
                }
                field("Vendor Name"; vendname)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Morbi Inv. In CRT"; MorbiInventoryCRT)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Current Line Morbi REserve"; CurrSLReserveQty)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Morbi Inventory"; MorbiInventory)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tot Morbi Reserve Stock"; MorbiReserveStock)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invd. (Base)"; Rec."Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225 Field N/F
                /* field("Amount To Customer"; "Amount To Customer")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Charges To Customer"; "Charges To Customer")
                 {
                     ApplicationArea = All;
                 }
                 field("MRP Price"; "MRP Price")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
                field("GST Place of Supply"; Rec."GST Place of Supply")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                }
                //16225 Field N/F
                /*field("GST Base Amount"; "GST Base Amount")
                {
                    ApplicationArea = All;
                }
                field("GST %"; "GST %")
                {
                    ApplicationArea = All;
                }
                field("Total GST Amount"; "Total GST Amount")
                {
                    ApplicationArea = All;
                }*/
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                /*field("Sales Amount"; "Sales Amount")
                {
                    ApplicationArea = All;
                }*/
                field("Quantity in Cartons"; Rec."Quantity in Cartons")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt."; Rec."Quantity in Sq. Mt.")
                {
                    ApplicationArea = All;
                }
                field("Buyer's Price"; Rec."Buyer's Price")
                {
                    ApplicationArea = All;
                }
                field("Discount Per Unit"; Rec."Discount Per Unit")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; Rec."Type Catogery Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                }
                field("Remaining Inventory"; Rec."Remaining Inventory")
                {
                    ApplicationArea = All;
                }
                field("Total Reserved Quantity"; Rec."Total Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt.(Ship)"; Rec."Quantity in Sq. Mt.(Ship)")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Cartons(Ship)"; Rec."Quantity in Cartons(Ship)")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Hand SQM"; Rec."Quantity in Hand SQM")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Blanket Order"; Rec."Quantity in Blanket Order")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight (Ship)"; Rec."Gross Weight (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Net Weight (Ship)"; Rec."Net Weight (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Discount Per SQ.MT"; Rec."Discount Per SQ.MT")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity in Hand CRT"; Rec."Quantity in Hand CRT")
                {
                    ApplicationArea = All;
                }
                field("Order Qty (CRT)"; Rec."Order Qty (CRT)")
                {
                    ApplicationArea = All;
                }
                field("AD Remarks"; Rec."AD Remarks")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipped Gross Weight"; Rec."Shipped Gross Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Gross Weight"; Rec."Outstanding Gross Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance Surcharge Amount"; Rec."Balance Surcharge Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remarks 1"; Rec.Remarks)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Releasing Date"; Rec."Releasing Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*  field("State Name"; rec."State Name")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 */
                field(D1; Rec.D1)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(D2; Rec.D2)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(D3; Rec.D3)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(D4; Rec.D4)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(S1; Rec.S1)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Discount Amt 1"; Rec."Discount Amt 1")
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 2"; Rec."Discount Amt 2")
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 3"; Rec."Discount Amt 3")
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 4"; Rec."Discount Amt 4")
                {
                    ApplicationArea = All;
                }
                field("System Discount Amount"; Rec."System Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Price Excl. VAT/Sq.Mt"; Rec."Unit Price Excl. VAT/Sq.Mt")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buyer's Price /Sq.Mt"; Rec."Buyer's Price /Sq.Mt")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(D6; Rec.D6)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Discount Amt 6"; Rec."Discount Amt 6")
                {
                    ApplicationArea = All;
                }
                field(D7; Rec.D7)
                {
                    ApplicationArea = All;
                }
                field("Discount Amt 7"; Rec."Discount Amt 7")
                {
                    ApplicationArea = All;
                }
                field("Approval Required"; Rec."Approval Required")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remarks 2"; Rec.Batch)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Morbi Remarks"; Rec."Itemr Change Remarks")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF reas1.GET(Rec."Itemr Change Remarks") THEN
                            Rec."Itemr Change Remarks" := reas1.Description;
                    end;
                }
                field("Outstanding Weight"; outgrossweight * Rec."Outstanding Qty. (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ASP; Rec.S1 + Rec.D6 + Rec."Buyer's Price /Sq.Mt")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; DocumentDt)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Type"; custtype)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Despatch Remarks"; Despatchremarks)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason To Hold"; Reasontohold)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Process Date"; orderprocessdt)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Size Description"; sizedesc)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(sp_name; sp_name)
                {
                    Caption = 'sp_name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship To City"; shiptocity)
                {
                    Caption = 'Ship To City';
                    ApplicationArea = All;
                }
                field(Pay; pay)
                {
                    Caption = 'Pay';
                    OptionCaption = 'To Pay, To Be Billed';
                    ApplicationArea = All;
                }
                field(Zone; Zone)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Orddate)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reserve Inventory ")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(AssociateVendorMgt);
                    IF CONFIRM('Are you Sure to Reserve the Inventory at Vendor Location') THEN BEGIN
                        GetMorbiInventory;
                        IF CurrSLReserveQty <> 0 THEN ERROR('Already Reserved Stock');
                        IF Rec.Quantity > MorbiInventory THEN ERROR('Insufficient Inventory to Reserve');
                        AssociateVendorMgt.ReserveInventoryVoucher(Rec);
                    END;
                end;
            }
            action("UnReserve Inventory")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(AssociateVendorMgt);
                    IF CONFIRM('Are you Sure to Delete the Reserve the Inventory at Vendor Location') THEN BEGIN
                        GetMorbiInventory;
                        AssociateVendorMgt.DeleteReservation(Rec);
                    END;
                end;
            }
            action("Show Location Wise Stock")
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TransportMethod: Record "Transport Method";
                begin
                    Rec.ShowMorbiInventory(TRUE);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetMorbiInventory;
        vendname := '';
        Vendor.SETFILTER("Morbi Location Code", '%1&<>%2', Rec."Vendor Code", '');
        IF Vendor.FINDFIRST THEN
            vendname := Vendor.Name;

        /*IF USERID = 'MA009' THEN BEGIN
           SETFILTER("Document Type", 'Blanket Order');
          // SETFILTER("Document Type", '<>%1','Credit Memo');
         END;
         */
        Despatchremarks := '';
        Reasontohold := '';
        Ordeval := Rec."Buyer's Price /Sq.Mt" * Rec."Quantity (Base)";
        Invval := Rec."Buyer's Price /Sq.Mt" * Rec."Qty. Invoiced (Base)";
        outval := Rec."Buyer's Price /Sq.Mt" * Rec."Outstanding Qty. (Base)";

        IF saleshead.GET(Rec."Document Type", Rec."Document No.") THEN
            shiptocity := saleshead."Ship-to City";
        pay := saleshead.Pay;
        orccode := saleshead."Dealer Code";
        orcterm := saleshead."ORC Terms";
        PONo := saleshead."PO No.";
        Despatchremarks := saleshead."Despatch Remarks";
        Reasontohold := saleshead.Commitment;
        // makeorderdate := saleshead."Make Order Date";

        IF saleshead.GET(Rec."Document Type", Rec."Document No.") THEN
            makeorderdate := saleshead."Make Order Date";
        DocumentDt := saleshead."Document Date";
        orderprocessdt := saleshead."Payment Date 3";



        //MSAK
        /*
        IF spname.GET("Salesperson Code") THEN
           sp_name := spname.Name;
        */
        RecCust.RESET;
        IF RecCust.GET(Rec."Sell-to Customer No.") THEN
            sp_name := RecCust."Salesperson Description";
        //Custype := Custype::RecCust."Customer Type";
        //MSAK

        IF Rec.Type = Rec.Type::Item THEN
            IF RecItem.GET(Rec."No.") THEN
                manufstrategy := RecItem."Manuf. Strategy";

        //
        CLEAR(SentTime);
        CLEAR(PACTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                    PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;

        CLEAR(Count1);
        CLEAR(PCHTime);
        CLEAR(ZMTime);
        CLEAR(PSMTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                Count1 += 1;
                IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;
        //MSAK

        IF item1.GET(Rec."No.") THEN
            tableautype := item1."Tableau Product Group";
        pchname := RecCust."PCH Name";
        sizedesc := item1."Size Code Desc.";
        outgrossweight := item1."Gross Weight";

        IF Rec.Type = Rec.Type::Item THEN BEGIN
            hvpnon.SETFILTER("Item No.", '%1', Rec."No.");
            hvpnon.SETFILTER("Starting Date", '%1..', 20180104D);//040118D//16225
            IF hvpnon.FINDLAST THEN
                hvp := hvpnon."HVP/Discontinued";
        END;

        IF RecCust.GET(Rec."Sell-to Customer No.") THEN;
        custtype := RecCust."Customer Type";

    end;

    trigger OnAfterGetRecord()
    begin
        GetMorbiInventory;
        vendname := '';
        Vendor.SETFILTER("Morbi Location Code", '%1&<>%2', Rec."Vendor Code", '');
        IF Vendor.FINDFIRST THEN
            vendname := Vendor.Name;

        GetMorbiInventory;
        vendname := '';
        Vendor.SETFILTER("Morbi Location Code", '%1&<>%2', Rec."Vendor Code", '');
        IF Vendor.FINDFIRST THEN
            vendname := Vendor.Name;

        /*IF USERID = 'MA009' THEN BEGIN
           SETFILTER("Document Type", 'Blanket Order');
          // SETFILTER("Document Type", '<>%1','Credit Memo');
         END;
         */
        Despatchremarks := '';
        Reasontohold := '';
        Ordeval := Rec."Buyer's Price /Sq.Mt" * Rec."Quantity (Base)";
        Invval := Rec."Buyer's Price /Sq.Mt" * Rec."Qty. Invoiced (Base)";
        outval := Rec."Buyer's Price /Sq.Mt" * Rec."Outstanding Qty. (Base)";

        IF saleshead.GET(Rec."Document Type", Rec."Document No.") THEN
            shiptocity := saleshead."Ship-to City";
        pay := saleshead.Pay;
        orccode := saleshead."Dealer Code";
        orcterm := saleshead."ORC Terms";
        PONo := saleshead."PO No.";
        Despatchremarks := saleshead."Despatch Remarks";
        Reasontohold := saleshead.Commitment;
        Orddate := saleshead."Order Date";
        // makeorderdate := saleshead."Make Order Date";

        IF saleshead.GET(Rec."Document Type", Rec."Document No.") THEN
            makeorderdate := saleshead."Make Order Date";
        DocumentDt := saleshead."Document Date";
        orderprocessdt := saleshead."Payment Date 3";



        //MSAK
        /*
        IF spname.GET("Salesperson Code") THEN
           sp_name := spname.Name;
        */
        RecCust.RESET;
        IF RecCust.GET(Rec."Sell-to Customer No.") THEN
            sp_name := RecCust."Salesperson Description";
        Zone := RecCust."Tableau Zone";
        //Custype := Custype::RecCust."Customer Type";
        //MSAK

        IF Rec.Type = Rec.Type::Item THEN
            IF RecItem.GET(Rec."No.") THEN
                manufstrategy := RecItem."Manuf. Strategy";

        //
        CLEAR(SentTime);
        CLEAR(PACTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                    PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;

        CLEAR(Count1);
        CLEAR(PCHTime);
        CLEAR(ZMTime);
        CLEAR(PSMTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."Document No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                Count1 += 1;
                IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;
        //MSAK

        IF item1.GET(Rec."No.") THEN
            tableautype := item1."Tableau Product Group";
        pchname := RecCust."PCH Name";
        sizedesc := item1."Size Code Desc.";
        outgrossweight := item1."Gross Weight";

        IF Rec.Type = Rec.Type::Item THEN BEGIN
            hvpnon.SETFILTER("Item No.", '%1', Rec."No.");
            hvpnon.SETFILTER("Starting Date", '%1..', 20180104D);//040118D//16225
            IF hvpnon.FINDLAST THEN
                hvp := hvpnon."HVP/Discontinued";
        END;

        IF RecCust.GET(Rec."Sell-to Customer No.") THEN;
        custtype := RecCust."Customer Type";

    end;

    trigger OnOpenPage()
    begin
        //IF (UPPERCASE(USERID) <> 'DE002') AND (UPPERCASE(USERID) <> 'MA006') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
        //   ERROR('You are not authorized to run this page');
        ///   LookupMorbiVendorCode(FALSE);
    end;

    var
        MorbiInventory: Decimal;
        saleshead: Record "Sales Header";
        makeorderdate: DateTime;
        shiptocity: Text[50];
        pay: Option;
        pay1: Option;
        spname: Record "Salesperson/Purchaser";
        sp_name: Text[50];
        manufstrategy: Option;
        RecItem: Record Item;
        ArchiveApprovalEntryREC: Record "Archive Approval Entry";
        SentTime: DateTime;
        PACTime: DateTime;
        Count1: Integer;
        PCHTime: DateTime;
        ZMTime: DateTime;
        PSMTime: DateTime;
        RecCust: Record Customer;
        hvp: Boolean;
        hvpnon: Record "HVP/Discontinued Items";
        item1: Record Item;
        tableautype: Text[20];
        custtype: Text[20];
        pchname: Text[35];
        Ordeval: Decimal;
        Invval: Decimal;
        outval: Decimal;
        orccode: Code[10];
        orcterm: Text[50];
        PONo: Text[20];
        DocumentDt: Date;
        Custype: Option;
        Despatchremarks: Text[50];
        Reasontohold: Text[50];
        orderprocessdt: Date;
        sizedesc: Text[10];
        outgrossweight: Decimal;
        reas1: Record "Reason Code";
        Vendor: Record Vendor;
        vendname: Text[100];
        Zone: Text[30];
        AssociateVendorMgt: Codeunit "Associate Vendor Mgt";
        MorbiReserveStock: Decimal;
        CurrSLReserveQty: Decimal;
        MorbiInventoryCRT: Decimal;
        Orddate: Date;

    local procedure GetMorbiInventory()
    begin
        MorbiInventory := 0;
        MorbiInventory := Rec.GetAssociateVendorInventory(Rec."No.", Rec."Vendor Code");
        MorbiInventoryCRT := 0;
        MorbiInventoryCRT := CalculateCarton(Rec."No.", '', MorbiInventory);

        MorbiReserveStock := 0;
        MorbiReserveStock := Rec.GetAssociateVendorReserveInventory(Rec."No.", Rec."Vendor Code");
        CurrSLReserveQty := 0;
        CurrSLReserveQty := Rec.GetMorbiReservedForSalesLine(Rec);
    end;

    procedure CalculateCarton(ItemNo: Code[20]; UOM: Code[10]; Qty: Decimal) CartonQty: Decimal
    var
        Item: Record Item;
    begin
        Item.GET(ItemNo);
        EXIT(Item.UomToCart(ItemNo, 'SQ.MT', Qty));
    end;
}

