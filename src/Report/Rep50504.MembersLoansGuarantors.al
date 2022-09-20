
Report 50504 "Members Loans Guarantors"
{
    RDLCLayout = 'Layouts/MembersLoansGuarantors.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Name;
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
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
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(UserId; UserId)
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(PhoneNo_Members; Customer."Phone No.")
            {
            }
            column(OutstandingBalance_Members; Customer."Outstanding Balance")
            {
            }
            column(CurrentShares_MembersRegister; Customer."Current Shares")
            {
            }
            column(FNo; FNo)
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loanees  No" = field("No."), "Loan No" = field("Loan No. Filter");
                DataItemTableView = where("Outstanding Balance" = filter(<> 0), Substituted = filter(false));
                RequestFilterFields = "Member No", "Loan No";
                column(AmontGuaranteed_LoanGuarantors; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                {
                }
                column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                {
                }
                column(LoanNo_LoanGuarantors; "Loans Guarantee Details"."Loan No")
                {
                }
                column(EntryNo; EntryNo)
                {
                }
                column(OutStandingBal; "Loans Guarantee Details"."Outstanding Balance")
                {
                }
                column(TotalOutstandingBal; TotalOutstandingBal)
                {
                }
                column(EmployerCode; EmployerCode)
                {
                }
                column(VarGuarantorDeposits; VarGuarantorDeposits)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    Loansr.Reset;
                    Loansr.SetRange(Loansr."Loan  No.", "Loan No");
                    if Loansr.Find('-') then //BEGIN
                        MemberNo := Loansr."Client Code";
                    MemberName := Loansr."Client Name";
                    EmployerCode := Loansr."Employer Code";
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "Loans Guarantee Details"."Member No");
                    if ObjCust.FindSet then begin
                        ObjCust.CalcFields(ObjCust."Current Shares");
                        VarGuarantorDeposits := ObjCust."Current Shares";
                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                //Members.CALCFIELDS(Members."Outstanding Balance",Members."Current Shares",Members."Loans Guaranteed");
                //AvailableSH:=Members."Current Shares"-Members."Loans Guaranteed";
                FNo := FNo + 1;
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
            ////:= false;

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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        Loansr: Record "Loans Register";
        EntryNo: Integer;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        Company: Record "Company Information";
        ObjCust: Record Customer;
        VarGuarantorDeposits: Decimal;

    var
}
