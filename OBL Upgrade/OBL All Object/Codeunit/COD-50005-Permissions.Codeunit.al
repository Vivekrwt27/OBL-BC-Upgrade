codeunit 50005 Permissions1
{

    trigger OnRun()
    begin
    end;


    procedure Type(var UserAccess: Integer; var Location: Code[10])
    var
        UserLocation: Record "User Location";
    begin
        UserLocation.RESET;
        IF UserLocation.GET(USERID, Location) THEN;
        //.............................................sALES---------------------------------------------------
        IF UserAccess = 0 THEN
            IF NOT UserLocation."Create Sales Quote" THEN
                ERROR('You Cannot Create/Update Sales Quote for %1 Location', Location);

        IF UserAccess = 1 THEN
            IF NOT UserLocation."Create Sales Order" THEN
                ERROR('You Cannot Create/Update Sales Order for %1 location', Location);

        IF UserAccess = 2 THEN
            IF NOT UserLocation."Create Sales Invoice" THEN
                ERROR('You Cannot Create/Update Sales Invoice for %1 Location', Location);

        IF UserAccess = 3 THEN
            IF NOT UserLocation."Create Sales Credit memo" THEN
                ERROR('You Cannot Create/Update Sales Credit Memo for %1 location', Location);

        IF UserAccess = 4 THEN
            IF NOT UserLocation."Create Sales Blanket Order" THEN
                ERROR('You Cannot Create/Update Sales Blanket Order for %1 Location', Location);

        IF UserAccess = 5 THEN
            IF NOT UserLocation."Create Sales Return order" THEN
                ERROR('You Cannot Create/Update Sales Return Order for %1 Location', Location);
        //..........................................iNVENTORY-------------------------------------------------
        IF UserAccess = 6 THEN
            IF NOT UserLocation."Transfer From" THEN
                ERROR('You Cannot Create/Update Transfer Order for %1 From Location', Location);

        IF UserAccess = 7 THEN
            IF NOT UserLocation."Transfer To" THEN
                ERROR('You Cannot Create/Update Transfer Order for %1 as To Location', Location);

        //...........................................pURCHASE--------------------------------------------------
        IF UserAccess = 8 THEN
            IF NOT UserLocation."Create Purchase Quote" THEN
                ERROR('You Cannot Create/Update Purchase Quote for %1 Location', Location);

        IF UserAccess = 9 THEN
            IF NOT UserLocation."Create Purchase Order" THEN
                ERROR('You Cannot Create/Update Purchase Order for %1 location', Location);

        IF UserAccess = 10 THEN
            IF NOT UserLocation."Create Purchase Invoice" THEN
                ERROR('You Cannot Create/Update Purchase Invoice for %1 Location', Location);

        IF UserAccess = 11 THEN
            IF NOT UserLocation."Create Purchase Credit memo" THEN
                ERROR('You Cannot Create/Update Purchase Credit Memo for %1 location', Location);

        IF UserAccess = 12 THEN
            IF NOT UserLocation."Create Purchase Blanket Order" THEN
                ERROR('You Cannot Create/Update Purchase Blanket Order for %1 Location', Location);

        IF UserAccess = 13 THEN
            IF NOT UserLocation."Create Purchase Return order" THEN
                ERROR('You Cannot Create/Update Purchase Return Order for %1 Location', Location);
        //....................................................fINANCE-----------------------------------
        IF UserAccess = 14 THEN
            IF NOT UserLocation."GJT General" THEN
                ERROR('You Cannot Create/Update General Journal for %1 Location', Location);

        IF UserAccess = 15 THEN
            IF NOT UserLocation."GJT Sales" THEN
                ERROR('You Cannot Create/Update Sales for %1 Location', Location);

        IF UserAccess = 16 THEN
            IF NOT UserLocation."GJT Purchases" THEN
                ERROR('You Cannot Create/Update Purchases for %1 Location', Location);

        IF UserAccess = 17 THEN
            IF NOT UserLocation."GJT Cash Receipts" THEN
                ERROR('You Cannot Create/Update Cash Receipts for %1 Location', Location);

        IF UserAccess = 18 THEN
            IF NOT UserLocation."GJT Payments" THEN
                ERROR('You Cannot Create/Update Payments for %1 Location', Location);

        IF UserAccess = 19 THEN
            IF NOT UserLocation."GJT Assets" THEN
                ERROR('You Cannot Create/Update Assets Journal for %1 location', Location);

        IF UserAccess = 20 THEN
            IF NOT UserLocation."GJT TDS Adjustments" THEN
                ERROR('You Cannot Create/Update TDS Adjustments for %1 Location', Location);

        IF UserAccess = 21 THEN
            IF NOT UserLocation."GJT LC" THEN
                ERROR('You Cannot Create/Update LC for %1 location', Location);

        IF UserAccess = 22 THEN
            IF NOT UserLocation."GJT Receipts" THEN
                ERROR('You Cannot Create/Update Receipts for %1 Location', Location);

        IF UserAccess = 23 THEN
            IF NOT UserLocation."GJT JV" THEN
                ERROR('You Cannot Create/Update JV for %1 location', Location);

        IF UserAccess = 24 THEN
            IF NOT UserLocation."GJT StdPayments" THEN
                ERROR('You Cannot Create/Update StdPayments for %1 Location', Location);

        //.................................................iNVENTORY------------------------------------

        IF UserAccess = 25 THEN
            IF NOT UserLocation."IJT Item" THEN
                ERROR('You Cannot Create/Update Item Journal for %1 Location', Location);

        IF UserAccess = 26 THEN
            IF NOT UserLocation."IJT Transfer" THEN
                ERROR('You Cannot Create/Update Transfer Journal for %1 Location', Location);

        IF UserAccess = 27 THEN
            IF NOT UserLocation."IJT Phys. Inventory" THEN
                ERROR('You Cannot Create/Update Phys. Inventory Journal for %1 Location', Location);

        IF UserAccess = 28 THEN
            IF NOT UserLocation."IJT Revaluation" THEN
                ERROR('You Cannot Create/Update Revaluation Journal for %1 Location', Location);

        IF UserAccess = 29 THEN
            IF NOT UserLocation."IJT Consumption" THEN
                ERROR('You Cannot Create/Update Consumption Journal for %1 location', Location);

        IF UserAccess = 30 THEN
            IF NOT UserLocation."IJT Output" THEN
                ERROR('You Cannot Create/Update Output Journal for %1 Location', Location);

        IF UserAccess = 31 THEN
            IF NOT UserLocation."IJT Capacity" THEN
                ERROR('You Cannot Create/Update Capacity Journal for %1 location', Location);

        //..................................................iNDENT---------------------------------------------
        IF UserAccess = 32 THEN
            IF NOT UserLocation."Create Indent" THEN
                ERROR('You Cannot Create/Update Indent for %1 location', Location);
        //...................................................RGP-----------------------------------------------
        IF UserAccess = 33 THEN
            IF NOT UserLocation."RGP IN" THEN
                ERROR('You Cannot Create/Update RGP IN for %1 location', Location);

        IF UserAccess = 34 THEN
            IF NOT UserLocation."RGP OUT" THEN
                ERROR('You Cannot Create/Update RGP OUT for %1 location', Location);

        //...................................................eXPORT iMPORT----------------------------------------------
        /*
        IF UserAccess = 35 THEN
          IF NOT UserLocation."Create Export Order" THEN
            ERROR('You Cannot Create/Update Export Order for %1 location',Location);
        
        IF UserAccess = 36 THEN
          IF NOT UserLocation."Create Import Order" THEN
            ERROR('You Cannot Create/Update Import Order for %1 location',Location);
          //Kulbhushan
          */

    end;
}

