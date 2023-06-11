pageextension 50011 pageextension50011 extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field("User Name"; rec."User Name")
            {
                Editable = true;
                ApplicationArea = All;
            }

        }

        addafter("Time Sheet Admin.")
        {
            field("ByPass Auto Posting Date"; rec."ByPass Auto Posting Date")
            {
                ApplicationArea = All;
            }
            field("Allow Generic SMS"; Rec."Allow Generic SMS")
            {
                ApplicationArea = all;
            }
            field("Purchase User"; rec."Purchase User")
            {
                ApplicationArea = All;
            }
            field("Sales User"; rec."Sales User")
            {
                ApplicationArea = All;
            }
            field("Allow Order Conf"; rec."Allow Order Conf")
            {
                ApplicationArea = All;
            }
            field("Finance User"; rec."Finance User")
            {
                ApplicationArea = All;
            }
            field("Prod. User"; rec."Prod. User")
            {
                ApplicationArea = All;
            }
            field("Warehouse User"; rec."Warehouse User")
            {
                ApplicationArea = All;
            }
            field("IC Posting"; rec."IC Posting")
            {
                ApplicationArea = All;
            }
            field("Allow Addtional Disc"; rec."Allow Addtional Disc")
            {
                ApplicationArea = All;
            }
            field("Approver ID"; rec."Approver ID")
            {
                ApplicationArea = All;
            }
            field("Unlimited Purchase Approval"; rec."Unlimited Purchase Approval")
            {
                ApplicationArea = All;
            }
            field(Substitute; rec.Substitute)
            {
                ApplicationArea = All;
            }
            field("E-Mail"; rec."E-Mail")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Purchase Amount Approval Limit"; rec."Purchase Amount Approval Limit")
            {
                ApplicationArea = All;
            }
            field("Allow UnLock"; rec."Allow UnLock")
            {
                ApplicationArea = All;
            }
            field("Allow PO Release"; rec."Allow PO Release")
            {
                ApplicationArea = All;
            }
            field("Allow PO Reopen"; rec."Allow PO Reopen")
            {
                ApplicationArea = All;
            }
            field("Allow Form"; rec."Allow Form")
            {
                ApplicationArea = All;
            }
            field("Allow BO Release"; rec."Allow BO Release")
            {
                ApplicationArea = All;
            }
            field("Allow BO Close"; rec."Allow BO Close")
            {
                ApplicationArea = All;
            }
            field("Allow BO Reopen"; rec."Allow BO Reopen")
            {
                ApplicationArea = All;
            }
            field("Allow SO Reopen"; rec."Allow SO Reopen")
            {
                ApplicationArea = All;
            }
            field("Allow SO Release"; rec."Allow SO Release")
            {
                ApplicationArea = All;
            }
            field("Allow TO Release"; rec."Allow TO Release")
            {
                ApplicationArea = All;
            }
            field("Item Authorization HSK 1"; Rec."Item Authorization HSK 1")
            {
                ApplicationArea = ALL;
            }
            field("Item Authorization 2"; Rec."Item Authorization 2")
            {
                ApplicationArea = ALL;
            }
            field("Item Authorization 3"; Rec."Item Authorization 3")
            {
                ApplicationArea = ALL;
            }
            field("Item Authorization 4"; Rec."Item Authorization 4")
            {
                ApplicationArea = ALL;
            }
            field("Item Authorization DRA 1"; Rec."Item Authorization DRA 1")
            {
                ApplicationArea = ALL;
            }
            field("Item Authorization SKD 1"; Rec."Item Authorization SKD 1")
            {
                ApplicationArea = ALL;
            }
            field("Miltiple Logins Allowed"; Rec."Miltiple Logins Allowed")
            {
                ApplicationArea = ALL;
            }
            field("No. of Sessions"; Rec."No. of Sessions")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 1"; Rec."Capex Authorization 1")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 2"; Rec."Capex Authorization 2")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 3"; Rec."Capex Authorization 3")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 4"; Rec."Capex Authorization 4")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 5"; Rec."Capex Authorization 5")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 6"; Rec."Capex Authorization 6")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 7"; Rec."Capex Authorization 7")
            {
                ApplicationArea = ALL;
            }
            field("Capex Authorization 8"; Rec."Capex Authorization 8")
            {
                ApplicationArea = ALL;
            }
            field("Request Capex Amount Limit"; Rec."Request Capex Amount Limit")
            {
                ApplicationArea = ALL;
            }
            field("Allow Bank account change"; Rec."Allow Bank account change")
            {
                ApplicationArea = ALL;
            }
            field("Allow Capex Modify"; Rec."Allow Capex Modify")
            {
                ApplicationArea = ALL;
            }
            field("Item Authorization WZ 1"; Rec."Item Authorization WZ 1")
            {
                ApplicationArea = ALL;
            }
            field("Item Creator"; Rec."Item Creator")
            {
                ApplicationArea = ALL;
            }
            field("BiPass Capex Approval Limit"; Rec."BiPass Capex Approval Limit")
            {
                ApplicationArea = ALL;
            }


            field("Authorization 1"; rec."Authorization 1")
            {
                ApplicationArea = All;
            }
            field("Make Order"; rec."Make Order")
            {
                ApplicationArea = All;
            }
            field("Authorization 2"; rec."Authorization 2")
            {
                ApplicationArea = All;
            }
            field("Authorization 3"; rec."Authorization 3")
            {
                ApplicationArea = All;
            }
            field(Location; rec.Location)
            {
                ApplicationArea = All;
            }
            field("Change Location"; rec."Change Location")
            {
                ApplicationArea = All;
            }
            field("Allow PO UnLock"; rec."Allow PO UnLock")
            {
                ApplicationArea = All;
            }
            field("Allow Comments Editable"; rec."Allow Comments Editable")
            {
                ApplicationArea = All;
            }
            field("CD User"; rec."CD User")
            {
                ApplicationArea = All;
            }
            field("Price Update"; rec."Price Update")
            {
                ApplicationArea = All;
            }
            field("Indent Limit"; Rec."Indent Limit")
            {
                ApplicationArea = ALL;
            }
            field(Plant; Rec.Plant)
            {
                ApplicationArea = ALL;
            }
            field(PIN; Rec.PIN)
            {
                ApplicationArea = ALL;
            }
            field(DOA; rec.DOA)
            {
                ApplicationArea = All;
            }
            field("Generate E-Way Bill"; rec."Generate E-Way Bill")
            {
                ApplicationArea = All;
            }
            field("Update E-Way Vechile No"; rec."Update E-Way Vechile No")
            {
                ApplicationArea = All;
            }
            field("Cancel E-Way Bill"; rec."Cancel E-Way Bill")
            {
                ApplicationArea = All;
            }
            field("Vendor Approver"; rec."Vendor Approver")
            {
                ApplicationArea = All;
            }
            field("Allow Delete Indent"; Rec."Allow Delete Indent")
            {
                ApplicationArea = all;
            }
            field("Allow Customer Card"; Rec."Allow Customer Card")
            {
                ApplicationArea = all;
            }
            field("Allow QTy.TO Ship"; Rec."Allow QTy.TO Ship")
            {
                ApplicationArea = all;
            }
        }
    }
}

