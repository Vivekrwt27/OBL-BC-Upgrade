report 50209 "Rejection Notice For Store"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\RejectionNoticeForStore.rdl';

    dataset
    {
        dataitem("Rejection Purchase Line"; 50043)
        {
            DataItemTableView = SORTING("Rejection No.", "Document Type", "Document No.", "Line No.");
            RequestFilterFields = "Rejection No.";
            column(add; add)
            {
            }
            column(StoreRejNo; "Store Rejection No.")
            {
            }
            column(VendNo; "Rejection Purchase Line"."Buy-from Vendor No.")
            {
            }
            column(vendname; vendname)
            {
            }
            column(vendaddress; vendaddress)
            {
            }
            column(CityPostCode; vandcity + '\' + vendpostcode)
            {
            }
            column(statedesc; statedesc)
            {
            }
            column(ShipmentNo; ShipmentNo)
            {
            }
            column(VendorInvoiceno; VendorInvoiceno)
            {
            }
            column(MRNNo; "MRN No.")
            {
            }
            column(Rdate; Rdate)
            {
            }
            column(Vdate; Vdate)
            {
            }
            column(vendorinvoiceDate; vendorinvoiceDate)
            {
            }
            column(MRNDate; "MRN Date")
            {
            }
            column(Sno; Sno)
            {
            }
            column(No; "No.")
            {
            }
            column(DesTotal; Description + ' ' + "Description 2")
            {
            }
            column(UOM; "Unit of Measure")
            {
            }
            column(ChalanQty; "Challan Quantity")
            {
            }
            column(ActQty; "Actual Quantity")
            {
            }
            column(ShortQty; "Shortage Quantity")
            {
            }
            column(RejQty; "Rejected Quantity")
            {
            }
            column(AccQty; "Accepted Quantity")
            {
            }
            column(ShortRejValue; ShortRejValue)
            {
            }
            column(RejectionReason; RejectionReason)
            {
            }
            column(ShortageReason; ShortageReason)
            {
            }
            column(RPL_RN; "Rejection Purchase Line"."Rejection No.")
            {
            }
            column(RejNo; "Rejection Purchase Line"."Rejection No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF ("Location Code" = 'SKD-STORE') OR ("Location Code" = 'SKD-PLANT') THEN
                    add := text0001
                ELSE
                    IF "Location Code" = 'HSK-PLANT' THEN
                        add := text0002
                    ELSE
                        IF "Location Code" = 'DRA-PLANT' THEN
                            add := text0003;


                IF NOT (("Rejection Purchase Line"."Shortage Quantity" > 0) OR ("Rejection Purchase Line"."Rejected Quantity" > 0)) THEN
                    CurrReport.SKIP;

                ReturnReason.RESET;
                IF ReturnReason.GET("Rejection Purchase Line"."Rejection Reason Code") THEN
                    RejectionReason := ReturnReason.Description;

                ReturnReason.RESET;
                IF ReturnReason.GET("Rejection Purchase Line"."Shortage Reason Code") THEN
                    ShortageReason := ReturnReason.Description;


                IF ("Rejection Purchase Line"."Shortage Quantity" > 0) OR ("Rejection Purchase Line"."Rejected Quantity" > 0) THEN BEGIN
                    // CurrReport.SHOWOUTPUT(TRUE);

                    //ValueEntry.RESET;

                    // ValueEntry.SETFILTER(ValueEntry."Item Ledger Entry No.",'%1',"Purch. Rcpt. Line"."Item Rcpt. Entry No.");
                    // IF ValueEntry.FIND('-') THEN
                    ShortRejValue := 0;
                    ShortRejValue := ("Rejection Purchase Line"."Unit Cost (LCY)") *
                    ("Rejection Purchase Line"."Shortage Quantity" + "Rejection Purchase Line"."Rejected Quantity");
                END;


                recstate.RESET;
                recstate.SETRANGE(recstate.Code, "State Code");
                IF recstate.FIND('-') THEN
                    statedesc := recstate.Description;
                IF vend.GET("Rejection Purchase Line"."Buy-from Vendor No.") THEN BEGIN
                    vendname := vend.Name;
                    vendaddress := vend.Address + '' + vend."Address 2";
                    vandcity := vend.City;
                    vendpostcode := vend."Post Code";
                END;
                IF rejectionpurchaseheader.GET("Rejection Purchase Line"."Rejection No.") THEN
                    VendorInvoiceno := rejectionpurchaseheader."Vendor Invoice No.";
                vendorinvoiceDate := rejectionpurchaseheader."Vendor Invoice Date";//Ori ut
                Vdate := rejectionpurchaseheader."Vendor Shipment Date";
                Rdate := rejectionpurchaseheader."Posting Date";
                ShipmentNo := rejectionpurchaseheader."Vendor Shipment No.";


                IF RejNo <> "Rejection Purchase Line"."Rejection No." THEN
                    Sno += 1;

                RejNo := "Rejection Purchase Line"."Rejection No.";
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(RejNo);
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

    trigger OnInitReport()
    begin
        //ERROR('You Cannot Execute the Report')
    end;

    var
        ReturnReason: Record 6635;
        vend: Record 23;
        ValueEntry: Record 5802;
        ILE: Record 32;
        ShortRejValue: Decimal;
        Sno: Integer;
        FilterString: Text[250];
        VendorInvoiceno: Text[30];
        RejectionReason: Text[250];
        ShortageReason: Text[250];
        rejectionpurchaseheader: Record 50042;
        Vdate: Date;
        ShipmentNo: Code[30];
        vendorinvoiceDate: Date;
        recstate: Record State;
        statedesc: Text[50];
        Rdate: Date;
        vendname: Text[100];
        vendaddress: Text[100];
        vandcity: Text[200];
        vendpostcode: Code[20];
        add: Text[150];
        RepAuditMgt: Codeunit 50028;
        text0001: Label '8,INDUSTRIAL AREA,SIKANDRABAD-203205,DISTT.BULANDSHAHR(UP)';
        text0002: Label 'Village Chokkahalli, Pillagumpe Industrial Area, Hoskote, Banglore (Karnataka) - 562114';
        text0003: Label 'Village Dora, Amod Taluk, Bruch';
        RejNo: Code[30];
}

