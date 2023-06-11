report 50298 "Datewise Booking & Releasing"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DatewiseBookingReleasing.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(Customer_Zone; Customer."Tableau Zone")
            {
            }
            column(TerritoryCode_Customer; Customer."Territory Code")
            {
            }
            column(AsonDate; FORMAT(AsonDate, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(MnthStartDate; FORMAT(MnthStartDate, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(MnthEndDate; FORMAT(MnthEndDate, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue1; FORMAT(DateValue[1], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue2; FORMAT(DateValue[2], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue3; FORMAT(DateValue[3], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue4; FORMAT(DateValue[4], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue5; FORMAT(DateValue[5], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue6; FORMAT(DateValue[6], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue7; FORMAT(DateValue[7], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue8; FORMAT(DateValue[8], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue9; FORMAT(DateValue[9], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue10; FORMAT(DateValue[10], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue11; FORMAT(DateValue[11], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue12; FORMAT(DateValue[12], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue13; FORMAT(DateValue[13], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue14; FORMAT(DateValue[14], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue15; FORMAT(DateValue[15], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue16; FORMAT(DateValue[16], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue17; FORMAT(DateValue[17], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue18; FORMAT(DateValue[18], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue19; FORMAT(DateValue[19], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue20; FORMAT(DateValue[20], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue21; FORMAT(DateValue[21], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue22; FORMAT(DateValue[22], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue23; FORMAT(DateValue[23], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue24; FORMAT(DateValue[24], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue25; FORMAT(DateValue[25], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue26; FORMAT(DateValue[26], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue27; FORMAT(DateValue[27], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue28; FORMAT(DateValue[28], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue29; FORMAT(DateValue[29], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue30; FORMAT(DateValue[30], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DateValue31; FORMAT(DateValue[31], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = FILTER("Order"));
                column(PendingOpenOrders; (PendingOpenOrders + TRDPendingOpenOrders) / 100000)
                {
                }
                column(PendingReleasedOrders; (SKDPReleasedOrders + DepotPReleasedOrders + TRDPReleasedOrders) / 100000)
                {
                }
                column(BookedAmt1; SKDBookedAmt[1] / 100000)
                {
                }
                column(BookedAmt2; SKDBookedAmt[2] / 100000)
                {
                }
                column(BookedAmt3; SKDBookedAmt[3] / 100000)
                {
                }
                column(BookedAmt4; SKDBookedAmt[4] / 100000)
                {
                }
                column(BookedAmt5; SKDBookedAmt[5] / 100000)
                {
                }
                column(BookedAmt6; SKDBookedAmt[6] / 100000)
                {
                }
                column(BookedAmt7; SKDBookedAmt[7] / 100000)
                {
                }
                column(BookedAmt8; SKDBookedAmt[8] / 100000)
                {
                }
                column(BookedAmt9; SKDBookedAmt[9] / 100000)
                {
                }
                column(BookedAmt10; SKDBookedAmt[10] / 100000)
                {
                }
                column(BookedAmt11; SKDBookedAmt[11] / 100000)
                {
                }
                column(BookedAmt12; SKDBookedAmt[12] / 100000)
                {
                }
                column(BookedAmt13; SKDBookedAmt[13] / 100000)
                {
                }
                column(BookedAmt14; SKDBookedAmt[14] / 100000)
                {
                }
                column(BookedAmt15; SKDBookedAmt[15] / 100000)
                {
                }
                column(BookedAmt16; SKDBookedAmt[16] / 100000)
                {
                }
                column(BookedAmt17; SKDBookedAmt[17] / 100000)
                {
                }
                column(BookedAmt18; SKDBookedAmt[18] / 100000)
                {
                }
                column(BookedAmt19; SKDBookedAmt[19] / 100000)
                {
                }
                column(BookedAmt20; SKDBookedAmt[20] / 100000)
                {
                }
                column(BookedAmt21; SKDBookedAmt[21] / 100000)
                {
                }
                column(BookedAmt22; SKDBookedAmt[22] / 100000)
                {
                }
                column(BookedAmt23; SKDBookedAmt[23] / 100000)
                {
                }
                column(BookedAmt24; SKDBookedAmt[24] / 100000)
                {
                }
                column(BookedAmt25; SKDBookedAmt[25] / 100000)
                {
                }
                column(BookedAmt26; SKDBookedAmt[26] / 100000)
                {
                }
                column(BookedAmt27; SKDBookedAmt[27] / 100000)
                {
                }
                column(BookedAmt28; SKDBookedAmt[28] / 100000)
                {
                }
                column(BookedAmt29; SKDBookedAmt[29] / 100000)
                {
                }
                column(BookedAmt30; SKDBookedAmt[30] / 100000)
                {
                }
                column(BookedAmt31; SKDBookedAmt[31] / 100000)
                {
                }
                column(BookedQty1; SKDBookedQty[1])
                {
                }
                column(BookedQty2; SKDBookedQty[2])
                {
                }
                column(BookedQty3; SKDBookedQty[3])
                {
                }
                column(BookedQty4; SKDBookedQty[4])
                {
                }
                column(BookedQty5; SKDBookedQty[5])
                {
                }
                column(BookedQty6; SKDBookedQty[6])
                {
                }
                column(BookedQty7; SKDBookedQty[7])
                {
                }
                column(BookedQty8; SKDBookedQty[8])
                {
                }
                column(BookedQty9; SKDBookedQty[9])
                {
                }
                column(BookedQty10; SKDBookedQty[10])
                {
                }
                column(BookedQty11; SKDBookedQty[11])
                {
                }
                column(BookedQty12; SKDBookedQty[12])
                {
                }
                column(BookedQty13; SKDBookedQty[13])
                {
                }
                column(BookedQty14; SKDBookedQty[14])
                {
                }
                column(BookedQty15; SKDBookedQty[15])
                {
                }
                column(BookedQty16; SKDBookedQty[16])
                {
                }
                column(BookedQty17; SKDBookedQty[17])
                {
                }
                column(BookedQty18; SKDBookedQty[18])
                {
                }
                column(BookedQty19; SKDBookedQty[19])
                {
                }
                column(BookedQty20; SKDBookedQty[20])
                {
                }
                column(BookedQty21; SKDBookedQty[21])
                {
                }
                column(BookedQty22; SKDBookedQty[22])
                {
                }
                column(BookedQty23; SKDBookedQty[23])
                {
                }
                column(BookedQty24; SKDBookedQty[24])
                {
                }
                column(BookedQty25; SKDBookedQty[25])
                {
                }
                column(BookedQty26; SKDBookedQty[26])
                {
                }
                column(BookedQty27; SKDBookedQty[27])
                {
                }
                column(BookedQty28; SKDBookedQty[28])
                {
                }
                column(BookedQty29; SKDBookedQty[29])
                {
                }
                column(BookedQty30; SKDBookedQty[30])
                {
                }
                column(BookedQty31; SKDBookedQty[31])
                {
                }
                column(ReleasedAmt1; (SKDRAmt[1] + TRDRAmt[1] + DepotRAmt[1]) / 100000)
                {
                }
                column(ReleasedAmt2; (SKDRAmt[2] + TRDRAmt[2] + DepotRAmt[2]) / 100000)
                {
                }
                column(ReleasedAmt3; (SKDRAmt[3] + TRDRAmt[3] + DepotRAmt[3]) / 100000)
                {
                }
                column(ReleasedAmt4; (SKDRAmt[4] + TRDRAmt[4] + DepotRAmt[4]) / 100000)
                {
                }
                column(ReleasedAmt5; (SKDRAmt[5] + TRDRAmt[5] + DepotRAmt[5]) / 100000)
                {
                }
                column(ReleasedAmt6; (SKDRAmt[6] + TRDRAmt[6] + DepotRAmt[6]) / 100000)
                {
                }
                column(ReleasedAmt7; (SKDRAmt[7] + TRDRAmt[7] + DepotRAmt[7]) / 100000)
                {
                }
                column(ReleasedAmt8; (SKDRAmt[8] + TRDRAmt[8] + DepotRAmt[8]) / 100000)
                {
                }
                column(ReleasedAmt9; (SKDRAmt[9] + TRDRAmt[9] + DepotRAmt[9]) / 100000)
                {
                }
                column(ReleasedAmt10; (SKDRAmt[10] + TRDRAmt[10] + DepotRAmt[10]) / 100000)
                {
                }
                column(ReleasedAmt11; (SKDRAmt[11] + TRDRAmt[11] + DepotRAmt[11]) / 100000)
                {
                }
                column(ReleasedAmt12; (SKDRAmt[12] + TRDRAmt[12] + DepotRAmt[12]) / 100000)
                {
                }
                column(ReleasedAmt13; (SKDRAmt[13] + TRDRAmt[13] + DepotRAmt[13]) / 100000)
                {
                }
                column(ReleasedAmt14; (SKDRAmt[14] + TRDRAmt[14] + DepotRAmt[14]) / 100000)
                {
                }
                column(ReleasedAmt15; (SKDRAmt[15] + TRDRAmt[15] + DepotRAmt[15]) / 100000)
                {
                }
                column(ReleasedAmt16; (SKDRAmt[16] + TRDRAmt[16] + DepotRAmt[16]) / 100000)
                {
                }
                column(ReleasedAmt17; (SKDRAmt[17] + TRDRAmt[17] + DepotRAmt[17]) / 100000)
                {
                }
                column(ReleasedAmt18; (SKDRAmt[18] + TRDRAmt[18] + DepotRAmt[18]) / 100000)
                {
                }
                column(ReleasedAmt19; (SKDRAmt[19] + TRDRAmt[19] + DepotRAmt[19]) / 100000)
                {
                }
                column(ReleasedAmt20; (SKDRAmt[20] + TRDRAmt[20] + DepotRAmt[20]) / 100000)
                {
                }
                column(ReleasedAmt21; (SKDRAmt[21] + TRDRAmt[21] + DepotRAmt[21]) / 100000)
                {
                }
                column(ReleasedAmt22; (SKDRAmt[22] + TRDRAmt[22] + DepotRAmt[22]) / 100000)
                {
                }
                column(ReleasedAmt23; (SKDRAmt[23] + TRDRAmt[23] + DepotRAmt[23]) / 100000)
                {
                }
                column(ReleasedAmt24; (SKDRAmt[24] + TRDRAmt[24] + DepotRAmt[24]) / 100000)
                {
                }
                column(ReleasedAmt25; (SKDRAmt[25] + TRDRAmt[25] + DepotRAmt[25]) / 100000)
                {
                }
                column(ReleasedAmt26; (SKDRAmt[26] + TRDRAmt[26] + DepotRAmt[26]) / 100000)
                {
                }
                column(ReleasedAmt27; (SKDRAmt[27] + TRDRAmt[27] + DepotRAmt[27]) / 100000)
                {
                }
                column(ReleasedAmt28; (SKDRAmt[28] + TRDRAmt[28] + DepotRAmt[28]) / 100000)
                {
                }
                column(ReleasedAmt29; (SKDRAmt[29] + TRDRAmt[29] + DepotRAmt[29]) / 100000)
                {
                }
                column(ReleasedAmt30; (SKDRAmt[30] + TRDRAmt[30] + DepotRAmt[30]) / 100000)
                {
                }
                column(ReleasedAmt31; (SKDRAmt[31] + TRDRAmt[31] + DepotRAmt[31]) / 100000)
                {
                }
                column(ReleasedQty1; SKDRQty[1] + TRDRQty[1] + DepotRQty[1])
                {
                }
                column(ReleasedQty2; SKDRQty[2] + TRDRQty[2] + DepotRQty[2])
                {
                }
                column(ReleasedQty3; SKDRQty[3] + TRDRQty[3] + DepotRQty[3])
                {
                }
                column(ReleasedQty4; SKDRQty[4] + TRDRQty[4] + DepotRQty[4])
                {
                }
                column(ReleasedQty5; SKDRQty[5] + TRDRQty[5] + DepotRQty[5])
                {
                }
                column(ReleasedQty6; SKDRQty[6] + TRDRQty[6] + DepotRQty[6])
                {
                }
                column(ReleasedQty7; SKDRQty[7] + TRDRQty[7] + DepotRQty[7])
                {
                }
                column(ReleasedQty8; SKDRQty[8] + TRDRQty[8] + DepotRQty[8])
                {
                }
                column(ReleasedQty9; SKDRQty[9] + TRDRQty[9] + DepotRQty[9])
                {
                }
                column(ReleasedQty10; SKDRQty[10] + TRDRQty[10] + DepotRQty[10])
                {
                }
                column(ReleasedQty11; SKDRQty[11] + TRDRQty[11] + DepotRQty[11])
                {
                }
                column(ReleasedQty12; SKDRQty[12] + TRDRQty[12] + DepotRQty[12])
                {
                }
                column(ReleasedQty13; SKDRQty[13] + TRDRQty[13] + DepotRQty[13])
                {
                }
                column(ReleasedQty14; SKDRQty[14] + TRDRQty[14] + DepotRQty[14])
                {
                }
                column(ReleasedQty15; SKDRQty[15] + TRDRQty[15] + DepotRQty[15])
                {
                }
                column(ReleasedQty16; SKDRQty[16] + TRDRQty[16] + DepotRQty[16])
                {
                }
                column(ReleasedQty17; SKDRQty[17] + TRDRQty[17] + DepotRQty[17])
                {
                }
                column(ReleasedQty18; SKDRQty[18] + TRDRQty[18] + DepotRQty[18])
                {
                }
                column(ReleasedQty19; SKDRQty[19] + TRDRQty[19] + DepotRQty[19])
                {
                }
                column(ReleasedQty20; SKDRQty[20] + TRDRQty[20] + DepotRQty[20])
                {
                }
                column(ReleasedQty21; SKDRQty[21] + TRDRQty[21] + DepotRQty[21])
                {
                }
                column(ReleasedQty22; SKDRQty[22] + TRDRQty[22] + DepotRQty[22])
                {
                }
                column(ReleasedQty23; SKDRQty[23] + TRDRQty[23] + DepotRQty[23])
                {
                }
                column(ReleasedQty24; SKDRQty[24] + TRDRQty[24] + DepotRQty[24])
                {
                }
                column(ReleasedQty25; SKDRQty[25] + TRDRQty[25] + DepotRQty[25])
                {
                }
                column(ReleasedQty26; SKDRQty[26] + TRDRQty[26] + DepotRQty[26])
                {
                }
                column(ReleasedQty27; SKDRQty[27] + TRDRQty[27] + DepotRQty[27])
                {
                }
                column(ReleasedQty28; SKDRQty[28] + TRDRQty[28] + DepotRQty[28])
                {
                }
                column(ReleasedQty29; SKDRQty[29] + TRDRQty[29] + DepotRQty[29])
                {
                }
                column(ReleasedQty30; SKDRQty[30] + TRDRQty[30] + DepotRQty[30])
                {
                }
                column(ReleasedQty31; SKDRQty[31] + TRDRQty[31] + DepotRQty[31])
                {
                }
                column(PendingToReleaseAmt1; (SPToRAmt[1] + TPToRAmt[1] + DPToRAmt[1]) / 100000)
                {
                }
                column(PendingToReleaseAmt2; (SPToRAmt[2] + TPToRAmt[2] + DPToRAmt[2]) / 100000)
                {
                }
                column(PendingToReleaseAmt3; (SPToRAmt[3] + TPToRAmt[3] + DPToRAmt[3]) / 100000)
                {
                }
                column(PendingToReleaseAmt4; (SPToRAmt[4] + TPToRAmt[4] + DPToRAmt[4]) / 100000)
                {
                }
                column(PendingToReleaseAmt5; (SPToRAmt[5] + TPToRAmt[5] + DPToRAmt[5]) / 100000)
                {
                }
                column(PendingToReleaseAmt6; (SPToRAmt[6] + TPToRAmt[6] + DPToRAmt[6]) / 100000)
                {
                }
                column(PendingToReleaseAmt7; (SPToRAmt[7] + TPToRAmt[7] + DPToRAmt[7]) / 100000)
                {
                }
                column(PendingToReleaseAmt8; (SPToRAmt[8] + TPToRAmt[8] + DPToRAmt[8]) / 100000)
                {
                }
                column(PendingToReleaseAmt9; (SPToRAmt[9] + TPToRAmt[9] + DPToRAmt[9]) / 100000)
                {
                }
                column(PendingToReleaseAmt10; (SPToRAmt[10] + TPToRAmt[10] + DPToRAmt[10]) / 100000)
                {
                }
                column(PendingToReleaseAmt11; (SPToRAmt[11] + TPToRAmt[11] + DPToRAmt[11]) / 100000)
                {
                }
                column(PendingToReleaseAmt12; (SPToRAmt[12] + TPToRAmt[12] + DPToRAmt[12]) / 100000)
                {
                }
                column(PendingToReleaseAmt13; (SPToRAmt[13] + TPToRAmt[13] + DPToRAmt[13]) / 100000)
                {
                }
                column(PendingToReleaseAmt14; (SPToRAmt[14] + TPToRAmt[14] + DPToRAmt[14]) / 100000)
                {
                }
                column(PendingToReleaseAmt15; (SPToRAmt[15] + TPToRAmt[15] + DPToRAmt[15]) / 100000)
                {
                }
                column(PendingToReleaseAmt16; (SPToRAmt[16] + TPToRAmt[16] + DPToRAmt[16]) / 100000)
                {
                }
                column(PendingToReleaseAmt17; (SPToRAmt[17] + TPToRAmt[17] + DPToRAmt[17]) / 100000)
                {
                }
                column(PendingToReleaseAmt18; (SPToRAmt[18] + TPToRAmt[18] + DPToRAmt[18]) / 100000)
                {
                }
                column(PendingToReleaseAmt19; (SPToRAmt[19] + TPToRAmt[19] + DPToRAmt[19]) / 100000)
                {
                }
                column(PendingToReleaseAmt20; (SPToRAmt[20] + TPToRAmt[20] + DPToRAmt[20]) / 100000)
                {
                }
                column(PendingToReleaseAmt21; (SPToRAmt[21] + TPToRAmt[21] + DPToRAmt[21]) / 100000)
                {
                }
                column(PendingToReleaseAmt22; (SPToRAmt[22] + TPToRAmt[22] + DPToRAmt[22]) / 100000)
                {
                }
                column(PendingToReleaseAmt23; (SPToRAmt[23] + TPToRAmt[23] + DPToRAmt[23]) / 100000)
                {
                }
                column(PendingToReleaseAmt24; (SPToRAmt[24] + TPToRAmt[24] + DPToRAmt[24]) / 100000)
                {
                }
                column(PendingToReleaseAmt25; (SPToRAmt[25] + TPToRAmt[25] + DPToRAmt[25]) / 100000)
                {
                }
                column(PendingToReleaseAmt26; (SPToRAmt[26] + TPToRAmt[26] + DPToRAmt[26]) / 100000)
                {
                }
                column(PendingToReleaseAmt27; (SPToRAmt[27] + TPToRAmt[27] + DPToRAmt[27]) / 100000)
                {
                }
                column(PendingToReleaseAmt28; (SPToRAmt[28] + TPToRAmt[28] + DPToRAmt[28]) / 100000)
                {
                }
                column(PendingToReleaseAmt29; (SPToRAmt[29] + TPToRAmt[29] + DPToRAmt[29]) / 100000)
                {
                }
                column(PendingToReleaseAmt30; (SPToRAmt[30] + TPToRAmt[30] + DPToRAmt[30]) / 100000)
                {
                }
                column(PendingToReleaseAmt31; (SPToRAmt[31] + TPToRAmt[31] + DPToRAmt[31]) / 100000)
                {
                }
                column(PendingToReleaseQty1; SPToRQty[1] + TPToRQty[1] + DPToRQty[1])
                {
                }
                column(PendingToReleaseQty2; SPToRQty[2] + TPToRQty[2] + DPToRQty[2])
                {
                }
                column(PendingToReleaseQty3; SPToRQty[3] + TPToRQty[3] + DPToRQty[3])
                {
                }
                column(PendingToReleaseQty4; SPToRQty[4] + TPToRQty[4] + DPToRQty[4])
                {
                }
                column(PendingToReleaseQty5; SPToRQty[5] + TPToRQty[5] + DPToRQty[5])
                {
                }
                column(PendingToReleaseQty6; SPToRQty[6] + TPToRQty[6] + DPToRQty[6])
                {
                }
                column(PendingToReleaseQty7; SPToRQty[7] + TPToRQty[7] + DPToRQty[7])
                {
                }
                column(PendingToReleaseQty8; SPToRQty[8] + TPToRQty[8] + DPToRQty[8])
                {
                }
                column(PendingToReleaseQty9; SPToRQty[9] + TPToRQty[9] + DPToRQty[9])
                {
                }
                column(PendingToReleaseQty10; SPToRQty[10] + TPToRQty[10] + DPToRQty[10])
                {
                }
                column(PendingToReleaseQty11; SPToRQty[11] + TPToRQty[11] + DPToRQty[11])
                {
                }
                column(PendingToReleaseQty12; SPToRQty[12] + TPToRQty[12] + DPToRQty[12])
                {
                }
                column(PendingToReleaseQty13; SPToRQty[13] + TPToRQty[13] + DPToRQty[13])
                {
                }
                column(PendingToReleaseQty14; SPToRQty[14] + TPToRQty[14] + DPToRQty[14])
                {
                }
                column(PendingToReleaseQty15; SPToRQty[15] + TPToRQty[15] + DPToRQty[15])
                {
                }
                column(PendingToReleaseQty16; SPToRQty[16] + TPToRQty[16] + DPToRQty[16])
                {
                }
                column(PendingToReleaseQty17; SPToRQty[17] + TPToRQty[17] + DPToRQty[17])
                {
                }
                column(PendingToReleaseQty18; SPToRQty[18] + TPToRQty[18] + DPToRQty[18])
                {
                }
                column(PendingToReleaseQty19; SPToRQty[19] + TPToRQty[19] + DPToRQty[19])
                {
                }
                column(PendingToReleaseQty20; SPToRQty[20] + TPToRQty[20] + DPToRQty[20])
                {
                }
                column(PendingToReleaseQty21; SPToRQty[21] + TPToRQty[21] + DPToRQty[21])
                {
                }
                column(PendingToReleaseQty22; SPToRQty[22] + TPToRQty[22] + DPToRQty[22])
                {
                }
                column(PendingToReleaseQty23; SPToRQty[23] + TPToRQty[23] + DPToRQty[23])
                {
                }
                column(PendingToReleaseQty24; SPToRQty[24] + TPToRQty[24] + DPToRQty[24])
                {
                }
                column(PendingToReleaseQty25; SPToRQty[25] + TPToRQty[25] + DPToRQty[25])
                {
                }
                column(PendingToReleaseQty26; SPToRQty[26] + TPToRQty[26] + DPToRQty[26])
                {
                }
                column(PendingToReleaseQty27; SPToRQty[27] + TPToRQty[27] + DPToRQty[27])
                {
                }
                column(PendingToReleaseQty28; SPToRQty[28] + TPToRQty[28] + DPToRQty[28])
                {
                }
                column(PendingToReleaseQty29; SPToRQty[29] + TPToRQty[29] + DPToRQty[29])
                {
                }
                column(PendingToReleaseQty30; SPToRQty[30] + TPToRQty[30] + DPToRQty[30])
                {
                }
                column(PendingToReleaseQty31; SPToRQty[31] + TPToRQty[31] + DPToRQty[31])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PendingOpenOrders);
                    CLEAR(TRDPendingOpenOrders);
                    CLEAR(SKDPReleasedOrders);
                    CLEAR(DepotPReleasedOrders);
                    CLEAR(TRDPReleasedOrders);
                    //IF (DT2DATE("Sales Header"."Make Order Date")<=MnthEndDate) AND ("Sales Header".Status = "Sales Header".Status::Open) THEN BEGIN
                    IF (DT2DATE("Sales Header"."Make Order Date") <= MnthEndDate) AND ("Sales Header".Status <> "Sales Header".Status::Released) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER') THEN BEGIN
                                    PendingOpenOrders += SalesLine."Outstanding Amount";
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;

                    IF (DT2DATE("Sales Header"."Make Order Date") <= MnthEndDate) AND ("Sales Header"."Payment Date 3" = 0D) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF (SalesLine."Location Code" = 'DP-MORBI') OR (SalesLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    TRDPendingOpenOrders += SalesLine."Outstanding Amount";
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;

                    IF ("Sales Header"."Releasing Date" <= MnthEndDate) AND ("Sales Header".Status = "Sales Header".Status::Released) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF SalesLine."Location Code" IN ['SKD-WH-MFG', 'HSK-WH-MFG', 'DRA-WH-MFG'] THEN BEGIN
                                    SKDPReleasedOrders += SalesLine."Outstanding Amount";
                                END;
                                IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER')
                                AND (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    DepotPReleasedOrders += SalesLine."Outstanding Amount";
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;

                    IF ("Sales Header"."Payment Date 3" > 0D) AND (DT2DATE("Sales Header"."Make Order Date") <= MnthEndDate) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF (SalesLine."Location Code" = 'DP-MORBI') OR (SalesLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    TRDPReleasedOrders += SalesLine."Outstanding Amount";
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;


                    CLEAR(SKDBookedAmt);
                    CLEAR(SKDBookedQty);
                    CLEAR(SKDRAmt);
                    CLEAR(SKDRQty);
                    CLEAR(TRDRAmt);
                    CLEAR(TRDRQty);
                    CLEAR(DepotRAmt);
                    CLEAR(DepotRQty);
                    CLEAR(SPToRAmt);
                    CLEAR(SPToRQty);
                    CLEAR(TPToRAmt);
                    CLEAR(TPToRQty);
                    CLEAR(DPToRAmt);
                    CLEAR(DPToRQty);

                    IF (DT2DATE("Sales Header"."Make Order Date") >= MnthStartDate) AND (DT2DATE("Sales Header"."Make Order Date") <= MnthEndDate) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[1] THEN BEGIN
                                    SKDBookedAmt[1] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[1] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[2] THEN BEGIN
                                    SKDBookedAmt[2] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[2] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[3] THEN BEGIN
                                    SKDBookedAmt[3] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[3] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[4] THEN BEGIN
                                    SKDBookedAmt[4] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[4] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[5] THEN BEGIN
                                    SKDBookedAmt[5] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[5] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[6] THEN BEGIN
                                    SKDBookedAmt[6] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[6] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[7] THEN BEGIN
                                    SKDBookedAmt[7] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[7] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[8] THEN BEGIN
                                    SKDBookedAmt[8] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[8] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[9] THEN BEGIN
                                    SKDBookedAmt[9] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[9] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[10] THEN BEGIN
                                    SKDBookedAmt[10] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[10] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[11] THEN BEGIN
                                    SKDBookedAmt[11] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[11] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[12] THEN BEGIN
                                    SKDBookedAmt[12] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[12] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[13] THEN BEGIN
                                    SKDBookedAmt[13] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[13] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[14] THEN BEGIN
                                    SKDBookedAmt[14] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[14] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[15] THEN BEGIN
                                    SKDBookedAmt[15] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[15] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[16] THEN BEGIN
                                    SKDBookedAmt[16] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[16] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[17] THEN BEGIN
                                    SKDBookedAmt[17] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[17] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[18] THEN BEGIN
                                    SKDBookedAmt[18] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[18] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[19] THEN BEGIN
                                    SKDBookedAmt[19] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[19] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[20] THEN BEGIN
                                    SKDBookedAmt[20] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[20] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[21] THEN BEGIN
                                    SKDBookedAmt[21] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[21] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[22] THEN BEGIN
                                    SKDBookedAmt[22] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[22] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[23] THEN BEGIN
                                    SKDBookedAmt[23] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[23] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[24] THEN BEGIN
                                    SKDBookedAmt[24] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[24] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[25] THEN BEGIN
                                    SKDBookedAmt[25] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[25] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[26] THEN BEGIN
                                    SKDBookedAmt[26] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[26] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[27] THEN BEGIN
                                    SKDBookedAmt[27] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[27] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[28] THEN BEGIN
                                    SKDBookedAmt[28] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[28] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[29] THEN BEGIN
                                    SKDBookedAmt[29] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[29] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[30] THEN BEGIN
                                    SKDBookedAmt[30] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[30] += SalesLine."Outstanding Qty. (Base)";
                                END;
                                IF DT2DATE("Sales Header"."Make Order Date") = DateValue[31] THEN BEGIN
                                    SKDBookedAmt[31] += SalesLine."Outstanding Amount";
                                    SKDBookedQty[31] += SalesLine."Outstanding Qty. (Base)";
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;

                    IF ("Sales Header"."Releasing Date" >= MnthStartDate) AND ("Sales Header"."Releasing Date" <= MnthEndDate) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF SalesLine."Location Code" IN ['SKD-WH-MFG', 'HSK-WH-MFG', 'DRA-WH-MFG'] THEN BEGIN
                                    IF "Sales Header"."Releasing Date" = DateValue[1] THEN BEGIN
                                        SKDRAmt[1] += SalesLine."Outstanding Amount";
                                        SKDRQty[1] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[2] THEN BEGIN
                                        SKDRAmt[2] += SalesLine."Outstanding Amount";
                                        SKDRQty[2] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[3] THEN BEGIN
                                        SKDRAmt[3] += SalesLine."Outstanding Amount";
                                        SKDRQty[3] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[4] THEN BEGIN
                                        SKDRAmt[4] += SalesLine."Outstanding Amount";
                                        SKDRQty[4] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[5] THEN BEGIN
                                        SKDRAmt[5] += SalesLine."Outstanding Amount";
                                        SKDRQty[5] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[6] THEN BEGIN
                                        SKDRAmt[6] += SalesLine."Outstanding Amount";
                                        SKDRQty[6] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[7] THEN BEGIN
                                        SKDRAmt[7] += SalesLine."Outstanding Amount";
                                        SKDRQty[7] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[8] THEN BEGIN
                                        SKDRAmt[8] += SalesLine."Outstanding Amount";
                                        SKDRQty[8] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[9] THEN BEGIN
                                        SKDRAmt[9] += SalesLine."Outstanding Amount";
                                        SKDRQty[9] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[10] THEN BEGIN
                                        SKDRAmt[10] += SalesLine."Outstanding Amount";
                                        SKDRQty[10] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[11] THEN BEGIN
                                        SKDRAmt[11] += SalesLine."Outstanding Amount";
                                        SKDRQty[11] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[12] THEN BEGIN
                                        SKDRAmt[12] += SalesLine."Outstanding Amount";
                                        SKDRQty[12] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[13] THEN BEGIN
                                        SKDRAmt[13] += SalesLine."Outstanding Amount";
                                        SKDRQty[13] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[14] THEN BEGIN
                                        SKDRAmt[14] += SalesLine."Outstanding Amount";
                                        SKDRQty[14] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[15] THEN BEGIN
                                        SKDRAmt[15] += SalesLine."Outstanding Amount";
                                        SKDRQty[15] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[16] THEN BEGIN
                                        SKDRAmt[16] += SalesLine."Outstanding Amount";
                                        SKDRQty[16] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[17] THEN BEGIN
                                        SKDRAmt[17] += SalesLine."Outstanding Amount";
                                        SKDRQty[17] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[18] THEN BEGIN
                                        SKDRAmt[18] += SalesLine."Outstanding Amount";
                                        SKDRQty[18] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[19] THEN BEGIN
                                        SKDRAmt[19] += SalesLine."Outstanding Amount";
                                        SKDRQty[19] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[20] THEN BEGIN
                                        SKDRAmt[20] += SalesLine."Outstanding Amount";
                                        SKDRQty[20] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[21] THEN BEGIN
                                        SKDRAmt[21] += SalesLine."Outstanding Amount";
                                        SKDRQty[21] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[22] THEN BEGIN
                                        SKDRAmt[22] += SalesLine."Outstanding Amount";
                                        SKDRQty[22] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[23] THEN BEGIN
                                        SKDRAmt[23] += SalesLine."Outstanding Amount";
                                        SKDRQty[23] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[24] THEN BEGIN
                                        SKDRAmt[24] += SalesLine."Outstanding Amount";
                                        SKDRQty[24] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[25] THEN BEGIN
                                        SKDRAmt[25] += SalesLine."Outstanding Amount";
                                        SKDRQty[25] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[26] THEN BEGIN
                                        SKDRAmt[26] += SalesLine."Outstanding Amount";
                                        SKDRQty[26] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[27] THEN BEGIN
                                        SKDRAmt[27] += SalesLine."Outstanding Amount";
                                        SKDRQty[27] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[28] THEN BEGIN
                                        SKDRAmt[28] += SalesLine."Outstanding Amount";
                                        SKDRQty[28] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[29] THEN BEGIN
                                        SKDRAmt[29] += SalesLine."Outstanding Amount";
                                        SKDRQty[29] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[30] THEN BEGIN
                                        SKDRAmt[30] += SalesLine."Outstanding Amount";
                                        SKDRQty[30] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[31] THEN BEGIN
                                        SKDRAmt[31] += SalesLine."Outstanding Amount";
                                        SKDRQty[31] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;

                                IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER')
                                AND (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    IF "Sales Header"."Releasing Date" = DateValue[1] THEN BEGIN
                                        DepotRAmt[1] += SalesLine."Outstanding Amount";
                                        DepotRQty[1] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[2] THEN BEGIN
                                        DepotRAmt[2] += SalesLine."Outstanding Amount";
                                        DepotRQty[2] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[3] THEN BEGIN
                                        DepotRAmt[3] += SalesLine."Outstanding Amount";
                                        DepotRQty[3] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[4] THEN BEGIN
                                        DepotRAmt[4] += SalesLine."Outstanding Amount";
                                        DepotRQty[4] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[5] THEN BEGIN
                                        DepotRAmt[5] += SalesLine."Outstanding Amount";
                                        DepotRQty[5] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[6] THEN BEGIN
                                        DepotRAmt[6] += SalesLine."Outstanding Amount";
                                        DepotRQty[6] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[7] THEN BEGIN
                                        DepotRAmt[7] += SalesLine."Outstanding Amount";
                                        DepotRQty[7] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[8] THEN BEGIN
                                        DepotRAmt[8] += SalesLine."Outstanding Amount";
                                        DepotRQty[8] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[9] THEN BEGIN
                                        DepotRAmt[9] += SalesLine."Outstanding Amount";
                                        DepotRQty[9] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[10] THEN BEGIN
                                        DepotRAmt[10] += SalesLine."Outstanding Amount";
                                        DepotRQty[10] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[11] THEN BEGIN
                                        DepotRAmt[11] += SalesLine."Outstanding Amount";
                                        DepotRQty[11] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[12] THEN BEGIN
                                        DepotRAmt[12] += SalesLine."Outstanding Amount";
                                        DepotRQty[12] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[13] THEN BEGIN
                                        DepotRAmt[13] += SalesLine."Outstanding Amount";
                                        DepotRQty[13] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[14] THEN BEGIN
                                        DepotRAmt[14] += SalesLine."Outstanding Amount";
                                        DepotRQty[14] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[15] THEN BEGIN
                                        DepotRAmt[15] += SalesLine."Outstanding Amount";
                                        DepotRQty[15] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[16] THEN BEGIN
                                        DepotRAmt[16] += SalesLine."Outstanding Amount";
                                        DepotRQty[16] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[17] THEN BEGIN
                                        DepotRAmt[17] += SalesLine."Outstanding Amount";
                                        DepotRQty[17] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[18] THEN BEGIN
                                        DepotRAmt[18] += SalesLine."Outstanding Amount";
                                        DepotRQty[18] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[19] THEN BEGIN
                                        DepotRAmt[19] += SalesLine."Outstanding Amount";
                                        DepotRQty[19] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[20] THEN BEGIN
                                        DepotRAmt[20] += SalesLine."Outstanding Amount";
                                        DepotRQty[20] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[21] THEN BEGIN
                                        DepotRAmt[21] += SalesLine."Outstanding Amount";
                                        DepotRQty[21] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[22] THEN BEGIN
                                        DepotRAmt[22] += SalesLine."Outstanding Amount";
                                        DepotRQty[22] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[23] THEN BEGIN
                                        DepotRAmt[23] += SalesLine."Outstanding Amount";
                                        DepotRQty[23] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[24] THEN BEGIN
                                        DepotRAmt[24] += SalesLine."Outstanding Amount";
                                        DepotRQty[24] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[25] THEN BEGIN
                                        DepotRAmt[25] += SalesLine."Outstanding Amount";
                                        DepotRQty[25] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[26] THEN BEGIN
                                        DepotRAmt[26] += SalesLine."Outstanding Amount";
                                        DepotRQty[26] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[27] THEN BEGIN
                                        DepotRAmt[27] += SalesLine."Outstanding Amount";
                                        DepotRQty[27] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[28] THEN BEGIN
                                        DepotRAmt[28] += SalesLine."Outstanding Amount";
                                        DepotRQty[28] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[29] THEN BEGIN
                                        DepotRAmt[29] += SalesLine."Outstanding Amount";
                                        DepotRQty[29] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[30] THEN BEGIN
                                        DepotRAmt[30] += SalesLine."Outstanding Amount";
                                        DepotRQty[30] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Releasing Date" = DateValue[31] THEN BEGIN
                                        DepotRAmt[31] += SalesLine."Outstanding Amount";
                                        DepotRQty[31] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;


                    IF ("Sales Header"."Payment Date 3" >= MnthStartDate) AND ("Sales Header"."Payment Date 3" <= MnthEndDate) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER'] THEN BEGIN
                                    IF "Sales Header"."Payment Date 3" = DateValue[1] THEN BEGIN
                                        TRDRAmt[1] += SalesLine."Outstanding Amount";
                                        TRDRQty[1] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[2] THEN BEGIN
                                        TRDRAmt[2] += SalesLine."Outstanding Amount";
                                        TRDRQty[2] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[3] THEN BEGIN
                                        TRDRAmt[3] += SalesLine."Outstanding Amount";
                                        TRDRQty[3] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[4] THEN BEGIN
                                        TRDRAmt[4] += SalesLine."Outstanding Amount";
                                        TRDRQty[4] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[5] THEN BEGIN
                                        TRDRAmt[5] += SalesLine."Outstanding Amount";
                                        TRDRQty[5] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[6] THEN BEGIN
                                        TRDRAmt[6] += SalesLine."Outstanding Amount";
                                        TRDRQty[6] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[7] THEN BEGIN
                                        TRDRAmt[7] += SalesLine."Outstanding Amount";
                                        TRDRQty[7] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[8] THEN BEGIN
                                        TRDRAmt[8] += SalesLine."Outstanding Amount";
                                        TRDRQty[8] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[9] THEN BEGIN
                                        TRDRAmt[9] += SalesLine."Outstanding Amount";
                                        TRDRQty[9] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[10] THEN BEGIN
                                        TRDRAmt[10] += SalesLine."Outstanding Amount";
                                        TRDRQty[10] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[11] THEN BEGIN
                                        TRDRAmt[11] += SalesLine."Outstanding Amount";
                                        TRDRQty[11] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[12] THEN BEGIN
                                        TRDRAmt[12] += SalesLine."Outstanding Amount";
                                        TRDRQty[12] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[13] THEN BEGIN
                                        TRDRAmt[13] += SalesLine."Outstanding Amount";
                                        TRDRQty[13] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[14] THEN BEGIN
                                        TRDRAmt[14] += SalesLine."Outstanding Amount";
                                        TRDRQty[14] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[15] THEN BEGIN
                                        TRDRAmt[15] += SalesLine."Outstanding Amount";
                                        TRDRQty[15] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[16] THEN BEGIN
                                        TRDRAmt[16] += SalesLine."Outstanding Amount";
                                        TRDRQty[16] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[17] THEN BEGIN
                                        TRDRAmt[17] += SalesLine."Outstanding Amount";
                                        TRDRQty[17] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[18] THEN BEGIN
                                        TRDRAmt[18] += SalesLine."Outstanding Amount";
                                        TRDRQty[18] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[19] THEN BEGIN
                                        TRDRAmt[19] += SalesLine."Outstanding Amount";
                                        TRDRQty[19] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[20] THEN BEGIN
                                        TRDRAmt[20] += SalesLine."Outstanding Amount";
                                        TRDRQty[20] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[21] THEN BEGIN
                                        TRDRAmt[21] += SalesLine."Outstanding Amount";
                                        TRDRQty[21] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[22] THEN BEGIN
                                        TRDRAmt[22] += SalesLine."Outstanding Amount";
                                        TRDRQty[22] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[23] THEN BEGIN
                                        TRDRAmt[23] += SalesLine."Outstanding Amount";
                                        TRDRQty[23] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[24] THEN BEGIN
                                        TRDRAmt[24] += SalesLine."Outstanding Amount";
                                        TRDRQty[24] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[25] THEN BEGIN
                                        TRDRAmt[25] += SalesLine."Outstanding Amount";
                                        TRDRQty[25] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[26] THEN BEGIN
                                        TRDRAmt[26] += SalesLine."Outstanding Amount";
                                        TRDRQty[26] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[27] THEN BEGIN
                                        TRDRAmt[27] += SalesLine."Outstanding Amount";
                                        TRDRQty[27] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[28] THEN BEGIN
                                        TRDRAmt[28] += SalesLine."Outstanding Amount";
                                        TRDRQty[28] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[29] THEN BEGIN
                                        TRDRAmt[29] += SalesLine."Outstanding Amount";
                                        TRDRQty[29] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[30] THEN BEGIN
                                        TRDRAmt[30] += SalesLine."Outstanding Amount";
                                        TRDRQty[30] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF "Sales Header"."Payment Date 3" = DateValue[31] THEN BEGIN
                                        TRDRAmt[31] += SalesLine."Outstanding Amount";
                                        TRDRQty[31] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;

                    IF ("Sales Header".Status <> "Sales Header".Status::Released) AND (DT2DATE("Sales Header"."Make Order Date") <= MnthEndDate) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF SalesLine."Location Code" IN ['SKD-WH-MFG', 'HSK-WH-MFG', 'DRA-WH-MFG'] THEN BEGIN
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[1] THEN BEGIN
                                        SPToRAmt[1] += SalesLine."Outstanding Amount";
                                        SPToRQty[1] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[2] THEN BEGIN
                                        SPToRAmt[2] += SalesLine."Outstanding Amount";
                                        SPToRQty[2] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[3] THEN BEGIN
                                        SPToRAmt[3] += SalesLine."Outstanding Amount";
                                        SPToRQty[3] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[4] THEN BEGIN
                                        SPToRAmt[4] += SalesLine."Outstanding Amount";
                                        SPToRQty[4] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[5] THEN BEGIN
                                        SPToRAmt[5] += SalesLine."Outstanding Amount";
                                        SPToRQty[5] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[6] THEN BEGIN
                                        SPToRAmt[6] += SalesLine."Outstanding Amount";
                                        SPToRQty[6] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[7] THEN BEGIN
                                        SPToRAmt[7] += SalesLine."Outstanding Amount";
                                        SPToRQty[7] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[8] THEN BEGIN
                                        SPToRAmt[8] += SalesLine."Outstanding Amount";
                                        SPToRQty[8] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[9] THEN BEGIN
                                        SPToRAmt[9] += SalesLine."Outstanding Amount";
                                        SPToRQty[9] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[10] THEN BEGIN
                                        SPToRAmt[10] += SalesLine."Outstanding Amount";
                                        SPToRQty[10] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[11] THEN BEGIN
                                        SPToRAmt[11] += SalesLine."Outstanding Amount";
                                        SPToRQty[11] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[12] THEN BEGIN
                                        SPToRAmt[12] += SalesLine."Outstanding Amount";
                                        SPToRQty[12] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[13] THEN BEGIN
                                        SPToRAmt[13] += SalesLine."Outstanding Amount";
                                        SPToRQty[13] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[14] THEN BEGIN
                                        SPToRAmt[14] += SalesLine."Outstanding Amount";
                                        SPToRQty[14] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[15] THEN BEGIN
                                        SPToRAmt[15] += SalesLine."Outstanding Amount";
                                        SPToRQty[15] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[16] THEN BEGIN
                                        SPToRAmt[16] += SalesLine."Outstanding Amount";
                                        SPToRQty[16] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[17] THEN BEGIN
                                        SPToRAmt[17] += SalesLine."Outstanding Amount";
                                        SPToRQty[17] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[18] THEN BEGIN
                                        SPToRAmt[18] += SalesLine."Outstanding Amount";
                                        SPToRQty[18] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[19] THEN BEGIN
                                        SPToRAmt[19] += SalesLine."Outstanding Amount";
                                        SPToRQty[19] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[20] THEN BEGIN
                                        SPToRAmt[20] += SalesLine."Outstanding Amount";
                                        SPToRQty[20] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[21] THEN BEGIN
                                        SPToRAmt[21] += SalesLine."Outstanding Amount";
                                        SPToRQty[21] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[22] THEN BEGIN
                                        SPToRAmt[22] += SalesLine."Outstanding Amount";
                                        SPToRQty[22] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[23] THEN BEGIN
                                        SPToRAmt[23] += SalesLine."Outstanding Amount";
                                        SPToRQty[23] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[24] THEN BEGIN
                                        SPToRAmt[24] += SalesLine."Outstanding Amount";
                                        SPToRQty[24] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[25] THEN BEGIN
                                        SPToRAmt[25] += SalesLine."Outstanding Amount";
                                        SPToRQty[25] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[26] THEN BEGIN
                                        SPToRAmt[26] += SalesLine."Outstanding Amount";
                                        SPToRQty[26] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[27] THEN BEGIN
                                        SPToRAmt[27] += SalesLine."Outstanding Amount";
                                        SPToRQty[27] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[28] THEN BEGIN
                                        SPToRAmt[28] += SalesLine."Outstanding Amount";
                                        SPToRQty[28] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[29] THEN BEGIN
                                        SPToRAmt[29] += SalesLine."Outstanding Amount";
                                        SPToRQty[29] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[30] THEN BEGIN
                                        SPToRAmt[30] += SalesLine."Outstanding Amount";
                                        SPToRQty[30] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[31] THEN BEGIN
                                        SPToRAmt[31] += SalesLine."Outstanding Amount";
                                        SPToRQty[31] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;

                                IF (SalesLine."Location Code" <> 'DP-MORBI') AND (SalesLine."Location Code" <> 'DP-BIKANER')
                                AND (COPYSTR(SalesLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[1] THEN BEGIN
                                        DPToRAmt[1] += SalesLine."Outstanding Amount";
                                        DPToRQty[1] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[2] THEN BEGIN
                                        DPToRAmt[2] += SalesLine."Outstanding Amount";
                                        DPToRQty[2] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[3] THEN BEGIN
                                        DPToRAmt[3] += SalesLine."Outstanding Amount";
                                        DPToRQty[3] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[4] THEN BEGIN
                                        DPToRAmt[4] += SalesLine."Outstanding Amount";
                                        DPToRQty[4] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[5] THEN BEGIN
                                        DPToRAmt[5] += SalesLine."Outstanding Amount";
                                        DPToRQty[5] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[6] THEN BEGIN
                                        DPToRAmt[6] += SalesLine."Outstanding Amount";
                                        DPToRQty[6] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[7] THEN BEGIN
                                        DPToRAmt[7] += SalesLine."Outstanding Amount";
                                        DPToRQty[7] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[8] THEN BEGIN
                                        DPToRAmt[8] += SalesLine."Outstanding Amount";
                                        DPToRQty[8] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[9] THEN BEGIN
                                        DPToRAmt[9] += SalesLine."Outstanding Amount";
                                        DPToRQty[9] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[10] THEN BEGIN
                                        DPToRAmt[10] += SalesLine."Outstanding Amount";
                                        DPToRQty[10] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[11] THEN BEGIN
                                        DPToRAmt[11] += SalesLine."Outstanding Amount";
                                        DPToRQty[11] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[12] THEN BEGIN
                                        DPToRAmt[12] += SalesLine."Outstanding Amount";
                                        DPToRQty[12] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[13] THEN BEGIN
                                        DPToRAmt[13] += SalesLine."Outstanding Amount";
                                        DPToRQty[13] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[14] THEN BEGIN
                                        DPToRAmt[14] += SalesLine."Outstanding Amount";
                                        DPToRQty[14] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[15] THEN BEGIN
                                        DPToRAmt[15] += SalesLine."Outstanding Amount";
                                        DPToRQty[15] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[16] THEN BEGIN
                                        DPToRAmt[16] += SalesLine."Outstanding Amount";
                                        DPToRQty[16] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[17] THEN BEGIN
                                        DPToRAmt[17] += SalesLine."Outstanding Amount";
                                        DPToRQty[17] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[18] THEN BEGIN
                                        DPToRAmt[18] += SalesLine."Outstanding Amount";
                                        DPToRQty[18] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[19] THEN BEGIN
                                        DPToRAmt[19] += SalesLine."Outstanding Amount";
                                        DPToRQty[19] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[20] THEN BEGIN
                                        DPToRAmt[20] += SalesLine."Outstanding Amount";
                                        DPToRQty[20] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[21] THEN BEGIN
                                        DPToRAmt[21] += SalesLine."Outstanding Amount";
                                        DPToRQty[21] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[22] THEN BEGIN
                                        DPToRAmt[22] += SalesLine."Outstanding Amount";
                                        DPToRQty[22] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[23] THEN BEGIN
                                        DPToRAmt[23] += SalesLine."Outstanding Amount";
                                        DPToRQty[23] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[24] THEN BEGIN
                                        DPToRAmt[24] += SalesLine."Outstanding Amount";
                                        DPToRQty[24] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[25] THEN BEGIN
                                        DPToRAmt[25] += SalesLine."Outstanding Amount";
                                        DPToRQty[25] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[26] THEN BEGIN
                                        DPToRAmt[26] += SalesLine."Outstanding Amount";
                                        DPToRQty[26] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[27] THEN BEGIN
                                        DPToRAmt[27] += SalesLine."Outstanding Amount";
                                        DPToRQty[27] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[28] THEN BEGIN
                                        DPToRAmt[28] += SalesLine."Outstanding Amount";
                                        DPToRQty[28] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[29] THEN BEGIN
                                        DPToRAmt[29] += SalesLine."Outstanding Amount";
                                        DPToRQty[29] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[30] THEN BEGIN
                                        DPToRAmt[30] += SalesLine."Outstanding Amount";
                                        DPToRQty[30] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[31] THEN BEGIN
                                        DPToRAmt[31] += SalesLine."Outstanding Amount";
                                        DPToRQty[31] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;

                    IF ("Sales Header"."Payment Date 3" = 0D) AND (DT2DATE("Sales Header"."Make Order Date") <= MnthEndDate) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesLine.SETRANGE("Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesLine.FINDFIRST THEN
                            REPEAT
                                IF SalesLine."Location Code" IN ['DP-MORBI', 'DP-BIKANER'] THEN BEGIN
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[1] THEN BEGIN
                                        TPToRAmt[1] += SalesLine."Outstanding Amount";
                                        TPToRQty[1] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[2] THEN BEGIN
                                        TPToRAmt[2] += SalesLine."Outstanding Amount";
                                        TPToRQty[2] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[3] THEN BEGIN
                                        TPToRAmt[3] += SalesLine."Outstanding Amount";
                                        TPToRQty[3] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[4] THEN BEGIN
                                        TPToRAmt[4] += SalesLine."Outstanding Amount";
                                        TPToRQty[4] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[5] THEN BEGIN
                                        TPToRAmt[5] += SalesLine."Outstanding Amount";
                                        TPToRQty[5] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[6] THEN BEGIN
                                        TPToRAmt[6] += SalesLine."Outstanding Amount";
                                        TPToRQty[6] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[7] THEN BEGIN
                                        TPToRAmt[7] += SalesLine."Outstanding Amount";
                                        TPToRQty[7] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[8] THEN BEGIN
                                        TPToRAmt[8] += SalesLine."Outstanding Amount";
                                        TPToRQty[8] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[9] THEN BEGIN
                                        TPToRAmt[9] += SalesLine."Outstanding Amount";
                                        TPToRQty[9] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[10] THEN BEGIN
                                        TPToRAmt[10] += SalesLine."Outstanding Amount";
                                        TPToRQty[10] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[11] THEN BEGIN
                                        TPToRAmt[11] += SalesLine."Outstanding Amount";
                                        TPToRQty[11] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[12] THEN BEGIN
                                        TPToRAmt[12] += SalesLine."Outstanding Amount";
                                        TPToRQty[12] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[13] THEN BEGIN
                                        TPToRAmt[13] += SalesLine."Outstanding Amount";
                                        TPToRQty[13] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[14] THEN BEGIN
                                        TPToRAmt[14] += SalesLine."Outstanding Amount";
                                        TPToRQty[14] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[15] THEN BEGIN
                                        TPToRAmt[15] += SalesLine."Outstanding Amount";
                                        TPToRQty[15] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[16] THEN BEGIN
                                        TPToRAmt[16] += SalesLine."Outstanding Amount";
                                        TPToRQty[16] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[17] THEN BEGIN
                                        TPToRAmt[17] += SalesLine."Outstanding Amount";
                                        TPToRQty[17] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[18] THEN BEGIN
                                        TPToRAmt[18] += SalesLine."Outstanding Amount";
                                        TPToRQty[18] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[19] THEN BEGIN
                                        TPToRAmt[19] += SalesLine."Outstanding Amount";
                                        TPToRQty[19] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[20] THEN BEGIN
                                        TPToRAmt[20] += SalesLine."Outstanding Amount";
                                        TPToRQty[20] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[21] THEN BEGIN
                                        TPToRAmt[21] += SalesLine."Outstanding Amount";
                                        TPToRQty[21] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[22] THEN BEGIN
                                        TPToRAmt[22] += SalesLine."Outstanding Amount";
                                        TPToRQty[22] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[23] THEN BEGIN
                                        TPToRAmt[23] += SalesLine."Outstanding Amount";
                                        TPToRQty[23] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[24] THEN BEGIN
                                        TPToRAmt[24] += SalesLine."Outstanding Amount";
                                        TPToRQty[24] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[25] THEN BEGIN
                                        TPToRAmt[25] += SalesLine."Outstanding Amount";
                                        TPToRQty[25] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[26] THEN BEGIN
                                        TPToRAmt[26] += SalesLine."Outstanding Amount";
                                        TPToRQty[26] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[27] THEN BEGIN
                                        TPToRAmt[27] += SalesLine."Outstanding Amount";
                                        TPToRQty[27] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[28] THEN BEGIN
                                        TPToRAmt[28] += SalesLine."Outstanding Amount";
                                        TPToRQty[28] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[29] THEN BEGIN
                                        TPToRAmt[29] += SalesLine."Outstanding Amount";
                                        TPToRQty[29] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[30] THEN BEGIN
                                        TPToRAmt[30] += SalesLine."Outstanding Amount";
                                        TPToRQty[30] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                    IF DT2DATE("Sales Header"."Make Order Date") <= DateValue[31] THEN BEGIN
                                        TPToRAmt[31] += SalesLine."Outstanding Amount";
                                        TPToRQty[31] += SalesLine."Outstanding Qty. (Base)";
                                    END;
                                END;
                            UNTIL SalesLine.NEXT = 0;
                    END;
                end;
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                column(SILBookedAmt1; SILBookedAmt[1] / 100000)
                {
                }
                column(SILBookedAmt2; SILBookedAmt[2] / 100000)
                {
                }
                column(SILBookedAmt3; SILBookedAmt[3] / 100000)
                {
                }
                column(SILBookedAmt4; SILBookedAmt[4] / 100000)
                {
                }
                column(SILBookedAmt5; SILBookedAmt[5] / 100000)
                {
                }
                column(SILBookedAmt6; SILBookedAmt[6] / 100000)
                {
                }
                column(SILBookedAmt7; SILBookedAmt[7] / 100000)
                {
                }
                column(SILBookedAmt8; SILBookedAmt[8] / 100000)
                {
                }
                column(SILBookedAmt9; SILBookedAmt[9] / 100000)
                {
                }
                column(SILBookedAmt10; SILBookedAmt[10] / 100000)
                {
                }
                column(SILBookedAmt11; SILBookedAmt[11] / 100000)
                {
                }
                column(SILBookedAmt12; SILBookedAmt[12] / 100000)
                {
                }
                column(SILBookedAmt13; SILBookedAmt[13] / 100000)
                {
                }
                column(SILBookedAmt14; SILBookedAmt[14] / 100000)
                {
                }
                column(SILBookedAmt15; SILBookedAmt[15] / 100000)
                {
                }
                column(SILBookedAmt16; SILBookedAmt[16] / 100000)
                {
                }
                column(SILBookedAmt17; SILBookedAmt[17] / 100000)
                {
                }
                column(SILBookedAmt18; SILBookedAmt[18] / 100000)
                {
                }
                column(SILBookedAmt19; SILBookedAmt[19] / 100000)
                {
                }
                column(SILBookedAmt20; SILBookedAmt[20] / 100000)
                {
                }
                column(SILBookedAmt21; SILBookedAmt[21] / 100000)
                {
                }
                column(SILBookedAmt22; SILBookedAmt[22] / 100000)
                {
                }
                column(SILBookedAmt23; SILBookedAmt[23] / 100000)
                {
                }
                column(SILBookedAmt24; SILBookedAmt[24] / 100000)
                {
                }
                column(SILBookedAmt25; SILBookedAmt[25] / 100000)
                {
                }
                column(SILBookedAmt26; SILBookedAmt[26] / 100000)
                {
                }
                column(SILBookedAmt27; SILBookedAmt[27] / 100000)
                {
                }
                column(SILBookedAmt28; SILBookedAmt[28] / 100000)
                {
                }
                column(SILBookedAmt29; SILBookedAmt[29] / 100000)
                {
                }
                column(SILBookedAmt30; SILBookedAmt[30] / 100000)
                {
                }
                column(SILBookedAmt31; SILBookedAmt[31] / 100000)
                {
                }
                column(SILBookedQty1; SILBookedQty[1])
                {
                }
                column(SILBookedQty2; SILBookedQty[2])
                {
                }
                column(SILBookedQty3; SILBookedQty[3])
                {
                }
                column(SILBookedQty4; SILBookedQty[4])
                {
                }
                column(SILBookedQty5; SILBookedQty[5])
                {
                }
                column(SILBookedQty6; SILBookedQty[6])
                {
                }
                column(SILBookedQty7; SILBookedQty[7])
                {
                }
                column(SILBookedQty8; SILBookedQty[8])
                {
                }
                column(SILBookedQty9; SILBookedQty[9])
                {
                }
                column(SILBookedQty10; SILBookedQty[10])
                {
                }
                column(SILBookedQty11; SILBookedQty[11])
                {
                }
                column(SILBookedQty12; SILBookedQty[12])
                {
                }
                column(SILBookedQty13; SILBookedQty[13])
                {
                }
                column(SILBookedQty14; SILBookedQty[14])
                {
                }
                column(SILBookedQty15; SILBookedQty[15])
                {
                }
                column(SILBookedQty16; SILBookedQty[16])
                {
                }
                column(SILBookedQty17; SILBookedQty[17])
                {
                }
                column(SILBookedQty18; SILBookedQty[18])
                {
                }
                column(SILBookedQty19; SILBookedQty[19])
                {
                }
                column(SILBookedQty20; SILBookedQty[20])
                {
                }
                column(SILBookedQty21; SILBookedQty[21])
                {
                }
                column(SILBookedQty22; SILBookedQty[22])
                {
                }
                column(SILBookedQty23; SILBookedQty[23])
                {
                }
                column(SILBookedQty24; SILBookedQty[24])
                {
                }
                column(SILBookedQty25; SILBookedQty[25])
                {
                }
                column(SILBookedQty26; SILBookedQty[26])
                {
                }
                column(SILBookedQty27; SILBookedQty[27])
                {
                }
                column(SILBookedQty28; SILBookedQty[28])
                {
                }
                column(SILBookedQty29; SILBookedQty[29])
                {
                }
                column(SILBookedQty30; SILBookedQty[30])
                {
                }
                column(SILBookedQty31; SILBookedQty[31])
                {
                }
                column(SILReleaseAmt1; (SILRAmt[1] + SILRTAmt[1]) / 100000)
                {
                }
                column(SILReleaseAmt2; (SILRAmt[2] + SILRTAmt[2]) / 100000)
                {
                }
                column(SILReleaseAmt3; (SILRAmt[3] + SILRTAmt[3]) / 100000)
                {
                }
                column(SILReleaseAmt4; (SILRAmt[4] + SILRTAmt[4]) / 100000)
                {
                }
                column(SILReleaseAmt5; (SILRAmt[5] + SILRTAmt[5]) / 100000)
                {
                }
                column(SILReleaseAmt6; (SILRAmt[6] + SILRTAmt[6]) / 100000)
                {
                }
                column(SILReleaseAmt7; (SILRAmt[7] + SILRTAmt[7]) / 100000)
                {
                }
                column(SILReleaseAmt8; (SILRAmt[8] + SILRTAmt[8]) / 100000)
                {
                }
                column(SILReleaseAmt9; (SILRAmt[9] + SILRTAmt[9]) / 100000)
                {
                }
                column(SILReleaseAmt10; (SILRAmt[10] + SILRTAmt[10]) / 100000)
                {
                }
                column(SILReleaseAmt11; (SILRAmt[11] + SILRTAmt[11]) / 100000)
                {
                }
                column(SILReleaseAmt12; (SILRAmt[12] + SILRTAmt[12]) / 100000)
                {
                }
                column(SILReleaseAmt13; (SILRAmt[13] + SILRTAmt[13]) / 100000)
                {
                }
                column(SILReleaseAmt14; (SILRAmt[14] + SILRTAmt[14]) / 100000)
                {
                }
                column(SILReleaseAmt15; (SILRAmt[15] + SILRTAmt[15]) / 100000)
                {
                }
                column(SILReleaseAmt16; (SILRAmt[16] + SILRTAmt[16]) / 100000)
                {
                }
                column(SILReleaseAmt17; (SILRAmt[17] + SILRTAmt[17]) / 100000)
                {
                }
                column(SILReleaseAmt18; (SILRAmt[18] + SILRTAmt[18]) / 100000)
                {
                }
                column(SILReleaseAmt19; (SILRAmt[19] + SILRTAmt[19]) / 100000)
                {
                }
                column(SILReleaseAmt20; (SILRAmt[20] + SILRTAmt[20]) / 100000)
                {
                }
                column(SILReleaseAmt21; (SILRAmt[21] + SILRTAmt[21]) / 100000)
                {
                }
                column(SILReleaseAmt22; (SILRAmt[22] + SILRTAmt[22]) / 100000)
                {
                }
                column(SILReleaseAmt23; (SILRAmt[23] + SILRTAmt[23]) / 100000)
                {
                }
                column(SILReleaseAmt24; (SILRAmt[24] + SILRTAmt[24]) / 100000)
                {
                }
                column(SILReleaseAmt25; (SILRAmt[25] + SILRTAmt[25]) / 100000)
                {
                }
                column(SILReleaseAmt26; (SILRAmt[26] + SILRTAmt[26]) / 100000)
                {
                }
                column(SILReleaseAmt27; (SILRAmt[27] + SILRTAmt[27]) / 100000)
                {
                }
                column(SILReleaseAmt28; (SILRAmt[28] + SILRTAmt[28]) / 100000)
                {
                }
                column(SILReleaseAmt29; (SILRAmt[29] + SILRTAmt[29]) / 100000)
                {
                }
                column(SILReleaseAmt30; (SILRAmt[30] + SILRTAmt[30]) / 100000)
                {
                }
                column(SILReleaseAmt31; (SILRAmt[31] + SILRTAmt[31]) / 100000)
                {
                }
                column(SILReleaseQty1; SILRQty[1] + SILRTQty[1])
                {
                }
                column(SILReleaseQty2; SILRQty[2] + SILRTQty[2])
                {
                }
                column(SILReleaseQty3; SILRQty[3] + SILRTQty[3])
                {
                }
                column(SILReleaseQty4; SILRQty[4] + SILRTQty[4])
                {
                }
                column(SILReleaseQty5; SILRQty[5] + SILRTQty[5])
                {
                }
                column(SILReleaseQty6; SILRQty[6] + SILRTQty[6])
                {
                }
                column(SILReleaseQty7; SILRQty[7] + SILRTQty[7])
                {
                }
                column(SILReleaseQty8; SILRQty[8] + SILRTQty[8])
                {
                }
                column(SILReleaseQty9; SILRQty[9] + SILRTQty[9])
                {
                }
                column(SILReleaseQty10; SILRQty[10] + SILRTQty[10])
                {
                }
                column(SILReleaseQty11; SILRQty[11] + SILRTQty[11])
                {
                }
                column(SILReleaseQty12; SILRQty[12] + SILRTQty[12])
                {
                }
                column(SILReleaseQty13; SILRQty[13] + SILRTQty[13])
                {
                }
                column(SILReleaseQty14; SILRQty[14] + SILRTQty[14])
                {
                }
                column(SILReleaseQty15; SILRQty[15] + SILRTQty[15])
                {
                }
                column(SILReleaseQty16; SILRQty[16] + SILRTQty[16])
                {
                }
                column(SILReleaseQty17; SILRQty[17] + SILRTQty[17])
                {
                }
                column(SILReleaseQty18; SILRQty[18] + SILRTQty[18])
                {
                }
                column(SILReleaseQty19; SILRQty[19] + SILRTQty[19])
                {
                }
                column(SILReleaseQty20; SILRQty[20] + SILRTQty[20])
                {
                }
                column(SILReleaseQty21; SILRQty[21] + SILRTQty[21])
                {
                }
                column(SILReleaseQty22; SILRQty[22] + SILRTQty[22])
                {
                }
                column(SILReleaseQty23; SILRQty[23] + SILRTQty[23])
                {
                }
                column(SILReleaseQty24; SILRQty[24] + SILRTQty[24])
                {
                }
                column(SILReleaseQty25; SILRQty[25] + SILRTQty[25])
                {
                }
                column(SILReleaseQty26; SILRQty[26] + SILRTQty[26])
                {
                }
                column(SILReleaseQty27; SILRQty[27] + SILRTQty[27])
                {
                }
                column(SILReleaseQty28; SILRQty[28] + SILRTQty[28])
                {
                }
                column(SILReleaseQty29; SILRQty[29] + SILRTQty[29])
                {
                }
                column(SILReleaseQty30; SILRQty[30] + SILRTQty[30])
                {
                }
                column(SILReleaseQty31; SILRQty[31] + SILRTQty[31])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(SILBookedAmt);
                    CLEAR(SILBookedQty);
                    IF ("Sales Invoice Header"."Order Date" >= MnthStartDate) AND ("Sales Invoice Header"."Order Date" <= MnthEndDate) THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", "No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF "Sales Invoice Header"."Order Date" = DateValue[1] THEN BEGIN
                                    SILBookedAmt[1] += SalesInvoiceLine.Amount;
                                    SILBookedQty[1] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[2] THEN BEGIN
                                    SILBookedAmt[2] += SalesInvoiceLine.Amount;
                                    SILBookedQty[2] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[3] THEN BEGIN
                                    SILBookedAmt[3] += SalesInvoiceLine.Amount;
                                    SILBookedQty[3] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[4] THEN BEGIN
                                    SILBookedAmt[4] += SalesInvoiceLine.Amount;
                                    SILBookedQty[4] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[5] THEN BEGIN
                                    SILBookedAmt[5] += SalesInvoiceLine.Amount;
                                    SILBookedQty[5] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[6] THEN BEGIN
                                    SILBookedAmt[6] += SalesInvoiceLine.Amount;
                                    SILBookedQty[6] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[7] THEN BEGIN
                                    SILBookedAmt[7] += SalesInvoiceLine.Amount;
                                    SILBookedQty[7] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[8] THEN BEGIN
                                    SILBookedAmt[8] += SalesInvoiceLine.Amount;
                                    SILBookedQty[8] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[9] THEN BEGIN
                                    SILBookedAmt[9] += SalesInvoiceLine.Amount;
                                    SILBookedQty[9] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[10] THEN BEGIN
                                    SILBookedAmt[10] += SalesInvoiceLine.Amount;
                                    SILBookedQty[10] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[11] THEN BEGIN
                                    SILBookedAmt[11] += SalesInvoiceLine.Amount;
                                    SILBookedQty[11] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[12] THEN BEGIN
                                    SILBookedAmt[12] += SalesInvoiceLine.Amount;
                                    SILBookedQty[12] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[13] THEN BEGIN
                                    SILBookedAmt[13] += SalesInvoiceLine.Amount;
                                    SILBookedQty[13] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[14] THEN BEGIN
                                    SILBookedAmt[14] += SalesInvoiceLine.Amount;
                                    SILBookedQty[14] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[15] THEN BEGIN
                                    SILBookedAmt[15] += SalesInvoiceLine.Amount;
                                    SILBookedQty[15] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[16] THEN BEGIN
                                    SILBookedAmt[16] += SalesInvoiceLine.Amount;
                                    SILBookedQty[16] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[17] THEN BEGIN
                                    SILBookedAmt[17] += SalesInvoiceLine.Amount;
                                    SILBookedQty[17] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[18] THEN BEGIN
                                    SILBookedAmt[18] += SalesInvoiceLine.Amount;
                                    SILBookedQty[18] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[19] THEN BEGIN
                                    SILBookedAmt[19] += SalesInvoiceLine.Amount;
                                    SILBookedQty[19] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[20] THEN BEGIN
                                    SILBookedAmt[20] += SalesInvoiceLine.Amount;
                                    SILBookedQty[20] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[21] THEN BEGIN
                                    SILBookedAmt[21] += SalesInvoiceLine.Amount;
                                    SILBookedQty[21] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[22] THEN BEGIN
                                    SILBookedAmt[22] += SalesInvoiceLine.Amount;
                                    SILBookedQty[22] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[23] THEN BEGIN
                                    SILBookedAmt[23] += SalesInvoiceLine.Amount;
                                    SILBookedQty[23] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[24] THEN BEGIN
                                    SILBookedAmt[24] += SalesInvoiceLine.Amount;
                                    SILBookedQty[24] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[25] THEN BEGIN
                                    SILBookedAmt[25] += SalesInvoiceLine.Amount;
                                    SILBookedQty[25] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[26] THEN BEGIN
                                    SILBookedAmt[26] += SalesInvoiceLine.Amount;
                                    SILBookedQty[26] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[27] THEN BEGIN
                                    SILBookedAmt[27] += SalesInvoiceLine.Amount;
                                    SILBookedQty[27] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[28] THEN BEGIN
                                    SILBookedAmt[28] += SalesInvoiceLine.Amount;
                                    SILBookedQty[28] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[29] THEN BEGIN
                                    SILBookedAmt[29] += SalesInvoiceLine.Amount;
                                    SILBookedQty[29] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[30] THEN BEGIN
                                    SILBookedAmt[30] += SalesInvoiceLine.Amount;
                                    SILBookedQty[30] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                                IF "Sales Invoice Header"."Order Date" = DateValue[31] THEN BEGIN
                                    SILBookedAmt[31] += SalesInvoiceLine.Amount;
                                    SILBookedQty[31] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    END;

                    CLEAR(SILRAmt);
                    CLEAR(SILRQty);
                    CLEAR(SILRDAmt);
                    CLEAR(SILRDQty);
                    CLEAR(SILRTAmt);
                    CLEAR(SILRTQty);
                    IF ("Sales Invoice Header"."Releasing Date" >= MnthStartDate) AND ("Sales Invoice Header"."Releasing Date" <= MnthEndDate) THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", "No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF SalesInvoiceLine."Location Code" IN ['SKD-WH-MFG', 'DRA-WH-MFG', 'HSK-WH-MFG'] THEN BEGIN
                                    /*
                                     IF (SalesInvoiceLine."Location Code"='SKD-WH-MFG') AND (SalesInvoiceLine."Location Code"='HSK-WH-MFG') AND
                                       (SalesInvoiceLine."Location Code"='DRA-WH-MFG') AND (SalesInvoiceLine."Location Code"<>'DP-MORBI') AND
                                       (SalesInvoiceLine."Location Code"<>'DP-BIKANER') AND (COPYSTR(SalesInvoiceLine."Location Code",1,3)='DP-') THEN BEGIN
                                     */
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[1] THEN BEGIN
                                        SILRAmt[1] += SalesInvoiceLine.Amount;
                                        SILRQty[1] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[2] THEN BEGIN
                                        SILRAmt[2] += SalesInvoiceLine.Amount;
                                        SILRQty[2] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[3] THEN BEGIN
                                        SILRAmt[3] += SalesInvoiceLine.Amount;
                                        SILRQty[3] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[4] THEN BEGIN
                                        SILRAmt[4] += SalesInvoiceLine.Amount;
                                        SILRQty[4] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[5] THEN BEGIN
                                        SILRAmt[5] += SalesInvoiceLine.Amount;
                                        SILRQty[5] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[6] THEN BEGIN
                                        SILRAmt[6] += SalesInvoiceLine.Amount;
                                        SILRQty[6] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[7] THEN BEGIN
                                        SILRAmt[7] += SalesInvoiceLine.Amount;
                                        SILRQty[7] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[8] THEN BEGIN
                                        SILRAmt[8] += SalesInvoiceLine.Amount;
                                        SILRQty[8] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[9] THEN BEGIN
                                        SILRAmt[9] += SalesInvoiceLine.Amount;
                                        SILRQty[9] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[10] THEN BEGIN
                                        SILRAmt[10] += SalesInvoiceLine.Amount;
                                        SILRQty[10] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[11] THEN BEGIN
                                        SILRAmt[11] += SalesInvoiceLine.Amount;
                                        SILRQty[11] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[12] THEN BEGIN
                                        SILRAmt[12] += SalesInvoiceLine.Amount;
                                        SILRQty[12] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[13] THEN BEGIN
                                        SILRAmt[13] += SalesInvoiceLine.Amount;
                                        SILRQty[13] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[14] THEN BEGIN
                                        SILRAmt[14] += SalesInvoiceLine.Amount;
                                        SILRQty[14] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[15] THEN BEGIN
                                        SILRAmt[15] += SalesInvoiceLine.Amount;
                                        SILRQty[15] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[16] THEN BEGIN
                                        SILRAmt[16] += SalesInvoiceLine.Amount;
                                        SILRQty[16] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[17] THEN BEGIN
                                        SILRAmt[17] += SalesInvoiceLine.Amount;
                                        SILRQty[17] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[18] THEN BEGIN
                                        SILRAmt[18] += SalesInvoiceLine.Amount;
                                        SILRQty[18] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[19] THEN BEGIN
                                        SILRAmt[19] += SalesInvoiceLine.Amount;
                                        SILRQty[19] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[20] THEN BEGIN
                                        SILRAmt[20] += SalesInvoiceLine.Amount;
                                        SILRQty[20] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[21] THEN BEGIN
                                        SILRAmt[21] += SalesInvoiceLine.Amount;
                                        SILRQty[21] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[22] THEN BEGIN
                                        SILRAmt[22] += SalesInvoiceLine.Amount;
                                        SILRQty[22] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[23] THEN BEGIN
                                        SILRAmt[23] += SalesInvoiceLine.Amount;
                                        SILRQty[23] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[24] THEN BEGIN
                                        SILRAmt[24] += SalesInvoiceLine.Amount;
                                        SILRQty[24] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[25] THEN BEGIN
                                        SILRAmt[25] += SalesInvoiceLine.Amount;
                                        SILRQty[25] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[26] THEN BEGIN
                                        SILRAmt[26] += SalesInvoiceLine.Amount;
                                        SILRQty[26] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[27] THEN BEGIN
                                        SILRAmt[27] += SalesInvoiceLine.Amount;
                                        SILRQty[27] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[28] THEN BEGIN
                                        SILRAmt[28] += SalesInvoiceLine.Amount;
                                        SILRQty[28] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[29] THEN BEGIN
                                        SILRAmt[29] += SalesInvoiceLine.Amount;
                                        SILRQty[29] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[30] THEN BEGIN
                                        SILRAmt[30] += SalesInvoiceLine.Amount;
                                        SILRQty[30] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[31] THEN BEGIN
                                        SILRAmt[31] += SalesInvoiceLine.Amount;
                                        SILRQty[31] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                END;

                                IF (SalesInvoiceLine."Location Code" <> 'DP-MORBI') AND (SalesInvoiceLine."Location Code" <> 'DP-BIKANER') AND (COPYSTR(SalesInvoiceLine."Location Code", 1, 3) = 'DP-') THEN BEGIN
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[1] THEN BEGIN
                                        SILRDAmt[1] += SalesInvoiceLine.Amount;
                                        SILRDQty[1] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[2] THEN BEGIN
                                        SILRDAmt[2] += SalesInvoiceLine.Amount;
                                        SILRDQty[2] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[3] THEN BEGIN
                                        SILRDAmt[3] += SalesInvoiceLine.Amount;
                                        SILRDQty[3] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[4] THEN BEGIN
                                        SILRDAmt[4] += SalesInvoiceLine.Amount;
                                        SILRDQty[4] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[5] THEN BEGIN
                                        SILRDAmt[5] += SalesInvoiceLine.Amount;
                                        SILRDQty[5] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[6] THEN BEGIN
                                        SILRDAmt[6] += SalesInvoiceLine.Amount;
                                        SILRDQty[6] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[7] THEN BEGIN
                                        SILRDAmt[7] += SalesInvoiceLine.Amount;
                                        SILRDQty[7] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[8] THEN BEGIN
                                        SILRDAmt[8] += SalesInvoiceLine.Amount;
                                        SILRDQty[8] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[9] THEN BEGIN
                                        SILRDAmt[9] += SalesInvoiceLine.Amount;
                                        SILRDQty[9] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[10] THEN BEGIN
                                        SILRDAmt[10] += SalesInvoiceLine.Amount;
                                        SILRDQty[10] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[11] THEN BEGIN
                                        SILRDAmt[11] += SalesInvoiceLine.Amount;
                                        SILRDQty[11] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[12] THEN BEGIN
                                        SILRDAmt[12] += SalesInvoiceLine.Amount;
                                        SILRDQty[12] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[13] THEN BEGIN
                                        SILRDAmt[13] += SalesInvoiceLine.Amount;
                                        SILRDQty[13] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[14] THEN BEGIN
                                        SILRDAmt[14] += SalesInvoiceLine.Amount;
                                        SILRDQty[14] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[15] THEN BEGIN
                                        SILRDAmt[15] += SalesInvoiceLine.Amount;
                                        SILRDQty[15] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[16] THEN BEGIN
                                        SILRDAmt[16] += SalesInvoiceLine.Amount;
                                        SILRDQty[16] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[17] THEN BEGIN
                                        SILRDAmt[17] += SalesInvoiceLine.Amount;
                                        SILRDQty[17] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[18] THEN BEGIN
                                        SILRDAmt[18] += SalesInvoiceLine.Amount;
                                        SILRDQty[18] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[19] THEN BEGIN
                                        SILRDAmt[19] += SalesInvoiceLine.Amount;
                                        SILRDQty[19] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[20] THEN BEGIN
                                        SILRDAmt[20] += SalesInvoiceLine.Amount;
                                        SILRDQty[20] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[21] THEN BEGIN
                                        SILRDAmt[21] += SalesInvoiceLine.Amount;
                                        SILRDQty[21] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[22] THEN BEGIN
                                        SILRDAmt[22] += SalesInvoiceLine.Amount;
                                        SILRDQty[22] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[23] THEN BEGIN
                                        SILRDAmt[23] += SalesInvoiceLine.Amount;
                                        SILRDQty[23] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[24] THEN BEGIN
                                        SILRDAmt[24] += SalesInvoiceLine.Amount;
                                        SILRDQty[24] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[25] THEN BEGIN
                                        SILRDAmt[25] += SalesInvoiceLine.Amount;
                                        SILRDQty[25] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[26] THEN BEGIN
                                        SILRDAmt[26] += SalesInvoiceLine.Amount;
                                        SILRDQty[26] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[27] THEN BEGIN
                                        SILRDAmt[27] += SalesInvoiceLine.Amount;
                                        SILRDQty[27] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[28] THEN BEGIN
                                        SILRDAmt[28] += SalesInvoiceLine.Amount;
                                        SILRDQty[28] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[29] THEN BEGIN
                                        SILRDAmt[29] += SalesInvoiceLine.Amount;
                                        SILRDQty[29] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[30] THEN BEGIN
                                        SILRDAmt[30] += SalesInvoiceLine.Amount;
                                        SILRDQty[30] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Releasing Date" = DateValue[31] THEN BEGIN
                                        SILRDAmt[31] += SalesInvoiceLine.Amount;
                                        SILRDQty[31] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    END;

                    IF ("Sales Invoice Header"."Payment Date 3" >= MnthStartDate) AND ("Sales Invoice Header"."Payment Date 3" <= MnthEndDate) THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.", "No.");
                        SalesInvoiceLine.SETRANGE("Document No.", "No.");
                        SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                        IF SalesInvoiceLine.FINDFIRST THEN
                            REPEAT
                                IF (SalesInvoiceLine."Location Code" = 'DP-MORBI') OR (SalesInvoiceLine."Location Code" = 'DP-BIKANER') THEN BEGIN
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[1] THEN BEGIN
                                        SILRTAmt[1] += SalesInvoiceLine.Amount;
                                        SILRTQty[1] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[2] THEN BEGIN
                                        SILRTAmt[2] += SalesInvoiceLine.Amount;
                                        SILRTQty[2] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[3] THEN BEGIN
                                        SILRTAmt[3] += SalesInvoiceLine.Amount;
                                        SILRTQty[3] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[4] THEN BEGIN
                                        SILRTAmt[4] += SalesInvoiceLine.Amount;
                                        SILRTQty[4] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[5] THEN BEGIN
                                        SILRTAmt[5] += SalesInvoiceLine.Amount;
                                        SILRTQty[5] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[6] THEN BEGIN
                                        SILRTAmt[6] += SalesInvoiceLine.Amount;
                                        SILRTQty[6] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[7] THEN BEGIN
                                        SILRTAmt[7] += SalesInvoiceLine.Amount;
                                        SILRTQty[7] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[8] THEN BEGIN
                                        SILRTAmt[8] += SalesInvoiceLine.Amount;
                                        SILRTQty[8] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[9] THEN BEGIN
                                        SILRTAmt[9] += SalesInvoiceLine.Amount;
                                        SILRTQty[9] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[10] THEN BEGIN
                                        SILRTAmt[10] += SalesInvoiceLine.Amount;
                                        SILRTQty[10] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[11] THEN BEGIN
                                        SILRTAmt[11] += SalesInvoiceLine.Amount;
                                        SILRTQty[11] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[12] THEN BEGIN
                                        SILRTAmt[12] += SalesInvoiceLine.Amount;
                                        SILRTQty[12] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[13] THEN BEGIN
                                        SILRTAmt[13] += SalesInvoiceLine.Amount;
                                        SILRTQty[13] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[14] THEN BEGIN
                                        SILRTAmt[14] += SalesInvoiceLine.Amount;
                                        SILRTQty[14] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[15] THEN BEGIN
                                        SILRTAmt[15] += SalesInvoiceLine.Amount;
                                        SILRTQty[15] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[16] THEN BEGIN
                                        SILRTAmt[16] += SalesInvoiceLine.Amount;
                                        SILRTQty[16] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[17] THEN BEGIN
                                        SILRTAmt[17] += SalesInvoiceLine.Amount;
                                        SILRTQty[17] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[18] THEN BEGIN
                                        SILRTAmt[18] += SalesInvoiceLine.Amount;
                                        SILRTQty[18] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[19] THEN BEGIN
                                        SILRTAmt[19] += SalesInvoiceLine.Amount;
                                        SILRTQty[19] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[20] THEN BEGIN
                                        SILRTAmt[20] += SalesInvoiceLine.Amount;
                                        SILRTQty[20] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[21] THEN BEGIN
                                        SILRTAmt[21] += SalesInvoiceLine.Amount;
                                        SILRTQty[21] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[22] THEN BEGIN
                                        SILRTAmt[22] += SalesInvoiceLine.Amount;
                                        SILRTQty[22] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[23] THEN BEGIN
                                        SILRTAmt[23] += SalesInvoiceLine.Amount;
                                        SILRTQty[23] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[24] THEN BEGIN
                                        SILRTAmt[24] += SalesInvoiceLine.Amount;
                                        SILRTQty[24] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[25] THEN BEGIN
                                        SILRTAmt[25] += SalesInvoiceLine.Amount;
                                        SILRTQty[25] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[26] THEN BEGIN
                                        SILRTAmt[26] += SalesInvoiceLine.Amount;
                                        SILRTQty[26] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[27] THEN BEGIN
                                        SILRTAmt[27] += SalesInvoiceLine.Amount;
                                        SILRTQty[27] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[28] THEN BEGIN
                                        SILRTAmt[28] += SalesInvoiceLine.Amount;
                                        SILRTQty[28] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[29] THEN BEGIN
                                        SILRTAmt[29] += SalesInvoiceLine.Amount;
                                        SILRTQty[29] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[30] THEN BEGIN
                                        SILRTAmt[30] += SalesInvoiceLine.Amount;
                                        SILRTQty[30] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                    IF "Sales Invoice Header"."Payment Date 3" = DateValue[31] THEN BEGIN
                                        SILRTAmt[31] += SalesInvoiceLine.Amount;
                                        SILRTQty[31] += SalesInvoiceLine."Quantity in Sq. Mt.";
                                    END;
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                    END;

                end;
            }

            trigger OnAfterGetRecord()
            var
                RecSalesHeader: Record "Sales Header";
            begin
                RecSalesHeader.RESET;
                RecSalesHeader.SETRANGE("Document Type", RecSalesHeader."Document Type"::Order);
                RecSalesHeader.SETRANGE("Sell-to Customer No.", "No.");
                IF NOT RecSalesHeader.FINDFIRST THEN
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        AsonDate := TODAY;
        //AsonDate := 300421D;
        MnthStartDate := CALCDATE('-CM', AsonDate - 1);
        MnthEndDate := AsonDate - 1;

        ReportDays := AsonDate - MnthStartDate;

        IF MnthEndDate - MnthStartDate >= 0 THEN
            DateValue[1] := MnthStartDate;
        IF MnthEndDate - MnthStartDate >= 1 THEN
            DateValue[2] := MnthStartDate + 1;
        IF MnthEndDate - MnthStartDate >= 2 THEN
            DateValue[3] := MnthStartDate + 2;
        IF MnthEndDate - MnthStartDate >= 3 THEN
            DateValue[4] := MnthStartDate + 3;
        IF MnthEndDate - MnthStartDate >= 4 THEN
            DateValue[5] := MnthStartDate + 4;
        IF MnthEndDate - MnthStartDate >= 5 THEN
            DateValue[6] := MnthStartDate + 5;
        IF MnthEndDate - MnthStartDate >= 6 THEN
            DateValue[7] := MnthStartDate + 6;
        IF MnthEndDate - MnthStartDate >= 7 THEN
            DateValue[8] := MnthStartDate + 7;
        IF MnthEndDate - MnthStartDate >= 8 THEN
            DateValue[9] := MnthStartDate + 8;
        IF MnthEndDate - MnthStartDate >= 9 THEN
            DateValue[10] := MnthStartDate + 9;
        IF MnthEndDate - MnthStartDate >= 10 THEN
            DateValue[11] := MnthStartDate + 10;
        IF MnthEndDate - MnthStartDate >= 11 THEN
            DateValue[12] := MnthStartDate + 11;
        IF MnthEndDate - MnthStartDate >= 12 THEN
            DateValue[13] := MnthStartDate + 12;
        IF MnthEndDate - MnthStartDate >= 13 THEN
            DateValue[14] := MnthStartDate + 13;
        IF MnthEndDate - MnthStartDate >= 14 THEN
            DateValue[15] := MnthStartDate + 14;
        IF MnthEndDate - MnthStartDate >= 15 THEN
            DateValue[16] := MnthStartDate + 15;
        IF MnthEndDate - MnthStartDate >= 16 THEN
            DateValue[17] := MnthStartDate + 16;
        IF MnthEndDate - MnthStartDate >= 17 THEN
            DateValue[18] := MnthStartDate + 17;
        IF MnthEndDate - MnthStartDate >= 18 THEN
            DateValue[19] := MnthStartDate + 18;
        IF MnthEndDate - MnthStartDate >= 19 THEN
            DateValue[20] := MnthStartDate + 19;
        IF MnthEndDate - MnthStartDate >= 20 THEN
            DateValue[21] := MnthStartDate + 20;
        IF MnthEndDate - MnthStartDate >= 21 THEN
            DateValue[22] := MnthStartDate + 21;
        IF MnthEndDate - MnthStartDate >= 22 THEN
            DateValue[23] := MnthStartDate + 22;
        IF MnthEndDate - MnthStartDate >= 23 THEN
            DateValue[24] := MnthStartDate + 23;
        IF MnthEndDate - MnthStartDate >= 24 THEN
            DateValue[25] := MnthStartDate + 24;
        IF MnthEndDate - MnthStartDate >= 25 THEN
            DateValue[26] := MnthStartDate + 25;
        IF MnthEndDate - MnthStartDate >= 26 THEN
            DateValue[27] := MnthStartDate + 26;
        IF MnthEndDate - MnthStartDate >= 27 THEN
            DateValue[28] := MnthStartDate + 27;
        IF MnthEndDate - MnthStartDate >= 28 THEN
            DateValue[29] := MnthStartDate + 28;
        IF MnthEndDate - MnthStartDate >= 29 THEN
            DateValue[30] := MnthStartDate + 29;
        IF MnthEndDate - MnthStartDate >= 30 THEN
            DateValue[31] := MnthStartDate + 30;
    end;

    var
        I: Integer;
        AsonDate: Date;
        RecCustomer: Record Customer;
        CustZone: Text[10];
        MnthStartDate: Date;
        MnthEndDate: Date;
        ReportDays: Integer;
        DateValue: array[31] of Date;
        SalesLine: Record "Sales Line";
        RpDocumentNo: Text;
        SKDBookedAmt: array[31] of Decimal;
        SKDBookedQty: array[31] of Decimal;
        SKDRAmt: array[31] of Decimal;
        SKDRQty: array[31] of Decimal;
        TRDRAmt: array[31] of Decimal;
        TRDRQty: array[31] of Decimal;
        DepotRAmt: array[31] of Decimal;
        DepotRQty: array[31] of Decimal;
        SKDRHdrAmt: array[31] of Decimal;
        SKDRHdrQty: array[31] of Decimal;
        TRDRHdrAmt: array[31] of Decimal;
        TRDRHdrQty: array[31] of Decimal;
        DepotRHdrAmt: array[31] of Decimal;
        DepotRHdrQty: array[31] of Decimal;
        SPToRAmt: array[31] of Decimal;
        SPToRQty: array[31] of Decimal;
        TPToRAmt: array[31] of Decimal;
        TPToRQty: array[31] of Decimal;
        DPToRAmt: array[31] of Decimal;
        DPToRQty: array[31] of Decimal;
        PendingOpenOrders: Decimal;
        TRDPendingOpenOrders: Decimal;
        SKDPReleasedOrders: Decimal;
        DepotPReleasedOrders: Decimal;
        TRDPReleasedOrders: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SILBookedAmt: array[31] of Decimal;
        SILBookedQty: array[31] of Decimal;
        SILRAmt: array[31] of Decimal;
        SILRQty: array[31] of Decimal;
        SILRDAmt: array[31] of Decimal;
        SILRDQty: array[31] of Decimal;
        SILRTAmt: array[31] of Decimal;
        SILRTQty: array[31] of Decimal;
}

