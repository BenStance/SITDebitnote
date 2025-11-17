report 50015 "SIT Debit Note"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'SIT Debit Note';
    DefaultLayout = RDLC;
    RDLCLayout = './Final_STI_Project/DebitNote/Layout/SITDebitNote.rdl';

    dataset
    {
        dataitem(DebitNote; "SIT Debit Note")
        {
            DataItemTableView = sorting("Debit Note No.");
            RequestFilterFields = "Debit Note No.";

            column(DebitNoteNo; "Debit Note No.")
            {

            }
            column(DocumentDate; "Document Date")
            {

            }
            column(PostingDate; "Posting Date")
            {

            }
            column(Status; Status)
            {

            }
            column(ModifiedBy; "Modified By")
            {

            }
            column(ModifiedOn; "Modified On")
            {

            }

            // Customer Fields
            column(CustomerNo; "Customer No.")
            {

            }
            column(CustomerName; "Customer Name")
            {

            }
            column(Address; Address)
            {

            }
            column(Address2; "Address 2")
            {

            }
            column(PhoneNo; "Phone No.")
            {

            }
            column(Email; Email)
            {

            }

            // Accounting Fields
            column(GLAccountNo; "G/L Account No.")
            {

            }
            column(GLAccountName; "G/L Account Name")
            {

            }
            column(Amount; Amount)
            {

            }
            column(Description; Description)
            {

            }

            // Company Information
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(CompanyAddress; CompanyInfo.Address)
            {

            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {

            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {

            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {

            }
            column(CompanyPicture; CompanyInfo.Picture)
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
           column(CompanyInfo;CompanyInfo.TIN)
            {
            }
            column(CompanyVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }



            trigger OnAfterGetRecord()
            var
                AmountToText: Codeunit "Amount in Words";
                NoText: array[2] of Text[80];
            begin
                // Convert numeric field to words
                AmountToText.FormatNoText(NoText, Amount, 'TZS');

                // Combine the two text lines into one result (if you have a Text field to store/display it)
                AmountInWords := NoText[1];
                if NoText[2] <> '' then
                    AmountInWords := AmountInWords + ' ' + NoText[2];
            end;
        }
    }

    requestpage
    {
        Caption = 'SIT Debit Note';

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    
                }
            }
        }



        var
            DebitNoteFilter: Code[20];

    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        AmountInWords: Text;
}
