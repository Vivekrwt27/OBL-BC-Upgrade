/*pageextension 50410 pageextension50410 extends "Structure Details"
{
    layout
    {

    }

    var
        [InDataSet]
        "Calculation ValueEditable": Boolean;
        [InDataSet]
        CodeEditable: Boolean;
        [InDataSet]
        "Calculation OrderEditable": Boolean;
        [InDataSet]
        TypeEditable: Boolean;
        [InDataSet]
        "Charge TypeEditable": Boolean;
        [InDataSet]
        "Tax/Charge GroupEditable": Boolean;
        [InDataSet]
        "Tax/Charge CodeEditable": Boolean;
        [InDataSet]
        "Calculation TypeEditable": Boolean;
        [InDataSet]
        CVDEditable: Boolean;
        [InDataSet]
        CVDPayabletoThirdPartyEditable: Boolean;
        [InDataSet]
        "CVD Third Party CodeEditable": Boolean;
        [InDataSet]
        IncludePITCalculationEditable: Boolean;
        [InDataSet]
        "Quantity PerEditable": Boolean;
        [InDataSet]
        "Base FormulaEditable": Boolean;
        [InDataSet]
        "Include BaseEditable": Boolean;
        [InDataSet]
        "Include Line DiscountEditable": Boolean;
        [InDataSet]
        IncludeInvoiceDiscountEditable: Boolean;
        [InDataSet]
        "Header/LineEditable": Boolean;
        [InDataSet]
        "Charge BasisEditable": Boolean;
        [InDataSet]
        "Loading on InventoryEditable": Boolean;
        [InDataSet]
        "Payable to Third PartyEditable": Boolean;
        [InDataSet]
        "Account No.Editable": Boolean;
        [InDataSet]
        AvailableforVATInputEditable: Boolean;
        [InDataSet]
        IncludeTDSBaseCalculationEdita: Boolean;*/


//Unsupported feature: Code Insertion on "OnAfterGetRecord".

//trigger OnAfterGetRecord()
//begin
/*
//Upgrade(+)

//MSBS.Rao End Dt. 20-08-12
IF (Type = Type::Charges)  AND ("Calculation Type"="Calculation Type"::"Fixed Value") THEN BEGIN
  "Calculation ValueEditable" := TRUE;
END ELSE BEGIN
  CodeEditable := FALSE;
  "Calculation OrderEditable" := FALSE;
  TypeEditable := FALSE;
  "Charge TypeEditable" := FALSE;
  "Tax/Charge GroupEditable" := FALSE;
  "Tax/Charge CodeEditable" := FALSE;
  "Calculation TypeEditable" := FALSE;
  "Calculation ValueEditable" := FALSE;
  CVDEditable := FALSE;
  CVDPayabletoThirdPartyEditable := FALSE;
  "CVD Third Party CodeEditable" := FALSE;
  IncludePITCalculationEditable := FALSE;
  "Quantity PerEditable" := FALSE;
  "Base FormulaEditable" := FALSE;
  "Include BaseEditable" := FALSE;
  "Include Line DiscountEditable" := FALSE;
  IncludeInvoiceDiscountEditable := FALSE;
  "Header/LineEditable" := FALSE;
  "Charge BasisEditable" := FALSE;
  "Loading on InventoryEditable" := FALSE;
  "Payable to Third PartyEditable" := FALSE;
  "Account No.Editable" := FALSE;
  AvailableforVATInputEditable := FALSE;
  IncludeTDSBaseCalculationEdita := FALSE;
END;
//MSBS.Rao End Dt. 20-08-12

//Upgrade(-)

*/
//end;


//Unsupported feature: Code Insertion on "OnInit".

//trigger OnInit()
//Parameters and return type have not been exported.
//begin
/*
//Upgrade(+)
IncludeTDSBaseCalculationEdita := TRUE;
AvailableforVATInputEditable := TRUE;
"Account No.Editable" := TRUE;
"Payable to Third PartyEditable" := TRUE;
"Loading on InventoryEditable" := TRUE;
"Charge BasisEditable" := TRUE;
"Header/LineEditable" := TRUE;
IncludeInvoiceDiscountEditable := TRUE;
"Include Line DiscountEditable" := TRUE;
"Include BaseEditable" := TRUE;
"Base FormulaEditable" := TRUE;
"Quantity PerEditable" := TRUE;
IncludePITCalculationEditable := TRUE;
"CVD Third Party CodeEditable" := TRUE;
CVDPayabletoThirdPartyEditable := TRUE;
CVDEditable := TRUE;
"Calculation TypeEditable" := TRUE;
"Tax/Charge CodeEditable" := TRUE;
"Charge TypeEditable" := TRUE;
TypeEditable := TRUE;
"Calculation OrderEditable" := TRUE;
CodeEditable := TRUE;
"Calculation ValueEditable" := TRUE;

//Upgrade(-)
*/
//end;
//}

