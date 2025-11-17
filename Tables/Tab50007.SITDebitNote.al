table 50007 "SIT Debit Note"
{
    Caption = 'SIT Debit Note';
    DataClassification = ToBeClassified;

    fields
    {
       
        field(1; "Debit Note No."; Code[20])
        {
            Caption = 'Debit Note No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if "Debit Note No." <> xRec."Debit Note No." then begin
                    PurchasesPayablesSetup.Get();
                    NoSeriesMgt.TestManual(PurchasesPayablesSetup."DEB-NOTE");
                    "Debit Note No." := '';
                end;
            end;
        }

        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification=ToBeClassified;
        }

        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification=ToBeClassified;
        }

        field(4; Status; Option)
        {
            Caption = 'Status';
            DataClassification=ToBeClassified;
            OptionMembers = Open,Released,Posted,Rejected;
            OptionCaption = 'Open,Released,Posted,Rejected';
        }

        field(5; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification=ToBeClassified;
            Editable = false;
        }

        field(6; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
            DataClassification=ToBeClassified;
            Editable = false;
        }

        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
                var
                    Cust: Record Customer;
                begin
                    if Cust.Get("Customer No.") then begin
                        "Customer Name" := Cust.Name;
                        Address := Cust.Address;
                        "Address 2" := Cust."Address 2";
                        "Phone No." := Cust."Phone No.";
                        "Email" := Cust."E-Mail";
                    end;
            end;
        }

        field(11; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }

        field(12; Address; Text[100])
        {
            Caption = 'Address';
            Editable = false;
        }

        field(13; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
            Editable = false;
        }

        field(14; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }

        field(15; "Email"; Text[50])
        {
            Caption = 'Email';
            Editable = false;
        }

        // ---------------------------------------------
        // Accounting Fields
        // ---------------------------------------------
        field(20; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account"."No.";
        }

        field(21; "G/L Account Name"; Text[100])
        {
            Caption = 'G/L Account Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account".Name where("No." = field("G/L Account No.")));
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
        key(PK; "Debit Note No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        userSetup: Record "User Setup";
        PurchasesPayablesSetup : Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "Debit Note No." = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("DEB-NOTE");
            "No. Series" := PurchasesPayablesSetup."DEB-NOTE";
            "Debit Note No." := NoSeriesMgt.GetNextNo("No. Series", Today(), true);
            "Modified On" := CurrentDateTime();
            "Modified By" := UserId();
            Status := Status::Open;
        end;     
    end;

    trigger OnModify()
    begin
        "Modified On" := CurrentDateTime();
        "Modified By" := UserId();
    end;

    var
        userSetup: Record "User Setup";
        PurchasesPayablesSetup : Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
