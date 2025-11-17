namespace BC.BC;

using Microsoft.Purchases.Setup;

pageextension 50010 SITExtPurchasePayPg extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("DEB-NOTE"; Rec."DEB-NOTE")
            {
                Caption = 'DEB-NOTE';
                ApplicationArea = All;
            }
            field("PDEB-NOTE"; Rec."PDEB-NOTE")
            {
                Caption = 'PDEB-NOTE';
                ApplicationArea = All;
            }
        }
    }
}
