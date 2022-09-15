
Report 50506 "Transactions HighRisk Accounts"
{
    RDLCLayout = 'Layouts/TransactionsHighRiskAccounts.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Member Risk Level" = const("High Risk"));

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
            column(MemberRiskLevel_MembersRegister; Customer."Member Risk Level")
            {
            }
            column(Name_MembersRegister; Customer.Name)
            {
            }
            column(No_MembersRegister; Customer."No.")
            {
            }
            column(CreatedBy_MembersRegister; Customer."Created By")
            {
            }
            dataitem(Transactions; Transactions)
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where(Posted = const(true));

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
                column(TransactionDate_Transactions; Transactions."Transaction Date")
                {
                }
                column(Amount_Transactions; Transactions.Amount)
                {
                }
                column(PostedBy_Transactions; Transactions."Posted By")
                {
                }
                column(SN2; SN)
                {
                }
                trigger OnPreDataItem();
                begin
                    Company.Get();
                    Company.CalcFields(Picture);
                end;

                trigger OnAfterGetRecord();
                begin
                    SN := SN + 1;
                end;

            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
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


    var
}