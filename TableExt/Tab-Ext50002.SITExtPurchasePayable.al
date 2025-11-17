namespace BCEXPERTROAD.BCEXPERTROAD;

using Microsoft.Purchases.Setup;
using Microsoft.Foundation.NoSeries;

tableextension 50009 SITExtPurchPaySetable extends "Purchases & Payables Setup"
{
    fields
    {
        field(50001; "DEB-NOTE";Code[20])
        {
            Caption = 'DEB-NOTE';
            TableRelation="No. Series";           
        }
        field(50002; "PDEB-NOTE";Code[20])
        {
            Caption = 'PDEB-NOTE';
            TableRelation="No. Series";
        }
    }
}