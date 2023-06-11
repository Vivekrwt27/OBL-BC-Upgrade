tableextension 50191 tableextension50191 extends "Approval Entry"
{

    //Unsupported feature: Property Insertion (Permissions) on ""Approval Entry"(Table 454)".

    fields
    {
        modify("Document Type")
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Credit Limit';

            //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 2)".

        }
        modify(Status)
        {
            OptionCaption = 'Created,Open,Cancelled,Rejected,Approved';

            trigger OnBeforeValidate()// 15578
            begin
                "Last TimeStamp" := CURRENTDATETIME;
            end;

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 9)".

        }


        field(50000; "GUID Key"; Guid)
        {
        }
        field(50001; "Comment Text"; Text[250])
        {
        }
        field(50002; "Approver Code"; Code[30])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50003; "Auto Approved"; Boolean)
        {
        }
        field(50004; "Auto Approved By"; Code[20])
        {
        }
        field(50005; "Last TimeStamp"; DateTime)
        {
            Editable = false;
        }
        field(50006; "Last Modified By ID1"; Code[50])
        {
        }
        field(50007; EmailID; Text[50])
        {
        }
        field(50008; PIN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key9; Status, "Sequence No.")
        {
        }
    }
    trigger OnInsert()// 15578
    begin
        "GUID Key" := CREATEGUID;
    end;

    var
        ArchApprovalEntry: Record "Archive Approval Entry";
}

