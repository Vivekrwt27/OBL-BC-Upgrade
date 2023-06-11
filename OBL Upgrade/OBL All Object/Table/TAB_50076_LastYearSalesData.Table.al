table 50076 "Last Year Sales Data"
{

    fields
    {
        field(1; DocumentType; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Invoice,Cr. Memo';
            OptionMembers = " ",Invoice,"Cr. Memo";
        }
        field(5; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; CustomerNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; CustomerName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; SellToCity; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; State; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; CustomerType; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(40; InvoiceNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(45; PostingDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; LocationCode; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(80; PMTCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85; Order_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(90; Order_No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(150; ItemNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(155; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(160; UOM; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(165; Quantity_Base; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(170; LineAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(175; AmountToCustomer; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(260; Quantity_in_Sq_Mt; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(315; SizeCodeDesc; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(330; TabProdGrp; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(400; SPCode; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(410; PCHCode; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(435; Tableau_Zone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(445; Zonal_Manager; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(450; Zonal_Head; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(455; Cust_Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(460; Revival_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(470; OBTB_Joining_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(500; ItemCatCode; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(501; "Area Code"; Code[12])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Matrix Master"."Type 2" WHERE("Mapping Type" = FILTER(City));
        }
    }

    keys
    {
        key(Key1; DocumentType, "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; PostingDate, SPCode, PCHCode, Zonal_Manager, Zonal_Head)
        {
        }
        key(Key3; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

