pageextension 50278 pageextension50278 extends "Posted Transfer Receipt"
{


    layout
    {
        addafter("In-Transit Code")
        {
            field("Transporter's Name"; Rec."Transporter's Name")
            {
                Caption = 'Transporter Code';
                Editable = false;
                ApplicationArea = All;
            }
            field("Truck No."; Rec."Truck No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Purpose; Rec.Purpose)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Loading Inspector"; Rec."Loading Inspector")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("GR No."; Rec."GR No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("GR Date"; Rec."GR Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("E-way Bill No."; Rec."E-way Bill No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF (STRLEN(Rec."E-way Bill No.") <> 12) THEN
                        ERROR(Text50032);

                    IF CONFIRM('E-Way Bill No. You have Entered' + '-' + Rec."E-way Bill No.", TRUE) THEN
                        "E-Way Bill No.editable" := FALSE
                    ELSE
                        "E-Way Bill No.editable" := TRUE
                end;
            }
            field("Insurance Amount"; Rec."Insurance Amount")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Receipt")
        {
            action("Sample Conversion")
            {
                Image = SerialNo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TrcptLine: Record "Transfer Receipt Line";
                    TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
                begin
                    TrcptLine.RESET;
                    TrcptLine.SETFILTER("Document No.", '%1', Rec."No.");
                    IF TrcptLine.FINDFIRST THEN BEGIN
                        REPEAT
                            CLEAR(TransferOrderPostReceipt);
                            //  TransferOrderPostReceipt.CreateAssemblyOrderandPost(TrcptLine);
                            // TransferOrderPostReceipt.CreateSampleAssemblyOrderandPost(TrcptLine);
                            MESSAGE('Created ');
                        UNTIL TrcptLine.NEXT = 0;
                    END;
                end;
            }
        }
    }

    var
        "E-Way Bill No.editable": Boolean;
        Text50032: Label 'E-Way Bill No. Should be 12 Digit Only.';

    trigger OnOpenPage()
    begin
        IF Rec."E-way Bill No." <> '' THEN
            "E-Way Bill No.editable" := FALSE
        ELSE
            "E-Way Bill No.editable" := TRUE

    end;
    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //begin
    /*
    IF "E-way Bill No." <>'' THEN
        "E-Way Bill No.editable" := FALSE
        ELSE
        "E-Way Bill No.editable" := TRUE

    */
    //end;
}

