page 50011 "SIT Debit Note Card"
{
    PageType = Card;
    SourceTable = "SIT Debit Note";
    Caption = 'SIT Debit Note Card';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Debit Note No."; Rec."Debit Note No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Billing)
            {
                Caption = 'Billing Information';

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
            }

            group(Accounting)
            {
                Caption = 'Accounting';

                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Message('Posting process will be executed.');
                end;
            }

            action(Release)
            {
                Caption = 'Release';
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Message('Debit Note released.');
                end;
            }

            action(Reopen)
            {
                Caption = 'Reopen';
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Message('Debit Note reopened.');
                end;
            }

            action("Request Approval")
            {
                Caption = 'Request Approval';
                ApplicationArea = All;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Message('Approval request initiated.');
                end;
            }

            action(Report)
            {
                Caption = 'Print Report';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var 
                    SITDebitNoteReport: Report "SIT Debit Note";
                begin
                    SITDebitNoteReport.SetTableView(Rec);
                    SITDebitNoteReport.Run();
                end;
            }
        }
    }
}
