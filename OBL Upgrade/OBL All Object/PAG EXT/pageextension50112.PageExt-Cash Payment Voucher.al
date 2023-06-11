pageextension 50112 pageextension50112 extends "Cash Payment Voucher"
{

    //Unsupported feature: Property Modification (PageType) on ""Cash Payment Voucher"(Page 16576)".

    layout
    {

        moveafter("Document No."; "Location Code")
        /*  addafter("Control 51")
          {
              field(ShortcutDimCode3; ShortcutDimCode[3])
              {
                  CaptionClass = '1,2,3';
                  Caption = 'ShortcutDimCode[3]';
                  Visible = false;

                  trigger OnLookup(var Text: Text): Boolean
                  begin
                      LookupShortcutDimCode(3, ShortcutDimCode[3]);
                  end;

                  trigger OnValidate()
                  begin
                      ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                  end;
              }
              field(ShortcutDimCode4; ShortcutDimCode[4])
              {
                  CaptionClass = '1,2,4';
                  Caption = 'ShortcutDimCode[4]';
                  Visible = false;

                  trigger OnLookup(var Text: Text): Boolean
                  begin
                      LookupShortcutDimCode(4, ShortcutDimCode[4]);
                  end;

                  trigger OnValidate()
                  begin
                      ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                  end;
              }
              field(ShortcutDimCode5; ShortcutDimCode[5])
              {
                  CaptionClass = '1,2,5';
                  Caption = 'ShortcutDimCode[5]';
                  Visible = false;

                  trigger OnLookup(var Text: Text): Boolean
                  begin
                      LookupShortcutDimCode(5, ShortcutDimCode[5]);
                  end;

                  trigger OnValidate()
                  begin
                      ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                  end;
              }
              field(ShortcutDimCode6; ShortcutDimCode[6])
              {
                  CaptionClass = '1,2,6';
                  Caption = 'ShortcutDimCode[6]';
                  Visible = false;

                  trigger OnLookup(var Text: Text): Boolean
                  begin
                      LookupShortcutDimCode(6, ShortcutDimCode[6]);
                  end;

                  trigger OnValidate()
                  begin
                      ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                  end;
              }
              field(ShortcutDimCode7; ShortcutDimCode[7])
              {
                  CaptionClass = '1,2,7';
                  Caption = 'ShortcutDimCode[7]';
                  Visible = false;

                  trigger OnLookup(var Text: Text): Boolean
                  begin
                      LookupShortcutDimCode(7, ShortcutDimCode[7]);
                  end;

                  trigger OnValidate()
                  begin
                      ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                  end;
              }
              field(ShortcutDimCode8; ShortcutDimCode[8])
              {
                  CaptionClass = '1,2,8';
                  Caption = 'ShortcutDimCode[8]';
                  Visible = false;

                  trigger OnLookup(var Text: Text): Boolean
                  begin
                      LookupShortcutDimCode(8, ShortcutDimCode[8]);
                  end;

                  trigger OnValidate()
                  begin
                      ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                  end;
              }
          }*/ // 15578
        moveafter("Reason Code"; "Cheque No.", "Cheque Date")
    }

    actions
    {
        modify(Post)
        {
            trigger OnAfterAction()
            begin
                rec.TESTFIELD("Shortcut Dimension 1 Code");
            end;
        }
    }
}

