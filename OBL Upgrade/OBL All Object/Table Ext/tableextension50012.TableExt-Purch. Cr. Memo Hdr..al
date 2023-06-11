tableextension 50012 tableextension50012 extends "Purch. Cr. Memo Hdr."
{

    //Unsupported feature: Property Insertion (Permissions) on ""Purch. Cr. Memo Hdr."(Table 124)".

    fields
    {
        modify("Posting Description")
        {

            //Unsupported feature: Property Modification (Data type) on ""Posting Description"(Field 22)".

            Description = 'TRI';
        }
        /* modify(Structure)
         {
             TableRelation = "Structure Header" WHERE (Structure Type=FILTER(Purchase));
         }*/ // 15578


        field(50009; "Vendor Invoice Date"; Date)
        {
        }
        field(50010; "Vendor Invoice No."; Code[20])
        {
            Caption = 'Vendor Invoice No.';
        }
        field(50093; "Truck No."; Text[15])
        {
        }
        field(50094; "GR No."; Code[15])
        {
        }
        field(50096; "Vendor GST CN  available"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(50097; "Vendor CN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "E-Way Bill No.1"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        } // 15578
        field(50101; "E-Way Bill Date1"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50102; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50103; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50104; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50105; "Vehicle No.1"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50106; "Vechile No. Update Remark"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = ' ,Due to Break Down,Due to Transhipment,Others,First Time';
            OptionMembers = " ","Due to Break Down","Due to Transhipment",Others,"First Time";
        }
        field(50107; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50108; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50109; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50111; "E-Way URL"; Text[200])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50112; "Reason of Cancel"; Option)
        {
            Description = 'Alle-[E-Way API]';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry mistake,Others';
            OptionMembers = " ",Duplicate,"Order Cancelled","Data Entry mistake",Others;
        }
        field(50113; "Shipping Agent Code1"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Description = 'Alle-[E-Way API]';
            TableRelation = "Shipping Agent";
        } // 15578 
        field(80000; "Due Date Calc. On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor Invoice Date,Posting Date,GRN Date,Document Date';
            OptionMembers = " ","Vendor Invoice Date","Posting Date","GRN Date","Document Date";
        }
        field(80007; "Posting Description New"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Description';
        }
    }
    keys
    {
        key(Key9; "Applies-to Doc. No.")
        {
        }
    }
}

