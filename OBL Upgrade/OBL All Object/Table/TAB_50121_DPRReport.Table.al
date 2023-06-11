table 50121 "DPR Report"
{

    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; "Production Line"; Code[20])
        {
        }
        field(3; Size; Code[50])
        {
        }
        field(4; "O/B of slip(MT)"; Decimal)
        {
        }
        field(5; "R/M issue from store(MT)"; Decimal)
        {
        }
        field(6; "Scrap charged(MT)"; Decimal)
        {
        }
        field(7; "Moisture loss(MT)"; Decimal)
        {
        }
        field(8; "Inter Plant Trf Slip"; Decimal)
        {
        }
        field(9; "C/B of slip(MT)"; Decimal)
        {
        }
        field(10; "Slip Production"; Decimal)
        {
        }
        field(11; "O/B of dust(MT)"; Decimal)
        {
        }
        field(12; "Dust production(MT)"; Decimal)
        {
        }
        field(13; "Inter Plant Trf Dust"; Decimal)
        {
        }
        field(14; "C/B of dust(MT)"; Decimal)
        {
        }
        field(15; "Dust issued to press(MT)"; Decimal)
        {
        }
        field(16; "O/B of glaze(MT)"; Decimal)
        {
        }
        field(17; "Mat. issued from stores(MT)"; Decimal)
        {
        }
        field(18; "Process Loss"; Decimal)
        {
        }
        field(19; "Glaze issued to G/L(MT)"; Decimal)
        {
        }
        field(20; "Inter Plant Trf -Glaze."; Decimal)
        {
        }
        field(21; "C/B of glaze(MT)"; Decimal)
        {
        }
        field(22; "Tiles pressed(sqm)"; Decimal)
        {
        }
        field(23; "Dust loss(MT)"; Decimal)
        {
        }
        field(24; "Green tiles issu to G/L(sqm)"; Decimal)
        {
        }
        field(25; "Green pitcher(sqm)"; Decimal)
        {
        }
        field(26; "Tiles received from press(sqm)"; Decimal)
        {
        }
        field(27; "Tiles issued to RHK(sqm)"; Decimal)
        {
        }
        field(29; "O/B of glaze on lines(MT)"; Decimal)
        {
        }
        field(30; "Inter Plant Trf -Glaze"; Decimal)
        {
        }
        field(31; "C/B of glaze on lines(MT)"; Decimal)
        {
        }
        field(32; "Actual glaze consumption(MT)"; Decimal)
        {
        }
        field(33; "O/B of tiles(sqm)"; Decimal)
        {
        }
        field(34; "Tiles issued to sorting(sqm)"; Decimal)
        {
        }
        field(35; "Green glazed pitcher(sqm)"; Decimal)
        {
        }
        field(36; "Fired pitcher(sqm) kiln"; Decimal)
        {
        }
        field(37; "C/B of tiles(sqm) RHK"; Decimal)
        {
        }
        field(38; "O/B of tiles(sqm)."; Decimal)
        {
        }
        field(39; "Tiles received from RHK(sqm)"; Decimal)
        {
        }
        field(40; "Fired pitcher(sqm)"; Decimal)
        {
        }
        field(41; "Short size(sqm)"; Decimal)
        {
        }
        field(42; "Assorted Sample(sqm)-Warehouse"; Decimal)
        {
        }
        field(43; "C/B of tiles(sqm) Sort Pack FG"; Decimal)
        {
        }
        field(44; "Tiles sent to W/H(sqm)"; Decimal)
        {
        }
        field(45; "Prem.(sqm)"; Decimal)
        {
        }
        field(46; "Com.(sqm)"; Decimal)
        {
        }
        field(47; "Pit.(sqm)"; Decimal)
        {
        }
        field(48; "Green glazed pitcher(sqm)."; Decimal)
        {
        }
        field(49; "C/B of tiles(sqm) Fire FG Pol."; Decimal)
        {
        }
        field(50; "Printed/Plain"; Decimal)
        {
        }
        field(51; "Eco.(sqm)"; Decimal)
        {
        }
        field(52; "Power-GE"; Decimal)
        {
        }
        field(53; "Power-DG"; Decimal)
        {
        }
        field(54; "Power-EB"; Decimal)
        {
        }
        field(55; "Power-Total"; Decimal)
        {
        }
        field(56; "Gas-GE"; Decimal)
        {
        }
        field(57; "Gas-Dryer"; Decimal)
        {
        }
        field(58; "Gas-Kiln"; Decimal)
        {
        }
        field(59; "Gas-Spray Dryer MF"; Decimal)
        {
        }
        field(60; "Gas-Spray Dryer MP"; Decimal)
        {
        }
        field(61; "Gas-Total"; Decimal)
        {
        }
        field(62; Production; Boolean)
        {
        }
        field(63; "Gas Price Per Unit"; Decimal)
        {
        }
        field(64; "Power EB  Price Per Unit"; Decimal)
        {
        }
        field(65; "Power DG Per Unit"; Decimal)
        {
        }
        field(66; "Saw Dust Total"; Decimal)
        {
        }
        field(67; "Coal Total"; Decimal)
        {
        }
        field(68; "Saw Dust Price per Unit"; Decimal)
        {
        }
        field(69; "Coal Price Per Unit"; Decimal)
        {
        }
        field(70; "Klin Gap"; Decimal)
        {
        }
        field(71; "Line Capecity"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Production Line", Date, Size)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record 349;
}

