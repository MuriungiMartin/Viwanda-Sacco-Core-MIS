#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50405 "Bosa Receipt line-Checkoff"
{
    PageType = ListPart;
    SourceTable = "ReceiptsProcessing_L-Checkoff";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Receipt Header No"; "Receipt Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Line No"; "Receipt Line No")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Type"; "Trans Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; "Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Staff Not Found"; "Staff Not Found")
                {
                    ApplicationArea = Basic;
                }
                field("Member Found"; "Member Found")
                {
                    ApplicationArea = Basic;
                }
                field("Search Index"; "Search Index")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Shares"; "Sacco Shares")
                {

                }
                field("Sacco Total Loan"; "Sacco Total Loan")
                {

                }
                field("Sacco Total Interest"; "Sacco Total Interest")
                {

                }
                field("Sacco Appl Fee"; "Sacco Appl Fee")
                {

                }
                field("Saccco Benevolent"; "Saccco Benevolent")
                {

                }
            }
        }
    }

    actions
    {
    }
}

