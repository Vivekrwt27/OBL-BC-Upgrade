page 50248 "Approval entry"
{
    PageType = List;
    Permissions = TableData "Approval Entry" = rimd;
    SourceTable = "Approval Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                /* field("Last Modified By ID"; "Last Modified By ID")//16225 Table field N/F
                 {
                 }*/
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = All;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = All;
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ApplicationArea = All;
                }
                field("Record ID to Approve"; Rec."Record ID to Approve")
                {
                    ApplicationArea = All;
                }
                field("Delegation Date Formula"; Rec."Delegation Date Formula")
                {
                    ApplicationArea = All;
                }
                field("Number of Approved Requests"; Rec."Number of Approved Requests")
                {
                    ApplicationArea = All;
                }
                field("Number of Rejected Requests"; Rec."Number of Rejected Requests")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
                {
                    ApplicationArea = All;
                }
                field("Related to Change"; Rec."Related to Change")
                {
                    ApplicationArea = All;
                }
                field("GUID Key"; Rec."GUID Key")
                {
                    ApplicationArea = All;
                }
                field("Comment Text"; Rec."Comment Text")
                {
                    ApplicationArea = All;
                }
                field("Approver Code"; Rec."Approver Code")
                {
                    ApplicationArea = All;
                }
                field("Auto Approved"; Rec."Auto Approved")
                {
                    ApplicationArea = All;
                }
                field("Auto Approved By"; Rec."Auto Approved By")
                {
                    ApplicationArea = All;
                }
                field("Last TimeStamp"; Rec."Last TimeStamp")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By ID1"; Rec."Last Modified By ID1")
                {
                    ApplicationArea = All;
                }
                field(EmailID; Rec.EmailID)
                {
                    ApplicationArea = All;
                }
                field(PIN; Rec.PIN)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

