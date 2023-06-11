tableextension 50265 tableextension50265 extends "User Setup"
{
    fields
    {
        field(50000; "Change Location"; Boolean)
        {
            Description = 'Customization No. 64';
        }
        field(50001; "Authorization 1"; Code[20])
        {
            Description = 'Customization No. 1 ND';
            TableRelation = "User Setup"."User ID";
        }
        field(50002; "Authorization 2"; Code[20])
        {
            Description = 'Customization No. 1 ND';
            TableRelation = "User Setup"."User ID";
        }
        field(50003; "Allow UnLock"; Boolean)
        {
        }
        field(50004; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(50005; "Allow Generic SMS"; Boolean)
        {
        }
        field(50006; "Make Order"; Boolean)
        {
        }
        field(50007; "Allow Form"; Boolean)
        {
        }
        field(50008; "Allow BO Reopen"; Boolean)
        {
        }
        field(50009; "Allow BO Release"; Boolean)
        {
        }
        field(50010; "Allow SO Reopen"; Boolean)
        {
        }
        field(50011; "Allow SO Release"; Boolean)
        {
        }
        field(50012; "Allow BO Close"; Boolean)
        {
        }
        field(50013; "Allow PO Reopen"; Boolean)
        {
        }
        field(50014; "Allow PO Release"; Boolean)
        {
        }
        field(50015; "Allow PO UnLock"; Boolean)
        {
            Description = 'TRI DG 241109';
        }
        field(50016; "Allow Delete Indent"; Boolean)
        {
        }
        field(50017; "Allow Customer Card"; Boolean)
        {
            Description = 'Ori Ut';
        }
        field(50018; "Verify Excise on PO"; Boolean)
        {
            Description = 'TSPL SA';
        }
        field(50019; "Allow QTy.TO Ship"; Boolean)
        {
            Description = 'Ori UT';
        }
        field(50020; "Authorization 3"; Code[20])
        {
            Description = 'MS-PB';
            TableRelation = "User Setup"."User ID";
        }
        field(50021; "IC Posting"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50022; "Allow Comments Editable"; Boolean)
        {
            Description = 'MSBS.Rao';
        }
        field(50023; "Allow Addtional Disc"; Boolean)
        {
        }
        field(50024; "ByPass Auto Posting Date"; Boolean)
        {
        }
        field(50025; "Purchase User"; Boolean)
        {
        }
        field(50026; "Sales User"; Boolean)
        {
        }
        field(50027; "Finance User"; Boolean)
        {
        }
        field(50028; "Prod. User"; Boolean)
        {
        }
        field(50029; "Warehouse User"; Boolean)
        {
        }
        field(50030; "Allow Order Conf"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "User Name"; Text[50])
        {
        }
        field(50036; "CD User"; Boolean)
        {
        }
        field(50037; DOA; Boolean)
        {
        }
        field(50038; "Price Update"; Boolean)
        {
        }
        field(50039; "Indent Limit"; Decimal)
        {
        }
        field(50040; Plant; Option)
        {
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;
        }
        field(50074; "Generate E-Way Bill"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50075; "Update E-Way Vechile No"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50076; "Cancel E-Way Bill"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50077; PIN; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Allow TO Release"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Item Authorization HSK 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50080; "Item Authorization 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50081; "Item Authorization 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50082; "Item Authorization 4"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50083; "Item Authorization DRA 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50084; "Item Authorization SKD 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50085; "Miltiple Logins Allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "No. of Sessions"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 1;
        }
        field(50100; "Capex Authorization 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50101; "Capex Authorization 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50102; "Capex Authorization 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50103; "Capex Authorization 4"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50104; "Capex Authorization 5"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50105; "Capex Authorization 6"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50106; "Capex Authorization 7"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50107; "Capex Authorization 8"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50108; "Request Capex Amount Limit"; Decimal)
        {
            Caption = 'Request Capex Amount Approval Limit';
            DataClassification = ToBeClassified;
            Description = 'MSRG';
        }
        field(50109; "Allow Bank account change"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Allow Capex Modify"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
        }
        field(50150; "Item Authorization WZ 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSRG';
            TableRelation = "User Setup"."User ID";
        }
        field(50151; "Item Creator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50155; "Vendor Approver"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            TableRelation = "User Setup"."User ID";
        }
        field(50156; "BiPass Capex Approval Limit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    procedure GetCapexApprovalLimit(CreateBy: Code[50]; NextApproverID: Code[50]): Decimal
    var
        CreateUserSetup: Record "User Setup";
        NextAppUserSetup: Record "User Setup";
    begin
        IF CreateUserSetup.GET(CreateBy) THEN;
        IF NextAppUserSetup.GET(NextApproverID) THEN;

        IF CreateUserSetup."BiPass Capex Approval Limit" THEN
            EXIT(0.01)
        ELSE BEGIN
            EXIT(NextAppUserSetup."Request Capex Amount Limit");
        END;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: DropDown)".

}

