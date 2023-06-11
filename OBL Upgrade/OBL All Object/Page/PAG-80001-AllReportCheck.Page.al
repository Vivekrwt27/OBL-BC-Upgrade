page 80001 "All Report Check"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 36;

    layout
    {
        /*  area(Content)
         {
             group(GroupName)
             {
                 field(Name; NameSource)
                 {
                     ApplicationArea = All;

                 }
             }
         } */
    }

    actions
    {
        area(Processing)
        {
            action(Report)
            {
                ApplicationArea = All;
                Caption = 'Indent Summary/Pending Indents';
                RunObject = report 50003;
            }
            action(Report1)
            {
                ApplicationArea = All;
                Caption = 'Customer Application';
                RunObject = report 50008;
            }
            action(Report2)
            {
                ApplicationArea = All;
                Caption = 'GST Sales Invoice Mod 2';
                RunObject = report 50012;
            }
            action(Report3)
            {
                ApplicationArea = All;
                Caption = 'Sales Journal';
                RunObject = report 50015;
            }
            action(Report4)
            {
                ApplicationArea = All;
                Caption = 'Import from Excel';
                RunObject = report 50016;
            }
            action(Report5)
            {
                ApplicationArea = All;
                Caption = 'Purchase V/S Dispatch Report';
                RunObject = report 50017;
            }
            action(Report6)
            {
                ApplicationArea = All;
                Caption = 'Generate MRN To Purch. Invo';
                RunObject = report 50018;
            }
            action(Report7)
            {
                ApplicationArea = All;
                Caption = 'Warehouse Summary';
                RunObject = report 50022;
            }
            action(Report8)
            {
                ApplicationArea = All;
                Caption = 'Update Matrix Master';
                RunObject = report 50031;
            }
            action(Report9)
            {
                ApplicationArea = All;
                Caption = 'Sales Data (Sales Journal)';
                RunObject = report 50036;
            }
            action(Report10)
            {
                ApplicationArea = All;
                Caption = 'Factory Gate Pass GR No. Wise';
                RunObject = report 50039;
            }
            action(Report11)
            {
                ApplicationArea = All;
                Caption = 'Purchase Indent Report';
                RunObject = report 50041;
            }
            action(Report12)
            {
                ApplicationArea = All;
                Caption = 'Factory Gate Pass';
                RunObject = report 50043;
            }
            action(Report13)
            {
                ApplicationArea = All;
                Caption = 'Generate Purchase Invoices';
                RunObject = report 50048;
            }
            action(Report14)
            {
                ApplicationArea = All;
                Caption = 'Target Vs Achie HSK DRA';
                RunObject = report 50052;
            }
            action(Report15)
            {
                ApplicationArea = All;
                Caption = 'Avg Coll Pd_Base';
                RunObject = report 50053;
            }
            action(Report16)
            {
                ApplicationArea = All;
                Caption = 'Sales GST Data Report';
                RunObject = report 50061;
            }
            action(Report17)
            {
                ApplicationArea = All;
                Caption = 'Indent Status Report (TAT)';
                RunObject = report 50063;
            }
            action(Report18)
            {
                ApplicationArea = All;
                Caption = 'Distribution Exansion';
                RunObject = report 50071;
            }
            action(Report19)
            {
                ApplicationArea = All;
                Caption = 'Sales Data (Sales Journal New)';
                RunObject = report 50080;
            }
            action(Report20)
            {
                ApplicationArea = All;
                Caption = 'Date Wise Invoice Wise Sales';
                RunObject = report 50092;
            }
            action(Report21)
            {
                ApplicationArea = All;
                Caption = 'Sales Person Goal Sheet ZH/ZM';
                RunObject = report 50098;
            }
            action(Report22)
            {
                ApplicationArea = All;
                Caption = 'Sales Person Goal Sheet SP';
                RunObject = report 50155;
            }
            action(Report23)
            {
                ApplicationArea = All;
                Caption = 'Sales Order Status Report';
                RunObject = report 50171;
            }
            action(Report24)
            {
                ApplicationArea = All;
                Caption = 'GST Sales Invoice Export Nepal';
                RunObject = report 50198;
            }
            action(Report25)
            {
                ApplicationArea = All;
                Caption = 'GSTR-1 Sales Data Export';
                RunObject = report 50219;
            }
            action(Report26)
            {
                ApplicationArea = All;
                Caption = 'Sales Journal Report';
                RunObject = report 50249;
            }
            action(Report27)
            {
                ApplicationArea = All;
                Caption = 'Loss of Sales Report New1';
                RunObject = report 50290;
            }
            action(Report28)
            {
                ApplicationArea = All;
                Caption = 'Sales Person Goal Sheet BH';
                RunObject = report 50313;
            }
            action(Report29)
            {
                ApplicationArea = All;
                Caption = 'De-Reserve Sales Order';
                RunObject = report 50336;
            }
            action(Report30)
            {
                ApplicationArea = All;
                Caption = 'Sales Journa(lDepot)';
                RunObject = report 50354;
            }
            action(Report31)
            {
                ApplicationArea = All;
                Caption = 'State Cust. Wise SalesJournal';
                RunObject = report 50355;
            }
            action(Report32)
            {
                ApplicationArea = All;
                Caption = 'New State Cust. Wise Sales Cr.';
                RunObject = report 50363;
            }
            action(Report33)
            {
                ApplicationArea = All;
                Caption = 'Issue Slip';
                RunObject = report 50372;
            }
            action(Report34)
            {
                ApplicationArea = All;
                Caption = 'Credit Billing Exception2';
                RunObject = report 50380;
            }
            action(Report35)
            {
                ApplicationArea = All;
                Caption = 'CD Summary';
                RunObject = report 50382;
            }
            action(Report36)
            {
                ApplicationArea = All;
                Caption = 'Sales Line Details';
                RunObject = report 50394;
            }
            action(Report37)
            {
                ApplicationArea = All;
                Caption = 'Sales Dashboard';
                RunObject = report 50395;
            }
            action(Report38)
            {
                ApplicationArea = All;
                Caption = 'c-FORM';
                RunObject = report 50399;
            }
            action(Report39)
            {
                ApplicationArea = All;
                Caption = 'Purchase - Receipt';
                RunObject = report 50708;
            }
            action(Report40)
            {
                ApplicationArea = All;
                Caption = 'Posted Voucher';
                RunObject = report 18041;
            }



        }
    }

    var
        myInt: Integer;
}