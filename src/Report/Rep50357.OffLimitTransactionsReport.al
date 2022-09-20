#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516357_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50357 "Off Limit Transactions Report"
{
    RDLCLayout = 'Layouts/OffLimitTransactionsReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Audit Suspicious Transactions"; "Audit Suspicious Transactions")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(SN; SN)
            {
            }
            column(DocumentNo_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Document No")
            {
            }
            column(MonthTurnOverAmount_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Month TurnOver Amount")
            {
            }
            column(MaxCreditsAllowable_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Max Credits Allowable")
            {
            }
            column(TransactedBy_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Transacted By")
            {
            }
            column(TransactionAmount_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Transaction Amount")
            {
            }
            column(TransactionType_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Transaction Type")
            {
            }
            column(TransactionDate_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Transaction Date")
            {
            }
            column(AccountName_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Account Name")
            {
            }
            column(AccountNo_AuditSuspiciousTransactions; "Audit Suspicious Transactions"."Account No")
            {
            }
            column(Variance; Variance)
            {
            }
            dataitem(Transactions; Transactions)
            {
                DataItemLink = No = field("Document No");
                column(ReportForNavId_2; 2) { } // Autogenerated by ForNav - Do not delete
                column(TransactionDeclaration_Transactions; Transactions."Transaction Declaration")
                {
                }
                column(EvidenceObtained_Transactions; Transactions."Evidence Obtained")
                {
                }
                column(TransactionType_Transactions; Transactions."Transaction Type")
                {
                }
                column(MemberNo_Transactions; Transactions."Member No")
                {
                }
                column(CheckedBy_Transactions; Transactions."Checked By")
                {
                }
                column(MemberName_Transactions; Transactions."Member Name")
                {
                }
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
                Variance := "Audit Suspicious Transactions"."Transaction Amount" - "Audit Suspicious Transactions"."Max Credits Allowable";
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;
        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        Company: Record "Company Information";
        SN: Integer;
        Variance: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516357_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
