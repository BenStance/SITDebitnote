table 50008 "Posted SIT Debit Note"
{
    Caption = 'Posted SIT Debit Note';
    DataClassification = ToBeClassified;

    fields
    {
        
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Posted Debit Note No."; Code[20])
        {
            Caption = 'Posted Debit Note No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if "Posted Debit Note No." <> xRec."Posted Debit Note No." then begin
                    PurchasesPayablesSetup.Get();
                    NoSeriesMgt.TestManual(PurchasesPayablesSetup."PDEB-NOTE");
                    "Posted Debit Note No." := '';
                end;
            end;
        }

        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification=ToBeClassified;
        }

        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification=ToBeClassified;
        }

        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Posted;
            OptionCaption = 'Posted';
            Editable = false;
        }

        field(6; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }

        field(7; "Posted On"; DateTime)
        {
            Caption = 'Posted On';
            Editable = false;
        }

        
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification=ToBeClassified;
        }

        field(11; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }

        field(12; Address; Text[100])
        {
            Caption = 'Address 1';
        }

        field(13; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
        }

        field(14; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }

        field(15; Email; Text[50])
        {
            Caption = 'Email';
        }

       
        field(20; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }

        field(21; "G/L Account Name"; Text[100])
        {
            Caption = 'G/L Account Name';
        }

        field(22; Amount; Decimal)
        {
            Caption = 'Amount';
        }

        field(23; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(24; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Description = 'Numbering series for Premium Invoices';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key("Posted Debit Note No."; "Posted Debit Note No.") { }
    }

    // Posted tables must NOT allow modification
  
    trigger OnInsert()
    var
        userSetup: Record "User Setup";
        PurchasesPayablesSetup : Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "Posted Debit Note No." = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("PDEB-NOTE");
            "No. Series" := PurchasesPayablesSetup."PDEB-NOTE";
            "Posted Debit Note No." := NoSeriesMgt.GetNextNo("No. Series", Today(), true);
            "Posted By" := UserId();
            "Posted On" := CurrentDateTime();    
        end;     
    end;

    trigger OnModify()
    begin
        Error('Posted Debit Notes cannot be modified.');
    end;

    trigger OnDelete()
    begin
        Error('Posted Debit Notes cannot be deleted.');
    end;
    
    var
        userSetup: Record "User Setup";
        PurchasesPayablesSetup : Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
