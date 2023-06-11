codeunit 50023 "Sales Matrix Functions"
{
    Permissions = TableData "Cust. Ledger Entry" = rimd;

    trigger OnRun()
    begin
        //MS-AN
        //SHELL('C:\Windows\Notepad.exe');
        //MS-AN
        /*
        SearchDirectory := 'C:\Anuj';
        IF ISCLEAR(rtFileSystem) THEN
          CREATE(rtFileSystem);
        IF NOT rtFileSystem.FolderExists(SearchDirectory) THEN
        rtFileSystem.CreateFolder(SearchDirectory);
        */

    end;

    var
        RecSaleLine: Record "Sales Line";
        i: Integer;
        TempSPAreaMappingLine: Record "Physical Journal Line" temporary;
        TempSPAreaMappingLine1: Record "Physical Journal Line" temporary;
        SalesInvLine: Record "Sales Invoice Line";
        RecCustomer: Record Customer;
        BlnUnique: Boolean;
        "---------": Integer;
        SearchDirectory: Text[200];
        // rtFileSystem: Automation;
        RecSalesPerson: Record "Salesperson/Purchaser";
        SPAreaMappingLine: Record "Physical Journal Line";
        SPAreaMappingHeader: Record "Physical Journal Header";
        DocNo: Code[20];


    procedure GetAllSalesPersonPCHCode("Area": Code[20])
    var
        RecSalesPersonMappingHdr: Record "Physical Journal Header";
        RecSalesPersonMappingLine: Record "Physical Journal Line";
        TempMasters: array[5] of Code[20];
    begin

        CLEAR(TempMasters);
        TempMasters[1] := GetMastersFromArea(Area, 1); // Zone
        TempMasters[2] := GetMastersFromArea(Area, 2); //States
        TempMasters[3] := GetMastersFromArea(Area, 3); //Division
        TempMasters[4] := GetMastersFromArea(Area, 4); //City

        /*
        RecSalesPersonMappingLine.RESET;
        WITH RecSalesPersonMappingLine DO BEGIN
          SETFILTER(Zone,'%1',TempMasters[1]);
            IF FINDFIRST AND (TempMasters[2] <> '') THEN
            SETFILTER(States,'%1',TempMasters[2]);
              IF FINDFIRST AND (TempMasters[3] <> '') THEN
              SETFILTER(Division,'%1',TempMasters[3]);
                IF FINDFIRST AND (TempMasters[4] <> '') THEN
                SETFILTER(City,'%1',TempMasters[4]);
                  IF FINDSET THEN BEGIN
                    ERROR('%1',COUNT);
                    TempSPAreaMappingLine.TRANSFERFIELDS(RecSalesPersonMappingLine);
                    TempSPAreaMappingLine.INSERT;
                  END;
        */
        //////////////////////// *** PCH *** ////////////////////////

        /* 15578   RecSalesPersonMappingLine.RESET;
             RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
             IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                 //WITH RecSalesPersonMappingLine DO BEGIN
                 RecSalesPersonMappingLine.SETFILTER(Area, '%1', Area);
                 IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[4] <> '') THEN BEGIN
                     RecSalesPersonMappingLine.RESET;
                     RecSalesPersonMappingLine.SETFILTER(City, '%1', TempMasters[4]);
                     RecSalesPersonMappingLine.SETFILTER(Area, '%1', '');
                     IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[3] <> '') THEN BEGIN
                         RecSalesPersonMappingLine.RESET;
                         RecSalesPersonMappingLine.SETFILTER(Division, '%1', TempMasters[3]);
                         RecSalesPersonMappingLine.SETFILTER(City, '%1', '');
                         IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[2] <> '') THEN BEGIN
                             RecSalesPersonMappingLine.RESET;
                             RecSalesPersonMappingLine.SETFILTER(States, '%1', TempMasters[2]);
                             RecSalesPersonMappingLine.SETFILTER(Division, '%1', '');
                             IF NOT RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                                 RecSalesPersonMappingLine.RESET;
                                 RecSalesPersonMappingLine.SETFILTER(Zone, '%1', TempMasters[1]);
                                 RecSalesPersonMappingLine.SETFILTER(States, '%1', '');
                             END;
                         END;
                     END;
                 END;
             END;*/ // 15578
        CLEAR(TempSPAreaMappingLine);
        TempSPAreaMappingLine.DELETEALL;

        IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
            REPEAT
                TempSPAreaMappingLine.TRANSFERFIELDS(RecSalesPersonMappingLine);
                TempSPAreaMappingLine.INSERT;
            UNTIL RecSalesPersonMappingLine.NEXT = 0;
        END;

        //////////////////////// *** SalesPerson *** ////////////////////////

        /* 15578    RecSalesPersonMappingLine.RESET;
            RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
            IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                //WITH RecSalesPersonMappingLine DO BEGIN
                RecSalesPersonMappingLine.SETFILTER(Area, '%1', Area);
                IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[4] <> '') THEN BEGIN
                    RecSalesPersonMappingLine.RESET;
                    RecSalesPersonMappingLine.SETFILTER(City, '%1', TempMasters[4]);
                    RecSalesPersonMappingLine.SETFILTER(Area, '%1', '');
                    IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[3] <> '') THEN BEGIN
                        RecSalesPersonMappingLine.RESET;
                        RecSalesPersonMappingLine.SETFILTER(Division, '%1', TempMasters[3]);
                        RecSalesPersonMappingLine.SETFILTER(City, '%1', '');
                        IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[2] <> '') THEN BEGIN
                            RecSalesPersonMappingLine.RESET;
                            RecSalesPersonMappingLine.SETFILTER(States, '%1', TempMasters[2]);
                            RecSalesPersonMappingLine.SETFILTER(Division, '%1', '');
                            IF NOT RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                                RecSalesPersonMappingLine.RESET;
                                RecSalesPersonMappingLine.SETFILTER(Zone, '%1', TempMasters[1]);
                                RecSalesPersonMappingLine.SETFILTER(States, '%1', '');
                            END;
                        END;
                    END;
                END;
            END;*/ // 15578
        CLEAR(TempSPAreaMappingLine);
        TempSPAreaMappingLine.DELETEALL;

        IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
            REPEAT
                TempSPAreaMappingLine.TRANSFERFIELDS(RecSalesPersonMappingLine);
                TempSPAreaMappingLine.INSERT;
            UNTIL RecSalesPersonMappingLine.NEXT = 0;
        END;

    end;


    procedure CreateSalesMatrixEntry(RecSaleLine: Record "Sales Line")
    var
        RecSaleMatrixEntry: Record "Sales Person Leave Details";
        RecCustomer: Record Customer;
        BlnUnique: Boolean;
    begin
        CLEAR(TempSPAreaMappingLine);
        RecCustomer.RESET;
        IF RecCustomer.GET(RecSaleLine."Sell-to Customer No.") THEN
            GetAllSalesPersonPCHCode(RecCustomer."Area Code");

        BlnUnique := TRUE;

        /*  WITH TempSPAreaMappingLine DO BEGIN
              RecSaleMatrixEntry.INIT;
              RecSaleMatrixEntry."Sales Person Code" := GetLastEntryNo;
              RecSaleMatrixEntry."Document Type" := RecSaleLine."Document Type";
              RecSaleMatrixEntry."Document No." := RecSaleLine."Document No.";
              RecSaleMatrixEntry."Line No." := RecSaleLine."Line No.";
              RecSaleMatrixEntry."Item No." := RecSaleLine."No.";
              RecSaleMatrixEntry.Quantity := RecSaleLine.Quantity;
              RecSaleMatrixEntry."Qty. in Sq. Mtrs" := RecSaleLine."Quantity in Sq. Mt.";

              RecSaleMatrixEntry.Zone := GetMastersFromArea(RecCustomer."Area Code", 1);
              RecSaleMatrixEntry.State := GetMastersFromArea(RecCustomer."Area Code", 2);
              RecSaleMatrixEntry.Date := GetMastersFromArea(RecCustomer."Area Code", 3);
              RecSaleMatrixEntry.City := GetMastersFromArea(RecCustomer."Area Code", 4);

              RecSaleMatrixEntry.Area := RecCustomer."Area Code";

              RecSaleMatrixEntry."Item Category Code" := RecSaleLine."Item Category Code";
              RecSaleMatrixEntry.Type := TempSPAreaMappingLine.Type;
              RecSaleMatrixEntry."PCH/Sales Person Code" := TempSPAreaMappingLine."PCH Code";
              RecSaleMatrixEntry."Customer No." := RecCustomer."No.";
              RecSaleMatrixEntry."Unique Entry" := BlnUnique;
              RecSaleMatrixEntry.INSERT(TRUE);
              BlnUnique := FALSE;
          END;*/ // 15578
    end;


    /*  procedure GetLastEntryNo(): Integer
      var
          RecSaleMatrixEntry: Record 50028;
      begin
          RecSaleMatrixEntry.RESET;
          IF RecSaleMatrixEntry.FINDLAST THEN
              EXIT(RecSaleMatrixEntry."Sales Person Code" + 1)
          ELSE
              EXIT(1);
      end;*/ // 15578


    procedure GetMastersFromArea("Area": Code[20]; Type: Option " ",Zone,States,Division,City,"Area"): Code[20]
    var
        RecMatrixMaster: Record "Matrix Master";
        Master: array[6] of Code[20];
    begin
        //1 := Area
        //2 := City
        //3 := Division
        //4 := State
        //5  := Zone

        Master[1] := Area;
        FOR i := 1 TO 5 DO BEGIN
            RecMatrixMaster.RESET;
            RecMatrixMaster.SETRANGE("Mapping Type", 5 - i);
            RecMatrixMaster.SETRANGE("Type 2", Master[i]);
            IF RecMatrixMaster.FINDFIRST THEN BEGIN
                Master[i + 1] := RecMatrixMaster."Type 1";
            END;
        END;

        CASE Type OF
            Type::Zone:
                EXIT(Master[6 - Type]);
            Type::States:
                EXIT(Master[6 - Type]);
            Type::Division:
                EXIT(Master[6 - Type]);
            Type::City:
                EXIT(Master[6 - Type]);
        END;
    end;


    procedure CreateSalesMatrixEntryPosted(RecSalesInvoice: Record "Sales Invoice Line")
    var
        RecSaleMatrixEntry: Record "Sales Person Leave Details";
    begin
        CLEAR(TempSPAreaMappingLine);
        CLEAR(TempSPAreaMappingLine1);
        BlnUnique := TRUE;
        SalesInvLine := RecSalesInvoice;
        RecCustomer.RESET;
        IF RecCustomer.GET(SalesInvLine."Sell-to Customer No.") THEN BEGIN
            GetAllPCHCode(RecCustomer."Area Code");
            GetAllSPCode(RecCustomer."Area Code");
        END;
    end;


    procedure GetAllPCHCode("Area": Code[20])
    var
        RecSalesPersonMappingHdr: Record "Physical Journal Header";
        RecSalesPersonMappingLine: Record "Physical Journal Line";
        TempMasters: array[5] of Code[20];
    begin
        CLEAR(TempMasters);
        TempMasters[1] := GetMastersFromArea(Area, 1); //Zone
        TempMasters[2] := GetMastersFromArea(Area, 2); //States
        TempMasters[3] := GetMastersFromArea(Area, 3); //Division
        TempMasters[4] := GetMastersFromArea(Area, 4); //City

        //////////////////////// *** PCH *** ////////////////////////

        /* 15578  RecSalesPersonMappingLine.RESET;
          RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
          IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
              RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
              RecSalesPersonMappingLine.SETFILTER(Area, '%1', Area);
              IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[4] <> '') THEN BEGIN
                  RecSalesPersonMappingLine.RESET;
                  RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
                  RecSalesPersonMappingLine.SETFILTER(City, '%1', TempMasters[4]);
                  RecSalesPersonMappingLine.SETFILTER(Area, '%1', '');
                  IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[3] <> '') THEN BEGIN
                      RecSalesPersonMappingLine.RESET;
                      RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
                      RecSalesPersonMappingLine.SETFILTER(Division, '%1', TempMasters[3]);
                      RecSalesPersonMappingLine.SETFILTER(City, '%1', '');
                      IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[2] <> '') THEN BEGIN
                          RecSalesPersonMappingLine.RESET;
                          RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
                          RecSalesPersonMappingLine.SETFILTER(States, '%1', TempMasters[2]);
                          RecSalesPersonMappingLine.SETFILTER(Division, '%1', '');
                          IF NOT RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                              RecSalesPersonMappingLine.RESET;
                              RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::PCH);
                              RecSalesPersonMappingLine.SETFILTER(Zone, '%1', TempMasters[1]);
                              RecSalesPersonMappingLine.SETFILTER(States, '%1', '');
                          END;
                      END;
                  END;
              END;
          END;*/ // 15578
        CLEAR(TempSPAreaMappingLine);
        TempSPAreaMappingLine.DELETEALL;

        IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
            REPEAT
                TempSPAreaMappingLine.TRANSFERFIELDS(RecSalesPersonMappingLine);
                TempSPAreaMappingLine.INSERT;
            UNTIL RecSalesPersonMappingLine.NEXT = 0;
        END;

        CreateSalesMatrixEntryForPCH;
    end;


    procedure GetAllSPCode("Area": Code[20])
    var
        RecSalesPersonMappingHdr: Record "Physical Journal Header";
        RecSalesPersonMappingLine: Record "Physical Journal Line";
        TempMasters: array[5] of Code[20];
    begin
        CLEAR(TempMasters);
        TempMasters[1] := GetMastersFromArea(Area, 1); // Zone
        TempMasters[2] := GetMastersFromArea(Area, 2); //States
        TempMasters[3] := GetMastersFromArea(Area, 3); //Division
        TempMasters[4] := GetMastersFromArea(Area, 4); //City

        //////////////////////// *** SalesPerson *** ////////////////////////

        /* 15578    RecSalesPersonMappingLine.RESET;
            RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
            IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
                RecSalesPersonMappingLine.SETFILTER(Area, '%1', Area);
                IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[4] <> '') THEN BEGIN
                    RecSalesPersonMappingLine.RESET;
                    RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
                    RecSalesPersonMappingLine.SETFILTER(City, '%1', TempMasters[4]);
                    RecSalesPersonMappingLine.SETFILTER(Area, '%1', '');
                    IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[3] <> '') THEN BEGIN
                        RecSalesPersonMappingLine.RESET;
                        RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
                        RecSalesPersonMappingLine.SETFILTER(Division, '%1', TempMasters[3]);
                        RecSalesPersonMappingLine.SETFILTER(City, '%1', '');
                        IF NOT RecSalesPersonMappingLine.FINDFIRST AND (TempMasters[2] <> '') THEN BEGIN
                            RecSalesPersonMappingLine.RESET;
                            RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
                            RecSalesPersonMappingLine.SETFILTER(States, '%1', TempMasters[2]);
                            RecSalesPersonMappingLine.SETFILTER(Division, '%1', '');
                            IF NOT RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
                                RecSalesPersonMappingLine.RESET;
                                RecSalesPersonMappingLine.SETRANGE(Type, RecSalesPersonMappingLine.Type::"Sales Person");
                                RecSalesPersonMappingLine.SETFILTER(Zone, '%1', TempMasters[1]);
                                RecSalesPersonMappingLine.SETFILTER(States, '%1', '');
                            END;
                        END;
                    END;
                END;
            END;*/ // 15578
        CLEAR(TempSPAreaMappingLine1);
        TempSPAreaMappingLine1.DELETEALL;

        IF RecSalesPersonMappingLine.FINDFIRST THEN BEGIN
            REPEAT
                TempSPAreaMappingLine1.TRANSFERFIELDS(RecSalesPersonMappingLine);
                TempSPAreaMappingLine1.INSERT;
            UNTIL RecSalesPersonMappingLine.NEXT = 0;
        END;

        CreateSalesMatrixEntryForSP;
    end;


    procedure CreateSalesMatrixEntryForPCH()
    var
        RecSaleMatrixEntry: Record "Sales Person Leave Details";
    begin
        /* 15578    IF TempSPAreaMappingLine.FINDFIRST THEN BEGIN
                REPEAT
                    WITH TempSPAreaMappingLine DO BEGIN
                        RecSaleMatrixEntry.INIT;
                        RecSaleMatrixEntry."Sales Person Code" := GetLastEntryNo;
                        RecSaleMatrixEntry."Document Type" := RecSaleMatrixEntry."Document Type"::"2";
                        RecSaleMatrixEntry."Document No." := SalesInvLine."Document No.";
                        RecSaleMatrixEntry."Line No." := SalesInvLine."Line No.";
                        RecSaleMatrixEntry."Item No." := SalesInvLine."No.";
                        RecSaleMatrixEntry.Description := SalesInvLine.Description;
                        RecSaleMatrixEntry.Quantity := SalesInvLine.Quantity;
                        RecSaleMatrixEntry."Qty. in Sq. Mtrs" := SalesInvLine."Quantity in Sq. Mt.";

                        RecSaleMatrixEntry.Zone := GetMastersFromArea(RecCustomer."Area Code", 1);
                        RecSaleMatrixEntry.State := GetMastersFromArea(RecCustomer."Area Code", 2);
                        RecSaleMatrixEntry.Date := GetMastersFromArea(RecCustomer."Area Code", 3);
                        RecSaleMatrixEntry.City := GetMastersFromArea(RecCustomer."Area Code", 4);
                        RecSaleMatrixEntry.Area := RecCustomer."Area Code";

                        RecSaleMatrixEntry."Item Category Code" := SalesInvLine."Item Category Code";
                        RecSaleMatrixEntry.Type := RecSaleMatrixEntry.Type::"1";

                        RecSaleMatrixEntry."PCH/Sales Person Code" := TempSPAreaMappingLine."PCH Code";
                        //RecSaleMatrixEntry."PCH/Sales Person Code" := GetCustSalesPersonPCHCode(TempSPAreaMappingLine."PCH Code");
                        RecSaleMatrixEntry."Customer No." := RecCustomer."No.";
                        RecSaleMatrixEntry."Item Size Code" := SalesInvLine."Size Code";

                        RecSaleMatrixEntry."Unique Entry" := BlnUnique;

                        RecSaleMatrixEntry."Posting Date" := SalesInvLine."Posting Date";
                        RecSaleMatrixEntry."Amount to Customer" := SalesInvLine."Amount To Customer";


                        RecSaleMatrixEntry.INSERT(TRUE);

                        //BlnUnique :=FALSE;
                    END;
                UNTIL TempSPAreaMappingLine.NEXT = 0;
            END;*/ // 15578
    end;


    procedure CreateSalesMatrixEntryForSP()
    var
        RecSaleMatrixEntry: Record "Sales Person Leave Details";
    begin
        /*    IF TempSPAreaMappingLine1.FINDFIRST THEN BEGIN
                REPEAT
                    WITH TempSPAreaMappingLine1 DO BEGIN
                        RecSaleMatrixEntry.INIT;
                        RecSaleMatrixEntry."Sales Person Code" := GetLastEntryNo;
                        RecSaleMatrixEntry."Document Type" := RecSaleMatrixEntry."Document Type"::"2";
                        RecSaleMatrixEntry."Document No." := SalesInvLine."Document No.";
                        RecSaleMatrixEntry."Line No." := SalesInvLine."Line No.";
                        RecSaleMatrixEntry."Item No." := SalesInvLine."No.";
                        RecSaleMatrixEntry.Description := SalesInvLine.Description;
                        RecSaleMatrixEntry.Quantity := SalesInvLine.Quantity;
                        RecSaleMatrixEntry."Qty. in Sq. Mtrs" := SalesInvLine."Quantity in Sq. Mt.";

                        RecSaleMatrixEntry.Zone := GetMastersFromArea(RecCustomer."Area Code", 1);
                        RecSaleMatrixEntry.State := GetMastersFromArea(RecCustomer."Area Code", 2);
                        RecSaleMatrixEntry.Date := GetMastersFromArea(RecCustomer."Area Code", 3);
                        RecSaleMatrixEntry.City := GetMastersFromArea(RecCustomer."Area Code", 4);

                        RecSaleMatrixEntry.Area := RecCustomer."Area Code";

                        RecSaleMatrixEntry."Item Category Code" := SalesInvLine."Item Category Code";
                        RecSaleMatrixEntry.Type := RecSaleMatrixEntry.Type::"2";
                        RecSaleMatrixEntry."PCH/Sales Person Code" := TempSPAreaMappingLine1."PCH Code";
                        //RecSaleMatrixEntry."PCH/Sales Person Code" := GetCustSalesPersonPCHCode(TempSPAreaMappingLine1."PCH Code");
                        RecSaleMatrixEntry."Customer No." := RecCustomer."No.";
                        RecSaleMatrixEntry."Item Size Code" := SalesInvLine."Size Code";

                        RecSaleMatrixEntry."Unique Entry" := BlnUnique;

                        RecSaleMatrixEntry."Posting Date" := SalesInvLine."Posting Date";
                        RecSaleMatrixEntry."Amount to Customer" := SalesInvLine."Amount To Customer";


                        RecSaleMatrixEntry.INSERT(TRUE);

                        //BlnUnique :=FALSE;
                    END;
                UNTIL TempSPAreaMappingLine1.NEXT = 0;
            END;*/ // 15578
    end;


    procedure GetCustSalesPersonPCHCode(SpPchCode: Code[10]): Code[20]
    var
        RecItem: Record Item;
        SpProductMappingLine: Record "Notification - User Mapping";
    begin
        /*    RecItem.GET(SalesInvLine."No.");
            SpProductMappingLine.RESET;
            SpProductMappingLine.SETRANGE("Item Category Code", RecItem."Type Catogery Code");
            SpProductMappingLine.SETRANGE("Size Code", RecItem."Size Code");
            IF SpProductMappingLine.FINDSET THEN BEGIN
                IF SpProductMappingLine."PCH Code" = SpPchCode THEN
                    EXIT(SpProductMappingLine."PCH Code")
                ELSE
                    EXIT;
            END;*/ // 15578
    end;


    procedure "----MSKS"()
    begin
    end;


    procedure UpdateSalesPersonMatrix(SP: Record "Salesperson/Purchaser"; Type: Option " ",PCH,"Sales Person")
    begin
        /* 15578   WITH SP DO BEGIN
               RecCustomer.RESET;
               RecCustomer.SETCURRENTKEY("Salesperson Code");
               IF Type = 2 THEN
                   RecCustomer.SETRANGE("Salesperson Code", SP.Code)
               ELSE
                   RecCustomer.SETRANGE("PCH Code", SP.Code);
               RecCustomer.SETFILTER("Area Code", '<>%1', '');
               IF RecCustomer.FINDFIRST THEN BEGIN
                   REPEAT
                     SPAreaMappingLine.RESET;
                       SPAreaMappingLine.SETRANGE(Type, Type);
                       SPAreaMappingLine.SETRANGE("PCH Code", SP.Code);
                       SPAreaMappingLine.SETRANGE(Area, RecCustomer."Area Code");
                       IF NOT SPAreaMappingLine.FINDFIRST THEN BEGIN
                           CreateSPMatrixLine(Type, SP.Code, DocNo, RecCustomer."Area Code");

                           SPAreaMappingLine."Document No." :=DocNo;
                           SPAreaMappingLine."Line No." := GetNextLineNo(DocNo);
                           SPAreaMappingLine.Area  := RecCustomer."Area Code";
                           SPAreaMappingLine."Start Date":= SPAreaMappingHeader."Start Date";
                           SPAreaMappingLine."End Date" :=  SPAreaMappingHeader."End Date";
                           SPAreaMappingLine.Type       :=  SPAreaMappingHeader.Type;
                           SPAreaMappingLine."PCH Code" :=  SP.Code;
                           SPAreaMappingLine.Zone :=GetMastersFromArea(RecCustomer."Area Code",1);
                           SPAreaMappingLine.States:=GetMastersFromArea(RecCustomer."Area Code",2);
                           SPAreaMappingLine.Division:=GetMastersFromArea(RecCustomer."Area Code",3);
                           SPAreaMappingLine.City:=GetMastersFromArea(RecCustomer."Area Code",4);
                           SPAreaMappingLine.INSERT(TRUE);

                       END;
                   UNTIL RecCustomer.NEXT = 0;
               END ELSE BEGIN
                   SPAreaMappingLine.RESET;
                   SPAreaMappingLine.SETRANGE(Type, Type);
                   SPAreaMappingLine.SETRANGE("PCH Code", SP.Code);
                   SPAreaMappingLine.SETRANGE(Area, RecCustomer."Area Code");
                   IF SPAreaMappingLine.FINDFIRST THEN BEGIN
                       SPAreaMappingLine.DELETE(TRUE);
                   END;
               END;
           END;*/ // 15578

    end;


    procedure CreateSPMatrixLine(Type: Option " ",PCH,"Sales Person"; SPCode: Code[20]; var DocNo: Code[20]; AreaCode: Code[20])
    var
        SPAreaMappingLine1: Record "Physical Journal Line";
    begin
        /*    SPAreaMappingHeader.RESET;
            SPAreaMappingHeader.SETRANGE(Type, Type);
            SPAreaMappingHeader.SETRANGE("PCH Code", SPCode);
            IF NOT SPAreaMappingHeader.FINDFIRST THEN BEGIN
                SPAreaMappingHeader."No." := '';
                SPAreaMappingHeader."PCH Code" := SPCode;
                SPAreaMappingHeader."Start Date" := TODAY;
                SPAreaMappingHeader.Type := Type;
                SPAreaMappingHeader.Status := 1;
                SPAreaMappingHeader.INSERT(TRUE);
                DocNo := SPAreaMappingHeader."No.";

                SPAreaMappingLine1.RESET;
                SPAreaMappingLine1."Document No." := DocNo;
                SPAreaMappingLine1."Line No." := GetNextLineNo(SPAreaMappingHeader."No.");
                SPAreaMappingLine1.Area := AreaCode;
                SPAreaMappingLine1."Start Date" := SPAreaMappingHeader."Start Date";
                SPAreaMappingLine1."End Date" := SPAreaMappingHeader."End Date";
                SPAreaMappingLine1.Type := SPAreaMappingHeader.Type;
                SPAreaMappingLine1."PCH Code" := SPAreaMappingHeader."PCH Code";
                SPAreaMappingLine1.Zone := GetMastersFromArea(AreaCode, 1);
                SPAreaMappingLine1.States := GetMastersFromArea(AreaCode, 2);
                SPAreaMappingLine1.Division := GetMastersFromArea(AreaCode, 3);
                SPAreaMappingLine1.City := GetMastersFromArea(AreaCode, 4);

                SPAreaMappingLine1.INSERT;

            END ELSE BEGIN
                DocNo := SPAreaMappingHeader."No.";
                SPAreaMappingLine1.RESET;
                SPAreaMappingLine1."Document No." := DocNo;
                SPAreaMappingLine1."Line No." := GetNextLineNo(SPAreaMappingHeader."No.");
                SPAreaMappingLine1.Area := AreaCode;
                SPAreaMappingLine1."Start Date" := SPAreaMappingHeader."Start Date";
                SPAreaMappingLine1."End Date" := SPAreaMappingHeader."End Date";
                SPAreaMappingLine1.Type := SPAreaMappingHeader.Type;
                SPAreaMappingLine1."PCH Code" := SPAreaMappingHeader."PCH Code";
                SPAreaMappingLine1.Zone := GetMastersFromArea(AreaCode, 1);
                SPAreaMappingLine1.States := GetMastersFromArea(AreaCode, 2);
                SPAreaMappingLine1.Division := GetMastersFromArea(AreaCode, 3);
                SPAreaMappingLine1.City := GetMastersFromArea(AreaCode, 4);

                SPAreaMappingLine1.INSERT;

            END;*/ // 15578
    end;


    procedure GetNextLineNo(DocNo: Code[20]): Integer
    var
        SPAreaMappingLine: Record "Physical Journal Line";
    begin
        SPAreaMappingLine.RESET;
        SPAreaMappingLine.SETRANGE("Document No.", DocNo);
        IF SPAreaMappingLine.FINDLAST THEN
            EXIT(SPAreaMappingLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;


    procedure Change1(EntryNum: Integer)
    var
        CustLEntry: Record "Cust. Ledger Entry";
    begin
        CustLEntry.LOCKTABLE;
        CustLEntry.GET(EntryNum);
        CustLEntry.AutoDebitCheckFlag := TRUE;
        CustLEntry.DebitCheckStateFlag := TRUE;
        CustLEntry.MODIFY;
        COMMIT;
    end;


    procedure Change2(EntryNum: Integer; DebitAmt: Decimal; DebitNoteDocNum: Code[25])
    var
        CustLEntry: Record "Cust. Ledger Entry";
    begin
        CustLEntry.LOCKTABLE;
        CustLEntry.GET(EntryNum);
        CustLEntry.CashDiscountDebitFlag := TRUE;
        CustLEntry.DebitAmtOnCashDisc := DebitAmt;
        CustLEntry.DebitInvNo := DebitNoteDocNum;
        CustLEntry.MODIFY;
        COMMIT;
    end;


    procedure Change3(EntryNum: Integer)
    var
        CustLEntry: Record "Cust. Ledger Entry";
    begin
        CustLEntry.LOCKTABLE;
        CustLEntry.GET(EntryNum);
        CustLEntry.AutoDebitCheckFlag := TRUE;
        CustLEntry.DebitSuspFlag := TRUE;
        CustLEntry.MODIFY;
        COMMIT;
    end;


    procedure Change4(EntryNum: Integer)
    var
        CustLEntry: Record "Cust. Ledger Entry";
    begin
        CustLEntry.LOCKTABLE;
        CustLEntry.GET(EntryNum);
        CustLEntry.DebitSuspFlag := FALSE;
        CustLEntry.MODIFY;
        COMMIT;
    end;
}

