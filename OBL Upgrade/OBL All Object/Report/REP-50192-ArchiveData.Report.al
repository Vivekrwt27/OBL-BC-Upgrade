report 50192 "Archive Data"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ArchiveData.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(Data; ArchiveData.Date_Archived)
            {
            }
            column(Doc_type; ArchiveData.Document_Type)
            {
            }
            column(status; ArchiveData.Status)
            {
            }
            column(Sell_cust; ArchiveData.Sell_to_Customer_No)
            {
            }
            column(Release_date; FORMAT(ArchiveData.Release_Date))
            {
            }
            column(Release_Time; FORMAT(ArchiveData.Release_Time))
            {
            }
            column(Archdate; FORMAT(ArchiveData.Arch_Date))
            {
            }
            column(archtime; FORMAT(ArchiveData.Arch_Time))
            {
            }
            column(docno; ArchiveData.Document_No)
            {
            }
            column(lineno; ArchiveData.Line_No)
            {
            }
            column(type_ty; ArchiveData.Type)
            {
            }
            column(no; ArchiveData.No)
            {
            }
            column(location; ArchiveData.Location_Code)
            {
            }
            column(pricegroup; ArchiveData.Price_Group_Code)
            {
            }
            column(postinggroup; ArchiveData.Posting_Group)
            {
            }
            column(desc; ArchiveData.Description)
            {
            }
            column(desc2; ArchiveData.Description_2)
            {
            }
            column(qty_per_uom; ArchiveData.Qty_per_Unit_of_Measure)
            {
            }
            column(UOM; ArchiveData.Unit_of_Measure)
            {
            }
            column(Qty_crt; ArchiveData.Quantity_in_Cartons)
            {
            }
            column(qty_base; ArchiveData.Quantity_Base)
            {
            }
            column(qty_shpd; ArchiveData.Quantity_Shipped)
            {
            }
            column(ship_base; ArchiveData.Qty_Shipped_Base)
            {
            }
            column(qty_inv; ArchiveData.Quantity_Invoiced)
            {
            }
            column(qtybase; ArchiveData.Qty_Invoiced_Base)
            {
            }
            column(out_qty; ArchiveData.Outstanding_Quantity)
            {
            }
            column(out_qty_base; ArchiveData.Outstanding_Qty_Base)
            {
            }
            column(amount; ArchiveData.Line_Amount)
            {
            }
            //16225   column(amttocusty; ArchiveData.Amount_To_Customer)
            column(amttocusty; Totalamt)
            {
            }
            column(outsamt; ArchiveData.Outstanding_Amount)
            {
            }
            column(prod_posting_grp; ArchiveData.Gen_Prod_Posting_Group)
            {
            }
            column(mrp; ArchiveData.MRP_Price)
            {
            }
            column(byer_price; ArchiveData.Buyer_s_Price)
            {
            }
            column(itc; ArchiveData.Item_Category_Code)
            {
            }
            column(completlyshipped; ArchiveData.Completely_Shipped)
            {
            }
            column(agent; ArchiveData.Shipping_Agent_Code)
            {
            }
            //16225 column(doctype; ArchiveData.Source_Document_Type)
            column(doctype; ArchiveData.Document_Type)
            {
            }
            column(type; ArchiveData.Type_Code)
            {
            }
            column(plant; ArchiveData.Plant_Code)
            {
            }
            column(size; ArchiveData.Size_Code)
            {
            }
            column(qualty; ArchiveData.Quality_Code)
            {
            }
            column(grossweight; ArchiveData.Gross_Weight)
            {
            }
            column(netwieht; ArchiveData.Net_Weight)
            {
            }
            column(reasoncode; rname)
            {
            }
            column(State_code; stname)
            {
            }
            column(Cust_type; ArchiveData.Customer_Type)
            {
            }
            column(Arch_by; ArchiveData.Archived_By)
            {
            }
            column(Name; ArchiveData.Sell_to_Customer_Name)
            {
            }
            column(Customer_city; ArchiveData.Sell_to_City)
            {
            }
            column(Order_booked; ArchiveData.Order_Booked_Date)
            {
            }
            column(Salesterretory; Salesterretory)
            {
            }
            column(Tableauzone; Tableauzone)
            {
            }
            column(tableauproduct; tableauproduct)
            {
            }
            column(itemclass; itemclass)
            {
            }
            column(Despatch_Remarks; ArchiveData.Despatch_Remarks)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //InitialiseVariables;

                IF NOT ArchiveData.READ THEN
                    CurrReport.BREAK;

                IF recstate.GET(ArchiveData.State) THEN
                    stname := recstate.Description;

                rname := '';
                IF recreason.GET(ArchiveData.Reason_Code) THEN
                    rname := recreason.Description;

                IF Customer1.GET(ArchiveData.Sell_to_Customer_No) THEN
                    Salesterretory := Customer1."Area Code";
                Tableauzone := Customer1."Tableau Zone";

                IF Item1.GET(ArchiveData.No) THEN
                    tableauproduct := Item1."Tableau Product Group";
                itemclass := Item1."Item Classification";
                Totalamt := CalcAmttoVendor.GetAmttoCustomerPostedLine(ArchiveData.Document_No, ArchiveData.Line_No);

            end;



            trigger OnPreDataItem()
            begin
                //IF GblStartDate THEN
                ArchiveData.SETFILTER(ArchiveData.Arch_Date, '%1..%2|%3..%4', GblStartDate, GBLEndDate, GblStartDate, GBLEndDate);
                ArchiveData.OPEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; GblStartDate)
                {
                    ApplicationArea = All;
                }
                field(EndDate; GBLEndDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ArchiveData: Query "Sales Line Archive";
        GblStartDate: Date;
        GBLEndDate: Date;
        recstate: Record State;
        stname: Text[50];
        recreason: Record "Reason Code";
        rname: Text[50];
        Customer1: Record Customer;
        Salesterretory: Text[20];
        Tableauzone: Text[20];
        tableauproduct: Text[20];
        itemclass: Text[12];
        Item1: Record Item;
        Totalamt: Decimal;
        CalcAmttoVendor: Codeunit CalcAmttoVendor;

    procedure SetParameters(StartDate: Date; EndDate: Date)
    begin
        GblStartDate := StartDate;
        GBLEndDate := EndDate;
    end;
}

