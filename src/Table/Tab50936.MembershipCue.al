#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50936 "Membership Cue"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Active)));
            FieldClass = FlowField;
        }
        field(3; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Dormant)));
            FieldClass = FlowField;
        }
        field(4; "Deceased Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Deceased)));
            FieldClass = FlowField;
        }
        field(5; "Withdrawn Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Exited)));
            FieldClass = FlowField;
        }
        field(6; "Male Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Male)));
            FieldClass = FlowField;
        }
        field(7; "Female Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Female)));
            FieldClass = FlowField;
        }
        field(8; "Resigned Members"; Integer)
        {
            // CalcFormula = count(Customer where (Status=const("9")));
            // FieldClass = FlowField;
        }
        field(9; BOSA; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BOSA'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(14; "Members with ID No"; Integer)
        {
            CalcFormula = count(Customer where("ID No." = filter(> '0')));
            FieldClass = FlowField;
        }
        field(15; "Members With Tell No"; Integer)
        {
            CalcFormula = count(Customer where("Phone No." = filter(> '0')));
            FieldClass = FlowField;
        }
        field(16; "Members With Mobile No"; Integer)
        {
            CalcFormula = count(Customer where("Mobile Phone No" = filter(> '0')));
            FieldClass = FlowField;
        }
        field(17; CROP; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('CROP'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(26; "Non-Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Awaiting Exit")));
            FieldClass = FlowField;
        }
        field(27; "NoQsAsked Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('NOQS'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(28; StaffAsset; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('312'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(29; StaffCar; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SCAR'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(30; "BDevt Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BDEVT'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(31; "Normal Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('NORMAL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(32; "Asset Financing Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ASSET'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(33; "Junior Members"; Integer)
        {
        }
        field(34; "Development Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(35; "Emergency Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('EL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(36; "Business Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('IL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(37; "Jijenge Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('MSL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(38; "School Fees Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(39; "Personal Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SPL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(40; "Asset Finance"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('TL'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }
        field(41; "Ufalme Project Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('TL1'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(42; "Corporate Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SSL'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }
        field(43; "Community Development Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('VS-MEMBER'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }
        field(44; "Housing Development Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('321'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(<> 0),
                                                        "Loan Status" = const(Disbursed)));
            FieldClass = FlowField;
        }
        field(45; "Mobile Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('322'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }
        field(46; "Group Accounts"; Integer)
        {
            CalcFormula = count(Customer where("Account Category" = filter(Group)));
            FieldClass = FlowField;
        }
        field(47; "Joint Accounts"; Integer)
        {
            CalcFormula = count("Member Ledger Entry" where("Customer No." = const('NO'),
                                                             "Transaction Type" = const("Junior Savings")));
            FieldClass = FlowField;
        }
        field(48; "Uncleared Cheques"; Integer)
        {
            CalcFormula = count(Transactions where("Transaction Type" = filter('CHEQUEDEPOSIT'),
                                                    Posted = const(true),
                                                    "Cheque Processed" = const(false)));
            FieldClass = FlowField;
        }
        field(49; "Cleared Cheques"; Integer)
        {
            CalcFormula = count("Cheque Clearing Lines" where("Cheque Clearing Status" = const(Cleared)));
            FieldClass = FlowField;
        }
        field(50; "Bounced Cheques"; Integer)
        {
            CalcFormula = count("Cheque Clearing Lines" where("Cheque Clearing Status" = const(Bounced)));
            FieldClass = FlowField;
        }
        field(51; "New Members"; Integer)
        {
            CalcFormula = count("Membership Applications" where(Status = const(Open)));
            FieldClass = FlowField;
        }
        field(52; "Approved Applications"; Integer)
        {
            CalcFormula = count("Membership Applications" where(Status = const(Approved),
                                                                 Created = const(true)));
            FieldClass = FlowField;
        }
        field(53; "Loans Pending Approval"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending)));
            FieldClass = FlowField;
        }
        field(54; "Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved),
                                                        Posted = const(false)));
            FieldClass = FlowField;
        }
        field(55; "Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Rejected),
                                                        "Loan Status" = const(Rejected)));
            FieldClass = FlowField;
        }
        field(56; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(57; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(58; "Leave Pending"; Integer)
        {
            CalcFormula = count("HR Leave Application" where(Status = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(59; "Leave Approved"; Integer)
        {
            CalcFormula = count("HR Leave Application" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(60; "Staff Claims Pending"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(61; "Staff Claims Approved"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(62; "Pending Cheque Payments"; Integer)
        {
            CalcFormula = count("Payments Header" where(Status = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(63; "Approved Cheque Payments"; Integer)
        {
            CalcFormula = count("Payments Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(64; Logo; Blob)
        {

        }
        field(65; "Loans due In a Month"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loans Register" where("Due Loans" = filter(true)));


        }
        field(66; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;


        }

    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    end;

    var
        company: record "Company Information";
}

